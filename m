Return-Path: <linux-kernel+bounces-238441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C41B924B0D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEA4F28763C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D08B1897FE;
	Tue,  2 Jul 2024 21:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F77Rfs9k"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6941218325C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957521; cv=none; b=VGKM230BR5cxQr+jUb2A03Zdx3Pg0aAQXcvYDN4PgmfSKODSaCAA9fHYlKattI04I/DZj/nS30J/W6Sll6SuJbGgg+j/R5xnMhKgpl1FyE3ovhVgpqxW52fNhSg/vtqNMLUFzwTbQCsOWOzMU8EXny/M0YvoekrsetGasF5U4jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957521; c=relaxed/simple;
	bh=kNrEoJCOfsjI6sAferW1c8ANnU9jCPipaa5wQV97i2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cp5hDBMjiguaZJ0Cc67kGvbKjcg7oXG04ay2d1nWM9zehVVxab1an6tzjJMkdLfhhPVlyfo1EF4UztxHAwwrQyV976LiB+Q5Z5ShC3A4NP0Vx0/kYHh/yppHWuZ31dak/eZY9CtOkkqyYJeGmDHPvyOe+YNwXqBHzR6Sf4kzYtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F77Rfs9k; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7f65a32a58fso21859039f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957519; x=1720562319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86vugQ8piC6pzh4RgCq/qOTI8lQn1pJMR2FsXqHUdq8=;
        b=F77Rfs9k1APuwTbkzMKl5tXZ79B7Gn8axNvf51vFXlOSYtnhOa7iW/XYS0XtTb1PrV
         w+xmMqDYIb7TsyEF33/7564Nt9dEBGZOhiKYJhgPSp1jFFdbqVaaPwhYXVkT+J5y6iaE
         F/yGEdm4SAlTSdWe4hfPrJUFKmJS2GK/iz5YO7AiffERLZsmp8cHKOf3k4if1N5/Kir5
         mWl6e41liyHYyyKgocNknErK8FZmtaDANakgZjT+WMhDLQy48PQ6jo6e1YYh4/YTpXYG
         yAANef6IkucxXn6JHIKyxhzOXS+9muTup+RDlLWK5MLKlvyb/aDja7qYK2i0OgVqfJMX
         lr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957519; x=1720562319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=86vugQ8piC6pzh4RgCq/qOTI8lQn1pJMR2FsXqHUdq8=;
        b=cCssZ/0IRYUDngGUkOv5QtAKayqDzegPiCAxoOLc1bM0MzwYDp5JJyWJbqB29D8S/j
         2rM/KD01clTkGIK6kdVgCQoJkJqWTWXOxY0ZEMvmx0m3SBOfLuGRlILmjgXYPHmKUSN4
         8vf+1JFywpsKYmG88KC0Dx10TKdD9Qna9bjJR9N6zefilHsJee91bZ52xN5VmJRup1Ps
         PcgHOeh1h6SSIY6KiwfxshhT6Lr/TV4+ZZWEwetAFDmxct1az66mqa2uwSSttFfbhmpq
         kTFW5fhh5+SzosbrYQolBC7kDYBakXF9T3aNdIQnqeiJb7GghksV+H5bdPElOf2a6hWw
         7HLA==
X-Gm-Message-State: AOJu0Yx62lweI3wZss+Cp1f2v56DZrwjMhQQBAYg78eRYmKbUg4ayeU3
	XTTGexy1GVlFpvl1Oa84PmNySrdwp3299dPBtMnMcxU3+B3SSKDw
X-Google-Smtp-Source: AGHT+IFh4NknMSqrRunexz7bPyO+GFuFsoZTUZjnQuX30OfvbKxEu2+OkmD/dNXRlYHLCXi/CEVDEA==
X-Received: by 2002:a05:6602:15c2:b0:7f6:19b9:3a3b with SMTP id ca18e2360f4ac-7f62edfe2e9mr1313056939f.1.1719957519578;
        Tue, 02 Jul 2024 14:58:39 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:58:39 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	ukaszb@chromium.org
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v9 20/52] selftests-dyndbg: add comma_terminator_tests
Date: Tue,  2 Jul 2024 15:57:10 -0600
Message-ID: <20240702215804.2201271-21-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702215804.2201271-1-jim.cromie@gmail.com>
References: <20240702215804.2201271-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New fn validates parsing and effect of queries using combinations of
commas and spaces to delimit the tokens.

It manipulates pr-debugs in builtin module/params, so might have deps
I havent foreseen on odd configurations.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../selftests/dynamic_debug/dyndbg_selftest.sh     | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index 1be70af26a38..b4ba293ab227 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -212,9 +212,23 @@ EOF
     ddcmd =_
 }
 
+function comma_terminator_tests {
+    echo -e "${GREEN}# COMMA_TERMINATOR_TESTS ${NC}"
+    # try combos of spaces & commas
+    check_match_ct '\[params\]' 4 -r
+    ddcmd module,params,=_		# commas as spaces
+    ddcmd module,params,+mpf		# turn on module's pr-debugs
+    check_match_ct =pmf 4
+    ddcmd ,module ,, ,  params, -p
+    check_match_ct =mf 4
+    ddcmd " , module ,,, ,  params, -m"	#
+    check_match_ct =f 4
+    ddcmd =_
+}
 
 tests_list=(
     basic_tests
+    comma_terminator_tests
 )
 
 # Run tests
-- 
2.45.2



Return-Path: <linux-kernel+bounces-254274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D41FC933159
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CED31F2446B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BF21A651E;
	Tue, 16 Jul 2024 18:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iunp8IaY"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78291A4F1F;
	Tue, 16 Jul 2024 18:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156333; cv=none; b=KLFTCuhpSqC3fGQk9AUlbqkNDEC7Qq2Fgo09PfevkMs+mkJ/EoYBjRGcGDl3lsEVS+fxIKjUxt4hsx+Ci7tRUmfuBPRdGqaBExrh4frejIk5Yocseo84GedCOGagZKwWOD6kLD2/2l6bpEFfzecgtuc2MOm/vY97R7WMD09DN5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156333; c=relaxed/simple;
	bh=kNrEoJCOfsjI6sAferW1c8ANnU9jCPipaa5wQV97i2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fqQ7sA09eO4391fM5krT/6QdGX7W+c+3Czw2Eda7pKs9Dmut99La8ad0E1tw5dp6rRlLZodwuBmMhExf6AsFjifgaYIHWWLu0X+nrduY4gcuSknSvk6nTEZL2+4f7D1X7nIPaH968/gJP6WK08JvQtlj7QcM8bTumGgbzs8K3lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iunp8IaY; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-80767b21543so4322839f.3;
        Tue, 16 Jul 2024 11:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156331; x=1721761131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86vugQ8piC6pzh4RgCq/qOTI8lQn1pJMR2FsXqHUdq8=;
        b=iunp8IaY6oqYIMWeLqM9SfKdkVtVT3LzqrmQTPGo8qvndVWwJcK9NOWEZbjzyqclUH
         ufZG8WNgTyC9aMJgYel7NkOkc8DMqKxgLx+T3sM7snuHIavWHQRSLvreTfTbfvobClUj
         sLjPTWdXImZSlGrVW5/SyII8Gh4pmKCepKtr+ZNCTNRy3rGBr8RrNBxIzfJpUUHN8g5b
         B6byRDmUW7fq6WVhhnM8qgKU+YdW8/FIAJFrnHPgi4JgsitQv+RCjqJYafoXXV6SMqTB
         oFEFnFh56PdzF3CEjWmGyg1etI43heeJoz3C0n+jkNWxPqhbYOM7VdIgec9F8/L665za
         +lmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156331; x=1721761131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=86vugQ8piC6pzh4RgCq/qOTI8lQn1pJMR2FsXqHUdq8=;
        b=DD+o2GEe6H/sTZIZZIHi6MT3wRP8MTtghMpOQ1/U/BcyTNNEmhVxTbiDK7ULpZHx0H
         BciL9mob8dG6yjCS8cF+lW+mrfe+DKU0HNZNEX0c9royjcqZFwqxG7b/ucEtwJYiBHZt
         2n144UI8ea9/E5jZ7f6NIr+1byEOVZckO/YrJrCqSxIB7Xh3kbkZY4GA2NR8doA7RmzT
         37QoromDJRMNFeGC1k4K1Zm6jZ8b3MDWJdBbBzVjzN6R8Yvy3iCjQqC1TACWyKS5kBm8
         qr3htGgrRTFzKYEcdgpnQpGwhfQG24a06x1vdnB7YnlyZfMZjQ4gxN5SBM8kKjJo2mBk
         Hbcg==
X-Forwarded-Encrypted: i=1; AJvYcCWXtIuk36mruEKOQDrS3weqNopi9G63vi1p1iywpNjaoN2Uz+zoUDucw5kWKCIbZWLY9g8cLHX3fma75AvyLomixlPSW2Eeqyc0
X-Gm-Message-State: AOJu0YwxHgy3m7I8x+ZeKK8pwcXgVKBZ5nlZwzVbUa4Lxjexi3HzPPaR
	cxSJP3rsrt1V2HQQybM1fcCCT+Ix9g24QgaHSDHIldpGzIim4Y3KF1kahUFT
X-Google-Smtp-Source: AGHT+IGspWRAZ8xQXE2wAmaby0oqEdb49oPrtrp7fF/Yp/QyZ4mDqvRaV/q4mGSb06mvHiXzLyf7xw==
X-Received: by 2002:a05:6602:2c08:b0:804:2216:4b23 with SMTP id ca18e2360f4ac-816c6519eacmr47580439f.17.1721156330718;
        Tue, 16 Jul 2024 11:58:50 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:58:50 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com
Cc: ukaszb@chromium.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	linux-doc@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	kernelnewbies@kernelnewbies.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v9-resend 20/54] selftests-dyndbg: add comma_terminator_tests
Date: Tue, 16 Jul 2024 12:57:32 -0600
Message-ID: <20240716185806.1572048-21-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716185806.1572048-1-jim.cromie@gmail.com>
References: <20240716185806.1572048-1-jim.cromie@gmail.com>
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



Return-Path: <linux-kernel+bounces-181402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EC38C7B93
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C668B20E05
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483081591ED;
	Thu, 16 May 2024 17:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvyFImDQ"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9E0157493
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 17:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715881505; cv=none; b=akqqeUp28MavWzwNgkC8BJ6qjoVDo2/dhISBK2Uc5jkiYztG260PyzDdNhOANmu05fXGJ7U8osr43BTHyo68cpJasc5E5v28H5LQ7x//guwUZisNWAbLkdUg8zcE0TLFoPWO0D6105d3cJbNTsS0UtS5lFBjKLX90yk35qkgvTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715881505; c=relaxed/simple;
	bh=0irpvrqeB6Py5kRKUz04f3K7f5Hu0Xmr2mVRw8vEvIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tYAOO4o7TLr9s+dOuycK8IyMhtILsMTVZe9tLh5YyCa3v/Oocl5mdCRQNDVgQ4yc0wnTK9IR1TgyOguaOAheB93qIpm6xGU7U6FBRnKCgwBy9C/kCLpc/h74vd+CdIqYhVQA/nfIueBblk5rhWzR2dAOsESv6tgtQQC14WbAsm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvyFImDQ; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7e1e06c9a10so67242439f.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715881503; x=1716486303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=os60IxUAXzHe/fTlflAC3Fj1jqSlC7haOycCU11kmOQ=;
        b=BvyFImDQlbkLrJPn6prrdt1lOh/NmkMRETmmWTXWwvuo7bkp9RJGmgSwUakRhegrQn
         6DdLadYDfCoAf8ECzWF7t0+B0XtSuItDo64DaJMNGe6LPjzI02bT1gzp5iD6e/uKXGNt
         2KqydRqSonPWWMQ2KFHDZsvdu7AHf8gBYHj2N205CpLYGQMBiHgdFDPJizOekmg2BgW3
         zwm3tzczJUa5MzR1HlDuzEuiVTm0emXisE64PvXjTCkIvoM+T9YLtk8h4bcQT8dcYwyW
         6MK7B7d5h1dDLTmNZOpuHaObryxr4+Rh2nFMA/42ep35OPtU4Zwt01wXrRC7oO0w6W4+
         URuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715881503; x=1716486303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=os60IxUAXzHe/fTlflAC3Fj1jqSlC7haOycCU11kmOQ=;
        b=HfShzYpkDM1vmJC/EYHrkzyGnRAzCmBAjJNfL0lG+u6hWOshSy6KNzwSSLKjnk2dWz
         mCp3mEPvZ8M1mei7v+8ba03HCnQl0/LL57vLs7LOaNUKpc/+AGY5fLubb07loLm7l4zT
         fzoaFMmvj3Wz3XXP2fleNHiyMuntefJ4J9x067mvHE98212xgapjLGipkdDPJqeWWwu6
         T9aQEzh5bcOPdl5KpyQfCxktF0enrOSUiv+lf6d78VkauNJD9TU/JYy1K0c6L8XlrszT
         95da7CCwtW1sPyUz2l8V5npY2Uq/WWNTQcgABZly8EusROmhyysi0SjNhaltzceVzXLU
         NOXg==
X-Forwarded-Encrypted: i=1; AJvYcCX2dYF0DukuhcuWGufbtdPE9TEJ88/e/lQXd6TyT4z07Df/feigGt51nsy/z4bx+tsqofOVGwa0br1d5v4UIijcwOQEofn86M9CvhxG
X-Gm-Message-State: AOJu0Yxh7DXLix25Dl88W+vpWcGyXti9BoiARIlTTX/LXSuXQlRGofQy
	MQUR1NnFHkcUV/PBNxd4HKnrdX0j1rf8xbceRjI2YEsHLDZxrcMw
X-Google-Smtp-Source: AGHT+IH/AdAKh0AUT8xpOtIlGPCk9LyCwKm+GIHOnGXHY+nCmScPvI++ujvn+rdLlykHquBtuW1rRQ==
X-Received: by 2002:a6b:6a19:0:b0:7de:cb15:1b17 with SMTP id ca18e2360f4ac-7e1b51cdac0mr2038774139f.9.1715881503054;
        Thu, 16 May 2024 10:45:03 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4893715057csm4273595173.80.2024.05.16.10.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 10:45:02 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Cc: ukaszb@chromium.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v8-RESEND 21/33] selftests-dyndbg: add comma_terminator_tests
Date: Thu, 16 May 2024 11:43:45 -0600
Message-ID: <20240516174357.26755-22-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240516174357.26755-1-jim.cromie@gmail.com>
References: <20240516174357.26755-1-jim.cromie@gmail.com>
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
index cb77ae142520..7a7d437e948b 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -217,9 +217,23 @@ EOF
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
2.45.0



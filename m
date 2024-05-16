Return-Path: <linux-kernel+bounces-181405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C58088C7B96
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4125C1F22BBB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C47715ADA6;
	Thu, 16 May 2024 17:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/yufmPy"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48B9158DD4
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 17:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715881507; cv=none; b=C94SGupvozwr6VZT31JWPMhxlWYWC4/X71cQpUk3+s+FzYTYhA0S0A+j1lPPDyomlsNRLr/nqDS1EGdHrOMQQiun/RszPIOThzo5UREjFNZ0J07NaWRcwZwufk+WR12M2C1GYI7zabCfSm3FCgdhrKxPWa1g42dwmwJvSsHEz3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715881507; c=relaxed/simple;
	bh=5RXdrrebCLyRNRu/PswOiPBlRFFX/KYQGPs3XeSm0zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRu91sby6zoxnxdTp8UOevgs/+I1060lhgQMht51nOFlTqZ5fhudnIxaZchDYr5KE9C5VXIuFADOKjIq01esJF0RknaIs/YKnykzNsncJcnWOiqxBHXBep2eLGriDDdZLsSuba1+tJ3RcTEjpPmNkovEZVc7IyUkAGMrpz894xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/yufmPy; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7e1bb4abfcfso64732739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715881505; x=1716486305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPvugwzLWUwzXXCLLOQaHatMSlMOb9JzZ40gA0iDEDg=;
        b=Y/yufmPyw9qfNiAInVCzekWz+achx7L8B2LBzhRPI8cC9wJovI8F7L1kZQeYUCKgzr
         rQN7v7UNX3Tvt9K3nWm+pDR12D56deLP4kDDkrxtSWwKJrIMYEucG8IqJvF6VZn2lozi
         3WdJePPlrvZ+UsOcbL+QflTqEJBqdEiIrVkL2dMBDeVhD8BhrxvdNO9pmPRHGESC9HgG
         c892v7PqJ6TMfXh4fvzC3FIT1DF0nqK5HWgQuvWf8dCZlBbTX/9agZ2+A/+tu2qFggAy
         X1W3xJKohkl5qQnj2ZbHegzQ4azVxQ1ya2le1fzbp2VoGOMrpay9BJ5W7oz4EfC5n8PT
         FetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715881505; x=1716486305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zPvugwzLWUwzXXCLLOQaHatMSlMOb9JzZ40gA0iDEDg=;
        b=YJg6JBsDMK6dyR+cPQzK1KvPJrwu05Uvts0z6Wt9SCTtlngtnEwRGXOMgKaBaGKuHe
         LnJGLz81GUgBAxsYYpIUfL5t+5VJ4fNRpYLmCIXmlLulA062StPpTKfR/RzrlAIu8xAe
         vHMg+W0NT0AqMZfd1RSrqb+bX/Vp8Fthwr+B83rQQGv8D8uzYF9R1j89VM4dPSTF7Ac4
         X9mB1gjdNBB7ufgnMygvp9GWFh7ZYrze/xGMdelJW6M1AmlGSLql5jU+r0/oWUAg/EsC
         KMdRyxdMDvJW8lxuxci1B8jipEa9eD79NW1qgJ47Vv5Ah61X+Ruzuqwcm5IMT6tIOf5O
         /AZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3fL6YjwJFOufD5hCZnoIoECmL4JXJbe/TeWvaAER5aNF0IWPSmWG7JZY8ycfVbMGIp+fh4Ej/Y7W4BohwvBcikkvvpvuShJXC/N3x
X-Gm-Message-State: AOJu0YzNyAyL+EAnQEeM91+lHiXe95OFIBTlKdDjdn7Ti/3wuQQEgnXv
	acNo94W/OL0ShxDEzJBxuo/MdYzr7/lzw8fk0GbCqwK0D8ra3dbt2q4xSi6+
X-Google-Smtp-Source: AGHT+IFLNKeTaw9iXVo5cxXFbdAHesMIZkS5AmGLUXUNEYlNOXHJW3I4DpYnys/G9UM+IcGgvUqZag==
X-Received: by 2002:a05:6e02:1a6a:b0:36c:d52:e969 with SMTP id e9e14a558f8ab-36cc1476080mr241739195ab.6.1715881505054;
        Thu, 16 May 2024 10:45:05 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4893715057csm4273595173.80.2024.05.16.10.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 10:45:04 -0700 (PDT)
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
Subject: [PATCH v8-RESEND 23/33] selftests-dyndbg: test_percent_splitting multi-cmds on module classes
Date: Thu, 16 May 2024 11:43:47 -0600
Message-ID: <20240516174357.26755-24-jim.cromie@gmail.com>
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

New fn tests multi-queries composed with % splitters.  It uses both
test_dynamic_debug and test_dynamic_debug_submod, and manipulates
several classes at once.  So despite the syntactic-oriented name, it
also tests classmaps.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../dynamic_debug/dyndbg_selftest.sh          | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index 7a7d437e948b..ddb04c0a7fd2 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -231,9 +231,29 @@ function comma_terminator_tests {
     ddcmd =_
 }
 
+function test_percent_splitting {
+    echo -e "${GREEN}# TEST_PERCENT_SPLITTING - multi-command splitting on % ${NC}"
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
+    ddcmd =_
+    modprobe test_dynamic_debug dyndbg=class,D2_CORE,+pf%class,D2_KMS,+pt%class,D2_ATOMIC,+pm
+    check_match_ct =pf 1
+    check_match_ct =pt 1
+    check_match_ct =pm 1
+    check_match_ct test_dynamic_debug 23 -r
+    # add flags to those callsites
+    ddcmd class,D2_CORE,+mf%class,D2_KMS,+lt%class,D2_ATOMIC,+ml
+    check_match_ct =pmf 1
+    check_match_ct =plt 1
+    check_match_ct =pml 1
+    check_match_ct test_dynamic_debug 23 -r
+    ifrmmod test_dynamic_debug
+}
+
 tests_list=(
     basic_tests
     comma_terminator_tests
+    test_percent_splitting
 )
 
 # Run tests
-- 
2.45.0



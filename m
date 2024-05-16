Return-Path: <linux-kernel+bounces-181407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E5D8C7B98
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 015E31F21AEF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A19F15B961;
	Thu, 16 May 2024 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmOw5eVQ"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D36715ADA7
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 17:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715881510; cv=none; b=cA8oN+jMH/9/AZnKlzwQUUFpV4MQyqVmlOUGHk3DX2V1oMnbzey96WzhCmjkEjhahJjCBlqy9Z0Oeg/RtCucX36t0utVJpvcDkBdM0etFZra38+0vYW2tMYtye8WRJUOjYMIJNhUGFz7YbWUd/pZUE/JTDxgeAeFnkpl6DTgzCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715881510; c=relaxed/simple;
	bh=S0YULHTm+fjM0qLnB/V2U6Y8Gar8z1QmhDis3HrZlsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VpMV/+b+W51CBCLfs8GSfEmeTPlTHDshfyU6666HP6OgmiQVgVJDOK2GZbRLP6t7VwXI31L0nKur0ocuIHxVQfX4CZTElQiKz/D1OH7UH1KzHlvxb5M4bW0aUfbn3jf4fIM+695XrsGbyyZ9BWmicwbkjl1uEvX/APZpuj6naMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmOw5eVQ; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7e1bb4abfcfso64738739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715881508; x=1716486308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7zHUfeGi4mVPiBP6D9isopkhhYt9FN8vIOW8+G9xg4=;
        b=WmOw5eVQmo+Rw0nj/6Y8FM45ya1GB3cIA8EwFPugvVUlTVOoQXAss5NsF21EmrcSYu
         IX89yrluz7A/ieLof5JjIGR5G18yEzX+wuNvwRlf41R/vCXDwAR8vMtsPJO+L4BL0Hf8
         agxxlCAaJoYIfIVF4MiI9RWe7JdPWfBxXoB6vLHt2YP61i5xonzvZDKPDHB0ZE2atYAI
         cDj1uIYJUtgd8Xrl4YsLL1dZ9NtHwzTKBzVXB72nX5F7h2x/caI/P+MeFP2aFkj76N6q
         wEzoBa0A7dn4qY0f0hYsKEV1ApMFE7OxliPdBK1+6By08HazRNhJWw5WEpjKopKDGoGR
         yf2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715881508; x=1716486308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7zHUfeGi4mVPiBP6D9isopkhhYt9FN8vIOW8+G9xg4=;
        b=Biv9o0V1E2PvSeUteQHewaJCSYFILrJRum15JJLV2wFyAuuGINSaKn1Ocy7+SOHbG6
         1ixCM/1PLirGVtC5Z3twN5/b/E5mNfzfMS/aMGg3AwQCIysNBvO9PBhO2mUvDSkCmdPc
         E0wt9J9YyYU/PuMUzt/YDaiyNoFYbWlE2gzQbX+yFDsW1Cc0kEisLAP/CS7EKie3yRNV
         xTWiqPy4F+BQxiwuk8yQCPe3bph8gJmougWnE4hV4YKGB2FZdQC+hZC6D/n/26o8ah0D
         sl/tlpTHA3gnBMfWOJL3mCuyyqPgL2RylP39d+IhQe9wOOnH+2LjETrqjlJP9Gavt9PX
         qLLw==
X-Forwarded-Encrypted: i=1; AJvYcCX+kXtifG1qfZZWIDy0MwVP3AuThCGqIomYwIt9rXVI1dyFmjrzYMTNNWdFbFYMXDPex1Vnogia9dY/lQubnVAr28bEzd0LQwCAw6nf
X-Gm-Message-State: AOJu0Yw7ahPAA8QYyThjxgFeecrcSHe1uIbizYCDaldIzNLRuQHQXAXs
	JrG2Hoo2c7Hj8Z2OjoVO06uguGwLXEbfpuFK2trUN5k4gsyvcsf6
X-Google-Smtp-Source: AGHT+IHY0hMb0HEeGBuUW18LZaLggFg/c3EURAhCr+m5emvlajDgZNchOQOmEQ+M02mvD5cudyMHIA==
X-Received: by 2002:a05:6602:1d5a:b0:7e1:80d7:96e0 with SMTP id ca18e2360f4ac-7e1b52054afmr2149986239f.14.1715881507373;
        Thu, 16 May 2024 10:45:07 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4893715057csm4273595173.80.2024.05.16.10.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 10:45:07 -0700 (PDT)
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
Subject: [PATCH v8-RESEND 25/33] selftests-dyndbg: add test_mod_submod
Date: Thu, 16 May 2024 11:43:49 -0600
Message-ID: <20240516174357.26755-26-jim.cromie@gmail.com>
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

This new test-fn runs 3 module/submodule modprobe scenarios, variously
using both the generic dyndbg=<queries> modprobe arg, and the
test-module's classmap-params to manipulate the test-mod*'s pr_debugs.
In all cases, the current flag-settings are counted and tested vs
expectations.

The 3rd scenario recapitulates the DRM_USE_DYNAMIC_DEBUG=y failure.

1. 2 modprobes (super then sub), with separate dyndbg=class-settings
   check module specific flag settings

2. modprobe submod, supermod is auto-loaded
   set supermod class-params
   check expected enablements in super & submod

3. modprobe super, with param=setting (like drm.debug=0x1ef)
   modprobe submod
   validate submod's class'd pr_debugs get properly enabled

The test uses multi-queries, with both commas and percents (to avoid
spaces and quoting).  This is the main reason the test wasn't earlier
in the patchset, closer to the classmap patches its validating.

With some tedium, the tests could be refactored to split out early
tests which avoid multi-cmds, and test only the class-params.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../dynamic_debug/dyndbg_selftest.sh          | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index ddb04c0a7fd2..54acee58cb4e 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -250,10 +250,70 @@ function test_percent_splitting {
     ifrmmod test_dynamic_debug
 }
 
+function test_mod_submod {
+    echo -e "${GREEN}# TEST_MOD_SUBMOD ${NC}"
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
+    ddcmd =_
+
+    # modprobe with class enablements
+    modprobe test_dynamic_debug dyndbg=class,D2_CORE,+pf%class,D2_KMS,+pt%class,D2_ATOMIC,+pm
+    check_match_ct '\[test_dynamic_debug\]' 23 -r
+    check_match_ct =pf 1
+    check_match_ct =pt 1
+    check_match_ct =pm 1
+
+    modprobe test_dynamic_debug_submod
+    check_match_ct test_dynamic_debug_submod 23 -r
+    check_match_ct '\[test_dynamic_debug\]' 23 -r
+    check_match_ct test_dynamic_debug 46 -r
+
+    # change classes again, this time submod too
+    ddcmd class,D2_CORE,+mf%class,D2_KMS,+lt%class,D2_ATOMIC,+ml "# add some prefixes"
+    check_match_ct =pmf 1 -v
+    check_match_ct =plt 1 -v
+    check_match_ct =pml 1 -v
+    #  submod changed too
+    check_match_ct =mf 1 -v
+    check_match_ct =lt 1 -v
+    check_match_ct =ml 1 -v
+
+    # now work the classmap-params
+    # fresh start, to clear all above flags (test-fn limits)
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
+    modprobe test_dynamic_debug_submod # get supermod too
+
+    echo 1 > /sys/module/test_dynamic_debug/parameters/p_disjoint_bits
+    echo 4 > /sys/module/test_dynamic_debug/parameters/p_level_num
+    # 2 mods * ( V1-3 + D2_CORE )
+    check_match_ct =p 8 -v
+    echo 3 > /sys/module/test_dynamic_debug/parameters/p_disjoint_bits
+    echo 0 > /sys/module/test_dynamic_debug/parameters/p_level_num
+    # 2 mods * ( D2_CORE, D2_DRIVER )
+    check_match_ct =p 4 -v
+    echo 0x16 > /sys/module/test_dynamic_debug/parameters/p_disjoint_bits
+    echo 0 > /sys/module/test_dynamic_debug/parameters/p_level_num
+    # 2 mods * ( D2_DRIVER, D2_KMS, D2_ATOMIC )
+    check_match_ct =p 6 -v
+
+    # recap DRM_USE_DYNAMIC_DEBUG regression
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
+    # set super-mod params
+    modprobe test_dynamic_debug p_disjoint_bits=0x16 p_level_num=5
+    check_match_ct =p 7 -v
+    modprobe test_dynamic_debug_submod
+    # see them picked up by submod
+    check_match_ct =p 14 -v
+}
+
 tests_list=(
     basic_tests
+    # these require test_dynamic_debug*.ko
     comma_terminator_tests
     test_percent_splitting
+    test_mod_submod
 )
 
 # Run tests
-- 
2.45.0



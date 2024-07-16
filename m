Return-Path: <linux-kernel+bounces-254278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD0C933165
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A9A82831A1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7307F1A83C5;
	Tue, 16 Jul 2024 18:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgT9+PS3"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6851A708F;
	Tue, 16 Jul 2024 18:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156338; cv=none; b=uU1EwcA4QmhzxbuYKos7W9Z7sWjC9YNu6Cl1O72cLTNwpZGMJYgsTc/d/SRKtZWUV2ynXD973szOw1UrhMhOfcTJywHw1ZIJxn27sYwzz+FKEj+9GWAtNqvT+dupCxblbi9lQOrxml2/MHe+5CmCSb7Vjkfg4sxPMP4c0GW4v0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156338; c=relaxed/simple;
	bh=kN/R7Fl1F1fcLv8VsLR2kYVGn+R+bGjHHORasn7sytk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=prEnhQJ2kqVVk+TmHz8qtLc9Zh7HzLaGTEclDHPna7X1TMaDefHH4q+GNdqVcPCFmCOJ1OcG70Swy/Kmsj52XvM9PQI11QKoDSzIrjdi7T9gMLNBjXlRZnqWzKP57NkbLg2WF8MPTM/vNgm9w2LB+lkfrNyfXTL1jS96xY/Whbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DgT9+PS3; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7f70a708f8aso5855339f.2;
        Tue, 16 Jul 2024 11:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156336; x=1721761136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJdYoevwZB2aGfv474+weXhid0sQKo8sv3F+UqQdL9E=;
        b=DgT9+PS3sdVkmNDA1n9HtBvhTCqaguqQczjnD9H/KrumX/lSmm+6/2GseHVW1B+oUV
         tykf+iM66y0W9fqLH2hGrz1OhrepiwY9vDy7mmFY8ZW4Sn7EzyeB7k37ub0Pt0q6w1C5
         +Ifffx9Qovad5RdLFprgoaSNffv1JLV6hdH86VymU/7p05cO4OhuDkHzxvHPSudSjMkk
         GGUFSU4r1AabX/wBaNb8Gxtyct/p+rI0BPdU2uZf1M/9sDmqLNLjDxe2UvUb+WT1rH3X
         MqZzbK3mBMWXC0ye9vcfhOLbljUbtwfQnJvYc82RWdN8TpXwAXUjJJwhun9VUPi5JkJE
         3Jww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156336; x=1721761136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJdYoevwZB2aGfv474+weXhid0sQKo8sv3F+UqQdL9E=;
        b=OC8mwxSnwDS+bSHc/rxc7NC0vMkkqZLpoHEyJReo+1PPrkTi+/4ZbaP63TCP2bN2TO
         1DHPS4zproYcXDmwU8hFSG5CpjKioEBKCT8FOay798qAoXzlYXzB0T3DMOvpmeNgLCBE
         HFz35RSg6TLmRTqPQOfLemlx49plF1enOfvaa9dlvXs3VuvQ4LcF6DtV8jb6YLarz8hd
         0tLaCzzgkBNWKdsEDN9u0dvzZ0lEPy8PkBmoACi3Lv5C1aDbqW7d0RedpBr2DHBzpk4C
         jBDF0xezo+8wGaKopt82ARMMkkCAd2q6bBQASHAX/iShidrhKLXoHiSzekYIqtpvPb18
         wpGA==
X-Forwarded-Encrypted: i=1; AJvYcCVKJg1HqJsbwIUFd+bOGblTnAZUVWX5BzeTL/XvpU/PX2YZ4VY7aX0A0rKOybtSRAf2vx4lc6J1oft3wJJdi4fwit0XQubn2f/7
X-Gm-Message-State: AOJu0Yxlc9Fg2Pg5NC7IfGFdxt0RKp0LrVSYGROv44ODDPUo1I+p6ZDo
	7yhQd4QUC1zkDNkrii6irmBkuk1NmxqdJfFMLPCGhGDFcDBCOdmUCCh5ocMH
X-Google-Smtp-Source: AGHT+IEznmXe0kK0CoynYcYtF+WgxWhQ96VOhaEo0TmnyPyzHHCMylbYsvdKD2W05mtvEUB7RgFdSA==
X-Received: by 2002:a05:6602:2b91:b0:807:82c2:5247 with SMTP id ca18e2360f4ac-816c34e59b4mr35528239f.6.1721156335827;
        Tue, 16 Jul 2024 11:58:55 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:58:55 -0700 (PDT)
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
Subject: [PATCH v9-resend 24/54] selftests-dyndbg: add test_mod_submod
Date: Tue, 16 Jul 2024 12:57:36 -0600
Message-ID: <20240716185806.1572048-25-jim.cromie@gmail.com>
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
 .../dynamic_debug/dyndbg_selftest.sh          | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index 996e6fdcfb52..fccd2012b548 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -246,10 +246,77 @@ function test_percent_splitting {
     ifrmmod test_dynamic_debug
 }
 
+function test_mod_submod {
+    echo -e "${GREEN}# TEST_MOD_SUBMOD ${NC}"
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
+    ddcmd =_
+
+    # modprobe with class enablements
+    modprobe test_dynamic_debug \
+	dyndbg=class,D2_CORE,+pf%class,D2_KMS,+pt%class,D2_ATOMIC,+pm
+
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
+    # no enablements propagate here
+    check_match_ct =pf 1
+    check_match_ct =pt 1
+    check_match_ct =pm 1
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
2.45.2



Return-Path: <linux-kernel+bounces-570216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 772BCA6ADED
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB1AE9852F8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877BD22F3BD;
	Thu, 20 Mar 2025 18:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2k5wkwI"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668CD22F160
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496813; cv=none; b=VFjU1ln5HoknifQqn6X8k+ORTjQ9qw64DpmlNmAEULHz1/9c6V2gpmNNCQY65jWLSmNOSbJXYeIutS6WnR7p0gIkWunCExhH/4dEchUG6BE+Cx/6qPoIpya53lLVPhaoVhoiMwjwpcQVX4AE++NJO8rmAGe5Wolh8MXcPBbzmQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496813; c=relaxed/simple;
	bh=gW97FK7kE+2ba8HMbFFP8xcJiMKoY2CjRDdGlOZTBDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uPpFTvMH7p5Wg8IwPfcVlq6qc/7Pek7eIYQQYswRxYmynaYrKk2cVEknheb6Efz+hBPoFAc5JbI/x/mVQqJ0m+eFu2/EJCmaIv/SyA6mVLbn6hXzTiGImWurOJhGEdlbXvbBrF3xmANMxnzq9pYihWdhC66Xyi6GZIlAB2T30lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2k5wkwI; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-851c4ee2a37so75122139f.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496811; x=1743101611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gMXprwpPowLLoVogtCcQtZ50lNSDFQUUtuE2MLi/rpw=;
        b=B2k5wkwI+8uMhVhXL3SHVmbEm6YSJE7qZWj/bN6jzEqqj8rfqwumpxQmmucci1cumX
         kFybqZJFsOxsfaBustsEZeR2WkpYhvAWpKgwD+Azj90Welmw9FXgiP341ADh/O64vnVp
         YadTaSLq+OqAQGMnAwb8S3ZjOouFBnX58rs6/dcYsrsmPtuIlSiQf4QfZGlPSL/PBJlU
         4efFfRe4/nzPU3G4IVUrqA7k0Ky6M3aMHZNDvDGqKPk8j2Hw/9TVf0hQRttyTpd5+1w0
         kvbUTCBRt6X0UJxBSDXzjrxjEpE+OS7dYc9/jAknhXkCSvss2ZcA3Xshww3roR4OY9Mh
         oV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496811; x=1743101611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gMXprwpPowLLoVogtCcQtZ50lNSDFQUUtuE2MLi/rpw=;
        b=N+CexG3Z9y5e1bShEOUGlpZpj/7K6upLkoWD1RThK642gwk8UON68GfHdmn2ahAQBE
         ZxM67BTHdPDevb5n2xT9xFwT22Sfz0UFyD5gPmZCbM7sPX+oC4z8eVbDPb52LxPRdiBW
         Vs8GHEuMADeTUUm9fYifMI5sLynp5pTjFyFWfGKcLypobu5drHuvJW55FZDLkuD0wAFX
         OMksuz2QMQ26SVFYsEtSu/ueWGnFsKxlqpxVCaeBPjNWdcUKQKd+HT41sca8eqdg+V28
         GxuMTEqxe1n87u199ceLQMwU1ZaDV24Fga5Go4okuckaVBAvrPsAZ/KYPXPW14a6RoK/
         jcjg==
X-Gm-Message-State: AOJu0Yz+XvDXUfRp8klU4+rjUOSdnBKRkWgZDXJOg4RM/6FaGi1fAzZG
	IEtxsi5QEvCILdR9Fg9h8MMpKCz3X19J3JQBZb6qiySQZv3mxDL898OK2D9m
X-Gm-Gg: ASbGnctkJ6BLTbZXCCgMidtAJxC7d+3SOkaGxmNNkHEBQUmds6zyHNXzH8w/Nw7w1R5
	ymKsLyBfgpdLdkmZCRLOunpUDQyjicv/OrEtV0kcWL9VmdsKCbWEs40ostekOVdx95VVAzwm4f0
	JntdkaEaEFAIRAdtlad+N/mlPjTk6lPqDIOPrrRAXstCRuhm134K8M9fnP99N53tiV58o0+hE0j
	mcswuloEjmZfV74cQYVgQ82cgz0JYKTrzSiIptu9nGZATIDlJTt4ZcSbCleCGMjjNGbC5IBgqc2
	jH7eCN9Sw8uxNKiOxOcbZOMtCxAaMmow/4DSMTx3iPwsQRTZdqA/hcNurOldKAfGMKLuTl51rn9
	26w==
X-Google-Smtp-Source: AGHT+IG+/7Kbepu4M0I9q9bM6mS824HGPKpcYmMojnJPg6cLnUArrmay+qvcX7lRE8FxKCVlxWVxpQ==
X-Received: by 2002:a05:6602:36c4:b0:85b:5494:5519 with SMTP id ca18e2360f4ac-85e2ca6fff3mr44385939f.5.1742496811395;
        Thu, 20 Mar 2025 11:53:31 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:53:30 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-gfx-trybot@lists.freedesktop.org
Cc: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 25/59] selftests-dyndbg: add comma_terminator_tests
Date: Thu, 20 Mar 2025 12:52:03 -0600
Message-ID: <20250320185238.447458-26-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320185238.447458-1-jim.cromie@gmail.com>
References: <20250320185238.447458-1-jim.cromie@gmail.com>
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
- skip comma tests if no builtins
---
 .../dynamic_debug/dyndbg_selftest.sh          | 21 ++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index 68a9046405f2..368d10a691a0 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -216,7 +216,7 @@ function check_err_msg() {
 function basic_tests {
     echo -e "${GREEN}# BASIC_TESTS ${NC}"
     if [ $LACK_DD_BUILTIN -eq 1 ]; then
-	echo "SKIP"
+	echo "SKIP - test requires params, which is a builtin module"
 	return
     fi
     ddcmd =_ # zero everything
@@ -238,8 +238,27 @@ EOF
     ddcmd =_
 }
 
+function comma_terminator_tests {
+    echo -e "${GREEN}# COMMA_TERMINATOR_TESTS ${NC}"
+    if [ $LACK_DD_BUILTIN -eq 1 ]; then
+	echo "SKIP - test requires params, which is a builtin module"
+	return
+    fi
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
+
 tests_list=(
     basic_tests
+    comma_terminator_tests
 )
 
 # Run tests
-- 
2.49.0



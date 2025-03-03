Return-Path: <linux-kernel+bounces-540843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A28FBA4B5B2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 02:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89AB1189057A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 01:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2E52C190;
	Mon,  3 Mar 2025 01:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHCkATj4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860754C85
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 01:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740963723; cv=none; b=oldNwfkZrUjcIHC40MUaQvuQlQqBjAyGfPLcmhnpEhxLKZ3r2Pth/2JilkQB1ZHM9Xb+hPG6ztoOoOvMzmuQQcvYjTKSNVhFdUk565QEVFD0l34XVygtXXnPepd+P1B/kFacLiIhnSvapDOQIvlA+rC5qT07pOIKtMp2WIdp0mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740963723; c=relaxed/simple;
	bh=zptuAMgcKHkjjSCc3Vad3LElYs5BZ1Fj2qcnIlzFFzs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TSu6r3oXCnJLn1p9Vedg/RdRCdZdhNcPMGDVzKm6TEeYgIZ/cAlJqJdSMpW4n8ou7sJHgSB4SA+kxXiJIaFKqgPkkGzn+zUX23iv7KV3DVZ9Mb5rRzYKTZJAXA4IQMjRumcVNUDEiqSoAG31RPZnblEcDtyV6bUvIOHel+Ul5UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHCkATj4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F48FC4CED6;
	Mon,  3 Mar 2025 01:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740963723;
	bh=zptuAMgcKHkjjSCc3Vad3LElYs5BZ1Fj2qcnIlzFFzs=;
	h=From:To:Cc:Subject:Date:From;
	b=nHCkATj4GlkTcQQTl2vtxDUJ1lzHvHuj1laTL0uDX79U8KBjqRcRtIwCHwQSmwrGg
	 ZzqilDCFWNYr7Ocp8ZDGxWQIzm0pP8Ut1PHTKA/sxW2Egznmdi8COwBJrtKHh3G1DJ
	 l3l78snBxpevJwXb6NtzU0b1szKPuG9xJHWS8k9B8lp2Fa9FmHQITegmnbaBCt6Fd8
	 rfqsR/2iBj4fhlBUr5Hkh8DHYXTvH2IQV4XLZRjEVsU9opNH5otll67n8+JShjGtp+
	 0x9wrCYTnbwIH2qBX/KnVIjJAQbhoNPQABlI5IlUHuK+wQue1pi2Hk8Kqb3jj+zLmj
	 nyrPT45D+1RwQ==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Arthur Marsh <arthur.marsh@internode.on.net>
Subject: [PATCH] tools build: Fix fixdep dependencies
Date: Sun,  2 Mar 2025 17:01:42 -0800
Message-ID: <a63ddb79a9adc11ab68052da633fc01d7dc65c06.1740963699.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tools version of fixdep has broken dependencies.  It doesn't get
rebuilt if the host compiler or headers change.

Build fixdep with the tools kbuild infrastructure, so fixdep runs on
itself.  Due to the recursive dependency, its dependency file is
incomplete the very first time it gets built.  In that case build it a
second time to achieve fixdep inception.

Reported-by: Arthur Marsh <arthur.marsh@internode.on.net>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/build/Build    |  2 ++
 tools/build/Makefile | 23 +++++++++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)
 create mode 100644 tools/build/Build

diff --git a/tools/build/Build b/tools/build/Build
new file mode 100644
index 000000000000..1c7e598e9f59
--- /dev/null
+++ b/tools/build/Build
@@ -0,0 +1,2 @@
+hostprogs	:= fixdep
+fixdep-y	:= fixdep.o
diff --git a/tools/build/Makefile b/tools/build/Makefile
index 63ef21878761..a5b3c29b8d70 100644
--- a/tools/build/Makefile
+++ b/tools/build/Makefile
@@ -37,5 +37,24 @@ ifneq ($(wildcard $(TMP_O)),)
 	$(Q)$(MAKE) -C feature OUTPUT=$(TMP_O) clean >/dev/null
 endif
 
-$(OUTPUT)fixdep: $(srctree)/tools/build/fixdep.c
-	$(QUIET_CC)$(HOSTCC) $(KBUILD_HOSTCFLAGS) $(KBUILD_HOSTLDFLAGS) -o $@ $<
+include $(srctree)/tools/build/Makefile.include
+
+FIXDEP		:= $(OUTPUT)fixdep
+FIXDEP_IN	:= $(OUTPUT)fixdep-in.o
+
+# To track fixdep's dependencies properly, fixdep needs to run on itself.
+# Build it twice the first time.
+$(FIXDEP_IN): FORCE
+	$(Q)if [ ! -f $(FIXDEP) ]; then						\
+		$(MAKE) $(build)=fixdep HOSTCFLAGS="$(KBUILD_HOSTCFLAGS)";	\
+		rm -f $(FIXDEP).o;						\
+	fi
+	$(Q)$(MAKE) $(build)=fixdep HOSTCFLAGS="$(KBUILD_HOSTCFLAGS)"
+
+
+$(FIXDEP): $(FIXDEP_IN)
+	$(QUIET_LINK)$(HOSTCC) $(FIXDEP_IN) $(KBUILD_HOSTLDFLAGS) -o $@
+
+FORCE:
+
+.PHONY: FORCE
-- 
2.48.1



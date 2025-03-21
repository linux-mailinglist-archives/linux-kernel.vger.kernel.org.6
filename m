Return-Path: <linux-kernel+bounces-571423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64130A6BCF2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AB09189B163
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D9F19CC20;
	Fri, 21 Mar 2025 14:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="TwqldJdU"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC814C85
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567357; cv=none; b=j4rtQk+z4r9u1ak00N52xkvP0z3z99VDVYHZxjxVsknQc1JI/er3Mqh1TpJwTJSlHogHmWwJodRF3wsTacjSvulCEkbvbs/3csvEpWDpSaawbp/wmXI/T+hiTB5L8Mx6nNe0LcKAM/G/gkLb/eQKrcctHBnPo2UjQfZCgD7ntDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567357; c=relaxed/simple;
	bh=sTYAUFclVZdLncU1+P/eN4/e7zBKr17UMTJxSmWMco4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IG9E+/ZfXLteMhqYJdYCR+FPRbMZzjpPg6/kgqVWvuTmef+8ilUEiF8oob8wQeFzZWXJ22yZAYC0MkHWWE1hHvePy+es0up4oYeomIFGJNZlHqjBQhwdh6cCoWk+Y5Gddl3kEwgvhZAxoG/A6YLSvcnQKWfqesa/NDvC3jHDsGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=TwqldJdU; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ZK4ZW1s0rz9spF;
	Fri, 21 Mar 2025 15:29:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1742567347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vMXXI+E/Sbp6yE2srQIZ5UyRk/DPJ+o0tAoJuj3BRCY=;
	b=TwqldJdUhainKtapBf+eSHFuKToyIyFA3rihZ/6ztaUjoe/1mhyu68rTfYX+bwyuAcPFWN
	aumWZtaa41558Klb0UZrLe1Cz2VvkmPh/EWn2i7LaaNrk1kNJN+nNmFGSu45OGZB2Q+vVj
	2B0eeej0AqVC22tb0yNkWxzcFWjdFhtG1kx6MOnmhhYKtrErxU7Qx4JBB4gz2NtPKtdMmj
	N8vdXuwqVa+20JHW5u7FkoP7Z/XcIixwo8Tm5FU+aWOFsNUoEEBhHkFJbTkzrlOGrND6+v
	W6JtEGCTHVfmnpwp7wYd0sh780iDCGKiR0lulYUMlWAonVwAqeAMumAdmFkM9g==
From: Tor Vic <torvic9@mailbox.org>
To: arnd@kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: bp@alien8.de,
	tglx@linutronix.de,
	mingo@redhat.com,
	hpa@zytor.com
Subject: [PATCH] arch/x86: Add an option to build the kernel with '-march=native' on x86-64
Date: Fri, 21 Mar 2025 15:28:58 +0100
Message-ID: <20250321142859.13889-1-torvic9@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 7ce7796149f77df7e09
X-MBO-RS-META: anjwshskwop1t1ss9yczbbtgpx78g5a4

Add a 'native' option that allows users to build an optimized kernel for
their local machine (i.e. the machine which is used to build the kernel)
by passing '-march=native' to the CFLAGS.

The idea comes from Linus' reply to Arnd's initial proposal in [1].

This patch is based on Arnd's x86 cleanup series, which is now in -tip [2].

[1] https://lore.kernel.org/all/CAHk-=wji1sV93yKbc==Z7OSSHBiDE=LAdG_d5Y-zPBrnSs0k2A@mail.gmail.com/
[2] https://lore.kernel.org/all/20250226213714.4040853-1-arnd@kernel.org/

Signed-off-by: Tor Vic <torvic9@mailbox.org>
---
Here are some numbers comparing 'generic' to 'native' on a Skylake dual-core
laptop (generic --> native):

  - vmlinux and compressed modules size:
      125'907'744 bytes --> 125'595'280 bytes  (-0.248 %)
      18'810 kilobytes --> 18'770 kilobytes    (-0.213 %)

  - phoronix, average of 3 runs:
      ffmpeg:
      130.99 --> 131.15                        (+0.122 %)
      nginx:
      10'650 --> 10'725                        (+0.704 %)
      hackbench (lower is better):
      102.27 --> 99.50                         (-2.709 %)

  - xz compression of firefox tarball (lower is better):
      319.57 seconds --> 317.34 seconds        (-0.698 %)

  - stress-ng, bogoops, average of 3 15-second runs:
      fork:
      111'744 --> 115'509                      (+3.397 %)
      bsearch:
      7'211 --> 7'436                          (+3.120 %)
      memfd:
      3'591 --> 3'604                          (+0.362 %)
      mmapfork:
      630 --> 629                              (-0.159 %)
      schedmix:
      42'715 --> 43'251                        (+1.255 %)
      epoll:
      2'443'767 --> 2'454'413                  (+0.436 %)
      vm:
      1'442'256 --> 1'486'615                  (+3.076 %)

  - schbench (two message threads), 30-second runs:
      304 rps --> 305 rps                      (+0.329 %)

There is little difference both in terms of size and of performance, however
the native build comes out on top ever so slightly.
---
 arch/x86/Kconfig.cpu | 9 +++++++++
 arch/x86/Makefile    | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 8fcb8ccee44b..057d7c28b794 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -245,6 +245,15 @@ config MATOM
 
 endchoice
 
+config NATIVE_CPU
+	bool "Build for native CPU"
+	depends on X86_64
+	default n
+	help
+	  Optimize for the current CPU used to compile the kernel.
+	  Use this option if you intend to build the kernel for your
+	  local machine.
+
 config X86_GENERIC
 	bool "Generic x86 support"
 	depends on X86_32
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 8120085b00a4..0075bace3ed9 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -178,8 +178,13 @@ else
 	# Use -mskip-rax-setup if supported.
 	KBUILD_CFLAGS += $(call cc-option,-mskip-rax-setup)
 
+ifdef CONFIG_NATIVE_CPU
+        KBUILD_CFLAGS += -march=native
+        KBUILD_RUSTFLAGS += -Ctarget-cpu=native
+else
         KBUILD_CFLAGS += -march=x86-64 -mtune=generic
         KBUILD_RUSTFLAGS += -Ctarget-cpu=x86-64 -Ztune-cpu=generic
+endif
 
         KBUILD_CFLAGS += -mno-red-zone
         KBUILD_CFLAGS += -mcmodel=kernel
-- 
2.49.0



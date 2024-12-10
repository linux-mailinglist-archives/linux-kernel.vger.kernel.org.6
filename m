Return-Path: <linux-kernel+bounces-439785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9739EB3EE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94ED7188B2D5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799371BEF8C;
	Tue, 10 Dec 2024 14:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZujiaCE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EA91BE86A
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733842209; cv=none; b=maUHwd1SveBOvI7fJuj8vEItgvTW2Pq8GUkTRoo1ZmwqXj5rCv5Nzchq+bkXwMW540OgpLysgcUGK/qPeZt1xHLWFWfV9cC5Is6chX8MiU66ifap2so+yJrCfkhohjmbl7t1xUVm+YGgZpgGZo9qVftZlpXA2tfGkiJyMCGlhzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733842209; c=relaxed/simple;
	bh=hRlH4NBVNwGhJ1JpNPALCjGk3CXpM7yv7jTBCNwOqX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g+htsAbJ6VGro4o3BNKbeed08pTokyZGONHn4x0xYLjchdBLejcq1DeW5uq9lLkRBLmZozgbgBB2NsDQYNnIxXaASTL1orFpzAmhMYP8vU8gm5SJ1BDDpNSAugRvrtbaF6c9DHT1QCSF3DsAhKZ8nJkNXkSZter1GuJb+oEcZfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZujiaCE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0BAC4CEDE;
	Tue, 10 Dec 2024 14:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733842209;
	bh=hRlH4NBVNwGhJ1JpNPALCjGk3CXpM7yv7jTBCNwOqX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GZujiaCEMkCIsTyMDSjPEg9/x3UV3riCwi9DlqVmH2yWvCHcW3+ks+7jw15JcstKo
	 Kyh9OaufWOE+DhWbUKiYUV2pOtrzbyoJPBXHqGCm6JkiPiku/1BOwCVSuSfNnVlLI1
	 AwU3DYpss7wqr8h2VCynpaS1d1ZGJaqyf3N4h5AacfOy3No8t5knnFyzm4sEL5iQjF
	 KSQ7p4mNdG+I5JYxVWgB1BQc2IJ/y+DD3otaQTXF0H/Y5V/zlcGR3jCEpeYGpOUEQP
	 yvruMzJvEKcAYuBWZMjHPtrKi2tcAemNkCb99bPHVrQOO9BUk776TfxxStF/yqqgnP
	 Sm1Z5+W+DcMog==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Shevchenko <andy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 05/11] x86: add CONFIG_X86_64_NATIVE option
Date: Tue, 10 Dec 2024 15:49:39 +0100
Message-Id: <20241210144945.2325330-6-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210144945.2325330-1-arnd@kernel.org>
References: <20241210144945.2325330-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

As a replacement for the obsole MK8/MPSC/MCORE2 configuration options,
allow building a specialized kernel for the local CPU, which is useful
for users building their own kernels, and does not require maintaining
a list of possible CPU options.

Between -march=native and -mtune=native, I pick the former in order
to give the best performance through the use of extra instructions,
but at the cost of not being able to run on older CPUs at all. This
creates a small risk of running into illegal instruction faults when
the resulting binary ends up being run on a machine other than the
one it was built on.

Link: https://lore.kernel.org/lkml/CAHk-=wji1sV93yKbc==Z7OSSHBiDE=LAdG_d5Y-zPBrnSs0k2A@mail.gmail.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/Kconfig.cpu | 14 ++++++++++++++
 arch/x86/Makefile    |  5 +++++
 2 files changed, 19 insertions(+)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 8fcb8ccee44b..d634b163e913 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -257,6 +257,20 @@ config X86_GENERIC
 	  This is really intended for distributors who need more
 	  generic optimizations.
 
+config X86_64_NATIVE
+	bool "Build with -march=native optimization"
+	depends on X86_64
+	help
+	  Make it possible to have a slightly better optimized kernel for
+	  the machine it is built on, by passing -march=native instead
+	  the more generic -march=x86-64 option.  This lets compilers
+	  use extensions to the x86-64 instruction set that were not
+	  present in the original AMD Opteron and Intel Pentium4 CPUs,
+	  and schedule instructions for the pipeline model.
+
+	  Select this option only when building a kernel to run locally,
+	  as it may be incompatible with any other processor.
+
 #
 # Define implied options from the CPU selection here
 config X86_INTERNODE_CACHE_SHIFT
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 8120085b00a4..bf45b84c138f 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -178,8 +178,13 @@ else
 	# Use -mskip-rax-setup if supported.
 	KBUILD_CFLAGS += $(call cc-option,-mskip-rax-setup)
 
+ifdef CONFIG_X86_64_NATIVE
+        KBUILD_CFLAGS += -march=native
+        KBUILD_RUSTFLAGS += -Ctarget-cpu=native
+else
         KBUILD_CFLAGS += -march=x86-64 -mtune=generic
         KBUILD_RUSTFLAGS += -Ctarget-cpu=x86-64 -Ztune-cpu=generic
+endif
 
         KBUILD_CFLAGS += -mno-red-zone
         KBUILD_CFLAGS += -mcmodel=kernel
-- 
2.39.5



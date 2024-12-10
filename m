Return-Path: <linux-kernel+bounces-439783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 608879EB3EC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F352928465D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B376B1BD9CA;
	Tue, 10 Dec 2024 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9nDsqw9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2D31BD51F
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733842204; cv=none; b=Y5xwO7VJllMJEp0JVNFQZrdeheLH8EBW4U2ziM2bvFEg/c7uDlMdq6W4T94qHpt0j46Rt5FOpwQiQNz3rSJAaNnce6MeHeZkUE2foHSrsanbGi0dhWl7kz3/x9g1JVa9u0/0A9jHj24LFBjbsZC/imXLgcF5YlXlKA5r7wVKI8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733842204; c=relaxed/simple;
	bh=RaOxny5lKPwI/fcP9pPId4nMHRz9abskR9v27E849o0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KVw8N34trmE2YYKS2BU7iZ1LOIMK+mQVXxPl+CAf4N8KIaGTSdu0WaBarJaTjcj4DL2ERGcV6RjIg+hjfvZNb1ctB7Mr3uT79La8IDzAjqRAVIOsLMsZiU521mLTooHlSTnA9vGJ990lLTMw94oxVC+GfHVeWHwc7DzVM9NAJqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9nDsqw9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394E9C4CEE1;
	Tue, 10 Dec 2024 14:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733842203;
	bh=RaOxny5lKPwI/fcP9pPId4nMHRz9abskR9v27E849o0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M9nDsqw92viA22YuGSYIthVeSsFjHA44oYRuCeW6/iVRd7gUJynkPxkevkM5bHk0r
	 pgs2OFjp3NIcRH10TiRCqkDvDLtX44PL5BF0ZvNH5HaJNtk8yvOOsDlP3NdKcmZxw3
	 1jrZ8Ma2ZhDGPxT1YFWtqKX2/ADZbXDA7Ezs8o/TtfNsnFgHU78VJ9+k8r5ZqVM2mf
	 TwoKiIJvUKUQBs+oZ4KfEHzn+CxYi066w8G2VRzgXwUoRKnMWbYS7r9sfhYwOcZyQC
	 +SgUXKIVa52AozXWTOi2r2DJ8CHkpX7ErG7KJjV3m+vb+K3q0CJkp4t6chbxvR/cZD
	 E+su1N+1BpCiA==
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
Subject: [PATCH v2 03/11] x86: rework CONFIG_GENERIC_CPU compiler flags
Date: Tue, 10 Dec 2024 15:49:37 +0100
Message-Id: <20241210144945.2325330-4-arnd@kernel.org>
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

Building an x86-64 kernel with CONFIG_GENERIC_CPU is documented to
run on all CPUs, but the Makefile does not actually pass an -march=
argument, instead relying on the default that was used to configure
the toolchain.

In many cases, gcc will be configured to -march=x86-64 or -march=k8
for maximum compatibility, but in other cases a distribution default
may be either raised to a more recent ISA, or set to -march=native
to build for the CPU used for compilation. This still works in the
case of building a custom kernel for the local machine.

The point where it breaks down is building a kernel for another
machine that is older the the default target. Changing the default
to -march=x86-64 would make it work reliable, but possibly produce
worse code on distros that intentionally default to a newer ISA.

To allow reliably building a kernel for either the oldest x86-64
CPUs, pass the -march=x86-64 flag to the compiler. This was not
possible in early versions of x86-64 gcc, but works on all currently
supported versions down to at least gcc-5.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 5b773b34768d..5af3172fd51c 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -183,14 +183,14 @@ else
         cflags-$(CONFIG_MPSC)		+= -march=nocona
         cflags-$(CONFIG_MCORE2)		+= -march=core2
         cflags-$(CONFIG_MATOM)		+= -march=atom
-        cflags-$(CONFIG_GENERIC_CPU)	+= -mtune=generic
+        cflags-$(CONFIG_GENERIC_CPU)	+= -march=x86-64 -mtune=generic
         KBUILD_CFLAGS += $(cflags-y)
 
         rustflags-$(CONFIG_MK8)		+= -Ctarget-cpu=k8
         rustflags-$(CONFIG_MPSC)	+= -Ctarget-cpu=nocona
         rustflags-$(CONFIG_MCORE2)	+= -Ctarget-cpu=core2
         rustflags-$(CONFIG_MATOM)	+= -Ctarget-cpu=atom
-        rustflags-$(CONFIG_GENERIC_CPU)	+= -Ztune-cpu=generic
+        rustflags-$(CONFIG_GENERIC_CPU)	+= -Ctarget-cpu=x86-64 -Ztune-cpu=generic
         KBUILD_RUSTFLAGS += $(rustflags-y)
 
         KBUILD_CFLAGS += -mno-red-zone
-- 
2.39.5



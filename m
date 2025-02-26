Return-Path: <linux-kernel+bounces-534989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 118EFA46D9D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4820A16A7D2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F3B25E470;
	Wed, 26 Feb 2025 21:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPqlmb5O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81BF25E44D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740605862; cv=none; b=XW3XwBZu5t0QTfWMCbFP3zPOnSK6esZQGC2Rwdcg893mfwNj7tE07E1efZaMI7XPv2RpQi77M8XhCD7mcsglYH9WETNCBK+othPoC78c2p5pSfjaOvDrBGPRZK84v+FxXRfBP+RHW6uhK2MsYsvfoMMPtKwVtCbgVTVB4WIanDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740605862; c=relaxed/simple;
	bh=RaOxny5lKPwI/fcP9pPId4nMHRz9abskR9v27E849o0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X6c2T9zQWLZuKdTPla16IStQ08ZGak990FyNCszQs5i3mlt9cXNG3vRas0kVemsIRFhtYPI7GGxRbSrefInN3uobRQbUqgTpv1uOqFGsrXYI8tlHLf/bbwpDlIok0JKUb0y5FH/2AcgKPKXKkYRpGyj608stgy+AKchgbPDdhDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPqlmb5O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F841C4CEE7;
	Wed, 26 Feb 2025 21:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740605862;
	bh=RaOxny5lKPwI/fcP9pPId4nMHRz9abskR9v27E849o0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DPqlmb5Ov4QvzzT94sMlm6XJr3zvIyGmtGgPZGAAwlH45fIi7Jf7e+Q7SlmeqOCgu
	 8Njdzr4sMmgfrqKOLpjPo169U+dgi4T4nL91zFZkuNzGXBxy83x92ZkRneYiwLp+9H
	 GOmneWRVCSsQW0ruPxPi5/JhgYseEeBnF4mfWFuxM2G+NkK3ihEa1e2zFcFkHKnvtr
	 n5xcJ5gDw+9oPDWBRYmJPKoghlhFEAJzZR6agxFFc14xTGe5JQZ3/ztcECREOua1MP
	 XoddDnxa9MQSiuklka1agypZdiZW1i895PkLH2ahEzHVMweUjnVIIhY6fqKT39nvn4
	 kbzPGBuL8AUOQ==
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
Subject: [PATCH v3 03/10] x86: rework CONFIG_GENERIC_CPU compiler flags
Date: Wed, 26 Feb 2025 22:37:07 +0100
Message-Id: <20250226213714.4040853-4-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226213714.4040853-1-arnd@kernel.org>
References: <20250226213714.4040853-1-arnd@kernel.org>
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



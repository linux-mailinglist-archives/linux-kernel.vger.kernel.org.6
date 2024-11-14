Return-Path: <linux-kernel+bounces-409306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C1A9C8B36
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 632F5B2A9F8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541E91FB754;
	Thu, 14 Nov 2024 12:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="rXaVeZnH"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6D51FAF1F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 12:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731588690; cv=none; b=MAPPtQFFoJtkPTnbOXa+lL1yHX5TRzXQqlV1D1U7mFqpq+vvbgiUjeQvVnaAeuq/u1nqRuHLhmf9KWbhTAUC0CIgWUJdpWswj5dA9bLDxxK6kwuAa+5aTdHtGCMDJJC4PSexZCUsmKzoSI+88FUXL4QB/l3KdT1Vt4DUwd+l+pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731588690; c=relaxed/simple;
	bh=wjmru2cIkMZm+QKvyVsJ/fzW1s1N8Ag8KGm35NrtlEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQ8kAXTtwkJZys+mfGP90qmg9ABuw4h2I+qPRRTOEGwoJZ/yhARZRR9xWOf4EDaelN+6q8MODwL52JqyY5VU/BgxrhOfJTfR5a/3p6sQgP1+R8kTwQo8hb896CRq/DI2sJ9d5mRg3bDZM7r31cRjbWR1Rd66EWbJLW0z5E8CEPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=rXaVeZnH; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731588682;
	bh=/VdgiLXZkCk0NyWSjjVFCKnQ+lQL3LyTfm/Yzm9iiTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rXaVeZnH/Uo5tOtSAp1Uiv1lcLXAVLk556SYhUJ3kWuKWrvvUtzu0rCkRpm6QZNlq
	 8fQnatzyYEgnQDFq4Q2WnAwryPy80Is0Nli/Qcl02UjJ3TqSCcTxauJ67hNE43YWeA
	 JxoE46n0gS86Iw03i7n5SqYvPAkzRdF+rCgrtbwBXiKB886trtbE6WCeKozrnnyy3I
	 dLX6SEytbSa4206xTL3xRCvznML9rknpOIQahAbhI8aUvrl3zumAOzFBQreFRsA/43
	 A6O+mm3YtqEUodaP/Rifuu7Hlx5YceuwJ+ahDntKGrOwvgNpL9nW9SMBoO9dM2y1ZS
	 Uzc4Ai4G/b7rw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xq0QL4SC0z4xSy;
	Thu, 14 Nov 2024 23:51:22 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: <linux-kernel@vger.kernel.org>,
	<jk@ozlabs.org>,
	<arnd@arndb.de>,
	<geoff@infradead.org>
Subject: [RFC PATCH 12/20] powerpc/io: Unhook MMIO accessors
Date: Thu, 14 Nov 2024 23:51:01 +1100
Message-ID: <20241114125111.599093-12-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114125111.599093-1-mpe@ellerman.id.au>
References: <20241114125111.599093-1-mpe@ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that PPC_INDIRECT_MMIO is removed, it's not possible/necessary
to hook any of the "memory" accessors, so turn them back into regular
static inlines, and restrict the hooking mechanism to the "pio"
accessors only.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/io-defs.h |  70 +++------------
 arch/powerpc/include/asm/io.h      | 135 ++++++++++++++++++++++++++---
 2 files changed, 137 insertions(+), 68 deletions(-)

diff --git a/arch/powerpc/include/asm/io-defs.h b/arch/powerpc/include/asm/io-defs.h
index faf8617cc574..5c2be9b54a9d 100644
--- a/arch/powerpc/include/asm/io-defs.h
+++ b/arch/powerpc/include/asm/io-defs.h
@@ -1,61 +1,15 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* This file is meant to be include multiple times by other headers */
-/* last 2 argments are used by platforms/cell/io-workarounds.[ch] */
 
-DEF_PCI_AC_RET(readb, u8, (const PCI_IO_ADDR addr), (addr), mem, addr)
-DEF_PCI_AC_RET(readw, u16, (const PCI_IO_ADDR addr), (addr), mem, addr)
-DEF_PCI_AC_RET(readl, u32, (const PCI_IO_ADDR addr), (addr), mem, addr)
-DEF_PCI_AC_RET(readw_be, u16, (const PCI_IO_ADDR addr), (addr), mem, addr)
-DEF_PCI_AC_RET(readl_be, u32, (const PCI_IO_ADDR addr), (addr), mem, addr)
-DEF_PCI_AC_NORET(writeb, (u8 val, PCI_IO_ADDR addr), (val, addr), mem, addr)
-DEF_PCI_AC_NORET(writew, (u16 val, PCI_IO_ADDR addr), (val, addr), mem, addr)
-DEF_PCI_AC_NORET(writel, (u32 val, PCI_IO_ADDR addr), (val, addr), mem, addr)
-DEF_PCI_AC_NORET(writew_be, (u16 val, PCI_IO_ADDR addr), (val, addr), mem, addr)
-DEF_PCI_AC_NORET(writel_be, (u32 val, PCI_IO_ADDR addr), (val, addr), mem, addr)
-
-#ifdef __powerpc64__
-DEF_PCI_AC_RET(readq, u64, (const PCI_IO_ADDR addr), (addr), mem, addr)
-DEF_PCI_AC_RET(readq_be, u64, (const PCI_IO_ADDR addr), (addr), mem, addr)
-DEF_PCI_AC_NORET(writeq, (u64 val, PCI_IO_ADDR addr), (val, addr), mem, addr)
-DEF_PCI_AC_NORET(writeq_be, (u64 val, PCI_IO_ADDR addr), (val, addr), mem, addr)
-#endif /* __powerpc64__ */
-
-DEF_PCI_AC_RET(inb, u8, (unsigned long port), (port), pio, port)
-DEF_PCI_AC_RET(inw, u16, (unsigned long port), (port), pio, port)
-DEF_PCI_AC_RET(inl, u32, (unsigned long port), (port), pio, port)
-DEF_PCI_AC_NORET(outb, (u8 val, unsigned long port), (val, port), pio, port)
-DEF_PCI_AC_NORET(outw, (u16 val, unsigned long port), (val, port), pio, port)
-DEF_PCI_AC_NORET(outl, (u32 val, unsigned long port), (val, port), pio, port)
-
-DEF_PCI_AC_NORET(readsb, (const PCI_IO_ADDR a, void *b, unsigned long c),
-		 (a, b, c), mem, a)
-DEF_PCI_AC_NORET(readsw, (const PCI_IO_ADDR a, void *b, unsigned long c),
-		 (a, b, c), mem, a)
-DEF_PCI_AC_NORET(readsl, (const PCI_IO_ADDR a, void *b, unsigned long c),
-		 (a, b, c), mem, a)
-DEF_PCI_AC_NORET(writesb, (PCI_IO_ADDR a, const void *b, unsigned long c),
-		 (a, b, c), mem, a)
-DEF_PCI_AC_NORET(writesw, (PCI_IO_ADDR a, const void *b, unsigned long c),
-		 (a, b, c), mem, a)
-DEF_PCI_AC_NORET(writesl, (PCI_IO_ADDR a, const void *b, unsigned long c),
-		 (a, b, c), mem, a)
-
-DEF_PCI_AC_NORET(insb, (unsigned long p, void *b, unsigned long c),
-		 (p, b, c), pio, p)
-DEF_PCI_AC_NORET(insw, (unsigned long p, void *b, unsigned long c),
-		 (p, b, c), pio, p)
-DEF_PCI_AC_NORET(insl, (unsigned long p, void *b, unsigned long c),
-		 (p, b, c), pio, p)
-DEF_PCI_AC_NORET(outsb, (unsigned long p, const void *b, unsigned long c),
-		 (p, b, c), pio, p)
-DEF_PCI_AC_NORET(outsw, (unsigned long p, const void *b, unsigned long c),
-		 (p, b, c), pio, p)
-DEF_PCI_AC_NORET(outsl, (unsigned long p, const void *b, unsigned long c),
-		 (p, b, c), pio, p)
-
-DEF_PCI_AC_NORET(memset_io, (PCI_IO_ADDR a, int c, unsigned long n),
-		 (a, c, n), mem, a)
-DEF_PCI_AC_NORET(memcpy_fromio, (void *d, const PCI_IO_ADDR s, unsigned long n),
-		 (d, s, n), mem, s)
-DEF_PCI_AC_NORET(memcpy_toio, (PCI_IO_ADDR d, const void *s, unsigned long n),
-		 (d, s, n), mem, d)
+DEF_PCI_AC_RET(inb, u8, (unsigned long port), (port))
+DEF_PCI_AC_RET(inw, u16, (unsigned long port), (port))
+DEF_PCI_AC_RET(inl, u32, (unsigned long port), (port))
+DEF_PCI_AC_NORET(outb, (u8 val, unsigned long port), (val, port))
+DEF_PCI_AC_NORET(outw, (u16 val, unsigned long port), (val, port))
+DEF_PCI_AC_NORET(outl, (u32 val, unsigned long port), (val, port))
+DEF_PCI_AC_NORET(insb, (unsigned long p, void *b, unsigned long c), (p, b, c))
+DEF_PCI_AC_NORET(insw, (unsigned long p, void *b, unsigned long c), (p, b, c))
+DEF_PCI_AC_NORET(insl, (unsigned long p, void *b, unsigned long c), (p, b, c))
+DEF_PCI_AC_NORET(outsb, (unsigned long p, const void *b, unsigned long c), (p, b, c))
+DEF_PCI_AC_NORET(outsw, (unsigned long p, const void *b, unsigned long c), (p, b, c))
+DEF_PCI_AC_NORET(outsl, (unsigned long p, const void *b, unsigned long c), (p, b, c))
diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index ecc0dff82dc6..faf868715eb5 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -580,19 +580,134 @@ __do_out_asm(_rec_outl, "stwbrx")
 				_memcpy_fromio(dst, src, n)
 #endif /* !CONFIG_EEH */
 
+static inline u8 readb(const PCI_IO_ADDR addr)
+{
+	return __do_readb(addr);
+}
+
+static inline u16 readw(const PCI_IO_ADDR addr)
+{
+	return __do_readw(addr);
+}
+
+static inline u32 readl(const PCI_IO_ADDR addr)
+{
+	return __do_readl(addr);
+}
+
+static inline u16 readw_be(const PCI_IO_ADDR addr)
+{
+	return __do_readw_be(addr);
+}
+
+static inline u32 readl_be(const PCI_IO_ADDR addr)
+{
+	return __do_readl_be(addr);
+}
+
+static inline void writeb(u8 val, PCI_IO_ADDR addr)
+{
+	__do_writeb(val, addr);
+}
+
+static inline void writew(u16 val, PCI_IO_ADDR addr)
+{
+	__do_writew(val, addr);
+}
+
+static inline void writel(u32 val, PCI_IO_ADDR addr)
+{
+	__do_writel(val, addr);
+}
+
+static inline void writew_be(u16 val, PCI_IO_ADDR addr)
+{
+	__do_writew_be(val, addr);
+}
+
+static inline void writel_be(u32 val, PCI_IO_ADDR addr)
+{
+	__do_writel_be(val, addr);
+}
+
+static inline void readsb(const PCI_IO_ADDR a, void *b, unsigned long c)
+{
+	__do_readsb(a, b, c);
+}
+
+static inline void readsw(const PCI_IO_ADDR a, void *b, unsigned long c)
+{
+	__do_readsw(a, b, c);
+}
+
+static inline void readsl(const PCI_IO_ADDR a, void *b, unsigned long c)
+{
+	__do_readsl(a, b, c);
+}
+
+static inline void writesb(PCI_IO_ADDR a, const void *b, unsigned long c)
+{
+	__do_writesb(a, b, c);
+}
+
+static inline void writesw(PCI_IO_ADDR a, const void *b, unsigned long c)
+{
+	__do_writesw(a, b, c);
+}
+
+static inline void writesl(PCI_IO_ADDR a, const void *b, unsigned long c)
+{
+	__do_writesl(a, b, c);
+}
+
+static inline void memset_io(PCI_IO_ADDR a, int c, unsigned long n)
+{
+	__do_memset_io(a, c, n);
+}
+
+static inline void memcpy_fromio(void *d, const PCI_IO_ADDR s, unsigned long n)
+{
+	__do_memcpy_fromio(d, s, n);
+}
+
+static inline void memcpy_toio(PCI_IO_ADDR d, const void *s, unsigned long n)
+{
+	__do_memcpy_toio(d, s, n);
+}
+
+#ifdef __powerpc64__
+static inline u64 readq(const PCI_IO_ADDR addr)
+{
+	return __do_readq(addr);
+}
+
+static inline u64 readq_be(const PCI_IO_ADDR addr)
+{
+	return __do_readq_be(addr);
+}
+
+static inline void writeq(u64 val, PCI_IO_ADDR addr)
+{
+	__do_writeq(val, addr);
+}
+
+static inline void writeq_be(u64 val, PCI_IO_ADDR addr)
+{
+	__do_writeq_be(val, addr);
+}
+#endif /* __powerpc64__ */
+
 #ifdef CONFIG_PPC_INDIRECT_PIO
-#define DEF_PCI_HOOK_pio(x)	x
+#define DEF_PCI_HOOK(x)	x
 #else
-#define DEF_PCI_HOOK_pio(x)	NULL
+#define DEF_PCI_HOOK(x)	NULL
 #endif
 
-#define DEF_PCI_HOOK_mem(x)	NULL
-
 /* Structure containing all the hooks */
 extern struct ppc_pci_io {
 
-#define DEF_PCI_AC_RET(name, ret, at, al, space, aa)	ret (*name) at;
-#define DEF_PCI_AC_NORET(name, at, al, space, aa)	void (*name) at;
+#define DEF_PCI_AC_RET(name, ret, at, al)	ret (*name) at;
+#define DEF_PCI_AC_NORET(name, at, al)		void (*name) at;
 
 #include <asm/io-defs.h>
 
@@ -602,18 +717,18 @@ extern struct ppc_pci_io {
 } ppc_pci_io;
 
 /* The inline wrappers */
-#define DEF_PCI_AC_RET(name, ret, at, al, space, aa)		\
+#define DEF_PCI_AC_RET(name, ret, at, al)			\
 static inline ret name at					\
 {								\
-	if (DEF_PCI_HOOK_##space(ppc_pci_io.name) != NULL)	\
+	if (DEF_PCI_HOOK(ppc_pci_io.name) != NULL)		\
 		return ppc_pci_io.name al;			\
 	return __do_##name al;					\
 }
 
-#define DEF_PCI_AC_NORET(name, at, al, space, aa)		\
+#define DEF_PCI_AC_NORET(name, at, al)		\
 static inline void name at					\
 {								\
-	if (DEF_PCI_HOOK_##space(ppc_pci_io.name) != NULL)		\
+	if (DEF_PCI_HOOK(ppc_pci_io.name) != NULL)		\
 		ppc_pci_io.name al;				\
 	else							\
 		__do_##name al;					\
-- 
2.47.0



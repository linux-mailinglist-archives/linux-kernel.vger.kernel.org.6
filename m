Return-Path: <linux-kernel+bounces-342133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F33AC988AEB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 21:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2139B1C22FCA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 19:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B991C3318;
	Fri, 27 Sep 2024 19:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TukinRj6"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9AD1C231F
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 19:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727466656; cv=none; b=PXsVDCm+busvqZ4Oo+IIxc4/qga78Eyb6PL4ZSsV7sZ4HhMbfDfoH8v4gQfEOcKo3wfowvT4eLcBWeuHWurck4B4qcwykRyrgHO3B0qhOi4V5EeCnIBXHzyhmQmj6j8Lf4fw/t8nKRlDH2ldk6YFWTm7e2/KTVsghWHpkpxt0a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727466656; c=relaxed/simple;
	bh=5uvF95TgyiLT6G2jUE9sdhJmR7W94HYAXCCl/2TomHA=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ID8U/ph5kznopZx75ZclZ5litAGAolU7DRifgeyAtopg2/4hH59+or3CiRUso+PXYFhjdloF5Q5TnG2J6pciiXA0GuvzhIDg5lgQ5nAoviCGJpuYvu1aKTFzZ6dVhqk9jmaXV7BkP/I2WGrmBqmRtu58AXyLDmwsrBr19sJuZGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TukinRj6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=2mwu19/OYEXX9hX1sQCEguvJJl/pwlDcYstsYT0uFu8=; b=TukinRj6T4fYMAE5hSrgZIorfx
	RvO6hF+dYbk7EVXrvjOQwA36ex+7V0HinnmTGTyqOu4zZdCbcImrJfAdBh88gDAAWZPTUsh5E6V1y
	nR3Av6gIsvPoZxQt4JQkf2hJpXKkTEF49qXh0UaGHJhPk3z2FFSPWtdNtERNPzVgtDlZcwJAxcTH2
	vJeIz7K74zY3LQW9sK7GQSZGppGLWpqrKd4acvdB5mMp5rWVbdAZN3svDeD8Os7vFLl04u/+HxX9H
	S3nw61JZVuXmpN35IdmKIOMpwf0n0Du1h5rdKElTrAXM+boCtIyAryuqnmp1djhi2iwgt3Yt2cM0E
	ionBptYg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1suGzG-0000000AVcw-3FDP;
	Fri, 27 Sep 2024 19:50:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id CE635308CBD; Fri, 27 Sep 2024 21:50:44 +0200 (CEST)
Message-Id: <20240927194925.389465951@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 27 Sep 2024 21:49:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 alyssa.milburn@intel.com,
 scott.d.constable@intel.com,
 joao@overdrivepizza.com,
 andrew.cooper3@citrix.com,
 jpoimboe@kernel.org,
 jose.marchesi@oracle.com,
 hjl.tools@gmail.com,
 ndesaulniers@google.com,
 samitolvanen@google.com,
 nathan@kernel.org,
 ojeda@kernel.org,
 kees@kernel.org,
 alexei.starovoitov@gmail.com
Subject: [PATCH 10/14] x86/early_printk: Harden early_serial
References: <20240927194856.096003183@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Scott found that mem32_serial_in() is an ideal speculation gadget, an
indirectly callable function that takes an adddress and offset and
immediately does a load.

Use static_call() to take away the need for indirect calls and
explicitly seal the functions to ensure they're not callable on IBT
enabled parts.

Reported-by: Scott Constable <scott.d.constable@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/early_printk.c |   51 ++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

--- a/arch/x86/kernel/early_printk.c
+++ b/arch/x86/kernel/early_printk.c
@@ -19,6 +19,7 @@
 #include <linux/usb/ehci_def.h>
 #include <linux/usb/xhci-dbgp.h>
 #include <asm/pci_x86.h>
+#include <linux/static_call.h>
 
 /* Simple VGA output */
 #define VGABASE		(__ISA_IO_base + 0xb8000)
@@ -94,26 +95,28 @@ static unsigned long early_serial_base =
 #define DLL             0       /*  Divisor Latch Low         */
 #define DLH             1       /*  Divisor latch High        */
 
-static unsigned int io_serial_in(unsigned long addr, int offset)
+static __noendbr unsigned int io_serial_in(unsigned long addr, int offset)
 {
 	return inb(addr + offset);
 }
+NOENDBR_SYMBOL(io_serial_in);
 
-static void io_serial_out(unsigned long addr, int offset, int value)
+static __noendbr void io_serial_out(unsigned long addr, int offset, int value)
 {
 	outb(value, addr + offset);
 }
+NOENDBR_SYMBOL(io_serial_out);
 
-static unsigned int (*serial_in)(unsigned long addr, int offset) = io_serial_in;
-static void (*serial_out)(unsigned long addr, int offset, int value) = io_serial_out;
+DEFINE_STATIC_CALL(serial_in, io_serial_in);
+DEFINE_STATIC_CALL(serial_out, io_serial_out);
 
 static int early_serial_putc(unsigned char ch)
 {
 	unsigned timeout = 0xffff;
 
-	while ((serial_in(early_serial_base, LSR) & XMTRDY) == 0 && --timeout)
+	while ((static_call(serial_in)(early_serial_base, LSR) & XMTRDY) == 0 && --timeout)
 		cpu_relax();
-	serial_out(early_serial_base, TXR, ch);
+	static_call(serial_out)(early_serial_base, TXR, ch);
 	return timeout ? 0 : -1;
 }
 
@@ -131,16 +134,16 @@ static __init void early_serial_hw_init(
 {
 	unsigned char c;
 
-	serial_out(early_serial_base, LCR, 0x3);	/* 8n1 */
-	serial_out(early_serial_base, IER, 0);	/* no interrupt */
-	serial_out(early_serial_base, FCR, 0);	/* no fifo */
-	serial_out(early_serial_base, MCR, 0x3);	/* DTR + RTS */
-
-	c = serial_in(early_serial_base, LCR);
-	serial_out(early_serial_base, LCR, c | DLAB);
-	serial_out(early_serial_base, DLL, divisor & 0xff);
-	serial_out(early_serial_base, DLH, (divisor >> 8) & 0xff);
-	serial_out(early_serial_base, LCR, c & ~DLAB);
+	static_call(serial_out)(early_serial_base, LCR, 0x3);	/* 8n1 */
+	static_call(serial_out)(early_serial_base, IER, 0);	/* no interrupt */
+	static_call(serial_out)(early_serial_base, FCR, 0);	/* no fifo */
+	static_call(serial_out)(early_serial_base, MCR, 0x3);	/* DTR + RTS */
+
+	c = static_call(serial_in)(early_serial_base, LCR);
+	static_call(serial_out)(early_serial_base, LCR, c | DLAB);
+	static_call(serial_out)(early_serial_base, DLL, divisor & 0xff);
+	static_call(serial_out)(early_serial_base, DLH, (divisor >> 8) & 0xff);
+	static_call(serial_out)(early_serial_base, LCR, c & ~DLAB);
 }
 
 #define DEFAULT_BAUD 9600
@@ -183,28 +186,26 @@ static __init void early_serial_init(cha
 	/* Convert from baud to divisor value */
 	divisor = 115200 / baud;
 
-	/* These will always be IO based ports */
-	serial_in = io_serial_in;
-	serial_out = io_serial_out;
-
 	/* Set up the HW */
 	early_serial_hw_init(divisor);
 }
 
 #ifdef CONFIG_PCI
-static void mem32_serial_out(unsigned long addr, int offset, int value)
+static __noendbr void mem32_serial_out(unsigned long addr, int offset, int value)
 {
 	u32 __iomem *vaddr = (u32 __iomem *)addr;
 	/* shift implied by pointer type */
 	writel(value, vaddr + offset);
 }
+NOENDBR_SYMBOL(mem32_serial_out);
 
-static unsigned int mem32_serial_in(unsigned long addr, int offset)
+static __noendbr unsigned int mem32_serial_in(unsigned long addr, int offset)
 {
 	u32 __iomem *vaddr = (u32 __iomem *)addr;
 	/* shift implied by pointer type */
 	return readl(vaddr + offset);
 }
+NOENDBR_SYMBOL(mem32_serial_in);
 
 /*
  * early_pci_serial_init()
@@ -278,15 +279,13 @@ static __init void early_pci_serial_init
 	 */
 	if ((bar0 & PCI_BASE_ADDRESS_SPACE) == PCI_BASE_ADDRESS_SPACE_IO) {
 		/* it is IO mapped */
-		serial_in = io_serial_in;
-		serial_out = io_serial_out;
 		early_serial_base = bar0 & PCI_BASE_ADDRESS_IO_MASK;
 		write_pci_config(bus, slot, func, PCI_COMMAND,
 				 cmdreg|PCI_COMMAND_IO);
 	} else {
 		/* It is memory mapped - assume 32-bit alignment */
-		serial_in = mem32_serial_in;
-		serial_out = mem32_serial_out;
+		static_call_update(serial_in, mem32_serial_in);
+		static_call_update(serial_out, mem32_serial_out);
 		/* WARNING! assuming the address is always in the first 4G */
 		early_serial_base =
 			(unsigned long)early_ioremap(bar0 & PCI_BASE_ADDRESS_MEM_MASK, 0x10);




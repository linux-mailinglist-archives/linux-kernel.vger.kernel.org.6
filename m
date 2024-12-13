Return-Path: <linux-kernel+bounces-444343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B61999F050E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 07:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7C47188ABDE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 06:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C74518E056;
	Fri, 13 Dec 2024 06:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="br+Jf2Zq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FD5185B56;
	Fri, 13 Dec 2024 06:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734072622; cv=none; b=qXvQrWFrKmwdI582fHR0dQbDPMiI+QF7cEvXtajJHTNqrp/8ZyAsEPBzEYn3W6broBUuep+yZMcR666Sc5QWv18GcOdXSQCDB7QhMwr/Jj9AvnVtcMkUfuoHX1E38obe9RPuSQsc9twMMvr4C1MSElxUSHoL0WlP/QKZOsp+Uqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734072622; c=relaxed/simple;
	bh=dY7JqUVQ+3bfcFjoGx3pIElgbHFkXyDq44SgfO1qn8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=peooplMa/dv0O5gqZ9QHar2ulJns3KOqJSJwU3W3oaTW53sCFOxTzH8nQvX14YaWabve3Vox6VmMiRxyLQllOv9Q3JgRJHS4R20VLa30FPml1NJUhqPtQudYd5UI9TVLaFbiCK6PuZstGkgEWxuOdL2zWBLqAHWQIgiZc/gvwOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=br+Jf2Zq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64DF7C4CED1;
	Fri, 13 Dec 2024 06:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734072622;
	bh=dY7JqUVQ+3bfcFjoGx3pIElgbHFkXyDq44SgfO1qn8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=br+Jf2ZqRgX+uOiXhtfb2p4slLxGOFYseHB0Vd4kJDz1tjbbIaXm8vdnfz1Xm0ISi
	 xuOA/oW3S5mg2ZWbSASDc3r9q1lKmtMtGWg+v0AQpNMU082qwoo8X1La6EaXKAKXiC
	 5z7C6mp4/s95fto1bZsI6r0zf20AeLO4VMB3/rAPTsChl+DIJRtwFvbC1RHLGvNslV
	 XJxeS51HHXKWox8+jr/QAO9essoNZnbexRq7n0wSKKZUFLjsIuF9AswcSqJxIewVRT
	 hFTAEuUr6vrN1cnFzuuNH7qQLk/k6mWh4t6CNCgllC6RPtkdUSH4BIWdKWKKHnjg8N
	 yMUL1xqkO5Kmw==
From: Arnd Bergmann <arnd@kernel.org>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Omer Faruk BULUT <m.omerfarukbulut@gmail.com>,
	Rohit Chavan <roheetchavan@gmail.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] staging: gpib: use ioport_map
Date: Fri, 13 Dec 2024 07:49:50 +0100
Message-Id: <20241213064959.1045243-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241213064959.1045243-1-arnd@kernel.org>
References: <20241213064959.1045243-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The tnt4882 backend has a rather elabolate way of abstracting the
PIO and MMIO based hardware variants, duplicating the functionality
of ioport_map() in a less portable way.

Change it to use ioport_map() with ioread8()/iowrite8() to do
this more easily.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/gpib/Kconfig                |  1 +
 drivers/staging/gpib/common/gpib_os.c       | 50 ---------------------
 drivers/staging/gpib/include/gpibP.h        | 12 +----
 drivers/staging/gpib/tnt4882/tnt4882_gpib.c | 49 +++++++++-----------
 4 files changed, 23 insertions(+), 89 deletions(-)

diff --git a/drivers/staging/gpib/Kconfig b/drivers/staging/gpib/Kconfig
index 275dbc32b28d..81510db3072e 100644
--- a/drivers/staging/gpib/Kconfig
+++ b/drivers/staging/gpib/Kconfig
@@ -66,6 +66,7 @@ config GPIB_NI_PCI_ISA
 	depends on HAS_IOPORT
 	depends on !X86_PAE
 	depends on PCMCIA || !PCMCIA
+	depends on HAS_IOPORT_MAP
 	select GPIB_COMMON
 	select GPIB_NEC7210
 	help
diff --git a/drivers/staging/gpib/common/gpib_os.c b/drivers/staging/gpib/common/gpib_os.c
index 405237d8cb47..50fc341eee96 100644
--- a/drivers/staging/gpib/common/gpib_os.c
+++ b/drivers/staging/gpib/common/gpib_os.c
@@ -116,56 +116,6 @@ int io_timed_out(gpib_board_t *board)
 	return 0;
 }
 
-void writeb_wrapper(unsigned int value, void *address)
-{
-	writeb(value, address);
-};
-EXPORT_SYMBOL(writeb_wrapper);
-
-void writew_wrapper(unsigned int value, void *address)
-{
-	writew(value, address);
-};
-EXPORT_SYMBOL(writew_wrapper);
-
-unsigned int readb_wrapper(void *address)
-{
-	return readb(address);
-};
-EXPORT_SYMBOL(readb_wrapper);
-
-unsigned int readw_wrapper(void *address)
-{
-	return readw(address);
-};
-EXPORT_SYMBOL(readw_wrapper);
-
-#ifdef CONFIG_HAS_IOPORT
-void outb_wrapper(unsigned int value, void *address)
-{
-	outb(value, (unsigned long)(address));
-};
-EXPORT_SYMBOL(outb_wrapper);
-
-void outw_wrapper(unsigned int value, void *address)
-{
-	outw(value, (unsigned long)(address));
-};
-EXPORT_SYMBOL(outw_wrapper);
-
-unsigned int inb_wrapper(void *address)
-{
-	return inb((unsigned long)(address));
-};
-EXPORT_SYMBOL(inb_wrapper);
-
-unsigned int inw_wrapper(void *address)
-{
-	return inw((unsigned long)(address));
-};
-EXPORT_SYMBOL(inw_wrapper);
-#endif
-
 /* this is a function instead of a constant because of Suse
  * defining HZ to be a function call to get_hz()
  */
diff --git a/drivers/staging/gpib/include/gpibP.h b/drivers/staging/gpib/include/gpibP.h
index 5fc42b645ab7..b97da577ba33 100644
--- a/drivers/staging/gpib/include/gpibP.h
+++ b/drivers/staging/gpib/include/gpibP.h
@@ -16,6 +16,7 @@
 
 #include <linux/fs.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 
 void gpib_register_driver(gpib_interface_t *interface, struct module *mod);
 void gpib_unregister_driver(gpib_interface_t *interface);
@@ -35,16 +36,5 @@ extern gpib_board_t board_array[GPIB_MAX_NUM_BOARDS];
 
 extern struct list_head registered_drivers;
 
-#include <linux/io.h>
-
-void writeb_wrapper(unsigned int value, void *address);
-unsigned int readb_wrapper(void *address);
-void outb_wrapper(unsigned int value, void *address);
-unsigned int inb_wrapper(void *address);
-void writew_wrapper(unsigned int value, void *address);
-unsigned int readw_wrapper(void *address);
-void outw_wrapper(unsigned int value, void *address);
-unsigned int inw_wrapper(void *address);
-
 #endif	// _GPIB_P_H
 
diff --git a/drivers/staging/gpib/tnt4882/tnt4882_gpib.c b/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
index e49a952fa0d8..408a123e9542 100644
--- a/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
+++ b/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
@@ -45,10 +45,6 @@ struct tnt4882_priv {
 	unsigned short imr0_bits;
 	unsigned short imr3_bits;
 	unsigned short auxg_bits;	// bits written to auxiliary register G
-	void (*io_writeb)(unsigned int value, void *address);
-	void (*io_writew)(unsigned int value, void *address);
-	unsigned int (*io_readb)(void *address);
-	unsigned int (*io_readw)(void *address);
 };
 
 // interface functions
@@ -104,17 +100,17 @@ static const int atgpib_iosize = 32;
 /* paged io */
 static inline unsigned int tnt_paged_readb(struct tnt4882_priv *priv, unsigned long offset)
 {
-	priv->io_writeb(AUX_PAGEIN, priv->nec7210_priv.iobase + AUXMR * priv->nec7210_priv.offset);
+	iowrite8(AUX_PAGEIN, priv->nec7210_priv.iobase + AUXMR * priv->nec7210_priv.offset);
 	udelay(1);
-	return priv->io_readb(priv->nec7210_priv.iobase + offset);
+	return ioread8(priv->nec7210_priv.iobase + offset);
 }
 
 static inline void tnt_paged_writeb(struct tnt4882_priv *priv, unsigned int value,
 				    unsigned long offset)
 {
-	priv->io_writeb(AUX_PAGEIN, priv->nec7210_priv.iobase + AUXMR * priv->nec7210_priv.offset);
+	iowrite8(AUX_PAGEIN, priv->nec7210_priv.iobase + AUXMR * priv->nec7210_priv.offset);
 	udelay(1);
-	priv->io_writeb(value, priv->nec7210_priv.iobase + offset);
+	iowrite8(value, priv->nec7210_priv.iobase + offset);
 }
 
 /* readb/writeb wrappers */
@@ -134,7 +130,7 @@ static inline unsigned short tnt_readb(struct tnt4882_priv *priv, unsigned long
 		switch (priv->nec7210_priv.type) {
 		case TNT4882:
 		case TNT5004:
-			retval = priv->io_readb(address);
+			retval = ioread8(address);
 			break;
 		case NAT4882:
 			retval = tnt_paged_readb(priv, offset - tnt_pagein_offset);
@@ -149,7 +145,7 @@ static inline unsigned short tnt_readb(struct tnt4882_priv *priv, unsigned long
 		}
 		break;
 	default:
-		retval = priv->io_readb(address);
+		retval = ioread8(address);
 		break;
 	}
 	spin_unlock_irqrestore(register_lock, flags);
@@ -170,7 +166,7 @@ static inline void tnt_writeb(struct tnt4882_priv *priv, unsigned short value, u
 		switch (priv->nec7210_priv.type) {
 		case TNT4882:
 		case TNT5004:
-			priv->io_writeb(value, address);
+			iowrite8(value, address);
 			break;
 		case NAT4882:
 			tnt_paged_writeb(priv, value, offset - tnt_pagein_offset);
@@ -183,7 +179,7 @@ static inline void tnt_writeb(struct tnt4882_priv *priv, unsigned short value, u
 		}
 		break;
 	default:
-		priv->io_writeb(value, address);
+		iowrite8(value, address);
 		break;
 	}
 	spin_unlock_irqrestore(register_lock, flags);
@@ -288,7 +284,7 @@ static int drain_fifo_words(struct tnt4882_priv *tnt_priv, uint8_t *buffer, int
 	while (fifo_word_available(tnt_priv) && count + 2 <= num_bytes)	{
 		short word;
 
-		word = tnt_priv->io_readw(nec_priv->iobase + FIFOB);
+		word = ioread16(nec_priv->iobase + FIFOB);
 		buffer[count++] = word & 0xff;
 		buffer[count++] = (word >> 8) & 0xff;
 	}
@@ -573,7 +569,7 @@ static int generic_write(gpib_board_t *board, uint8_t *buffer, size_t length,
 			word = buffer[count++] & 0xff;
 			if (count < length)
 				word |= (buffer[count++] << 8) & 0xff00;
-			tnt_priv->io_writew(word, nec_priv->iobase + FIFOB);
+			iowrite16(word, nec_priv->iobase + FIFOB);
 		}
 //  avoid unnecessary HR_NFF interrupts
 //		tnt_priv->imr3_bits |= HR_NFF;
@@ -1269,10 +1265,6 @@ int ni_pci_attach(gpib_board_t *board, const gpib_board_config_t *config)
 	if (tnt4882_allocate_private(board))
 		return -ENOMEM;
 	tnt_priv = board->private_data;
-	tnt_priv->io_writeb = writeb_wrapper;
-	tnt_priv->io_readb = readb_wrapper;
-	tnt_priv->io_writew = writew_wrapper;
-	tnt_priv->io_readw = readw_wrapper;
 	nec_priv = &tnt_priv->nec7210_priv;
 	nec_priv->type = TNT4882;
 	nec_priv->read_byte = nec7210_locking_iomem_read_byte;
@@ -1408,10 +1400,6 @@ static int ni_isa_attach_common(gpib_board_t *board, const gpib_board_config_t *
 	if (tnt4882_allocate_private(board))
 		return -ENOMEM;
 	tnt_priv = board->private_data;
-	tnt_priv->io_writeb = outb_wrapper;
-	tnt_priv->io_readb = inb_wrapper;
-	tnt_priv->io_writew = outw_wrapper;
-	tnt_priv->io_readw = inw_wrapper;
 	nec_priv = &tnt_priv->nec7210_priv;
 	nec_priv->type = chipset;
 	nec_priv->read_byte = nec7210_locking_ioport_read_byte;
@@ -1438,7 +1426,9 @@ static int ni_isa_attach_common(gpib_board_t *board, const gpib_board_config_t *
 		pr_err("tnt4882: failed to allocate ioports\n");
 		return -1;
 	}
-	nec_priv->iobase = iobase;
+	nec_priv->iobase = ioport_map(iobase, atgpib_iosize);
+	if (!nec_priv->iobase)
+		return -1;
 
 	// get irq
 	if (request_irq(irq, tnt4882_interrupt, isr_flags, "atgpib", board)) {
@@ -1478,6 +1468,8 @@ void ni_isa_detach(gpib_board_t *board)
 			tnt4882_board_reset(tnt_priv, board);
 		if (tnt_priv->irq)
 			free_irq(tnt_priv->irq, board);
+		if (nec_priv->iobase)
+			ioport_unmap(nec_priv->iobase);
 		if (nec_priv->iobase)
 			release_region((unsigned long)(nec_priv->iobase), atgpib_iosize);
 		if (tnt_priv->pnp_dev)
@@ -1817,10 +1809,6 @@ int ni_pcmcia_attach(gpib_board_t *board, const gpib_board_config_t *config)
 	if (tnt4882_allocate_private(board))
 		return -ENOMEM;
 	tnt_priv = board->private_data;
-	tnt_priv->io_writeb = outb_wrapper;
-	tnt_priv->io_readb = inb_wrapper;
-	tnt_priv->io_writew = outw_wrapper;
-	tnt_priv->io_readw = inw_wrapper;
 	nec_priv = &tnt_priv->nec7210_priv;
 	nec_priv->type = TNT4882;
 	nec_priv->read_byte = nec7210_locking_ioport_read_byte;
@@ -1835,7 +1823,10 @@ int ni_pcmcia_attach(gpib_board_t *board, const gpib_board_config_t *config)
 		return -EIO;
 	}
 
-	nec_priv->iobase = (void *)(unsigned long)curr_dev->resource[0]->start;
+	nec_priv->iobase = ioport_map(curr_dev->resource[0]->start,
+					resource_size(curr_dev->resource[0]));
+	if (!nec_priv->iobase)
+		return -1;
 
 	// get irq
 	if (request_irq(curr_dev->irq, tnt4882_interrupt, isr_flags, "tnt4882", board))	{
@@ -1860,6 +1851,8 @@ void ni_pcmcia_detach(gpib_board_t *board)
 		nec_priv = &tnt_priv->nec7210_priv;
 		if (tnt_priv->irq)
 			free_irq(tnt_priv->irq, board);
+		if (nec_priv->iobase)
+			ioport_unmap(nec_priv->iobase);
 		if (nec_priv->iobase) {
 			tnt4882_board_reset(tnt_priv, board);
 			release_region((unsigned long)nec_priv->iobase, pcmcia_gpib_iosize);
-- 
2.39.5



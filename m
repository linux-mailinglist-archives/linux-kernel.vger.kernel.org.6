Return-Path: <linux-kernel+bounces-444344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 359699F0516
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 07:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2152A16688D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 06:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE4318E02A;
	Fri, 13 Dec 2024 06:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmbFEUur"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC7617AE1C;
	Fri, 13 Dec 2024 06:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734072725; cv=none; b=mDEOOdL966AHDCbPVikIA4+gPV5CJtX8l5U7UnUAIstWVc2ByG99oKj+pSfRNa6yflHW47qFPVkbs8PymKDG9nzr18zXWwE0pvaIuEIKSbUO1Cx6WORMdA1xHBSxSGeEhbESSHTQ8RBJv3rWn1KntFBnWGOIhRjg9LIFsuRZyH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734072725; c=relaxed/simple;
	bh=Ehmy0a8ShNE9sI3tZ9b9Jy8tT2gJYvOAfxikpBoSG6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UG7h3kLr0Lu2KaMzuylUfSVkI1VV0sVtYIw4ec/LKz5vK2vC1gKOJE3XT9P+g55tXs35EE2glNXO3Ift3K1VsWvhMU4pnbN9rDfJwAzHvROvh2RtshTXuVEAJOpF4EA0SoxJooWBjxhdIncLVlEMV/1QHi1sxV6ddnDZNQ5VR2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmbFEUur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DD4C4CED0;
	Fri, 13 Dec 2024 06:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734072724;
	bh=Ehmy0a8ShNE9sI3tZ9b9Jy8tT2gJYvOAfxikpBoSG6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CmbFEUurDCMxY04jH7QNi7D+cixGo3i388OLy4d7FngA8ztMmVztaK2lzF9x2hVZB
	 bkY2nwpMwLEOjE46mZbe6aQ8HE6faZ0gL12Y7O/1jkNPkD6kh5LZGuEfxNPuKPTDO0
	 oGzyLU3zlJrzI7fVo4GTnLRG1ZcQbOcdVfYwyh5JE+qD1hzt8XR5bqzB0bLss/jLD6
	 Bu6JgkIG5jgeXxHT4+vTWR//lmnFldxHf/8O7EJiGI0Wa9KHyDz+8aEx4alr+BtWKJ
	 JM1VNPT1YimN9yk9QqTysK1ccyijzd3k/nuFnBibjPF18X6cpfvytsMDjfGtG095gK
	 sYVBBpJw4pPEQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Rohit Chavan <roheetchavan@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Prarit Bhargava <prarit@redhat.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] staging: gpib: fix address space mixup
Date: Fri, 13 Dec 2024 07:49:51 +0100
Message-Id: <20241213064959.1045243-3-arnd@kernel.org>
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

Throughout the gpib drivers, a 'void *' struct member is used in place
of either port numbers or __iomem pointers, which leads to lots of extra
type casts, sparse warnings and less portable code.

Split the struct member in two separate ones with the correct types,
so each driver can pick which one to use.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../gpib/agilent_82350b/agilent_82350b.c      |  4 +-
 drivers/staging/gpib/cb7210/cb7210.c          | 12 ++---
 drivers/staging/gpib/cb7210/cb7210.h          |  4 +-
 drivers/staging/gpib/cec/cec_gpib.c           |  4 +-
 drivers/staging/gpib/common/gpib_os.c         |  2 +-
 drivers/staging/gpib/eastwood/fluke_gpib.c    | 12 ++---
 drivers/staging/gpib/eastwood/fluke_gpib.h    |  4 +-
 drivers/staging/gpib/fmh_gpib/fmh_gpib.c      | 25 +++++-----
 drivers/staging/gpib/fmh_gpib/fmh_gpib.h      |  4 +-
 drivers/staging/gpib/hp_82335/hp82335.c       | 21 +++++----
 drivers/staging/gpib/hp_82341/hp_82341.c      | 16 +++----
 drivers/staging/gpib/include/gpib_types.h     |  3 +-
 drivers/staging/gpib/include/nec7210.h        |  5 +-
 drivers/staging/gpib/include/tms9914.h        |  5 +-
 drivers/staging/gpib/ines/ines.h              |  4 +-
 drivers/staging/gpib/ines/ines_gpib.c         | 22 ++++-----
 .../gpib/lpvo_usb_gpib/lpvo_usb_gpib.c        |  2 +-
 drivers/staging/gpib/nec7210/nec7210.c        | 16 +++----
 drivers/staging/gpib/pc2/pc2_gpib.c           | 16 +++----
 drivers/staging/gpib/tms9914/tms9914.c        |  8 ++--
 drivers/staging/gpib/tnt4882/mite.h           |  4 +-
 drivers/staging/gpib/tnt4882/tnt4882_gpib.c   | 46 +++++++++----------
 22 files changed, 123 insertions(+), 116 deletions(-)

diff --git a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
index 53006d0cc79c..8e2334fe5c9b 100644
--- a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
+++ b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
@@ -700,7 +700,7 @@ static int agilent_82350b_generic_attach(gpib_board_t *board, const gpib_board_c
 							     GPIB_82350A_REGION));
 		dev_dbg(board->gpib_dev, "%s: gpib base address remapped to 0x%p\n",
 			driver_name, a_priv->gpib_base);
-		tms_priv->iobase = a_priv->gpib_base + TMS9914_BASE_REG;
+		tms_priv->mmiobase = a_priv->gpib_base + TMS9914_BASE_REG;
 		a_priv->sram_base = ioremap(pci_resource_start(a_priv->pci_device,
 							       SRAM_82350A_REGION),
 					    pci_resource_len(a_priv->pci_device,
@@ -724,7 +724,7 @@ static int agilent_82350b_generic_attach(gpib_board_t *board, const gpib_board_c
 					    pci_resource_len(a_priv->pci_device, GPIB_REGION));
 		dev_dbg(board->gpib_dev, "%s: gpib base address remapped to 0x%p\n",
 			driver_name, a_priv->gpib_base);
-		tms_priv->iobase = a_priv->gpib_base + TMS9914_BASE_REG;
+		tms_priv->mmiobase = a_priv->gpib_base + TMS9914_BASE_REG;
 		a_priv->sram_base = ioremap(pci_resource_start(a_priv->pci_device, SRAM_REGION),
 					    pci_resource_len(a_priv->pci_device, SRAM_REGION));
 		dev_dbg(board->gpib_dev, "%s: sram base address remapped to 0x%p\n",
diff --git a/drivers/staging/gpib/cb7210/cb7210.c b/drivers/staging/gpib/cb7210/cb7210.c
index 63df7f3eb3f3..59e41c97f518 100644
--- a/drivers/staging/gpib/cb7210/cb7210.c
+++ b/drivers/staging/gpib/cb7210/cb7210.c
@@ -971,12 +971,12 @@ int cb_pci_attach(gpib_board_t *board, const gpib_board_config_t *config)
 	switch (cb_priv->pci_chip) {
 	case PCI_CHIP_AMCC_S5933:
 		cb_priv->amcc_iobase = pci_resource_start(cb_priv->pci_device, 0);
-		nec_priv->iobase = (void *)(pci_resource_start(cb_priv->pci_device, 1));
+		nec_priv->iobase = pci_resource_start(cb_priv->pci_device, 1);
 		cb_priv->fifo_iobase = pci_resource_start(cb_priv->pci_device, 2);
 		break;
 	case PCI_CHIP_QUANCOM:
-		nec_priv->iobase = (void *)(pci_resource_start(cb_priv->pci_device, 0));
-		cb_priv->fifo_iobase = (unsigned long)nec_priv->iobase;
+		nec_priv->iobase = pci_resource_start(cb_priv->pci_device, 0);
+		cb_priv->fifo_iobase = nec_priv->iobase;
 		break;
 	default:
 		pr_err("cb7210: bug! unhandled pci_chip=%i\n", cb_priv->pci_chip);
@@ -1040,8 +1040,8 @@ int cb_isa_attach(gpib_board_t *board, const gpib_board_config_t *config)
 		return retval;
 	cb_priv = board->private_data;
 	nec_priv = &cb_priv->nec7210_priv;
-	if (request_region((unsigned long)config->ibbase, cb7210_iosize, "cb7210") == 0) {
-		pr_err("gpib: ioports starting at 0x%p are already in use\n", config->ibbase);
+	if (request_region(config->ibbase, cb7210_iosize, "cb7210") == 0) {
+		pr_err("gpib: ioports starting at 0x%u are already in use\n", config->ibbase);
 		return -EIO;
 	}
 	nec_priv->iobase = config->ibbase;
@@ -1471,7 +1471,7 @@ int cb_pcmcia_attach(gpib_board_t *board, const gpib_board_config_t *config)
 		       (unsigned long)curr_dev->resource[0]->start);
 		return -EIO;
 	}
-	nec_priv->iobase = (void *)(unsigned long)curr_dev->resource[0]->start;
+	nec_priv->iobase = curr_dev->resource[0]->start;
 	cb_priv->fifo_iobase = curr_dev->resource[0]->start;
 
 	if (request_irq(curr_dev->irq, cb7210_interrupt, IRQF_SHARED,
diff --git a/drivers/staging/gpib/cb7210/cb7210.h b/drivers/staging/gpib/cb7210/cb7210.h
index 4ad976de2b68..c17cb22585f7 100644
--- a/drivers/staging/gpib/cb7210/cb7210.h
+++ b/drivers/staging/gpib/cb7210/cb7210.h
@@ -113,9 +113,9 @@ enum hs_regs {
 	HS_STATUS = 0x8,	/* HS_STATUS register */
 };
 
-static inline unsigned long nec7210_iobase(const struct cb7210_priv *cb_priv)
+static inline u32 nec7210_iobase(const struct cb7210_priv *cb_priv)
 {
-	return (unsigned long)(cb_priv->nec7210_priv.iobase);
+	return cb_priv->nec7210_priv.iobase;
 }
 
 static inline int cb7210_page_in_bits(unsigned int page)
diff --git a/drivers/staging/gpib/cec/cec_gpib.c b/drivers/staging/gpib/cec/cec_gpib.c
index 3dc933deb401..9c00a874468c 100644
--- a/drivers/staging/gpib/cec/cec_gpib.c
+++ b/drivers/staging/gpib/cec/cec_gpib.c
@@ -297,8 +297,8 @@ int cec_pci_attach(gpib_board_t *board, const gpib_board_config_t *config)
 
 	cec_priv->plx_iobase = pci_resource_start(cec_priv->pci_device, 1);
 	pr_info(" plx9050 base address 0x%lx\n", cec_priv->plx_iobase);
-	nec_priv->iobase = (void *)(pci_resource_start(cec_priv->pci_device, 3));
-	pr_info(" nec7210 base address 0x%p\n", nec_priv->iobase);
+	nec_priv->iobase = pci_resource_start(cec_priv->pci_device, 3);
+	pr_info(" nec7210 base address 0x%x\n", nec_priv->iobase);
 
 	isr_flags |= IRQF_SHARED;
 	if (request_irq(cec_priv->pci_device->irq, cec_interrupt, isr_flags, "pci-gpib", board)) {
diff --git a/drivers/staging/gpib/common/gpib_os.c b/drivers/staging/gpib/common/gpib_os.c
index 50fc341eee96..0557f338853b 100644
--- a/drivers/staging/gpib/common/gpib_os.c
+++ b/drivers/staging/gpib/common/gpib_os.c
@@ -1573,7 +1573,7 @@ static int iobase_ioctl(gpib_board_config_t *config, unsigned long arg)
 
 	if (WARN_ON_ONCE(sizeof(void *) > sizeof(base_addr)))
 		return -EFAULT;
-	config->ibbase = (void *)(unsigned long)(base_addr);
+	config->ibbase = base_addr;
 
 	return 0;
 }
diff --git a/drivers/staging/gpib/eastwood/fluke_gpib.c b/drivers/staging/gpib/eastwood/fluke_gpib.c
index 3f938ab0c84d..5e59d38beb35 100644
--- a/drivers/staging/gpib/eastwood/fluke_gpib.c
+++ b/drivers/staging/gpib/eastwood/fluke_gpib.c
@@ -1011,12 +1011,12 @@ static int fluke_attach_impl(gpib_board_t *board, const gpib_board_config_t *con
 	}
 	e_priv->gpib_iomem_res = res;
 
-	nec_priv->iobase = ioremap(e_priv->gpib_iomem_res->start,
+	nec_priv->mmiobase = ioremap(e_priv->gpib_iomem_res->start,
 				   resource_size(e_priv->gpib_iomem_res));
-	pr_info("gpib: iobase %lx remapped to %p, length=%d\n",
-		(unsigned long)e_priv->gpib_iomem_res->start,
-		nec_priv->iobase, (int)resource_size(e_priv->gpib_iomem_res));
-	if (!nec_priv->iobase) {
+	pr_info("gpib: mmiobase %llx remapped to %p, length=%d\n",
+		(u64)e_priv->gpib_iomem_res->start,
+		nec_priv->mmiobase, (int)resource_size(e_priv->gpib_iomem_res));
+	if (!nec_priv->mmiobase) {
 		dev_err(&fluke_gpib_pdev->dev, "Could not map I/O memory\n");
 		return -ENOMEM;
 	}
@@ -1107,7 +1107,7 @@ void fluke_detach(gpib_board_t *board)
 		gpib_free_pseudo_irq(board);
 		nec_priv = &e_priv->nec7210_priv;
 
-		if (nec_priv->iobase) {
+		if (nec_priv->mmiobase) {
 			fluke_paged_write_byte(e_priv, 0, ISR0_IMR0, ISR0_IMR0_PAGE);
 			nec7210_board_reset(nec_priv, board);
 		}
diff --git a/drivers/staging/gpib/eastwood/fluke_gpib.h b/drivers/staging/gpib/eastwood/fluke_gpib.h
index fcbd42f8f9af..4e2144d45270 100644
--- a/drivers/staging/gpib/eastwood/fluke_gpib.h
+++ b/drivers/staging/gpib/eastwood/fluke_gpib.h
@@ -72,7 +72,7 @@ static inline uint8_t fluke_read_byte_nolock(struct nec7210_priv *nec_priv,
 {
 	u8 retval;
 
-	retval = readl(nec_priv->iobase + register_num * nec_priv->offset);
+	retval = readl(nec_priv->mmiobase + register_num * nec_priv->offset);
 	return retval;
 }
 
@@ -80,7 +80,7 @@ static inline uint8_t fluke_read_byte_nolock(struct nec7210_priv *nec_priv,
 static inline void fluke_write_byte_nolock(struct nec7210_priv *nec_priv, uint8_t data,
 					   int register_num)
 {
-	writel(data, nec_priv->iobase + register_num * nec_priv->offset);
+	writel(data, nec_priv->mmiobase + register_num * nec_priv->offset);
 }
 
 static inline uint8_t fluke_paged_read_byte(struct fluke_priv *e_priv,
diff --git a/drivers/staging/gpib/fmh_gpib/fmh_gpib.c b/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
index 62791db1c34a..2ed286fa5d6e 100644
--- a/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
+++ b/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
@@ -1419,15 +1419,14 @@ static int fmh_gpib_attach_impl(gpib_board_t *board, const gpib_board_config_t *
 	}
 	e_priv->gpib_iomem_res = res;
 
-	nec_priv->iobase = ioremap(e_priv->gpib_iomem_res->start,
+	nec_priv->mmiobase = ioremap(e_priv->gpib_iomem_res->start,
 				   resource_size(e_priv->gpib_iomem_res));
-	if (!nec_priv->iobase) {
+	if (!nec_priv->mmiobase) {
 		dev_err(board->dev, "Could not map I/O memory for gpib\n");
 		return -ENOMEM;
 	}
-	dev_info(board->dev, "iobase 0x%lx remapped to %p, length=%ld\n",
-		 (unsigned long)e_priv->gpib_iomem_res->start,
-		 nec_priv->iobase, (unsigned long)resource_size(e_priv->gpib_iomem_res));
+	dev_info(board->dev, "iobase %pr remapped to %p\n",
+		 e_priv->gpib_iomem_res, nec_priv->mmiobase);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dma_fifos");
 	if (!res) {
@@ -1507,14 +1506,14 @@ void fmh_gpib_detach(gpib_board_t *board)
 			free_irq(e_priv->irq, board);
 		if (e_priv->fifo_base)
 			fifos_write(e_priv, 0, FIFO_CONTROL_STATUS_REG);
-		if (nec_priv->iobase) {
+		if (nec_priv->mmiobase) {
 			write_byte(nec_priv, 0, ISR0_IMR0_REG);
 			nec7210_board_reset(nec_priv, board);
 		}
 		if (e_priv->fifo_base)
 			iounmap(e_priv->fifo_base);
-		if (nec_priv->iobase)
-			iounmap(nec_priv->iobase);
+		if (nec_priv->mmiobase)
+			iounmap(nec_priv->mmiobase);
 		if (e_priv->dma_port_res) {
 			release_mem_region(e_priv->dma_port_res->start,
 					   resource_size(e_priv->dma_port_res));
@@ -1564,12 +1563,12 @@ static int fmh_gpib_pci_attach_impl(gpib_board_t *board, const gpib_board_config
 	e_priv->gpib_iomem_res = &pci_device->resource[gpib_control_status_pci_resource_index];
 	e_priv->dma_port_res =  &pci_device->resource[gpib_fifo_pci_resource_index];
 
-	nec_priv->iobase = ioremap(pci_resource_start(pci_device,
+	nec_priv->mmiobase = ioremap(pci_resource_start(pci_device,
 						      gpib_control_status_pci_resource_index),
 				   pci_resource_len(pci_device,
 						    gpib_control_status_pci_resource_index));
 	dev_info(board->dev, "base address for gpib control/status registers remapped to 0x%p\n",
-		 nec_priv->iobase);
+		 nec_priv->mmiobase);
 
 	if (e_priv->dma_port_res->flags & IORESOURCE_MEM) {
 		e_priv->fifo_base = ioremap(pci_resource_start(pci_device,
@@ -1632,14 +1631,14 @@ void fmh_gpib_pci_detach(gpib_board_t *board)
 			free_irq(e_priv->irq, board);
 		if (e_priv->fifo_base)
 			fifos_write(e_priv, 0, FIFO_CONTROL_STATUS_REG);
-		if (nec_priv->iobase) {
+		if (nec_priv->mmiobase) {
 			write_byte(nec_priv, 0, ISR0_IMR0_REG);
 			nec7210_board_reset(nec_priv, board);
 		}
 		if (e_priv->fifo_base)
 			iounmap(e_priv->fifo_base);
-		if (nec_priv->iobase)
-			iounmap(nec_priv->iobase);
+		if (nec_priv->mmiobase)
+			iounmap(nec_priv->mmiobase);
 		if (e_priv->dma_port_res || e_priv->gpib_iomem_res)
 			pci_release_regions(to_pci_dev(board->dev));
 		if (board->dev)
diff --git a/drivers/staging/gpib/fmh_gpib/fmh_gpib.h b/drivers/staging/gpib/fmh_gpib/fmh_gpib.h
index 43bfc89d2a6f..60b1bd6d3c15 100644
--- a/drivers/staging/gpib/fmh_gpib/fmh_gpib.h
+++ b/drivers/staging/gpib/fmh_gpib/fmh_gpib.h
@@ -127,13 +127,13 @@ static const unsigned int fifo_max_burst_length_mask = 0x00ff;
 static inline uint8_t gpib_cs_read_byte(struct nec7210_priv *nec_priv,
 					unsigned int register_num)
 {
-	return readb(nec_priv->iobase + register_num * nec_priv->offset);
+	return readb(nec_priv->mmiobase + register_num * nec_priv->offset);
 }
 
 static inline void gpib_cs_write_byte(struct nec7210_priv *nec_priv, uint8_t data,
 				      unsigned int register_num)
 {
-	writeb(data, nec_priv->iobase + register_num * nec_priv->offset);
+	writeb(data, nec_priv->mmiobase + register_num * nec_priv->offset);
 }
 
 static inline uint16_t fifos_read(struct fmh_priv *fmh_priv, int register_num)
diff --git a/drivers/staging/gpib/hp_82335/hp82335.c b/drivers/staging/gpib/hp_82335/hp82335.c
index 40afe42aea47..ea78143c7ab6 100644
--- a/drivers/staging/gpib/hp_82335/hp82335.c
+++ b/drivers/staging/gpib/hp_82335/hp82335.c
@@ -9,6 +9,7 @@
  */
 
 #include "hp82335.h"
+#include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/sched.h>
 #include <linux/module.h>
@@ -233,7 +234,7 @@ static void hp82335_clear_interrupt(struct hp82335_priv *hp_priv)
 {
 	struct tms9914_priv *tms_priv = &hp_priv->tms9914_priv;
 
-	writeb(0, tms_priv->iobase + HPREG_INTR_CLEAR);
+	writeb(0, tms_priv->mmiobase + HPREG_INTR_CLEAR);
 }
 
 int hp82335_attach(gpib_board_t *board, const gpib_board_config_t *config)
@@ -241,7 +242,7 @@ int hp82335_attach(gpib_board_t *board, const gpib_board_config_t *config)
 	struct hp82335_priv *hp_priv;
 	struct tms9914_priv *tms_priv;
 	int retval;
-	const unsigned long upper_iomem_base = (unsigned long)config->ibbase + hp82335_rom_size;
+	const unsigned long upper_iomem_base = config->ibbase + hp82335_rom_size;
 
 	board->status = 0;
 
@@ -253,7 +254,7 @@ int hp82335_attach(gpib_board_t *board, const gpib_board_config_t *config)
 	tms_priv->write_byte = hp82335_write_byte;
 	tms_priv->offset = 1;
 
-	switch ((unsigned long)(config->ibbase)) {
+	switch (config->ibbase) {
 	case 0xc4000:
 	case 0xc8000:
 	case 0xcc000:
@@ -271,7 +272,7 @@ int hp82335_attach(gpib_board_t *board, const gpib_board_config_t *config)
 	case 0xfc000:
 		break;
 	default:
-		pr_err("hp82335: invalid base io address 0x%p\n", config->ibbase);
+		pr_err("hp82335: invalid base io address 0x%u\n", config->ibbase);
 		return -EINVAL;
 	}
 	if (!request_mem_region(upper_iomem_base, hp82335_upper_iomem_size, "hp82335")) {
@@ -280,9 +281,9 @@ int hp82335_attach(gpib_board_t *board, const gpib_board_config_t *config)
 		return -EBUSY;
 	}
 	hp_priv->raw_iobase = upper_iomem_base;
-	tms_priv->iobase = ioremap(upper_iomem_base, hp82335_upper_iomem_size);
+	tms_priv->mmiobase = ioremap(upper_iomem_base, hp82335_upper_iomem_size);
 	pr_info("hp82335: upper half of 82335 iomem region 0x%lx remapped to 0x%p\n",
-		hp_priv->raw_iobase, tms_priv->iobase);
+		hp_priv->raw_iobase, tms_priv->mmiobase);
 
 	retval = request_irq(config->ibirq, hp82335_interrupt, 0, "hp82335", board);
 	if (retval) {
@@ -296,7 +297,7 @@ int hp82335_attach(gpib_board_t *board, const gpib_board_config_t *config)
 
 	hp82335_clear_interrupt(hp_priv);
 
-	writeb(INTR_ENABLE, tms_priv->iobase + HPREG_CCR);
+	writeb(INTR_ENABLE, tms_priv->mmiobase + HPREG_CCR);
 
 	tms9914_online(board, tms_priv);
 
@@ -312,10 +313,10 @@ void hp82335_detach(gpib_board_t *board)
 		tms_priv = &hp_priv->tms9914_priv;
 		if (hp_priv->irq)
 			free_irq(hp_priv->irq, board);
-		if (tms_priv->iobase) {
-			writeb(0, tms_priv->iobase + HPREG_CCR);
+		if (tms_priv->mmiobase) {
+			writeb(0, tms_priv->mmiobase + HPREG_CCR);
 			tms9914_board_reset(tms_priv);
-			iounmap((void *)tms_priv->iobase);
+			iounmap(tms_priv->mmiobase);
 		}
 		if (hp_priv->raw_iobase)
 			release_mem_region(hp_priv->raw_iobase, hp82335_upper_iomem_size);
diff --git a/drivers/staging/gpib/hp_82341/hp_82341.c b/drivers/staging/gpib/hp_82341/hp_82341.c
index 8ad1c885a9fb..71d481e88bd9 100644
--- a/drivers/staging/gpib/hp_82341/hp_82341.c
+++ b/drivers/staging/gpib/hp_82341/hp_82341.c
@@ -473,12 +473,12 @@ void hp_82341_free_private(gpib_board_t *board)
 
 static uint8_t hp_82341_read_byte(struct tms9914_priv *priv, unsigned int register_num)
 {
-	return inb((unsigned long)(priv->iobase) + register_num);
+	return inb(priv->iobase + register_num);
 }
 
 static void hp_82341_write_byte(struct tms9914_priv *priv, uint8_t data, unsigned int register_num)
 {
-	outb(data, (unsigned long)(priv->iobase) + register_num);
+	outb(data, priv->iobase + register_num);
 }
 
 static int hp_82341_find_isapnp_board(struct pnp_dev **dev)
@@ -682,8 +682,8 @@ int hp_82341_attach(gpib_board_t *board, const gpib_board_config_t *config)
 {
 	struct hp_82341_priv *hp_priv;
 	struct tms9914_priv *tms_priv;
-	unsigned long start_addr;
-	void *iobase;
+	u32 start_addr;
+	u32 iobase;
 	int irq;
 	int i;
 	int retval;
@@ -704,7 +704,7 @@ int hp_82341_attach(gpib_board_t *board, const gpib_board_config_t *config)
 		if (retval < 0)
 			return retval;
 		hp_priv->pnp_dev = dev;
-		iobase = (void *)(pnp_port_start(dev, 0));
+		iobase = pnp_port_start(dev, 0);
 		irq = pnp_irq(dev, 0);
 		hp_priv->hw_version = HW_VERSION_82341D;
 		hp_priv->io_region_offset = 0x8;
@@ -714,9 +714,9 @@ int hp_82341_attach(gpib_board_t *board, const gpib_board_config_t *config)
 		hp_priv->hw_version = HW_VERSION_82341C;
 		hp_priv->io_region_offset = 0x400;
 	}
-	pr_info("hp_82341: base io 0x%p\n", iobase);
+	pr_info("hp_82341: base io 0x%u\n", iobase);
 	for (i = 0; i < hp_82341_num_io_regions; ++i) {
-		start_addr = (unsigned long)(iobase) + i * hp_priv->io_region_offset;
+		start_addr = iobase + i * hp_priv->io_region_offset;
 		if (!request_region(start_addr, hp_82341_region_iosize, "hp_82341")) {
 			pr_err("hp_82341: failed to allocate io ports 0x%lx-0x%lx\n",
 			       start_addr,
@@ -725,7 +725,7 @@ int hp_82341_attach(gpib_board_t *board, const gpib_board_config_t *config)
 		}
 		hp_priv->iobase[i] = start_addr;
 	}
-	tms_priv->iobase = (void *)(hp_priv->iobase[2]);
+	tms_priv->iobase = hp_priv->iobase[2];
 	if (hp_priv->hw_version == HW_VERSION_82341D) {
 		retval = isapnp_cfg_begin(hp_priv->pnp_dev->card->number,
 					  hp_priv->pnp_dev->number);
diff --git a/drivers/staging/gpib/include/gpib_types.h b/drivers/staging/gpib/include/gpib_types.h
index ee2643da6d71..b41781a55a60 100644
--- a/drivers/staging/gpib/include/gpib_types.h
+++ b/drivers/staging/gpib/include/gpib_types.h
@@ -31,7 +31,8 @@ typedef struct {
 	void *init_data;
 	int init_data_length;
 	/* IO base address to use for non-pnp cards (set by core, driver should make local copy) */
-	void *ibbase;
+	u32 ibbase;
+	void __iomem *mmibbase;
 	/* IRQ to use for non-pnp cards (set by core, driver should make local copy) */
 	unsigned int ibirq;
 	/* dma channel to use for non-pnp cards (set by core, driver should make local copy) */
diff --git a/drivers/staging/gpib/include/nec7210.h b/drivers/staging/gpib/include/nec7210.h
index c00aba4ce846..ca998c4a84bf 100644
--- a/drivers/staging/gpib/include/nec7210.h
+++ b/drivers/staging/gpib/include/nec7210.h
@@ -18,7 +18,10 @@
 
 /* struct used to provide variables local to a nec7210 chip */
 struct nec7210_priv {
-	void *iobase;
+#ifdef CONFIG_HAS_IOPORT
+	u32 iobase;
+#endif
+	void __iomem *mmiobase;
 	unsigned int offset;	// offset between successive nec7210 io addresses
 	unsigned int dma_channel;
 	u8 *dma_buffer;
diff --git a/drivers/staging/gpib/include/tms9914.h b/drivers/staging/gpib/include/tms9914.h
index 456b488212d2..d8c8d1c9b131 100644
--- a/drivers/staging/gpib/include/tms9914.h
+++ b/drivers/staging/gpib/include/tms9914.h
@@ -20,7 +20,10 @@ enum tms9914_holdoff_mode {
 
 /* struct used to provide variables local to a tms9914 chip */
 struct tms9914_priv {
-	void *iobase;
+#ifdef CONFIG_HAS_IOPORT
+	u32 iobase;
+#endif
+	void __iomem *mmiobase;
 	unsigned int offset;	// offset between successive tms9914 io addresses
 	unsigned int dma_channel;
 	// software copy of bits written to interrupt mask registers
diff --git a/drivers/staging/gpib/ines/ines.h b/drivers/staging/gpib/ines/ines.h
index 7e8302619998..eed038fd3f28 100644
--- a/drivers/staging/gpib/ines/ines.h
+++ b/drivers/staging/gpib/ines/ines.h
@@ -83,14 +83,14 @@ void ines_set_xfer_counter(struct ines_priv *priv, unsigned int count);
 /* inb/outb wrappers */
 static inline unsigned int ines_inb(struct ines_priv *priv, unsigned int register_number)
 {
-	return inb((unsigned long)(priv->nec7210_priv.iobase) +
+	return inb(priv->nec7210_priv.iobase +
 		   register_number * priv->nec7210_priv.offset);
 }
 
 static inline void ines_outb(struct ines_priv *priv, unsigned int value,
 			     unsigned int register_number)
 {
-	outb(value, (unsigned long)(priv->nec7210_priv.iobase) +
+	outb(value, priv->nec7210_priv.iobase +
 	     register_number * priv->nec7210_priv.offset);
 }
 
diff --git a/drivers/staging/gpib/ines/ines_gpib.c b/drivers/staging/gpib/ines/ines_gpib.c
index 9d8387c3bf01..e18455ba842f 100644
--- a/drivers/staging/gpib/ines/ines_gpib.c
+++ b/drivers/staging/gpib/ines/ines_gpib.c
@@ -273,10 +273,10 @@ irqreturn_t ines_pci_interrupt(int irq, void *arg)
 	struct nec7210_priv *nec_priv = &priv->nec7210_priv;
 
 	if (priv->pci_chip_type == PCI_CHIP_QUANCOM) {
-		if ((inb((unsigned long)nec_priv->iobase +
+		if ((inb(nec_priv->iobase +
 			 QUANCOM_IRQ_CONTROL_STATUS_REG) &
 		     QUANCOM_IRQ_ASSERTED_BIT))
-			outb(QUANCOM_IRQ_ENABLE_BIT, (unsigned long)(nec_priv->iobase) +
+			outb(QUANCOM_IRQ_ENABLE_BIT, nec_priv->iobase +
 			     QUANCOM_IRQ_CONTROL_STATUS_REG);
 	}
 
@@ -780,8 +780,8 @@ static int ines_common_pci_attach(gpib_board_t *board, const gpib_board_config_t
 
 	if (pci_request_regions(ines_priv->pci_device, "ines-gpib"))
 		return -1;
-	nec_priv->iobase = (void *)(pci_resource_start(ines_priv->pci_device,
-						       found_id.gpib_region));
+	nec_priv->iobase = pci_resource_start(ines_priv->pci_device,
+					      found_id.gpib_region);
 
 	ines_priv->pci_chip_type = found_id.pci_chip_type;
 	nec_priv->offset = found_id.io_offset;
@@ -840,7 +840,7 @@ static int ines_common_pci_attach(gpib_board_t *board, const gpib_board_config_t
 	}
 	break;
 	case PCI_CHIP_QUANCOM:
-		outb(QUANCOM_IRQ_ENABLE_BIT, (unsigned long)(nec_priv->iobase) +
+		outb(QUANCOM_IRQ_ENABLE_BIT, nec_priv->iobase +
 		     QUANCOM_IRQ_CONTROL_STATUS_REG);
 		break;
 	case PCI_CHIP_QUICKLOGIC5030:
@@ -899,8 +899,8 @@ int ines_isa_attach(gpib_board_t *board, const gpib_board_config_t *config)
 	ines_priv = board->private_data;
 	nec_priv = &ines_priv->nec7210_priv;
 
-	if (!request_region((unsigned long)config->ibbase, ines_isa_iosize, "ines_gpib")) {
-		pr_err("ines_gpib: ioports at 0x%p already in use\n", config->ibbase);
+	if (!request_region(config->ibbase, ines_isa_iosize, "ines_gpib")) {
+		pr_err("ines_gpib: ioports at 0x%x already in use\n", config->ibbase);
 		return -1;
 	}
 	nec_priv->iobase = config->ibbase;
@@ -931,7 +931,7 @@ void ines_pci_detach(gpib_board_t *board)
 				break;
 			case PCI_CHIP_QUANCOM:
 				if (nec_priv->iobase)
-					outb(0, (unsigned long)(nec_priv->iobase) +
+					outb(0, nec_priv->iobase +
 					     QUANCOM_IRQ_CONTROL_STATUS_REG);
 				break;
 			default:
@@ -960,7 +960,7 @@ void ines_isa_detach(gpib_board_t *board)
 			free_irq(ines_priv->irq, board);
 		if (nec_priv->iobase) {
 			nec7210_board_reset(nec_priv, board);
-			release_region((unsigned long)(nec_priv->iobase), ines_isa_iosize);
+			release_region(nec_priv->iobase, ines_isa_iosize);
 		}
 	}
 	ines_free_private(board);
@@ -1355,7 +1355,7 @@ int ines_common_pcmcia_attach(gpib_board_t *board)
 		return -1;
 	}
 
-	nec_priv->iobase = (void *)(unsigned long)curr_dev->resource[0]->start;
+	nec_priv->iobase = curr_dev->resource[0]->start;
 
 	nec7210_board_reset(nec_priv, board);
 
@@ -1410,7 +1410,7 @@ void ines_pcmcia_detach(gpib_board_t *board)
 			free_irq(ines_priv->irq, board);
 		if (nec_priv->iobase) {
 			nec7210_board_reset(nec_priv, board);
-			release_region((unsigned long)(nec_priv->iobase), ines_pcmcia_iosize);
+			release_region(nec_priv->iobase, ines_pcmcia_iosize);
 		}
 	}
 	ines_free_private(board);
diff --git a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
index 4135734cafad..f7ba770e4707 100644
--- a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
+++ b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
@@ -434,7 +434,7 @@ static void set_timeout(gpib_board_t *board)
 static int usb_gpib_attach(gpib_board_t *board, const gpib_board_config_t *config)
 {
 	int retval, j;
-	int base = (long)config->ibbase;
+	u32 base = config->ibbase;
 	char *device_path;
 	int match;
 	struct usb_device *udev;
diff --git a/drivers/staging/gpib/nec7210/nec7210.c b/drivers/staging/gpib/nec7210/nec7210.c
index 1d9951035497..c9a837fad96e 100644
--- a/drivers/staging/gpib/nec7210/nec7210.c
+++ b/drivers/staging/gpib/nec7210/nec7210.c
@@ -1035,7 +1035,7 @@ EXPORT_SYMBOL(nec7210_board_online);
 /* wrappers for io */
 uint8_t nec7210_ioport_read_byte(struct nec7210_priv *priv, unsigned int register_num)
 {
-	return inb((unsigned long)(priv->iobase) + register_num * priv->offset);
+	return inb(priv->iobase + register_num * priv->offset);
 }
 EXPORT_SYMBOL(nec7210_ioport_read_byte);
 
@@ -1047,7 +1047,7 @@ void nec7210_ioport_write_byte(struct nec7210_priv *priv, uint8_t data, unsigned
 		 */
 		nec7210_locking_ioport_write_byte(priv, data, register_num);
 	else
-		outb(data, (unsigned long)(priv->iobase) + register_num * priv->offset);
+		outb(data, priv->iobase + register_num * priv->offset);
 }
 EXPORT_SYMBOL(nec7210_ioport_write_byte);
 
@@ -1058,7 +1058,7 @@ uint8_t nec7210_locking_ioport_read_byte(struct nec7210_priv *priv, unsigned int
 	unsigned long flags;
 
 	spin_lock_irqsave(&priv->register_page_lock, flags);
-	retval = inb((unsigned long)(priv->iobase) + register_num * priv->offset);
+	retval = inb(priv->iobase + register_num * priv->offset);
 	spin_unlock_irqrestore(&priv->register_page_lock, flags);
 	return retval;
 }
@@ -1072,7 +1072,7 @@ void nec7210_locking_ioport_write_byte(struct nec7210_priv *priv, uint8_t data,
 	spin_lock_irqsave(&priv->register_page_lock, flags);
 	if (register_num == AUXMR)
 		udelay(1);
-	outb(data, (unsigned long)(priv->iobase) + register_num * priv->offset);
+	outb(data, priv->iobase + register_num * priv->offset);
 	spin_unlock_irqrestore(&priv->register_page_lock, flags);
 }
 EXPORT_SYMBOL(nec7210_locking_ioport_write_byte);
@@ -1080,7 +1080,7 @@ EXPORT_SYMBOL(nec7210_locking_ioport_write_byte);
 
 uint8_t nec7210_iomem_read_byte(struct nec7210_priv *priv, unsigned int register_num)
 {
-	return readb(priv->iobase + register_num * priv->offset);
+	return readb(priv->mmiobase + register_num * priv->offset);
 }
 EXPORT_SYMBOL(nec7210_iomem_read_byte);
 
@@ -1092,7 +1092,7 @@ void nec7210_iomem_write_byte(struct nec7210_priv *priv, uint8_t data, unsigned
 		 */
 		nec7210_locking_iomem_write_byte(priv, data, register_num);
 	else
-		writeb(data, priv->iobase + register_num * priv->offset);
+		writeb(data, priv->mmiobase + register_num * priv->offset);
 }
 EXPORT_SYMBOL(nec7210_iomem_write_byte);
 
@@ -1102,7 +1102,7 @@ uint8_t nec7210_locking_iomem_read_byte(struct nec7210_priv *priv, unsigned int
 	unsigned long flags;
 
 	spin_lock_irqsave(&priv->register_page_lock, flags);
-	retval = readb(priv->iobase + register_num * priv->offset);
+	retval = readb(priv->mmiobase + register_num * priv->offset);
 	spin_unlock_irqrestore(&priv->register_page_lock, flags);
 	return retval;
 }
@@ -1116,7 +1116,7 @@ void nec7210_locking_iomem_write_byte(struct nec7210_priv *priv, uint8_t data,
 	spin_lock_irqsave(&priv->register_page_lock, flags);
 	if (register_num == AUXMR)
 		udelay(1);
-	writeb(data, priv->iobase + register_num * priv->offset);
+	writeb(data, priv->mmiobase + register_num * priv->offset);
 	spin_unlock_irqrestore(&priv->register_page_lock, flags);
 }
 EXPORT_SYMBOL(nec7210_locking_iomem_write_byte);
diff --git a/drivers/staging/gpib/pc2/pc2_gpib.c b/drivers/staging/gpib/pc2/pc2_gpib.c
index 7b3b34f47341..d22af25125b1 100644
--- a/drivers/staging/gpib/pc2/pc2_gpib.c
+++ b/drivers/staging/gpib/pc2/pc2_gpib.c
@@ -426,7 +426,7 @@ int pc2_attach(gpib_board_t *board, const gpib_board_config_t *config)
 	nec_priv = &pc2_priv->nec7210_priv;
 	nec_priv->offset = pc2_reg_offset;
 
-	if (request_region((unsigned long)config->ibbase, pc2_iosize, "pc2") == 0) {
+	if (request_region(config->ibbase, pc2_iosize, "pc2") == 0) {
 		pr_err("gpib: ioports are already in use\n");
 		return -1;
 	}
@@ -471,7 +471,7 @@ void pc2_detach(gpib_board_t *board)
 			free_irq(pc2_priv->irq, board);
 		if (nec_priv->iobase) {
 			nec7210_board_reset(nec_priv, board);
-			release_region((unsigned long)(nec_priv->iobase), pc2_iosize);
+			release_region(nec_priv->iobase, pc2_iosize);
 		}
 		if (nec_priv->dma_buffer) {
 			dma_free_coherent(board->dev, nec_priv->dma_buffer_length,
@@ -498,14 +498,14 @@ static int pc2a_common_attach(gpib_board_t *board, const gpib_board_config_t *co
 	nec_priv = &pc2_priv->nec7210_priv;
 	nec_priv->offset = pc2a_reg_offset;
 
-	switch ((unsigned long)(config->ibbase)) {
+	switch (config->ibbase) {
 	case 0x02e1:
 	case 0x22e1:
 	case 0x42e1:
 	case 0x62e1:
 		break;
 	default:
-		pr_err("PCIIa base range invalid, must be one of 0x[0246]2e1, but is 0x%p\n",
+		pr_err("PCIIa base range invalid, must be one of 0x[0246]2e1, but is 0x%d\n",
 		       config->ibbase);
 		return -1;
 	}
@@ -522,7 +522,7 @@ static int pc2a_common_attach(gpib_board_t *board, const gpib_board_config_t *co
 	unsigned int err = 0;
 
 	for (i = 0; i < num_registers; i++) {
-		if (check_region((unsigned long)config->ibbase + i * pc2a_reg_offset, 1))
+		if (check_region(config->ibbase + i * pc2a_reg_offset, 1))
 			err++;
 	}
 	if (config->ibirq && check_region(pc2a_clear_intr_iobase + config->ibirq, 1))
@@ -533,11 +533,11 @@ static int pc2a_common_attach(gpib_board_t *board, const gpib_board_config_t *co
 	}
 #endif
 	for (i = 0; i < num_registers; i++) {
-		if (!request_region((unsigned long)config->ibbase +
+		if (!request_region(config->ibbase +
 					i * pc2a_reg_offset, 1, "pc2a")) {
 			pr_err("gpib: ioports are already in use");
 			for (j = 0; j < i; j++)
-				release_region((unsigned long)(config->ibbase) +
+				release_region(config->ibbase +
 					j * pc2a_reg_offset, 1);
 			return -1;
 		}
@@ -608,7 +608,7 @@ static void pc2a_common_detach(gpib_board_t *board, unsigned int num_registers)
 		if (nec_priv->iobase) {
 			nec7210_board_reset(nec_priv, board);
 			for (i = 0; i < num_registers; i++)
-				release_region((unsigned long)nec_priv->iobase +
+				release_region(nec_priv->iobase +
 					       i * pc2a_reg_offset, 1);
 		}
 		if (pc2_priv->clear_intr_addr)
diff --git a/drivers/staging/gpib/tms9914/tms9914.c b/drivers/staging/gpib/tms9914/tms9914.c
index 152b243b845b..ec8e1d4d762f 100644
--- a/drivers/staging/gpib/tms9914/tms9914.c
+++ b/drivers/staging/gpib/tms9914/tms9914.c
@@ -866,14 +866,14 @@ EXPORT_SYMBOL_GPL(tms9914_online);
 // wrapper for inb
 uint8_t tms9914_ioport_read_byte(struct tms9914_priv *priv, unsigned int register_num)
 {
-	return inb((unsigned long)(priv->iobase) + register_num * priv->offset);
+	return inb(priv->iobase + register_num * priv->offset);
 }
 EXPORT_SYMBOL_GPL(tms9914_ioport_read_byte);
 
 // wrapper for outb
 void tms9914_ioport_write_byte(struct tms9914_priv *priv, uint8_t data, unsigned int register_num)
 {
-	outb(data, (unsigned long)(priv->iobase) + register_num * priv->offset);
+	outb(data, priv->iobase + register_num * priv->offset);
 	if (register_num == AUXCR)
 		udelay(1);
 }
@@ -883,14 +883,14 @@ EXPORT_SYMBOL_GPL(tms9914_ioport_write_byte);
 // wrapper for readb
 uint8_t tms9914_iomem_read_byte(struct tms9914_priv *priv, unsigned int register_num)
 {
-	return readb(priv->iobase + register_num * priv->offset);
+	return readb(priv->mmiobase + register_num * priv->offset);
 }
 EXPORT_SYMBOL_GPL(tms9914_iomem_read_byte);
 
 // wrapper for writeb
 void tms9914_iomem_write_byte(struct tms9914_priv *priv, uint8_t data, unsigned int register_num)
 {
-	writeb(data, priv->iobase + register_num * priv->offset);
+	writeb(data, priv->mmiobase + register_num * priv->offset);
 	if (register_num == AUXCR)
 		udelay(1);
 }
diff --git a/drivers/staging/gpib/tnt4882/mite.h b/drivers/staging/gpib/tnt4882/mite.h
index fb84eaa83de3..2ecd83379974 100644
--- a/drivers/staging/gpib/tnt4882/mite.h
+++ b/drivers/staging/gpib/tnt4882/mite.h
@@ -34,9 +34,9 @@ struct mite_struct {
 
 	struct pci_dev *pcidev;
 	unsigned long mite_phys_addr;
-	void *mite_io_addr;
+	void __iomem *mite_io_addr;
 	unsigned long daq_phys_addr;
-	void *daq_io_addr;
+	void __iomem *daq_io_addr;
 
 	int DMA_CheckNearEnd;
 
diff --git a/drivers/staging/gpib/tnt4882/tnt4882_gpib.c b/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
index 408a123e9542..ce91c3eb768c 100644
--- a/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
+++ b/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
@@ -100,23 +100,23 @@ static const int atgpib_iosize = 32;
 /* paged io */
 static inline unsigned int tnt_paged_readb(struct tnt4882_priv *priv, unsigned long offset)
 {
-	iowrite8(AUX_PAGEIN, priv->nec7210_priv.iobase + AUXMR * priv->nec7210_priv.offset);
+	iowrite8(AUX_PAGEIN, priv->nec7210_priv.mmiobase + AUXMR * priv->nec7210_priv.offset);
 	udelay(1);
-	return ioread8(priv->nec7210_priv.iobase + offset);
+	return ioread8(priv->nec7210_priv.mmiobase + offset);
 }
 
 static inline void tnt_paged_writeb(struct tnt4882_priv *priv, unsigned int value,
 				    unsigned long offset)
 {
-	iowrite8(AUX_PAGEIN, priv->nec7210_priv.iobase + AUXMR * priv->nec7210_priv.offset);
+	iowrite8(AUX_PAGEIN, priv->nec7210_priv.mmiobase + AUXMR * priv->nec7210_priv.offset);
 	udelay(1);
-	iowrite8(value, priv->nec7210_priv.iobase + offset);
+	iowrite8(value, priv->nec7210_priv.mmiobase + offset);
 }
 
 /* readb/writeb wrappers */
 static inline unsigned short tnt_readb(struct tnt4882_priv *priv, unsigned long offset)
 {
-	void *address = priv->nec7210_priv.iobase + offset;
+	void *address = priv->nec7210_priv.mmiobase + offset;
 	unsigned long flags;
 	unsigned short retval;
 	spinlock_t *register_lock = &priv->nec7210_priv.register_page_lock;
@@ -154,7 +154,7 @@ static inline unsigned short tnt_readb(struct tnt4882_priv *priv, unsigned long
 
 static inline void tnt_writeb(struct tnt4882_priv *priv, unsigned short value, unsigned long offset)
 {
-	void *address = priv->nec7210_priv.iobase + offset;
+	void *address = priv->nec7210_priv.mmiobase + offset;
 	unsigned long flags;
 	spinlock_t *register_lock = &priv->nec7210_priv.register_page_lock;
 
@@ -284,7 +284,7 @@ static int drain_fifo_words(struct tnt4882_priv *tnt_priv, uint8_t *buffer, int
 	while (fifo_word_available(tnt_priv) && count + 2 <= num_bytes)	{
 		short word;
 
-		word = ioread16(nec_priv->iobase + FIFOB);
+		word = ioread16(nec_priv->mmiobase + FIFOB);
 		buffer[count++] = word & 0xff;
 		buffer[count++] = (word >> 8) & 0xff;
 	}
@@ -569,7 +569,7 @@ static int generic_write(gpib_board_t *board, uint8_t *buffer, size_t length,
 			word = buffer[count++] & 0xff;
 			if (count < length)
 				word |= (buffer[count++] << 8) & 0xff00;
-			iowrite16(word, nec_priv->iobase + FIFOB);
+			iowrite16(word, nec_priv->mmiobase + FIFOB);
 		}
 //  avoid unnecessary HR_NFF interrupts
 //		tnt_priv->imr3_bits |= HR_NFF;
@@ -1316,7 +1316,7 @@ int ni_pci_attach(gpib_board_t *board, const gpib_board_config_t *config)
 		return retval;
 	}
 
-	nec_priv->iobase = tnt_priv->mite->daq_io_addr;
+	nec_priv->mmiobase = tnt_priv->mite->daq_io_addr;
 
 	// get irq
 	if (request_irq(mite_irq(tnt_priv->mite), tnt4882_interrupt, isr_flags,
@@ -1351,7 +1351,7 @@ void ni_pci_detach(gpib_board_t *board)
 	if (tnt_priv) {
 		nec_priv = &tnt_priv->nec7210_priv;
 
-		if (nec_priv->iobase)
+		if (nec_priv->mmiobase)
 			tnt4882_board_reset(tnt_priv, board);
 		if (tnt_priv->irq)
 			free_irq(tnt_priv->irq, board);
@@ -1392,7 +1392,7 @@ static int ni_isa_attach_common(gpib_board_t *board, const gpib_board_config_t *
 	struct tnt4882_priv *tnt_priv;
 	struct nec7210_priv *nec_priv;
 	int isr_flags = 0;
-	void *iobase;
+	u32 iobase;
 	int irq;
 
 	board->status = 0;
@@ -1415,19 +1415,19 @@ static int ni_isa_attach_common(gpib_board_t *board, const gpib_board_config_t *
 		if (retval < 0)
 			return retval;
 		tnt_priv->pnp_dev = dev;
-		iobase = (void *)(pnp_port_start(dev, 0));
+		iobase = pnp_port_start(dev, 0);
 		irq = pnp_irq(dev, 0);
 	} else {
 		iobase = config->ibbase;
 		irq = config->ibirq;
 	}
 	// allocate ioports
-	if (!request_region((unsigned long)(iobase), atgpib_iosize, "atgpib")) {
+	if (!request_region(iobase, atgpib_iosize, "atgpib")) {
 		pr_err("tnt4882: failed to allocate ioports\n");
 		return -1;
 	}
-	nec_priv->iobase = ioport_map(iobase, atgpib_iosize);
-	if (!nec_priv->iobase)
+	nec_priv->mmiobase = ioport_map(iobase, atgpib_iosize);
+	if (!nec_priv->mmiobase)
 		return -1;
 
 	// get irq
@@ -1468,10 +1468,10 @@ void ni_isa_detach(gpib_board_t *board)
 			tnt4882_board_reset(tnt_priv, board);
 		if (tnt_priv->irq)
 			free_irq(tnt_priv->irq, board);
+		if (nec_priv->mmiobase)
+			ioport_unmap(nec_priv->mmiobase);
 		if (nec_priv->iobase)
-			ioport_unmap(nec_priv->iobase);
-		if (nec_priv->iobase)
-			release_region((unsigned long)(nec_priv->iobase), atgpib_iosize);
+			release_region(nec_priv->iobase, atgpib_iosize);
 		if (tnt_priv->pnp_dev)
 			pnp_device_detach(tnt_priv->pnp_dev);
 	}
@@ -1823,9 +1823,9 @@ int ni_pcmcia_attach(gpib_board_t *board, const gpib_board_config_t *config)
 		return -EIO;
 	}
 
-	nec_priv->iobase = ioport_map(curr_dev->resource[0]->start,
+	nec_priv->mmiobase = ioport_map(curr_dev->resource[0]->start,
 					resource_size(curr_dev->resource[0]));
-	if (!nec_priv->iobase)
+	if (!nec_priv->mmiobase)
 		return -1;
 
 	// get irq
@@ -1851,11 +1851,11 @@ void ni_pcmcia_detach(gpib_board_t *board)
 		nec_priv = &tnt_priv->nec7210_priv;
 		if (tnt_priv->irq)
 			free_irq(tnt_priv->irq, board);
-		if (nec_priv->iobase)
-			ioport_unmap(nec_priv->iobase);
+		if (nec_priv->mmiobase)
+			ioport_unmap(nec_priv->mmiobase);
 		if (nec_priv->iobase) {
 			tnt4882_board_reset(tnt_priv, board);
-			release_region((unsigned long)nec_priv->iobase, pcmcia_gpib_iosize);
+			release_region(nec_priv->iobase, pcmcia_gpib_iosize);
 		}
 	}
 	tnt4882_free_private(board);
-- 
2.39.5



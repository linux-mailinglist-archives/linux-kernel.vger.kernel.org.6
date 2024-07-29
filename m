Return-Path: <linux-kernel+bounces-265797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6082693F612
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25A78281E33
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA1714A4DB;
	Mon, 29 Jul 2024 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="ga1NWhsU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D5KRASSm"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646AF1465B4
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 13:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722258158; cv=none; b=TGtxq29WEoaNDMJfsCWpTAZDrefLFzakBGM5FS1/zVxvCOiKslk6nIPgl6Hf0mww1WZk0dSzwYIWMhoxlU3OdYBfFYxm3ewawa7G1EhpE2fpJd4PqyKGbrqeKYMsbdaaVjmMhCvap/U4FnXniKeqUGxYEzc2wYsZz+IbyN8qKuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722258158; c=relaxed/simple;
	bh=oHNhajBsx4vkAH52VoPSlwg5rZui1cFa5P1T6U1XqRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBKNBino9KaODqgI4JPU0wV7rMcN9pmebQddqZhLBBa8dOwDhoJQrS+OVAKIZ1f6SEZebAanA8FzE2Yr3GQbqadCssskuqaOVFobCPvpIXxCPMhRVg7A6V34p8nzGbX2FcB9ZoU9vASvykmegbcgtqZxHUkFBW99GOcsUXxNFTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=ga1NWhsU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D5KRASSm; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D103C1140076;
	Mon, 29 Jul 2024 09:02:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 29 Jul 2024 09:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722258153; x=
	1722344553; bh=hl00sQuxAurJEsD1AWjNLggvTsUpZqcpnsH8S9oiw9o=; b=g
	a1NWhsULzu0NDZ1XydEt9XjQqYfdp6joWqWaRJ4eRv5L7iSlSFdgmCoKdcdweoXD
	rrglOPkCHejaEKanXZ1kfnzbzEw6VF51iXWK/akuV9A6WMsIZDXYVzf56mFQ9eIU
	2e4k4Ukxf+/kyKfIg8wqrMPWWgNbKhMEcb51uKn0S7wkUZ4jYWW5oD9RLkg1Jq6X
	efDmlJ5LG2C2rlkhh4zeuhoay8jt5r8LGZ6cUrxoxrkiira74e7PSiFpf9pXekTQ
	O9Lj25FcTStuoQCEdZzQlC+hFy/FJ56g0pFpyZwczTIWUiJ7P+/lTsgHH3Bx4sH5
	K2T5QDP+O2qUbkbjtxTvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722258153; x=
	1722344553; bh=hl00sQuxAurJEsD1AWjNLggvTsUpZqcpnsH8S9oiw9o=; b=D
	5KRASSmG9MLrkJ3gp6tCQnJd8TdNGqFgvtq8BJE8vATkq1Voaxux0a0Ylsu+DYHP
	vIJhqxzEdB5z0WFTr63hfujv4W73kYuCfOeief1jin+50psnMqL8J/RpNQ/4qBQi
	ibiBPfRv6+gpuE6cX0GpQWaBH2/fCUUeDyn/kE3Jl4VKU1tbaV6MXJf6Tyj7VS+B
	5M6S5ZqT9Lrzs477fLgkM8SbsLjYsmcpaIQWEnXmof5lMsdgMoGmDN7qDkXy/f1o
	9oWZXjKlb2Z+4f6W6zQ8CoMeyZwRfoXbTdg0tsnoccLMRUiNsTDgju1F36jAPwOt
	JOu5mVXKk8qquy604I5sg==
X-ME-Sender: <xms:6ZKnZh8wcymJ15EopZh4eqBA3_26Z_oH1F00BXHpFDpMZpcxMO3gMQ>
    <xme:6ZKnZltz0anotzX_ESPEaIijrhlOxMuwq9UOccoGZKLY70n7iLfSXpBlp0DpAMVL2
    C5rxxBYpaaXZwo>
X-ME-Received: <xmr:6ZKnZvA3FrU-7ACDdbFs0eHI5sXWmQPXkMWG-E53Lxe4vbK8ZFvcv_O-Kk7R7NWifnt6fL5Lt5wAQcxeZwiAb7tt-Fl80mpd-cEHYv4JR86nUgfn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjedvgdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepifhrihhffhhinhcumfhrohgrhhdqjfgrrhhtmhgrnhcuoehg
    rhhifhhfihhnsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpefgjedvteetve
    dtheduhffggfeuteelvedtjeeuvdehtdekveefvdevueefvdfgudenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhhifhhfihhnsehkrhhorg
    hhrdgtohhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:6ZKnZlfd2gZJRgdLpZFn2MEuqEiFaWBjE8zhn7kinppgAP_u0KxO1Q>
    <xmx:6ZKnZmMshEgXDVj86llCXwtoRlghByk5zqArFcJjhaj7m-3tCklR2w>
    <xmx:6ZKnZnl0UubW_AwIK4eOUFg_MhWXcsy2Pe3YcyWf8_aipUL5qEWZYw>
    <xmx:6ZKnZgvf6eWLH32cvsLuaSyZPXb5pfL5ToTRlsbpAd-ooWh1Lr3oaw>
    <xmx:6ZKnZjokNkvZLYmxDPG0fpvPpAJKAKk11IJcoSZBs75diujQUghGjwyb>
Feedback-ID: i1d2843be:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jul 2024 09:02:31 -0400 (EDT)
From: Griffin Kroah-Hartman <griffin@kroah.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Griffin Kroah-Hartman <griffin@kroah.com>
Subject: [PATCH 2/2] staging: vme_user: vme_tsi148.c: Change Formatting
Date: Mon, 29 Jul 2024 15:02:13 +0200
Message-ID: <20240729130213.48941-2-griffin@kroah.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240729130213.48941-1-griffin@kroah.com>
References: <20240729130213.48941-1-griffin@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adhere to Linux Kernal coding style.

Reported by checkpatch

CHECK: Alignment should match open parenthesis

Signed-off-by: Griffin Kroah-Hartman <griffin@kroah.com>
---
 drivers/staging/vme_user/vme_tsi148.c | 133 +++++++++++++-------------
 1 file changed, 67 insertions(+), 66 deletions(-)

diff --git a/drivers/staging/vme_user/vme_tsi148.c b/drivers/staging/vme_user/vme_tsi148.c
index 9b1e9fd9ff20..d81be8e4ceba 100644
--- a/drivers/staging/vme_user/vme_tsi148.c
+++ b/drivers/staging/vme_user/vme_tsi148.c
@@ -55,14 +55,14 @@ static struct pci_driver tsi148_driver = {
 };
 
 static void reg_join(unsigned int high, unsigned int low,
-	unsigned long long *variable)
+		     unsigned long long *variable)
 {
 	*variable = (unsigned long long)high << 32;
 	*variable |= (unsigned long long)low;
 }
 
 static void reg_split(unsigned long long variable, unsigned int *high,
-	unsigned int *low)
+		      unsigned int *low)
 {
 	*low = (unsigned int)variable & 0xFFFFFFFF;
 	*high = (unsigned int)(variable >> 32);
@@ -72,7 +72,7 @@ static void reg_split(unsigned long long variable, unsigned int *high,
  * Wakes up DMA queue.
  */
 static u32 tsi148_DMA_irqhandler(struct tsi148_driver *bridge,
-	int channel_mask)
+				 int channel_mask)
 {
 	u32 serviced = 0;
 
@@ -207,7 +207,7 @@ static u32 tsi148_IACK_irqhandler(struct tsi148_driver *bridge)
  * Calling VME bus interrupt callback if provided.
  */
 static u32 tsi148_VIRQ_irqhandler(struct vme_bridge *tsi148_bridge,
-	u32 stat)
+				  u32 stat)
 {
 	int vec, i, serviced = 0;
 	struct tsi148_driver *bridge;
@@ -358,7 +358,7 @@ static int tsi148_irq_init(struct vme_bridge *tsi148_bridge)
 }
 
 static void tsi148_irq_exit(struct vme_bridge *tsi148_bridge,
-	struct pci_dev *pdev)
+			    struct pci_dev *pdev)
 {
 	struct tsi148_driver *bridge = tsi148_bridge->driver_priv;
 
@@ -392,7 +392,7 @@ static int tsi148_iack_received(struct tsi148_driver *bridge)
  * Configure VME interrupt
  */
 static void tsi148_irq_set(struct vme_bridge *tsi148_bridge, int level,
-	int state, int sync)
+			   int state, int sync)
 {
 	struct pci_dev *pdev;
 	u32 tmp;
@@ -430,7 +430,7 @@ static void tsi148_irq_set(struct vme_bridge *tsi148_bridge, int level,
  * interrupt to be acked.
  */
 static int tsi148_irq_generate(struct vme_bridge *tsi148_bridge, int level,
-	int statid)
+			       int statid)
 {
 	u32 tmp;
 	struct tsi148_driver *bridge;
@@ -453,7 +453,7 @@ static int tsi148_irq_generate(struct vme_bridge *tsi148_bridge, int level,
 
 	/* XXX Consider implementing a timeout? */
 	wait_event_interruptible(bridge->iack_queue,
-		tsi148_iack_received(bridge));
+				 tsi148_iack_received(bridge));
 
 	mutex_unlock(&bridge->vme_int);
 
@@ -464,8 +464,8 @@ static int tsi148_irq_generate(struct vme_bridge *tsi148_bridge, int level,
  * Initialize a slave window with the requested attributes.
  */
 static int tsi148_slave_set(struct vme_slave_resource *image, int enabled,
-	unsigned long long vme_base, unsigned long long size,
-	dma_addr_t pci_base, u32 aspace, u32 cycle)
+			    unsigned long long vme_base, unsigned long long size,
+			    dma_addr_t pci_base, u32 aspace, u32 cycle)
 {
 	unsigned int i, addr = 0, granularity = 0;
 	unsigned int temp_ctl = 0;
@@ -607,8 +607,8 @@ static int tsi148_slave_set(struct vme_slave_resource *image, int enabled,
  * Get slave window configuration.
  */
 static int tsi148_slave_get(struct vme_slave_resource *image, int *enabled,
-	unsigned long long *vme_base, unsigned long long *size,
-	dma_addr_t *pci_base, u32 *aspace, u32 *cycle)
+			    unsigned long long *vme_base, unsigned long long *size,
+			    dma_addr_t *pci_base, u32 *aspace, u32 *cycle)
 {
 	unsigned int i, granularity = 0, ctl = 0;
 	unsigned int vme_base_low, vme_base_high;
@@ -706,7 +706,7 @@ static int tsi148_slave_get(struct vme_slave_resource *image, int *enabled,
  * Allocate and map PCI Resource
  */
 static int tsi148_alloc_resource(struct vme_master_resource *image,
-	unsigned long long size)
+				 unsigned long long size)
 {
 	unsigned long long existing_size;
 	int retval = 0;
@@ -751,9 +751,9 @@ static int tsi148_alloc_resource(struct vme_master_resource *image,
 	image->bus_resource.end = (unsigned long)size;
 	image->bus_resource.flags = IORESOURCE_MEM;
 
-	retval = pci_bus_alloc_resource(pdev->bus,
-		&image->bus_resource, size, 0x10000, PCIBIOS_MIN_MEM,
-		0, NULL, NULL);
+	retval = pci_bus_alloc_resource(pdev->bus, &image->bus_resource,
+					size, 0x10000, PCIBIOS_MIN_MEM,
+					0, NULL, NULL);
 	if (retval) {
 		dev_err(tsi148_bridge->parent, "Failed to allocate mem resource for window %d size 0x%lx start 0x%lx\n",
 			image->number, (unsigned long)size,
@@ -796,8 +796,8 @@ static void tsi148_free_resource(struct vme_master_resource *image)
  * Set the attributes of an outbound window.
  */
 static int tsi148_master_set(struct vme_master_resource *image, int enabled,
-	unsigned long long vme_base, unsigned long long size, u32 aspace,
-	u32 cycle, u32 dwidth)
+			     unsigned long long vme_base, unsigned long long size,
+			     u32 aspace, u32 cycle, u32 dwidth)
 {
 	int retval = 0;
 	unsigned int i;
@@ -1031,8 +1031,8 @@ static int tsi148_master_set(struct vme_master_resource *image, int enabled,
  * XXX Not parsing prefetch information.
  */
 static int __tsi148_master_get(struct vme_master_resource *image, int *enabled,
-	unsigned long long *vme_base, unsigned long long *size, u32 *aspace,
-	u32 *cycle, u32 *dwidth)
+			       unsigned long long *vme_base, unsigned long long *size,
+			       u32 *aspace, u32 *cycle, u32 *dwidth)
 {
 	unsigned int i, ctl;
 	unsigned int pci_base_low, pci_base_high;
@@ -1140,15 +1140,15 @@ static int __tsi148_master_get(struct vme_master_resource *image, int *enabled,
 }
 
 static int tsi148_master_get(struct vme_master_resource *image, int *enabled,
-	unsigned long long *vme_base, unsigned long long *size, u32 *aspace,
-	u32 *cycle, u32 *dwidth)
+			     unsigned long long *vme_base, unsigned long long *size,
+			     u32 *aspace, u32 *cycle, u32 *dwidth)
 {
 	int retval;
 
 	spin_lock(&image->lock);
 
 	retval = __tsi148_master_get(image, enabled, vme_base, size, aspace,
-		cycle, dwidth);
+				     cycle, dwidth);
 
 	spin_unlock(&image->lock);
 
@@ -1156,7 +1156,7 @@ static int tsi148_master_get(struct vme_master_resource *image, int *enabled,
 }
 
 static ssize_t tsi148_master_read(struct vme_master_resource *image, void *buf,
-	size_t count, loff_t offset)
+				  size_t count, loff_t offset)
 {
 	int retval, enabled;
 	unsigned long long vme_base, size;
@@ -1241,7 +1241,7 @@ static ssize_t tsi148_master_read(struct vme_master_resource *image, void *buf,
 }
 
 static ssize_t tsi148_master_write(struct vme_master_resource *image, void *buf,
-	size_t count, loff_t offset)
+				   size_t count, loff_t offset)
 {
 	int retval = 0, enabled;
 	unsigned long long vme_base, size;
@@ -1342,9 +1342,8 @@ static ssize_t tsi148_master_write(struct vme_master_resource *image, void *buf,
  *
  * Requires a previously configured master window, returns final value.
  */
-static unsigned int tsi148_master_rmw(struct vme_master_resource *image,
-	unsigned int mask, unsigned int compare, unsigned int swap,
-	loff_t offset)
+static unsigned int tsi148_master_rmw(struct vme_master_resource *image, unsigned int mask,
+				      unsigned int compare, unsigned int swap, loff_t offset)
 {
 	unsigned long long pci_addr;
 	unsigned int pci_addr_high, pci_addr_low;
@@ -1399,7 +1398,7 @@ static unsigned int tsi148_master_rmw(struct vme_master_resource *image,
 }
 
 static int tsi148_dma_set_vme_src_attributes(struct device *dev, __be32 *attr,
-	u32 aspace, u32 cycle, u32 dwidth)
+					     u32 aspace, u32 cycle, u32 dwidth)
 {
 	u32 val;
 
@@ -1497,7 +1496,7 @@ static int tsi148_dma_set_vme_src_attributes(struct device *dev, __be32 *attr,
 }
 
 static int tsi148_dma_set_vme_dest_attributes(struct device *dev, __be32 *attr,
-	u32 aspace, u32 cycle, u32 dwidth)
+					      u32 aspace, u32 cycle, u32 dwidth)
 {
 	u32 val;
 
@@ -1599,8 +1598,8 @@ static int tsi148_dma_set_vme_dest_attributes(struct device *dev, __be32 *attr,
  *
  * Note: DMA engine expects the DMA descriptor to be big endian.
  */
-static int tsi148_dma_list_add(struct vme_dma_list *list,
-	struct vme_dma_attr *src, struct vme_dma_attr *dest, size_t count)
+static int tsi148_dma_list_add(struct vme_dma_list *list, struct vme_dma_attr *src,
+			       struct vme_dma_attr *dest, size_t count)
 {
 	struct tsi148_dma_entry *entry, *prev;
 	u32 address_high, address_low, val;
@@ -1666,9 +1665,11 @@ static int tsi148_dma_list_add(struct vme_dma_list *list,
 		entry->descriptor.dsal = cpu_to_be32(address_low);
 		entry->descriptor.dsat = cpu_to_be32(TSI148_LCSR_DSAT_TYP_VME);
 
-		retval = tsi148_dma_set_vme_src_attributes(
-			tsi148_bridge->parent, &entry->descriptor.dsat,
-			vme_attr->aspace, vme_attr->cycle, vme_attr->dwidth);
+		retval = tsi148_dma_set_vme_src_attributes(tsi148_bridge->parent,
+							   &entry->descriptor.dsat,
+							   vme_attr->aspace,
+							   vme_attr->cycle,
+							   vme_attr->dwidth);
 		if (retval < 0)
 			goto err_source;
 		break;
@@ -1688,7 +1689,7 @@ static int tsi148_dma_list_add(struct vme_dma_list *list,
 		pci_attr = dest->private;
 
 		reg_split((unsigned long long)pci_attr->address, &address_high,
-			&address_low);
+			  &address_low);
 		entry->descriptor.ddau = cpu_to_be32(address_high);
 		entry->descriptor.ddal = cpu_to_be32(address_low);
 		entry->descriptor.ddat = cpu_to_be32(TSI148_LCSR_DDAT_TYP_PCI);
@@ -1697,14 +1698,16 @@ static int tsi148_dma_list_add(struct vme_dma_list *list,
 		vme_attr = dest->private;
 
 		reg_split((unsigned long long)vme_attr->address, &address_high,
-			&address_low);
+			  &address_low);
 		entry->descriptor.ddau = cpu_to_be32(address_high);
 		entry->descriptor.ddal = cpu_to_be32(address_low);
 		entry->descriptor.ddat = cpu_to_be32(TSI148_LCSR_DDAT_TYP_VME);
 
-		retval = tsi148_dma_set_vme_dest_attributes(
-			tsi148_bridge->parent, &entry->descriptor.ddat,
-			vme_attr->aspace, vme_attr->cycle, vme_attr->dwidth);
+		retval = tsi148_dma_set_vme_dest_attributes(tsi148_bridge->parent,
+							    &entry->descriptor.ddat,
+							    vme_attr->aspace,
+							    vme_attr->cycle,
+							    vme_attr->dwidth);
 		if (retval < 0)
 			goto err_dest;
 		break;
@@ -1733,7 +1736,7 @@ static int tsi148_dma_list_add(struct vme_dma_list *list,
 	/* Fill out previous descriptors "Next Address" */
 	if (entry->list.prev != &list->entries) {
 		reg_split((unsigned long long)entry->dma_handle, &address_high,
-			&address_low);
+			  &address_low);
 		prev = list_entry(entry->list.prev, struct tsi148_dma_entry,
 				  list);
 		prev->descriptor.dnlau = cpu_to_be32(address_high);
@@ -1811,7 +1814,7 @@ static int tsi148_dma_list_exec(struct vme_dma_list *list)
 
 	/* Get first bus address and write into registers */
 	entry = list_first_entry(&list->entries, struct tsi148_dma_entry,
-		list);
+				 list);
 
 	mutex_unlock(&ctrlr->mtx);
 
@@ -1830,7 +1833,7 @@ static int tsi148_dma_list_exec(struct vme_dma_list *list)
 		TSI148_LCSR_DMA[channel] + TSI148_LCSR_OFFSET_DCTL);
 
 	retval = wait_event_interruptible(bridge->dma_queue[channel],
-		tsi148_dma_busy(ctrlr->parent, channel));
+					  tsi148_dma_busy(ctrlr->parent, channel));
 
 	if (retval) {
 		iowrite32be(dctlreg | TSI148_LCSR_DCTL_ABT, bridge->base +
@@ -1881,7 +1884,7 @@ static int tsi148_dma_list_empty(struct vme_dma_list *list)
 		entry = list_entry(pos, struct tsi148_dma_entry, list);
 
 		dma_unmap_single(tsi148_bridge->parent, entry->dma_handle,
-			sizeof(struct tsi148_dma_descriptor), DMA_TO_DEVICE);
+				 sizeof(struct tsi148_dma_descriptor), DMA_TO_DEVICE);
 		kfree(entry);
 	}
 
@@ -1896,7 +1899,7 @@ static int tsi148_dma_list_empty(struct vme_dma_list *list)
  * callback is attached and disabled when the last callback is removed.
  */
 static int tsi148_lm_set(struct vme_lm_resource *lm, unsigned long long lm_base,
-	u32 aspace, u32 cycle)
+			 u32 aspace, u32 cycle)
 {
 	u32 lm_base_high, lm_base_low, lm_ctl = 0;
 	int i;
@@ -1961,7 +1964,7 @@ static int tsi148_lm_set(struct vme_lm_resource *lm, unsigned long long lm_base,
  * or disabled.
  */
 static int tsi148_lm_get(struct vme_lm_resource *lm,
-	unsigned long long *lm_base, u32 *aspace, u32 *cycle)
+			 unsigned long long *lm_base, u32 *aspace, u32 *cycle)
 {
 	u32 lm_base_high, lm_base_low, lm_ctl, enabled = 0;
 	struct tsi148_driver *bridge;
@@ -2011,7 +2014,7 @@ static int tsi148_lm_get(struct vme_lm_resource *lm,
  * Callback will be passed the monitor triggered.
  */
 static int tsi148_lm_attach(struct vme_lm_resource *lm, int monitor,
-	void (*callback)(void *), void *data)
+			    void (*callback)(void *), void *data)
 {
 	u32 lm_ctl, tmp;
 	struct vme_bridge *tsi148_bridge;
@@ -2084,7 +2087,7 @@ static int tsi148_lm_detach(struct vme_lm_resource *lm, int monitor)
 	iowrite32be(tmp, bridge->base + TSI148_LCSR_INTEO);
 
 	iowrite32be(TSI148_LCSR_INTC_LMC[monitor],
-		 bridge->base + TSI148_LCSR_INTC);
+		    bridge->base + TSI148_LCSR_INTC);
 
 	/* Detach callback */
 	bridge->lm_callback[monitor] = NULL;
@@ -2124,7 +2127,7 @@ static int tsi148_slot_get(struct vme_bridge *tsi148_bridge)
 }
 
 static void *tsi148_alloc_consistent(struct device *parent, size_t size,
-	dma_addr_t *dma)
+				     dma_addr_t *dma)
 {
 	struct pci_dev *pdev;
 
@@ -2135,7 +2138,7 @@ static void *tsi148_alloc_consistent(struct device *parent, size_t size,
 }
 
 static void tsi148_free_consistent(struct device *parent, size_t size,
-	void *vaddr, dma_addr_t dma)
+				   void *vaddr, dma_addr_t dma)
 {
 	struct pci_dev *pdev;
 
@@ -2158,7 +2161,7 @@ static void tsi148_free_consistent(struct device *parent, size_t size,
  * be mapped onto PCI memory.
  */
 static int tsi148_crcsr_init(struct vme_bridge *tsi148_bridge,
-	struct pci_dev *pdev)
+			     struct pci_dev *pdev)
 {
 	u32 cbar, crat, vstat;
 	u32 crcsr_bus_high, crcsr_bus_low;
@@ -2199,8 +2202,7 @@ static int tsi148_crcsr_init(struct vme_bridge *tsi148_bridge,
 		dev_info(tsi148_bridge->parent, "CR/CSR already enabled\n");
 	} else {
 		dev_info(tsi148_bridge->parent, "Enabling CR/CSR space\n");
-		iowrite32be(crat | TSI148_LCSR_CRAT_EN,
-			bridge->base + TSI148_LCSR_CRAT);
+		iowrite32be(crat | TSI148_LCSR_CRAT_EN, bridge->base + TSI148_LCSR_CRAT);
 	}
 
 	/* If we want flushed, error-checked writes, set up a window
@@ -2208,9 +2210,8 @@ static int tsi148_crcsr_init(struct vme_bridge *tsi148_bridge,
 	 * through VME writes.
 	 */
 	if (err_chk) {
-		retval = tsi148_master_set(bridge->flush_image, 1,
-			(vstat * 0x80000), 0x80000, VME_CRCSR, VME_SCT,
-			VME_D16);
+		retval = tsi148_master_set(bridge->flush_image, 1, (vstat * 0x80000),
+					   0x80000, VME_CRCSR, VME_SCT, VME_D16);
 		if (retval)
 			dev_err(tsi148_bridge->parent, "Configuring flush image failed\n");
 	}
@@ -2219,7 +2220,7 @@ static int tsi148_crcsr_init(struct vme_bridge *tsi148_bridge,
 }
 
 static void tsi148_crcsr_exit(struct vme_bridge *tsi148_bridge,
-	struct pci_dev *pdev)
+			      struct pci_dev *pdev)
 {
 	u32 crat;
 	struct tsi148_driver *bridge;
@@ -2229,7 +2230,7 @@ static void tsi148_crcsr_exit(struct vme_bridge *tsi148_bridge,
 	/* Turn off CR/CSR space */
 	crat = ioread32be(bridge->base + TSI148_LCSR_CRAT);
 	iowrite32be(crat & ~TSI148_LCSR_CRAT_EN,
-		bridge->base + TSI148_LCSR_CRAT);
+		    bridge->base + TSI148_LCSR_CRAT);
 
 	/* Free image */
 	iowrite32be(0, bridge->base + TSI148_LCSR_CROU);
@@ -2285,7 +2286,7 @@ static int tsi148_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	/* map registers in BAR 0 */
 	tsi148_device->base = ioremap(pci_resource_start(pdev, 0),
-		4096);
+				      4096);
 	if (!tsi148_device->base) {
 		dev_err(&pdev->dev, "Unable to remap CRG region\n");
 		retval = -EIO;
@@ -2365,7 +2366,7 @@ static int tsi148_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		       sizeof(master_image->bus_resource));
 		master_image->kern_base  = NULL;
 		list_add_tail(&master_image->list,
-			&tsi148_bridge->master_resources);
+			      &tsi148_bridge->master_resources);
 	}
 
 	/* Add slave windows to list */
@@ -2386,7 +2387,7 @@ static int tsi148_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			VME_2eSST267 | VME_2eSST320 | VME_SUPER | VME_USER |
 			VME_PROG | VME_DATA;
 		list_add_tail(&slave_image->list,
-			&tsi148_bridge->slave_resources);
+			      &tsi148_bridge->slave_resources);
 	}
 
 	/* Add dma engines to list */
@@ -2407,7 +2408,7 @@ static int tsi148_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		INIT_LIST_HEAD(&dma_ctrlr->pending);
 		INIT_LIST_HEAD(&dma_ctrlr->running);
 		list_add_tail(&dma_ctrlr->list,
-			&tsi148_bridge->dma_resources);
+			      &tsi148_bridge->dma_resources);
 	}
 
 	/* Add location monitor to list */
@@ -2445,16 +2446,16 @@ static int tsi148_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	data = ioread32be(tsi148_device->base + TSI148_LCSR_VSTAT);
 	dev_info(&pdev->dev, "Board is%s the VME system controller\n",
-		(data & TSI148_LCSR_VSTAT_SCONS) ? "" : " not");
+		 (data & TSI148_LCSR_VSTAT_SCONS) ? "" : " not");
 	if (!geoid)
 		dev_info(&pdev->dev, "VME geographical address is %d\n",
-			data & TSI148_LCSR_VSTAT_GA_M);
+			 data & TSI148_LCSR_VSTAT_GA_M);
 	else
 		dev_info(&pdev->dev, "VME geographical address is set to %d\n",
-			geoid);
+			 geoid);
 
 	dev_info(&pdev->dev, "VME Write and flush and error check is %s\n",
-		err_chk ? "enabled" : "disabled");
+		 err_chk ? "enabled" : "disabled");
 
 	retval = tsi148_crcsr_init(tsi148_bridge, pdev);
 	if (retval) {
-- 
2.45.2



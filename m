Return-Path: <linux-kernel+bounces-423837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DFE9DAD73
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CB6628207A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 19:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919B1201261;
	Wed, 27 Nov 2024 19:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="Z6mYFFjA"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F5A20125B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 18:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732733999; cv=none; b=REBJ0TOl7H6w/FFwbvpo7CN5YoVgh9rbgytbjYCCGwfK3bfaIqcIacFl+s4uPD3H8V5JancVTo7FroWapUrnOEdBOzH80I9xsYAMkkxtSPgULxJAoDbD3GtssKIrgxF3zwee6T2G0EkSY8RxJNIlU5vQR1Q3uQAEiPzi8Aju5d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732733999; c=relaxed/simple;
	bh=Q9lD0FFdsE2KuX9EExX2wAlkFfqAIiMM16sS73q7On4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TpvJ5r/EmBZ0DF44v6/Ngbk/wBJJtfpqoEhOCtfHAbprFO4w9Gxo1TzCRKPwYiQjfmUqMKAVeBSe/1BZwLRrS7IlGNLX7hyqjESW1+oKHKT4rwEYn0gTUn7/Rsf9KFpQLzbSuAuOByqP3fE8p/n/2C6jZ1pS+mAfsU5mMiAhyC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=Z6mYFFjA; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc.intra.ispras.ru (unknown [10.10.165.4])
	by mail.ispras.ru (Postfix) with ESMTPSA id EDCD2518E76F;
	Wed, 27 Nov 2024 18:59:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru EDCD2518E76F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1732733992;
	bh=IbWtycDxvF+2Dy4hwBe4BTV3k5eyFHoRBLH861A4gOI=;
	h=From:To:Cc:Subject:Date:From;
	b=Z6mYFFjAn6JgbSPD5vF9Vm0kclH6Et4l/3KZmgaE7c7JVyqPY0YIPQtlTJn8wpS8D
	 bukRG+IeNWgKspQ/zepNoe3iv7PR1vfotYqd/KG15qx7I0xBkRhcMllYWO2UQdF6jc
	 2NiyBgbhYUPhbKBDy8WUdwdDSTue8A923iKGjZPs=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Christoph Hellwig <hch@lst.de>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] dma-debug: fix physical address calculation for struct dma_debug_entry
Date: Wed, 27 Nov 2024 21:59:26 +0300
Message-Id: <20241127185926.168102-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Offset into the page should also be considered while calculating a physical
address for struct dma_debug_entry. page_to_phys() just shifts the value
PAGE_SHIFT bits to the left so offset part is zero-filled.

An example (wrong) debug assertion failure with CONFIG_DMA_API_DEBUG
enabled which is observed during systemd boot process after recent
dma-debug changes:

DMA-API: e1000 0000:00:03.0: cacheline tracking EEXIST, overlapping mappings aren't supported
WARNING: CPU: 4 PID: 941 at kernel/dma/debug.c:596 add_dma_entry
CPU: 4 UID: 0 PID: 941 Comm: ip Not tainted 6.12.0+ #288
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:add_dma_entry kernel/dma/debug.c:596 
Call Trace:
 <TASK>
debug_dma_map_page kernel/dma/debug.c:1236 
dma_map_page_attrs kernel/dma/mapping.c:179
e1000_alloc_rx_buffers drivers/net/ethernet/intel/e1000/e1000_main.c:4616
...

Found by Linux Verification Center (linuxtesting.org).

Fixes: 9d4f645a1fd4 ("dma-debug: store a phys_addr_t in struct dma_debug_entry")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 kernel/dma/debug.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 295396226f31..27ade2bab531 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -1219,7 +1219,7 @@ void debug_dma_map_page(struct device *dev, struct page *page, size_t offset,
 
 	entry->dev       = dev;
 	entry->type      = dma_debug_single;
-	entry->paddr	 = page_to_phys(page);
+	entry->paddr	 = page_to_phys(page) + offset;
 	entry->dev_addr  = dma_addr;
 	entry->size      = size;
 	entry->direction = direction;
@@ -1400,7 +1400,8 @@ void debug_dma_alloc_coherent(struct device *dev, size_t size,
 	entry->type      = dma_debug_coherent;
 	entry->dev       = dev;
 	entry->paddr	 = page_to_phys((is_vmalloc_addr(virt) ?
-				vmalloc_to_page(virt) : virt_to_page(virt)));
+				vmalloc_to_page(virt) : virt_to_page(virt))) +
+				offset_in_page(virt);
 	entry->size      = size;
 	entry->dev_addr  = dma_addr;
 	entry->direction = DMA_BIDIRECTIONAL;
@@ -1424,7 +1425,8 @@ void debug_dma_free_coherent(struct device *dev, size_t size,
 		return;
 
 	ref.paddr = page_to_phys((is_vmalloc_addr(virt) ?
-			vmalloc_to_page(virt) : virt_to_page(virt)));
+			vmalloc_to_page(virt) : virt_to_page(virt))) +
+			offset_in_page(virt);
 
 	if (unlikely(dma_debug_disabled()))
 		return;
-- 
2.39.5



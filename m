Return-Path: <linux-kernel+bounces-275175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 103AF94816C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 20:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B086F1F239B9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2F916BE3F;
	Mon,  5 Aug 2024 18:09:11 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3759315F3F9;
	Mon,  5 Aug 2024 18:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722881351; cv=none; b=TQAWXYrSd7mBmszA1a+6rDylLgniM4Fn2li0nz1kxcL8dLn40KOpjAHi7E11V4TBYl4UFXybBD3PEcUwnAw7pFzVA7tv+AKwPux0QiGWwLsprZ/REhexW1nZy03480OCJOA+ud2+jZ/YBcUk1kF29yPO/+Aqkto8RRAmfIrTIMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722881351; c=relaxed/simple;
	bh=ZlL/bZnKxgelWGM+f2zkxYAgtHUZrVdQ2f0Z10Znte8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=bht0w12eS3KdVcrvXvjxkKtCciAM8LR96FdzGbfOv5nHoTX0uu/djrGpgszt48QjMcpEahDldGYLNj91WSP4s4KyBRdpn/Cq3qVFAKcWgl3CFn9J5FQHv9mvv4Ylw8QSA/hvrNkbkXCeP/RWhGuNFyKXr1tXLmvm3FsIMs91B/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1sb28T-000000008VH-2KyJ;
	Mon, 05 Aug 2024 14:08:45 -0400
Date: Mon, 5 Aug 2024 14:08:44 -0400
From: Rik van Riel <riel@surriel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Breno Leitao <leitao@debian.org>, kernel-team@meta.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] dma,debug: avoid deadlock between dma debug vs printk and
 netcons
Message-ID: <20240805140844.6a863c76@imladris.surriel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: riel@surriel.com

Currently the dma debugging code can end up indirectly calling
printk under the radix_lock. This happens when a radix tree node
allocation fails.

This is a problem because the printk code, when used together
with netcons, can end up inside the dma debugging code while
trying to transmit a message over netcons.

This creates the possibility of either a circular deadlock
on the same CPU, with that CPU trying to grab the radix_lock
twice, or an ABBA deadlock between different CPUs, where one
CPU grabs the console lock first and then waits for the
radix_lock, while the other CPU is holding the radix_lock
and is waiting for the console lock.

The trace captured by lockdep is of the ABBA variant.

-> #2 (&dma_entry_hash[i].lock){-.-.}-{2:2}:
                  _raw_spin_lock_irqsave+0x5a/0x90
                  debug_dma_map_page+0x79/0x180
                  dma_map_page_attrs+0x1d2/0x2f0
                  bnxt_start_xmit+0x8c6/0x1540
                  netpoll_start_xmit+0x13f/0x180
                  netpoll_send_skb+0x20d/0x320
                  netpoll_send_udp+0x453/0x4a0
                  write_ext_msg+0x1b9/0x460
                  console_flush_all+0x2ff/0x5a0
                  console_unlock+0x55/0x180
                  vprintk_emit+0x2e3/0x3c0
                  devkmsg_emit+0x5a/0x80
                  devkmsg_write+0xfd/0x180
                  do_iter_readv_writev+0x164/0x1b0
                  vfs_writev+0xf9/0x2b0
                  do_writev+0x6d/0x110
                  do_syscall_64+0x80/0x150
                  entry_SYSCALL_64_after_hwframe+0x4b/0x53

-> #0 (console_owner){-.-.}-{0:0}:
                  __lock_acquire+0x15d1/0x31a0
                  lock_acquire+0xe8/0x290
                  console_flush_all+0x2ea/0x5a0
                  console_unlock+0x55/0x180
                  vprintk_emit+0x2e3/0x3c0
                  _printk+0x59/0x80
                  warn_alloc+0x122/0x1b0
                  __alloc_pages_slowpath+0x1101/0x1120
                  __alloc_pages+0x1eb/0x2c0
                  alloc_slab_page+0x5f/0x150
                  new_slab+0x2dc/0x4e0
                  ___slab_alloc+0xdcb/0x1390
                  kmem_cache_alloc+0x23d/0x360
                  radix_tree_node_alloc+0x3c/0xf0
                  radix_tree_insert+0xf5/0x230
                  add_dma_entry+0xe9/0x360
                  dma_map_page_attrs+0x1d2/0x2f0
                  __bnxt_alloc_rx_frag+0x147/0x180
                  bnxt_alloc_rx_data+0x79/0x160
                  bnxt_rx_skb+0x29/0xc0
                  bnxt_rx_pkt+0xe22/0x1570
                  __bnxt_poll_work+0x101/0x390
                  bnxt_poll+0x7e/0x320
                  __napi_poll+0x29/0x160
                  net_rx_action+0x1e0/0x3e0
                  handle_softirqs+0x190/0x510
                  run_ksoftirqd+0x4e/0x90
                  smpboot_thread_fn+0x1a8/0x270
                  kthread+0x102/0x120
                  ret_from_fork+0x2f/0x40
                  ret_from_fork_asm+0x11/0x20

This bug is more likely than it seems, because when one
CPU has run out of memory, chances are the other has too.

The good news is, this bug is hidden behind the
CONFIG_DMA_API_DEBUG, so not many users are likely to
trigger it.

Signed-off-by: Rik van Riel <riel@surriel.com>
Reported-by: Konstantin Ovsepian <ovs@meta.com>
---
 kernel/dma/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index a6e3792b15f8..dc96e414be38 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -417,7 +417,7 @@ static unsigned long long phys_addr(struct dma_debug_entry *entry)
  * other hand, consumes a single dma_debug_entry, but inserts 'nents'
  * entries into the tree.
  */
-static RADIX_TREE(dma_active_cacheline, GFP_ATOMIC);
+static RADIX_TREE(dma_active_cacheline, GFP_ATOMIC | __GFP_NOWARN);
 static DEFINE_SPINLOCK(radix_lock);
 #define ACTIVE_CACHELINE_MAX_OVERLAP ((1 << RADIX_TREE_MAX_TAGS) - 1)
 #define CACHELINE_PER_PAGE_SHIFT (PAGE_SHIFT - L1_CACHE_SHIFT)
-- 
2.45.2




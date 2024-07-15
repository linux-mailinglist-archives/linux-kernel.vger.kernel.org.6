Return-Path: <linux-kernel+bounces-251960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A8D930C36
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 02:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3F96281526
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 00:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE5FEC0;
	Mon, 15 Jul 2024 00:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f1G+caIB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FC6629
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 00:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721001890; cv=none; b=lOcpR+imuGYRDZns6Ez2X6Q5W2UhBkBaEMsyG02NAeOeXJ4etLq8gj3PtJac0/XfA/esKW1srlqY4KPi+aXmKhhmjXilzkWUsmLhmYO5k6hlxJ1DyPAx0sZd0Dbl6g9RlTr3Df/EJSxz7DZks1Gtw+fhrQxvRags9eTa1izRXLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721001890; c=relaxed/simple;
	bh=o58G3LZ0VYLSoaLoI0Wn+i7Rb8RzjX1BvBjyvuZUUDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m2n6jmeP5oax1jK5+h7QoP2Xqivo6qEPE2pQ5Uu+FNefBJzX1tGNqc+DknbduuIG3K8K5yUceZUCgQGWpMs5ldvuTB9EK2kbHyE8fDhx/zJuKw1UeTMoJASIJPH/t3PFIwvH7W5ar+YfZSeIEJY8eS9D82A9M2rrkzPbAzlVlpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f1G+caIB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721001886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ss5nvLQlRresfaFy+QpvOrR2/iS4IZAR4myhGSH4g6k=;
	b=f1G+caIBm4v3rktkMEYSjLrbrvaXpgb9fDoqzZclqzC4Rp9nYVCxMTSxUVTYvpOqOv5qOa
	HFxwx4MJaa5SZDBMouhGHMnzx0z/o/7dGcqMw7ScHjN4vt7QYyZFR4avoMxvl6AtFxr7mh
	IOjt5W8xY+rPjFfJBxWPLLCWXFJk3mk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-7gFk26TCPi-Qi9Tyr7ZSCQ-1; Sun,
 14 Jul 2024 20:04:43 -0400
X-MC-Unique: 7gFk26TCPi-Qi9Tyr7ZSCQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B1F931944D30;
	Mon, 15 Jul 2024 00:04:40 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.14])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 910E919560AE;
	Mon, 15 Jul 2024 00:04:33 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	willy@infradead.org,
	baohua@kernel.org,
	ryan.roberts@arm.com,
	peterx@redhat.com,
	ziy@nvidia.com,
	william.kucharski@oracle.com,
	baolin.wang@linux.alibaba.com,
	ddutile@redhat.com,
	shan.gavin@gmail.com
Subject: [PATCH v2] mm/huge_memory: Avoid PMD-size page cache if needed
Date: Mon, 15 Jul 2024 10:04:23 +1000
Message-ID: <20240715000423.316491-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

xarray can't support arbitrary page cache size. the largest and
supported page cache size is defined as MAX_PAGECACHE_ORDER by
commit 099d90642a71 ("mm/filemap: make MAX_PAGECACHE_ORDER acceptable
to xarray"). However, it's possible to have 512MB page cache in
the huge memory's collapsing path on ARM64 system whose base page
size is 64KB. 512MB page cache is breaking the limitation and a
warning is raised when the xarray entry is split as shown in the
following example.

[root@dhcp-10-26-1-207 ~]# cat /proc/1/smaps | grep KernelPageSize
KernelPageSize:       64 kB
[root@dhcp-10-26-1-207 ~]# cat /tmp/test.c
   :
int main(int argc, char **argv)
{
	const char *filename = TEST_XFS_FILENAME;
	int fd = 0;
	void *buf = (void *)-1, *p;
	int pgsize = getpagesize();
	int ret = 0;

	if (pgsize != 0x10000) {
		fprintf(stdout, "System with 64KB base page size is required!\n");
		return -EPERM;
	}

	system("echo 0 > /sys/devices/virtual/bdi/253:0/read_ahead_kb");
	system("echo 1 > /proc/sys/vm/drop_caches");

	/* Open the xfs file */
	fd = open(filename, O_RDONLY);
	assert(fd > 0);

	/* Create VMA */
	buf = mmap(NULL, TEST_MEM_SIZE, PROT_READ, MAP_SHARED, fd, 0);
	assert(buf != (void *)-1);
	fprintf(stdout, "mapped buffer at 0x%p\n", buf);

	/* Populate VMA */
	ret = madvise(buf, TEST_MEM_SIZE, MADV_NOHUGEPAGE);
	assert(ret == 0);
	ret = madvise(buf, TEST_MEM_SIZE, MADV_POPULATE_READ);
	assert(ret == 0);

	/* Collapse VMA */
	ret = madvise(buf, TEST_MEM_SIZE, MADV_HUGEPAGE);
	assert(ret == 0);
	ret = madvise(buf, TEST_MEM_SIZE, MADV_COLLAPSE);
	if (ret) {
		fprintf(stdout, "Error %d to madvise(MADV_COLLAPSE)\n", errno);
		goto out;
	}

	/* Split xarray entry. Write permission is needed */
	munmap(buf, TEST_MEM_SIZE);
	buf = (void *)-1;
	close(fd);
	fd = open(filename, O_RDWR);
	assert(fd > 0);
	fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
 		  TEST_MEM_SIZE - pgsize, pgsize);
out:
	if (buf != (void *)-1)
		munmap(buf, TEST_MEM_SIZE);
	if (fd > 0)
		close(fd);

	return ret;
}

[root@dhcp-10-26-1-207 ~]# gcc /tmp/test.c -o /tmp/test
[root@dhcp-10-26-1-207 ~]# /tmp/test
 ------------[ cut here ]------------
 WARNING: CPU: 25 PID: 7560 at lib/xarray.c:1025 xas_split_alloc+0xf8/0x128
 Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib    \
 nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct      \
 nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4      \
 ip_set rfkill nf_tables nfnetlink vfat fat virtio_balloon drm fuse   \
 xfs libcrc32c crct10dif_ce ghash_ce sha2_ce sha256_arm64 virtio_net  \
 sha1_ce net_failover virtio_blk virtio_console failover dimlib virtio_mmio
 CPU: 25 PID: 7560 Comm: test Kdump: loaded Not tainted 6.10.0-rc7-gavin+ #9
 Hardware name: QEMU KVM Virtual Machine, BIOS edk2-20240524-1.el9 05/24/2024
 pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
 pc : xas_split_alloc+0xf8/0x128
 lr : split_huge_page_to_list_to_order+0x1c4/0x780
 sp : ffff8000ac32f660
 x29: ffff8000ac32f660 x28: ffff0000e0969eb0 x27: ffff8000ac32f6c0
 x26: 0000000000000c40 x25: ffff0000e0969eb0 x24: 000000000000000d
 x23: ffff8000ac32f6c0 x22: ffffffdfc0700000 x21: 0000000000000000
 x20: 0000000000000000 x19: ffffffdfc0700000 x18: 0000000000000000
 x17: 0000000000000000 x16: ffffd5f3708ffc70 x15: 0000000000000000
 x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
 x11: ffffffffffffffc0 x10: 0000000000000040 x9 : ffffd5f3708e692c
 x8 : 0000000000000003 x7 : 0000000000000000 x6 : ffff0000e0969eb8
 x5 : ffffd5f37289e378 x4 : 0000000000000000 x3 : 0000000000000c40
 x2 : 000000000000000d x1 : 000000000000000c x0 : 0000000000000000
 Call trace:
  xas_split_alloc+0xf8/0x128
  split_huge_page_to_list_to_order+0x1c4/0x780
  truncate_inode_partial_folio+0xdc/0x160
  truncate_inode_pages_range+0x1b4/0x4a8
  truncate_pagecache_range+0x84/0xa0
  xfs_flush_unmap_range+0x70/0x90 [xfs]
  xfs_file_fallocate+0xfc/0x4d8 [xfs]
  vfs_fallocate+0x124/0x2f0
  ksys_fallocate+0x4c/0xa0
  __arm64_sys_fallocate+0x24/0x38
  invoke_syscall.constprop.0+0x7c/0xd8
  do_el0_svc+0xb4/0xd0
  el0_svc+0x44/0x1d8
  el0t_64_sync_handler+0x134/0x150
  el0t_64_sync+0x17c/0x180

Fix it by correcting the supported page cache orders, different sets
for DAX and other files. With it corrected, 512MB page cache becomes
disallowed on all non-DAX files on ARM64 system where the base page
size is 64KB. After this patch is applied, the test program fails
with error -EINVAL returned from __thp_vma_allowable_orders() and
the madvise() system call to collapse the page caches.

Fixes: 6b24ca4a1a8d ("mm: Use multi-index entries in the page cache")
Cc: <stable@vger.kernel.org> # v5.17+
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
v2: Corrected supported orders for DAX and other files as suggested
    by David/Matthew/Baolin
---
 include/linux/huge_mm.h | 12 +++++++++---
 mm/huge_memory.c        | 12 ++++++++++--
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 2aa986a5cd1b..c73ad77fa33d 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -72,14 +72,20 @@ extern struct kobj_attribute shmem_enabled_attr;
 #define THP_ORDERS_ALL_ANON	((BIT(PMD_ORDER + 1) - 1) & ~(BIT(0) | BIT(1)))
 
 /*
- * Mask of all large folio orders supported for file THP.
+ * Mask of all large folio orders supported for file THP. Folios in a DAX
+ * file is never split and the MAX_PAGECACHE_ORDER limit does not apply to
+ * it.
  */
-#define THP_ORDERS_ALL_FILE	(BIT(PMD_ORDER) | BIT(PUD_ORDER))
+#define THP_ORDERS_ALL_FILE_DAX		\
+	(BIT(PMD_ORDER) | BIT(PUD_ORDER))
+#define THP_ORDERS_ALL_FILE_DEFAULT	\
+	((BIT(MAX_PAGECACHE_ORDER + 1) - 1) & ~BIT(0))
 
 /*
  * Mask of all large folio orders supported for THP.
  */
-#define THP_ORDERS_ALL		(THP_ORDERS_ALL_ANON | THP_ORDERS_ALL_FILE)
+#define THP_ORDERS_ALL	\
+	(THP_ORDERS_ALL_ANON | THP_ORDERS_ALL_FILE_DAX | THP_ORDERS_ALL_FILE_DEFAULT)
 
 #define TVA_SMAPS		(1 << 0)	/* Will be used for procfs */
 #define TVA_IN_PF		(1 << 1)	/* Page fault handler */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2120f7478e55..4690f33afaa6 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -88,9 +88,17 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 	bool smaps = tva_flags & TVA_SMAPS;
 	bool in_pf = tva_flags & TVA_IN_PF;
 	bool enforce_sysfs = tva_flags & TVA_ENFORCE_SYSFS;
+	unsigned long supported_orders;
+
 	/* Check the intersection of requested and supported orders. */
-	orders &= vma_is_anonymous(vma) ?
-			THP_ORDERS_ALL_ANON : THP_ORDERS_ALL_FILE;
+	if (vma_is_anonymous(vma))
+		supported_orders = THP_ORDERS_ALL_ANON;
+	else if (vma_is_dax(vma))
+		supported_orders = THP_ORDERS_ALL_FILE_DAX;
+	else
+		supported_orders = THP_ORDERS_ALL_FILE_DEFAULT;
+
+	orders &= supported_orders;
 	if (!orders)
 		return 0;
 
-- 
2.45.2



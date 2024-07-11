Return-Path: <linux-kernel+bounces-249015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1569292E50E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 419161C21E58
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646C1156F5D;
	Thu, 11 Jul 2024 10:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kv6iTVF3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA56149E15
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 10:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720694976; cv=none; b=ouM6adM9yRHbgx8T7EXbivghs0qAWmtU0olOIofvtnjjOqXyu/Jnndy5wOTk9tWnATTLmEhkAhfuVXI9SsXV4CcNxa4qSETjPEd/pIDnY2ipYqQ5AwkIxJJqdrO/N0pZKYGC00ModO+k5dhvPStHTZJHWZXT7CwhOWtFHJ2btqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720694976; c=relaxed/simple;
	bh=XXVKLrd1IMiPrtBxjlRxfKvg4Oil4eY2nBwgOKodzTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qrkaO+rztauaRm+0JWM7aR9QCs3iQLRFdTMajI0eFGrjNddhQLxrAKpnI/WIZbk7gr3vUSjEbI5MMxrt9DA0YWnx4ktDvmGiF58guH1nn9jSe2s/T7x9FOu6VznBmdrraBZW4+3xtGnZ41uaNorphMk6AjJuuThbipXxg+49Nwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kv6iTVF3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720694973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tZC3wpUX2uGzu3svYpunH5/qYl9NuP85eye8VqVTeVk=;
	b=Kv6iTVF3gh2Zzr1/yv5JTfu2xKrJRomDr97Y05gNHqftXrdqGyqizE8S8dSuuqQ7kTVFwl
	/Z4pQggqeDxMfiXaSh2rCMUp+bNhAPoE/cBJSA623081oHqy78qkSrp6QBWLtIrMHWGkw5
	AhCxk037b6vJusaN258NCs3UP6o9mBI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-18-xS58UjoBPoWgHtVH316iHA-1; Thu,
 11 Jul 2024 06:49:27 -0400
X-MC-Unique: xS58UjoBPoWgHtVH316iHA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 914F719560B9;
	Thu, 11 Jul 2024 10:49:25 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.68])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A72A19560AA;
	Thu, 11 Jul 2024 10:49:20 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	william.kucharski@oracle.com,
	willy@infradead.org,
	david@redhat.com,
	ryan.roberts@arm.com,
	shan.gavin@gmail.com
Subject: [PATCH] mm/huge_memory: Avoid PMD-size page cache if needed
Date: Thu, 11 Jul 2024 20:48:40 +1000
Message-ID: <20240711104840.200573-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Currently, xarray can't support arbitrary page cache size and the
largest and supported page cache size is defined as MAX_PAGECACHE_ORDER
in commit 099d90642a71 ("mm/filemap: make MAX_PAGECACHE_ORDER acceptable
to xarray"). However, it's possible to have 512MB page cache in the huge
memory collapsing path on ARM64 system whose base page size is 64KB. A
warning is raised when the huge page cache is split as shown in the
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

	/* Open xfs or shmem file */
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

	/* Split xarray. The file needs to reopened with write permission */
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

Fix it by avoiding PMD-sized page cache in the huge memory collapsing
path. After this patch is applied, the test program fails with error
-EINVAL returned from __thp_vma_allowable_orders() and the madvise()
system call to collapse the page caches.

Fixes: 6b24ca4a1a8d ("mm: Use multi-index entries in the page cache")
Cc: <stable@vger.kernel.org>  # v5.17+
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 mm/huge_memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2120f7478e55..e9335ac667be 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -136,7 +136,8 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 
 		while (orders) {
 			addr = vma->vm_end - (PAGE_SIZE << order);
-			if (thp_vma_suitable_order(vma, addr, order))
+			if (!(vma->vm_file && order > MAX_PAGECACHE_ORDER) &&
+			    thp_vma_suitable_order(vma, addr, order))
 				break;
 			order = next_order(&orders, order);
 		}
-- 
2.45.2



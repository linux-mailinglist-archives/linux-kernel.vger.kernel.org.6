Return-Path: <linux-kernel+bounces-168623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FE88BBAEE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 13:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2D051C210D2
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 11:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B77839FD8;
	Sat,  4 May 2024 11:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="XdSKjOKx"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4DD210EC
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 11:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714823320; cv=none; b=sZPmjQ75oPLBGZ0UEkHmHdCIrXHcfi3R3dIM9ISAKlT40FGwGkOXGd+Zky+6L4x5VxMjy6Op/e7hhus9iOoU2zp4ImrU7fJY71KvIC+GomKsv1isORzzlIGaDo9E8sws9sCYZ9DIublIKkeOhe52GUXTQVppBC3AmiNbaU5WexU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714823320; c=relaxed/simple;
	bh=cDHnzaVmZj1P/Yo5aKbOtea9ZLJDWirFLzj/JIj75tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RjjkeKDeUwHwoOoLt472jJdWc2z48gm8T7PNp21u3ofBH2Q/vg60WUngDOVm7zUkTvsZMdFtnKR+rGE32rimngwI4tpBzDs9oYQQm8aOElDRaczeTutVufo2d4/E6dKjZ2EtvNC6UALHdkpF23jgWnPgLu47HLSz+nX2EAZPqK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=XdSKjOKx; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost.localdomain (unknown [5.228.116.47])
	by mail.ispras.ru (Postfix) with ESMTPSA id BD9D240737B5;
	Sat,  4 May 2024 11:48:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru BD9D240737B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1714823315;
	bh=RxA857iBR0FODbLGi/CqJrg5YTNv0+6aonrAsG0UTyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XdSKjOKxtwI6PpBHM1CliTSnQeqoNF+HV7nzw/rD2j9XZKWwXMgw7DqxB8bUBtX1j
	 T/AZ4xXOs/hptpzKwgFNUWR3DYP2Vm6DuW8jYV6iqNXXB5/XlXWCNY2g8SQp47/iBh
	 Aqq0eljU1+MkOGPnuGzHWGspTCCyVAS0Rv+voFOg=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Xiang Chen <chenxiang66@hisilicon.com>,
	Barry Song <21cnbao@gmail.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: [PATCH v2 4/4] dma-mapping: benchmark: handle NUMA_NO_NODE correctly
Date: Sat,  4 May 2024 14:47:04 +0300
Message-ID: <20240504114713.567164-5-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240504114713.567164-1-pchelkin@ispras.ru>
References: <20240504114713.567164-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpumask_of_node() can be called for NUMA_NO_NODE inside do_map_benchmark()
resulting in the following sanitizer report:

UBSAN: array-index-out-of-bounds in ./arch/x86/include/asm/topology.h:72:28
index -1 is out of range for type 'cpumask [64][1]'
CPU: 1 PID: 990 Comm: dma_map_benchma Not tainted 6.9.0-rc6 #29
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
Call Trace:
 <TASK>
dump_stack_lvl (lib/dump_stack.c:117)
ubsan_epilogue (lib/ubsan.c:232)
__ubsan_handle_out_of_bounds (lib/ubsan.c:429)
cpumask_of_node (arch/x86/include/asm/topology.h:72) [inline]
do_map_benchmark (kernel/dma/map_benchmark.c:104)
map_benchmark_ioctl (kernel/dma/map_benchmark.c:246)
full_proxy_unlocked_ioctl (fs/debugfs/file.c:333)
__x64_sys_ioctl (fs/ioctl.c:890)
do_syscall_64 (arch/x86/entry/common.c:83)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

Use cpumask_of_node() in place when binding a kernel thread to a cpuset
of a particular node.

Note that the provided node id is checked inside map_benchmark_ioctl().
It's just a NUMA_NO_NODE case which is not handled properly later.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 65789daa8087 ("dma-mapping: add benchmark support for streaming DMA APIs")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 kernel/dma/map_benchmark.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index 9f6c15f3f168..4950e0b622b1 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -101,7 +101,6 @@ static int do_map_benchmark(struct map_benchmark_data *map)
 	struct task_struct **tsk;
 	int threads = map->bparam.threads;
 	int node = map->bparam.node;
-	const cpumask_t *cpu_mask = cpumask_of_node(node);
 	u64 loops;
 	int ret = 0;
 	int i;
@@ -124,7 +123,7 @@ static int do_map_benchmark(struct map_benchmark_data *map)
 		}
 
 		if (node != NUMA_NO_NODE)
-			kthread_bind_mask(tsk[i], cpu_mask);
+			kthread_bind_mask(tsk[i], cpumask_of_node(node));
 	}
 
 	/* clear the old value in the previous benchmark */
-- 
2.45.0



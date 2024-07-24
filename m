Return-Path: <linux-kernel+bounces-260679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F40093ACE8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4F111F2369F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 07:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A1255888;
	Wed, 24 Jul 2024 07:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="A4jK8Yj9"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B1D4C84
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 07:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721804671; cv=none; b=qCfc45bhKEbBNHFOsgeIOu3xIUnMIlrAhn4Ho4giEGFYnk4oEfOkUtzu3ZX7bgqZNjxJixtx3UyNd78DRkctR+g8UIvrtiQwsMZhAmlv/fF+fMvNHskyLCtvvtxGK0SIxB/oQ0VWtEspVLVMJtzVludIHZ6d08v16zCQWnzap3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721804671; c=relaxed/simple;
	bh=YDvV5zpzZNavinuh/5h43hpX4icFIp+N8Lqge4dX7zY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MfE9F1C9e2RomSWHIFRxt3HGKN1GL6TK/Qjd4/6I9Yo89PfGSRPMaePBPtIOmmvvcN/ybzWFwG31L78ILqniqrvQtaQLNyjwp5Qvg/aJONCy00HA6u1/PJUx3ffKek4Zjm1onB9hC4TjuzlCoST/nncEtayWSo/VwhkIUQk0lRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=A4jK8Yj9; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721804660; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=0NYBHprulQZtHPnfTUTw7qiedMYUcVzPoRU8gRrqzf4=;
	b=A4jK8Yj9lsuTBtXHRz1Qb3dKQ55LaQ6yUkKCZ30r5IlEfWU8hEp9mnDSSf3CQZxH2M5Ruivy7PkWdK4kG/y2Hm51PiocX1cUHzlUU9P1mRfwSA9bZeHNXVjC6UfQY37Z5Wc3gHVD/eqjwiWikKxFQbB4WrGwGl2xt4kmyMzFKnQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0WBDLAaE_1721804658;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WBDLAaE_1721804658)
          by smtp.aliyun-inc.com;
          Wed, 24 Jul 2024 15:04:19 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	ziy@nvidia.com,
	ioworker0@gmail.com,
	da.gomez@samsung.com,
	p.raghav@samsung.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] Support large folios for tmpfs
Date: Wed, 24 Jul 2024 15:03:57 +0800
Message-Id: <cover.1721720891.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This RFC patch series attempts to support large folios for tmpfs. The first
two patches are based on Daniel's previous patches in [1], mainly using the
length in the write and fallocate paths to get a highest order hint for large
order allocation. The last patch adds mTHP filter control for tmpfs if mTHP
is set for the following reasons:

1. Maintain backward compatibility for the control interface. Tmpfs already
has a global 'huge=' mount option and '/sys/kernel/mm/transparent_hugepage/shmem_enabled'
interface to control large order allocations. mTHP extends this capability to a
per-size basis while maintaining good interface compatibility.

2. For the large order allocation of writable mmap() faults in tmpfs, we need
something like the mTHP interfaces to control large orders, as well as ensuring
consistent interfaces with shmem.

3. Ryan pointed out that large order allocations based on write length could
lead to memory fragmentation issue. Just quoting Ryan's comment [2]:
"And it's possible (likely even, in my opinion) that allocating lots of different
folio sizes will exacerbate memory fragmentation, leading to more order-0
fallbacks, which would hurt the overall system performance in the long run, vs
restricting to a couple of folio sizes."

4. Some hardware preferences, such as for the ARM64 architecture, can better
utilize the cont-pte feature to reduce TLB pressure and optimize performance with
a 64K size folio. Using mTHP can better leverage these hardware advantages.

Please correct me if I missed something. Thanks a lot.

[1] https://lore.kernel.org/all/20240515055719.32577-1-da.gomez@samsung.com/
[2] https://lore.kernel.org/all/e83e1687-3e3c-40d0-bf0e-225871647092@arm.com/

Baolin Wang (1):
  mm: shmem: use mTHP interface to control huge orders for tmpfs

Daniel Gomez (2):
  mm: shmem: add file length arg in shmem_get_folio() path
  mm: shmem: add large folio support to the write and fallocate paths

 fs/xfs/scrub/xfile.c     |   6 +--
 fs/xfs/xfs_buf_mem.c     |   3 +-
 include/linux/shmem_fs.h |   6 +--
 mm/huge_memory.c         |   2 +-
 mm/khugepaged.c          |   3 +-
 mm/memory.c              |   4 +-
 mm/shmem.c               | 101 +++++++++++++++++++++++++++++----------
 mm/userfaultfd.c         |   2 +-
 8 files changed, 91 insertions(+), 36 deletions(-)

-- 
2.39.3



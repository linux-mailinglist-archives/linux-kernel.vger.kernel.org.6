Return-Path: <linux-kernel+bounces-358739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9BA998304
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA8961C21417
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D781BE872;
	Thu, 10 Oct 2024 09:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mf2nisBB"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B91C1A0BD1
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728554303; cv=none; b=MiV5ybL+aPLbaL8ezYRYYBqayRkkvo1msIgL2O+f8LZoP7wMFV31l/JIh+pGQJ0fBE/h02HAPMGdxjVYE+tOqlKFUludaAydcljV4dQeDEjn8HK0Z8kg8Ati2K+seelE2fYG7QL7A6EeHjvzIfYHzvwyq/fYYp9MXoU+E/AMJcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728554303; c=relaxed/simple;
	bh=rLfePOr/P3+++1M4V9kEA93lsZPAs8R5PvOdBWEQDA4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bdZHHC/Yl9xom7mwmlgGpuueMwpclSeKCAQWchZYD2O1zCG0jMNzvwDbyAhDOuZmLDQHQ7DksBPGlgT2zVyhI0SetyDSuZxsKy2DYE3DsvIjXDBAQy3sKDPrAIS1U9VT9cjY9HGBIu5rGO4H1CPFYIPs2MXowGLafw7WLYhXT/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mf2nisBB; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728554299; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=68SYjty2xW+7Wyn01Un2urytR1FCalqpR1eIGlQg1ks=;
	b=mf2nisBBG10nKgUqhSMsAwLO+Q6nDcI2GCYKBRftJ45PRSRxmDMa+2qFTjBwBcpvT1GeVXp6zalabZHx4gNKuUDESFDBEvrzQ3jmagCREvh9o4gTzCiMNFQXQhljXSiCF2fwDPTuEi41ZL8YRgHKRO3vwRvNUot2aMvwUvBn/N8=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WGlzQXW_1728554297 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 10 Oct 2024 17:58:18 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	wangkefeng.wang@huawei.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	ioworker0@gmail.com,
	da.gomez@samsung.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 0/4] Support large folios for tmpfs
Date: Thu, 10 Oct 2024 17:58:10 +0800
Message-Id: <cover.1728548374.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This RFC patch series attempts to support large folios for tmpfs. 

Considering that tmpfs already has the 'huge=' option to control the THP
allocation, it is necessary to maintain compatibility with the 'huge='
option, as well as considering the 'deny' and 'force' option controlled
by '/sys/kernel/mm/transparent_hugepage/shmem_enabled'.

Add a new huge option 'write_size' to support large folio allocation based
on the write size for tmpfs write and fallocate paths. So the huge pages
allocation strategy for tmpfs is that, if the 'huge=' option
(huge=always/within_size/advise) is enabled or the 'shmem_enabled' option
is 'force', it need just allow PMD sized THP to keep backward compatibility
for tmpfs. While 'huge=' option is disabled (huge=never) or the 'shmem_enabled'
option is 'deny', it will still disable any large folio allocations. Only
when the 'huge=' option is 'write_size', it will allow allocating large
folios based on the write size.

And I think the 'huge=write_size' option should be the default behavior
for tmpfs in future.

Any comments and suggestions are appreciated. Thanks.

Changes from RFC v2:
 - Drop mTHP interfaces to control huge page allocation, per Matthew.
 - Add a new helper to calculate the order, suggested by Matthew.
 - Add a new huge=write_size option to allocate large folios based on
   the write size.
 - Add a new patch to update the documentation.

Changes from RFC v1:
 - Drop patch 1.
 - Use 'write_end' to calculate the length in shmem_allowable_huge_orders().
 - Update shmem_mapping_size_order() per Daniel.

Baolin Wang (4):
  mm: factor out the order calculation into a new helper
  mm: shmem: change shmem_huge_global_enabled() to return huge order
    bitmap
  mm: shmem: add large folio support to the write and fallocate paths
    for tmpfs
  docs: tmpfs: add documention for 'write_size' huge option

 Documentation/filesystems/tmpfs.rst |   7 +-
 include/linux/pagemap.h             |  16 ++++-
 mm/shmem.c                          | 105 ++++++++++++++++++++--------
 3 files changed, 94 insertions(+), 34 deletions(-)

-- 
2.39.3



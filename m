Return-Path: <linux-kernel+bounces-340121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FEB986EC3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FB241F22D73
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FD21A4E82;
	Thu, 26 Sep 2024 08:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RsqqoUUT"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020E51A726C
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 08:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727339269; cv=none; b=I86KQPe+qWUkdSHd2JdOb8nIhN+1x52+MHsHU50E3F4+WbhGaxwh9zqXz+JEJjQLd23IS2L7vgJxf9a3Cc1cJKWaDFvcsN+HaT9braybi/xZNSP2k7Nga1kcJUSpgEuhLxLLjg5QAQmRv9ToFPbRAbcQEgxpLslp0FjARzcpbeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727339269; c=relaxed/simple;
	bh=/aGsMCKb3FJVn+vjSyt0I90GTXvXXUY+ez5ld+n1n+g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=upiWyVsUZ1XFEadb8/y1r7JQoYtwP6jsn9Wo/u0jUwIACFk7ikjLA5MJmZpJ+DiRJ9HOA0YVFbqt8fgdsSDhSXXJkUAS4caQchOd6yEy5nf2RC4TQ98r74wp6jCr//3R+b+FFmrGctxubxT6P3EQGkNRAvPuliyh3AwEi7wPUfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RsqqoUUT; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727339259; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=F+79Mmm9ctdCoF8VYkFvLVzQiHBgINg2lBAfCIV45Jg=;
	b=RsqqoUUTryF2gYQg+hO9CY8E2SENGcyLCafuWDzoslqgfO3ODTckTAoS1SXwW0/MuKJgJD7HSNht7bY2pwCJDmisDDvK0jlmX7usLi7hjbO/IeyjG0OOqhHHjfh4gL1G91wonejgxAbDjBreRW7PESLaStSe0PtM7wUJ91dNXxY=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WFmgaSC_1727339257)
          by smtp.aliyun-inc.com;
          Thu, 26 Sep 2024 16:27:38 +0800
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
Subject: [RFC PATCH v2 0/2] Support large folios for tmpfs
Date: Thu, 26 Sep 2024 16:27:25 +0800
Message-Id: <cover.1727338549.git.baolin.wang@linux.alibaba.com>
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
patch is based on Daniel's previous patches in [1], mainly using the length
in the write and fallocate paths to get a highest order hint for large
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

Any comments and suggestions are appreciated. Thanks.

[1] https://lore.kernel.org/all/20240515055719.32577-1-da.gomez@samsung.com/
[2] https://lore.kernel.org/all/e83e1687-3e3c-40d0-bf0e-225871647092@arm.com/

Changes from RFC v1:
 - Drop patch 1.
 - Use 'write_end' to calculate the length in shmem_allowable_huge_orders().
 - Update shmem_mapping_size_order() per Daniel.

Baolin Wang (1):
  mm: shmem: use mTHP interface to control huge orders for tmpfs

Daniel Gomez (1):
  mm: shmem: add large folio support to the write and fallocate paths

 mm/memory.c |  4 ++--
 mm/shmem.c  | 66 +++++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 58 insertions(+), 12 deletions(-)

-- 
2.39.3



Return-Path: <linux-kernel+bounces-300598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3E495E5A6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 01:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39F1A1F215C6
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 23:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AED677115;
	Sun, 25 Aug 2024 23:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cg3pEiMF"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C213378B4C
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 23:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724627662; cv=none; b=MjJoO/XvVCOOUSXpIBjELbIwNgZ5s8zGFBFw9YMar7y24E508ZNbn36vgmayGjAGrkJftCgeLJl05FspXJfetrBZY4mb02Rj7ZVrYJ3bwdo+HotodZTSePoeDdbGr095GlrVWc6HHJvtMNwy4qsMspdQ2YEbi2xt4t10qmBW/qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724627662; c=relaxed/simple;
	bh=Cd/K5RKA1FKL8JwrQsoZYz0vHYJskot9ZY74ovJatEA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=idjy8BzFDKKBB91Iyeq55+LYTg0GDva+Y32qIDootIYcQ140x0RHAcxxQWptW1pV5OzOdFYO3DHoivarkA6AXQkOxXeO5ftxI7P4gjAeMwRxqsvFZ+o5YGFlNf3RL6b+rizUulWwnLFA81tn6iHlBcTZHB96/sizx/BNgpVhNnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cg3pEiMF; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71433096e89so3060338b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 16:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724627660; x=1725232460; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mC6ZNidx5P90YPf8uENc5nx+UFKunBsUReK2aoP9rHQ=;
        b=cg3pEiMFG7yl+zH6GwWMoEdYIp00L/3FeCSpeeEGLYThJ7KaxC8btU0H22THaNui6c
         lYjlOj2rIKY/cjMix6X7EKKHlS1QpQjvaczkzfg420WGPUGCNwveu2eBTrLQHwvpO81i
         sAWhYTi7Z401OVbLokXm4PTT4QldnJbyRsIYukg9EkuBJ8LqfW3xxVl/zQQ5n3sYjX4y
         zISkkZfEjqk+iaw794wRbcW1/oApmmtJKKnQBzHXfkKPfbn5wyyWsEOVPRbhg5Ad42d7
         cQffZxkMq6VdiHDritwsxZvK0WmfhULfey6Kyd+a35XWGIo6nJLCZ1+Z1YiUnkYVGGzn
         bo5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724627660; x=1725232460;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mC6ZNidx5P90YPf8uENc5nx+UFKunBsUReK2aoP9rHQ=;
        b=F3eP5v8zHNKRVejnjrj6lhXQbN95lpPiBnNpWcnah4bKRizEeh2L0ZI2lfsRhB1EjN
         gAt5+Dt0fpX6NpxDlY7aXjoo3J9pFAcPuGrgpHx4anGFLeLl6OQxqTxHLvKyfXBF256g
         vflhsS68nNIvTUIj6ENNTHQbfeOKzzQtuFG3RABt4yFKaX9E+kIjGVO6XzZ3altB7ClZ
         S/TrJtTYbaGW0o+9mE0YrxQXdoSl3VrYBPOi1mlH33YUzwi2W9GJVVzL+343nEMGcpD0
         8SU9dB4MYtKkFQr6NE7XLVzrdbUckhEfI8HYNhRWSLD6bll4wk3RIz5H85wtODm4z+Dg
         YOig==
X-Forwarded-Encrypted: i=1; AJvYcCUAJQk8pp1IVyKfefOJA+hQiXDrj15XkA3pq9Ds43onabg1wWeXr3GaCw3WNoHhIKSp0a9Aq0zsI00/OGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD1VeV1O4ey+m4LQkvf6TemIQVaQh5zY67+HUhplLRJNL3a1oA
	+VBuYK6LoTf3Iwf5WEkkZJ03g7RXHDOZ/j2WAA+WEgrFE9b+Ijihag3gbbxBDA==
X-Google-Smtp-Source: AGHT+IGE9+OJfYdLhUWe3+YNVm5Vr+YvsjwDj/HUN/vjjDjaiK8QWqY92RdQvJI/j2XrPJlIyd5xhQ==
X-Received: by 2002:a05:6a00:1ace:b0:70e:a42e:3417 with SMTP id d2e1a72fcca58-7144578e8d4mr7657363b3a.10.1724627659635;
        Sun, 25 Aug 2024 16:14:19 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143430cc6fsm6259418b3a.177.2024.08.25.16.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 16:14:18 -0700 (PDT)
Date: Sun, 25 Aug 2024 16:14:17 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>
cc: hughd@google.com, willy@infradead.org, david@redhat.com, 
    wangkefeng.wang@huawei.com, chrisl@kernel.org, ying.huang@intel.com, 
    21cnbao@gmail.com, ryan.roberts@arm.com, shy828301@gmail.com, 
    ziy@nvidia.com, ioworker0@gmail.com, da.gomez@samsung.com, 
    p.raghav@samsung.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 9/9] mm: shmem: support large folio swap out
In-Reply-To: <d80c21abd20e1b0f5ca66b330f074060fb2f082d.1723434324.git.baolin.wang@linux.alibaba.com>
Message-ID: <aef55f8d-6040-692d-65e3-16150cce4440@google.com>
References: <cover.1723434324.git.baolin.wang@linux.alibaba.com> <d80c21abd20e1b0f5ca66b330f074060fb2f082d.1723434324.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 12 Aug 2024, Baolin Wang wrote:

> Shmem will support large folio allocation [1] [2] to get a better performance,
> however, the memory reclaim still splits the precious large folios when trying
> to swap out shmem, which may lead to the memory fragmentation issue and can not
> take advantage of the large folio for shmeme.
> 
> Moreover, the swap code already supports for swapping out large folio without
> split, hence this patch set supports the large folio swap out for shmem.
> 
> Note the i915_gem_shmem driver still need to be split when swapping, thus
> add a new flag 'split_large_folio' for writeback_control to indicate spliting
> the large folio.

Is that last paragraph a misunderstanding? The i915 THP splitting in
shmem_writepage() was to avoid mm VM_BUG_ONs and crashes when shmem.c
did not support huge page swapout: but now you are enabling that support,
and such VM_BUG_ONs and crashes are gone (so far as I can see: and this
is written on a laptop using the i915 driver).

I cannot think of why i915 itself would care how mm implements swapout
(beyond enjoying faster): I think all the wbc->split_large_folio you
introduce here should be reverted.  But you may know better!

I do need a further change to shmem_writepage() here: see fixup patch
below: that's written to apply on top of this 9/9, but I'd be glad to
see a replacement with wbc->split_large_folio gone, and just one
!IS_ENABLED(CONFIG_THP_SWAP) instead.

> 
> [1] https://lore.kernel.org/all/cover.1717495894.git.baolin.wang@linux.alibaba.com/
> [2] https://lore.kernel.org/all/20240515055719.32577-1-da.gomez@samsung.com/

I get "Not found" for that [2] link.

> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  drivers/gpu/drm/i915/gem/i915_gem_shmem.c |  1 +
>  include/linux/writeback.h                 |  4 +++
>  mm/shmem.c                                | 12 ++++++---
>  mm/vmscan.c                               | 32 ++++++++++++++++++-----
>  4 files changed, 38 insertions(+), 11 deletions(-)

[PATCH] mm: shmem: shmem_writepage() split folio at EOF before swapout

Working in a constrained (size= or nr_blocks=) huge=always tmpfs relies
on swapout to split a large folio at EOF, to trim off its excess before
hitting premature ENOSPC: shmem_unused_huge_shrink() contains no code to
handle splitting huge swap blocks, and nobody would want that to be added.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/shmem.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 37c300f69baf..4dd0570962fa 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1459,6 +1459,7 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 	swp_entry_t swap;
 	pgoff_t index;
 	int nr_pages;
+	bool split = false;
 
 	/*
 	 * Our capabilities prevent regular writeback or sync from ever calling
@@ -1480,8 +1481,20 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 	 * If /sys/kernel/mm/transparent_hugepage/shmem_enabled is "always" or
 	 * "force", drivers/gpu/drm/i915/gem/i915_gem_shmem.c gets huge pages,
 	 * and its shmem_writeback() needs them to be split when swapping.
+	 *
+	 * And shrinkage of pages beyond i_size does not split swap, so
+	 * swapout of a large folio crossing i_size needs to split too
+	 * (unless fallocate has been used to preallocate beyond EOF).
 	 */
-	if (wbc->split_large_folio && folio_test_large(folio)) {
+	if (folio_test_large(folio)) {
+		split = wbc->split_large_folio;
+		index = shmem_fallocend(inode,
+			DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE));
+		if (index > folio->index && index < folio_next_index(folio))
+			split = true;
+	}
+
+	if (split) {
 try_split:
 		/* Ensure the subpages are still dirty */
 		folio_test_set_dirty(folio);
-- 
2.35.3


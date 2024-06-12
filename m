Return-Path: <linux-kernel+bounces-210953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB6A904B07
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB3D31C22FB4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD58374C3;
	Wed, 12 Jun 2024 05:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g73qcUQy"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8A964A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 05:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718171212; cv=none; b=advCqceRtGekKJrCpY6swTC8AVykOA5iRt2OdqxCla+qjf6lGAbauVd6JKLdCJmVSinASNnckInoorMsu+6MGXLUbebiGTm/xUomJjn+SQevcP4XSp1J+HSfkjDd3hG0CFApw1AHAxHcO7EjphD55PpXjrSrXH22zqzBD3JuwrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718171212; c=relaxed/simple;
	bh=nzvsMGY13uJ7sQRH9JYlFRQ3OWBjIpc4hYbnM9L2CWs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JSVF8raLWZvy71b8lNQcvNn9g4qzlWzb39EuXsWfZo/nc4Kv+qeYXbu44yBdKYSdzQGEH92tebD/FXl3UX3NrBHh8kbjicWlhxPsCWtfWlr2kwl9h6erAYtMY8xzXPS/HALRZYEGV4/dNAK8fpke8MZfCwPJ+2CilF1I+YBUUEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g73qcUQy; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-62a0849f8e5so68995127b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 22:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718171209; x=1718776009; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=moJnHsIsot9+U+qmE6uaTW3P8PCz1p59VpzC+G7DvZY=;
        b=g73qcUQyCRBvH+yo19N5d1Fw9MYc23XhSrX9hbRCTJkZaotQYXyzZHqkogROBVh/+u
         RS17KhEaXi6p4dZlclsv8oEGX1cC5FF49H1YnCAuWrePUpujK6OrGOuk5uDdd26pjR30
         kvhOorm1Mom6G3O5VQ9a07SFcPR5KUTSgaZyRT0bhYhL2IWRYM8NwmK1U+Xp/F9Ca2kQ
         wE7VHJGWUr/Oatr0P3JchMYn/dLP45pKADcshfBR/jDXrDRoee2NobN/5gMDMBcPpWhF
         24dGmLp+jboS3rDP6Lp9jws/zSLNrq3vQmSnNNLV+rUvxTrwoJfSAIu8Hvqa5H1xF57t
         Kadw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718171209; x=1718776009;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=moJnHsIsot9+U+qmE6uaTW3P8PCz1p59VpzC+G7DvZY=;
        b=r6SqDsr87p9Z7wmXPl/OLnNQ6cioawN9fkAkeXR1+V2o4rt5ws1uGvXL/MfuJWmIFS
         nei7OtlwowPdE6p/b4Op66u44+e4D7RybSCTLXWGxi6sSugBhXMS5Pr4zGiGmeqgvTRS
         6ayXwSoGbCxuN2tTFVDDB/bSX5kfLWIncmacIlVlCqrm8ArAqYYwUKK2DxcfaJN50eoX
         CmEGpOupx2vywI56NscbV17KNbqEhZJWqLjVHRUyemy7M35RUAcKM/C97HNuaALzRq3Z
         d9SV94IZXJVO9THLDZpL4t2a6PnrwrYvS9HHuuU/OtW7NgdcH+HW9Yt/kRUOFamHeo9o
         TWdw==
X-Forwarded-Encrypted: i=1; AJvYcCVPPlZwvYZnWq1fk7bvjGxGUFVuq+fR2rk+DWnM1dyusnEXpgzhB1Qwa4yscfuE1wnt/IeJXQc7cVxdh7GcLcu1UhYGXfDkYYg9R216
X-Gm-Message-State: AOJu0YzCHnQOQTnfxstFrvf+ZR18qaX3qhI6J33TbBP3Xl0t+987/gzF
	b6C3LhK7V/BDQO/pIkO9UbSgtYKVkrUaYDSRTS2fWx5cQZc04NL41C7Sh5rIXA==
X-Google-Smtp-Source: AGHT+IGKs+qtmC+lPU0WP+6G10ji1oSZEVaWsH4gOFl+QYJT8h+ibgE3eVIvlQmm7E1leKVvM6n+ug==
X-Received: by 2002:a0d:e6d5:0:b0:60a:66c0:d5fe with SMTP id 00721157ae682-62fba9435edmr8488907b3.13.1718171209034;
        Tue, 11 Jun 2024 22:46:49 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62ccad1b679sm22806697b3.66.2024.06.11.22.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 22:46:48 -0700 (PDT)
Date: Tue, 11 Jun 2024 22:46:34 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org, 
    david@redhat.com, wangkefeng.wang@huawei.com, chrisl@kernel.org, 
    ying.huang@intel.com, 21cnbao@gmail.com, ryan.roberts@arm.com, 
    shy828301@gmail.com, ziy@nvidia.com, ioworker0@gmail.com, 
    da.gomez@samsung.com, p.raghav@samsung.com, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] support large folio swap-out and swap-in for shmem
In-Reply-To: <cover.1717673614.git.baolin.wang@linux.alibaba.com>
Message-ID: <7477de0e-e5bb-529d-e2c0-cabd0d39fb5c@google.com>
References: <cover.1717673614.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 6 Jun 2024, Baolin Wang wrote:

> Shmem will support large folio allocation [1] [2] to get a better performance,
> however, the memory reclaim still splits the precious large folios when trying
> to swap-out shmem, which may lead to the memory fragmentation issue and can not
> take advantage of the large folio for shmeme.
> 
> Moreover, the swap code already supports for swapping out large folio without
> split, and large folio swap-in[3] series is queued into mm-unstable branch.
> Hence this patch set also supports the large folio swap-out and swap-in for
> shmem.
> 
> [1] https://lore.kernel.org/all/cover.1717495894.git.baolin.wang@linux.alibaba.com/
> [2] https://lore.kernel.org/all/20240515055719.32577-1-da.gomez@samsung.com/
> [3] https://lore.kernel.org/all/20240508224040.190469-6-21cnbao@gmail.com/T/
> 
> Changes from RFC:
>  - Rebased to the latest mm-unstable.
>  - Drop the counter name fixing patch, which was queued into mm-hotfixes-stable
>  branch.
> 
> Baolin Wang (7):
>   mm: vmscan: add validation before spliting shmem large folio
>   mm: swap: extend swap_shmem_alloc() to support batch SWAP_MAP_SHMEM
>     flag setting
>   mm: shmem: support large folio allocation for shmem_replace_folio()
>   mm: shmem: extend shmem_partial_swap_usage() to support large folio
>     swap
>   mm: add new 'orders' parameter for find_get_entries() and
>     find_lock_entries()
>   mm: shmem: use swap_free_nr() to free shmem swap entries
>   mm: shmem: support large folio swap out
> 
>  drivers/gpu/drm/i915/gem/i915_gem_shmem.c |  1 +
>  include/linux/swap.h                      |  4 +-
>  include/linux/writeback.h                 |  1 +
>  mm/filemap.c                              | 27 ++++++-
>  mm/internal.h                             |  4 +-
>  mm/shmem.c                                | 58 ++++++++------
>  mm/swapfile.c                             | 98 ++++++++++++-----------
>  mm/truncate.c                             |  8 +-
>  mm/vmscan.c                               | 22 ++++-
>  9 files changed, 140 insertions(+), 83 deletions(-)

I wanted to have some tests running, while looking through these
and your shmem mTHP patches; but I wasted too much time on that by
applying these on top and hitting crash, OOMs and dreadful thrashing -
testing did not get very far at all.

Perhaps all easily fixed, but I don't have more time to spend on it,
and think this series cannot expect to go into 6.11: I'll have another
try with it next cycle.

I really must turn my attention to your shmem mTHP series: no doubt
I'll have minor adjustments to ask there - but several other people
are also waiting for me to respond (or given up on me completely).

The little crash fix needed in this series appears to be:

--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2053,7 +2053,8 @@ static int shmem_swapin_folio(struct ino
 			goto failed;
 	}
 
-	error = shmem_add_to_page_cache(folio, mapping, index,
+	error = shmem_add_to_page_cache(folio, mapping,
+					round_down(index, nr_pages),
 					swp_to_radix_entry(swap), gfp);
 	if (error)
 		goto failed;

Then the OOMs and dreadful thrashing are due to refcount confusion:
I did not even glance at these patches to work out what's wanted,
but a printk in __remove_mapping() showed that folio->_refcount was
1024 where 513 was expected, so reclaim was freeing none of them.

Hugh


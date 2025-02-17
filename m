Return-Path: <linux-kernel+bounces-515637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAABA36727
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 21:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D7A1893291
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 20:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1111D7E4A;
	Fri, 14 Feb 2025 20:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="INKco4EG"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7757D1C862E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 20:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739566702; cv=none; b=Y22sR7CqRaMTnBWV2ttab1lqBsZ8c4QHk84AhOeZmz6gwuh2HqmQ4KqJ8qT8UDm8nPy7aMO2N1awfyKwfTfdeLQ7QfTpD+aek9k3wEj4aN5Ek8azdcm4ZiJ3wpvkiUjnnpWbPD0uTsa6QYtyrEZipcws94C0XbrQ7FoohHG7Yoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739566702; c=relaxed/simple;
	bh=vaKwmHnAyriqw0O10M/Qwf2Y5vvws0cQSQXtACGqsfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=soSA9+JJvBU5KwlxkavmlsW8DjIo9swQZh3ie8gekB8HI4DF3MCMhWsoz8v0KfA9wS34WzU651wRZ7pKd1LfasSa6/20hhPUnRNeP9sMrLKFA1ZbZvlyXjG+csAt24bCcLdrs2P5z6iLSC0oVSAC+ivJydA5AyXfhM2nl85p3+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=INKco4EG; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21f8c280472so7485ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 12:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739566699; x=1740171499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YgySpnqFZLhvEyVlrQicLthetC3cVznXnvyAWuRKPc=;
        b=INKco4EGdnDB/fWUSfqA+LvgLTV4CSurw2RLCOUsI079ybiABggsMV8XKJdbeLtPM/
         ltbgjWU9Lf6Y+qGpq0tNjvpZSrBe0cY+jyBAs3CvWsLKs5ZILfnWw4yAWKRM4tSEQWmp
         2Qg23Wi+ZclT5NNc4Umd3oBKk2PJfVrgowt29059iQs+vcNL/XxHQEdpuZFBnBQhMyC4
         vNYDRmDGDc3/YhsSXZCY+aHw53mxssNWApbWySGnAEq4H4lneuq5dOj4MTTJQPXNzVL9
         QR5uHKF6zdNs6JwvC9B9gpc0ED6lemp9Zv4amatqgNX+gLjYvX90f9qgpiJ8MnHh3mPW
         B7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739566699; x=1740171499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YgySpnqFZLhvEyVlrQicLthetC3cVznXnvyAWuRKPc=;
        b=axE19Z/1+UcEo7h79yqg0bhbCJIGsR2TOn/P1EMhsXx82lCnDXWyluvk+iKac/kgK7
         TJGYVk4oXucxBdXsa/k79O3gRKRnFWQszMQEV49rNxRpZKQjJ7dvfdrvcwxKHQH5hVAK
         SlySeHtpXFZYA44f/Mh6L014qtGYAZ5UOSjTmaImaYxz2IqYZ/Cwbc5LayVRnECjsfTQ
         Epo06Bsh4G/EEgUsVqsUUEATsp5j/+/xBoY/l3a7XxOaFR/80Hnsh7Btg6YGLIqGg46C
         xnvF5eHjEwtAxJ3MWyEW9lFJJ13Ql8wqC4pZPkwPaIQ/suLnqEAxvOstqQXIFXNaqdSK
         yXyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYpxlPWunJUj9YTyLDt0heQkAakmQ7ZJ1zJRDv3Y3360wGTvGKPpmzA31gp6qE+grb7YhSoAoX77LIjkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWhTmdLDsgkfUFgF5yx+cpRgwKBHzBpisYZjJ3FT/Ofno2gB/I
	CXbqFyzJi2zFPksv3pcSeuQHyPcb//r5E9sQXZ9qJTsWobF1wYWSuGIuSnjPRZVSoHh/jJZ8//N
	3K2Q50NDtK1snBmqc9zGtVoOKVmWDEWdEPsFM
X-Gm-Gg: ASbGncv6huPmWjf3Iy3pHLocnfy7yNulnDJDkeARf9x2TkM/lrZvNUJWAlnp/ABHRNb
	2Vf9BI6iHDFI5B+nYDNoNaedz3U+zf85TrGEbXYA8uaYvMjn8A7g5Hx3E8uqkDjOoTbmHL3L3a4
	K7PIy3xnF1AUr30iSL8FGIxSBUMow=
X-Google-Smtp-Source: AGHT+IHMo7WsTDcyDI2IJxk30OmWpNkq4lqd/LDPkpSnJQoBmryh3jggnLVgBNK9KRLZbjUR8YF1jff3s8KWZZmox3M=
X-Received: by 2002:a17:902:d50d:b0:220:c905:689f with SMTP id
 d9443c01a7336-22104ec0a38mr369985ad.25.1739566699325; Fri, 14 Feb 2025
 12:58:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212092552.1779679-1-linyunsheng@huawei.com> <20250212092552.1779679-3-linyunsheng@huawei.com>
In-Reply-To: <20250212092552.1779679-3-linyunsheng@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 14 Feb 2025 12:58:05 -0800
X-Gm-Features: AWEUYZkrCnzHRX-UM7YzAnXpZTXuHcolUoh7nm-MSMVw8gpzJwYFTphmx0X5nYE
Message-ID: <CAHS8izPZe0UHn8P38EvzX0ei_jGJnsXg99B5ra9Ldu09aWBU-Q@mail.gmail.com>
Subject: Re: [PATCH net-next v9 2/4] page_pool: fix IOMMU crash when driver
 has already unbound
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	zhangkun09@huawei.com, liuyonglong@huawei.com, fanghaiqing@huawei.com, 
	Robin Murphy <robin.murphy@arm.com>, Alexander Duyck <alexander.duyck@gmail.com>, 
	IOMMU <iommu@lists.linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 1:34=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> Networking driver with page_pool support may hand over page
> still with dma mapping to network stack and try to reuse that
> page after network stack is done with it and passes it back
> to page_pool to avoid the penalty of dma mapping/unmapping.
> With all the caching in the network stack, some pages may be
> held in the network stack without returning to the page_pool
> soon enough, and with VF disable causing the driver unbound,
> the page_pool does not stop the driver from doing it's
> unbounding work, instead page_pool uses workqueue to check
> if there is some pages coming back from the network stack
> periodically, if there is any, it will do the dma unmmapping
> related cleanup work.
>
> As mentioned in [1], attempting DMA unmaps after the driver
> has already unbound may leak resources or at worst corrupt
> memory. Fundamentally, the page pool code cannot allow DMA
> mappings to outlive the driver they belong to.
>
> Currently it seems there are at least two cases that the page
> is not released fast enough causing dma unmmapping done after
> driver has already unbound:
> 1. ipv4 packet defragmentation timeout: this seems to cause
>    delay up to 30 secs.
> 2. skb_defer_free_flush(): this may cause infinite delay if
>    there is no triggering for net_rx_action().
>
> In order not to call DMA APIs to do DMA unmmapping after driver
> has already unbound and stall the unloading of the networking
> driver, use some pre-allocated item blocks to record inflight
> pages including the ones which are handed over to network stack,
> so the page_pool can do the DMA unmmapping for those pages when
> page_pool_destroy() is called. As the pre-allocated item blocks
> need to be large enough to avoid performance degradation, add a
> 'item_fast_empty' stat to indicate the unavailability of the
> pre-allocated item blocks.
>
> By using the 'struct page_pool_item' referenced by page->pp_item,
> page_pool is not only able to keep track of the inflight page to
> do dma unmmaping if some pages are still handled in networking
> stack when page_pool_destroy() is called, and networking stack is
> also able to find the page_pool owning the page when returning
> pages back into page_pool:
> 1. When a page is added to the page_pool, an item is deleted from
>    pool->hold_items and set the 'pp_netmem' pointing to that page
>    and set item->state and item->pp_netmem accordingly in order to
>    keep track of that page, refill from pool->release_items when
>    pool->hold_items is empty or use the item from pool->slow_items
>    when fast items run out.
> 2. When a page is released from the page_pool, it is able to tell
>    which page_pool this page belongs to by masking off the lower
>    bits of the pointer to page_pool_item *item, as the 'struct
>    page_pool_item_block' is stored in the top of a struct page. And
>    after clearing the pp_item->state', the item for the released page
>    is added back to pool->release_items so that it can be reused for
>    new pages or just free it when it is from the pool->slow_items.
> 3. When page_pool_destroy() is called, item->state is used to tell if
>    a specific item is being used/dma mapped or not by scanning all the
>    item blocks in pool->item_blocks, then item->netmem can be used to
>    do the dma unmmaping if the corresponding inflight page is dma
>    mapped.
>
> The overhead of tracking of inflight pages is about 10ns~20ns,
> which causes about 10% performance degradation for the test case
> of time_bench_page_pool03_slow() in [2].
>
> Note, the devmem patchset seems to make the bug harder to fix,
> and may make backporting harder too. As there is no actual user
> for the devmem and the fixing for devmem is unclear for now,
> this patch does not consider fixing the case for devmem yet.
>
> 1. https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kern=
el.org/T/
> 2. https://github.com/netoptimizer/prototype-kernel
> CC: Robin Murphy <robin.murphy@arm.com>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> CC: IOMMU <iommu@lists.linux.dev>
> Fixes: f71fec47c2df ("page_pool: make sure struct device is stable")
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> Tested-by: Yonglong Liu <liuyonglong@huawei.com>
[...]
> +
> +/* The size of item_block is always PAGE_SIZE, so that the address of it=
em_block
> + * for a specific item can be calculated using 'item & PAGE_MASK'
> + */
> +struct page_pool_item_block {
> +       struct page_pool *pp;
> +       struct list_head list;
> +       struct page_pool_item items[];
> +};
> +

I think this feedback was mentioned in earlier iterations of the series:

Can we not hold a struct list_head in the page_pool that keeps track
of inflight netmems that we need to dma-unmap on page_pool_destroy?
Why do we have to modify the pp entry in the struct page and struct
net_iov?

The decision to modify pp entry in struct page and struct net_iov is
making this patchset bigger and harder to review IMO.

--=20
Thanks,
Mina


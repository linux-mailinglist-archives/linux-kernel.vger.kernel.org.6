Return-Path: <linux-kernel+bounces-551252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A5AA56A1E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 041921776FA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8F91A8F68;
	Fri,  7 Mar 2025 14:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cfnaHWqT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92FB2185BC
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741356932; cv=none; b=WzPpUr1eM7HZvSYRTMfqfEjEgvvHfUs+u4xh8ku+4gLQNFtONZiA6QOISkQpjYdmadEFQKF5lmCMcFXxI6Hvjsf360xuQ2c2y97y1nXOd0zJ3DQgascmUggmHtVShoHBExMIiao2hWYl78JNAixGcAhXinViMZtfFOqG+mnyzIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741356932; c=relaxed/simple;
	bh=ORlXqKH59TAvqyZ696RW4rdKfXnYfX3Dj6nxXbH2qsY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dnhDtWpVMWP5ctRCToxa0TlMX55gT33abr3YNxQKx2e4AtGwDVARMKGm5wrj0Qln/7Dl6HEYppfWXlTZmwKzNTnRsjihdEih8Pi1bdhL8zkb4TjhdMAVBoBK4w/hS22Z03Gg0S6J3ymUttSNbATh9X5+hudbKjIXF6Pn8t5RaCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cfnaHWqT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741356928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3O3AnmpQI3jBSfzVaFR0gisRYPo1AftdSa2GSlKHZsw=;
	b=cfnaHWqTYy/EwlluAIJkTzfOyvI3cxT9/zynGveLQJGUofxU0lmNzsasATVtFllCB45uVc
	nfLatL3fCRG6wW+HbfrdvphwD4Sq90Q5Ts0FRXQlOr4crE23URb1xmkooUXNQROQLJ5yZ8
	36Wtj6FIMk6zPud0cM4jC6p+3HLzqsY=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-Xrgo1NPOPqaptEvg_UjFhQ-1; Fri, 07 Mar 2025 09:15:27 -0500
X-MC-Unique: Xrgo1NPOPqaptEvg_UjFhQ-1
X-Mimecast-MFC-AGG-ID: Xrgo1NPOPqaptEvg_UjFhQ_1741356926
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5493a71ae78so1240071e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 06:15:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741356926; x=1741961726;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3O3AnmpQI3jBSfzVaFR0gisRYPo1AftdSa2GSlKHZsw=;
        b=h9dOlhdlG5IgBfEZd7er9jDU3fMTy19ePXmgQCg72DX28buTa4rYX85w2R0XfETqO9
         FS4wBUOKxvcB0DOXFTgi0LecxY7xspnDFkUAqt2zasfrBu/NLeMc9YO+cOEj1oFjSlZK
         p2qTZnK1lJ3jkH+xYW0uvaVjMNT0XECLdgGcEDOGJlQ91dlt0kTwjiVeHK0woC43npT4
         dVV9dmRoQK7qQK5p+62A2Zwh1j4wowyiz/Q0Vwgcgdm911H6aHynFrZuCSRwir9OezuP
         cOyx2YqEPp9vTgC1Q3fRImwqaX3Y42lUKt/ddsuhCJ+RqMqOsvuag6by/xlSJA0jkUmA
         eYtA==
X-Forwarded-Encrypted: i=1; AJvYcCV6t+l2rZuVXvKjrderDIOocVoTC0FQbKOliwFbsPc08/e2WuAZbRvDgIOjNCdSghEkTN/laghq7ZE8sZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDXCYSvXBVERJWeIDTeeK5ykWQjphst6jqHzTLpnjzPuXx2lXE
	kUPmtMrv96HnM0piTJpO24r0bnGKWn7InmKy9VFe6jDY7lBrO1dwbdWn3GGWDMJDLeIDLPIWqhR
	gRjah1HYNjDE+3H2vJUKWLbH00sNe9Rj3zMUtjfKfCVlYAzxoGDjMIyeB8TTm9w==
X-Gm-Gg: ASbGnctrURupdFhIFLASS2Unk6x4CAN8et8QaQ6kAmTRypAnCQ6xtzLf2uH6oVbEm+x
	OLp4lDz/E94CSfhHMiKNpuTRyMnQ2ITMayC3AGSw/aQbbP6wt6FJ8bzXVjT9TJnNSl4XXky6lF/
	ZZ7OFINtH5z/bUuTWSPkffgX9Gm61Ttkes1HQr0kqCmI9zTjgsiFGNu8HSQY1jSLPLtK0rt7tWw
	vwFaHUg0aK/mFZC5WlQwFx4oLo+dC8Kzg1ADTQPmk7MyPgZ0+Fi72qGUYL1u57QftMX0j/zNcDd
	E1XaOJ/3IR5Y
X-Received: by 2002:a05:6512:3e08:b0:549:8c0c:f059 with SMTP id 2adb3069b0e04-549903f7501mr1328609e87.10.1741356925933;
        Fri, 07 Mar 2025 06:15:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3xCZIBKOSDK+lcZFrDyk8zQiKyadlLEz2VUX4gZrVM2Ry982AQyl3kHsVBYxqC5TNxfqK0A==
X-Received: by 2002:a05:6512:3e08:b0:549:8c0c:f059 with SMTP id 2adb3069b0e04-549903f7501mr1328584e87.10.1741356925465;
        Fri, 07 Mar 2025 06:15:25 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae58e4fsm500345e87.82.2025.03.07.06.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 06:15:24 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C544C18B8B34; Fri, 07 Mar 2025 15:15:22 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com
Cc: zhangkun09@huawei.com, liuyonglong@huawei.com, fanghaiqing@huawei.com,
 Yunsheng Lin <linyunsheng@huawei.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Alexander Duyck <alexander.duyck@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, Gaurav Batra <gbatra@linux.ibm.com>, Matthew
 Rosato <mjrosato@linux.ibm.com>, IOMMU <iommu@lists.linux.dev>, MM
 <linux-mm@kvack.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v11 0/4] fix the DMA API misuse problem for
 page_pool
In-Reply-To: <20250307092356.638242-1-linyunsheng@huawei.com>
References: <20250307092356.638242-1-linyunsheng@huawei.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 07 Mar 2025 15:15:22 +0100
Message-ID: <87v7slvsed.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yunsheng Lin <linyunsheng@huawei.com> writes:

> This patchset fix the dma API misuse problem as below:
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
>    page_pool_item_block' is stored in the top of a struct page.
>    And after clearing the pp_item->state', the item for the
>    released page is added back to pool->release_items so that it
>    can be reused for new pages or just free it when it is from the
>    pool->slow_items.
> 3. When page_pool_destroy() is called, item->state is used to tell
>    if a specific item is being used/dma mapped or not by scanning
>    all the item blocks in pool->item_blocks, then item->netmem can
>    be used to do the dma unmmaping if the corresponding inflight
>    page is dma mapped.

You are making this incredibly complicated. You've basically implemented
a whole new slab allocator for those page_pool_item objects, and you're
tracking every page handed out by the page pool instead of just the ones
that are DMA-mapped. None of this is needed.

I took a stab at implementing the xarray-based tracking first suggested
by Mina[0]:

https://git.kernel.org/toke/c/e87e0edf9520

And, well, it's 50 lines of extra code, none of which are in the fast
path.

Jesper has kindly helped with testing that it works for normal packet
processing, but I haven't yet verified that it resolves the original
crash. Will post the patch to the list once I have verified this (help
welcome!).

-Toke

[0] https://lore.kernel.org/all/CAHS8izPg7B5DwKfSuzz-iOop_YRbk3Sd6Y4rX7KBG9DcVJcyWg@mail.gmail.com/



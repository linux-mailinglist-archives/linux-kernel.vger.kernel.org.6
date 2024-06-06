Return-Path: <linux-kernel+bounces-203937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C788FE225
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 373F9B29D66
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1606C155C9D;
	Thu,  6 Jun 2024 09:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ugkwibh9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F69315574D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 09:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664565; cv=none; b=IQHM1GxZ02KQPw3TDVjEK+5P2HRDyssuMZgRYVjjUPSTM6RIVKAh8qnb9bybgik3JgeDHATr2npAbSlih6C+on9l1XcdQgCFNECqleKpNiMsWye0p6FmeHvEKcKYMQs3dDaVjKW9MYfFg7jEdEJVLcfBM2gtA54e0OBRQ7cpKCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664565; c=relaxed/simple;
	bh=9icnmEfpu4qV4+inQ0UmDn7/E9tga/lNpi/8MPeEJbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kT5q+qCoZc24Qn3fGm0ThS0hWJd3WS3wNL+JgrzkMzxlENAi9fWH42fqqBd6QwGm9hJ3TcWCQH+8Pef/UnSn3c/YGvnJeep34jKPm/pe/8YKBTUqA2CEBqt79zQi7CFSP5iYgUQOS0kT6T3+2RH5Xi+7NUq5Ij+6j7Zbt27JLQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ugkwibh9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717664562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LeIpi3AlPo5Ron82kvJE1KgranvjfzkDt2CgEkhJ+AQ=;
	b=Ugkwibh9ObNUwxUzUflWNFLSW+xxazEU2+5WitymlKdYfBz6kBH3fLJtO79X2UvnwHJmZe
	T02SB+RPCFbbCgH3icvwhDnpu10sD9nFcEo6QDkiX8PjCV10owKEa4+xXemclB6RZsMr8P
	Bn/Zm/uEFhocem/03vHR5lQovTg95uk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-KtvURmmHOEOHZXqGUnOUMA-1; Thu,
 06 Jun 2024 05:02:40 -0400
X-MC-Unique: KtvURmmHOEOHZXqGUnOUMA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB4F529AA387;
	Thu,  6 Jun 2024 09:02:39 +0000 (UTC)
Received: from fedora (unknown [10.72.113.78])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 16B6B20229B8;
	Thu,  6 Jun 2024 09:02:34 +0000 (UTC)
Date: Thu, 6 Jun 2024 17:02:30 +0800
From: Ming Lei <ming.lei@redhat.com>
To: YangYang <yang.yang@vivo.com>
Cc: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	"yukuai (C)" <yukuai3@huawei.com>,
	Yu Kuai <yukuai1@huaweicloud.com>
Subject: Re: [PATCH v2] sbitmap: fix io hung due to race on
 sbitmap_word::cleared
Message-ID: <ZmF7JsJYlUmp5xTj@fedora>
References: <20240604031124.2261-1-yang.yang@vivo.com>
 <CAFj5m9KV7OJ4_KjbSkpdtfrKamoLzV6EH-mJP3=y+VvoYOzC3w@mail.gmail.com>
 <aa7246f9-f7df-3054-077e-eb21c7f423ac@huaweicloud.com>
 <ZmEpIBL2Ot5cwRyv@fedora>
 <bebf237c-1223-43e9-93f1-10a32c4923af@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bebf237c-1223-43e9-93f1-10a32c4923af@vivo.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On Thu, Jun 06, 2024 at 03:21:38PM +0800, YangYang wrote:
> On 2024/6/6 11:12, Ming Lei wrote:
> > On Tue, Jun 04, 2024 at 02:12:22PM +0800, Yu Kuai wrote:
> > > Hi,
> > > 
> > > 在 2024/06/04 11:25, Ming Lei 写道:
> > > > On Tue, Jun 4, 2024 at 11:12 AM Yang Yang <yang.yang@vivo.com> wrote:
> > > > > 
> > > > > Configuration for sbq:
> > > > >     depth=64, wake_batch=6, shift=6, map_nr=1
> > > > > 
> > > > > 1. There are 64 requests in progress:
> > > > >     map->word = 0xFFFFFFFFFFFFFFFF
> > > > > 2. After all the 64 requests complete, and no more requests come:
> > > > >     map->word = 0xFFFFFFFFFFFFFFFF, map->cleared = 0xFFFFFFFFFFFFFFFF
> > > > > 3. Now two tasks try to allocate requests:
> > > > >     T1:                                       T2:
> > > > >     __blk_mq_get_tag                          .
> > > > >     __sbitmap_queue_get                       .
> > > > >     sbitmap_get                               .
> > > > >     sbitmap_find_bit                          .
> > > > >     sbitmap_find_bit_in_word                  .
> > > > >     __sbitmap_get_word  -> nr=-1              __blk_mq_get_tag
> > > > >     sbitmap_deferred_clear                    __sbitmap_queue_get
> > > > >     /* map->cleared=0xFFFFFFFFFFFFFFFF */     sbitmap_find_bit
> > > > >       if (!READ_ONCE(map->cleared))           sbitmap_find_bit_in_word
> > > > >         return false;                         __sbitmap_get_word -> nr=-1
> > > > >       mask = xchg(&map->cleared, 0)           sbitmap_deferred_clear
> > > > >       atomic_long_andnot()                    /* map->cleared=0 */
> > > > >                                                 if (!(map->cleared))
> > > > >                                                   return false;
> > > > >                                        /*
> > > > >                                         * map->cleared is cleared by T1
> > > > >                                         * T2 fail to acquire the tag
> > > > >                                         */
> > > > > 
> > > > > 4. T2 is the sole tag waiter. When T1 puts the tag, T2 cannot be woken
> > > > > up due to the wake_batch being set at 6. If no more requests come, T1
> > > > > will wait here indefinitely.
> > > > > 
> > > > > To fix this issue, simply revert commit 661d4f55a794 ("sbitmap:
> > > > > remove swap_lock"), which causes this issue.
> > > > 
> > > > I'd suggest to add the following words in commit log:
> > > > 
> > > > Check on ->cleared and update on both ->cleared and ->word need to be
> > > > done atomically, and using spinlock could be the simplest solution.
> > > > 
> > > > Otherwise, the patch looks fine for me.
> > > 
> > > Maybe I'm noob, but I'm confused how can this fix the problem, looks
> > > like the race condition doesn't change.
> > > 
> > > In sbitmap_find_bit_in_word:
> > > 
> > > 1) __sbitmap_get_word read word;
> > > 2) sbitmap_deferred_clear clear cleared;
> > > 3) sbitmap_deferred_clear update word;
> > > 
> > > 2) and 3) are done atomically while 1) can still concurrent with 3):
> > 
> > After 1) fails, sbitmap_deferred_clear() is called with spinlock,
> > then it is pretty easy to solve the race, such as, the following patch
> > against the revert patch.
> > 
> > 
> > diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> > index dee02a0266a6..c015ecd8e10e 100644
> > --- a/lib/sbitmap.c
> > +++ b/lib/sbitmap.c
> > @@ -63,13 +63,15 @@ static inline void update_alloc_hint_after_get(struct sbitmap *sb,
> >   static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
> >   {
> >   	unsigned long mask;
> > -	bool ret = false;
> >   	unsigned long flags;
> > +	bool ret;
> >   	spin_lock_irqsave(&map->swap_lock, flags);
> > -	if (!map->cleared)
> > +	if (!map->cleared) {
> > +		ret = !!map->word;
> 
> After atomic_long_andnot(mask, (atomic_long_t *)&map->word), map->word
> may be 0 if all requests have completed, or not 0 if some requests are
> still in flight.

setting ->word is lockless, but zeroing ->word is serialized with ->swap_lock.

> Therefore, using !!map->word to determine the
> availability of free tags is inaccurate.

The check should be changed to decide if any free bit is available in
map->word instead of !!map->word, and 'shift' need to be passed in
sbitmap_deferred_clear().

Just be curious, do you have reproducer for this issue?

Thanks,
Ming



Return-Path: <linux-kernel+bounces-320150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F239706B8
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 12:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8057C1F21C1E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 10:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7107514C59B;
	Sun,  8 Sep 2024 10:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iLL+gxvE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A52514D2AC
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 10:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725792489; cv=none; b=ifrph2eV39Ol9EEieyWXOSlxh671gFji5mpM5GL6SmwOjmOqxJWUNxiKzpVprE2jlDHZs8tJwbGHPAL+PRQAaz3Yf2Ab+dZXxm/Otrb3hNCLzT1FctZYrCxsdv1Um6vZitWtqUhHFlVY8tah2Gti6+oeTIA0FM62raRfnRtG8Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725792489; c=relaxed/simple;
	bh=4u/BMOcDccyUyOPthirmKTbAVPKYeZC4p+svxp9M+Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MdzdYmvlXnw4fw7EDGL6LKhA5dPN1kBs2UoR73QEoqzJ+q+CrtjyemCsb5E1NLvZyeTob0RI50VHQhRMrRNC0Ajqgg+r3iQu6JwETmc47wHX6Ja5WS8s6gHw3mzG8Eaj9kS5mnNv+gL7QEKcPf8DJx73IvQgFIrMNxNZ+CBz9Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iLL+gxvE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725792485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i1aqoQcu5QjkkF8FRma0LxNF5TpHRHrEBWMC+woi8Fc=;
	b=iLL+gxvEhMs5vb676JKU/G2htbfLiC1xFo+YNZ9PSIsBH0lFQLfoAo8+v5Z+NFPNVa2KVv
	KPCCs9VUP2fz9PZFhtq9nZiAL8QmlhWTHmad63MxdRjgplfw8nfkSnl300BnmYH08dHaFg
	Ca9s4dsdln8/qM6actD1E2YKtQ84Ucs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-g9REQ_6MM-ylZ6L5gq9Q7w-1; Sun, 08 Sep 2024 06:48:04 -0400
X-MC-Unique: g9REQ_6MM-ylZ6L5gq9Q7w-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5c24c92db25so6572082a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 03:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725792483; x=1726397283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1aqoQcu5QjkkF8FRma0LxNF5TpHRHrEBWMC+woi8Fc=;
        b=W9YK7C6yYUPqhiUKD8bjbgQwqzi/SLS0h7HwgJv3VzQHpTIzayl7Hcy85NSwLMYUVk
         dFPk6RFXZWv+h3EZPwmEaYi8Dsbsp0ZAOOReIYvY91qtHP42zUP1NAuwK5G5S3gn9dyI
         HByyH5VDJwZiWMT0tXtnHTb/OGbrd/+M3Kg/Sl8+XwuInXfOH1unbdb9FKceEtL9xGxe
         5sJ0VLkFxxSGPdyKs9efsS/vs/SZrB7xBZY331i6r8QDB4wKw77SDLP9zBV4uYQDEEq2
         OCiua0+ahyO5exn9+TJcI1If+qg2KGjjWn0io6rodc2G6Mv+UWP9BwXzRUXGAvPQqfw0
         edyw==
X-Gm-Message-State: AOJu0YzWbhDF4divJMjJyEMdvAuyIAWisrWIuQtTFjoL1w8H/xMS8yt/
	d6+69k4yLLEB/kEvC7nku0h0RYoSkBY+m3ZCXZrwfTnnLr6+mdu4A4x3tMJQJ7vdHZAQooZq4wG
	qw4eU+LgExk5D5fcdqRB+7fT0F5tqhCDGSK8c51dy7RR0nMQ2vIm/zqQzMU+dOw==
X-Received: by 2002:a05:6402:50d4:b0:5c2:e888:4cf4 with SMTP id 4fb4d7f45d1cf-5c3b291c3b5mr15324838a12.0.1725792483395;
        Sun, 08 Sep 2024 03:48:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLXUTlnzlooSWy+K5xVuihtz3ewF2aX1nU5LKkFkKXiqkQNUY0OxKwgyhYlKKWEIx53TTKjA==
X-Received: by 2002:a05:6402:50d4:b0:5c2:e888:4cf4 with SMTP id 4fb4d7f45d1cf-5c3b291c3b5mr15324762a12.0.1725792482281;
        Sun, 08 Sep 2024 03:48:02 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1ed:17aa:6194:fdaa:53cf:2b5f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd76ee5sm1720538a12.71.2024.09.08.03.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 03:48:01 -0700 (PDT)
Date: Sun, 8 Sep 2024 06:47:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Darren Kenny <darren.kenny@oracle.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Si-Wei Liu <si-wei.liu@oracle.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH RFC 1/3] Revert "virtio_net: rx remove premapped failover
 code"
Message-ID: <20240908064724-mutt-send-email-mst@kernel.org>
References: <cover.1723617902.git.mst@redhat.com>
 <7774ac707743ad8ce3afeacbd4bee63ac96dd927.1723617902.git.mst@redhat.com>
 <m2y14zrv2t.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2y14zrv2t.fsf@oracle.com>

Could you pls repeat this testing for v2? I had to revert more patches for
that one.

On Wed, Aug 14, 2024 at 04:19:06PM +0100, Darren Kenny wrote:
> Hi Michael,
> 
> I've tested this on the system that was reproducing the panic, and it
> everything is working now as expected.
> 
> For the series then:
> 
> Tested-by: Darren Kenny <darren.kenny@oracle.com>
> 
> Thanks,
> 
> Darren.
> 
> On Wednesday, 2024-08-14 at 02:59:20 -04, Michael S. Tsirkin wrote:
> > This reverts commit defd28aa5acb0fd7c15adc6bc40a8ac277d04dea.
> >
> > leads to crashes with no ACCESS_PLATFORM when
> > sysctl net.core.high_order_alloc_disable=1
> >
> > Reported-by: Si-Wei Liu <si-wei.liu@oracle.com>
> > Message-ID: <8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  drivers/net/virtio_net.c | 89 +++++++++++++++++++++++-----------------
> >  1 file changed, 52 insertions(+), 37 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index fd3d7e926022..4f7e686b8bf9 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -348,6 +348,9 @@ struct receive_queue {
> >  
> >  	/* Record the last dma info to free after new pages is allocated. */
> >  	struct virtnet_rq_dma *last_dma;
> > +
> > +	/* Do dma by self */
> > +	bool do_dma;
> >  };
> >  
> >  /* This structure can contain rss message with maximum settings for indirection table and keysize
> > @@ -848,7 +851,7 @@ static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
> >  	void *buf;
> >  
> >  	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
> > -	if (buf)
> > +	if (buf && rq->do_dma)
> >  		virtnet_rq_unmap(rq, buf, *len);
> >  
> >  	return buf;
> > @@ -861,6 +864,11 @@ static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
> >  	u32 offset;
> >  	void *head;
> >  
> > +	if (!rq->do_dma) {
> > +		sg_init_one(rq->sg, buf, len);
> > +		return;
> > +	}
> > +
> >  	head = page_address(rq->alloc_frag.page);
> >  
> >  	offset = buf - head;
> > @@ -886,42 +894,44 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
> >  
> >  	head = page_address(alloc_frag->page);
> >  
> > -	dma = head;
> > +	if (rq->do_dma) {
> > +		dma = head;
> >  
> > -	/* new pages */
> > -	if (!alloc_frag->offset) {
> > -		if (rq->last_dma) {
> > -			/* Now, the new page is allocated, the last dma
> > -			 * will not be used. So the dma can be unmapped
> > -			 * if the ref is 0.
> > +		/* new pages */
> > +		if (!alloc_frag->offset) {
> > +			if (rq->last_dma) {
> > +				/* Now, the new page is allocated, the last dma
> > +				 * will not be used. So the dma can be unmapped
> > +				 * if the ref is 0.
> > +				 */
> > +				virtnet_rq_unmap(rq, rq->last_dma, 0);
> > +				rq->last_dma = NULL;
> > +			}
> > +
> > +			dma->len = alloc_frag->size - sizeof(*dma);
> > +
> > +			addr = virtqueue_dma_map_single_attrs(rq->vq, dma + 1,
> > +							      dma->len, DMA_FROM_DEVICE, 0);
> > +			if (virtqueue_dma_mapping_error(rq->vq, addr))
> > +				return NULL;
> > +
> > +			dma->addr = addr;
> > +			dma->need_sync = virtqueue_dma_need_sync(rq->vq, addr);
> > +
> > +			/* Add a reference to dma to prevent the entire dma from
> > +			 * being released during error handling. This reference
> > +			 * will be freed after the pages are no longer used.
> >  			 */
> > -			virtnet_rq_unmap(rq, rq->last_dma, 0);
> > -			rq->last_dma = NULL;
> > +			get_page(alloc_frag->page);
> > +			dma->ref = 1;
> > +			alloc_frag->offset = sizeof(*dma);
> > +
> > +			rq->last_dma = dma;
> >  		}
> >  
> > -		dma->len = alloc_frag->size - sizeof(*dma);
> > -
> > -		addr = virtqueue_dma_map_single_attrs(rq->vq, dma + 1,
> > -						      dma->len, DMA_FROM_DEVICE, 0);
> > -		if (virtqueue_dma_mapping_error(rq->vq, addr))
> > -			return NULL;
> > -
> > -		dma->addr = addr;
> > -		dma->need_sync = virtqueue_dma_need_sync(rq->vq, addr);
> > -
> > -		/* Add a reference to dma to prevent the entire dma from
> > -		 * being released during error handling. This reference
> > -		 * will be freed after the pages are no longer used.
> > -		 */
> > -		get_page(alloc_frag->page);
> > -		dma->ref = 1;
> > -		alloc_frag->offset = sizeof(*dma);
> > -
> > -		rq->last_dma = dma;
> > +		++dma->ref;
> >  	}
> >  
> > -	++dma->ref;
> > -
> >  	buf = head + alloc_frag->offset;
> >  
> >  	get_page(alloc_frag->page);
> > @@ -938,9 +948,12 @@ static void virtnet_rq_set_premapped(struct virtnet_info *vi)
> >  	if (!vi->mergeable_rx_bufs && vi->big_packets)
> >  		return;
> >  
> > -	for (i = 0; i < vi->max_queue_pairs; i++)
> > -		/* error should never happen */
> > -		BUG_ON(virtqueue_set_dma_premapped(vi->rq[i].vq));
> > +	for (i = 0; i < vi->max_queue_pairs; i++) {
> > +		if (virtqueue_set_dma_premapped(vi->rq[i].vq))
> > +			continue;
> > +
> > +		vi->rq[i].do_dma = true;
> > +	}
> >  }
> >  
> >  static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
> > @@ -2036,7 +2049,8 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
> >  
> >  	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
> >  	if (err < 0) {
> > -		virtnet_rq_unmap(rq, buf, 0);
> > +		if (rq->do_dma)
> > +			virtnet_rq_unmap(rq, buf, 0);
> >  		put_page(virt_to_head_page(buf));
> >  	}
> >  
> > @@ -2150,7 +2164,8 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
> >  	ctx = mergeable_len_to_ctx(len + room, headroom);
> >  	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
> >  	if (err < 0) {
> > -		virtnet_rq_unmap(rq, buf, 0);
> > +		if (rq->do_dma)
> > +			virtnet_rq_unmap(rq, buf, 0);
> >  		put_page(virt_to_head_page(buf));
> >  	}
> >  
> > @@ -5231,7 +5246,7 @@ static void free_receive_page_frags(struct virtnet_info *vi)
> >  	int i;
> >  	for (i = 0; i < vi->max_queue_pairs; i++)
> >  		if (vi->rq[i].alloc_frag.page) {
> > -			if (vi->rq[i].last_dma)
> > +			if (vi->rq[i].do_dma && vi->rq[i].last_dma)
> >  				virtnet_rq_unmap(&vi->rq[i], vi->rq[i].last_dma, 0);
> >  			put_page(vi->rq[i].alloc_frag.page);
> >  		}
> > -- 
> > MST



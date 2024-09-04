Return-Path: <linux-kernel+bounces-314820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EE496B97C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87CC41C21975
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF54D1D0154;
	Wed,  4 Sep 2024 10:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TUxEIRT0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700CF1CF7A9
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 10:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725447469; cv=none; b=eg/ig2aJEG44mGA5zoZQGiHWiUD74o/Ann/GyLM0tTvobwbMYgWRiDMzpn/BESIMwHbVuPRgXEoyH1TC3m2Q5Y4PxLPgCOyXQWUhfndRFM+19H5dDC8m4VRa7N1Wb6InlkneT7oK83xefSLV+bmtCY2gdfFRJ/RlvDZDmDmgjMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725447469; c=relaxed/simple;
	bh=+g60buYkNs482gAOZIHUNmzE2rgVaRxfXaFe9VsN+BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWv2Uc6W4teuFXGQ4uQzaX1W1XybtvOqoKEiqYMEOIBVe+DZ6WhOlRv5uxRJlWYTyKxMvxv+i7ewZ5yUJBTKKztp+QNgB3oswlD1UlL6BS1pctiWBY5koaB33vsQG2/u2W+J3sDnBs9MdneKuW2Am3M6VJGEFFFmDpCg8nb6OMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TUxEIRT0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725447466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rw2ZChNtb/jDuSC/Rnl6IchZi9rO4dgpRix6imcWTTE=;
	b=TUxEIRT0az+vIA9LEm21iN8Vx6lqbRt/lEFN9uynACp3XKMCRKgWT4r/IYIE2H2g2BqMdV
	O/QbihB6sDOCgMF//epKuI53PGyWP+7+Y7SFxluq4ua+UzE2jdvsC3uB1DRRt9y9kmmzPu
	GfwiZIgHoyxzFh7mJdeZ7vB1/tvhj+k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-qD3UPRVUPPiAWQ4lFLORWQ-1; Wed, 04 Sep 2024 06:57:44 -0400
X-MC-Unique: qD3UPRVUPPiAWQ4lFLORWQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42bac946976so58264025e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 03:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725447462; x=1726052262;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rw2ZChNtb/jDuSC/Rnl6IchZi9rO4dgpRix6imcWTTE=;
        b=kPstJZX9H6aRP3byd4B4BrKrU18m5KrWe8GvAqkirLGZWRnSMzXEKmTPo0RJFyXhAT
         SZlGd9aO2EuuJ0PXLh47IlyZG4+erMH8nGPBaJFeMreOAkowBihNT0kovM19xqMhf0Av
         UPCRYlMbODa3KY8/c9KzXwgM1o34BGY2W338DHzhv1tz4suK/SQBCEtGJf6z0hvCYvMq
         2SSrPhKIc9PLJxW3vFKJrmClGHUfYO9rLqUYku9rIvgyvhPa9nn1fcyEPGtDNnUx2byp
         E57sAdX2/gsf2ChsmKnefv+JGgTgZd10+ue2rhG0WKTGp3zA5AplDgDJeEx2vR07Kd6r
         0Z4A==
X-Forwarded-Encrypted: i=1; AJvYcCXietInNil1mONV/oaKOZN72vz6SPMjKq20e2g57FJor/oNw2dw7MRRjEiMawfDanIkgb/OzosvF/BS84A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAiFm7mOFVfvvLIRK59t8qtP78sSweCOw8OZ8Zq7GD2Kb+50O5
	P+RIjaqsChBCic7M/lOSlPOFzpa6cLRoSFmCrnoJpWBg5F7aAiAFudy0NCFSOmBcTE/z6BEbXqX
	fmn7C+u0HCtDjI1AFafsc8C3ZdEACcCPAFK3c8FbbuFGli//k7eEp8zuzcRqqX8zss1+fBA==
X-Received: by 2002:a05:600c:a09:b0:428:1608:831e with SMTP id 5b1f17b1804b1-42bb0309910mr160893305e9.22.1725447462555;
        Wed, 04 Sep 2024 03:57:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkXwypcqrJh3Y7gP5Q6Ltrp9NU+HSv0Qi7Do0Jl++xDXPGVKmVZyxkDfQPyxOpKULa8FQy6w==
X-Received: by 2002:a05:600c:a09:b0:428:1608:831e with SMTP id 5b1f17b1804b1-42bb0309910mr160892975e9.22.1725447461617;
        Wed, 04 Sep 2024 03:57:41 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:25b:d02e:ab32:7c17:4d7a:fa4a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c8a08dafsm9108194f8f.75.2024.09.04.03.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 03:57:40 -0700 (PDT)
Date: Wed, 4 Sep 2024 06:57:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: =?utf-8?B?5paH5Y2a5p2O?= <liwenbo.martin@bytedance.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jiahui Cen <cenjiahui@bytedance.com>,
	Ying Fang <fangying.tommy@bytedance.com>, jasowang@redhat.com,
	eperezma@redhat.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [External] Re: [PATCH v2] virtio_net: Fix mismatched buf address
 when unmapping for small packets
Message-ID: <20240904065626-mutt-send-email-mst@kernel.org>
References: <20240904061009.90785-1-liwenbo.martin@bytedance.com>
 <1725432304.274084-1-xuanzhuo@linux.alibaba.com>
 <CABwj4+hMwUQ+=m+XyG=66e+PUbOzOvHEsQzboB17DE+3aBHA3g@mail.gmail.com>
 <1725435002.9733856-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1725435002.9733856-1-xuanzhuo@linux.alibaba.com>

On Wed, Sep 04, 2024 at 03:30:02PM +0800, Xuan Zhuo wrote:
> On Wed, 4 Sep 2024 15:21:28 +0800, =?utf-8?b?5paH5Y2a5p2O?= <liwenbo.martin@bytedance.com> wrote:
> > When SWIOTLB is enabled, a DMA map will allocate a bounce buffer for real
> > DMA operations,
> > and when unmapping, SWIOTLB copies the content in the bounce buffer to the
> > driver-allocated
> > buffer (the `buf` variable). Such copy only synchronizes data in the buffer
> > range, not the whole page.
> > So we should give the correct offset for DMA unmapping.
> 
> I see.
> 
> But I think we should pass the "correct" buf to virtio core as the "data" by
> virtqueue_add_inbuf_ctx().
> 
> In the merge mode, we pass the pointer that points to the virtnet header.
> In the small mode, we pass the pointer that points to the virtnet header - offset.
> 
> But this is not the only problem, we try to get the virtnet header by the buf
> inside receive_buf(before receive_small).
> 
> 	flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
> 
> So I think it is time to unify the buf that passed to the virtio core into a
> pointer pointed to the virtnet header.
> 
> Thanks.

Hard to say without seeing what is proposed, but I think
data pointer is opaque to virtio, it does not have to
point to anything specific - just !NULL.


> 
> >
> > Thanks.
> >
> > On Wed, Sep 4, 2024 at 2:46 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > >
> > > On Wed,  4 Sep 2024 14:10:09 +0800, Wenbo Li <liwenbo.martin@bytedance.com>
> > wrote:
> > > > Currently, the virtio-net driver will perform a pre-dma-mapping for
> > > > small or mergeable RX buffer. But for small packets, a mismatched
> > address
> > > > without VIRTNET_RX_PAD and xdp_headroom is used for unmapping.
> > >
> > > Will used virt_to_head_page(), so could you say more about it?
> > >
> > >         struct page *page = virt_to_head_page(buf);
> > >
> > > Thanks.
> > >
> > > >
> > > > That will result in unsynchronized buffers when SWIOTLB is enabled, for
> > > > example, when running as a TDX guest.
> > > >
> > > > This patch handles small and mergeable packets separately and fixes
> > > > the mismatched buffer address.
> > > >
> > > > Changes from v1: Use ctx to get xdp_headroom.
> > > >
> > > > Fixes: 295525e29a5b ("virtio_net: merge dma operations when filling
> > mergeable buffers")
> > > > Signed-off-by: Wenbo Li <liwenbo.martin@bytedance.com>
> > > > Signed-off-by: Jiahui Cen <cenjiahui@bytedance.com>
> > > > Signed-off-by: Ying Fang <fangying.tommy@bytedance.com>
> > > > ---
> > > >  drivers/net/virtio_net.c | 29 ++++++++++++++++++++++++++++-
> > > >  1 file changed, 28 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index c6af18948..cbc3c0ae4 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -891,6 +891,23 @@ static void *virtnet_rq_get_buf(struct
> > receive_queue *rq, u32 *len, void **ctx)
> > > >       return buf;
> > > >  }
> > > >
> > > > +static void *virtnet_rq_get_buf_small(struct receive_queue *rq,
> > > > +                                   u32 *len,
> > > > +                                   void **ctx,
> > > > +                                   unsigned int header_offset)
> > > > +{
> > > > +     void *buf;
> > > > +     unsigned int xdp_headroom;
> > > > +
> > > > +     buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
> > > > +     if (buf) {
> > > > +             xdp_headroom = (unsigned long)*ctx;
> > > > +             virtnet_rq_unmap(rq, buf + VIRTNET_RX_PAD + xdp_headroom,
> > *len);
> > > > +     }
> > > > +
> > > > +     return buf;
> > > > +}
> > > > +
> > > >  static void virtnet_rq_init_one_sg(struct receive_queue *rq, void
> > *buf, u32 len)
> > > >  {
> > > >       struct virtnet_rq_dma *dma;
> > > > @@ -2692,13 +2709,23 @@ static int virtnet_receive_packets(struct
> > virtnet_info *vi,
> > > >       int packets = 0;
> > > >       void *buf;
> > > >
> > > > -     if (!vi->big_packets || vi->mergeable_rx_bufs) {
> > > > +     if (vi->mergeable_rx_bufs) {
> > > >               void *ctx;
> > > >               while (packets < budget &&
> > > >                      (buf = virtnet_rq_get_buf(rq, &len, &ctx))) {
> > > >                       receive_buf(vi, rq, buf, len, ctx, xdp_xmit,
> > stats);
> > > >                       packets++;
> > > >               }
> > > > +     } else if (!vi->big_packets) {
> > > > +             void *ctx;
> > > > +             unsigned int xdp_headroom = virtnet_get_headroom(vi);
> > > > +             unsigned int header_offset = VIRTNET_RX_PAD +
> > xdp_headroom;
> > > > +
> > > > +             while (packets < budget &&
> > > > +                    (buf = virtnet_rq_get_buf_small(rq, &len, &ctx,
> > header_offset))) {
> > > > +                     receive_buf(vi, rq, buf, len, ctx, xdp_xmit,
> > stats);
> > > > +                     packets++;
> > > > +             }
> > > >       } else {
> > > >               while (packets < budget &&
> > > >                      (buf = virtqueue_get_buf(rq->vq, &len)) != NULL) {
> > > > --
> > > > 2.20.1
> > > >
> >



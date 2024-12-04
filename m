Return-Path: <linux-kernel+bounces-430547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFAF9E329B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 05:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9D64167E72
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 04:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C316684039;
	Wed,  4 Dec 2024 04:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="j1uAEwmy"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C794D2500D4
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 04:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733285775; cv=none; b=Ph4i/yYCDbjgIy5kxwiCGZ3CNqRkzsmYjaCKSH6H7q6Rzta5XOiLj5oLzsscKYeqLs2jv4r/4UxCh66LqjC9P2Wxq4zN9/CQ/UccR3etZrsbX7oomyvp+Zi3d4mmbC86VDISuh4LeUUH1xjr4hm6kjzACsvXSsC4q2zaniKUcBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733285775; c=relaxed/simple;
	bh=IrUEeeXk0XqjRNrEb78avFaZBzk2PWSNq8LbhH2Q5vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElaOYtDh84w51K8jryeSPJ8mKj9ahKAI2YINVBQ8GZDlAl3Yq8VIVJjYMbv2fAVLd5+jQO/4Q/Xvywh41krpZBCKAx7O7xW/Sij5Y6OZbKxjXJw0rou1hGYTkav9vUezix8W6gyWuyBidZQ67taP+atk2GKO3CwWJAq4xvcmpoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=j1uAEwmy; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 66A843F1CE
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 04:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733285764;
	bh=Q24GDRfJXQyjTe8o63+C0HsFRR+/g6kWIzNile+zMUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=j1uAEwmyNAwdErjxHBKlzFmJqKKhmS6RuAqCbNNeuPVNMTMH9/+ajIw9JaAJGgkSa
	 SD75RC/Kan7tcm6xDABJfjrlDN3wRH9ztjKs7p+W7Kv64+qwnrtvQjyzMLybkeG69z
	 WU1SGK6frcJBzXVwF/4IZF/R3t04ejdRzdJDVore+Kw2Hy/fWvhauGYEf89F7yZ6mJ
	 X4Ga13wK7HR2c/U0ooKm79LbcbqxBl2+g4Wl/F8uiwNgRqQOJJeYH8nv/aewVCcXol
	 r5hbuHxiZkbIEP0empYENURnF9dscmyE/wNpBbYKKvlZYuPjWPOR6vbRbSXCke9vCa
	 x+Dw2qC8T3lMw==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ee31227b58so5665164a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 20:16:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733285694; x=1733890494;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q24GDRfJXQyjTe8o63+C0HsFRR+/g6kWIzNile+zMUE=;
        b=ezu/Uy323zkf/6WVi0ZWtGlEgKUJ1Z+VfEoEpeqwFn02f8WmJW32kxWgnNBFcyAKJb
         9lUaFFQU9Rgg27m2iDVTTD6EJku6phgH0Senizl/Sj3/J515Y+WocFnrrZjeDFSSkYfh
         bwy48IwBjE5kgNMJFIf8ygUDwwHAw9V7Qd1uyZ6FhqVLFj2+49kbmlA5cp/QdcABNRRB
         LSmK0uGa6rw1e6nEE1xT1QeCq3s1JGMMet5AOX1jdUxQUPc4EwTclh7ClecRh7lAH8Ou
         IAEHc6o282h8E56L26uIe05Z4De9kC49wCSCaoE4poX9Gr9Pi4JJfQVmM5hkrCv660D7
         /NmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQm/EzFN0Uh2VmWp92mcyDrx3z/nXWkx6XGq5SZPxKF0VW2nWGe6tFVV6I1QZ0j349dCOU6Xzc2JNfTyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YweQOsV/zfzsPSDUmi2ROiqjppJsMaopxN9insHEBRRNaTs60eI
	ic26n25lg7UwJ4xihCkEVY75LZTnZ5qksvWG1XeH0O25XnS5NLJ3E2Ki/M9PA+u+YDZxBuq/f2w
	fz2IrGBFIP8kVPvaLTdins7SHbYhdikKwmU2UF0L5HNllpG1iooN0mdOxC1wvUnE7QeQS+5xE+u
	dzvg==
X-Gm-Gg: ASbGncvrLPJG8QE98MNWXw6Dd7ahnInnodnWAxoYtPEql9MNLCYaep9rGEuB6HvAwvu
	iVUdsB5mqjaBV4pDqVBl+e6aE7QEMKZSiPrKq7xwYN02BYeMIOwwmvpfdNvhtGd2/x4+a7moiHx
	ocNsX2mwJ0q4OychxHggg0mMPq9ZINgC0rZemWxhDy4qT1kQyyBlcnrgM5W2C2+1CFA7ZQQUnVE
	aFtGiWUnoH0tWF9nEt78Jr4sARJDDoGPvhj5S3aq4PwAlpexMGg
X-Received: by 2002:a17:90a:e70c:b0:2ee:f440:53ed with SMTP id 98e67ed59e1d1-2ef0127597bmr5969986a91.31.1733285694346;
        Tue, 03 Dec 2024 20:14:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmmxQJst2LuugrSZJhqPzCTrbLye21ezDzuZBBWTLDHpaGBRfvTE3sFkECyoe3UpjTjDpNpw==
X-Received: by 2002:a17:90a:e70c:b0:2ee:f440:53ed with SMTP id 98e67ed59e1d1-2ef0127597bmr5969973a91.31.1733285694019;
        Tue, 03 Dec 2024 20:14:54 -0800 (PST)
Received: from localhost ([240f:74:7be:1:9c88:3d14:cbea:e537])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef27050103sm388122a91.41.2024.12.03.20.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 20:14:53 -0800 (PST)
Date: Wed, 4 Dec 2024 13:14:51 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/5] virtio_ring: add 'flushed' as an
 argument to virtqueue_reset()
Message-ID: <ub7pbfodhjpubwixxsbxlkiclthp3adbxin7etff5seoxqs5i7@aj3c7tpeirwq>
References: <20241203073025.67065-1-koichiro.den@canonical.com>
 <20241203073025.67065-5-koichiro.den@canonical.com>
 <CACGkMEuUa+6_uaa7H2CSvUnfNzBr-rdoQ+cp8eZD+Ay1CZ=A-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEuUa+6_uaa7H2CSvUnfNzBr-rdoQ+cp8eZD+Ay1CZ=A-g@mail.gmail.com>

On Wed, Dec 04, 2024 at 10:49:02AM +0800, Jason Wang wrote:
> On Tue, Dec 3, 2024 at 3:31 PM Koichiro Den <koichiro.den@canonical.com> wrote:
> >
> > When virtqueue_reset() has actually recycled all unused buffers,
> > additional work may be required in some cases. Relying solely on its
> > return status is fragile, so introduce a new argument 'flushed' to
> > explicitly indicate whether it has really occurred.
> >
> > Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> > ---
> >  drivers/net/virtio_net.c     | 6 ++++--
> >  drivers/virtio/virtio_ring.c | 6 +++++-
> >  include/linux/virtio.h       | 3 ++-
> >  3 files changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 0103d7990e44..d5240a03b7d6 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -5695,6 +5695,7 @@ static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct receive_queu
> >                                     struct xsk_buff_pool *pool)
> >  {
> >         int err, qindex;
> > +       bool flushed;
> >
> >         qindex = rq - vi->rq;
> >
> > @@ -5713,7 +5714,7 @@ static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct receive_queu
> >
> >         virtnet_rx_pause(vi, rq);
> >
> > -       err = virtqueue_reset(rq->vq, virtnet_rq_unmap_free_buf);
> > +       err = virtqueue_reset(rq->vq, virtnet_rq_unmap_free_buf, &flushed);
> >         if (err) {
> >                 netdev_err(vi->dev, "reset rx fail: rx queue index: %d err: %d\n", qindex, err);
> >
> > @@ -5737,12 +5738,13 @@ static int virtnet_sq_bind_xsk_pool(struct virtnet_info *vi,
> >                                     struct xsk_buff_pool *pool)
> >  {
> >         int err, qindex;
> > +       bool flushed;
> >
> >         qindex = sq - vi->sq;
> >
> >         virtnet_tx_pause(vi, sq);
> >
> > -       err = virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf);
> > +       err = virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf, &flushed);
> >         if (err) {
> >                 netdev_err(vi->dev, "reset tx fail: tx queue index: %d err: %d\n", qindex, err);
> >                 pool = NULL;
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 34a068d401ec..b522ef798946 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -2828,6 +2828,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
> >   * virtqueue_reset - detach and recycle all unused buffers
> >   * @_vq: the struct virtqueue we're talking about.
> >   * @recycle: callback to recycle unused buffers
> > + * @flushed: whether or not unused buffers are all flushed
> >   *
> >   * Caller must ensure we don't call this with other virtqueue operations
> >   * at the same time (except where noted).
> > @@ -2839,14 +2840,17 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
> >   * -EPERM: Operation not permitted
> >   */
> >  int virtqueue_reset(struct virtqueue *_vq,
> > -                   void (*recycle)(struct virtqueue *vq, void *buf))
> > +                   void (*recycle)(struct virtqueue *vq, void *buf),
> > +                   bool *flushed)
> >  {
> >         struct vring_virtqueue *vq = to_vvq(_vq);
> >         int err;
> >
> > +       *flushed = false;
> >         err = virtqueue_disable_and_recycle(_vq, recycle);
> >         if (err)
> >                 return err;
> > +       *flushed = true;
> >
> 
> This makes me think if it would be easier if we just find a way to
> reset the tx queue inside virtqueue_disable_and_recycle().
> 
> For example, introducing a recycle_done callback?

It sounds reasonable and much cleaner. I'll prepare and send v3 shortly.
Thanks for the review.

-Koichiro Den

> 
> Thanks
> 


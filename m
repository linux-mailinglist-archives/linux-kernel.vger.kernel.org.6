Return-Path: <linux-kernel+bounces-430552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 410A49E32A9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 05:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B67D16898D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 04:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E809156243;
	Wed,  4 Dec 2024 04:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ZARSLq81"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32492219E4
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 04:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733286561; cv=none; b=Q5m01ABRAeQlNMSJpBYQgTRGGFNsP82EwW1zFM/REI+23RDM9CkSqkI+EwVk+DCKWqTUGbAhYTKsBs8+gsYiT8eLofpF9VufpdjHYBmw5u7fGChOO6Nl/EgPEq6Wpnhqmxj1aHamjDlW4G9PBMPbYa0pAnSVabH3pW5s23fB040=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733286561; c=relaxed/simple;
	bh=IrUEeeXk0XqjRNrEb78avFaZBzk2PWSNq8LbhH2Q5vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bswb3t/e8UKGDzl3dH2eYpK3e2YFNw6DcwBw6XcmIibzNC2QCHImHWLV2ARXegduV6N9PCIeKG0AUfUUsIflobk99QokfYnUa30BvQRx4GmykbIHpPKC0Fzv5y0p20lcUk1lmMcWhTTNlKEdPRy4jNzk9NAGOPDqmrLWnyIJqds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ZARSLq81; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5CD423F31C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 04:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733286551;
	bh=Q24GDRfJXQyjTe8o63+C0HsFRR+/g6kWIzNile+zMUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=ZARSLq81qQ3L+6wByUZ3Jfvtr4jX6yd9UgExp+0cr7wDw3ZGPtg7OF2pCODS8jg6n
	 Fetuca7hXjtG1bBLhYZ5hZ/1lepd73legh9F1udBcH5SxoGu3HXxI+MrQwC2NHVY4M
	 HLvD9X6trZIRlcqicwighKPGa9ThN5FLa3qKWB7R9vqH9ih+/Sp822FJYrdKGkNPwP
	 wFWeMPBugRTvpWvnR00h7xiiQTlLRqunblh0hLJZH8emZUs7lHPn6LqLhghiFXw085
	 z5pvNW/452IlJcSADmnRL+t/nl+qlUuQ0Yc2rwG0nPWXPVoe0ZAjbDL+rbe1t22jVc
	 Sk1qso+ueQfoQ==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ee31227b58so5675726a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 20:29:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733286550; x=1733891350;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q24GDRfJXQyjTe8o63+C0HsFRR+/g6kWIzNile+zMUE=;
        b=YwnBdwcaYOSQsAyvvFcfd20nn/WTXmSom66VbCyDSkRdB5n2xguTC1Cn21s22/7ox9
         5r11vjPLFAdzu9Zl6YFHCdkzxbIIpkV3HI81wITi+q2CXDfrM25NAxPB25/cRlouD48W
         mWIOTtVYdvufcd9YI1Lnu2mX1jZ+YqRwnsAfOLcWVIz3d3ddFPjEuxqK2jqxHJFH/ycU
         7N1wv0cgZ1WS3jdJIrzshr9BYtVtOT29KWGPd8iudVFyKSM/fna2P6wXgPHbf/8OgQ+L
         EvaKinekE0QfnziSAfrMDV0zRubknht1C8v32p3lQNkdXOE/71oGVCB9hUDip3X9GWVl
         23uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOKbe4+5PeddbT4l5Ew3l0pjOc7BrC3Z3uG+d11uMGL278UCsiaWtBY4ZZGy9UP1sAJtrgTlBQpg4c+xU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGN3O1jRQcOA6KcLwAf39G++45fcyRxLhzHnTuAnO300SJEjps
	KpJAndTlGVoJN+FG+Cx5fdFyPL1F52ysvrqm3Q2QHCUVWeCkfxRfPrQQmUyycYiWk6YPdR6OI0M
	80Cmb/36/7CohqtkOjM0lWWl76k9EOdXEw5GrYHKf7S4M2y7aPgyMemOnC4H8MLZ5CNjNxQuvJy
	JkEQ==
X-Gm-Gg: ASbGncsWvrG1kiXqlc9Ld1NX691XWXVXoZ0FMHlhYhRWjDEf5wsYESrqyyTUbGgJfjQ
	5s7C+/+8D/6x7bte8SutdncYoDASFR/i3uevaSY1bK8MDBZR44tsPYkE+kt0Zfb3BesY22EJzQf
	/AJ77JemP7Vo90yr5EVJKua1V8pLPgFVXLlnX2ro7hvkocGBtRyZiTJx/WcDMgM/YZ/sj3u+ZnJ
	93wWFisMZTQ3shV3WdJS6UesN203AvYgoydruD7q0wnotn210b/
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


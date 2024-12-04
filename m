Return-Path: <linux-kernel+bounces-430493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B57D69E3199
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 03:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74DBC286663
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 02:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D6E12C470;
	Wed,  4 Dec 2024 02:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cmAY3HBx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA6E17BA9
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 02:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733280559; cv=none; b=n5n5hA3A34ARZZgbpfRqS61KnigB6eqgT3uQqrVvkk1kkW0ywdN0Ue1hsHaIamISjr/tSHyP/NlrfGnEZTz/4rgZhMcAcH7y+ROHcsv0gBx5oDzfHQ/WKfIOQgu6uuNVfVhZowuYfON6lQNAaPnYsjewbVS4KVd+u8Eup5sxDJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733280559; c=relaxed/simple;
	bh=TOKXJ9rIYYz9mEp3F9nZfG9+id1wmYy7VtWtelOVUxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aURo+gV1/67P4DCs5/lMiqaFM9/ehiFJQ/LZd+l4tXStqUTCIsgJcaqZM+XBb39wKnnBEauXgm3/RG88SGBOBAPofZ75GI255u9ReI6p+c3rqQTOJxeG4MCRbjaqwWyEBQkvBr5r3YV9jw3WOCCXOeh26b4nRSLDamvHyDuaUws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cmAY3HBx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733280557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c24b0aojPcSy5fMUgMajgZWX2t8sneTXVxIv1lQUC1A=;
	b=cmAY3HBxVCsUQXUGO0ySge+LRD1SImeS0i347tRNzSgthXWw5dL8Q5QlKX97Hx0e7NGAVh
	LJGBQt4vp5/DPjsQ5xI9DQPFsogYWvYiBJcPIy/bzTWIbozmxe93EUdZJS8rB4ML6h0bvd
	0FP7RDH/j1i5y61z7cJKKQdGK3BRkJI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-4bxKmQc7Mcii6jaqURVNGg-1; Tue, 03 Dec 2024 21:49:15 -0500
X-MC-Unique: 4bxKmQc7Mcii6jaqURVNGg-1
X-Mimecast-MFC-AGG-ID: 4bxKmQc7Mcii6jaqURVNGg
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2eeb4c251b4so426816a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 18:49:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733280554; x=1733885354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c24b0aojPcSy5fMUgMajgZWX2t8sneTXVxIv1lQUC1A=;
        b=v1llauDDU0xFyZkRzKok/Je0oG/tha3eTULflNTl78wceQ6MwkSSHIZ8fVSCB3A/Xu
         duyljLt1gvAnC1kCLebsolpUKZTTqdbOHwBDpvL98oXBTMfsTrHqt4llPSOOUFGNHOft
         Vr5SgUwoILmUXFTj4S/m4SC/PFobo2Vse6AiuyDKWTlckywysiRjzu0AKizNsNYS1ZDX
         xpfBJrEKh9pO0kHy3a6TMqDt+BTj/SSbAWn1RkkF2eEAaTM51kyO6lsadNtQqzUH4ZXl
         Ro723/b6TVecRJr1ApUp3RNESUs/qtpVpYVUXs9FAsYCHOkWGot1niDJgBG2T662yXUr
         zu0g==
X-Forwarded-Encrypted: i=1; AJvYcCX6e/vgf1zAC6mU+AO4likIbmg/o2AobydjUvwWWQxENDsLgL1UvKVB8SB6fNwde4O1/ZGdur4xsuLqKOU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxbn6zM/+loQwzOlb5Wg7xOsVEjMzSFx72WqtRfwppswyYniCZ
	6xKnub3vMCX9BrSYn0bOOodlG34hjcamzQqVMh2HiO/vN0nRyWfPUL730W+JWajI0Ea5IfV0oG7
	Tt86OkbiPT6zYt8vfH79nFYMiozyu+j0O4cl3oklxJwLgkuGOsaXrFmjt3QAHzT/3eFaxPaWk5O
	qB21t9Dyg2ICmdV/obfWtGIXI11wChICuobwjT
X-Gm-Gg: ASbGncs7+tft3ZXomKzETRxQLyqMgBy5cFBle8dD2tpXfcMJxPpiy5EPonF2hu/h2oJ
	iTYTfidVsx95/H6gYkE3q4DT+JLX6UFW9
X-Received: by 2002:a17:90b:1e4f:b0:2ee:ad18:b310 with SMTP id 98e67ed59e1d1-2ef0262ddc4mr7260534a91.18.1733280554224;
        Tue, 03 Dec 2024 18:49:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZcqsAhghjmH/484dFh700xwwcOiFPYlB810UI197DONEX9jOMQzSsmaISh5CyYuH1hhBd5fKSpxOiglUbnhk=
X-Received: by 2002:a17:90b:1e4f:b0:2ee:ad18:b310 with SMTP id
 98e67ed59e1d1-2ef0262ddc4mr7260510a91.18.1733280553846; Tue, 03 Dec 2024
 18:49:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203073025.67065-1-koichiro.den@canonical.com> <20241203073025.67065-5-koichiro.den@canonical.com>
In-Reply-To: <20241203073025.67065-5-koichiro.den@canonical.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Dec 2024 10:49:02 +0800
Message-ID: <CACGkMEuUa+6_uaa7H2CSvUnfNzBr-rdoQ+cp8eZD+Ay1CZ=A-g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 4/5] virtio_ring: add 'flushed' as an argument
 to virtqueue_reset()
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 3:31=E2=80=AFPM Koichiro Den <koichiro.den@canonical=
.com> wrote:
>
> When virtqueue_reset() has actually recycled all unused buffers,
> additional work may be required in some cases. Relying solely on its
> return status is fragile, so introduce a new argument 'flushed' to
> explicitly indicate whether it has really occurred.
>
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> ---
>  drivers/net/virtio_net.c     | 6 ++++--
>  drivers/virtio/virtio_ring.c | 6 +++++-
>  include/linux/virtio.h       | 3 ++-
>  3 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0103d7990e44..d5240a03b7d6 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -5695,6 +5695,7 @@ static int virtnet_rq_bind_xsk_pool(struct virtnet_=
info *vi, struct receive_queu
>                                     struct xsk_buff_pool *pool)
>  {
>         int err, qindex;
> +       bool flushed;
>
>         qindex =3D rq - vi->rq;
>
> @@ -5713,7 +5714,7 @@ static int virtnet_rq_bind_xsk_pool(struct virtnet_=
info *vi, struct receive_queu
>
>         virtnet_rx_pause(vi, rq);
>
> -       err =3D virtqueue_reset(rq->vq, virtnet_rq_unmap_free_buf);
> +       err =3D virtqueue_reset(rq->vq, virtnet_rq_unmap_free_buf, &flush=
ed);
>         if (err) {
>                 netdev_err(vi->dev, "reset rx fail: rx queue index: %d er=
r: %d\n", qindex, err);
>
> @@ -5737,12 +5738,13 @@ static int virtnet_sq_bind_xsk_pool(struct virtne=
t_info *vi,
>                                     struct xsk_buff_pool *pool)
>  {
>         int err, qindex;
> +       bool flushed;
>
>         qindex =3D sq - vi->sq;
>
>         virtnet_tx_pause(vi, sq);
>
> -       err =3D virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf);
> +       err =3D virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf, &flus=
hed);
>         if (err) {
>                 netdev_err(vi->dev, "reset tx fail: tx queue index: %d er=
r: %d\n", qindex, err);
>                 pool =3D NULL;
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 34a068d401ec..b522ef798946 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2828,6 +2828,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
>   * virtqueue_reset - detach and recycle all unused buffers
>   * @_vq: the struct virtqueue we're talking about.
>   * @recycle: callback to recycle unused buffers
> + * @flushed: whether or not unused buffers are all flushed
>   *
>   * Caller must ensure we don't call this with other virtqueue operations
>   * at the same time (except where noted).
> @@ -2839,14 +2840,17 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
>   * -EPERM: Operation not permitted
>   */
>  int virtqueue_reset(struct virtqueue *_vq,
> -                   void (*recycle)(struct virtqueue *vq, void *buf))
> +                   void (*recycle)(struct virtqueue *vq, void *buf),
> +                   bool *flushed)
>  {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
>         int err;
>
> +       *flushed =3D false;
>         err =3D virtqueue_disable_and_recycle(_vq, recycle);
>         if (err)
>                 return err;
> +       *flushed =3D true;
>

This makes me think if it would be easier if we just find a way to
reset the tx queue inside virtqueue_disable_and_recycle().

For example, introducing a recycle_done callback?

Thanks



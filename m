Return-Path: <linux-kernel+bounces-314321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2C396B1D6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88818B26C83
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 06:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC10130A7D;
	Wed,  4 Sep 2024 06:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bH0CaUEj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B253880C0C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 06:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725431698; cv=none; b=InGvfhCv4VSmNZYB+8pPwU/ut5aQdYh5ePd+gppoBwvOwDRm09mK1BDzqm55tr4g2Zc5uUSgT1gUXg9YFYo0NKIkdJzwZrYorbTuLpTAthTSG9wFP9g02sw3fUZ9cYZzmt4p4ctw86UK3BADkSYyn32V6QWlnqwCHIhWizXONIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725431698; c=relaxed/simple;
	bh=NHk8FpIJQC2mzNX+SVK98/2jJ0cuZFoSyhCWm6EdBtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aXBf2kl51LlhPBQkBbGZcRw2pGCytMX7V53CPoBuPXLHdYUvLn90sXwqFwx83C2caYEnlM5iRbDMtgh0PzPCtCVEXf58/c8BCb1zLXJMAKu5hiuyZulW8uNahK54X7J36p7aoAJw3Jb+ExUftV99Qi2eACdOGPBzDQM4wKsrSFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bH0CaUEj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725431695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CTZ9w0ekh4uK8i4TV5xGSvspEeutq9HPzTvoRIeqw5k=;
	b=bH0CaUEjCuNbvRgvdRu8uRqnLD7bEtTx6MtDP5FTvLz33bAbfhMbAPVOnUhEBWIxy1XAA/
	SiNHvAEQnYfjlAi9C2L3jdRI32WDC/wtwCzra5eqWCvAGgja3yPGIHqkTsHEOK+9B0Gd+g
	WwEoT9D9rgdVX/9tuVbTO0GTL+UqazM=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-ZRKInwgAOPyPRKBujq_0_Q-1; Wed, 04 Sep 2024 02:34:54 -0400
X-MC-Unique: ZRKInwgAOPyPRKBujq_0_Q-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-715e085835fso6611661b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 23:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725431514; x=1726036314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CTZ9w0ekh4uK8i4TV5xGSvspEeutq9HPzTvoRIeqw5k=;
        b=TnI6fL3RRz9yjGPpJ5B4GdJ7Xg5cFP9aAnb9WJakWzVvXSRa3r3RLMnGksh5y4PULM
         0rRnc6sWPOy0G2OZiB4pOTaQ29939yCwrfLD9lqumcl8miIcsE8YRLViBtFAKjR/To3w
         f4NJrFZc7tjCUmOn4UBW4miQPIlIYvRbVs4z4npwrLk7s92pI+PZlJSyTm1eiyg82oqp
         YQ4XYI9VsNO6/ibzGb99MSsEx7BknrDZHxwUZjy4pB1fpUurG298dEc9fFkTLXyh+Neh
         TNaEyUAAEOP5sIcSq23IBIVOS7Z+VHzECJQjw5NkkLq5LPS/YziGbTUbDpF42mQCvWkm
         C35w==
X-Forwarded-Encrypted: i=1; AJvYcCUzdIxCGxW8hnl85jqE6iftbi32LZAUlcuwqYlLOqeyYKUssl5gM4rqdJr+6sYDI9o9RZyE15+3TCl/imY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjbrDtnbqqxeFM2hJy2k+v0WF45rcXg8WmMjay0711rfH9FB6V
	K+5/WOD5GX9V4CK/Kbg7NBYCQ9SXneaLCjju3GJpB2l0ukkXUNQbmZ8sqHmZJ3u9J6Q0oRT9/pL
	zJlQczYKgQJsdayozb7AL9kM8a664htsHxKa2YoBcTLdFpJEnTpZjJM7PE0+GNxIHkaoGnpjhm2
	YDpAP9kiIWWCE4k/6e3zBGq4yGnSFBVi4Rrmaf
X-Received: by 2002:a05:6a20:9c89:b0:1ca:981:8e4e with SMTP id adf61e73a8af0-1cce1003859mr18255946637.3.1725431513972;
        Tue, 03 Sep 2024 23:31:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA2IPAlHgkpPhPv0OlmQPhO59Hrm6A57UoLBdFNZjRY9QRb8AYf52TsZjskxoDtYGD0Us3AKueXQPBXy7HSlo=
X-Received: by 2002:a05:6a20:9c89:b0:1ca:981:8e4e with SMTP id
 adf61e73a8af0-1cce1003859mr18255924637.3.1725431513524; Tue, 03 Sep 2024
 23:31:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904061009.90785-1-liwenbo.martin@bytedance.com>
In-Reply-To: <20240904061009.90785-1-liwenbo.martin@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Sep 2024 14:31:42 +0800
Message-ID: <CACGkMEsMnEX25+-jyn3sjwF4iDEFCWKX2478dK-mf-fJeBrKtA@mail.gmail.com>
Subject: Re: [PATCH v2] virtio_net: Fix mismatched buf address when unmapping
 for small packets
To: Wenbo Li <liwenbo.martin@bytedance.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jiahui Cen <cenjiahui@bytedance.com>, 
	Ying Fang <fangying.tommy@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 2:10=E2=80=AFPM Wenbo Li <liwenbo.martin@bytedance.c=
om> wrote:
>
> Currently, the virtio-net driver will perform a pre-dma-mapping for
> small or mergeable RX buffer. But for small packets, a mismatched address
> without VIRTNET_RX_PAD and xdp_headroom is used for unmapping.
>
> That will result in unsynchronized buffers when SWIOTLB is enabled, for
> example, when running as a TDX guest.
>
> This patch handles small and mergeable packets separately and fixes
> the mismatched buffer address.
>
> Changes from v1: Use ctx to get xdp_headroom.
>
> Fixes: 295525e29a5b ("virtio_net: merge dma operations when filling merge=
able buffers")
> Signed-off-by: Wenbo Li <liwenbo.martin@bytedance.com>
> Signed-off-by: Jiahui Cen <cenjiahui@bytedance.com>
> Signed-off-by: Ying Fang <fangying.tommy@bytedance.com>
> ---
>  drivers/net/virtio_net.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c6af18948..cbc3c0ae4 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -891,6 +891,23 @@ static void *virtnet_rq_get_buf(struct receive_queue=
 *rq, u32 *len, void **ctx)
>         return buf;
>  }
>
> +static void *virtnet_rq_get_buf_small(struct receive_queue *rq,
> +                                     u32 *len,
> +                                     void **ctx,
> +                                     unsigned int header_offset)

header_offset is unused?

> +{
> +       void *buf;
> +       unsigned int xdp_headroom;
> +
> +       buf =3D virtqueue_get_buf_ctx(rq->vq, len, ctx);
> +       if (buf) {
> +               xdp_headroom =3D (unsigned long)*ctx;
> +               virtnet_rq_unmap(rq, buf + VIRTNET_RX_PAD + xdp_headroom,=
 *len);
> +       }
> +
> +       return buf;
> +}
> +
>  static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, =
u32 len)
>  {
>         struct virtnet_rq_dma *dma;
> @@ -2692,13 +2709,23 @@ static int virtnet_receive_packets(struct virtnet=
_info *vi,
>         int packets =3D 0;
>         void *buf;
>
> -       if (!vi->big_packets || vi->mergeable_rx_bufs) {
> +       if (vi->mergeable_rx_bufs) {
>                 void *ctx;
>                 while (packets < budget &&
>                        (buf =3D virtnet_rq_get_buf(rq, &len, &ctx))) {
>                         receive_buf(vi, rq, buf, len, ctx, xdp_xmit, stat=
s);
>                         packets++;
>                 }
> +       } else if (!vi->big_packets) {
> +               void *ctx;
> +               unsigned int xdp_headroom =3D virtnet_get_headroom(vi);
> +               unsigned int header_offset =3D VIRTNET_RX_PAD + xdp_headr=
oom;
> +
> +               while (packets < budget &&
> +                      (buf =3D virtnet_rq_get_buf_small(rq, &len, &ctx, =
header_offset))) {
> +                       receive_buf(vi, rq, buf, len, ctx, xdp_xmit, stat=
s);
> +                       packets++;
> +               }
>         } else {
>                 while (packets < budget &&
>                        (buf =3D virtqueue_get_buf(rq->vq, &len)) !=3D NUL=
L) {
> --
> 2.20.1
>

Thanks



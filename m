Return-Path: <linux-kernel+bounces-216611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EAB90A215
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 03:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 977541F24E6F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 01:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED193176AD3;
	Mon, 17 Jun 2024 01:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H1IL27Vb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C684615FA7A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 01:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718589107; cv=none; b=QHOYix33w0QMFZT+RgaDL7lUR/TOOYrtvN5OCarS54Dw3ryCpVlZttASK1JhUdTGSgDLfCiSJa/ji5pmM46D8ZIwpE/aQhsoUgf8o8ddV25iQrPiKt8hijci6mebulIohQMK1OR+sx9pFAK6xNdV3B/FuNrWmbhh/Hd9JumAQdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718589107; c=relaxed/simple;
	bh=KrtdDO/VCr23v8ybpPvgLXMiSCeSjc0+KH0kowuinfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JL0Uyda3Q0WW6lvMiU2MCLTyqvPa96VK4q3lIlHN1A+/8ISP7hAnzUJB1vG1Jq0sL+aKDfmrkyVqjX/kugGSckTn2608iLpsGhhG4dtWOfcqnPiLU8mOn7R8BIU+4ar9r1W6lEhPCRtotTm89HISkHrGS+JmRebn3PErDPKe9yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H1IL27Vb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718589104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8sFa9jqalWQkohxBGb7r1/BRwO9hzM28tWfgameCGoM=;
	b=H1IL27VbBgM5JBolGVSDIrSv8d4WCNJg3NMyous+u4IXMI2AMKmIJL+SMvmsXrhnS9INie
	lwmkDJ3+LG7aUI2dm7CEcOlZ8cP5buR3dodvRvGgeQyOOWlLNzBI+pNemIlEzBYIGn3FWT
	yxLFy2XbVNA8YALFngDgQtuFtAMqymo=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-dW__jSasMBqIM1MlD5_RLA-1; Sun, 16 Jun 2024 21:51:43 -0400
X-MC-Unique: dW__jSasMBqIM1MlD5_RLA-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-6fb1b675545so3889193a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 18:51:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718589102; x=1719193902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sFa9jqalWQkohxBGb7r1/BRwO9hzM28tWfgameCGoM=;
        b=SSDjew0cyno2RbSrHhRjPErOUA9NH3m0YtfiardbIOySfLw3WEM6LvntkihbcXAkpC
         sxbi7C1Qo5cCxRPIiaz5UlPZ98jRqGtoCpzNoChJCKhIpRdQpVRa8hExc85+TKeenVvP
         vUOblA1ywIsK6I78KajpUgiVOHvAgpPOUQdUxiDYo+PqTrqpnIM5tSYQmExui9Vk70U4
         joeKg+qlU8QDw7wetS4l21wlXVhFrLlgc2666phiaRTQOFyxpX+KfwUITuO8l5jTwkZr
         G3FG7LZGNg7Rj86o+pnQHxO3plW6BKy35XijOezujzD+Nu2jY0rS3OGUtCzNAjHqi5u0
         yGEA==
X-Forwarded-Encrypted: i=1; AJvYcCVnef02JGCUDLLTQ/XWLMp/pFfwXdKiRUfoNRBjXPe+XqZSVKkUJ4HjfI2rpkWRbF3ZcSazXpRIUzkaHkVv/OM4NwHFrn2xU4BLqkL/
X-Gm-Message-State: AOJu0Yz/GtsMRAPByGze2703sTdB8qaGAFoEhmLsV/WUXkKV7PVKNuKR
	xasffm8+qfgdWTxLVnMu+DC3IALoiYgy3+JqZ7ijggAsU5VGMaxq2NDLGEEtBADy6BGoUrorXGY
	UBRx0HJBCd7iKn5++aRmaG7VvhNX0y+f4zx01Zyob5wewt9RQyHCHd9cunCr7VHzZDIUSfBk50e
	fb2W20sF530iCnw1SdyLAXRLuetEiauB/Tm2W+
X-Received: by 2002:a05:6a20:9705:b0:1b6:d9fa:8bd with SMTP id adf61e73a8af0-1bae7e7d746mr9987509637.25.1718589102241;
        Sun, 16 Jun 2024 18:51:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKgEBaAC5HQqbCxUsXuTfI029p4WEvw6v7kCzjrPyFhRt1ZFQs3vMZt900K6rK/wsx8brxoPR4nl9Zu4d7zU0=
X-Received: by 2002:a05:6a20:9705:b0:1b6:d9fa:8bd with SMTP id
 adf61e73a8af0-1bae7e7d746mr9987491637.25.1718589101920; Sun, 16 Jun 2024
 18:51:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614220422.42733-1-jain.abhinav177@gmail.com>
In-Reply-To: <20240614220422.42733-1-jain.abhinav177@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Jun 2024 09:51:30 +0800
Message-ID: <CACGkMEt1nREjoe9bSmwoAmbbpA5mCSiC7QizE5rHCas0xvfgEA@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: Eliminate OOO packets during switching
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	javier.carrasco.cruz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 15, 2024 at 6:05=E2=80=AFAM Abhinav Jain <jain.abhinav177@gmail=
.com> wrote:
>
> Disable the network device & turn off carrier before modifying the
> number of queue pairs.
> Process all the in-flight packets and then turn on carrier, followed
> by waking up all the queues on the network device.
>
> Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
> ---
>  drivers/net/virtio_net.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 61a57d134544..d0a655a3b4c6 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3447,7 +3447,6 @@ static void virtnet_get_drvinfo(struct net_device *=
dev,
>
>  }
>
> -/* TODO: Eliminate OOO packets during switching */
>  static int virtnet_set_channels(struct net_device *dev,
>                                 struct ethtool_channels *channels)
>  {
> @@ -3471,6 +3470,15 @@ static int virtnet_set_channels(struct net_device =
*dev,
>         if (vi->rq[0].xdp_prog)
>                 return -EINVAL;
>
> +       /* Disable network device to prevent packet processing during
> +        * the switch.
> +        */
> +       netif_tx_disable(dev);
> +       netif_carrier_off(dev);

Any reason we don't need to synchronize with NAPI here?

Thanks

> +
> +       /* Make certain that all in-flight packets are processed. */
> +       synchronize_net();
> +
>         cpus_read_lock();
>         err =3D virtnet_set_queues(vi, queue_pairs);
>         if (err) {
> @@ -3482,7 +3490,12 @@ static int virtnet_set_channels(struct net_device =
*dev,
>
>         netif_set_real_num_tx_queues(dev, queue_pairs);
>         netif_set_real_num_rx_queues(dev, queue_pairs);
> - err:
> +
> +       /* Restart the network device */
> +       netif_carrier_on(dev);
> +       netif_tx_wake_all_queues(dev);
> +
> +err:
>         return err;
>  }
>
> --
> 2.34.1
>



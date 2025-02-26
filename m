Return-Path: <linux-kernel+bounces-533038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27413A4550C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35E1B188EBCE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 05:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4882F267F64;
	Wed, 26 Feb 2025 05:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X8JyWRyz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5B1267B1C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 05:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740548953; cv=none; b=QPVl51gMJTMVBG4ohmp2rpdhZlikMoEpbLlex3D/3w6GKmBhlaNgsfb9r9cBZVBmKass2sIlGIVL/D7JD7D+zGbQF/OLFDSFIZwcmR0z+4lQ40m68N9vFIRQk77gKjZrwCEnyBvpN7pdeXjA5VGEGaJyEe6b/u5jYJuJMW5CIRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740548953; c=relaxed/simple;
	bh=hqqcCdPMVooooWngvgN4tV2EfEuA1ABEORr+ZrijTfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KaKrE12GvzuPZAwz130ptEifH4I7UlW1LkwFAkr7Eevit/kpF6KVmBWmAEjVFrn6dg46TLlBIhas2a7JPnNFmhktNbuLSq4w4TgqSgBeL+nZEF9V+aDSkEZeCqZA2mODTjFtuBjUyJAAJanuYrg/UOKfS3HPIIcLbSxNagOWS10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X8JyWRyz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740548950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aE4JkoNvfDTdeIMWAMDlOpX2WdoSYaOC9pAuENsHwYQ=;
	b=X8JyWRyzvG5OubsyEp0J6tFKYIqfucm/It4NfJdu1SVFeOLVvvNRTNH/qda+cSZDYu1n2J
	XDG9S+8vswPdwIw9juaGptlc88Y0JPmVWxJEPVHRL7X4pvRXm40eaB4B4+GBRN5L6CSys4
	54CkRknkrHvA8gA5ln/jE3OF49eYS3k=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-4-QSmYQ4MMKk5A3pFYj3GQ-1; Wed, 26 Feb 2025 00:49:04 -0500
X-MC-Unique: 4-QSmYQ4MMKk5A3pFYj3GQ-1
X-Mimecast-MFC-AGG-ID: 4-QSmYQ4MMKk5A3pFYj3GQ_1740548944
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fc1eabf4f7so13940426a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 21:49:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740548943; x=1741153743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aE4JkoNvfDTdeIMWAMDlOpX2WdoSYaOC9pAuENsHwYQ=;
        b=E4RRuFMNYEvo8DB4g9EhancUl+pxW4zdB1WyJmG2qq70FxrHhlAEsigiCwnsLK/P6z
         MUOrJz26XQJ2Z1ZbL8ddxsHQ+hLH9hRGxu/qS1FiHP02T58G5VHujZzd9OQKxxYl02fp
         2Y4G6uRwt8Z0RWR02W7+f9s5pQxjaPXNlDsLaADN0keKGVxuyShONeoOxFSOrtab8NkC
         71p6HFOmu1CM3N8Sk3kgj8QzA66y1jYtiSGfsFmIo3Uxq2uyl9JWFYp90UtULscJWdhJ
         BuDaMxcDctIjN7rOPBDJe2jUzAJNE7pQuCNocSjUU+xmcSutUIWmzh5M0AHOqYeeQz4A
         rvZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzX1ghBjHIZIfWZZ97j41wo6S6ASk4/sqoc42CyZVdPh1btgNWC2VzpQTw8dKkIg1QiakBHldppTm4dnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcS/cwJ7cg2YK/gkkJPp7EqXTxivYZ8JNK2adWALsGNtcnGJ7g
	vuT37a0u+UAzbYyxgRafNEcJqXfnwq/QjbCAD4iCLlhiTKLnaMVipev1cdXwoPAjKE1M49lgEQi
	rLELx7Hl7OW8K1xIwD7AaNK+W2oXKaKwVzV6RyYGmG+xbPZCDZ6FZKFCeAzlNw7iVK48sBlSbRc
	ZC6+5AIzKQ/eaq6EpiGVMgf/L9BwzBS/+phbwj
X-Gm-Gg: ASbGncufMvz5Q52zrsSzj8lwj6GlrJuDvPwejerYnlmrGmpJfIE/ISkCMGiDmWHbKQ0
	NZWlh6zsaDLawBXqyIcCI5wYkfTgmj7HulU05LBaINIL98eNtURC+aNGyap+eW5ndFdR0E5wQfQ
	==
X-Received: by 2002:a17:90b:56ce:b0:2ee:af31:a7bd with SMTP id 98e67ed59e1d1-2fe68ac9677mr8976272a91.5.1740548943556;
        Tue, 25 Feb 2025 21:49:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1cQJOreRhNipg8RG8SHD6a6eCQXDwKn/KRknNwemdrteiyX7QaFKrqNkhS/i2MNdbjrnwQMsnA81JLuU9C3k=
X-Received: by 2002:a17:90b:56ce:b0:2ee:af31:a7bd with SMTP id
 98e67ed59e1d1-2fe68ac9677mr8976239a91.5.1740548943131; Tue, 25 Feb 2025
 21:49:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225020455.212895-1-jdamato@fastly.com> <20250225020455.212895-4-jdamato@fastly.com>
In-Reply-To: <20250225020455.212895-4-jdamato@fastly.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Feb 2025 13:48:50 +0800
X-Gm-Features: AWEUYZmNxwdlHR-rvkj2CTip3bPJLbeQFDHT1vQC8t3dWY5cp0G7mHaR4pRJtEE
Message-ID: <CACGkMEv6y+TkZnWWLPG4UE59iyREhkiaby8kj==cnp=6chmu+w@mail.gmail.com>
Subject: Re: [PATCH net-next v4 3/4] virtio-net: Map NAPIs to queues
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, 
	gerhard@engleder-embedded.com, xuanzhuo@linux.alibaba.com, kuba@kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 10:05=E2=80=AFAM Joe Damato <jdamato@fastly.com> wr=
ote:
>
> Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
> can be accessed by user apps, taking care to hold RTNL as needed.

I may miss something but I wonder whether letting the caller hold the
lock is better.

More below.

>
> $ ethtool -i ens4 | grep driver
> driver: virtio_net
>
> $ sudo ethtool -L ens4 combined 4
>
> $ ./tools/net/ynl/pyynl/cli.py \
>        --spec Documentation/netlink/specs/netdev.yaml \
>        --dump queue-get --json=3D'{"ifindex": 2}'
> [{'id': 0, 'ifindex': 2, 'napi-id': 8289, 'type': 'rx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8290, 'type': 'rx'},
>  {'id': 2, 'ifindex': 2, 'napi-id': 8291, 'type': 'rx'},
>  {'id': 3, 'ifindex': 2, 'napi-id': 8292, 'type': 'rx'},
>  {'id': 0, 'ifindex': 2, 'type': 'tx'},
>  {'id': 1, 'ifindex': 2, 'type': 'tx'},
>  {'id': 2, 'ifindex': 2, 'type': 'tx'},
>  {'id': 3, 'ifindex': 2, 'type': 'tx'}]
>
> Note that virtio_net has TX-only NAPIs which do not have NAPI IDs, so
> the lack of 'napi-id' in the above output is expected.
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  drivers/net/virtio_net.c | 73 ++++++++++++++++++++++++++++------------
>  1 file changed, 52 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e578885c1093..13bb4a563073 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2807,6 +2807,20 @@ static void skb_recv_done(struct virtqueue *rvq)
>         virtqueue_napi_schedule(&rq->napi, rvq);
>  }
>
> +static void virtnet_queue_set_napi(struct net_device *dev,
> +                                  struct napi_struct *napi,
> +                                  enum netdev_queue_type q_type, int qid=
x,
> +                                  bool need_rtnl)
> +{
> +       if (need_rtnl)
> +               rtnl_lock();
> +
> +       netif_queue_set_napi(dev, qidx, q_type, napi);
> +
> +       if (need_rtnl)
> +               rtnl_unlock();
> +}
> +
>  static void virtnet_napi_do_enable(struct virtqueue *vq,
>                                    struct napi_struct *napi)
>  {
> @@ -2821,15 +2835,21 @@ static void virtnet_napi_do_enable(struct virtque=
ue *vq,
>         local_bh_enable();
>  }
>
> -static void virtnet_napi_enable(struct receive_queue *rq)
> +static void virtnet_napi_enable(struct receive_queue *rq, bool need_rtnl=
)
>  {
> +       struct virtnet_info *vi =3D rq->vq->vdev->priv;
> +       int qidx =3D vq2rxq(rq->vq);
> +
>         virtnet_napi_do_enable(rq->vq, &rq->napi);
> +       virtnet_queue_set_napi(vi->dev, &rq->napi,
> +                              NETDEV_QUEUE_TYPE_RX, qidx, need_rtnl);
>  }
>
> -static void virtnet_napi_tx_enable(struct send_queue *sq)
> +static void virtnet_napi_tx_enable(struct send_queue *sq, bool need_rtnl=
)
>  {
>         struct virtnet_info *vi =3D sq->vq->vdev->priv;
>         struct napi_struct *napi =3D &sq->napi;
> +       int qidx =3D vq2txq(sq->vq);
>
>         if (!napi->weight)
>                 return;
> @@ -2843,20 +2863,31 @@ static void virtnet_napi_tx_enable(struct send_qu=
eue *sq)
>         }
>
>         virtnet_napi_do_enable(sq->vq, napi);
> +       virtnet_queue_set_napi(vi->dev, napi, NETDEV_QUEUE_TYPE_TX, qidx,
> +                              need_rtnl);
>  }
>
> -static void virtnet_napi_tx_disable(struct send_queue *sq)
> +static void virtnet_napi_tx_disable(struct send_queue *sq, bool need_rtn=
l)
>  {
> +       struct virtnet_info *vi =3D sq->vq->vdev->priv;
>         struct napi_struct *napi =3D &sq->napi;
> +       int qidx =3D vq2txq(sq->vq);
>
> -       if (napi->weight)
> +       if (napi->weight) {
> +               virtnet_queue_set_napi(vi->dev, NULL, NETDEV_QUEUE_TYPE_T=
X,
> +                                      qidx, need_rtnl);
>                 napi_disable(napi);
> +       }
>  }
>
> -static void virtnet_napi_disable(struct receive_queue *rq)
> +static void virtnet_napi_disable(struct receive_queue *rq, bool need_rtn=
l)
>  {
> +       struct virtnet_info *vi =3D rq->vq->vdev->priv;
>         struct napi_struct *napi =3D &rq->napi;
> +       int qidx =3D vq2rxq(rq->vq);
>
> +       virtnet_queue_set_napi(vi->dev, NULL, NETDEV_QUEUE_TYPE_TX, qidx,
> +                              need_rtnl);
>         napi_disable(napi);
>  }
>
> @@ -2870,9 +2901,9 @@ static void refill_work(struct work_struct *work)
>         for (i =3D 0; i < vi->curr_queue_pairs; i++) {
>                 struct receive_queue *rq =3D &vi->rq[i];
>
> -               virtnet_napi_disable(rq);
> +               virtnet_napi_disable(rq, true);
>                 still_empty =3D !try_fill_recv(vi, rq, GFP_KERNEL);
> -               virtnet_napi_enable(rq);
> +               virtnet_napi_enable(rq, true);
>
>                 /* In theory, this can happen: if we don't get any buffer=
s in
>                  * we will *never* try to fill again.
> @@ -3069,8 +3100,8 @@ static int virtnet_poll(struct napi_struct *napi, i=
nt budget)
>
>  static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_i=
ndex)
>  {
> -       virtnet_napi_tx_disable(&vi->sq[qp_index]);
> -       virtnet_napi_disable(&vi->rq[qp_index]);
> +       virtnet_napi_tx_disable(&vi->sq[qp_index], false);
> +       virtnet_napi_disable(&vi->rq[qp_index], false);
>         xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
>  }
>
> @@ -3089,8 +3120,8 @@ static int virtnet_enable_queue_pair(struct virtnet=
_info *vi, int qp_index)
>         if (err < 0)
>                 goto err_xdp_reg_mem_model;
>
> -       virtnet_napi_enable(&vi->rq[qp_index]);
> -       virtnet_napi_tx_enable(&vi->sq[qp_index]);
> +       virtnet_napi_enable(&vi->rq[qp_index], false);
> +       virtnet_napi_tx_enable(&vi->sq[qp_index], false);
>
>         return 0;
>
> @@ -3342,7 +3373,7 @@ static void virtnet_rx_pause(struct virtnet_info *v=
i, struct receive_queue *rq)
>         bool running =3D netif_running(vi->dev);
>
>         if (running) {
> -               virtnet_napi_disable(rq);
> +               virtnet_napi_disable(rq, true);

During the resize, the rtnl lock has been held on the ethtool path

        rtnl_lock();
        rc =3D __dev_ethtool(net, ifr, useraddr, ethcmd, state);
        rtnl_unlock();

virtnet_rx_resize()
    virtnet_rx_pause()

and in the case of XSK binding, I see ASSERT_RTNL in xp_assign_dev() at lea=
st.

Thanks



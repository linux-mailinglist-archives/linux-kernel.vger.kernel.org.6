Return-Path: <linux-kernel+bounces-410605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A099B9CDDF0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 12:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304F41F22BDD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 11:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EB31BBBD0;
	Fri, 15 Nov 2024 11:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N6PfnwHS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D5F1B2EEB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 11:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731671963; cv=none; b=GQRwgxvaLJ6Tl0VU/3EouaAPKCcTIZhmlHNhlWvhClwS00QdsFdJSdgI3abN4XAc4oHqvZD4NthXvuBneprYwg1te1IO5lx2bwf2S8s8lGzeda5NwAiHdkgGanzbNeftKwP6SJA6jCz6lhkoVSxz4ccRgjNvb8Yug8VBx+OICOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731671963; c=relaxed/simple;
	bh=2pulDDreteiHjL9r4qUGqKDhpqeb1HMkFOW42Xg7+Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kL+Gn7+blUGz8boPC2n6N/PvisTJyOs1exE7LCkiNeI47HRmHVnP9dk4aEEnUTZH/bFMfwwY7dZdXjghgXt5qVowGaDolZt+pXpsiHwqHG17nmc72wsfFjVtHjzby5hsCOUCEuD1BaJn9hUzULlONwp1m8Kl0u2OX6W92zRx874=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N6PfnwHS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731671960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KWFhnUI/8u1MsI357oWFQrDLalvod+ZiB7DQP1zPYnA=;
	b=N6PfnwHSnw8ElqvfDpbFO5/woGEVGcgDRt+1S449QeFmvCXlJhW4SMVh0FuV0LV0hHbivf
	RB+pPjAqbBEjFjfnW0uGaOp06rAg3zSlm2nzVV7PbhTwFeo2V6oELqtLVYOTgOlcpH61Q3
	lB3xEKGWbpkDm9c35pOcwa0R9weGW7Y=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-jBC3DywTNGuGnlnXER_3nw-1; Fri, 15 Nov 2024 06:59:19 -0500
X-MC-Unique: jBC3DywTNGuGnlnXER_3nw-1
X-Mimecast-MFC-AGG-ID: jBC3DywTNGuGnlnXER_3nw
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b147855414so203871885a.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 03:59:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731671959; x=1732276759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWFhnUI/8u1MsI357oWFQrDLalvod+ZiB7DQP1zPYnA=;
        b=eAgKQ8tf+VNu6BnNY1S6wY7A167nviM53xlGWSpnawZ3VWwKUcQejQY85ifu84OHcG
         f56aNISwZOBt0WgWqKX4UAEs+IID9g5ui7TbyfErEvojtMPangOX8ug3R2uU3jLROam9
         0Uzxq4L8azWSkFpqekbmvreChVWVJlPmkP/rZ68l9CNV49xH8Pu7VUpaFZksQ2+xq0gG
         HGU8O1WjxvtPGXfiJRM2n1DilYnfRDziqQNbffegUM91u42MRV/FAM0DD65VrzVCHiKh
         kYMNzsq488CHPMmchdPwDvIFC+7jxXqW5RKg8hGsGxNeN2+MKmtbb4Y+Sy78xWKW4X3a
         1T9A==
X-Forwarded-Encrypted: i=1; AJvYcCVvDx3NGAr1FZEfrWvK3GijH6y2i8HJC3QuMDSnN71GOdR9/kpq5+J1ZwzT3hlfkQtk+f/AzAvAbI4PFzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWy4x8bc+ibALFzFkllNfvFZfwSvbYgOkpb9UVIeaQcYcJ9/IJ
	76v5LBFjE1SY5agmwUaWqJlMrTilOs+zz35EySm65Yl0a03BvcGnQOOUWdv2GhMI8ZbA5iFEryg
	F84WCW0Vgf5j+6rjNJC6jyS+QhPw5N3g0a50GlPGb4pWlZhHgVB0JcyWWsoK4WQ==
X-Received: by 2002:a05:620a:179e:b0:7b3:56f4:6e09 with SMTP id af79cd13be357-7b3622bcab6mr264000185a.27.1731671958887;
        Fri, 15 Nov 2024 03:59:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfVKO66Y6rgNt/itCv3b+8Dv2NvBLsA25nUYuxO9qTqEw2uRmmntwxkoCY3pA5nCghXARiwg==
X-Received: by 2002:a05:620a:179e:b0:7b3:56f4:6e09 with SMTP id af79cd13be357-7b3622bcab6mr263998485a.27.1731671958500;
        Fri, 15 Nov 2024 03:59:18 -0800 (PST)
Received: from sgarzare-redhat ([79.46.200.129])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35c984691sm151968885a.2.2024.11.15.03.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 03:59:17 -0800 (PST)
Date: Fri, 15 Nov 2024 12:59:07 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, Asias He <asias@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] vsock/virtio: Remove queued_replies pushback logic
Message-ID: <yjhfe5bsnfpqbnibxl2urrnuowzitxnrbodlihz4y5csig7e7p@drgxxxxgokfo>
References: <20241115103016.86461-1-graf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241115103016.86461-1-graf@amazon.com>

On Fri, Nov 15, 2024 at 10:30:16AM +0000, Alexander Graf wrote:
>Ever since the introduction of the virtio vsock driver, it included
>pushback logic that blocks it from taking any new RX packets until the
>TX queue backlog becomes shallower than the virtqueue size.
>
>This logic works fine when you connect a user space application on the
>hypervisor with a virtio-vsock target, because the guest will stop
>receiving data until the host pulled all outstanding data from the VM.

So, why not skipping this only when talking with a sibling VM?

>
>With Nitro Enclaves however, we connect 2 VMs directly via vsock:
>
>  Parent      Enclave
>
>    RX -------- TX
>    TX -------- RX
>
>This means we now have 2 virtio-vsock backends that both have the pushback
>logic. If the parent's TX queue runs full at the same time as the
>Enclave's, both virtio-vsock drivers fall into the pushback path and
>no longer accept RX traffic. However, that RX traffic is TX traffic on
>the other side which blocks that driver from making any forward
>progress. We're not in a deadlock.
>
>To resolve this, let's remove that pushback logic altogether and rely on
>higher levels (like credits) to ensure we do not consume unbounded
>memory.

I spoke quickly with Stefan who has been following the development from
the beginning and actually pointed out that there might be problems
with the control packets, since credits only covers data packets, so
it doesn't seem like a good idea remove this mechanism completely.

>
>Fixes: 0ea9e1d3a9e3 ("VSOCK: Introduce virtio_transport.ko")

I'm not sure we should add this Fixes tag, this seems very risky
backporting on stable branches IMHO.

If we cannot find a better mechanism to replace this with something
that works both guest <-> host and guest <-> guest, I would prefer
to do this just for guest <-> guest communication.
Because removing this completely seems too risky for me, at least
without a proof that control packets are fine.

Thanks,
Stefano

>Signed-off-by: Alexander Graf <graf@amazon.com>
>---
> net/vmw_vsock/virtio_transport.c | 51 ++------------------------------
> 1 file changed, 2 insertions(+), 49 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 64a07acfef12..53e79779886c 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -44,8 +44,6 @@ struct virtio_vsock {
> 	struct work_struct send_pkt_work;
> 	struct sk_buff_head send_pkt_queue;
>
>-	atomic_t queued_replies;
>-
> 	/* The following fields are protected by rx_lock.  vqs[VSOCK_VQ_RX]
> 	 * must be accessed with rx_lock held.
> 	 */
>@@ -171,17 +169,6 @@ virtio_transport_send_pkt_work(struct work_struct *work)
>
> 		virtio_transport_deliver_tap_pkt(skb);
>
>-		if (reply) {
>-			struct virtqueue *rx_vq = vsock->vqs[VSOCK_VQ_RX];
>-			int val;
>-
>-			val = atomic_dec_return(&vsock->queued_replies);
>-
>-			/* Do we now have resources to resume rx processing? */
>-			if (val + 1 == virtqueue_get_vring_size(rx_vq))
>-				restart_rx = true;
>-		}
>-
> 		added = true;
> 	}
>
>@@ -218,9 +205,6 @@ virtio_transport_send_pkt(struct sk_buff *skb)
> 		goto out_rcu;
> 	}
>
>-	if (virtio_vsock_skb_reply(skb))
>-		atomic_inc(&vsock->queued_replies);
>-
> 	virtio_vsock_skb_queue_tail(&vsock->send_pkt_queue, skb);
> 	queue_work(virtio_vsock_workqueue, &vsock->send_pkt_work);
>
>@@ -233,7 +217,7 @@ static int
> virtio_transport_cancel_pkt(struct vsock_sock *vsk)
> {
> 	struct virtio_vsock *vsock;
>-	int cnt = 0, ret;
>+	int ret;
>
> 	rcu_read_lock();
> 	vsock = rcu_dereference(the_virtio_vsock);
>@@ -242,17 +226,7 @@ virtio_transport_cancel_pkt(struct vsock_sock *vsk)
> 		goto out_rcu;
> 	}
>
>-	cnt = virtio_transport_purge_skbs(vsk, &vsock->send_pkt_queue);
>-
>-	if (cnt) {
>-		struct virtqueue *rx_vq = vsock->vqs[VSOCK_VQ_RX];
>-		int new_cnt;
>-
>-		new_cnt = atomic_sub_return(cnt, &vsock->queued_replies);
>-		if (new_cnt + cnt >= virtqueue_get_vring_size(rx_vq) &&
>-		    new_cnt < virtqueue_get_vring_size(rx_vq))
>-			queue_work(virtio_vsock_workqueue, &vsock->rx_work);
>-	}
>+	virtio_transport_purge_skbs(vsk, &vsock->send_pkt_queue);
>
> 	ret = 0;
>
>@@ -323,18 +297,6 @@ static void virtio_transport_tx_work(struct work_struct *work)
> 		queue_work(virtio_vsock_workqueue, &vsock->send_pkt_work);
> }
>
>-/* Is there space left for replies to rx packets? */
>-static bool virtio_transport_more_replies(struct virtio_vsock *vsock)
>-{
>-	struct virtqueue *vq = vsock->vqs[VSOCK_VQ_RX];
>-	int val;
>-
>-	smp_rmb(); /* paired with atomic_inc() and atomic_dec_return() */
>-	val = atomic_read(&vsock->queued_replies);
>-
>-	return val < virtqueue_get_vring_size(vq);
>-}
>-
> /* event_lock must be held */
> static int virtio_vsock_event_fill_one(struct virtio_vsock *vsock,
> 				       struct virtio_vsock_event *event)
>@@ -581,14 +543,6 @@ static void virtio_transport_rx_work(struct work_struct *work)
> 			struct sk_buff *skb;
> 			unsigned int len;
>
>-			if (!virtio_transport_more_replies(vsock)) {
>-				/* Stop rx until the device processes already
>-				 * pending replies.  Leave rx virtqueue
>-				 * callbacks disabled.
>-				 */
>-				goto out;
>-			}
>-
> 			skb = virtqueue_get_buf(vq, &len);
> 			if (!skb)
> 				break;
>@@ -735,7 +689,6 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
>
> 	vsock->rx_buf_nr = 0;
> 	vsock->rx_buf_max_nr = 0;
>-	atomic_set(&vsock->queued_replies, 0);
>
> 	mutex_init(&vsock->tx_lock);
> 	mutex_init(&vsock->rx_lock);
>-- 
>2.40.1
>
>
>
>
>Amazon Web Services Development Center Germany GmbH
>Krausenstr. 38
>10117 Berlin
>Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
>Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
>Sitz: Berlin
>Ust-ID: DE 365 538 597
>
>



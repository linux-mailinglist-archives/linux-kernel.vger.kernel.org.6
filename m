Return-Path: <linux-kernel+bounces-268715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E7E94283F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB4E8B23020
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3031A7F63;
	Wed, 31 Jul 2024 07:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="htdFB0CY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63921A76C4
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722411604; cv=none; b=dEpvLR2ZbYTu9mVC/Qnn9kmGWNxovRKr3CcbQLPvuW3h1/xni38OGxfbXCPzK7SACePDCccS7jdbM9QsQJ/vob8JY6zzjeF9iIGG0O1Qwuh5cVu9HdyN16+2CEHUZlRlwqwvKbTbJcX6u0Gwrm7RNhEN3jpASagcgYy89WTOtts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722411604; c=relaxed/simple;
	bh=BaxCt27OZsHcMWoUAgXJmK2Vffoa7dbbJn3AJYpv87s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WoawVPjXdXd6Msk+Lwku+qq7JWmQBBCLcuMQdFmkKECCP2moyO1WRI/fyuHHUb1dcYuOzGDvNnz4PeyI+9emETMvYPGdUGMTWuJPMuYjLGzYD4NzWJ3E6QJ8nFvx3wOl7WJIWmhfu6JGDwEtoaIQAS4AGiHbbiQ1q4dx9hko90M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=htdFB0CY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722411601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BHg5YCh5BA7hqCWyo1rRiqsfxT+DXFPGHFeuupOZS4M=;
	b=htdFB0CYS2jxY1V9+nNJt+Eo+AdZ2kcsw9CQkeIs0pNQIAhUgIIHqOXOFWH8GHm8dXNuCL
	nVOO2sPWISbybIdaTG9IAjlDckMXYW3L3GrkHWioQb6Hm9oplbgHcqJycdz/tGcJ9z0tfJ
	TxNXYOuMjhZGPmkBeaRGvdBnPC1nqVM=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-oSHBNSprNRq3t4sPoltnqQ-1; Wed, 31 Jul 2024 03:39:57 -0400
X-MC-Unique: oSHBNSprNRq3t4sPoltnqQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ef311ad4bcso54106751fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 00:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722411596; x=1723016396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHg5YCh5BA7hqCWyo1rRiqsfxT+DXFPGHFeuupOZS4M=;
        b=qD6QxBOgic5g7M4nWy3PMFS3URQUIjJHyIIlcQfUCEo3k41kWVha9+Snup98oI5d4M
         oVBNUSPMF6D7s7TB9nMGW1CH/Uts2lWXtZ3nwl4Bn9LOBS6yaToNuj4c25EUMQ/2MPbF
         Qu1rDuPhgcI2tm1NYqs3FF/cuvp2HntX53hPrXxj43NkVwmQ1tKdgRiQ/TQlGRq3tj0N
         obFmQqFx1wQlHQ90RsHOw7ZdHCirdJ4oAvk8/RjjB74v12Hf1oQwBegueRZZKQrSc2UU
         HfUj1tip12WiSY9hmZ/sXd7RQehCE4O5LN/G+DWj432gKY50t6sTuFdyKFaC5W/ZonN/
         l/iA==
X-Forwarded-Encrypted: i=1; AJvYcCUgXPreAggO9iRAq48SVpFe2prRlRPDs62ipPfkmaA+CaWaTXcYDYCQsFJ2YOZGaKMTH8jePuROesZS9otfZiiQWLG0DJm3VmRjUT7l
X-Gm-Message-State: AOJu0YxpHREjs+mT2KTMtMweAlvg/jduF4mt1e7BKbDDr2tQcTrPCm7r
	OAi+8befpBUdwy+grFulJiv+FZUzOxmkwgNt21S7UgM2wEozToA5RmDhfBr3bIdrKDYgWokjaPm
	It9YIOQBtqKBAOU/ZJfyCtzCR+w/AS4zLCMG01JuF/JJ75vZSwhYeetJUpNGvdw==
X-Received: by 2002:a2e:9687:0:b0:2ef:23ec:9357 with SMTP id 38308e7fff4ca-2f12ea9b35bmr88693131fa.0.1722411596256;
        Wed, 31 Jul 2024 00:39:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQrkoDxw+l0VIlIR0+Qgk+955MiL63klXTLU5DFu/vj4R5NQt4RkfZvM7Q37gJtl9EWRqz2w==
X-Received: by 2002:a2e:9687:0:b0:2ef:23ec:9357 with SMTP id 38308e7fff4ca-2f12ea9b35bmr88692741fa.0.1722411595293;
        Wed, 31 Jul 2024 00:39:55 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-79.retail.telecomitalia.it. [82.57.51.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb6403bsm10938855e9.35.2024.07.31.00.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 00:39:54 -0700 (PDT)
Date: Wed, 31 Jul 2024 09:39:50 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: luigi.leonardi@outlook.com
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Marco Pinna <marco.pinn95@gmail.com>
Subject: Re: [PATCH net-next v4 2/2] vsock/virtio: avoid queuing packets when
 intermediate queue is empty
Message-ID: <yrw4u5lwsiovb36i2vhc7qtwcai2us5uoqhb5zpabfqgxp267g@nmqtvj4oqndc>
References: <20240730-pinna-v4-0-5c9179164db5@outlook.com>
 <20240730-pinna-v4-2-5c9179164db5@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240730-pinna-v4-2-5c9179164db5@outlook.com>

On Tue, Jul 30, 2024 at 09:47:32PM GMT, Luigi Leonardi via B4 Relay wrote:
>From: Luigi Leonardi <luigi.leonardi@outlook.com>
>
>When the driver needs to send new packets to the device, it always
>queues the new sk_buffs into an intermediate queue (send_pkt_queue)
>and schedules a worker (send_pkt_work) to then queue them into the
>virtqueue exposed to the device.
>
>This increases the chance of batching, but also introduces a lot of
>latency into the communication. So we can optimize this path by
>adding a fast path to be taken when there is no element in the
>intermediate queue, there is space available in the virtqueue,
>and no other process that is sending packets (tx_lock held).
>
>The following benchmarks were run to check improvements in latency and
>throughput. The test bed is a host with Intel i7-10700KF CPU @ 3.80GHz
>and L1 guest running on QEMU/KVM with vhost process and all vCPUs
>pinned individually to pCPUs.
>
>- Latency
>   Tool: Fio version 3.37-56
>   Mode: pingpong (h-g-h)
>   Test runs: 50
>   Runtime-per-test: 50s
>   Type: SOCK_STREAM
>
>In the following fio benchmark (pingpong mode) the host sends
>a payload to the guest and waits for the same payload back.
>
>fio process pinned both inside the host and the guest system.
>
>Before: Linux 6.9.8
>
>Payload 64B:
>
>	1st perc.	overall		99th perc.
>Before	12.91		16.78		42.24		us
>After	9.77		13.57		39.17		us
>
>Payload 512B:
>
>	1st perc.	overall		99th perc.
>Before	13.35		17.35		41.52		us
>After	10.25		14.11		39.58		us
>
>Payload 4K:
>
>	1st perc.	overall		99th perc.
>Before	14.71		19.87		41.52		us
>After	10.51		14.96		40.81		us
>
>- Throughput
>   Tool: iperf-vsock
>
>The size represents the buffer length (-l) to read/write
>P represents the number of parallel streams
>
>P=1
>	4K	64K	128K
>Before	6.87	29.3	29.5 Gb/s
>After	10.5	39.4	39.9 Gb/s
>
>P=2
>	4K	64K	128K
>Before	10.5	32.8	33.2 Gb/s
>After	17.8	47.7	48.5 Gb/s
>
>P=4
>	4K	64K	128K
>Before	12.7	33.6	34.2 Gb/s
>After	16.9	48.1	50.5 Gb/s

Great improvement! Thanks again for this work!

>
>The performance improvement is related to this optimization,
>I used a ebpf kretprobe on virtio_transport_send_skb to check
>that each packet was sent directly to the virtqueue
>
>Co-developed-by: Marco Pinna <marco.pinn95@gmail.com>
>Signed-off-by: Marco Pinna <marco.pinn95@gmail.com>
>Signed-off-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>---
> net/vmw_vsock/virtio_transport.c | 39 +++++++++++++++++++++++++++++++++++----
> 1 file changed, 35 insertions(+), 4 deletions(-)

All my comments have been resolved. I let iperf run bidirectionally for 
a long time and saw no problems, so:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index f641e906f351..f992f9a216f0 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -208,6 +208,28 @@ virtio_transport_send_pkt_work(struct work_struct *work)
> 		queue_work(virtio_vsock_workqueue, &vsock->rx_work);
> }
>
>+/* Caller need to hold RCU for vsock.
>+ * Returns 0 if the packet is successfully put on the vq.
>+ */
>+static int virtio_transport_send_skb_fast_path(struct virtio_vsock *vsock, struct sk_buff *skb)
>+{
>+	struct virtqueue *vq = vsock->vqs[VSOCK_VQ_TX];
>+	int ret;
>+
>+	/* Inside RCU, can't sleep! */
>+	ret = mutex_trylock(&vsock->tx_lock);
>+	if (unlikely(ret == 0))
>+		return -EBUSY;
>+
>+	ret = virtio_transport_send_skb(skb, vq, vsock);
>+	if (ret == 0)
>+		virtqueue_kick(vq);
>+
>+	mutex_unlock(&vsock->tx_lock);
>+
>+	return ret;
>+}
>+
> static int
> virtio_transport_send_pkt(struct sk_buff *skb)
> {
>@@ -231,11 +253,20 @@ virtio_transport_send_pkt(struct sk_buff *skb)
> 		goto out_rcu;
> 	}
>
>-	if (virtio_vsock_skb_reply(skb))
>-		atomic_inc(&vsock->queued_replies);
>+	/* If send_pkt_queue is empty, we can safely bypass this queue
>+	 * because packet order is maintained and (try) to put the packet
>+	 * on the virtqueue using virtio_transport_send_skb_fast_path.
>+	 * If this fails we simply put the packet on the intermediate
>+	 * queue and schedule the worker.
>+	 */
>+	if (!skb_queue_empty_lockless(&vsock->send_pkt_queue) ||
>+	    virtio_transport_send_skb_fast_path(vsock, skb)) {
>+		if (virtio_vsock_skb_reply(skb))
>+			atomic_inc(&vsock->queued_replies);
>
>-	virtio_vsock_skb_queue_tail(&vsock->send_pkt_queue, skb);
>-	queue_work(virtio_vsock_workqueue, &vsock->send_pkt_work);
>+		virtio_vsock_skb_queue_tail(&vsock->send_pkt_queue, skb);
>+		queue_work(virtio_vsock_workqueue, &vsock->send_pkt_work);
>+	}
>
> out_rcu:
> 	rcu_read_unlock();
>
>-- 
>2.45.2
>
>



Return-Path: <linux-kernel+bounces-237566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E1E923AF8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65A3C1F21A8F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 10:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36834157E84;
	Tue,  2 Jul 2024 10:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/xzxhyg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCEF84DFF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 10:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719914416; cv=none; b=Cx3ktAzCVxPcRAqAkLKX3niTx0MReQ6CG4j/HP/ADjty/zVaSlahDTW82DOZNx/LLVCYBH92k4QO9a97PBW8JfOZkql4epp2obD7Ek9wGlXuV2WSEUCfr17tfCbm/ZYCbZjBlzZspLNG9CuF4WrI0n88KpQ1jmIirhtrif3exRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719914416; c=relaxed/simple;
	bh=FL9d6OezN0DaGSeDwX3ch8BUZ6rZMm7r6XTHPIhIbRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6I8QUi8hY8EDMbHblGaWj+AdGE1dyvNVQcVVBQXBP3FuFjdu5TB5PEGVP6+1DNUc3Iu+XqQ0WAmtaUbXIgJ11N/HcRY7uxpLNXf9GrUCp53wcCKDX/TymdNQmIFCG2xNWGkQspuN8hxIFHa+DjcQVRtSuHwSYoBhId0sIc/x7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J/xzxhyg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719914413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yv6opSv0vaul5KLer+4NSP+gJbph4rk+UabR1uMZGi8=;
	b=J/xzxhygmRM0a9LjZJx3Pqmhs3GbTrAanyehBJ9YikjMFB2nNVW2eMBMqfgO9jv9bh8cu4
	jImfFjSy9li9iIQ7TNQWI4OoAyAJhZFjpeLadUdlS8FBROnaQ0S1y0FdN6JpuhHWv2KGNI
	88LetmkAToEm756X/RlxoT8/uovogFw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-Q5FssW9gOlWL5T-SJHtfVg-1; Tue, 02 Jul 2024 06:00:10 -0400
X-MC-Unique: Q5FssW9gOlWL5T-SJHtfVg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b07ef34bfcso75276236d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 03:00:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719914409; x=1720519209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yv6opSv0vaul5KLer+4NSP+gJbph4rk+UabR1uMZGi8=;
        b=XhjldPjQt5aPnRGaUdEUyYXa3dycA/L3Eo1pMv4FAK5098AIvzYtFOQMiC7x6Zc3sl
         hKkvWHsYzjUSSkAYfDEz208Cq0FB9Vj50K8PWroeaMMU7RDdS6PDmTifaqiyJ8asc/K4
         cevkqJLyZGCSHQC9cpDZzKS/8pZHBbyywupQ4+nrNIQL4k+OA/2eI/f+1UWbjges315v
         Pw9r5T/MkuXh78C1TytylQRY3la6yXHdbObjaeBkD5vYF4RtgjgMNBS7OiV4v1QMvPqG
         eFouzvtW+0rlhY9PuvoG6GgaTGvIBXS7/A1U/QrDVYby/5SSGcXBMW1PN2L0FNKQY7vR
         MKJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsbOUhfb4nCrRU11i5ne83yjv2JLV2whRej+Qm9DCbVn4QsRf2x7pwlCxsqRyiVrpCTgCits5kNHrG5CMAqW4kQtvzFUKbvTaErHvk
X-Gm-Message-State: AOJu0YyRcnF6MCpRwNSW58Geb/X74WONGlxBVbTpAmuJUuJXW8vjT86J
	d36Q2v3ytC+qvHTUOZyPMCjl8XB+xF7XWvitsA87iDdvogRI2DDF9vSp/1Q6gQDMrVycslGMTO/
	B1USSSfknSnARC2e4uMHb4a7ptCEsrZSKf8aACLFrD/rVkgW2s6l+Ul5PsHInjw==
X-Received: by 2002:ad4:5dc9:0:b0:6af:7b2e:1868 with SMTP id 6a1803df08f44-6b5b6eb34demr150374086d6.18.1719914409593;
        Tue, 02 Jul 2024 03:00:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6OFvuiXkTbjAlYyeTGZ8incXsosT5LSwB4zEJQ1+txCs4HqKJX0owYZypPLWDDL7ByIDetg==
X-Received: by 2002:ad4:5dc9:0:b0:6af:7b2e:1868 with SMTP id 6a1803df08f44-6b5b6eb34demr150373726d6.18.1719914409206;
        Tue, 02 Jul 2024 03:00:09 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.133.110])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e5631bcsm42009626d6.32.2024.07.02.03.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 03:00:08 -0700 (PDT)
Date: Tue, 2 Jul 2024 12:00:00 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: luigi.leonardi@outlook.com
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Marco Pinna <marco.pinn95@gmail.com>
Subject: Re: [PATCH PATCH net-next v2 2/2] vsock/virtio: avoid enqueue
 packets when work queue is empty
Message-ID: <omiwday3x75sfre6qp7zp7rzmdwyv27eq2wmzkz6hwt7p6jqvv@n2dx55e2xojf>
References: <20240701-pinna-v2-0-ac396d181f59@outlook.com>
 <20240701-pinna-v2-2-ac396d181f59@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240701-pinna-v2-2-ac396d181f59@outlook.com>

On Mon, Jul 01, 2024 at 04:28:03PM GMT, Luigi Leonardi via B4 Relay wrote:
>From: Marco Pinna <marco.pinn95@gmail.com>
>
>Introduce an optimization in virtio_transport_send_pkt:
>when the work queue (send_pkt_queue) is empty the packet is
>put directly in the virtqueue reducing latency.
>
>In the following benchmark (pingpong mode) the host sends
>a payload to the guest and waits for the same payload back.
>
>All vCPUs pinned individually to pCPUs.
>vhost process pinned to a pCPU
>fio process pinned both inside the host and the guest system.
>
>Host CPU: Intel i7-10700KF CPU @ 3.80GHz
>Tool: Fio version 3.37-56
>Env: Phys host + L1 Guest
>Payload: 512
>Runtime-per-test: 50s
>Mode: pingpong (h-g-h)
>Test runs: 50
>Type: SOCK_STREAM
>
>Before (Linux 6.8.11)
>------
>mean(1st percentile):    380.56 ns
>mean(overall):           780.83 ns
>mean(99th percentile):  8300.24 ns
>
>After
>------
>mean(1st percentile):   370.59 ns
>mean(overall):          720.66 ns
>mean(99th percentile): 7600.27 ns
>
>Same setup, using 4K payload:
>
>Before (Linux 6.8.11)
>------
>mean(1st percentile):    458.84 ns
>mean(overall):          1650.17 ns
>mean(99th percentile): 42240.68 ns
>
>After
>------
>mean(1st percentile):    450.12 ns
>mean(overall):          1460.84 ns
>mean(99th percentile): 37632.45 ns
>
>virtqueue.
>
>Throughput: iperf-vsock
>
>Before (Linux 6.8.11)
>G2H 28.7 Gb/s
>
>After
>G2H 40.8 Gb/s

Cool!

I'd suggest to add the length of buffer (-l param) used, and also
check more lenghts, like at least 4k, 64k, 128k.

>
>The performance improvement is related to this optimization,
>I checked that each packet was put directly on the vq
>avoiding the work queue.

How?

>
>Co-developed-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>Signed-off-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>Signed-off-by: Marco Pinna <marco.pinn95@gmail.com>

I think you might want to change the author of this patch, since it's 
changed a lot from Marco's original one. Obviously if you both agree on 
this.

Thanks,
Stefano

>---
> net/vmw_vsock/virtio_transport.c | 38 ++++++++++++++++++++++++++++++++++++--
> 1 file changed, 36 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index a74083d28120..3815aa8d956b 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -213,6 +213,7 @@ virtio_transport_send_pkt(struct sk_buff *skb)
> {
> 	struct virtio_vsock_hdr *hdr;
> 	struct virtio_vsock *vsock;
>+	bool use_worker = true;
> 	int len = skb->len;
>
> 	hdr = virtio_vsock_hdr(skb);
>@@ -234,8 +235,41 @@ virtio_transport_send_pkt(struct sk_buff *skb)
> 	if (virtio_vsock_skb_reply(skb))
> 		atomic_inc(&vsock->queued_replies);
>
>-	virtio_vsock_skb_queue_tail(&vsock->send_pkt_queue, skb);
>-	queue_work(virtio_vsock_workqueue, &vsock->send_pkt_work);
>+	/* If the workqueue (send_pkt_queue) is empty there is no need to enqueue the packet.
>+	 * Just put it on the virtqueue using virtio_transport_send_skb.
>+	 */
>+	if (skb_queue_empty_lockless(&vsock->send_pkt_queue)) {
>+		bool restart_rx = false;
>+		struct virtqueue *vq;
>+		int ret;
>+
>+		/* Inside RCU, can't sleep! */
>+		ret = mutex_trylock(&vsock->tx_lock);
>+		if (unlikely(ret == 0))
>+			goto out_worker;
>+
>+		/* Driver is being removed, no need to enqueue the packet */
>+		if (!vsock->tx_run)
>+			goto out_rcu;
>+
>+		vq = vsock->vqs[VSOCK_VQ_TX];
>+
>+		if (!virtio_transport_send_skb(skb, vq, vsock, &restart_rx)) {
>+			use_worker = false;
>+			virtqueue_kick(vq);
>+		}
>+
>+		mutex_unlock(&vsock->tx_lock);
>+
>+		if (restart_rx)
>+			queue_work(virtio_vsock_workqueue, &vsock->rx_work);
>+	}
>+
>+out_worker:
>+	if (use_worker) {
>+		virtio_vsock_skb_queue_tail(&vsock->send_pkt_queue, skb);
>+		queue_work(virtio_vsock_workqueue, &vsock->send_pkt_work);
>+	}
>
> out_rcu:
> 	rcu_read_unlock();
>
>-- 2.45.2
>
>



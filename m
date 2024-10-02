Return-Path: <linux-kernel+bounces-347601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B465A98D6B6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DD5FB22798
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B30F1D0BBA;
	Wed,  2 Oct 2024 13:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BzFWewBh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00551CFEDB
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 13:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876514; cv=none; b=O8kKHy2eORrWbD1e+9lgL5fVQ0scnm5T/KLLR4LC9TkasANSXlTd7bEc4bczuMw28JwKs1owpHvZqPUc7eVH2IzrZwnFdjUiOY5jjAoWBKAK0RJKlW/LnR2zUAf82gwmBow1XlaHHeII6i4FKTTcns0vykecW7N9f92qowOavnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876514; c=relaxed/simple;
	bh=5OZTexW1N2cYsiipBckmnTsow8NYUZJeFd0Dc1g6Amk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iwzuoOZ9VGre0MTrp6L8D99ncQaMXmhYsR+Jj6OZ9C3+YLrSIkIJbQKkz9j432xG1rR6u7WwM7IuccCvA2J8SBjkUO7agVNwrtDWSQexdDTcsq8H6HqYzn8aw86MCUoRFNNzIl3BVtRYDroRK2pCS0Ix2LR9o/O/s/H2Xhx8M2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BzFWewBh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727876512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=UWQpm0mcyr3iomDUG9qlXZHim5cqJMh8ETQLI86SlcY=;
	b=BzFWewBhw06eEVoQsjPGo12PZiF9M/NKMiDAYvSZs3tjt4f/wIRVYq/TVp277I4n8WXnIR
	0Sc5h5yssijcDqY7MTgdT6dwhCjJkctn1fRRCH8rFRi1TEnFEAipHWMPWe51JnDcrITnwE
	1cFAGG+vpBultgdDgjy/F6bqVBtpF7o=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-F_qHbdLsPMm6fcAOzU7ohQ-1; Wed, 02 Oct 2024 09:41:50 -0400
X-MC-Unique: F_qHbdLsPMm6fcAOzU7ohQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a8ff95023b6so495689866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 06:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727876509; x=1728481309;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UWQpm0mcyr3iomDUG9qlXZHim5cqJMh8ETQLI86SlcY=;
        b=jzq9hZDZPnwaPdtP8PcO9TiA26EsIYhYCUV8aZ7FTKdc+tPxpgc3vyUzwG/odjdYRJ
         peC48y7+9aWc5+fT4U/H1v4dwvyJbEOYZgYk33/G0S9V56cQpemQJUsNmOivkCmbtSt4
         rAu7Qg6RqeV0oHOWhJwLs+olaD9qp9rdWjuR4W3/dKL2r/8OlYzQIkooWvoz084Jvlub
         2lrpYNVjtTNoa3YtATaOvBuwL4Widxj+/RIsdd6/d7UyO0D4W8Zv9lbw+i9dXWkl/kC9
         kkIFgTAoX5hqFsv3G+9oPd8sXSjaS8oAOwe50RwO3ubLrrakmBxTjW5jMfCNmv1Ee+M3
         yJDw==
X-Gm-Message-State: AOJu0YwSHeFWNO8hxidtCLNGWx42fDoTDlsvbxzWZOIadrRkwZsufkDK
	vym/nsD2uAGBg3brLG88VG28R2v7BtsGd4w4Qw/IJ3/GPLpfHRKpFd+hBHIRpQ5Ksjb2q85iXWN
	PUFXhukV/r+W2N3IB6/fpQyzXm8/LvfIJp+OD5JwdR6sDjmkrzSlp8UWB23gXoe2sNk3tRV9DoT
	uofp9Lh6AjOUtYSOjc53wY2cD/h2zt8AregLyiJ6c=
X-Received: by 2002:a17:907:6d1e:b0:a86:8917:fcd6 with SMTP id a640c23a62f3a-a98f838de30mr290164166b.60.1727876508949;
        Wed, 02 Oct 2024 06:41:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwRbtorkfQnEgLoH126u7jMASiHc1X3K7k60KPoDf4Uvq08XhmDqGPPCIGAMX5Sl2hbplPTQ==
X-Received: by 2002:a17:907:6d1e:b0:a86:8917:fcd6 with SMTP id a640c23a62f3a-a98f838de30mr290159466b.60.1727876508383;
        Wed, 02 Oct 2024 06:41:48 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17d:4f25:dd73:e931:ef00:4c45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c29844a1sm885087666b.172.2024.10.02.06.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 06:41:47 -0700 (PDT)
Date: Wed, 2 Oct 2024 09:41:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Luigi Leonardi <luigi.leonardi@outlook.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marco Pinna <marco.pinn95@gmail.com>,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH] vsock/virtio: use GFP_ATOMIC under RCU read lock
Message-ID: <3fbfb6e871f625f89eb578c7228e127437b1975a.1727876449.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

virtio_transport_send_pkt in now called on transport fast path,
under RCU read lock. In that case, we have a bug: virtio_add_sgs
is called with GFP_KERNEL, and might sleep.

Pass the gfp flags as an argument, and use GFP_ATOMIC on
the fast path.

Link: https://lore.kernel.org/all/hfcr2aget2zojmqpr4uhlzvnep4vgskblx5b6xf2ddosbsrke7@nt34bxgp7j2x
Fixes: efcd71af38be ("vsock/virtio: avoid queuing packets when intermediate queue is empty")
Reported-by: Christian Brauner <brauner@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Cc: Luigi Leonardi <luigi.leonardi@outlook.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Lightly tested. Christian, could you pls confirm this fixes the problem
for you? Stefano, it's a holiday here - could you pls help test!
Thanks!


 net/vmw_vsock/virtio_transport.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index f992f9a216f0..0cd965f24609 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -96,7 +96,7 @@ static u32 virtio_transport_get_local_cid(void)
 
 /* Caller need to hold vsock->tx_lock on vq */
 static int virtio_transport_send_skb(struct sk_buff *skb, struct virtqueue *vq,
-				     struct virtio_vsock *vsock)
+				     struct virtio_vsock *vsock, gfp_t gfp)
 {
 	int ret, in_sg = 0, out_sg = 0;
 	struct scatterlist **sgs;
@@ -140,7 +140,7 @@ static int virtio_transport_send_skb(struct sk_buff *skb, struct virtqueue *vq,
 		}
 	}
 
-	ret = virtqueue_add_sgs(vq, sgs, out_sg, in_sg, skb, GFP_KERNEL);
+	ret = virtqueue_add_sgs(vq, sgs, out_sg, in_sg, skb, gfp);
 	/* Usually this means that there is no more space available in
 	 * the vq
 	 */
@@ -178,7 +178,7 @@ virtio_transport_send_pkt_work(struct work_struct *work)
 
 		reply = virtio_vsock_skb_reply(skb);
 
-		ret = virtio_transport_send_skb(skb, vq, vsock);
+		ret = virtio_transport_send_skb(skb, vq, vsock, GFP_KERNEL);
 		if (ret < 0) {
 			virtio_vsock_skb_queue_head(&vsock->send_pkt_queue, skb);
 			break;
@@ -221,7 +221,7 @@ static int virtio_transport_send_skb_fast_path(struct virtio_vsock *vsock, struc
 	if (unlikely(ret == 0))
 		return -EBUSY;
 
-	ret = virtio_transport_send_skb(skb, vq, vsock);
+	ret = virtio_transport_send_skb(skb, vq, vsock, GFP_ATOMIC);
 	if (ret == 0)
 		virtqueue_kick(vq);
 
-- 
MST



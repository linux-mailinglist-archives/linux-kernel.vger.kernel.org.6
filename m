Return-Path: <linux-kernel+bounces-537123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA849A4883E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C871D3A7891
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF9A26E65C;
	Thu, 27 Feb 2025 18:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="kvPpHehL"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEF926D5B0
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740682245; cv=none; b=YxrDY8Nd/7hXsbimAygi4Jk/LYZgD4asA0k2tGv3/bW/OTGjPIoq/LueCAyvxKHnJM3nPQQ+ZZwdUoW3SV+4MKOMaPSmVQfQ6eTXCpUYGYePkemAytsCMBNlZRJbzMmXJaEFOp9VCBgQIJJJsUBlTB8bBsyKQ7MfmdL1TKarzkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740682245; c=relaxed/simple;
	bh=oZEKZBNyzTFUQoyDm8VLIwp8l+Uss/+aDmlef+L4zKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CMAMdaRa45fsysMata4eOprwVJggkrs6upGF9cQ8trPEmOr3RJROZS9cv8yrw3Yu2mi0C3pd1zvvuL8Qd9fiC+AdODKA1PU2KbJ0O1lX/BGPlHwNhSTcqVM7Ba6c19V6LVqTLy+ufwdWXcpWrWF9tSANqoZPeZsf5d5cCIJXXYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=kvPpHehL; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2211acda7f6so31287705ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 10:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740682242; x=1741287042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tghgwiJFbKnAoocPVNdoGW6mlhutsLEBZ7NkypKcYI=;
        b=kvPpHehLh7QX0nSvKrLbXx4/cHGp+YLaVXCWWPUl+dxWThUR8cnF5fejruKOzNNypl
         BjGRw/eyAuIgj+H1GnV5NQN3nViT1UiCx9BATchjVOjwstU0eloQ6dyR2VeXyU6VvsaZ
         EdGR4zUNTPm8ddCO9zXkwZuYma+4ddcpXGsCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740682242; x=1741287042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/tghgwiJFbKnAoocPVNdoGW6mlhutsLEBZ7NkypKcYI=;
        b=cwHrNWKnr6mU/yZM9yvZJ3odGqvExOmaAXRk3OY9gR3Siaoxz+TbtSdh1lTuzM1y+S
         xmEKGJ+9tPlVNhINTQacG6PXwjlzFxxK0HO9QlSZwRsp4b12Q+8qrhGit1Bkk3I/2a2W
         NB3mOTOH37AW/ExY3TtQjzLXbkckpDXwTOqlUE3qRoDEfEahZ6Yic3Dz/stYy/FSH8er
         h4EBWQ0jvbZYhIfJVTBRZZcFydn+cu3LdfGUlf93YDU4EGq9QbSD/lScrdKPVXKdls26
         T73wVsqKTw8Vh9+F8Vfq0KDz7ueumQMPT4oS36lzzlsK22nu4TBIs7fgwy8V1fRHGnOm
         aozw==
X-Forwarded-Encrypted: i=1; AJvYcCUMQ8paJpeLlHm3X8T1qwwcTalPSdYi7g1Ara9ReFwe1dVA3r1HOUCDZ/zecdVDQE0a+1XNR114PHZhGbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzESpFANoWlQyfkiN6eyP04W3YBzzHNk+0jPsjnCWPfM5WOK6lY
	tTxBmXCjbdQDbvBsLw6CSfNcPIQFdPyP9Bo0JJIlNtTaiG9yaIW5dZ7FvEgANqg=
X-Gm-Gg: ASbGncuZlk9I9hNRNAvHCLllUujEn+uQkQecISqJLUl2wI/O/U2hQ9CBIbY4hcLy1jo
	iKZKFdMhjgI7VORFGwSBVVYoBjNYcT2DkpGEGy3V/45FBUJ1Q0mxWBMN/Y2nypBuPZxCv/wZoXz
	0Dvau0INr0UpVghL1xMmhlvRPpukkC8cZtfnUuU5lWMU8FQlHWdKngadotQ5y2wzE3ujc62+g+1
	m88v1tdCOTeTA8LIeuVeuO3F7tZL0/L3PFYVZyj/bfACR+aiEiXjkgx6ZGv6t1a/L2SMl1uSkv9
	uGpsSd7bi9HMuYdlpJsBGILzGAnqvNsvog==
X-Google-Smtp-Source: AGHT+IGZcb+iC6eZQd5zAGhqgRUruIqyeQKBvaS/JmNMwuWmIIK9UyEnnF0UseSHFo77HzWGMN4JpA==
X-Received: by 2002:a17:902:fccf:b0:220:e63c:5b08 with SMTP id d9443c01a7336-22368f6a1b5mr3409305ad.11.1740682242112;
        Thu, 27 Feb 2025 10:50:42 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22350503eb9sm18275985ad.193.2025.02.27.10.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 10:50:41 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	gerhard@engleder-embedded.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	kuba@kernel.org,
	mst@redhat.com,
	leiyang@redhat.com,
	Joe Damato <jdamato@fastly.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v5 1/4] virtio-net: Refactor napi_enable paths
Date: Thu, 27 Feb 2025 18:50:11 +0000
Message-ID: <20250227185017.206785-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227185017.206785-1-jdamato@fastly.com>
References: <20250227185017.206785-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor virtnet_napi_enable and virtnet_napi_tx_enable to take a struct
receive_queue. Create a helper, virtnet_napi_do_enable, which contains
the logic to enable a NAPI.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 drivers/net/virtio_net.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index ac26a6201c44..133b004c7a9a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2807,7 +2807,8 @@ static void skb_recv_done(struct virtqueue *rvq)
 	virtqueue_napi_schedule(&rq->napi, rvq);
 }
 
-static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
+static void virtnet_napi_do_enable(struct virtqueue *vq,
+				   struct napi_struct *napi)
 {
 	napi_enable(napi);
 
@@ -2820,10 +2821,16 @@ static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
 	local_bh_enable();
 }
 
-static void virtnet_napi_tx_enable(struct virtnet_info *vi,
-				   struct virtqueue *vq,
-				   struct napi_struct *napi)
+static void virtnet_napi_enable(struct receive_queue *rq)
 {
+	virtnet_napi_do_enable(rq->vq, &rq->napi);
+}
+
+static void virtnet_napi_tx_enable(struct send_queue *sq)
+{
+	struct virtnet_info *vi = sq->vq->vdev->priv;
+	struct napi_struct *napi = &sq->napi;
+
 	if (!napi->weight)
 		return;
 
@@ -2835,7 +2842,7 @@ static void virtnet_napi_tx_enable(struct virtnet_info *vi,
 		return;
 	}
 
-	return virtnet_napi_enable(vq, napi);
+	virtnet_napi_do_enable(sq->vq, napi);
 }
 
 static void virtnet_napi_tx_disable(struct napi_struct *napi)
@@ -2856,7 +2863,7 @@ static void refill_work(struct work_struct *work)
 
 		napi_disable(&rq->napi);
 		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
-		virtnet_napi_enable(rq->vq, &rq->napi);
+		virtnet_napi_enable(rq);
 
 		/* In theory, this can happen: if we don't get any buffers in
 		 * we will *never* try to fill again.
@@ -3073,8 +3080,8 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
 	if (err < 0)
 		goto err_xdp_reg_mem_model;
 
-	virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
-	virtnet_napi_tx_enable(vi, vi->sq[qp_index].vq, &vi->sq[qp_index].napi);
+	virtnet_napi_enable(&vi->rq[qp_index]);
+	virtnet_napi_tx_enable(&vi->sq[qp_index]);
 
 	return 0;
 
@@ -3339,7 +3346,7 @@ static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
 		schedule_delayed_work(&vi->refill, 0);
 
 	if (running)
-		virtnet_napi_enable(rq->vq, &rq->napi);
+		virtnet_napi_enable(rq);
 }
 
 static int virtnet_rx_resize(struct virtnet_info *vi,
@@ -3402,7 +3409,7 @@ static void virtnet_tx_resume(struct virtnet_info *vi, struct send_queue *sq)
 	__netif_tx_unlock_bh(txq);
 
 	if (running)
-		virtnet_napi_tx_enable(vi, sq->vq, &sq->napi);
+		virtnet_napi_tx_enable(sq);
 }
 
 static int virtnet_tx_resize(struct virtnet_info *vi, struct send_queue *sq,
@@ -5983,9 +5990,8 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 		if (old_prog)
 			bpf_prog_put(old_prog);
 		if (netif_running(dev)) {
-			virtnet_napi_enable(vi->rq[i].vq, &vi->rq[i].napi);
-			virtnet_napi_tx_enable(vi, vi->sq[i].vq,
-					       &vi->sq[i].napi);
+			virtnet_napi_enable(&vi->rq[i]);
+			virtnet_napi_tx_enable(&vi->sq[i]);
 		}
 	}
 
@@ -6000,9 +6006,8 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 
 	if (netif_running(dev)) {
 		for (i = 0; i < vi->max_queue_pairs; i++) {
-			virtnet_napi_enable(vi->rq[i].vq, &vi->rq[i].napi);
-			virtnet_napi_tx_enable(vi, vi->sq[i].vq,
-					       &vi->sq[i].napi);
+			virtnet_napi_enable(&vi->rq[i]);
+			virtnet_napi_tx_enable(&vi->sq[i]);
 		}
 	}
 	if (prog)
-- 
2.45.2



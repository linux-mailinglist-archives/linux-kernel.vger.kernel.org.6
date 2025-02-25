Return-Path: <linux-kernel+bounces-530386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E63A432C7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 03:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C82917B46D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 02:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E521624C0;
	Tue, 25 Feb 2025 02:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="g3F8DLYb"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9437214F9FF
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 02:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740449117; cv=none; b=fNtGNnEjIMy3ETbSAhwPVJDI0lEu7vVdv5ij7t9vk7Fcn3k+gMD9y+CwFQhVWOgIdexO6QNMoFUnlyv3hNqmzSXOdNyqTcmME7fsQ2ecK3sgNhC4e9ABms6yRoqBA+bLi6P1vnXFjP5QxYwBbqeCrVkzD1cXYVV/ycjnofgddhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740449117; c=relaxed/simple;
	bh=YqThljS+z2rvWEULTOq783byam96cUms4PJNbrKe1eE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJS8/A4O9htKHE4e/vxYMNeuk1PcuCOHmETso7xZERpz3c9qmRwzggVF40t9iOHMtoSvWJk9x/LUFK6KwDgt3xQVibGGj7oz7WgQUU9Vxk7bPonJudjbeDdS9yBGLMBa97T1BHr/g817E6+SGX9ofY/dUFjyAj2v0ZyX0qXARe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=g3F8DLYb; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-219f8263ae0so106732345ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740449115; x=1741053915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Snh9ND17tUPe0ximyCM9OYF2x7OPKQXCCkpOdmoFuU=;
        b=g3F8DLYbapK9/Tko42G3Ii3IQ6ePYPFyWEQ8eqe2m6p8tzKqjidyeRkicHZaN14iCt
         EIdFWjxrw6JJslvyMsJZ8mUvvSWTwZ2d2ixgCui/ju8xNIJ0DJfdyPKA/HuT6I3I/MdA
         g3Q4XRTMSy8mKbPB6sTnjaVD46OCsKV78ytGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740449115; x=1741053915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Snh9ND17tUPe0ximyCM9OYF2x7OPKQXCCkpOdmoFuU=;
        b=QlqzxBJS3Y5uiMD0wbJJgCnwaFIYFmt+McSiwLDSvVZ3Y0NpgWVzTBuhrPGcgPjbrj
         ewx7xLTazekkF1iCp7Y23LkJfRCDY1LlSggRg+980JwF2c/bGxKtb6pNeO1/Bqm9xC+6
         cmA/bRmNZDvX87lx6gIlVH2IVf8+aM3J9TJkSZ/cob7zU/nAR8WFwg9FL6rajQOD6BmN
         jTDu/rUKcM5/PPFAnPQTg6tH/n61TcjwVcWOkWKqAT5/zK+9oB+Uh+RcBLy23PL2tbE8
         I4VqTDXIRxcTXAjkBGeA+Rg4t0UuwNF1p6ueuvoDypOsWsW8beI8Qqj+G7yGGL96xvbr
         yB7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXIlBCkt5MtSN0UKxZOxkxKFIm/g5npHI3uW0RIB/3ZUweTI/f70CwTNPSDjiUmJp+zg+zwlhPeG+9OrFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcswgg2/VmzrvlXgf8k72NeAGOp4wbS2CSlrba055SKq8Cjt2Y
	+08uwJ63fK2DrEXcjTpYQiuBfadPQxVFyWe9Xi+oN8t0dFy/CakZGoj/lhO+2qk=
X-Gm-Gg: ASbGncs1rAt0FdMhN/yBAo60LalPgykMc8ax7zMQYMCZdvQkKvRZdQz0ci7ceslSgSa
	5tWYljVZhAw1IjFzKi4GQwyZiK0huv8Mya10Dm2ameY3aLqZO5MQ1B1nrEsif4BTpIvqkEtE++O
	J43C6NX07UKLf9uf07ZfiZp+bbsA+7kk8D5pyltSJlFoncslY8Zp6wQckodzpGvJyEwDaMysTyG
	MXMrDtkoKUrgMbWp8pgc7P5suFzr8t1t8T/5fb6FigOmoytjehnQJDkQsH8ZIWtsO/Sg69gjfuy
	1V58c0w3jUye7gfIx3W7Uk6MVwLG01OZkQ==
X-Google-Smtp-Source: AGHT+IHCvop7PHEGOGbAsvCw/IG/lFcjljiGLYpCNBBJXObyJXhimwHpVmnD5+SRMh+DiFNZX2lEQg==
X-Received: by 2002:a17:902:ce8c:b0:21f:522b:690f with SMTP id d9443c01a7336-221a11b9bfdmr255955815ad.46.1740449114783;
        Mon, 24 Feb 2025 18:05:14 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a021909sm2926985ad.94.2025.02.24.18.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 18:05:14 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	gerhard@engleder-embedded.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v4 3/4] virtio-net: Map NAPIs to queues
Date: Tue, 25 Feb 2025 02:04:50 +0000
Message-ID: <20250225020455.212895-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225020455.212895-1-jdamato@fastly.com>
References: <20250225020455.212895-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
can be accessed by user apps, taking care to hold RTNL as needed.

$ ethtool -i ens4 | grep driver
driver: virtio_net

$ sudo ethtool -L ens4 combined 4

$ ./tools/net/ynl/pyynl/cli.py \
       --spec Documentation/netlink/specs/netdev.yaml \
       --dump queue-get --json='{"ifindex": 2}'
[{'id': 0, 'ifindex': 2, 'napi-id': 8289, 'type': 'rx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8290, 'type': 'rx'},
 {'id': 2, 'ifindex': 2, 'napi-id': 8291, 'type': 'rx'},
 {'id': 3, 'ifindex': 2, 'napi-id': 8292, 'type': 'rx'},
 {'id': 0, 'ifindex': 2, 'type': 'tx'},
 {'id': 1, 'ifindex': 2, 'type': 'tx'},
 {'id': 2, 'ifindex': 2, 'type': 'tx'},
 {'id': 3, 'ifindex': 2, 'type': 'tx'}]

Note that virtio_net has TX-only NAPIs which do not have NAPI IDs, so
the lack of 'napi-id' in the above output is expected.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/virtio_net.c | 73 ++++++++++++++++++++++++++++------------
 1 file changed, 52 insertions(+), 21 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e578885c1093..13bb4a563073 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2807,6 +2807,20 @@ static void skb_recv_done(struct virtqueue *rvq)
 	virtqueue_napi_schedule(&rq->napi, rvq);
 }
 
+static void virtnet_queue_set_napi(struct net_device *dev,
+				   struct napi_struct *napi,
+				   enum netdev_queue_type q_type, int qidx,
+				   bool need_rtnl)
+{
+	if (need_rtnl)
+		rtnl_lock();
+
+	netif_queue_set_napi(dev, qidx, q_type, napi);
+
+	if (need_rtnl)
+		rtnl_unlock();
+}
+
 static void virtnet_napi_do_enable(struct virtqueue *vq,
 				   struct napi_struct *napi)
 {
@@ -2821,15 +2835,21 @@ static void virtnet_napi_do_enable(struct virtqueue *vq,
 	local_bh_enable();
 }
 
-static void virtnet_napi_enable(struct receive_queue *rq)
+static void virtnet_napi_enable(struct receive_queue *rq, bool need_rtnl)
 {
+	struct virtnet_info *vi = rq->vq->vdev->priv;
+	int qidx = vq2rxq(rq->vq);
+
 	virtnet_napi_do_enable(rq->vq, &rq->napi);
+	virtnet_queue_set_napi(vi->dev, &rq->napi,
+			       NETDEV_QUEUE_TYPE_RX, qidx, need_rtnl);
 }
 
-static void virtnet_napi_tx_enable(struct send_queue *sq)
+static void virtnet_napi_tx_enable(struct send_queue *sq, bool need_rtnl)
 {
 	struct virtnet_info *vi = sq->vq->vdev->priv;
 	struct napi_struct *napi = &sq->napi;
+	int qidx = vq2txq(sq->vq);
 
 	if (!napi->weight)
 		return;
@@ -2843,20 +2863,31 @@ static void virtnet_napi_tx_enable(struct send_queue *sq)
 	}
 
 	virtnet_napi_do_enable(sq->vq, napi);
+	virtnet_queue_set_napi(vi->dev, napi, NETDEV_QUEUE_TYPE_TX, qidx,
+			       need_rtnl);
 }
 
-static void virtnet_napi_tx_disable(struct send_queue *sq)
+static void virtnet_napi_tx_disable(struct send_queue *sq, bool need_rtnl)
 {
+	struct virtnet_info *vi = sq->vq->vdev->priv;
 	struct napi_struct *napi = &sq->napi;
+	int qidx = vq2txq(sq->vq);
 
-	if (napi->weight)
+	if (napi->weight) {
+		virtnet_queue_set_napi(vi->dev, NULL, NETDEV_QUEUE_TYPE_TX,
+				       qidx, need_rtnl);
 		napi_disable(napi);
+	}
 }
 
-static void virtnet_napi_disable(struct receive_queue *rq)
+static void virtnet_napi_disable(struct receive_queue *rq, bool need_rtnl)
 {
+	struct virtnet_info *vi = rq->vq->vdev->priv;
 	struct napi_struct *napi = &rq->napi;
+	int qidx = vq2rxq(rq->vq);
 
+	virtnet_queue_set_napi(vi->dev, NULL, NETDEV_QUEUE_TYPE_TX, qidx,
+			       need_rtnl);
 	napi_disable(napi);
 }
 
@@ -2870,9 +2901,9 @@ static void refill_work(struct work_struct *work)
 	for (i = 0; i < vi->curr_queue_pairs; i++) {
 		struct receive_queue *rq = &vi->rq[i];
 
-		virtnet_napi_disable(rq);
+		virtnet_napi_disable(rq, true);
 		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
-		virtnet_napi_enable(rq);
+		virtnet_napi_enable(rq, true);
 
 		/* In theory, this can happen: if we don't get any buffers in
 		 * we will *never* try to fill again.
@@ -3069,8 +3100,8 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 
 static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
 {
-	virtnet_napi_tx_disable(&vi->sq[qp_index]);
-	virtnet_napi_disable(&vi->rq[qp_index]);
+	virtnet_napi_tx_disable(&vi->sq[qp_index], false);
+	virtnet_napi_disable(&vi->rq[qp_index], false);
 	xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
 }
 
@@ -3089,8 +3120,8 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
 	if (err < 0)
 		goto err_xdp_reg_mem_model;
 
-	virtnet_napi_enable(&vi->rq[qp_index]);
-	virtnet_napi_tx_enable(&vi->sq[qp_index]);
+	virtnet_napi_enable(&vi->rq[qp_index], false);
+	virtnet_napi_tx_enable(&vi->sq[qp_index], false);
 
 	return 0;
 
@@ -3342,7 +3373,7 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
 	bool running = netif_running(vi->dev);
 
 	if (running) {
-		virtnet_napi_disable(rq);
+		virtnet_napi_disable(rq, true);
 		virtnet_cancel_dim(vi, &rq->dim);
 	}
 }
@@ -3355,7 +3386,7 @@ static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
 		schedule_delayed_work(&vi->refill, 0);
 
 	if (running)
-		virtnet_napi_enable(rq);
+		virtnet_napi_enable(rq, true);
 }
 
 static int virtnet_rx_resize(struct virtnet_info *vi,
@@ -3384,7 +3415,7 @@ static void virtnet_tx_pause(struct virtnet_info *vi, struct send_queue *sq)
 	qindex = sq - vi->sq;
 
 	if (running)
-		virtnet_napi_tx_disable(sq);
+		virtnet_napi_tx_disable(sq, true);
 
 	txq = netdev_get_tx_queue(vi->dev, qindex);
 
@@ -3418,7 +3449,7 @@ static void virtnet_tx_resume(struct virtnet_info *vi, struct send_queue *sq)
 	__netif_tx_unlock_bh(txq);
 
 	if (running)
-		virtnet_napi_tx_enable(sq);
+		virtnet_napi_tx_enable(sq, true);
 }
 
 static int virtnet_tx_resize(struct virtnet_info *vi, struct send_queue *sq,
@@ -5961,8 +5992,8 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 	/* Make sure NAPI is not using any XDP TX queues for RX. */
 	if (netif_running(dev)) {
 		for (i = 0; i < vi->max_queue_pairs; i++) {
-			virtnet_napi_disable(&vi->rq[i]);
-			virtnet_napi_tx_disable(&vi->sq[i]);
+			virtnet_napi_disable(&vi->rq[i], false);
+			virtnet_napi_tx_disable(&vi->sq[i], false);
 		}
 	}
 
@@ -5999,8 +6030,8 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 		if (old_prog)
 			bpf_prog_put(old_prog);
 		if (netif_running(dev)) {
-			virtnet_napi_enable(&vi->rq[i]);
-			virtnet_napi_tx_enable(&vi->sq[i]);
+			virtnet_napi_enable(&vi->rq[i], false);
+			virtnet_napi_tx_enable(&vi->sq[i], false);
 		}
 	}
 
@@ -6015,8 +6046,8 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 
 	if (netif_running(dev)) {
 		for (i = 0; i < vi->max_queue_pairs; i++) {
-			virtnet_napi_enable(&vi->rq[i]);
-			virtnet_napi_tx_enable(&vi->sq[i]);
+			virtnet_napi_enable(&vi->rq[i], false);
+			virtnet_napi_tx_enable(&vi->sq[i], false);
 		}
 	}
 	if (prog)
-- 
2.45.2



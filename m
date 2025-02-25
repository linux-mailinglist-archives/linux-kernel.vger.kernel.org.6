Return-Path: <linux-kernel+bounces-530384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0D4A432C4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 03:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C70AD179A8E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 02:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921751487F8;
	Tue, 25 Feb 2025 02:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="bw9CQfWv"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B23946C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 02:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740449113; cv=none; b=REKHjJIy19RAUuzkCwGM8pAzwAleXBfeeVl/IWoix54sdJLKUUmHkih/tn6teGgZpd9WL7xgCN2/2vv4U36onwx/OqxWhzlkGA96SIqxKEJXixDdaMczlAOo9ZfJMqzs2tsUOh7CAxx1M3WzW9JhR382Xwita10r9ebtCpAwNdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740449113; c=relaxed/simple;
	bh=O1/087om4F0aQVS80+qWqW7HTYSlWzFCPffyQOL+39g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ns2t9I8Y5jsUdW7x8Rof+bINB22TwTcNqLHD/yUYTzAINgCmEzk4lRXdqfJa11IkCdZDObjT/qzIlwH0du5FgmJZm2oMFN9HR871Gxq12Zks8xpr1FGGIMm3dwRMo3TVWYSMzHb1H8EaEuh+L/JFqkn7V1uqOUC/6/jHvnQXHMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=bw9CQfWv; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2210d92292eso294695ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740449112; x=1741053912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrU/GLtdg0ptzOcVYQYyLKXFl5BzTzzKA9LeyaGSuBE=;
        b=bw9CQfWvofOQK65sxBFINjA6c9lVhiKwonOMhooD1Cs6jODoHyx2Xe+8/E4s/4iZp+
         +qN7xbmetHDf9+oQpkHVR4n/uMPlhy8gtotmcrJdaFVK6aoameK+kkHdaAX1x1JNQLZH
         /9AkoZkTtsf9RnAP9v07Iapx+4qOZ6ndiHg/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740449112; x=1741053912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrU/GLtdg0ptzOcVYQYyLKXFl5BzTzzKA9LeyaGSuBE=;
        b=kyY+t68NnJicv24msEejAxhwAfb4tPTWBy/2ujYowV2m1fAJpZ154rLlQAF+373ioV
         uh/ifzpOdSPBe6sfW/R065LrlygY2f4Y4Jl/KemokA6DX4pquW9e/OAgpIKlBMpfPENh
         qn9883ryBpqormJsZj+JfGaRtzEs5frrHoeERxFoX9NmjwxA3FLRO0hOEZJ3iqVkB7JH
         56/+izwChVfdhVWFX591YdMNEAlruLO2Y9UfEB67yG693WiXHZDl4w63IEZ7bxjUdKTX
         y5L0XfZ1VHyIGXFCeWNqPYpozl5/0OzKT2p4mY7kQhZbvjAP86BuLu+8ki3/SuP9xxBO
         ToaA==
X-Forwarded-Encrypted: i=1; AJvYcCVPI/W6p74wR1/rA6jQG07L/XCJ4g191oy5XxvdNzw4hnqAGiZpZpFaUTy3lRo50Wl9oKMYgD9lbFez55k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHEyKkqGlkQZgQ2LQnZWadBa/MthP6DWKcWMfM6REARPzKFDSK
	OkyhiBDtsjheUkAR82S+Tl/9HDvKdRpV46SE7Y3exLit3hCiVy384vSRCtUfIIU=
X-Gm-Gg: ASbGncsE/fFmcn8hdUT949uV5hSjvqtlUO945JMyExccyOj7TJkNcL9WN0bvAQ8IXK6
	lmyLhytpMHQ/HMC5pwHTdtPLygwaw1uQu1DL3NueN2njcH7wvShQtho7KWIe+qZCWTzzy0tzYXw
	LG8NExdbW+bQrz5zRlS4h1LJ139+B8l731uHvf/xkM5Aov+COCodLP7VM++1u9rZcZMmqcchzEy
	444N9ThzosoneFQ1FMiiP6tK6jDP31QskAyNa+nF8KDEw8o4maR0pYswqrodZrDsZtD5MKeLWGj
	KFI4rmtZrQ+9HonIF7qs4E/T5kEB/lowJQ==
X-Google-Smtp-Source: AGHT+IHY8lwN0JrUuvEAmWjnsdHLEwnDxmgRP+MXId726hvqxCaVfFz4XoQuZ4YlYhDmAgxBLFzirg==
X-Received: by 2002:a17:902:ced0:b0:220:e792:8456 with SMTP id d9443c01a7336-2219ff311c3mr267682865ad.11.1740449111274;
        Mon, 24 Feb 2025 18:05:11 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a021909sm2926985ad.94.2025.02.24.18.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 18:05:10 -0800 (PST)
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
Subject: [PATCH net-next v4 1/4] virtio-net: Refactor napi_enable paths
Date: Tue, 25 Feb 2025 02:04:48 +0000
Message-ID: <20250225020455.212895-2-jdamato@fastly.com>
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

Refactor virtnet_napi_enable and virtnet_napi_tx_enable to take a struct
receive_queue. Create a helper, virtnet_napi_do_enable, which contains
the logic to enable a NAPI.

Signed-off-by: Joe Damato <jdamato@fastly.com>
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



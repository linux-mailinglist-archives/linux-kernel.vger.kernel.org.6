Return-Path: <linux-kernel+bounces-550228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 947B8A55CCE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 02:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C2F61702DA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFD41632D9;
	Fri,  7 Mar 2025 01:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ag6mFf2R"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9331459EA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 01:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741309944; cv=none; b=V5a9PGcZqyKuiisemRMC3uEyxAzjsu8RnZKuSJN4l+nvKpmyIP7qij3O1BcCfwmZm6kazNMhUDn3Kqik0fYPia0c4mTaaLP9+uB/pWoDfo06CzM61ficWhM3tDLNvhnoe7NodlFI/1TpxxJOHF+WzXvsN4KtGxUuvpLV9NnBn3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741309944; c=relaxed/simple;
	bh=oZEKZBNyzTFUQoyDm8VLIwp8l+Uss/+aDmlef+L4zKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YLAUgl6ao8A4wn/eFx772TUuoQ9iOfIVV3CvaFRdvM2fgg9H/akyIL8SZTjEFsgxUTn7cxVuIyV9nTMQTPhkwR1CpUiqst0r18trx+tv699233d7wlJ3cd76CcIwbbMUIyTAhLuGwinb6FcifhgnvBUCfFlEaYVPd3hA670BjnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ag6mFf2R; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2235908a30aso34239775ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 17:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1741309941; x=1741914741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tghgwiJFbKnAoocPVNdoGW6mlhutsLEBZ7NkypKcYI=;
        b=ag6mFf2RTzECLKnv6pE/D/+sfHo9wqGeoSYN91a4sDIbM06KgK9I2mbK0ORy+TpZdT
         0koqwhoSFg5f2HYodPLa6n4TFVUVHu+ra++PZ3mTpy8/tb3RNYBs9UmHOHVcsOHzLw9+
         mkzCyO+YoZSuVS+jvMLv2IjghkQQca1xFSzok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741309941; x=1741914741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/tghgwiJFbKnAoocPVNdoGW6mlhutsLEBZ7NkypKcYI=;
        b=ZC+b8uHkYDebVqLcc2Zwiw3zXqz5Kdn7QiSw3KoIxCN3/Jd4hWVremWZb0Rmna0nek
         UG4m0SFi5HpXJuGQ/y0d85P85BRqoDozsGzGk4YvtI1t/ebkkjtd66dPN/6AZNIJ7eA8
         2m8wpYpF8ITAnOUxXLdH9nAmA/CmCqAygVdci8ee5ts3oftueYD5+gtDNKmtOZwKDPl8
         8mKIagXndOJ/0pllOX8VdckLGUPKvVXw/VXTxF3uN76PaW8ChtxGrCpYjIKbvrQNISbH
         +LwA+s6M7SlGOBElJux04gSMFHRTDxUNS6aw5cv604Q4EJgfJnhz3QdHe3QWs0Yxzqyf
         PAlA==
X-Forwarded-Encrypted: i=1; AJvYcCXgWgrzCj/fSh41jy5UfcZybFO02ZB7M8wNgp8EHR1uQEODtVMQ9+OdsJuz8ZORDgKR3aLd8PxE6qwdblQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ8Ke4VLVy4CarG1Ut3qu7tiT807IImff7omjKFy34sSIqo6UN
	YkwTq/e5BHLbiZGOSO+F46Z2swGvqOoLrApUxd7XQ656PI8LN03XTPk++mYi0wo=
X-Gm-Gg: ASbGncsUB6Fv9XemiwFRGMJr8EuwvGpUk9n9BHKdvSPuzWOZJqOjSLJERuxjnjXnfBH
	Cp+H2XglJ4LvFEYrkuEsd7BcUXliJi1kjgHl6dsh/kBriM4KwkT1DxxWTv+cvCBbVTxLuJIcjoc
	oXT0roDFLEGSveP+xpZCgwbS0GLrCE9iIv8/U90BvNMZKSkeAtmRgQw/V/XM959GbqypA1SHBCW
	qBIBrybKvLy6ei9xba5kiyL8agAqPwOWQ0Obq34/Ip7RFzflJCIwKC5gkvY0eSEQM+FASHrbL9f
	vDh4x3ux5bCR+SEDzpUHe61q6MZ8i7jS17FXge71yBu7h9AFOtc0
X-Google-Smtp-Source: AGHT+IGKhqwe2JpllICnS8YtflWUc4MgBo06dsvavfBwoHtdqy1vxCbTRe3YRbrAw0m3enhzIMPo2g==
X-Received: by 2002:a17:902:ce0a:b0:224:584:6f05 with SMTP id d9443c01a7336-22428bdecdemr26052505ad.41.1741309941695;
        Thu, 06 Mar 2025 17:12:21 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410abc816sm18749685ad.258.2025.03.06.17.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 17:12:21 -0800 (PST)
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
Subject: [PATCH net-next v6 1/4] virtio-net: Refactor napi_enable paths
Date: Fri,  7 Mar 2025 01:12:09 +0000
Message-ID: <20250307011215.266806-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307011215.266806-1-jdamato@fastly.com>
References: <20250307011215.266806-1-jdamato@fastly.com>
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



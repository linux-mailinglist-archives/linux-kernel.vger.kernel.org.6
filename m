Return-Path: <linux-kernel+bounces-550229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE76A55CD2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 02:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 438BC172EA4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8A61547C3;
	Fri,  7 Mar 2025 01:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="uXXbd7Ux"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193DD1474DA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 01:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741309946; cv=none; b=JlKZJj+E2jAYu3frvE7mZBXjzXG3/ba+YeonOeTPUL6f/YW8OKUxswYHEprTSkLcWGCr1uNgnb9qUospk1n8QdR8nnfh5ODpWabvIcrffbbWsuxsBxpIccceZWWJSj0YLPixWnf31oAvRSf0z4K2yC77y5ZK9TQONuypPyTO0pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741309946; c=relaxed/simple;
	bh=yAvpgVVKv0qwVx/BcaJPPk6io7i8uqUMf303YSpg6Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YFmuWWP2udkit743F6dAdF6jKgy/7wt9ejy4BlT/aQrbbt9DTWOcWYTGNowRCw9MsQa2aufSV2KE2zBGWR2kH31aRGmzDZvLdmiYjQYFsNTmVEkA2lheiAyijW27ZMOvQTwgxM9m+zMNg8nKvZE5bOwfPr56POyr8fB0uW0CSY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=uXXbd7Ux; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-224100e9a5cso24308505ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 17:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1741309943; x=1741914743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvwTo73+IFY77/cYaIXsS2w5RqkSonWsueWTF0kXS/4=;
        b=uXXbd7Uxc0itPUE7M83fbS3D+/GaNswUO4C3yB7UDqCf7Kmx09SJyAuDcJ2GXpFSPc
         hbN6f6CENPJEKIGrWjmZ9szhZ3NoFPqsawtTA5wbQ4qV5O279iQWCj1vHC1ssFqiWt/6
         SgjfyUhqjNhQE8sqBNMzVc4vXIu2lAlO0XJhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741309943; x=1741914743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kvwTo73+IFY77/cYaIXsS2w5RqkSonWsueWTF0kXS/4=;
        b=fnt8Bq/ixjReMmjIaq5rHTgwxwYj8bUKqbXY9tV0y84Y9cusF1gUOI8yrITj7PX5QQ
         DHtRfmu6Y77yw9PvpizE3fNYFGmoajSgwnQbSzcxyhC5q8NV8OOa517inQfVD2w8fyqz
         q4AO0pBC/6fW6Yq35G7mbA3LrNm6LcdMChAoRPMU0AWS7iG8e20qZqgXMg49M/spqGuC
         jFFLdKGGBvtg4Detif2ZYDIMB4oWZJgdl50Fbbgp9Hq51wrGe2NWlQ/c23axB2ZN9srm
         b25sT2fCn5ijl5HC0NKd+kLcHdwnATicPoH7vlXVP0Kc6RE881MxlbBFh/GIaBC3LzPr
         URGg==
X-Forwarded-Encrypted: i=1; AJvYcCW93PSSqjCoN2dJBwCOv447Bm0SGbzuRh1hH37I7sIMoqiuKsboHrhxOpPujYsmAhgfT47zWDjn01a94ZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLtURHutRrsSxfuzNsWdQDaWZN+OID+C5OOeA3wTAzM0Reuzh8
	zRbNeEu4IZq/kn2qFl0wyDzvaQ+fWpgRjtXB5I7VRdOay6IdYQOj24kgwKjsN+E=
X-Gm-Gg: ASbGncvLOnnkFKiOcpNmkShzK7R3q5b3W2L/yXS+4v6Y0gnRsUOx1I+Ny/cPAHU1klY
	W+2K9/JI5N3ytB6CVh+kYkf84EXqKx9Z1TPEZHU6gz9aQaPWw2GJ7gq+5suMlZU2APvY0RwM3cE
	yJBriaZaSumiKHF6L0mIDPusRsW5h8Xhz6z9uJsSwh8LOqitfeaYBMVKZH9ofxRK0XpM69auIm+
	EmGign9ZZrPqisBqxIjyFmXW6u0Q6kkvytiz1S4ePmzODR1FxSxo8nudNtVqsqQY+xCrjJHhwm2
	0dFxgB3Ot2HsYue4MBgDqjV+Tws6aAhE4boFxa6bBMJ2PBhJmCjw
X-Google-Smtp-Source: AGHT+IGoI+aPJvj7yY+4BLZ2+twYf/oT3+TiRwVbnShK0v7noTjCRMsILjhJFgqCavzprURMi0Wvnw==
X-Received: by 2002:a17:902:e810:b0:223:432b:593d with SMTP id d9443c01a7336-22428c07537mr25062635ad.42.1741309943342;
        Thu, 06 Mar 2025 17:12:23 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410abc816sm18749685ad.258.2025.03.06.17.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 17:12:22 -0800 (PST)
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
Subject: [PATCH net-next v6 2/4] virtio-net: Refactor napi_disable paths
Date: Fri,  7 Mar 2025 01:12:10 +0000
Message-ID: <20250307011215.266806-3-jdamato@fastly.com>
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

Create virtnet_napi_disable helper and refactor virtnet_napi_tx_disable
to take a struct send_queue.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 drivers/net/virtio_net.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 133b004c7a9a..e578885c1093 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2845,12 +2845,21 @@ static void virtnet_napi_tx_enable(struct send_queue *sq)
 	virtnet_napi_do_enable(sq->vq, napi);
 }
 
-static void virtnet_napi_tx_disable(struct napi_struct *napi)
+static void virtnet_napi_tx_disable(struct send_queue *sq)
 {
+	struct napi_struct *napi = &sq->napi;
+
 	if (napi->weight)
 		napi_disable(napi);
 }
 
+static void virtnet_napi_disable(struct receive_queue *rq)
+{
+	struct napi_struct *napi = &rq->napi;
+
+	napi_disable(napi);
+}
+
 static void refill_work(struct work_struct *work)
 {
 	struct virtnet_info *vi =
@@ -2861,7 +2870,7 @@ static void refill_work(struct work_struct *work)
 	for (i = 0; i < vi->curr_queue_pairs; i++) {
 		struct receive_queue *rq = &vi->rq[i];
 
-		napi_disable(&rq->napi);
+		virtnet_napi_disable(rq);
 		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
 		virtnet_napi_enable(rq);
 
@@ -3060,8 +3069,8 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 
 static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
 {
-	virtnet_napi_tx_disable(&vi->sq[qp_index].napi);
-	napi_disable(&vi->rq[qp_index].napi);
+	virtnet_napi_tx_disable(&vi->sq[qp_index]);
+	virtnet_napi_disable(&vi->rq[qp_index]);
 	xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
 }
 
@@ -3333,7 +3342,7 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
 	bool running = netif_running(vi->dev);
 
 	if (running) {
-		napi_disable(&rq->napi);
+		virtnet_napi_disable(rq);
 		virtnet_cancel_dim(vi, &rq->dim);
 	}
 }
@@ -3375,7 +3384,7 @@ static void virtnet_tx_pause(struct virtnet_info *vi, struct send_queue *sq)
 	qindex = sq - vi->sq;
 
 	if (running)
-		virtnet_napi_tx_disable(&sq->napi);
+		virtnet_napi_tx_disable(sq);
 
 	txq = netdev_get_tx_queue(vi->dev, qindex);
 
@@ -5952,8 +5961,8 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 	/* Make sure NAPI is not using any XDP TX queues for RX. */
 	if (netif_running(dev)) {
 		for (i = 0; i < vi->max_queue_pairs; i++) {
-			napi_disable(&vi->rq[i].napi);
-			virtnet_napi_tx_disable(&vi->sq[i].napi);
+			virtnet_napi_disable(&vi->rq[i]);
+			virtnet_napi_tx_disable(&vi->sq[i]);
 		}
 	}
 
-- 
2.45.2



Return-Path: <linux-kernel+bounces-530385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B07A432CB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 03:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53545189FB36
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 02:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE23E152196;
	Tue, 25 Feb 2025 02:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="lzzRgMx2"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82A8143722
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 02:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740449115; cv=none; b=AMRLn9fRwDLbRLYrRVKspDkMxcbZWxw1T4+nYdTPOU3htV6JJUyUkah532X1OirgpBW9pU1xQfhm+/q6HYeh8UqNoX4MdnFfLId8goe5f/x7v5cO/EzSxAjj3kc9d/fBKKclE5gA1Sk86SQS6nopNsS4KcH7/h6ihMwzcchs/qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740449115; c=relaxed/simple;
	bh=GWWDChFIQB2blY/jPfW79k1D8RtfKUSWn6cGyll0Ezg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZglE4a/BhsxdGWS+54ZwxsIgHO6tEpTS+rQ72xX2/BO0z9l3sZk6rt9GuBBoI31vEpDvtng2vGKXaePZBjEQrUl3kzLx7OMsRfTLeFVBZn7VxXdct/RLYqHNCa9heFIihxcXkRJNNascsq/hu97bJROqCL2ejHSEfxz7SAwrpHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=lzzRgMx2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220d132f16dso78200575ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740449113; x=1741053913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Nd9NSzHqA5rIn7zkDOos29JmkSo0ut7TBrki2afWb8=;
        b=lzzRgMx2BFKdmOcweC7W/S0csh5sm9x4GhmyI7wYkwvEqVTpdV06yF/g2rJl2xsCWl
         p7E1sY1PWkIuMjligG3jprAja7tLwyL6g2jcxMBLNBf5/rvQ158XAjg0x6Nsw9QxQ8Yy
         pteH76c+73WVUsOKL8OhHpbs7iw/FKum4ReYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740449113; x=1741053913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Nd9NSzHqA5rIn7zkDOos29JmkSo0ut7TBrki2afWb8=;
        b=NKGizGQOEcI3VWXlDv/G+yBGanlZwRkAJr0+qOXmjfUxgsvusq5xmfzZcwEQ6AL8LI
         Xy0vu0iMH8QPLNgODTxLMRW7llTTl53TVqlRg837kk4z5X2rifPfVlfrAH0J0HKCuzCQ
         yxjnJ9D02jXzFeBxU21fOonrsTrhm6XVCVNrj4C4yqfxfBHZi2RorNZ8LB52DKlDW52A
         M67a936YbIvDpS3ISk7HrCgQuYu1RWJbtCgb3Uj39RnrTcxtU+bdjm8EVY5ddl/HSAjq
         jW9xtDFG/9jiqVW5Tmmr5DvbzXQr+ioXLS/QDqDvCNw7mo1tfiJ3CiYln7/LFCDGFxJf
         LbxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVL+9DRS4niBpqE5FH7i7VWbAdHusFarNgcyDaH6Te1JMo2cN6AG1wyMD6lAjZsl6Db61TJj09x9zesyuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywri84Cn11XhE20s5hQPMwnWc5RB7g0iY/4Q2Gvxf+UGeMzM1Bt
	WuW/JnZOukGzte24eWrBdQOMGYqnP4Ymh6G6WlhdUoTuXAv5hUNsnl2JAgFXHkC0GUMnblIByJY
	jDEI=
X-Gm-Gg: ASbGncuksejXHFyXsi+/wXBq0U8feh8tC8tvDECPO+GaQlnOq2Lb42L/BzG6fFhm5UL
	tei6DeFBAnHoO3P+ETyDwwmToMokigfn+OgAWDpFnZ1pXbhKFEHt2h9SGFsb6tSemv1gC37vltQ
	Udw76E4ZykCpYyz1XdtxfwMA2oJ7KfV0HsSZnl2RWm9GH7YAJSMMqa7TDj2W9TSAWnh6Tx2JRUt
	AZYVm+kdYJoahkS5tWwaCs5KFRGq3H57PU14PRLHFuqcasE61VDK2aYBhDqW+v+HsH+3WHSNh2c
	YIyoA8/nWvVZzeWljclVyZkZB2iuq7RLOw==
X-Google-Smtp-Source: AGHT+IFv9Txtr44zQZYD0oHJYIFMzObgMUa7hD66RW/Qe+HC1Hn+TXbMiigLaJAVRrR47Zqg0gTjmg==
X-Received: by 2002:a17:902:d4cf:b0:21d:cd54:c7ef with SMTP id d9443c01a7336-2219ff31902mr229422035ad.9.1740449113075;
        Mon, 24 Feb 2025 18:05:13 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a021909sm2926985ad.94.2025.02.24.18.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 18:05:12 -0800 (PST)
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
Subject: [PATCH net-next v4 2/4] virtio-net: Refactor napi_disable paths
Date: Tue, 25 Feb 2025 02:04:49 +0000
Message-ID: <20250225020455.212895-3-jdamato@fastly.com>
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

Create virtnet_napi_disable helper and refactor virtnet_napi_tx_disable
to take a struct send_queue.

Signed-off-by: Joe Damato <jdamato@fastly.com>
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



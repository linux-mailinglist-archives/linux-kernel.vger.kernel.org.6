Return-Path: <linux-kernel+bounces-537124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAF3A48842
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18C22188EA0A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3183426D5DB;
	Thu, 27 Feb 2025 18:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Ij+Yj6ef"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F92526E165
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740682246; cv=none; b=T6dK6Wgeywit3LnfilUkba/UL/sKb5QrQb9uoeHGTxjxJ3nLnjoI4Rd1LN3+ImRPKyat4dxlBy97IdcB10vZzDOzU+vZ9U4wsAjOC0y/KHw4jzT9xr7wgw+0YQxuWfCqTbNYTqdJ2sITha0Tz/2jeQw80rJnD0MFsrVEaGu43B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740682246; c=relaxed/simple;
	bh=yAvpgVVKv0qwVx/BcaJPPk6io7i8uqUMf303YSpg6Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mGzhMxRLNi8g0dCoTsx0dhQtEX42B6DamoCSthySMS2HP4XBXBxXe870FCnTMIJL01Gb3vQUwSFrPxz/G+qB9bcbBD8mZsAmAi9zZ+Qhc58Hd0tncRJb9dL00zaeRznLxVc5cy6w/nzux6x8SoXsGKIl0YiI6d3ZyRMrtrr89N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Ij+Yj6ef; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22355618fd9so19775915ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 10:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740682244; x=1741287044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvwTo73+IFY77/cYaIXsS2w5RqkSonWsueWTF0kXS/4=;
        b=Ij+Yj6efCnaOTDAfh4AWIN1PMa8RpbRuEs92Zkmm0FOrPQSvSwoLXPD9Cg0v3WZG6j
         VM1bYerrqXtV4yYyazwsMl78/j4/Bs8f7CYVv5OH7jCqtWywgINzkFmcHzXU8fjoER7c
         Mx9QQd2pmoAHnAKnxrdOpsqvkLJGiHo/ih/30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740682244; x=1741287044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kvwTo73+IFY77/cYaIXsS2w5RqkSonWsueWTF0kXS/4=;
        b=udGBwbcpRIk0YwegTT/lc8JBkfXnMI7cBuOIz6DffrCMobfObhUN6AGD3q+D3LHkIF
         kSZ6yVxi/nI81VShoFpHmCr/TsET4qdUDFwP1i4NHZ+EYiJZbkVkwbJehwyW4Xf/YWPM
         e3nIuvP6cx+EavjQBTCMie2c7abRma4GmcNgWtbDS6OSRIoZcx1JDHY3WI2thdmd2kHQ
         3SWatUDSwQzQG0Oc5NFk8k9lWpsU5/BSRN+t4JQ13LbicvDv1wEPWPTiP1ySoqVsWQDh
         Cod8+YktJv9He5ufrn2HT7mjTBmZ1FhqllrJ+ShG52ivX0ltr2WQIIeF9DbKNBuRzUOX
         cfYw==
X-Forwarded-Encrypted: i=1; AJvYcCUd0WfeMinnJXhkZa6IlM6tVsc3KWGn67Adk0zq+NQseyrFmec69v6gak4mqXeuYwVo/QBNsKAzfpXTcac=@vger.kernel.org
X-Gm-Message-State: AOJu0YzviXVaLiu9LyAMqcO8dPyLobzAC7/jdlUg/cmTf7Gaw7g4Ytq9
	NfdnFluntOimwGHvGLtE1Bzdm8L0f+OXDIpgQ34Op9pAbpkW4usA67ZD7rlCvJM=
X-Gm-Gg: ASbGncv2JtQmPjbxniHRv1HlHjKFbQDSwcbpfodk+SayBiTpwvt12AJvfmNwB17OLPg
	yS0PhXIjrBqhKDkuT4ux0tqT8bQvXKWY56enkijaWpOj4Mt6X+1MX+/GUfQD4GhLgvsvNTa3Tp4
	8nayOS6UdRGXOmWmFoiAU/m0P/YJZrkdaJjq1rAayr9bdE4ZeV4auTDrsqrm2yPAjqxVVhqOsxE
	KZKegssiEXVkJYHJkVdVEUGknJiGyPrE+MOoUDYEkYU4pZSUnGZm1T7g3pcFpss46FGJUpBdQdG
	n4CjjJ8cmf11zgfwGuBzTRz+KBVBl3e8og==
X-Google-Smtp-Source: AGHT+IG/mIbJ7+AwlpU7kzFyTXUYqGruYlMGaC/kiigMhtr+Deogz9sMy/ksGfgjZazdRJbKbvfNCw==
X-Received: by 2002:a17:902:cec1:b0:223:5945:ffd5 with SMTP id d9443c01a7336-2236925558dmr3548155ad.32.1740682243894;
        Thu, 27 Feb 2025 10:50:43 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22350503eb9sm18275985ad.193.2025.02.27.10.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 10:50:43 -0800 (PST)
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
Subject: [PATCH net-next v5 2/4] virtio-net: Refactor napi_disable paths
Date: Thu, 27 Feb 2025 18:50:12 +0000
Message-ID: <20250227185017.206785-3-jdamato@fastly.com>
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



Return-Path: <linux-kernel+bounces-333082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2C197C337
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 05:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C49322835FD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 03:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776B1168C7;
	Thu, 19 Sep 2024 03:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DbjzV8Rf"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8605812E48
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 03:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726717945; cv=none; b=uaKJCPLUU+U+PL+9GZUMOyWv5TvY9A1QKOgIu5+NYGjiWESS3c6SuxIz/VPO5ELz7V08U07BAlTo8OeRd/l+mnSx7uF8d6PRQU/Qyw0209PBmnzv/0BRQXqC8yJAr4vJrmvWuQG4mW3ZoEmFvLu2W/VJf5MQUnV/WiQo58P87lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726717945; c=relaxed/simple;
	bh=pBJ/W7zBpUfR9NB2GMjokItUqXP95jfukF66km3Za5I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QC1cEugrXvsnVf/TtymFyM3XUSubqPMQlEK1ZWvTmL5dyFaKQHWiXzkhu7SR5EaOh53f1lizFnbSGk+dOXziKYdbSa6gdXsiXZgedNUFczAZPZb7a0/k+71mA1O38CDeMGAkg5l+hpLmfPrdeBKo2eIhVm3O2qZjqzMToyPb32Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DbjzV8Rf; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71971d20a95so290914b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 20:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1726717944; x=1727322744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jsPYIMNNv1DkZ6gPtEDdkFMUvpsPPh5XX8rDZ9tVrqw=;
        b=DbjzV8RfzKGWESIJvCkN8nnfQ5yL0RGFu7cukKdrpDV7wsOHokDj8P7pJBELsN9KFu
         VaTQaSub67EP9qUJTAulPPANTTyX+28eMCJYe62PsuKlnTV4Zd2CJyvHTLMIPsMdMX1z
         K7mFCIKrWLX2PNI0XKd2c1Te7qfdIG0JCPkt8Tynhx4s3Ua5WOokuOlEqSrgyhyscggo
         T/8Fx2VZdTGEatl4Lx/PYz6acR/Lm2ADXjVcb/fUcO1TmkcOFPlWRPeaTvEZBpdCtYwt
         Bu/XMb3CPdHTrHX0536UeHKaEMF89Gr2TDYuWMiHPvCELPZUwD3MTcbGgkdWHGhjRzij
         WGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726717944; x=1727322744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jsPYIMNNv1DkZ6gPtEDdkFMUvpsPPh5XX8rDZ9tVrqw=;
        b=Kbe0BDfSTTVJqsDjoZ8BVzG3IRb1y+LIJs9ziRI0pHqeJ8gRly47Nly4U6t4Yqsfmo
         OWolR3wZ86j1vvMXJ23xJIfsGjJANYEeD4G0Bo36Ty14KNqGw+rhyWxEXqRukpJKtUaC
         Hzt/7zPEqK7nCFdDXSTsjczERAaovLpC3Vhgc8jh0t2Rv6jkLkhEezfdKLGzkvahRlDo
         QvA1xGM++CPYmUFQzFK3nq4WzZV/qoS1tEQH3nyrj0twGN2S+ehuMb0msADgSlSON4fI
         PNSrnr8rFbQNp06uHGEj020+oZ0j8xojwp2U2i2mGboVRRE0Pg25Y0BRrdKEH8Ury3KL
         reGw==
X-Forwarded-Encrypted: i=1; AJvYcCWiyeFd2Il5zgiLVtRuuMXiYNEMbcakoREO9pF4NVnUrpYTY5oN4IxEwK9+D1h6ZxsVhL+dUKY/61wdEhM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Z6xvbjpUcFAOCe4G1/8c8SdY3OCPj4EK8G/wWeqRDh/DTECI
	zW+kb8D/Hp63UbScWAqu9V3ofYxf57ILqxfLUkO0SgvI+PgD3pkq+GxOAmkJ+Iw600+yzP6yutD
	0dys=
X-Google-Smtp-Source: AGHT+IEqBFPHlxkk+SH91tCLfNpFsIjMwSxd3QepCi+7QxXZSuHfi8gouMDIv2rsWh1zhf5xVvIJrQ==
X-Received: by 2002:a05:6a00:4fc4:b0:714:1a74:9953 with SMTP id d2e1a72fcca58-71936a6267cmr30996907b3a.16.1726717943745;
        Wed, 18 Sep 2024 20:52:23 -0700 (PDT)
Received: from LRW1FYT73J.bytedance.net ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b9ab85sm7661091b3a.173.2024.09.18.20.52.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Sep 2024 20:52:23 -0700 (PDT)
From: Wenbo Li <liwenbo.martin@bytedance.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wenbo Li <liwenbo.martin@bytedance.com>,
	Jiahui Cen <cenjiahui@bytedance.com>,
	Ying Fang <fangying.tommy@bytedance.com>
Subject: [RESEND PATCH v3] virtio_net: Fix mismatched buf address when unmapping for small packets
Date: Thu, 19 Sep 2024 11:52:14 +0800
Message-Id: <20240919035214.41805-1-liwenbo.martin@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the virtio-net driver will perform a pre-dma-mapping for
small or mergeable RX buffer. But for small packets, a mismatched address
without VIRTNET_RX_PAD and xdp_headroom is used for unmapping.

That will result in unsynchronized buffers when SWIOTLB is enabled, for
example, when running as a TDX guest.

This patch unifies the address passed to the virtio core into the address
of the virtnet header and fixes the mismatched buffer address.

Changes from v2: unify the buf that passed to the virtio core in small
and merge mode.
Changes from v1: Use ctx to get xdp_headroom.

Fixes: 295525e29a5b ("virtio_net: merge dma operations when filling mergeable buffers")
Signed-off-by: Wenbo Li <liwenbo.martin@bytedance.com>
Signed-off-by: Jiahui Cen <cenjiahui@bytedance.com>
Signed-off-by: Ying Fang <fangying.tommy@bytedance.com>
---
 drivers/net/virtio_net.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 6f4781ec2b36..9446666c84aa 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1804,9 +1804,15 @@ static struct sk_buff *receive_small(struct net_device *dev,
 				     struct virtnet_rq_stats *stats)
 {
 	unsigned int xdp_headroom = (unsigned long)ctx;
-	struct page *page = virt_to_head_page(buf);
+	struct page *page;
 	struct sk_buff *skb;
 
+	// We passed the address of virtnet header to virtio-core,
+	// so truncate the padding.
+	buf -= VIRTNET_RX_PAD + xdp_headroom;
+
+	page = virt_to_head_page(buf);
+
 	len -= vi->hdr_len;
 	u64_stats_add(&stats->bytes, len);
 
@@ -2422,8 +2428,9 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
 	if (unlikely(!buf))
 		return -ENOMEM;
 
-	virtnet_rq_init_one_sg(rq, buf + VIRTNET_RX_PAD + xdp_headroom,
-			       vi->hdr_len + GOOD_PACKET_LEN);
+	buf += VIRTNET_RX_PAD + xdp_headroom;
+
+	virtnet_rq_init_one_sg(rq, buf, vi->hdr_len + GOOD_PACKET_LEN);
 
 	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
 	if (err < 0) {
-- 
2.20.1



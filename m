Return-Path: <linux-kernel+bounces-314281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C688A96B107
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B3A21F21D95
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 06:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C5784A5C;
	Wed,  4 Sep 2024 06:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ke9mNOLq"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6FB84A36
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 06:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725430223; cv=none; b=TZj7Nwtu1TxE4t3spTBo10zlolNi1BZK6nLrD40r7wPY589XjCa9FyAswCH9YY1G5xzCjgb4zETZotYBFmoD+Y6gHoRHoP+SnB9B0xn2zYGs0n03PDk+S5cJHcne1LFAoWEbeOqASDp+0tOvaCfmoxuPZHwFxEHsjY/0sRYJnEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725430223; c=relaxed/simple;
	bh=014gXkD8ygbNVGMJO+0Zp0ga5DirG6KNtyYbEwIUiCU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qk2a5+FjSdEjgg7/qVznNupBkbb7sWyXiRQtMvOHZ9+pYkqMcSNiVvdMsbWQAT1FeoakLKSgvnWLhC+7KCsKC5T6sUF0G6vd3BsASrQzxeN+ENY3ELCZ1hBH5py5uBcpIcX9J3CdktS+SPzc9ehOfPIVgMWmyIG0PDkbZR9QMHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ke9mNOLq; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7d4f2e1d11cso363447a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 23:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1725430220; x=1726035020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V36tSWxAHLAIOwnkr8bXXchZBGFhkcs/NfyGu0nHDJw=;
        b=ke9mNOLqSBayh2F08yupz1d86VGCKQMD5YVzwom1GDULdcM8IHz5evIBuNJPTS8Ki1
         wzUnOReGrUkxbHv99ETqrCyPU9olFZMgUQd5MjwT4lTWTYrXBgei+/RQRcIPpAGiuUPb
         cp0betABczsUDRPDsM5USlkqa3G5Yc2fihMpJH7MNh6Re088Fz3bvwdIKczNTzQhYZpa
         UtIwfEvMWbApKLC2/4zbqwZrcdomgucMmypV2924arjmmsPlWuUvoY5p05EvlLg1KYCo
         KF7cCmfjPtTivB5jGzMN4jIdYVkiegqMTTF2BbvkhnRrSKwqs6Yn3wMa4CuWjcB6vz0S
         MdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725430220; x=1726035020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V36tSWxAHLAIOwnkr8bXXchZBGFhkcs/NfyGu0nHDJw=;
        b=SK7/V/CQSJFcIduuWq8Nx6ucUL7em0kQFriArwTUgVUOnaPpbZi12xkWLPbrC6Dd3T
         hiM6q7dVzGT54jlE/amuTXEW9yzWHT6LUTlFnMIsdLQi3x22UaQt3TZQJnMxsF+J+Eqv
         xU9XFiZ9h1BkSwm76QzSPsemHKMF9lVnSIYsJUiOgohsIqJRMRWqfJGAnAETCothSz7V
         VBHaECKAcMIxNEzjROJfjqripb4IFHLxL/xeHThXXq3W4glD/Q7e4aFnKhmuWeDvDLjF
         G1x1oe3CGFxNSY3yaePCwqBgbGtrVnyhop79Fp5+Q2zai5ScHztSNUzaT6lE534JYKKL
         KqxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxrceSSAFEfU8zwnXyrgDJEuXPjVnGW+i830QqIPMFTQdBCrO1YtK1+yyAal3floZYO/P2ZYqCUoExm9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNQV1UbejGKKaZ3K7gJzKWQSEAShXI+dXbRftC30IinCBeeU+k
	HpUNTlRYBk9ESZu2A8kQ9Li+knFQUWr0kINbigdEYJjTiyQGsYBMmN+BWt0Z/sw=
X-Google-Smtp-Source: AGHT+IHMau4o8Ew3FW+eey6qgIUz41XJZGyUqCz0/A7x+A6o0sgpiBWZX5EMygQKk21MSGSMGAcELQ==
X-Received: by 2002:a17:903:18d:b0:206:b5b8:25ef with SMTP id d9443c01a7336-206b5b82940mr13284525ad.15.1725430220327;
        Tue, 03 Sep 2024 23:10:20 -0700 (PDT)
Received: from LRW1FYT73J.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae912357sm6989385ad.14.2024.09.03.23.10.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Sep 2024 23:10:19 -0700 (PDT)
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
Subject: [PATCH v2] virtio_net: Fix mismatched buf address when unmapping for small packets
Date: Wed,  4 Sep 2024 14:10:09 +0800
Message-Id: <20240904061009.90785-1-liwenbo.martin@bytedance.com>
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

This patch handles small and mergeable packets separately and fixes
the mismatched buffer address.

Changes from v1: Use ctx to get xdp_headroom.

Fixes: 295525e29a5b ("virtio_net: merge dma operations when filling mergeable buffers")
Signed-off-by: Wenbo Li <liwenbo.martin@bytedance.com>
Signed-off-by: Jiahui Cen <cenjiahui@bytedance.com>
Signed-off-by: Ying Fang <fangying.tommy@bytedance.com>
---
 drivers/net/virtio_net.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c6af18948..cbc3c0ae4 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -891,6 +891,23 @@ static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
 	return buf;
 }
 
+static void *virtnet_rq_get_buf_small(struct receive_queue *rq,
+				      u32 *len,
+				      void **ctx,
+				      unsigned int header_offset)
+{
+	void *buf;
+	unsigned int xdp_headroom;
+
+	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
+	if (buf) {
+		xdp_headroom = (unsigned long)*ctx;
+		virtnet_rq_unmap(rq, buf + VIRTNET_RX_PAD + xdp_headroom, *len);
+	}
+
+	return buf;
+}
+
 static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
 {
 	struct virtnet_rq_dma *dma;
@@ -2692,13 +2709,23 @@ static int virtnet_receive_packets(struct virtnet_info *vi,
 	int packets = 0;
 	void *buf;
 
-	if (!vi->big_packets || vi->mergeable_rx_bufs) {
+	if (vi->mergeable_rx_bufs) {
 		void *ctx;
 		while (packets < budget &&
 		       (buf = virtnet_rq_get_buf(rq, &len, &ctx))) {
 			receive_buf(vi, rq, buf, len, ctx, xdp_xmit, stats);
 			packets++;
 		}
+	} else if (!vi->big_packets) {
+		void *ctx;
+		unsigned int xdp_headroom = virtnet_get_headroom(vi);
+		unsigned int header_offset = VIRTNET_RX_PAD + xdp_headroom;
+
+		while (packets < budget &&
+		       (buf = virtnet_rq_get_buf_small(rq, &len, &ctx, header_offset))) {
+			receive_buf(vi, rq, buf, len, ctx, xdp_xmit, stats);
+			packets++;
+		}
 	} else {
 		while (packets < budget &&
 		       (buf = virtqueue_get_buf(rq->vq, &len)) != NULL) {
-- 
2.20.1



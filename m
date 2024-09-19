Return-Path: <linux-kernel+bounces-333228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC9B97C5A8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 10:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B84D6B2101B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C394F198E84;
	Thu, 19 Sep 2024 08:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OIrIXV4z"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B33229A5
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 08:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726733642; cv=none; b=pntc4MENhCm/RrZJwGhaO3fa3PP6HRns2drXcJviVtTQlb8HWaS3NSF2Hx8jeh3R/FgC/A5BlsVOwlazJ5p3kQ4P37vBbaFMYljXeVMitN/HPss+X1ukYZBKbYxXzsKpfzm208HPMk54u3pf6OLvhsJz9tlg50g5BSkL8ZcRZaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726733642; c=relaxed/simple;
	bh=obPizuvNjntWiaeSWyWHSSnIyiXDkzWD/VemLy1LTHk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZWsD4fQKugW3BUS0H1nrwyaKEoxPnUEI+SkQ95j/cbVtW1almb/cPihtZ2mDH1/G6So6gs91t2LwgXtPxgbLgE1ezyRJIeUjlD/SzRN6CDXVzacBgLoky6ThPah8QTVu4A8VaAX8qFtRARAFS9B/of/5CfBU08Scng93uNN8pDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OIrIXV4z; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e045525719so305331b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 01:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1726733638; x=1727338438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/dmixfEFYfutwhSv2UHLcy5Vr3qDSZZFKkZiBqJtRic=;
        b=OIrIXV4z1pYVVJfNXsRgEqaOv33YKzaD37SnwiyYNvpQu9f7ggjsieTbQgVLsm81fI
         iveriqlFhuiAmWrw2ttjkX/v90T5D4nW0o+2GO1w7oVCaU1y30J6Bmkpq6Qc9O9xDhx2
         V/eseJ1k3evNzwcUAimfUoU/Hx8WnLMdz2hTDGTFXR1w3ziGf4BWZDdmVFrF7TuWf3Qz
         eoss3GfC/6wuvK6hCiOybWddZjQkk7esuE0AICPIfNiIN95Xe2ycLkeHN5xbWd+nWmIV
         H9uTAkzcgESRinZCS8jsa2VSlCUPGD29UO+yHdOU3Vpo+YoWyz3el0HvBL4NwqW2HU1K
         E04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726733638; x=1727338438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/dmixfEFYfutwhSv2UHLcy5Vr3qDSZZFKkZiBqJtRic=;
        b=cCcLOLuxa7ZCB7uSa41hkCONVMkZEsJ9r8FvsMGml92CvkOQrwlq7w5AV5BWl29f+U
         5Y+dih6huOtuVnV5qpDo+FLzyWP1CQw8zEhX5C34j4PO5nrWxM19n8rH2be9RGNJqxFx
         KQq9IfiPJUyuxFlFDLz4W9patUA4uva6TBCEDZ8aSE1xOA3dBHuj98pjYzZBngcl5wHC
         0bchJo5RP6RpR9KZHJy2zSzEAK72Y4EaYwoW82KuONy6bOacTIxU88uG200hpsgh+WeL
         x6cEyEQcXzjhKPsrS20rywYpcFmgguMgSp0Ul7cczH5pMhDb01vXWYyqFdU+9ke72K73
         ea8A==
X-Forwarded-Encrypted: i=1; AJvYcCW1/qY/+60vlArcxX8llKG8DOC0Z7+09qxRpCXSPydDHm4iWCmlgLLJlo0MxUaJXOCHWFChckrpYGxiPWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YywyibR2zdnMqmX1YK7ipAtyuaTdGp076Vv49HGnccdNu5wmNA2
	mtCWfkUtdvNxpmcfVeHyKHsKgqOanW+zyJm6d7VnK5oflElJ89s0iHSC05s9fbs=
X-Google-Smtp-Source: AGHT+IHrrnzRxSY4w/ZqyCFd4PYtjfrKVDqkWH8qTW+OmjOTvxBIUj5ZqO1lp38Ok8sq4NeMIAkHWQ==
X-Received: by 2002:a05:6808:2292:b0:3e2:5b9a:d43 with SMTP id 5614622812f47-3e25b9a0f53mr7459331b6e.34.1726733638252;
        Thu, 19 Sep 2024 01:13:58 -0700 (PDT)
Received: from LRW1FYT73J.bytedance.net ([2408:8642:893:ac37:a1db:b4af:9e2e:2d1c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db498fb8f4sm7544306a12.32.2024.09.19.01.13.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Sep 2024 01:13:57 -0700 (PDT)
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
Date: Thu, 19 Sep 2024 16:13:51 +0800
Message-Id: <20240919081351.51772-1-liwenbo.martin@bytedance.com>
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

This patch unifies the address passed to the virtio core as the address of
the virtnet header and fixes the mismatched buffer address.

Changes from v2: unify the buf that passed to the virtio core in small
and merge mode.
Changes from v1: Use ctx to get xdp_headroom.

Fixes: 295525e29a5b ("virtio_net: merge dma operations when filling mergeable buffers")
Signed-off-by: Wenbo Li <liwenbo.martin@bytedance.com>
Signed-off-by: Jiahui Cen <cenjiahui@bytedance.com>
Signed-off-by: Ying Fang <fangying.tommy@bytedance.com>
---
 drivers/net/virtio_net.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 6f4781ec2b36..f8131f92a392 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1807,6 +1807,11 @@ static struct sk_buff *receive_small(struct net_device *dev,
 	struct page *page = virt_to_head_page(buf);
 	struct sk_buff *skb;
 
+	/* We passed the address of virtnet header to virtio-core,
+	 * so truncate the padding.
+	 */
+	buf -= VIRTNET_RX_PAD + xdp_headroom;
+
 	len -= vi->hdr_len;
 	u64_stats_add(&stats->bytes, len);
 
@@ -2422,8 +2427,9 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
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



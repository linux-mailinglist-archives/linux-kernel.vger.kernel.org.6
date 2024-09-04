Return-Path: <linux-kernel+bounces-314605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 880D396B5A8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08BFB1F21A5A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2ACF19D887;
	Wed,  4 Sep 2024 08:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Y8GuF0NS"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880F918733B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 08:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725440324; cv=none; b=PgSt7eeIPEETUnkGoTxkfC5lB7KYJlYwCXHrrrLFQ639ks256Ye7MWU3eY/SZc3nfLBOhX/T2eH+qlCbl+TRYVgzDFTCkoocV2dqpT2NQPwLa3YDlkVn/IGptLyPG0LNzy7JAVOLjoK5iQleYT50D26qv6fVGV6UtcuZfSE09+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725440324; c=relaxed/simple;
	bh=XfKP8unbbPBjVgS+QzaKOcNAm22jNvgAVhT2scaF0BM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lrs4wErvH/91lb6nd+aRh6NzXOnsnAukKfKyzSKxZ8c+yWu+F2M6Yy9aAxhXHrnU/Zlw0UBRxctPKeg5qh4XrspWd2sgaeLGMcfdKFLO+uLwzsxt5OEaT/AoaMNXgXYMdt7HhFkiR+CFSIya74jMzkoBXhKAJxFi5LdevGcItkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Y8GuF0NS; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7cd8afc9ff3so380581a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 01:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725440322; x=1726045122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+t37x9TLIsk4O4gRZ6eWG8xD3/DMOHyXQXhYkfg2vsc=;
        b=Y8GuF0NSsdSHACS7Q/mkauqMuX05ZgV25nN1B4HNzRu2+GFybYITqEWLZ1Z1TTkaUl
         vOb0DcMtfeq5PUM01rNcPpLw1TehXRzJ16l5L7wx2Bq9mZ6XUZF1hs+NlElKNlhwFxNh
         xb6rlPeQqo8N1/fMydbdGSH6qoVvwyHx4UCzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725440322; x=1726045122;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+t37x9TLIsk4O4gRZ6eWG8xD3/DMOHyXQXhYkfg2vsc=;
        b=sHTJoeUqtWE+N8tIP1xa7FE5gPCDXXmrrQFRc1AEpsd9Hvjn05jpxHulAMW6ZivlzG
         NPIy69wIWceXzro09y4GHExx0Wb/qa7lRbwfgHZs0PpmgcPgk8n4W4s9d5DNlcBCoogb
         rnxrmNExtSsO/nMb0lqONuC//tOAhJrUkNzky1kq7hG5NIoWfiV4+cOSBb5O9lRFe2rm
         /OrRHeQgHWKX3g1RNa8GQ5AfBkUwHNSRzDZohLIqui+91Zw6KXkltVVkdz1wPfeg9WBU
         GDiW7x/fXkwXiSxIPK2zJRABRcLIMkYzPiffh2h6CVFRUDc+oqFLZJ5/SYfY1uZ4/xNM
         4yyw==
X-Forwarded-Encrypted: i=1; AJvYcCV0RXOrhdyecgIoNBAwiD/t5rFRQK7PX34af42wV9Jio+DiQCVp7T/tnsplW3kVhTa4Qvae2XjARyNlwoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjX9H8REbNnqLmQkAXPUrO5JjIgJkhDJgOV1yWkxl8Ii+zPZ3m
	OSPXR/HB2+MX3oXsmetm9KasHWEZ5MGgsY/TPiZYpvfz8NyfPvT0gMSaXk/V5Q==
X-Google-Smtp-Source: AGHT+IGhKGqxiqy44JngHWHRLAJzqxdbahk1woNkmt3+2VUIw1+4M6eU68DZSnvt573TLX01XI6S5w==
X-Received: by 2002:a17:90a:bc9:b0:2da:50e6:5ab with SMTP id 98e67ed59e1d1-2da8f3028b9mr2329713a91.18.1725440321498;
        Wed, 04 Sep 2024 01:58:41 -0700 (PDT)
Received: from shivania.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2da6fb086cfsm2813801a91.24.2024.09.04.01.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 01:58:41 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Breno Leitao <leitao@debian.org>,
	Heng Qi <hengqi@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v6.6] virtio_net: Fix napi_skb_cache_put warning
Date: Wed,  4 Sep 2024 01:58:29 -0700
Message-Id: <20240904085829.14684-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

[ Upstream commit f8321fa75102246d7415a6af441872f6637c93ab ]

After the commit bdacf3e34945 ("net: Use nested-BH locking for
napi_alloc_cache.") was merged, the following warning began to appear:

	WARNING: CPU: 5 PID: 1 at net/core/skbuff.c:1451 napi_skb_cache_put+0x82/0x4b0

	  __warn+0x12f/0x340
	  napi_skb_cache_put+0x82/0x4b0
	  napi_skb_cache_put+0x82/0x4b0
	  report_bug+0x165/0x370
	  handle_bug+0x3d/0x80
	  exc_invalid_op+0x1a/0x50
	  asm_exc_invalid_op+0x1a/0x20
	  __free_old_xmit+0x1c8/0x510
	  napi_skb_cache_put+0x82/0x4b0
	  __free_old_xmit+0x1c8/0x510
	  __free_old_xmit+0x1c8/0x510
	  __pfx___free_old_xmit+0x10/0x10

The issue arises because virtio is assuming it's running in NAPI context
even when it's not, such as in the netpoll case.

To resolve this, modify virtnet_poll_tx() to only set NAPI when budget
is available. Same for virtnet_poll_cleantx(), which always assumed that
it was in a NAPI context.

Fixes: df133f3f9625 ("virtio_net: bulk free tx skbs")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>
Link: https://patch.msgid.link/20240712115325.54175-1-leitao@debian.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Shivani: Modified to apply on v6.6.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 drivers/net/virtio_net.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 51ade909c84f..bc01f2dafa94 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2140,7 +2140,7 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 	return packets;
 }
 
-static void virtnet_poll_cleantx(struct receive_queue *rq)
+static void virtnet_poll_cleantx(struct receive_queue *rq, int budget)
 {
 	struct virtnet_info *vi = rq->vq->vdev->priv;
 	unsigned int index = vq2rxq(rq->vq);
@@ -2158,7 +2158,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 
 		do {
 			virtqueue_disable_cb(sq->vq);
-			free_old_xmit_skbs(sq, true);
+			free_old_xmit_skbs(sq, !!budget);
 		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
 
 		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
@@ -2177,7 +2177,7 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 	unsigned int received;
 	unsigned int xdp_xmit = 0;
 
-	virtnet_poll_cleantx(rq);
+	virtnet_poll_cleantx(rq, budget);
 
 	received = virtnet_receive(rq, budget, &xdp_xmit);
 
@@ -2280,7 +2280,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	txq = netdev_get_tx_queue(vi->dev, index);
 	__netif_tx_lock(txq, raw_smp_processor_id());
 	virtqueue_disable_cb(sq->vq);
-	free_old_xmit_skbs(sq, true);
+	free_old_xmit_skbs(sq, !!budget);
 
 	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
 		netif_tx_wake_queue(txq);
-- 
2.39.4



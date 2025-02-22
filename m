Return-Path: <linux-kernel+bounces-527444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 280EFA40B5E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 20:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD463BEBCE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 19:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A696A218845;
	Sat, 22 Feb 2025 19:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3vhCkRvu"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70E52153EB
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 19:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740251734; cv=none; b=sjTnivhLaqa93B9gNo5/QF5OEZJf0pIL6qLzHBodYSpj40NEtS/HPSVpfAYeG984/5hHQ2aE5i9l55KssHu+Pp2dYQ8DYgvbtdjxnrUk0vPQ0X1uDPua2stLEc+Lj5ySfHndJOQynK8CxUj5lVTxQLBWLW8U13vIlsRYbhcD8D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740251734; c=relaxed/simple;
	bh=S4WIdcIymEnObCKW8hFtjmYPsUwr3C9vEUbedDCBePY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sM5cUzdlCxKHsLDDa7sq/Kqh0vMZiUSLWxIxDuz9kDzWxH5IUdNPtjSW9AUoNNaN8y1Any3Msg+wqOu5mZuAy9WfIzWKTuQH7DGGg7w659FYjVXYFh5cgtshFQ1hJKi3LeXuVZnwE2LJom4Bj/BDJe9LOJ1uCcdLqSwwEpq+7r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3vhCkRvu; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc1c7c8396so6788446a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 11:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740251732; x=1740856532; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=biWDWCpFQb1l1Z/yT0zgxnecEVUj+cBj8CVtcecqD6k=;
        b=3vhCkRvu9ODATAHeq172b5LYMXdSmSzPyrHBeonxWdVs0zR0wvYWtpdn05MjErEjrb
         U3iAxI/fqMS0Be3gPk7aMcwgRQ28JmeDnf5JcZ1Z4XhneCdTcRMpLU/JmMje/2zkS7nW
         D+nUiFYiXJcrjMNc/J/Ufda9gynSdCBMArhnTQ/WHB3+xig5pnxtfMav9t+yfZogPHpx
         vw3Y96nrkYccbLoEEN5Lr8e2w62doHQngW2LXparGfL/ETIOkQRqEanKZl8JtPyR2VUw
         1YTeASmCrCtpHzxPCZmkf+ZSoKGiLD2RtnktUqM1aZ//mFZ1TEq4q5kb9S8A+wGr/Lt+
         MwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740251732; x=1740856532;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=biWDWCpFQb1l1Z/yT0zgxnecEVUj+cBj8CVtcecqD6k=;
        b=gY8u3oQN3dvyOojTLZ/0GV7ZyAt1X2ULhElPi7rXdKx25mBpeJXPJJEFUz9XAckXws
         q3jx9UURQSA8u4564Kve3oAKD5SSymncrS+tccSSjQN/ReIxKF6RL9JTTbbBLbRaEPXH
         TUbOIXIZsjzAlXPskihTQc8wXPnhm5ldMlj5uel2FX80q4EG4/htn45mikk6QtQDw8QA
         W6edap2vISw8snpr7a/8WitfiCQ710lchX628ACKnT4G/Ri+upAsGULbNP0kdDv1M2xu
         c1r/gY0CVniIfuIqBbPLK3m8mZ2AVz64dgX8KbB5/7ftHoYeceUgMGxTfnIdA9TWQ4kY
         JCQg==
X-Forwarded-Encrypted: i=1; AJvYcCUGKcujiRRGlYb+OqUL2pds0CA5JaR6IvfKLQ5uH52FhpKVfUZbkCxGnHSPSESO6/vRC4jpprSMUXP5VII=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Skixx12M7bU1XZtW8fNHZRuVvimfMdJOldI6ZQxwZq2+SsTK
	oiJoc7YGTpjBFmSgag/ftHe5qfmhFM20WnDE/YnD2FGqTqEVSAseSAcRk07gULF9q7EbNjF9Hbv
	cYvGIpaqlITOdG153URXcYg==
X-Google-Smtp-Source: AGHT+IF3RH6VzHVCehHRbpJJLJjV+rVcxv8rDd/2+CtDFFrrVHzDHLPS8NaJht7KEp7lWFwHwxhOI4KSFp5QbSD+AA==
X-Received: from pjbdj7.prod.google.com ([2002:a17:90a:d2c7:b0:2fc:2b96:2d4b])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3b4a:b0:2fa:1a8a:cffc with SMTP id 98e67ed59e1d1-2fce875d403mr10219694a91.34.1740251732332;
 Sat, 22 Feb 2025 11:15:32 -0800 (PST)
Date: Sat, 22 Feb 2025 19:15:15 +0000
In-Reply-To: <20250222191517.743530-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250222191517.743530-1-almasrymina@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250222191517.743530-8-almasrymina@google.com>
Subject: [PATCH net-next v5 7/9] gve: add netmem TX support to GVE DQO-RDA mode
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	asml.silence@gmail.com, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"

Use netmem_dma_*() helpers in gve_tx_dqo.c DQO-RDA paths to
enable netmem TX support in that mode.

Declare support for netmem TX in GVE DQO-RDA mode.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v4:
- New patch
---
 drivers/net/ethernet/google/gve/gve_main.c   | 4 ++++
 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 8 +++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 029be8342b7b..0f11c8455149 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2817,6 +2817,10 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	dev_info(&pdev->dev, "GVE version %s\n", gve_version_str);
 	dev_info(&pdev->dev, "GVE queue format %d\n", (int)priv->queue_format);
+
+	if (!gve_is_gqi(priv) && !gve_is_qpl(priv))
+		dev->netmem_tx = true;
+
 	gve_clear_probe_in_progress(priv);
 	queue_work(priv->gve_wq, &priv->service_task);
 	return 0;
diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index 394debc62268..e74580dc7ebe 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -667,7 +667,8 @@ static int gve_tx_add_skb_no_copy_dqo(struct gve_tx_ring *tx,
 			goto err;
 
 		dma_unmap_len_set(pkt, len[pkt->num_bufs], len);
-		dma_unmap_addr_set(pkt, dma[pkt->num_bufs], addr);
+		netmem_dma_unmap_addr_set(skb_frag_netmem(frag), pkt,
+					  dma[pkt->num_bufs], addr);
 		++pkt->num_bufs;
 
 		gve_tx_fill_pkt_desc_dqo(tx, desc_idx, skb, len, addr,
@@ -1045,8 +1046,9 @@ static void gve_unmap_packet(struct device *dev,
 	dma_unmap_single(dev, dma_unmap_addr(pkt, dma[0]),
 			 dma_unmap_len(pkt, len[0]), DMA_TO_DEVICE);
 	for (i = 1; i < pkt->num_bufs; i++) {
-		dma_unmap_page(dev, dma_unmap_addr(pkt, dma[i]),
-			       dma_unmap_len(pkt, len[i]), DMA_TO_DEVICE);
+		netmem_dma_unmap_page_attrs(dev, dma_unmap_addr(pkt, dma[i]),
+					    dma_unmap_len(pkt, len[i]),
+					    DMA_TO_DEVICE, 0);
 	}
 	pkt->num_bufs = 0;
 }
-- 
2.48.1.601.g30ceb7b040-goog



Return-Path: <linux-kernel+bounces-535534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B097A47420
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 125E51694C7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637F922538F;
	Thu, 27 Feb 2025 04:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0DXnXmCM"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17E22153E9
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740629545; cv=none; b=uEhfkLOqmhW/+0SJOhB5S2WHqj9KDc/tM4i43C+AAeO0hrNPjAya8ugK3T3DNRdE54y2U0Xt65veIPoQpRDNbkbl7QIPA1TeWWoQsemRIKjDBJR5amhJ553zEGOmm3fv1osxItOiTxC4ai9l2/LfYKuzMPVViNX+JPNT/jSsQaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740629545; c=relaxed/simple;
	bh=lBHVKsoCoEgF3bW4CEOzs0StxmW/iNQWIYUttIHfQDA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f6cPIq+mgBVzL70nkUUWV202jDhRJE6LNYe/MSBTRh7q0pMNF1Eg3EssM893FqxGDWrRs1vWCNDZRqr6t+Epv8SasM0ZnXIo37dtx3CCKCHpzxy+thkICDhcHYTThcCIXYnUlFIKSh60pv8a3GJ5BQJE2kpu4ZdCTDKri31VRUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0DXnXmCM; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-220cd43c75aso15751065ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740629542; x=1741234342; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5S0JHVgHhHQYEE34tPqFbSIw0W293JeUSSt2z5OQCwE=;
        b=0DXnXmCMbzObPuKx5pSmtu5kbN3BoRHzohK1jIQNNcVoHbIm9Z6GfdmiKGOWk0uvJF
         Qree8uJEa6wSCIcxpFlQ5/LH4PO+e+L2XiWb0HQxsBqxtDw+dOa+CCn+1s0ve3vt1v/f
         23+K1n8qQX4BUR/NfeIf3KKy5tbnUKZFGnjFLNMlOrIOjgzwDJORPsG9CNF7/AiaS9LB
         JkG5ZHGDtTW5hUbJZ8Agccc+j9lPuCn+RCV363AQvAOYDT3na0qXB4oXMOuPHPt4B4IF
         PATbeXz27keSC6ehTH4pfxz6TSrsEZKCIO9UUFrjBQiQjPV9/GWra4y1SMRkMaJFYlYL
         V/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740629542; x=1741234342;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5S0JHVgHhHQYEE34tPqFbSIw0W293JeUSSt2z5OQCwE=;
        b=u/wdKXHPoZ4w9Pp9+bNAPO18fmaDqS+J/DAR8liYBiPY7zoStHKAYMfD45NL2g8OYy
         IFmzWZjLsujP11XO8ymbomvpXsSGNrRdQE66O1xw/paObBbwh6ST6UUQ8FDKvg5srUyX
         Bivh4bGkJh55yBNsrP0RFrOwykHStk0nnH78daWw6b/CkTrvuyPea+khRBSo7YjDbCHO
         8G2MS2/mEXR9WT1sCdHYdEPvLq9D/JJ7mGFitWyTSj+rTn28FknKTAkoow1kHPGeDMAb
         4LBGHfIwkdngzjXBkevJrRvHVFbzgrE3pM3Ag8152ZnepD6uWOAoYotlLBUih++HSS6/
         XSJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIfQSYzvoqM4EOAmGTv5kYhKE2WD5SM/ZR2619Qtwl7Gowizrbdu4BcwGDOJN+jfhDeESjsJUQ7IOxM9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3MZ76YmXHXLziLyVGA0z/04BxE6Ep+IvsTmgLLJchQfl4SMAi
	/GmRqh6FjU3NAvYUBePEVkPi0afy1jgQYG60q7+1vwMq2ietcPMY/J1twJYzSaB0ZEgnEwnuQ5S
	5XbHYjWvmIzY9aGBwlVKqiA==
X-Google-Smtp-Source: AGHT+IFNaUt79J+Fb8AMW/Fz6OdO9a2Y/vF7HhxDsqKeMT5mD/d76Hd15XMQCxK+nePqad+2ARZWGsDMfho8wFl38g==
X-Received: from plbjx3.prod.google.com ([2002:a17:903:1383:b0:220:bc6c:e6ad])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d4ce:b0:221:7955:64c3 with SMTP id d9443c01a7336-223200af968mr96903595ad.23.1740629542171;
 Wed, 26 Feb 2025 20:12:22 -0800 (PST)
Date: Thu, 27 Feb 2025 04:12:07 +0000
In-Reply-To: <20250227041209.2031104-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227041209.2031104-1-almasrymina@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250227041209.2031104-7-almasrymina@google.com>
Subject: [PATCH net-next v6 6/8] gve: add netmem TX support to GVE DQO-RDA mode
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
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
2.48.1.658.g4767266eb4-goog



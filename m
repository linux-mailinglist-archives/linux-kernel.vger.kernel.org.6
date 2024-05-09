Return-Path: <linux-kernel+bounces-174955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA91C8C17F3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E412B21F98
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B32986AFC;
	Thu,  9 May 2024 20:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="qKSiSiwN"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93955338D
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 20:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715287871; cv=none; b=CafvHOcRHcDFdVKdPhlpkIlY4tgBZn0MTRtLe/B1OvLO7M4taFg7vpX5/ZX6fyU6Pj5tO/fMinw6Yq/HOe00HLOG0tyfrH/XWFxOxn2Zd94sCc+QjGX26lKCqlzSdn0eDHBjiGSBPrM/DyBw4m7kM1xYLKxgAKPs9oqrC2732TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715287871; c=relaxed/simple;
	bh=gCbabcQaR8Ix1K97TkMliO2FSC7RBAC3W9/BPXaCzC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p3AJ3cJ0ovu6roR2tVj6yRlHxif4v+vIOhpAuO5cG8P6IAeUGT3qOOHdV+Et3qm/x265MvDF3I4zDuamNeJEWmrn1buKm5dM6IVOD0tifY5mYxtQmd1R+AcrXhOZRhiqmAsigKqY8YkQkp6ZRBziz/Qr6brPEUNTcjZDaZLY1Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=qKSiSiwN; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ed835f3c3cso11423555ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 13:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1715287868; x=1715892668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmgZyGJ6WZhyygeOTuBznvTKrsssXOFJdYN+KnXDyKU=;
        b=qKSiSiwNW1uI8ORsZds65zVBrjsrTwxnHMSNcSTWaLJ4RTCfIFfa4i+/rOoRyAchtZ
         u93CRfrF+wrqfHIqnGIZ2GGeL+41X57AWe4PkWxYRlZXqKYqpBippEgUA+entGOvGxLN
         ciQYslYIIw6GhPwhMYnJDx0Qih0fBxovHA0As=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715287868; x=1715892668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KmgZyGJ6WZhyygeOTuBznvTKrsssXOFJdYN+KnXDyKU=;
        b=Ol7dQOvRhUy7d3zpr136veA5U00nhNkybpxIHlA2SXCaOOrRJ7zL0FHsqBHDppY7Uk
         GLeVyx1H178GvN8CnPuW5jlTajBqnmng0WGFsKZTcWFqb+r6D61dX/JrhF5l/JNsfJ6A
         Q/fpZHb3Z9UKHeqKUhaHt2sgWOchrBC5C5tu7j0iMpaApF7RG0N9spZYdmE5nRL5nQqj
         hQjgEBnXrbDhEDMVkQfgosPI0aZFHH1jddHNhcOUnVJbhPdp+wRj4XChNq9SHfpbymBH
         pNnia2g4V5cueB/1Lr4i9Z8O9Ujl0acY2rV2QNZuIPC2t+oSfgK3eP9TIdCEoyoSH0EN
         Xokg==
X-Gm-Message-State: AOJu0YywLSsg6HNZTRdOY9kjUbQFKfTO9CLqulbBttBdoHKrWcYxDHx2
	tQo5+VvheudRe15cFrjw23EDagyLXplsk7YgKiBhWKmVsHmh8N6oab55URkUDcbKfJnyjw1hfqb
	nkPVTBBYdSaur7lA8NpZaSuSbgp25VDMUq8JtU6dzz6OVfj+r9YbNM6urSUjAS8/u+WV6XFDCwa
	r1cZGx+29chx8LchROaP/o37Oao0JyZmsCXKIk+YTbDXU=
X-Google-Smtp-Source: AGHT+IFAC02y7XWbzyZ9poYznCRhteDMrS6y/6vnrp3VuOJIRuyyMgREUL36urHGU3CvlHCx24DmMQ==
X-Received: by 2002:a17:902:d4c2:b0:1ec:ad62:fe87 with SMTP id d9443c01a7336-1ef44059628mr10146585ad.56.1715287867290;
        Thu, 09 May 2024 13:51:07 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0badb959sm18677365ad.85.2024.05.09.13.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 13:51:06 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	nalramli@fastly.com,
	Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX4 core VPI driver)
Subject: [PATCH net-next v4 2/3] net/mlx4: link NAPI instances to queues and IRQs
Date: Thu,  9 May 2024 20:50:55 +0000
Message-Id: <20240509205057.246191-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240509205057.246191-1-jdamato@fastly.com>
References: <20240509205057.246191-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make mlx4 compatible with the newly added netlink queue GET APIs.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
Acked-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx4/en_cq.c   | 14 ++++++++++++++
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_cq.c b/drivers/net/ethernet/mellanox/mlx4/en_cq.c
index 1184ac5751e1..461cc2c79c71 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_cq.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_cq.c
@@ -126,6 +126,7 @@ int mlx4_en_activate_cq(struct mlx4_en_priv *priv, struct mlx4_en_cq *cq,
 		cq_idx = cq_idx % priv->rx_ring_num;
 		rx_cq = priv->rx_cq[cq_idx];
 		cq->vector = rx_cq->vector;
+		irq = mlx4_eq_get_irq(mdev->dev, cq->vector);
 	}
 
 	if (cq->type == RX)
@@ -142,18 +143,23 @@ int mlx4_en_activate_cq(struct mlx4_en_priv *priv, struct mlx4_en_cq *cq,
 	if (err)
 		goto free_eq;
 
+	cq->cq_idx = cq_idx;
 	cq->mcq.event = mlx4_en_cq_event;
 
 	switch (cq->type) {
 	case TX:
 		cq->mcq.comp = mlx4_en_tx_irq;
 		netif_napi_add_tx(cq->dev, &cq->napi, mlx4_en_poll_tx_cq);
+		netif_napi_set_irq(&cq->napi, irq);
 		napi_enable(&cq->napi);
+		netif_queue_set_napi(cq->dev, cq_idx, NETDEV_QUEUE_TYPE_TX, &cq->napi);
 		break;
 	case RX:
 		cq->mcq.comp = mlx4_en_rx_irq;
 		netif_napi_add(cq->dev, &cq->napi, mlx4_en_poll_rx_cq);
+		netif_napi_set_irq(&cq->napi, irq);
 		napi_enable(&cq->napi);
+		netif_queue_set_napi(cq->dev, cq_idx, NETDEV_QUEUE_TYPE_RX, &cq->napi);
 		break;
 	case TX_XDP:
 		/* nothing regarding napi, it's shared with rx ring */
@@ -189,6 +195,14 @@ void mlx4_en_destroy_cq(struct mlx4_en_priv *priv, struct mlx4_en_cq **pcq)
 void mlx4_en_deactivate_cq(struct mlx4_en_priv *priv, struct mlx4_en_cq *cq)
 {
 	if (cq->type != TX_XDP) {
+		enum netdev_queue_type qtype;
+
+		if (cq->type == RX)
+			qtype = NETDEV_QUEUE_TYPE_RX;
+		else
+			qtype = NETDEV_QUEUE_TYPE_TX;
+
+		netif_queue_set_napi(cq->dev, cq->cq_idx, qtype, NULL);
 		napi_disable(&cq->napi);
 		netif_napi_del(&cq->napi);
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
index cd70df22724b..28b70dcc652e 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
@@ -380,6 +380,7 @@ struct mlx4_en_cq {
 #define MLX4_EN_OPCODE_ERROR	0x1e
 
 	const struct cpumask *aff_mask;
+	int cq_idx;
 };
 
 struct mlx4_en_port_profile {
-- 
2.25.1



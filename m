Return-Path: <linux-kernel+bounces-228104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1353915ADF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 02:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D9C283681
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C841A270;
	Tue, 25 Jun 2024 00:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D5FTMWE4"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8E81759F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 00:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719274366; cv=none; b=rf+XVWpqDH+WBlXYhWkx71ckp6CkOQs+e+tY+fvOZhA3dX1SB6GKhJSvAsYSom6GGdCYd+r+EZ/tpg+k3nxwQ9H05y+dbGZWFpeTlPLI69Esyas76a+iTQNqwA20RsuvhHAea2YJYh1MuJhPuULF2GTh+10Y3Lr/DHQ6qpxs9i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719274366; c=relaxed/simple;
	bh=MmVEsjXBcmLv3ahy7KCRgQ1UaitYYNC1aL/kmKXydJI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cVcJSCNYMVyu8kDF98L0Mrz03c1lpJmN+GqSfHQX+9Zx6k8IhKsjfe/ewBSroul1zVUa4cRBkI032O8MGp6T8A5vH9Ho0o4xgelHnkMvA9ig5rxxtjQ5XiEDBZv+XzYwKP/wMcHInNLyULM1h4mRRhXlkJ6q03uPs5NfE6JfAGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D5FTMWE4; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e023e936ac4so10174696276.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 17:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719274363; x=1719879163; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UF/LA5l49cCSyY/ORl++ES/NB8h3whhttxPN3Oux0qU=;
        b=D5FTMWE4LEaPrDoOsINVbMnaxiKAptlim3sHhkRGwLfISzQW1nZc2QOgTpXNzfacc+
         +uDDTpocgfkCPDAqhYm3EUAEsH/uT+dqcJ67EyJoLA93mAav48TRM5w6q6rJKiuPT2OY
         abL4S2v1o7STP1iE2St0ekTbOA7+UPiSbT8XRc2V1xHIgdVNPW7f2Khn9VFOZMJI0kmv
         99qgq1Jj5fu4NY598xCwkdmXVTOGAPHvFXjplHvH6Ec3iAFADE2dLj7iazeszg2Wecta
         lB2FPzeEOKsTEN0nqeixf+Z+c1KzVlUzQEX+Gulz6IY4/FNmBRT5dp8sSnD1ajhlF2An
         yNwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719274363; x=1719879163;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UF/LA5l49cCSyY/ORl++ES/NB8h3whhttxPN3Oux0qU=;
        b=lO5FmoG0JDouVFb4My/nqYZtKRfhqJxGxhgWSC70lHJcDN8Rc98BO9oY9VlYnDBOvY
         VyhdDaktRsqvkoe3pN4dA4VXeOhnH1RVEmW78wyOFcXbgSa5xTFwAUKTIsSJ30tDnhwC
         Typ+CesJ+8ekAnWVBmEP4uRuloSPuYbxjUrQEcT3oleuXC57xxIJKiZiJl2jKDM+R/ft
         yexNdCGUWJ2/JRKuUwlGVG2/uX2F8ABDcalcxyzgs6leD/vmNpxVSi2NUXmxSg3v0+VM
         BqDGZ2n6YR+tmBzPsu/FIhU09sVmlJOzIIKqhYvXkrKxczT/4kmjL1sUcEJvYjnssEX9
         n8HA==
X-Forwarded-Encrypted: i=1; AJvYcCX1aJUAM0EV+hzSvRSv8vgnUJylv+nd611WYjQOOFFgGSqk9G3gmS0jIIrbwW2tbWIqBfwxMtj6w3XwMXKkwE7kHSSKFvJhou8zj7I2
X-Gm-Message-State: AOJu0YxgezV0UAThrrFv/wTXF4nMMVjNsMK1QcL8y/V3IBcVBul1Mxcm
	TIPL5CKCtkg0q7Gj9c760hsmOiJZEklGUPAnO3M618y+M0usCVSBv7j6BWpb/zDqhqudSL1ElGR
	MjgO8B7RhoFU0XA==
X-Google-Smtp-Source: AGHT+IEjts80TGjeNg9PqdjcZ5WlTd1WyKlXNuVsz0sNbeNZhg0p7d3HFilnAbDL/fQFqvFR4brINgPRKmkP9AY=
X-Received: from ziwei-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:9b0])
 (user=ziweixiao job=sendgmr) by 2002:a25:3625:0:b0:dfd:d6ec:4e3b with SMTP id
 3f1490d57ef6-e0303f2b228mr65305276.7.1719274363172; Mon, 24 Jun 2024 17:12:43
 -0700 (PDT)
Date: Tue, 25 Jun 2024 00:12:29 +0000
In-Reply-To: <20240625001232.1476315-1-ziweixiao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625001232.1476315-1-ziweixiao@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240625001232.1476315-4-ziweixiao@google.com>
Subject: [PATCH net-next v3 3/5] gve: Add flow steering device option
From: Ziwei Xiao <ziweixiao@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, pkaligineedi@google.com, shailend@google.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, hramamurthy@google.com, ziweixiao@google.com, 
	rushilg@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Jeroen de Borst <jeroendb@google.com>

Add a new device option to signal to the driver that the device supports
flow steering. This device option also carries the maximum number of
flow steering rules that the device can store.

Signed-off-by: Jeroen de Borst <jeroendb@google.com>
Co-developed-by: Ziwei Xiao <ziweixiao@google.com>
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
Changes in v3:
	- Move the `priv->dev->hw_features |= NETIF_F_NTUPLE;` to where
	  flow steering is supported when receiving the valid flow
	  steering device option(Jakub Kicinski)

 drivers/net/ethernet/google/gve/gve.h        |  2 +
 drivers/net/ethernet/google/gve/gve_adminq.c | 40 +++++++++++++++++++-
 drivers/net/ethernet/google/gve/gve_adminq.h | 11 ++++++
 3 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index ca7fce17f2c0..58213c15e084 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -786,6 +786,8 @@ struct gve_priv {
 
 	u16 header_buf_size; /* device configured, header-split supported if non-zero */
 	bool header_split_enabled; /* True if the header split is enabled by the user */
+
+	u32 max_flow_rules;
 };
 
 enum gve_service_task_flags_bit {
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 5b54ce369eb2..088f543f0ba8 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -44,6 +44,7 @@ void gve_parse_device_option(struct gve_priv *priv,
 			     struct gve_device_option_jumbo_frames **dev_op_jumbo_frames,
 			     struct gve_device_option_dqo_qpl **dev_op_dqo_qpl,
 			     struct gve_device_option_buffer_sizes **dev_op_buffer_sizes,
+			     struct gve_device_option_flow_steering **dev_op_flow_steering,
 			     struct gve_device_option_modify_ring **dev_op_modify_ring)
 {
 	u32 req_feat_mask = be32_to_cpu(option->required_features_mask);
@@ -189,6 +190,23 @@ void gve_parse_device_option(struct gve_priv *priv,
 		if (option_length == GVE_DEVICE_OPTION_NO_MIN_RING_SIZE)
 			priv->default_min_ring_size = true;
 		break;
+	case GVE_DEV_OPT_ID_FLOW_STEERING:
+		if (option_length < sizeof(**dev_op_flow_steering) ||
+		    req_feat_mask != GVE_DEV_OPT_REQ_FEAT_MASK_FLOW_STEERING) {
+			dev_warn(&priv->pdev->dev, GVE_DEVICE_OPTION_ERROR_FMT,
+				 "Flow Steering",
+				 (int)sizeof(**dev_op_flow_steering),
+				 GVE_DEV_OPT_REQ_FEAT_MASK_FLOW_STEERING,
+				 option_length, req_feat_mask);
+			break;
+		}
+
+		if (option_length > sizeof(**dev_op_flow_steering))
+			dev_warn(&priv->pdev->dev,
+				 GVE_DEVICE_OPTION_TOO_BIG_FMT,
+				 "Flow Steering");
+		*dev_op_flow_steering = (void *)(option + 1);
+		break;
 	default:
 		/* If we don't recognize the option just continue
 		 * without doing anything.
@@ -208,6 +226,7 @@ gve_process_device_options(struct gve_priv *priv,
 			   struct gve_device_option_jumbo_frames **dev_op_jumbo_frames,
 			   struct gve_device_option_dqo_qpl **dev_op_dqo_qpl,
 			   struct gve_device_option_buffer_sizes **dev_op_buffer_sizes,
+			   struct gve_device_option_flow_steering **dev_op_flow_steering,
 			   struct gve_device_option_modify_ring **dev_op_modify_ring)
 {
 	const int num_options = be16_to_cpu(descriptor->num_device_options);
@@ -230,7 +249,7 @@ gve_process_device_options(struct gve_priv *priv,
 					dev_op_gqi_rda, dev_op_gqi_qpl,
 					dev_op_dqo_rda, dev_op_jumbo_frames,
 					dev_op_dqo_qpl, dev_op_buffer_sizes,
-					dev_op_modify_ring);
+					dev_op_flow_steering, dev_op_modify_ring);
 		dev_opt = next_opt;
 	}
 
@@ -838,6 +857,8 @@ static void gve_enable_supported_features(struct gve_priv *priv,
 					  *dev_op_dqo_qpl,
 					  const struct gve_device_option_buffer_sizes
 					  *dev_op_buffer_sizes,
+					  const struct gve_device_option_flow_steering
+					  *dev_op_flow_steering,
 					  const struct gve_device_option_modify_ring
 					  *dev_op_modify_ring)
 {
@@ -890,10 +911,23 @@ static void gve_enable_supported_features(struct gve_priv *priv,
 			priv->min_tx_desc_cnt = be16_to_cpu(dev_op_modify_ring->min_tx_ring_size);
 		}
 	}
+
+	if (dev_op_flow_steering &&
+	    (supported_features_mask & GVE_SUP_FLOW_STEERING_MASK)) {
+		if (dev_op_flow_steering->max_flow_rules) {
+			priv->max_flow_rules =
+				be32_to_cpu(dev_op_flow_steering->max_flow_rules);
+			priv->dev->hw_features |= NETIF_F_NTUPLE;
+			dev_info(&priv->pdev->dev,
+				 "FLOW STEERING device option enabled with max rule limit of %u.\n",
+				 priv->max_flow_rules);
+		}
+	}
 }
 
 int gve_adminq_describe_device(struct gve_priv *priv)
 {
+	struct gve_device_option_flow_steering *dev_op_flow_steering = NULL;
 	struct gve_device_option_buffer_sizes *dev_op_buffer_sizes = NULL;
 	struct gve_device_option_jumbo_frames *dev_op_jumbo_frames = NULL;
 	struct gve_device_option_modify_ring *dev_op_modify_ring = NULL;
@@ -930,6 +964,7 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 					 &dev_op_gqi_qpl, &dev_op_dqo_rda,
 					 &dev_op_jumbo_frames, &dev_op_dqo_qpl,
 					 &dev_op_buffer_sizes,
+					 &dev_op_flow_steering,
 					 &dev_op_modify_ring);
 	if (err)
 		goto free_device_descriptor;
@@ -991,7 +1026,8 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 
 	gve_enable_supported_features(priv, supported_features_mask,
 				      dev_op_jumbo_frames, dev_op_dqo_qpl,
-				      dev_op_buffer_sizes, dev_op_modify_ring);
+				      dev_op_buffer_sizes, dev_op_flow_steering,
+				      dev_op_modify_ring);
 
 free_device_descriptor:
 	dma_pool_free(priv->adminq_pool, descriptor, descriptor_bus);
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index e0370ace8397..e64a0e72e781 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -146,6 +146,14 @@ struct gve_device_option_modify_ring {
 
 static_assert(sizeof(struct gve_device_option_modify_ring) == 12);
 
+struct gve_device_option_flow_steering {
+	__be32 supported_features_mask;
+	__be32 reserved;
+	__be32 max_flow_rules;
+};
+
+static_assert(sizeof(struct gve_device_option_flow_steering) == 12);
+
 /* Terminology:
  *
  * RDA - Raw DMA Addressing - Buffers associated with SKBs are directly DMA
@@ -163,6 +171,7 @@ enum gve_dev_opt_id {
 	GVE_DEV_OPT_ID_DQO_QPL			= 0x7,
 	GVE_DEV_OPT_ID_JUMBO_FRAMES		= 0x8,
 	GVE_DEV_OPT_ID_BUFFER_SIZES		= 0xa,
+	GVE_DEV_OPT_ID_FLOW_STEERING		= 0xb,
 };
 
 enum gve_dev_opt_req_feat_mask {
@@ -174,12 +183,14 @@ enum gve_dev_opt_req_feat_mask {
 	GVE_DEV_OPT_REQ_FEAT_MASK_DQO_QPL		= 0x0,
 	GVE_DEV_OPT_REQ_FEAT_MASK_BUFFER_SIZES		= 0x0,
 	GVE_DEV_OPT_REQ_FEAT_MASK_MODIFY_RING		= 0x0,
+	GVE_DEV_OPT_REQ_FEAT_MASK_FLOW_STEERING		= 0x0,
 };
 
 enum gve_sup_feature_mask {
 	GVE_SUP_MODIFY_RING_MASK	= 1 << 0,
 	GVE_SUP_JUMBO_FRAMES_MASK	= 1 << 2,
 	GVE_SUP_BUFFER_SIZES_MASK	= 1 << 4,
+	GVE_SUP_FLOW_STEERING_MASK	= 1 << 5,
 };
 
 #define GVE_DEV_OPT_LEN_GQI_RAW_ADDRESSING 0x0
-- 
2.45.2.741.gdbec12cfda-goog



Return-Path: <linux-kernel+bounces-320311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0FE9708B6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 18:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5767A1C2159F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 16:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D95017C9AC;
	Sun,  8 Sep 2024 16:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="W0eg9OPM"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3644417BB17
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 16:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725811745; cv=none; b=STZute3zUMhnKJ+GxbqxgMkrTdqgegr97M9QMnXRtQ3Y6lUHxqP0ladCkOHA6J1VKNssPB4r3ggpBp/caMbHFDxti7Xqz2/WFG583mrIdpXiWOhROhAg9QM9keCJBC2YTy1G1uGEiU8o8Er6tajLSd3JPvaIpzzQRA8zWh0A3sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725811745; c=relaxed/simple;
	bh=4HEYXckzb30ldYDuv6OJ1NZpctFxN6G/pxcTLPkqpU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I8rPdUbOeyMjjR261GujM1GHrt1mY9PJEc69FFQ1RZhno5d6nFIpmTb8qFw3hv53aw3pNNwKZ5QqqxMjLOyWlXtb6qm6Sb3gPailK8081FfbxPIbVJnHn9L2Yly5vpefcvZHtJdVo65XqTNv5E4WR5cuFXe+u7IdszRwEv9s05s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=W0eg9OPM; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fee6435a34so30451165ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 09:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1725811743; x=1726416543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPqS0EtM6+tGmEgcYaXfQxu3vZbAasBMjVTJ7sHaKBI=;
        b=W0eg9OPMngSp6ybIFB5oq4IB6cv9G+mpQ0SAqvEzmC9MkxSjbxC5Xw3zXG67zs0jFk
         KbgUglMGRj2AQbmtWReAVdvJyCN3B5iCsNGaivaxZnNzyB528qdctatcSNonK+IYCiNP
         6GKLdo12yk/oYHkC3d6yWJZf7laXTUU4fKElM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725811743; x=1726416543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gPqS0EtM6+tGmEgcYaXfQxu3vZbAasBMjVTJ7sHaKBI=;
        b=HR1bYzOnpZo8TEauLDE85aICXGyBhq7MV2k4s073FCF2DhDqoSYf2PuS5LGgVac4w6
         TDQufCNbaJHhc8H1pphNhYgZXRVBwJMglDQp0cv5PrBnOtm1Xae5H0UO85VfUsePlVPq
         sJA/It8Rd6a86MMD/FORl/YOjkhUfd2iiQd9+3bmUaCn5NAC2a3cv7hjRKlJTouy9g0/
         +AnFnxp3EJRuhvD56kEBo2RkTHtk8eoMOMukSvMX/of8L3WSqNpUqwzFfU6ctPz1S+XN
         5TyRpoS08Sd6mUsUkxR8D0nnDYbilHiOqBKZilukLXrqC/4HXvkk5Ohaq6AkgyKdTaIs
         WfMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtnZwLHECcycsjhKi850uBPTtd5GwHM6/aJB5OZm2lwWJp2w+9Gsv+jpZfrIqUIp1PWuWcmAZwpFBHYTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwST+9JFisII/c5wTudakH9sYboBpavTKyYCUNjWlCRsM5i4hUo
	94lsWori/ukLxR7z4NqpLlambGhLgDEN9dvNOqNSZUwJqQoARN7s48ki3SyYqbU=
X-Google-Smtp-Source: AGHT+IGK4rR7SL/3525ecrLJrxwc+z1VKN6ygfWdTXmVhAnwErckliz5jxK7Lr6ScN1xS4HxwJmdDA==
X-Received: by 2002:a17:902:f64e:b0:205:9220:aa37 with SMTP id d9443c01a7336-206f051e59emr78713005ad.22.1725811743466;
        Sun, 08 Sep 2024 09:09:03 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f3179fsm21412535ad.258.2024.09.08.09.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 09:09:03 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	kuba@kernel.org,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	Joe Damato <jdamato@fastly.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next v2 8/9] mlx5: Add support for napi storage
Date: Sun,  8 Sep 2024 16:06:42 +0000
Message-Id: <20240908160702.56618-9-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240908160702.56618-1-jdamato@fastly.com>
References: <20240908160702.56618-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use netif_napi_add_storage to assign per-NAPI storage when initializing
NAPIs.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 47e7a80d221b..2b718ee61140 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2696,7 +2696,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
 	c->aff_mask = irq_get_effective_affinity_mask(irq);
 	c->lag_port = mlx5e_enumerate_lag_port(mdev, ix);
 
-	netif_napi_add(netdev, &c->napi, mlx5e_napi_poll);
+	netif_napi_add_storage(netdev, &c->napi, mlx5e_napi_poll, NAPI_POLL_WEIGHT, ix);
 	netif_napi_set_irq(&c->napi, irq);
 
 	err = mlx5e_open_queues(c, params, cparam);
-- 
2.25.1



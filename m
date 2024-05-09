Return-Path: <linux-kernel+bounces-174954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADF08C17ED
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B462D281358
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C9A85955;
	Thu,  9 May 2024 20:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Ed67/4tf"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D946A83A0D
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 20:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715287869; cv=none; b=k+3Qe+mLbXOnSVdTfVKdEbf0b5x4qx+CHAis8GFMcISvb/YSS1DIPr1a/2X7UkKtqFtdF5gZ2Y6OA9B+iJMqC5/PiqOjP2/rTcxEAdc4QxBVtT1miMHx/3AZTm5P1zhBULAlmd4686ojMwNtg/kvueKgDIry7w3imxvGQ4i8hB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715287869; c=relaxed/simple;
	bh=AO4ibM0f40u0LST8xsBvynBO/brqWCLwYZxK5Wpm0nw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZUuOYOeu84n6w25aPwITm6NRQf/atFR2hgqLlTWe2iDDpHk2GSWA2ltJWa7AFnze5rdxxz3bTmQzCViBL6sJV7W3Lc3ujMbWkPcBpU+BZF9Ufi5DpT7wdEVJAwhSajKvifr7Nkox0H9hSWyrsdtnfp+ipLvCAXa4kf3LvIBLuNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Ed67/4tf; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-620e30d8f37so1109982a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 13:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1715287866; x=1715892666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mK9jRCqJy/IAjt4V55hSSH/H3KvUaHNlqx/4tUOcg/w=;
        b=Ed67/4tfRKob+rHwqlGfFIl6bqdWmz9So+IxPDc4LHg5gndY/4YzTkAYeIdM4Tp9Yk
         OrrehrbByqoUzvelU3q/x5TzL98DIlmdYARhEYkZnbXNhud9tvOvxMhnphWq5Taxcb7P
         tzRfNG/9JxVKihzIGfjBgX1vUmbScnaNzEhuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715287866; x=1715892666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mK9jRCqJy/IAjt4V55hSSH/H3KvUaHNlqx/4tUOcg/w=;
        b=lq7HeTE8udkjCQceHYr6Z1GVX01RqGJn9RFOvEzJqafPvr4lp+oztu2bUf4jHe2q7o
         nYchSsi6ryQG7MVD8sm79lx7czhV9vhjUv9Z6fv1PWhr0h3Pqs83fr+9nH43LGZRpYBe
         4Ul1cbl2h/ga8ZPkV5HYCveQfdl1S3+plLvI4eC3IJ8q8NjG753y4WHWsICLkxjZW0kJ
         7qnY1DewCXTD74z/lpD1ohPFLtGBnSzZSfWB47QP2cfDveGpEqQF1ezPcCCHxNdaylV2
         Nfp2Mj0kfjhdeJHxExZ46k27SbEUbZQhcBcHZi0e76x8H4BLgKTK/bx6ZrFBURRBB1j6
         Nsrw==
X-Gm-Message-State: AOJu0YzuFuafgpp4RYProWAYZ2hk4SyqsCWsY34VzkeF2aVR78On38fO
	pOvWsiIHvppquWqbpfyffR5aju6JOm+MBVGhP54cQ1xhm03ENZYoD/8/UfJS0o6+sAL+Yg3cO3U
	zDPXtKlfWSPzFhzn4XRLO9PHDLNBvtD6DzKjRATx5j5TYkvEpbdVO26NbR0+VEZu70v6hgzbsYg
	CKOxzQYiFsUa03DbTwbNlyBV4cmYXBJcriUccBJuOoQio=
X-Google-Smtp-Source: AGHT+IHla1dQrim4j3USXrIXGvmfovYHjmRSCd80Xn+OwNzfQ8XNKU71RDvgr85iegLA1EQwUc2zpw==
X-Received: by 2002:a05:6a21:99aa:b0:1af:7180:494f with SMTP id adf61e73a8af0-1afde1b6f3dmr1283476637.41.1715287865782;
        Thu, 09 May 2024 13:51:05 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0badb959sm18677365ad.85.2024.05.09.13.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 13:51:05 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	nalramli@fastly.com,
	Joe Damato <jdamato@fastly.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX4 core VPI driver)
Subject: [PATCH net-next v4 1/3] net/mlx4: Track RX allocation failures in a stat
Date: Thu,  9 May 2024 20:50:54 +0000
Message-Id: <20240509205057.246191-2-jdamato@fastly.com>
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

mlx4_en_alloc_frags currently returns -ENOMEM when mlx4_alloc_page
fails but does not increment a stat field when this occurs.

A new field called alloc_fail has been added to struct mlx4_en_rx_ring
which is now incremented in mlx4_en_rx_ring when -ENOMEM occurs.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
---
 drivers/net/ethernet/mellanox/mlx4/en_rx.c   | 4 +++-
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index 8328df8645d5..15c57e9517e9 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -82,8 +82,10 @@ static int mlx4_en_alloc_frags(struct mlx4_en_priv *priv,
 
 	for (i = 0; i < priv->num_frags; i++, frags++) {
 		if (!frags->page) {
-			if (mlx4_alloc_page(priv, frags, gfp))
+			if (mlx4_alloc_page(priv, frags, gfp)) {
+				ring->alloc_fail++;
 				return -ENOMEM;
+			}
 			ring->rx_alloc_pages++;
 		}
 		rx_desc->data[i].addr = cpu_to_be64(frags->dma +
diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
index efe3f97b874f..cd70df22724b 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
@@ -355,6 +355,7 @@ struct mlx4_en_rx_ring {
 	unsigned long xdp_tx;
 	unsigned long xdp_tx_full;
 	unsigned long dropped;
+	unsigned long alloc_fail;
 	int hwtstamp_rx_filter;
 	cpumask_var_t affinity_mask;
 	struct xdp_rxq_info xdp_rxq;
-- 
2.25.1



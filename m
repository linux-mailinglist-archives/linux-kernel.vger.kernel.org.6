Return-Path: <linux-kernel+bounces-193397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADE18D2B60
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 05:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CA55289B0C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 03:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8047515B54A;
	Wed, 29 May 2024 03:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Dn4myONj"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7A91391
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 03:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716952850; cv=none; b=dP0selCBdSovOe53Q9in6JuKv+GpcQ0YxMT3eQmles8Wd+8Lo6SRwyp/tINBHUsHgX/CStU/D/peI8Op+B0ddebTYVMNYSYNKaom+IE/0RzKIbotdmstusx5jZdTF2eoTrmYVBAkP51MQOmMihUaPLFVdEb2hSkcau0mu0CmR3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716952850; c=relaxed/simple;
	bh=BVpS8rKD6cvn1sPKzxoaeISlmBMwAbkMpGgmUZ9C45g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ng3VUu3sHYNuwYrR+HrqwORH7qYj2rqyJnnDfjTgP1GA/qKZZjncelnpInTavNihuKpyeMBhaB2d4qTHKaWYQ47cMJJgWXic5mv60lq12FqOGDXStig+YS8ZxybgATP8kV/ndkEvt876jD0AE3HhMvK23A6rpvrP4KFohd7sToE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Dn4myONj; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3d19dfb3dceso835321b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 20:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1716952848; x=1717557648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WirfrVmj6xSxuzh+j2j6GMDFSD8Lc9FPWQtGaC4uG4=;
        b=Dn4myONjX3wib2nS25vRddz2OQ9sEn/AFE7s5KC/oiSSncEUrRZTMZnWcxCpYtdn1n
         G1yCWxRtFWFxWfub+l0qqVsc/VdYClK1o3cR5ItSU8Qc8hXxs8V9GbUfIOuTJeKt47U6
         sTqkMTCqH/qrtphC/10aU9YCLX+z0qusLaU58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716952848; x=1717557648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5WirfrVmj6xSxuzh+j2j6GMDFSD8Lc9FPWQtGaC4uG4=;
        b=V5ljDU3UrPejF3iI4CFRFr+MyS5VnyLBoJjmVNSN1WeVoRaSbrrsQjfv6IJ19hFIaK
         sHCrOLOHp5+Zr4UXxMIMHhEn4Ze6mwgxqbEDqaKlKQJHSA91gd2zguoj5TBGeZB11A3g
         d/zx1DiOcmx+2rzY1hRbfDg56pzeUe8YQ50YSpcrZ6mucE4vJuRSI8rex6aQFCfVBkMV
         GHxa9zFpwhioq0J4BbjEbgly5XrhZqembsHXNFJzXS5eBp6nxVpIFx+UP94JqSCxWXg/
         bQfREMybGtqFKhBRWCv5f8wekBYumUknmZeMcaBcam34bfwOvvpyxby7bhqurfS0huXc
         uLaQ==
X-Gm-Message-State: AOJu0YwSieYwRQJzsAyXwQ3eTxo7CY7BytG40t2SAzH+6yAoh10Vq97L
	GW11rRhor/KkKxDVpVoXPH/rUbiEIBO9hTd9OJP7Hk7NYcDBrjcaJyTKEQKQP09I+e+dWkOy+fF
	sdUZLIyPJj7baedvytge5gTYWM7AC9Yikc7btF2Kdgc8X9zquDXql40i1TOSwr8sudN7PwenbVh
	7Q+QAD6mgUR0iVoSFLZrQ58Bj0XejWzokBfzjdYiwy8WY=
X-Google-Smtp-Source: AGHT+IHH9sy0SpZ3yb1feGf+fkpJAxcwJ0SYOomfUNtQqmdNd7SYvKLISg1dP1EawRO3hGcKzr9hBg==
X-Received: by 2002:a05:6808:13c3:b0:3c9:92f3:d519 with SMTP id 5614622812f47-3d1a6019c51mr17456943b6e.4.1716952847979;
        Tue, 28 May 2024 20:20:47 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fbd3ea03sm7156766b3a.39.2024.05.28.20.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 20:20:47 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: nalramli@fastly.com,
	Joe Damato <jdamato@fastly.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver)
Subject: [RFC net-next v3 1/2] net/mlx5e: Add helpers to calculate txq and ch idx
Date: Wed, 29 May 2024 03:16:26 +0000
Message-Id: <20240529031628.324117-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240529031628.324117-1-jdamato@fastly.com>
References: <20240529031628.324117-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add two helpers to:

1. Compute the txq_ix given a channel and a tc offset (tc_to_txq_ix).
2. Compute the channel index and tc offset given a txq_ix
   (txq_ix_to_chtc_ix).

The first helper, tc_to_txq_ix, is used in place of the mathematical
expressionin mlx5e_open_sqs when txq_ix values are computed.

The second helper, txq_ix_to_chtc_ix, will be used in a following patch.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c  | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index b758bc72ac36..ce15805ad55a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2312,6 +2312,22 @@ static int mlx5e_txq_get_qos_node_hw_id(struct mlx5e_params *params, int txq_ix,
 	return 0;
 }
 
+static inline int tc_to_txq_ix(struct mlx5e_channel *c,
+			       struct mlx5e_params *params,
+			       int tc)
+{
+	return c->ix + tc * params->num_channels;
+}
+
+static inline void txq_ix_to_chtc_ix(struct mlx5e_params *params, int txq_ix,
+				     int *ch_ix, int *tc_ix)
+{
+	if (params->num_channels) {
+		*ch_ix = txq_ix % params->num_channels;
+		*tc_ix = txq_ix / params->num_channels;
+	}
+}
+
 static int mlx5e_open_sqs(struct mlx5e_channel *c,
 			  struct mlx5e_params *params,
 			  struct mlx5e_channel_param *cparam)
@@ -2319,7 +2335,7 @@ static int mlx5e_open_sqs(struct mlx5e_channel *c,
 	int err, tc;
 
 	for (tc = 0; tc < mlx5e_get_dcb_num_tc(params); tc++) {
-		int txq_ix = c->ix + tc * params->num_channels;
+		int txq_ix = tc_to_txq_ix(c, params, tc);
 		u32 qos_queue_group_id;
 		u32 tisn;
 
-- 
2.25.1



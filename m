Return-Path: <linux-kernel+bounces-361686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E4999AB70
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 20:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CFD71F2021C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 18:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C308B1D1F6B;
	Fri, 11 Oct 2024 18:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="foKSwG9Z"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FF91D1E67
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 18:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672374; cv=none; b=IshaRJO0UIBPF+5hiEf0PZbLBC5q/Ab4ZJKNb6ATzfABecTYD2vGwjG4TANwKNrjwvWhPJHysmG3LcxtStl0AHO3dIYW5UOTFxt2FXd5oZ8yiXv4gp0yK3poOFt7jUdEATgi8u4TbWT+Wrao6EpgyX1rFGls8VuuKAlLvg0yng4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672374; c=relaxed/simple;
	bh=rdUwUl0O8uACIgxUtWrf+uGT//W8R20vX+DxgJVlwC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J45dyLwfSFtk1iM/NpPdOwJd5kbsiCFUQXAbawJPZjKKQrO6+Mw5znt8B3xiliBJx9wkryXTHRuRQpJPpmjDqxlwMzqWKwCNkjlbEDSyaVJrjB3B2LJmoYId7UZvwSWyIEtZzoSK8SJLuuCbA0zSb+eVQ/MbkP6nOzE/Lvog+3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=foKSwG9Z; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e2ad9825a7so1707511a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 11:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728672372; x=1729277172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SnL/nRVpUbVr0QJP8g9nrYJJ88Tc0QHRfi4pl34q3/U=;
        b=foKSwG9Z5R+oVSEEsAsDF6CMRqzlGN11KZofIQGq9q3IyINWyrlipI4wHK6oIMhgF/
         ggef884BilgLINlz0fAlFJn+wCZ2D0SEZO8sjJy4tYyIRluddptQn04h0v33ephS2m0r
         H2d6e47LHM7fi1TWDXRVxkD+TtEKhtHfUo23E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672372; x=1729277172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SnL/nRVpUbVr0QJP8g9nrYJJ88Tc0QHRfi4pl34q3/U=;
        b=haYmaSmSyxgvexgdvgFM012/BkkE4QSQKcYI/FOGpcs62gxdFnIgSx5o+C3Q8jfpE2
         QjvZerXzq0YcEm0NhOzdEGnQ7PJGL6q8eQZDxEvFyE4DDxpq9Km5HsUDxGPE+Gsrdj0j
         O7yGRw6Xkxo1JQ7NkyICsAEKCB9VXTO67GroGMR8rBrixcI7SyVm4fWfG/7+vpYKOrlw
         t5n5g+gcmUs+UdfRUFMLx54iI3GJu+CWXgRnW6oZ7IzEvW3XD67mqgJveYQGwuAugdRm
         UEh0YAeBW3fx4yexwN7YksaW9Fzz7G5hDuZ9t5fa8GYiZHUCN03YZWt7PKm74093eeKI
         TbHA==
X-Forwarded-Encrypted: i=1; AJvYcCU25Vbst2Ud38qFev9cMScmatmma9IzHDElg8JlPLcwiYbfxwEAIPCFwjV/bUMD2j3xfJjhkw39XjRr4Cc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6zQsBLyeb3kqgTbMBbuemnRHlA1NjTuGGr7yBaUnBGX6OizwT
	bGSGeRsOnK/jDPFv0bAZnwIboQwmI2Ww97Ft5DMgfd/l1L+h1Mg3wraeRlUpQhE=
X-Google-Smtp-Source: AGHT+IEFsFDVLhRfbEt3rKS6YFF2OdRWJzbou3HLQ3bnnhFginEdMVv+nVTJNPgJ7nFKxYZB38UDGw==
X-Received: by 2002:a17:90a:ee8f:b0:2e2:cf5c:8ee3 with SMTP id 98e67ed59e1d1-2e2f0a48877mr5057995a91.10.1728672372104;
        Fri, 11 Oct 2024 11:46:12 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e30d848e1csm687625a91.42.2024.10.11.11.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:46:10 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	willemdebruijn.kernel@gmail.com,
	edumazet@google.com,
	Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver),
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next v6 8/9] mlx5: Add support for persistent NAPI config
Date: Fri, 11 Oct 2024 18:45:03 +0000
Message-Id: <20241011184527.16393-9-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241011184527.16393-1-jdamato@fastly.com>
References: <20241011184527.16393-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use netif_napi_add_config to assign persistent per-NAPI config when
initializing NAPIs.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index a5659c0c4236..09ab7ac07c29 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2697,7 +2697,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
 	c->aff_mask = irq_get_effective_affinity_mask(irq);
 	c->lag_port = mlx5e_enumerate_lag_port(mdev, ix);
 
-	netif_napi_add(netdev, &c->napi, mlx5e_napi_poll);
+	netif_napi_add_config(netdev, &c->napi, mlx5e_napi_poll, ix);
 	netif_napi_set_irq(&c->napi, irq);
 
 	err = mlx5e_open_queues(c, params, cparam);
-- 
2.25.1



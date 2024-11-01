Return-Path: <linux-kernel+bounces-391670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEA29B8A13
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 04:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 262131F22688
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 03:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADFB13FD83;
	Fri,  1 Nov 2024 03:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ZzeeFI5G"
Received: from mail-yb1-f226.google.com (mail-yb1-f226.google.com [209.85.219.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D824C79
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 03:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730432907; cv=none; b=nxgxoFywIFsJ7djYwKpj2lFcHp/FLzDpBCLtlLktxarpppEhF7V8RGl7AkFb2KGbHHDPo4S+Otp96x+ZLpAiwaTtgCyjRyDLGNFQB2Yl6xHDWxMTSnaCdhfn/bAKjI18KoMbgc/Xdpgfm8lHR1K0yoogUtwGbaK+y9lgwr/0Zzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730432907; c=relaxed/simple;
	bh=vb2oy9sCtacw/TXgOT7kaZXJblOW4SHOKBYJ4mHT4RA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lwnuJhsbecPOTVP7hICLHiiDcIiXxLvACeK+4T0xLfyIcvtiTL2y3qW6QM2BuL2701NkrWuzTMK6n7J28mKzxG0bF3A4hqFRz7f8suA9J+beqdO401oYNEeaGQEdm9ILRScTREJH/hcJEWGeMkDC3+5l/Fvf/1jPpNLtPd9IrMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ZzeeFI5G; arc=none smtp.client-ip=209.85.219.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-yb1-f226.google.com with SMTP id 3f1490d57ef6-e3090425693so229291276.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1730432904; x=1731037704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Up78lUxvH9q9ucvQFWkY0ZlRiNJvCC25wLA/XPV5mzI=;
        b=ZzeeFI5Gv+utldo5Ncc9JuDW9O2ij/nWykM+hYt3eacndZW+NQ2BgmlNiNuWeyOg3z
         VmZ6RbAqMHKer7PLU3pANnTSi0JvOge7NAz6yU3+MOMLsOLPORib6vkZju2+ZwQam9hO
         EQwYMKA5/LAAuf8rlWlk1kf/LhfmHmMivG/z7x+ved8Hh3Swa4z/FuE+WOVAKSzdoTEx
         b6hv0YBZPQOa0kpds8oyLWvKPAWvGeA01YEZSawMCADj6w/7dB/9gHgp2zO+rJvKkWPr
         qTpew1XhDbvPSccrOy6RULbCI707Rk0kgJmZ4HJIqCt1RlIPGeRiMzb0926tSUFUDfLg
         UYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730432904; x=1731037704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Up78lUxvH9q9ucvQFWkY0ZlRiNJvCC25wLA/XPV5mzI=;
        b=GSaNNkl1syhZc3YfIbwd3jeQGknJ7TDsNcWD7ANv+J5Hv9xxmuF1t2MaFJaaxsDNfN
         S4aZ+O+ct3IjatuMynUxMmsGxdqmwXNSRFCkXg3/epOLUXRXC1xzDA4h6IfyRlljSgyC
         pla0rI/tG8We7EMbO4MYBYX9T0SLQJ3ZRdJs4ylE/2fFkf8wvI3OCIgUTFwkK3xMoSGE
         aCG9zexHU3PTYYbb4jd91mU9ahnErK7HBj9jTTGdQAMhnVdPGGEnMSNquoHPLNhBPL+/
         r6buBo+41SfxpcA6QnygB6NhmwnkYI6ZrhHp18Ai/KvQraF2vSCo2zTIMz3jnAVwoDgS
         EKbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT4XNiMVkk1jorDjC2uUUJ0kOKX7IJudFCangj3ztV2rZweokfB9QNrS/s8PbBbYdodaJiKRufPTExH2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ0lZGAgNcJoOgWgFQZ5WEt1WDkHrg0ec3jhabqEwmmgEokNPG
	WVEJjf+HUTq/nww1JevmlFHzkSGYbqg5bwbJeAsHFykIF61XTJ1NcW8mm+6muODyTaaPyMX3kwo
	aSW8WaBlEUv2pabuxMSeyYIUdHTas4yGs2KBNQ/n6jzX8LrqC
X-Google-Smtp-Source: AGHT+IGWZ6+2TcpibDq+QvmilpiTPyrL6xq18JN2Nx0c+o1Cryy+xInZp0VbeTqIdLLnK+T9JrTGA/dbML47
X-Received: by 2002:a05:690c:fc7:b0:6e2:ad08:492a with SMTP id 00721157ae682-6e9d8aab833mr104947587b3.5.1730432903988;
        Thu, 31 Oct 2024 20:48:23 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-6ea55b0cd8fsm946117b3.20.2024.10.31.20.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 20:48:23 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id A182A3406A8;
	Thu, 31 Oct 2024 21:48:22 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 98397E42B1D; Thu, 31 Oct 2024 21:48:22 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] mlx5/core: deduplicate {mlx5_,}eq_update_ci()
Date: Thu, 31 Oct 2024 21:46:40 -0600
Message-ID: <20241101034647.51590-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241101034647.51590-1-csander@purestorage.com>
References: <20241101034647.51590-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The logic of eq_update_ci() is duplicated in mlx5_eq_update_ci(). The
only additional work done by mlx5_eq_update_ci() is to increment
eq->cons_index. Call eq_update_ci() from mlx5_eq_update_ci() to avoid
the duplication.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index 859dcf09b770..078029c81935 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -802,19 +802,12 @@ struct mlx5_eqe *mlx5_eq_get_eqe(struct mlx5_eq *eq, u32 cc)
 }
 EXPORT_SYMBOL(mlx5_eq_get_eqe);
 
 void mlx5_eq_update_ci(struct mlx5_eq *eq, u32 cc, bool arm)
 {
-	__be32 __iomem *addr = eq->doorbell + (arm ? 0 : 2);
-	u32 val;
-
 	eq->cons_index += cc;
-	val = (eq->cons_index & 0xffffff) | (eq->eqn << 24);
-
-	__raw_writel((__force u32)cpu_to_be32(val), addr);
-	/* We still want ordering, just not swabbing, so add a barrier */
-	wmb();
+	eq_update_ci(eq, arm);
 }
 EXPORT_SYMBOL(mlx5_eq_update_ci);
 
 static void comp_irq_release_pci(struct mlx5_core_dev *dev, u16 vecidx)
 {
-- 
2.45.2



Return-Path: <linux-kernel+bounces-378107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E389ACB76
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A58E286B46
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12691B5ED0;
	Wed, 23 Oct 2024 13:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="byqFQa1x"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE31F1AE01C
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 13:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729690913; cv=none; b=LcW1e/n7om2qLkVnlbAZ1xINNZLWs7WQ0c22jLZXYMVk/ZD2i74AFgguhFcD2eGGDfwEbxTlElsBbbAeOM8yAahuXaImlpsdAdIr6vNqjn0YqTmDcTXkUPCquwCg15OC5bN6oZQRYkxDKlODCPn0/4XzvZqoV+i4TnCZLxrbd8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729690913; c=relaxed/simple;
	bh=u9FF3WzzoqNp4eLryQOSowGgpuAPFK0vwL3y9Yg8ZNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P5tzO/KnofrIcRgzWSmoOLxcz0TbBiqvF6QGhMdhrqkLztByp60LK3MMNJdMYc2BrCQbSCScK6lyICLS1AGIeMqzYWmjNpug7iygEMwxEEH4XkSC47a+RkzIin54WtpAM3Nhkz7jC7774pKgTZCQgw4ISJ9PQZhPjv+MwOkqIp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=byqFQa1x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729690910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZAM8ZRvTda+LEs/8ya4sgurWTTiohnnijyfOuyfhNxo=;
	b=byqFQa1xCXkohw8TyvRP+gAxZP/5RsF4oFm0kNWCjid1TdI3ejVAQQxM84xpj8LCpy5qdG
	nBU5XTmb5CDT+xFH94/PlidHizcPYeN5CEf0UIhSPVLjs/Wgrt+9+TOK3oQD/wvjefQH9J
	XEztHF7dGSDH+kMMz29+6eUfUFIiOHc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-6VgPiVvFNSGxX4BPqH6D1A-1; Wed, 23 Oct 2024 09:41:49 -0400
X-MC-Unique: 6VgPiVvFNSGxX4BPqH6D1A-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d589138a9so3790352f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 06:41:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729690908; x=1730295708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZAM8ZRvTda+LEs/8ya4sgurWTTiohnnijyfOuyfhNxo=;
        b=XwNsKXlHWYirmyBozb+T3QHJEpaFVviNsCkKEUbWiGEGFVgoJrD2UDBhTQehYaVtTN
         7J5AGyLUZV0NAVcqUu2A0bc3RCORP0BMJlD8bSFeQ2M/bkq/R2YEnog4QZbi6GJbU56F
         iI+0RXWFGSZ5qDdcybEBDVHWtNUf1jqnzvGWMkQJrTXAi+7Xhux2042uKj5i+YKj9ISC
         2iiIBluAcXW8Q7WUa2TkYzpKyQ6bupppiQmjQYx6TiRCMheUyuE5qj+7KS6J2hbCcyLl
         CtUQT84NcpkE+XJxRUKL3rLaBX2cPD6QUy6oXYjjAHMSBIi4B4T+j2EJb4Ji3LLm+nXS
         vACA==
X-Forwarded-Encrypted: i=1; AJvYcCVVsJkJukaNJUO+PzyyoJkah/lS7CLM23y0CKdNV+unSMA4K48dcgIAv10u+w6AlJXM9STKs2KMb7Y364U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxOpssl8kKvI/DmymdDavRazbiXs+hVgTOCX3N4IgoYH9YIG9Y
	nEYO4xCW/mqR8Pxm52Fz9ZuzjXb+ZQYA6L+hQwX81SATnWeoR/yK1wc4GMJZCdguZ2o64GmBUv7
	24LzvB5BgJwVr2IAZ8TS9n1qZvJUqktGsNLlh8qBY1zcqOAqghnlzd9wKyqkXwQ==
X-Received: by 2002:a5d:44c2:0:b0:374:cd3e:7d98 with SMTP id ffacd0b85a97d-37efcf106ddmr2013609f8f.19.1729690908051;
        Wed, 23 Oct 2024 06:41:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXPXXPAYcibfIzDBRMTHs9hPWdPNDz3Eha+UK8URGkuRSuFekIz7fNUsSwd5AIqn2zOU7BLQ==
X-Received: by 2002:a5d:44c2:0:b0:374:cd3e:7d98 with SMTP id ffacd0b85a97d-37efcf106ddmr2013576f8f.19.1729690907619;
        Wed, 23 Oct 2024 06:41:47 -0700 (PDT)
Received: from rh.fritz.box (p200300f6af01c000f92aec4042337510.dip0.t-ipconnect.de. [2003:f6:af01:c000:f92a:ec40:4233:7510])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a5882dsm8898858f8f.50.2024.10.23.06.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 06:41:47 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Parav Pandit <parav@nvidia.com>,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH v2 RESEND] net/mlx5: unique names for per device caches
Date: Wed, 23 Oct 2024 15:41:46 +0200
Message-ID: <20241023134146.28448-1-sebott@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20240920181129.37156-1-sebott@redhat.com>
References: <20240920181129.37156-1-sebott@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the device name to the per device kmem_cache names to
ensure their uniqueness. This fixes warnings like this:
"kmem_cache of name 'mlx5_fs_fgs' already exists".

Reviwed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 8505d5e241e1..c2db0a1c132b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -3689,6 +3689,7 @@ void mlx5_fs_core_free(struct mlx5_core_dev *dev)
 int mlx5_fs_core_alloc(struct mlx5_core_dev *dev)
 {
 	struct mlx5_flow_steering *steering;
+	char name[80];
 	int err = 0;
 
 	err = mlx5_init_fc_stats(dev);
@@ -3713,10 +3714,12 @@ int mlx5_fs_core_alloc(struct mlx5_core_dev *dev)
 	else
 		steering->mode = MLX5_FLOW_STEERING_MODE_DMFS;
 
-	steering->fgs_cache = kmem_cache_create("mlx5_fs_fgs",
+	snprintf(name, sizeof(name), "%s-mlx5_fs_fgs", dev_name(dev->device));
+	steering->fgs_cache = kmem_cache_create(name,
 						sizeof(struct mlx5_flow_group), 0,
 						0, NULL);
-	steering->ftes_cache = kmem_cache_create("mlx5_fs_ftes", sizeof(struct fs_fte), 0,
+	snprintf(name, sizeof(name), "%s-mlx5_fs_ftes", dev_name(dev->device));
+	steering->ftes_cache = kmem_cache_create(name, sizeof(struct fs_fte), 0,
 						 0, NULL);
 	if (!steering->ftes_cache || !steering->fgs_cache) {
 		err = -ENOMEM;
-- 
2.42.0



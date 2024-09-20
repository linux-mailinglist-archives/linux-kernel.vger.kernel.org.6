Return-Path: <linux-kernel+bounces-334415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCCE97D6F4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 16:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C04D11C224C3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 14:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF551791EB;
	Fri, 20 Sep 2024 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SqFz+oUu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C0D178396
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726842823; cv=none; b=Xp0ZifY8rgKOUmI7N9BVDVrCQY3nkiuxCQDyzFH8K49m0rJcJ5fKQqtdPbN7Zy8JEHNPE3RY2rpOoIDHtcXdAykZDudXtXt1l2Iq9NtZDCKtIQTi+czhpjLfcc1VY/HeJ1uTaG5ZJKfGiYBfSs5O7AXKnRfo5jyyNeVtp0LahKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726842823; c=relaxed/simple;
	bh=tUfgUOq49WrEDpN5pdgY6D/0Qk7FtO9dpv32vCJn3IU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BY1oITqcovNUK+9FFbKXgwGK3Ng3Wx9uUy2jq0D4Rvmsf9HGRZHnj3u8d+lFjDiJZ03z7v/5GBl25q5/5kRVsi95lUJ6oysmj0hXbBibMnkOMT8A3QAV3D9BHGhwwR5w84kbgg9+csMurxWE36+LiY2TDTmMnJ1kVt4G/9eBJOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SqFz+oUu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726842820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nh73bzW1xNMFfeehNCkHV0pz1FHPuovA0JZeAor5wJM=;
	b=SqFz+oUuxP59WkwETVhkwvKzzhlJL6XEl7007sqM4hNGq0qQrQrO2YCGTPNpGn2dCuMt3h
	F2t2uXtHYis25UoZOy83sdThy/KNY9/aPx68DgZuI7GA8fSphbA6B+vBlFMI6ySkEhhP7p
	o1SNIeGfojTlpz/0kHDr/oktt1uQhl0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-JE_RPzG_Mpab9-jKb3XwcQ-1; Fri, 20 Sep 2024 10:33:39 -0400
X-MC-Unique: JE_RPzG_Mpab9-jKb3XwcQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cb236ad4aso13764685e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 07:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726842818; x=1727447618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nh73bzW1xNMFfeehNCkHV0pz1FHPuovA0JZeAor5wJM=;
        b=d8drk/sN2Eix3+vhTb2RMu7WJp+yfaUhDsL9Q8z5aarFzyB/4CCdscjCxXND3k/hMp
         A8aciBww0GWpM67pOJLt1CqQd/Km8+vopRV9Ja6bBzWeMsMqBT9F7o2PLl8Rsq1VNDU+
         pdDlnkthonk1LCQS1RbBIMnXuifsKyQJyn+B4C6AUWNsvOURJNbe4ojBPfZ/7NXcreRC
         A3FwG13WB35XEyY1E7SJ4SHLIz4O04LwNQvqhdVC66vAEeikuaux1GnPH4cj0iHpmTVC
         3cQaUOKeASLPnhIjLA2V9vbhe0lNvAnQWIW10SJ+1A0qL2C7EfMLV+lZUsYGhX8z2utW
         tEUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZQx4vQ0lDU+efxECQpq1unQNH0qkhOvero0n3XPzCq7iaYySBPkcvihIxoK6THhXlmL8SeqQl+MOyrDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEkJd+PigKXHiiPifJYPeNeHbrAwH2L9OCwBTvNmU6PNfN5JTQ
	SlEIJApgb9n/H1jcjk7ptEWzOsrvtl6JzVbze6dIzf0KhnFeny4mSdlCyCTKbikOaEHnwdPxdLW
	V8myjGODlXsGrISaQuZ1mFm3j1Wh4YcyfA3KW/BcCFCTrRb3Vk2dwt9Vkr9a/MmY3QFK1JA==
X-Received: by 2002:a05:600c:1913:b0:42b:ac80:52ea with SMTP id 5b1f17b1804b1-42e7c15b463mr17788055e9.6.1726842817874;
        Fri, 20 Sep 2024 07:33:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEd1vVMqqhTQymkaT07xRTWXVi5ZjKJWcWsXMiOmQS35B7J37IDcfa/8i4iM26zXTYmInNzAQ==
X-Received: by 2002:a05:600c:1913:b0:42b:ac80:52ea with SMTP id 5b1f17b1804b1-42e7c15b463mr17787815e9.6.1726842817465;
        Fri, 20 Sep 2024 07:33:37 -0700 (PDT)
Received: from rh.fritz.box (p200300e16705d800cb8281343aec4007.dip0.t-ipconnect.de. [2003:e1:6705:d800:cb82:8134:3aec:4007])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e85ccsm17749784f8f.42.2024.09.20.07.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 07:33:37 -0700 (PDT)
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
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] net/mlx5: unique names for per device caches
Date: Fri, 20 Sep 2024 16:33:35 +0200
Message-ID: <20240920143335.25237-1-sebott@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the pci device name to the per device kmem_cache names
to ensure their uniqueness. This fixes warnings like this:
"kmem_cache of name 'mlx5_fs_fgs' already exists".

Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 8505d5e241e1..5d54386a5669 100644
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
+	snprintf(name, sizeof(name), "%s-mlx5_fs_fgs", pci_name(dev->pdev));
+	steering->fgs_cache = kmem_cache_create(name,
 						sizeof(struct mlx5_flow_group), 0,
 						0, NULL);
-	steering->ftes_cache = kmem_cache_create("mlx5_fs_ftes", sizeof(struct fs_fte), 0,
+	snprintf(name, sizeof(name), "%s-mlx5_fs_ftes", pci_name(dev->pdev));
+	steering->ftes_cache = kmem_cache_create(name, sizeof(struct fs_fte), 0,
 						 0, NULL);
 	if (!steering->ftes_cache || !steering->fgs_cache) {
 		err = -ENOMEM;
-- 
2.42.0



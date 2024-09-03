Return-Path: <linux-kernel+bounces-313419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E246E96A539
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 19:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0129286DDF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380611922CD;
	Tue,  3 Sep 2024 17:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivzn69SD"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9399018E77D
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 17:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725383722; cv=none; b=qvHuoeVC3/ncpH9yRWKYWcRsXT78Wvyf8i1aS5ZuN52qAL5AwcAO1OrUqNVuvEJOP+NSM0mEJHRAsJ+yTXd41AEmuk2347gsBc+vAUt0Z2D0pAhu5t7GaWi7vquCqVgAHxdziJKD+8JxYhUmVDk9rV/lW90my8E1Dl0HxFC8chE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725383722; c=relaxed/simple;
	bh=UBXaEzD6NsiHqvODjvX31vkv3EiWvvL8bQ23FaxJHds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ip64LEMERYAwRta++gZ1NuHpb4XsMrbSMP9k3H2k4BuEdl/HNVbVBCCbLdDE0Yg+8F2cZeGrCs/DoSm7KRJTwRex/KS3u3LKRmo5aukv/1xBXFRCYCcDZcFAlVyE6X31yGx7i0FYgcsx6cbZljtAmmOk2zVYxSxAvMOp6GTHJI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivzn69SD; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3df0fc40271so2917663b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 10:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725383720; x=1725988520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3qsiMSfNmjbkX2eCu5p1cSwOlsmlaRHY+Cyc4oyQRM=;
        b=ivzn69SDJvHLoMKWytubC5Wt21MbJD2h4XwImA2bWxLXVlh/09sCIYh70Tr7xsvC2I
         cJL05MdLPcpepnDyhvIrZLA2Ybi8K08s8luX/BNgorsMKcpuhOjAXqRygbJ8yHbH8dqC
         zvKiDe9Ue8ZFFW7P1qkfaDjIwAYTCulVNkUdgd1mJSqHGwIkTxA/DQMnSQTm5UnKGski
         wJtmL4o2aCESGSZKrJXvh/Kk7ZAgdXVL9LHnBpeUealAkHxH7Dxdia1j8C10piIfARrb
         WtALm4NREsYmZgC/8w5/x5Gq8QEkzv7GbEKJ18d7iMx/57X2hYaC0cKGv+PRGygC7i47
         FxCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725383720; x=1725988520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3qsiMSfNmjbkX2eCu5p1cSwOlsmlaRHY+Cyc4oyQRM=;
        b=B2bJt9AjU8nMcOVTFga+hC/vznzzc0Es3tmAlpIA9VBaGyIGXwG1xlm7v2j1Hev1PY
         9l73Bw4FHa2YGKtPrNoWFf+FqhwWN4LBUg53UQ4TtjfuqwDQze0Rre0+L//2I66OBFBN
         2llfGOiADrNHYhpSk3KbM6pylwEYHTbE47oSTsU2zIG2vk9p3mwvFbu6VghhgIGD+9zA
         q2GbY8o4NqnlWre9+x2PvGWMdIMwdhM1GUAEpmte+BgCOQzzb3K+hvK/+2EzDTvupVR3
         078n9vG4ebGRCBqrYtigGe0ZRXuCUSwJwOhExtm3LgU+oym2Vthcq9xfgUsbTYwb9108
         NU3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWt6YBrSC9NLqY4R066YRLQ4y404uZgYwUa1k2pestBP+UHN3qIO+zdL9OjezvxCIbPrAQ6zHM9vRMWxN0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4yeChxGSuYMvGx5jNZ/YOs/pNx8hGwEWbrVdrY9JvQzJQUnxP
	16sceDymCnPMU92/Up9OGqU6Gsh7sIhd7dOZ+PE+WzVDEIHIDzhR
X-Google-Smtp-Source: AGHT+IGV3rZD7KoP/5wlhFh2OPfdnNraXwEmrcwJLNm4tP3Ng+C7cF2gR3/JZeN6QHjpyybEFYbohQ==
X-Received: by 2002:a05:6808:2f0f:b0:3df:3bf8:277d with SMTP id 5614622812f47-3df3bf828d7mr11854811b6e.44.1725383719560;
        Tue, 03 Sep 2024 10:15:19 -0700 (PDT)
Received: from pipaware.tx.rr.com ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3df117a5f91sm2398059b6e.2.2024.09.03.10.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 10:15:19 -0700 (PDT)
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
To: dtatulea@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	shannon.nelson@amd.com,
	sashal@kernel.org,
	alvaro.karsz@solid-run.com,
	christophe.jaillet@wanadoo.fr,
	steven.sistare@oracle.com
Cc: bilbao@vt.edu,
	xuanzhuo@linux.alibaba.com,
	johnah.palmer@oracle.com,
	eperezma@redhat.com,
	cratiu@nvidia.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Carlos Bilbao <cbilbao@digitalocean.com>
Subject: [PATCH v2 1/2] vdpa/mlx5: Set speed and duplex of vDPA devices to UNKNOWN
Date: Tue,  3 Sep 2024 12:15:13 -0500
Message-ID: <20240903171514.201569-2-carlos.bilbao.osdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903171514.201569-1-carlos.bilbao.osdev@gmail.com>
References: <20240903171514.201569-1-carlos.bilbao.osdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carlos Bilbao <cbilbao@digitalocean.com>

Initialize the speed and duplex fields in virtio_net_config to UNKNOWN.
This is needed because mlx5_vdpa vDPA devicess currently do not support the
VIRTIO_NET_F_SPEED_DUPLEX feature which reports speed and duplex. Add
needed helper cpu_to_mlx5vdpa32() to convert endianness of speed.

Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index b56aae3f7be3..5fce6d62af4f 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -173,6 +173,11 @@ static __virtio16 cpu_to_mlx5vdpa16(struct mlx5_vdpa_dev *mvdev, u16 val)
 	return __cpu_to_virtio16(mlx5_vdpa_is_little_endian(mvdev), val);
 }
 
+static __virtio32 cpu_to_mlx5vdpa32(struct mlx5_vdpa_dev *mvdev, u32 val)
+{
+    return __cpu_to_virtio32(mlx5_vdpa_is_little_endian(mvdev), val);
+}
+
 static u16 ctrl_vq_idx(struct mlx5_vdpa_dev *mvdev)
 {
 	if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
@@ -3433,6 +3438,13 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	init_rwsem(&ndev->reslock);
 	config = &ndev->config;
 
+	/*
+	 * mlx5_vdpa vDPA devices currently don't support reporting or
+	 * setting the speed or duplex.
+	 */
+	config->speed  = cpu_to_mlx5vdpa32(mvdev, SPEED_UNKNOWN);
+	config->duplex = DUPLEX_UNKNOWN;
+
 	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) {
 		err = config_func_mtu(mdev, add_config->net.mtu);
 		if (err)
-- 
2.34.1



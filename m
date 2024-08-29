Return-Path: <linux-kernel+bounces-307292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8395E964B65
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 907F21C225B6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448461B5325;
	Thu, 29 Aug 2024 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5Kpfo7X"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063FE1B4C35
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 16:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948187; cv=none; b=jbj8R7lQL5XA3jPYdxRJCvfwSOhLoLPTev9JSRrKbcP3Nqn0VLVuF/+JlSpm3SBteYyot4Cd9aZL4xiqdbskgrMGyPNhiQCloJslzRWv1On8bHko3TdlFyE4xRwi4MM5GRlyelJZBqTMmlFRst5SBMo4+78zbqxAM17VNEOJ1N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948187; c=relaxed/simple;
	bh=Lexdeul/O21z3fM/QRb/FUqhuhZQBzxTTZt6LiYYdek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pO4uE+oxfeekUGgAPdLeL00+aKgGe6wE3HdCalgTYWgCYUTyp2ET4GmW05Jw5Dq6qKw/S6pxtO2Kz6xKa3prWKI8WV4gjzSZQYfbm+5tsX0z6SVu6eZWFoFUC4IaOnREx4pzRvTD5ULCX3bC3EGazgYxKRA+HrcHpjakjlMupIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5Kpfo7X; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3de13126957so556819b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724948184; x=1725552984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGdViJ5BehvH8g12Et4D3WrvoKpcdTG3o5SIaYUp3Vc=;
        b=G5Kpfo7XEA18D1FW6Qy5rD70hma1ctpNjTCK5L4+b1RFrokijO7A0vrNf/2MLkWbC6
         EHGECTKj1jaD1y41yrg7mToQKLttLLXwvRTlM7tiYToA5biTXOWF4meYtoXVzVSIALNT
         2WQ6fsaUxcL6eEKlD1VQvYeHE+OLvyaBVWLxUkMkJjlZ8vaKOy2o/MzzOLJKXKjogANA
         /5AY9XinHgGkIyTMgUcYe6osc481vwg47pYbuWngnGD16VJASoIOfCkAQNiNi09DjUYn
         RKQJe2V2zABClFuf3saU2ifaEpwBa5mb/TsHEUVNaVm6BVXMn5KO/YEPUgwa8c+XSYHH
         fbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724948184; x=1725552984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PGdViJ5BehvH8g12Et4D3WrvoKpcdTG3o5SIaYUp3Vc=;
        b=ICvU/W4yrGS/nhgsZC4Y+xojS8icdOgvdQqc7rF/Wf3/MeA0ULyaO/qfEyvts5zdKB
         +89aGYE8rQykh6sT8X9d+P8pK9X1oRbkaXK7t90q+hRwYKKVfcOfY4YqCwCHOWdVRRY2
         C3XWQS0W9HszOqn7XJ/tLNV985ffUagOPIncw90enqY+yYJ37HmlSpSHnEMbfI/uffvs
         q7WsvSePvu33XXIgM4c7Dx5nj2INQdcB/P1rj5P3y3Y/5UlAYKzu2CcdhfH4yop+pdXy
         /3Ok99AJTlXjGT187nUsBeR219O9BtYx9Sc40eR4Dyb/snxvMtyef3FYlUPtRTzWkXO8
         mUFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXZ4pcb3DBO1NgLIS2xIF/vbruGuR8zqcke7S7Av34yGvenubqhwu/cJxR/Ip/ai8uBrUbU6G6faZ1KwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLgM12UZoSzbxpfE9djhVmcF38vo48WI1f1A9zlG+gqvCHaFWr
	wFQSLAiZ7V/O1cxmFbbZyNsgkbbUvP1oZNNLhXNOgZwVk73Ep+DP
X-Google-Smtp-Source: AGHT+IHRef4RQmQH41SA0rzNU2CJO5fOMQsqOnIHEpMiUJo2Ry4PdkOvs3cvLm1yN9c4/3r5JgYipg==
X-Received: by 2002:a05:6808:1644:b0:3db:1cd1:cadd with SMTP id 5614622812f47-3df05d69f04mr3091164b6e.18.1724948183983;
        Thu, 29 Aug 2024 09:16:23 -0700 (PDT)
Received: from pipaware.tx.rr.com ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3df08943854sm372296b6e.45.2024.08.29.09.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 09:16:23 -0700 (PDT)
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
To: dtatulea@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com
Cc: bilbao@vt.edu,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	cratiu@nvidia.com,
	lingshan.zhu@intel.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Carlos Bilbao <cbilbao@digitalocean.com>
Subject: [PATCH 1/2] mlx5_vnet: Set speed and duplex of vDPA devices to UNKNOWN
Date: Thu, 29 Aug 2024 11:16:19 -0500
Message-ID: <20240829161620.38679-2-carlos.bilbao.osdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240829161620.38679-1-carlos.bilbao.osdev@gmail.com>
References: <20240829161620.38679-1-carlos.bilbao.osdev@gmail.com>
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
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index fa78e8288ebb..c47009a8b472 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -193,6 +193,11 @@ static __virtio16 cpu_to_mlx5vdpa16(struct mlx5_vdpa_dev *mvdev, u16 val)
 	return __cpu_to_virtio16(mlx5_vdpa_is_little_endian(mvdev), val);
 }
 
+static __virtio32 cpu_to_mlx5vdpa32(struct mlx5_vdpa_dev *mvdev, u32 val)
+{
+	return __cpu_to_virtio32(mlx5_vdpa_is_little_endian(mvdev), val);
+}
+
 static u16 ctrl_vq_idx(struct mlx5_vdpa_dev *mvdev)
 {
 	if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
@@ -3795,6 +3800,13 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
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



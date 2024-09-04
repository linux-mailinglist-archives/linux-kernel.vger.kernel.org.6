Return-Path: <linux-kernel+bounces-315390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E690996C205
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AE6D1C247A8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BAF1DEFD0;
	Wed,  4 Sep 2024 15:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxSZiuXe"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A624D1DA608
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 15:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463103; cv=none; b=crvAZ76W9+kf0tI7AM4R7f7NdVH6+jqPLZ1RT/BBny+oxgkbGD4xCeroAP4NH40GkPPVWtd/QwP5spCzjzIKiuXqhsdROQjR7+WsDS2RF6KgBV0PkMNf7jOt8z9TrFzzGf1m69w+enNhAdMn2N8QcjeYyVdntzWlbCxpXoPwLLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463103; c=relaxed/simple;
	bh=hfy/rgIIPDC5YMhAasDnsWW4tqAqTW97g74OJxZy/NE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kdakA6xkBBUMUdLIGLWwrYYw6FUABrLGYzE4y6z6UclNzET2RZMDlJRHRHkgzD29kvlZhmkdLNUzOxq2NN3YJuUhR+rhuBkpeZKJA067miUvsVkM/EqJimzyNzOhwzq2WIHK+jbjp8v8qs4zxzHzZwukU4ewN3njjIdKV5Wlv04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxSZiuXe; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7094641d4e6so2652837a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 08:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725463100; x=1726067900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1PEqwqIKP4NM5bMSR2b34sKqyNHaAPvN22LwlO+2ok=;
        b=CxSZiuXeesz50q5kAOeUxX3qG3giCavZ2QfLnacVV4/RXp8O0FEChxafbEXDaCtMil
         i3uIJzaWjqXKDw7O8djlDWDvycrGjApvHqLJW4DiXo/kCxC3EHPuOggEl/uVGBnQhq/C
         NlCg3JbXc30Mxyb015MyM6AqrjWsrDr/981rwnzWamFtIho9/qzn1AJeR1tbBz+XgueZ
         1FnnyYRkmbxIEmAGTm9cM8H6PlAF4G91r3BHy2iZdtPbJH528jKD3T+971udAX+T+f/+
         mZq1wc5BwFRtwspCIFf2cgmR3ZOQHhQ2MOD/hlQUGOiVU1X9QpldoiCCe4tda79xigfW
         bH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725463100; x=1726067900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1PEqwqIKP4NM5bMSR2b34sKqyNHaAPvN22LwlO+2ok=;
        b=wQVLfcdVW0N1AZzq2PEiV1jJsl0sM98L5CyhosbkfLAx005k27zYzxlsWGC2auTiSc
         VDZVIK8sMinz2wGMKnB2hqBuL2RPlzVUJp4aIidEERvLppBLVUkhyEXotMSL5L586j6J
         ppKTRectCInQdFJlMC++KMhJlFjXiDJPFItldBt7p6iS+MTl+iKmQPzEL8ozEjGa5eig
         9F4GKHSPmhgixtweRIpftL0m2YMCTk0w8dc/5gpKviye1JevcLMCJdan/UFbUmCFKCf8
         vap0TzEAYGZPj6qreIWFOf5Grn2T2otdpmI+51yEPmbZdGaPBCDEZoWT4NDnlYeAqaaJ
         KbWA==
X-Forwarded-Encrypted: i=1; AJvYcCXSk1IeOAHaChqgcaYyYxZ9kr/sgs89OIOibge4BQmtPT34FQIY9xKf7zincUMDc3v1xirhSS9Ae0l8ubE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9V9i1wPjueEFT4bakI+IppcimbpBdQ/MSy/eRpU1LrUBK9dT3
	/F7RPlV1iAnP8J84S0XoMz7QOTIjWIiZ0f65oQOS+N6lahRFX9bJ
X-Google-Smtp-Source: AGHT+IEJpXAOYwS2mKFK6HgoKBqnJHyNpR9had8i5M1YX72q29HtYb9hQQZPQRA7BfYu1Z/3OrUajg==
X-Received: by 2002:a05:6808:4492:b0:3d9:30a2:f8f1 with SMTP id 5614622812f47-3df1d5b90d2mr14894855b6e.8.1725463100702;
        Wed, 04 Sep 2024 08:18:20 -0700 (PDT)
Received: from pipaware.tx.rr.com ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3df117db1f2sm2831040b6e.32.2024.09.04.08.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 08:18:20 -0700 (PDT)
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
Subject: [PATCH v3 1/2] vdpa/mlx5: Set speed and duplex of vDPA devices to UNKNOWN
Date: Wed,  4 Sep 2024 10:11:14 -0500
Message-ID: <20240904151115.205622-2-carlos.bilbao.osdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240904151115.205622-1-carlos.bilbao.osdev@gmail.com>
References: <20240904151115.205622-1-carlos.bilbao.osdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carlos Bilbao <cbilbao@digitalocean.com>

Initialize the speed and duplex fields in virtio_net_config to UNKNOWN.
This is needed because mlx5_vdpa vDPA devices currently do not support the
VIRTIO_NET_F_SPEED_DUPLEX feature which reports speed and duplex. Add
needed helper cpu_to_mlx5vdpa32() to convert endianness of speed.

Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index b56aae3f7be3..41ca268d43ff 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -173,6 +173,11 @@ static __virtio16 cpu_to_mlx5vdpa16(struct mlx5_vdpa_dev *mvdev, u16 val)
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



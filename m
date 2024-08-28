Return-Path: <linux-kernel+bounces-305495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76664962F99
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAB971F225DF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94383154C19;
	Wed, 28 Aug 2024 18:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVeaB7Pu"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6933B328DB
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 18:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724868990; cv=none; b=lE+kDXfmT3VvK7jlv9HtC8rMBtoWQ7RZydRoI2ZqyPu8KvBXvGtfO5mwJZ483i+l7Wah4E0H24LucTlyE/4Cyvs9Kg21Axc4wrRA79vTCSfiClsADUl57CjomlexM3YdwA3NyH3V3uPKz1X3QuH7zsruPkM41C0xVLwWDcRiuD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724868990; c=relaxed/simple;
	bh=Q2d/0twMVi+6hXDTnHDjJ5wn1S3dmbaButW3eHNIbL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W0Okg3tO7H+gsuCS8wVcmb5CQibfrtKaftZPN0vNjcddOLr5W3EFNU0W1edkiniRGQLQQhfbLSoEK90Y5daI7KI4aT/6Km4NiNx1vafhyGHuPAfdl9I5Nxg4KSzoaRlCJ4XN0jta870XuiVNee9ZfKL+GYXUa00VF5Ohb1UxoCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVeaB7Pu; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-709428a9469so6066967a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 11:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724868988; x=1725473788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ie3C6w+Q51NXLAK9okmiUNEZZtMDP+Q0GvIW3y+N5tU=;
        b=TVeaB7PuJcN7pGu7MR2y2Ulw2AkcWih7T2zYYYIEKMuxBko3LU7Jy9//8QytC54kMQ
         aRWkaUaZ1IdFvt9I1Gh3ZHxQev3yiU2rHL7fsVm7H7YEHoDpxlZ1zH2FmkD/xz2sC94p
         bPcwsteBDLlZyrLkKKCPIEbt5H/3F1BGpyGUGiQR/w2gKCSmhJoUdsKTaUvxjxS/wKAE
         1lklcP1tSrYrvVMXcLfWrYCtPrapd0KUeD8fRweMWeXknwJd/+9n3uqzMNSTKewdUmOz
         XzbiWzbyGVAzaNwjrnnA7y54ZDyXZQJ6uwZd2xCXYmko4pFiY1qQMZAZWk5CJttNGlSQ
         0tjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724868988; x=1725473788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ie3C6w+Q51NXLAK9okmiUNEZZtMDP+Q0GvIW3y+N5tU=;
        b=EukCsjDMGQfwWxqSEqF9oqwL0o7FzaR1/TS0W/Pj9aq/OYaK8ZOb1c8DoXWQRzU1rl
         FHbVeJF6ptyWZ8xh8vOFHP1imIek6zNOiX1aGAplplhMDSxs0OjRcEHPp0dbeqV0/gla
         OtRRNrK+27wFmavndNnEEbeewHEpBNWSFfC3gdV+Qtk1q21HH/Rq+ecaWAl7cpS78XWH
         E23n0n8u7rK7X/GDwx45Q1Or4ZcHn0UFAGo/970lWmQrHWIyD9SG+VIfphlzUli/bT8B
         3x9J9+I+KIIyweREFcHPsXdKfz5N73hURU4FKaf/G/RfRuOpOwYyMLvQY/M5tb0hIzW7
         1Cyg==
X-Forwarded-Encrypted: i=1; AJvYcCUJ98hYOx6weewbgDsTKlbzOw1yG+qeZ41LHAg7UdG4h+8FBzroRyeEML8gBJmoiJ1GlQAvbAVSYE6yMHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX5kMp02ir9SiT01cqt4KMNbEGKRPln2QyQyjmbQea38r+YZm8
	eKFguhnBhmMEUgTS2+duLIfn/648W1bMn1IV9kJi/dXfTMLcJmV5Xae9Aw==
X-Google-Smtp-Source: AGHT+IEFJEhZXQy4V/sd4/Xh0ag9Z4Tn+CasH+w6KcdsTImAxV876emN4Ud8Cb4Sihp5uXIQPNv4Tg==
X-Received: by 2002:a05:6830:2702:b0:703:5c3d:e3f3 with SMTP id 46e09a7af769-70f5c3deac3mr426517a34.14.1724868988527;
        Wed, 28 Aug 2024 11:16:28 -0700 (PDT)
Received: from pipaware.tx.rr.com ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70e03b882f5sm2996345a34.67.2024.08.28.11.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 11:16:27 -0700 (PDT)
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
Subject: [PATCH] vdpa: Set speed and duplex of mlx5_vnet to UNKNOWN
Date: Wed, 28 Aug 2024 13:16:25 -0500
Message-ID: <20240828181625.7831-1-carlos.bilbao.osdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carlos Bilbao <cbilbao@digitalocean.com>

mlx5_vdpa vDPA devices currently don't support reporting or setting the
speed and duplex and hence should be UNKNOWN instead of zero.

Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c |  7 +++++++
 drivers/vdpa/vdpa.c               | 23 +++++++++++++++++++++++
 include/uapi/linux/vdpa.h         |  2 ++
 3 files changed, 32 insertions(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index fa78e8288ebb..319f5c6121de 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -3795,6 +3795,13 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	init_rwsem(&ndev->reslock);
 	config = &ndev->config;
 
+	/*
+	 * mlx5_vdpa vDPA devices currently don't support reporting or
+	 * setting the speed or duplex.
+	 */
+	config->speed  = SPEED_UNKNOWN;
+	config->duplex = DUPLEX_UNKNOWN;
+
 	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) {
 		err = config_func_mtu(mdev, add_config->net.mtu);
 		if (err)
diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 4dbd2e55a288..abde23e0041d 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -15,6 +15,7 @@
 #include <net/genetlink.h>
 #include <linux/mod_devicetable.h>
 #include <linux/virtio_ids.h>
+#include <uapi/linux/ethtool.h>
 
 static LIST_HEAD(mdev_head);
 /* A global mutex that protects vdpa management device and device level operations. */
@@ -919,6 +920,22 @@ static int vdpa_dev_net_status_config_fill(struct sk_buff *msg, u64 features,
 	return nla_put_u16(msg, VDPA_ATTR_DEV_NET_STATUS, val_u16);
 }
 
+static int vdpa_dev_net_speed_config_fill(struct sk_buff *msg, u64 features,
+					struct virtio_net_config *config)
+{
+	__le32 speed = cpu_to_le32(SPEED_UNKNOWN);
+
+	return nla_put(msg, VDPA_ATTR_DEV_NET_CFG_SPEED, sizeof(speed), &speed);
+}
+
+static int vdpa_dev_net_duplex_config_fill(struct sk_buff *msg, u64 features,
+					struct virtio_net_config *config)
+{
+	u8 duplex = DUPLEX_UNKNOWN;
+
+	return nla_put(msg, VDPA_ATTR_DEV_NET_CFG_DUPLEX, sizeof(duplex), &duplex);
+}
+
 static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *msg)
 {
 	struct virtio_net_config config = {};
@@ -941,6 +958,12 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
 	if (vdpa_dev_net_status_config_fill(msg, features_device, &config))
 		return -EMSGSIZE;
 
+	if (vdpa_dev_net_speed_config_fill(msg, features_device, &config))
+		return -EMSGSIZE;
+
+	if (vdpa_dev_net_duplex_config_fill(msg, features_device, &config))
+		return -EMSGSIZE;
+
 	return vdpa_dev_net_mq_config_fill(msg, features_device, &config);
 }
 
diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
index 842bf1201ac4..1c64ee0dd7b1 100644
--- a/include/uapi/linux/vdpa.h
+++ b/include/uapi/linux/vdpa.h
@@ -43,6 +43,8 @@ enum vdpa_attr {
 	VDPA_ATTR_DEV_NET_STATUS,		/* u8 */
 	VDPA_ATTR_DEV_NET_CFG_MAX_VQP,		/* u16 */
 	VDPA_ATTR_DEV_NET_CFG_MTU,		/* u16 */
+	VDPA_ATTR_DEV_NET_CFG_SPEED,		/* u32 */
+	VDPA_ATTR_DEV_NET_CFG_DUPLEX,		/* u8 */
 
 	VDPA_ATTR_DEV_NEGOTIATED_FEATURES,	/* u64 */
 	VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,		/* u32 */
-- 
2.34.1



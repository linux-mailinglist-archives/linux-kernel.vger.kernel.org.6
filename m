Return-Path: <linux-kernel+bounces-437892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0969E9A31
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FFEA188777B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6305F1BEF9B;
	Mon,  9 Dec 2024 15:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="N/vyps5P"
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C881B423A
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 15:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733757398; cv=none; b=h1S/zR3amVMDaJUaaBvbF3MRgGd35b0TM9d2N0I/9Vzs/13LHKHSXPE3yNkXJZalTRfffpf9ntfwEQek3aVDEGwIByOfqcEmjHGcv0tCMoIyOtA67uQI2iZJRhkFkjlL4bGMgCrRE3kAS6DWkCaBhZ8oQBM72bXHGjn2MVX3FZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733757398; c=relaxed/simple;
	bh=dCVh9WBvh9EkyZb2743y5egLYj8nOjEe+aHvIt9mgXY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YtvMgEWf+hxKGuMQDvPcFawEOe31aA7Zo7yNVcvJ4QyABM7VLKxyMcnkaWNK5cEYvxjbvq3U3rNIAraW1MYsdj3o9Ln8cWkuLsMPCethlYPLDf4jfH8zvFKgyhuv9IwbWHkwlv8GR0EylUZOiJQu8dfKkTHvtmsveeaoXWuwMzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=N/vyps5P; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9AUu1R008516;
	Mon, 9 Dec 2024 07:16:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=o
	RvMgCApv96FqeBhbUMF4ozwHnfOKaHC2bHCrqSq1Bc=; b=N/vyps5PXqCiJkvBG
	m/TBjwKpsAPcqiBsmWTVsCa/WCA9CCS76TdgUcN6HcsDAfJCGg7JRcEzZxx8VCey
	k8x2hANeISig2VrDE2eojvKE/k8Jw/RyvkfLOl+8990R7hZ7o/6uSw3aCk2yCUyF
	rj3O1u62CFcGUyeaWPB9ub7ehq7vJDqyHfJpZcEhyVNsyfNA3Rtd+Fj9vwF840ug
	fmnUcQvSm7UN9RmpakyGh/4MIPseuwziB+c7jvxgyCSMJV2V/gU4fUC1gjuMyAL8
	/5gjE8vJ7IaGPf4maT7XkoRas0iqRt5lC1q5Aqv7hidDC3lGcE337zI6V51x+yER
	IZZAQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 43dxv4gk5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 07:16:25 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 9 Dec 2024 07:16:24 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 9 Dec 2024 07:16:24 -0800
Received: from localhost.localdomain (unknown [10.28.34.29])
	by maili.marvell.com (Postfix) with ESMTP id A2A055B693E;
	Mon,  9 Dec 2024 07:16:20 -0800 (PST)
From: Shijith Thotton <sthotton@marvell.com>
To: <virtualization@lists.linux.dev>, <mst@redhat.com>, <jasowang@redhat.com>,
        <dan.carpenter@linaro.org>
CC: Shijith Thotton <sthotton@marvell.com>, <schalla@marvell.com>,
        <vattunuru@marvell.com>, <ndabilpuram@marvell.com>,
        <jerinj@marvell.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>,
        Satha Rao <skoteshwar@marvell.com>,
        open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 4/4] vdpa/octeon_ep: read vendor-specific PCI capability
Date: Mon, 9 Dec 2024 20:42:16 +0530
Message-ID: <20241209151427.3720026-4-sthotton@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241209151427.3720026-1-sthotton@marvell.com>
References: <20241209151427.3720026-1-sthotton@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: q3V8E93ACOeZFCAB6SrtNBK_6TdZXG_a
X-Proofpoint-ORIG-GUID: q3V8E93ACOeZFCAB6SrtNBK_6TdZXG_a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Added support to read the vendor-specific PCI capability to identify the
type of device being emulated.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Shijith Thotton <sthotton@marvell.com>
---
 drivers/vdpa/octeon_ep/octep_vdpa.h      | 20 ++++++++++++++
 drivers/vdpa/octeon_ep/octep_vdpa_hw.c   | 33 +++++++++++++++++++++++-
 drivers/vdpa/octeon_ep/octep_vdpa_main.c |  4 ++-
 3 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/octeon_ep/octep_vdpa.h b/drivers/vdpa/octeon_ep/octep_vdpa.h
index 2cadb878e679..53b020b019f7 100644
--- a/drivers/vdpa/octeon_ep/octep_vdpa.h
+++ b/drivers/vdpa/octeon_ep/octep_vdpa.h
@@ -8,6 +8,7 @@
 #include <linux/pci_regs.h>
 #include <linux/vdpa.h>
 #include <linux/virtio_pci_modern.h>
+#include <uapi/linux/virtio_crypto.h>
 #include <uapi/linux/virtio_net.h>
 #include <uapi/linux/virtio_blk.h>
 #include <uapi/linux/virtio_config.h>
@@ -52,6 +53,24 @@ struct octep_vring_info {
 	phys_addr_t notify_pa;
 };
 
+enum octep_pci_vndr_cfg_type {
+	OCTEP_PCI_VNDR_CFG_TYPE_VIRTIO_ID,
+	OCTEP_PCI_VNDR_CFG_TYPE_MAX,
+};
+
+struct octep_pci_vndr_data {
+	struct virtio_pci_vndr_data hdr;
+	u8 id;
+	u8 bar;
+	union {
+		u64 data;
+		struct {
+			u32 offset;
+			u32 length;
+		};
+	};
+};
+
 struct octep_hw {
 	struct pci_dev *pdev;
 	u8 __iomem *base[PCI_STD_NUM_BARS];
@@ -69,6 +88,7 @@ struct octep_hw {
 	u32 config_size;
 	int nb_irqs;
 	int *irqs;
+	u8 dev_id;
 };
 
 u8 octep_hw_get_status(struct octep_hw *oct_hw);
diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_hw.c b/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
index d5a599f87e18..b932f5da511e 100644
--- a/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
+++ b/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
@@ -358,7 +358,14 @@ u16 octep_get_vq_size(struct octep_hw *oct_hw)
 
 static u32 octep_get_config_size(struct octep_hw *oct_hw)
 {
-	return sizeof(struct virtio_net_config);
+	switch (oct_hw->dev_id) {
+	case VIRTIO_ID_NET:
+		return sizeof(struct virtio_net_config);
+	case VIRTIO_ID_CRYPTO:
+		return sizeof(struct virtio_crypto_config);
+	default:
+		return 0;
+	}
 }
 
 static void __iomem *octep_get_cap_addr(struct octep_hw *oct_hw, struct virtio_pci_cap *cap)
@@ -416,8 +423,23 @@ static int octep_pci_signature_verify(struct octep_hw *oct_hw)
 	return 0;
 }
 
+static void octep_vndr_data_process(struct octep_hw *oct_hw,
+				    struct octep_pci_vndr_data *vndr_data)
+{
+	switch (vndr_data->id) {
+	case OCTEP_PCI_VNDR_CFG_TYPE_VIRTIO_ID:
+		oct_hw->dev_id = (u8)vndr_data->data;
+		break;
+	default:
+		dev_err(&oct_hw->pdev->dev, "Invalid vendor data id %u\n",
+			vndr_data->id);
+		break;
+	}
+}
+
 int octep_hw_caps_read(struct octep_hw *oct_hw, struct pci_dev *pdev)
 {
+	struct octep_pci_vndr_data vndr_data;
 	struct octep_mbox __iomem *mbox;
 	struct device *dev = &pdev->dev;
 	struct virtio_pci_cap cap;
@@ -466,6 +488,15 @@ int octep_hw_caps_read(struct octep_hw *oct_hw, struct pci_dev *pdev)
 		case VIRTIO_PCI_CAP_ISR_CFG:
 			oct_hw->isr = octep_get_cap_addr(oct_hw, &cap);
 			break;
+		case VIRTIO_PCI_CAP_VENDOR_CFG:
+			octep_pci_caps_read(oct_hw, &vndr_data, sizeof(vndr_data), pos);
+			if (vndr_data.hdr.vendor_id != PCI_VENDOR_ID_CAVIUM) {
+				dev_err(dev, "Invalid vendor data\n");
+				return -EINVAL;
+			}
+
+			octep_vndr_data_process(oct_hw, &vndr_data);
+			break;
 		}
 
 		pos = cap.cap_next;
diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
index 4d56be64ae56..f3d4dda4e04c 100644
--- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
+++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
@@ -302,7 +302,9 @@ static u32 octep_vdpa_get_generation(struct vdpa_device *vdpa_dev)
 
 static u32 octep_vdpa_get_device_id(struct vdpa_device *vdpa_dev)
 {
-	return VIRTIO_ID_NET;
+	struct octep_hw *oct_hw = vdpa_to_octep_hw(vdpa_dev);
+
+	return oct_hw->dev_id;
 }
 
 static u32 octep_vdpa_get_vendor_id(struct vdpa_device *vdpa_dev)
-- 
2.25.1



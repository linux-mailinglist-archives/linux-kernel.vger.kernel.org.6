Return-Path: <linux-kernel+bounces-191034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CD38D0718
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8D2FB23150
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866B816C865;
	Mon, 27 May 2024 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b="wE+8G3F8"
Received: from mail02.habana.ai (habanamailrelay.habana.ai [213.57.90.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE34B16C6B8
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.57.90.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716822161; cv=none; b=S2SvgWcyVGAF6OR+fS3qIwX/bDhlAnDo6EbtZdlPNHpxfQY8aBAiQuvdoJd+XLIjuzx5UFhA6j7ZrCli4Ejdq5q6s0/vqP5oaozXO2uJDgcbVJOPPZgj9k4Mj5rzK2BPIjGQQ4V5jjWpprNQA4rlzcZuK6ESh8UscIO1QvQGUhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716822161; c=relaxed/simple;
	bh=3jyCp5WLB1q5U7lpJgv1v9IMLy+ia/ewwngv2+8knpU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W/nwiGexo+zWuVfLZ5Ib42/HqTTUoTcvzP8HdWI6JVxu7YamwWkzY4HBPKvWIffY24bKZM+XjIPVE+3lbjteqjmPVjRouLicPG7Td5P2FjmEi2iZWDythiJAQJUi66tMI+p7CaktuVPfs86E6FSYogUNoSg96JPPIBu50KyQYDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai; spf=pass smtp.mailfrom=habana.ai; dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b=wE+8G3F8; arc=none smtp.client-ip=213.57.90.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=habana.ai
Received: internal info suppressed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=habana.ai; s=default;
	t=1716822162; bh=3jyCp5WLB1q5U7lpJgv1v9IMLy+ia/ewwngv2+8knpU=;
	h=From:To:Cc:Subject:Date:From;
	b=wE+8G3F8xZhEjg6kH22qMDN3MEFKr8Pk6Bj1OL35JC0o3D7iALI5f+08xCynp2mpH
	 H2IDQPmlIbUQn+LZUEdEijMPYp1DxJ4uKwvSSEFJy1H8RGc7HX854Vgeiw6THliiB9
	 HImm4tWADWZXJgu36e/3AabyvbJCzWMLM0VohGvW20HoBeZwLnVbQuzhxBfsIOQxlO
	 KyQrNcWLuFQjczrxN4obEO6yL0AbV0eu+7zCqiAn0sAkKbqQYXRzO9Rb9Pug+/M2Ip
	 uen92lMw0WK/cGF11MNyJheccJTqPkdmvz5BEw8p4cDwHF0Ab1XPehknIhKMLFKNZj
	 T2YtUyfF17FZQ==
Received: from obitton-vm-u22.habana-labs.com (localhost [127.0.0.1])
	by obitton-vm-u22.habana-labs.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 44RF2PiS1954007;
	Mon, 27 May 2024 18:02:25 +0300
From: Ofir Bitton <obitton@habana.ai>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Farah Kassabri <fkassabri@habana.ai>
Subject: [PATCH 1/8] accel/habanalabs/gaudi2: add GAUDI2D revision support
Date: Mon, 27 May 2024 18:02:17 +0300
Message-Id: <20240527150224.1953969-1-obitton@habana.ai>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Farah Kassabri <fkassabri@habana.ai>

Gaudi2 with PCI revision ID with the value of '4' represents Gaudi2D
device and should be detected and initialized as Gaudi2.

Signed-off-by: Farah Kassabri <fkassabri@habana.ai>
Reviewed-by: Ofir Bitton <obitton@habana.ai>
---
 drivers/accel/habanalabs/common/device.c                 | 4 ++++
 drivers/accel/habanalabs/common/habanalabs.h             | 3 +++
 drivers/accel/habanalabs/common/habanalabs_drv.c         | 3 +++
 drivers/accel/habanalabs/common/mmu/mmu.c                | 1 +
 drivers/accel/habanalabs/common/sysfs.c                  | 3 +++
 drivers/accel/habanalabs/include/hw_ip/pci/pci_general.h | 3 ++-
 6 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index f9b8601c4396..fd117489a05a 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -862,6 +862,10 @@ static int device_early_init(struct hl_device *hdev)
 		gaudi2_set_asic_funcs(hdev);
 		strscpy(hdev->asic_name, "GAUDI2C", sizeof(hdev->asic_name));
 		break;
+	case ASIC_GAUDI2D:
+		gaudi2_set_asic_funcs(hdev);
+		strscpy(hdev->asic_name, "GAUDI2D", sizeof(hdev->asic_name));
+		break;
 	default:
 		dev_err(hdev->dev, "Unrecognized ASIC type %d\n",
 			hdev->asic_type);
diff --git a/drivers/accel/habanalabs/common/habanalabs.h b/drivers/accel/habanalabs/common/habanalabs.h
index 057087dc8592..0d16b5310add 100644
--- a/drivers/accel/habanalabs/common/habanalabs.h
+++ b/drivers/accel/habanalabs/common/habanalabs.h
@@ -1273,15 +1273,18 @@ struct hl_dec {
  * @ASIC_GAUDI2: Gaudi2 device.
  * @ASIC_GAUDI2B: Gaudi2B device.
  * @ASIC_GAUDI2C: Gaudi2C device.
+ * @ASIC_GAUDI2D: Gaudi2D device.
  */
 enum hl_asic_type {
 	ASIC_INVALID,
+
 	ASIC_GOYA,
 	ASIC_GAUDI,
 	ASIC_GAUDI_SEC,
 	ASIC_GAUDI2,
 	ASIC_GAUDI2B,
 	ASIC_GAUDI2C,
+	ASIC_GAUDI2D,
 };
 
 struct hl_cs_parser;
diff --git a/drivers/accel/habanalabs/common/habanalabs_drv.c b/drivers/accel/habanalabs/common/habanalabs_drv.c
index e542fd40e16c..b1613a82c7f2 100644
--- a/drivers/accel/habanalabs/common/habanalabs_drv.c
+++ b/drivers/accel/habanalabs/common/habanalabs_drv.c
@@ -144,6 +144,9 @@ static enum hl_asic_type get_asic_type(struct hl_device *hdev)
 		case REV_ID_C:
 			asic_type = ASIC_GAUDI2C;
 			break;
+		case REV_ID_D:
+			asic_type = ASIC_GAUDI2D;
+			break;
 		default:
 			break;
 		}
diff --git a/drivers/accel/habanalabs/common/mmu/mmu.c b/drivers/accel/habanalabs/common/mmu/mmu.c
index a9813ffcde14..79823facce7f 100644
--- a/drivers/accel/habanalabs/common/mmu/mmu.c
+++ b/drivers/accel/habanalabs/common/mmu/mmu.c
@@ -600,6 +600,7 @@ int hl_mmu_if_set_funcs(struct hl_device *hdev)
 	case ASIC_GAUDI2:
 	case ASIC_GAUDI2B:
 	case ASIC_GAUDI2C:
+	case ASIC_GAUDI2D:
 		hl_mmu_v2_set_funcs(hdev, &hdev->mmu_func[MMU_DR_PGT]);
 		if (prop->pmmu.host_resident)
 			hl_mmu_v2_hr_set_funcs(hdev, &hdev->mmu_func[MMU_HR_PGT]);
diff --git a/drivers/accel/habanalabs/common/sysfs.c b/drivers/accel/habanalabs/common/sysfs.c
index 8a9f98832157..b6c63f8a0c1b 100644
--- a/drivers/accel/habanalabs/common/sysfs.c
+++ b/drivers/accel/habanalabs/common/sysfs.c
@@ -270,6 +270,9 @@ static ssize_t device_type_show(struct device *dev,
 	case ASIC_GAUDI2C:
 		str = "GAUDI2C";
 		break;
+	case ASIC_GAUDI2D:
+		str = "GAUDI2D";
+		break;
 	default:
 		dev_err(hdev->dev, "Unrecognized ASIC type %d\n",
 				hdev->asic_type);
diff --git a/drivers/accel/habanalabs/include/hw_ip/pci/pci_general.h b/drivers/accel/habanalabs/include/hw_ip/pci/pci_general.h
index 4f951cada077..a75faa00197f 100644
--- a/drivers/accel/habanalabs/include/hw_ip/pci/pci_general.h
+++ b/drivers/accel/habanalabs/include/hw_ip/pci/pci_general.h
@@ -25,7 +25,8 @@ enum hl_revision_id {
 	REV_ID_INVALID				= 0x00,
 	REV_ID_A				= 0x01,
 	REV_ID_B				= 0x02,
-	REV_ID_C				= 0x03
+	REV_ID_C				= 0x03,
+	REV_ID_D				= 0x04
 };
 
 #endif /* INCLUDE_PCI_GENERAL_H_ */
-- 
2.34.1



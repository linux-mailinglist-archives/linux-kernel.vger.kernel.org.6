Return-Path: <linux-kernel+bounces-552541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E14A57AF7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 15:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A5A3B1EEB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 14:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6578F1D89F1;
	Sat,  8 Mar 2025 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjI86XEx"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A302182BD
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 14:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741443077; cv=none; b=MXboIeXXkNoEmFWbrpKO3DNmIU0hyy4kMFkqcr94nyIAaQrOsf5i6FO6A8zA+wFzf7TevS0hnTDoPoPQoeTe2aRcBZNvwnr54INaQAX15porAEP1Hg9d6umSG7LnrMpLIJJapkKC7X6pVD5SyXumP0fVM+60liBYhvgNwb6o/kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741443077; c=relaxed/simple;
	bh=AeqC1dN11eeIjGYgnhyzRd3tRwMI3HGUsYDrAiLW9sE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G2cvsp6cwD5+qHVFYCDigbw0SyN2eC9a3ReCbps4ifBfRUR5i5WZQXK6luaIbCug+gXhDr5piHXNJiR8OEYhA9ukdfh7E+mwh7xve9GPw1ZILad/+4mkEnCjRRTZvy7P8LVqZ/xWMiEGbSZKX0BihW1cHnGvf1SFz3tFMpoNuAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjI86XEx; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ff7255b8c6so629791a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 06:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741443074; x=1742047874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J10QeskcT12v/UsxJ7EeUY65TUXqux1i/qCJaeu/e6Q=;
        b=HjI86XExWYiTYtM9Yxa8M5jnUAieu9tuk0L5BlDMNRyLrB97gufWRg8oMiUhFAdk1p
         uG5C5D55md5BzFdnzvsH+BrMbsUp8ss/AK5IOF1gp/LrdcB+56GLVklrfVa6foZD74iY
         2qnjkuQiMYcRPPkcW2/vTizrNKQVjC8n/HRuqRHKkcG4wcatugCp8wnRIU9lqJoGU6vg
         iB9op1Dn/CHrortHxMAsu+2F8SfH0dHGbVQvQ+gvJ8+sR3NoaUol/u38uoX9f7Xk21Zt
         e2hx7oYVKVDzB5snEfZWFdxJVuYDF/DcTGuliTzuJ6uloexKuiTbG7AXSLYf9cKN5UZB
         N5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741443074; x=1742047874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J10QeskcT12v/UsxJ7EeUY65TUXqux1i/qCJaeu/e6Q=;
        b=obzD3Ro0NqiytxVUTMt3+xpxvD1v/l3ycpwOHzIjjzxjJTsiJHjJF01zPRLbte4Wgt
         oDP2CjcjVBwuYefkX4qQkX1ZvHF1qzylXsyGjtUebz28ftREeYT88SfL9KxOKDCPglGV
         akyUyVwN0Qyuc0yXF61YXwfDWhyVyH1VqndhqpdpgbZmBpDrj+DkDcvmmMdMIEVLLM8N
         v3Gaiin6bDT9gD2RxEvnYQ4xEi8i133Xkuq7ESo5iRyVbAqlS9AnQKMf3bVq27b4FtaB
         dvUaW9t8AndSDjTnkuG+QUm621M2KStn+XnCzDy3LY1WpuYR/Wsoz+QgP40j4HSMe9Kt
         MXaw==
X-Forwarded-Encrypted: i=1; AJvYcCVeotlgI+QlCsCUZn/Tz0dqdjx+9QwSdDq+5uOFBGd2t8KC1/QWaDbWZ4dDuqLLhhXh+sGJbfuJ6Zpc1wI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9gIXTpcWQhXOkszvmlBk+Si0GmHFYscfecnvN02jktA1W38NH
	i9s7Y3MaqVntpcxyU9n3m4wxcS+Z/OEnSdInQU8O7Ddb70C4NuWtPhlRCE9k7m8=
X-Gm-Gg: ASbGncvLWsuaw/WWLMCjETp77+m1fDHCDe7tJBRu8UV/sD4lck0awKw2KQbSupIgMLr
	LeV6Sfx5taMbIXZvgzSMuYcWVk+PV7Z9BTbZ/p3LGXyA6qCakuYsXLtoWxsgUqoOFOEHR74CxKw
	otz+IZcdq0Yq0bXuebCkC+c/a5AidL39f3/zbrYocPb4TvQHOEPCfmg3a4t8uhmH/Rcb0G6tJEc
	OXY60u8lEMecLV5HnRZENprsyc0WHkJULo3S794Fd1YvZEKta4/mhYO8/pi4NJlnBDcOy6FnBR8
	PPQOrY7ejY4FDJbHhHLKx7vU6mxyXx+mmiTshYTgTdQXix6lk9KCFL6tNgW38RGDHn6WbA==
X-Google-Smtp-Source: AGHT+IHqBRpCNb80mXfZUuRQWsM9GihdP0zcIfVkkOqy7vCFy0maAPK3KAGzt53Ys1ENCYGGMsrzRQ==
X-Received: by 2002:a05:6a00:2e97:b0:730:915c:b77 with SMTP id d2e1a72fcca58-736becaf415mr1616500b3a.1.1741443074169;
        Sat, 08 Mar 2025 06:11:14 -0800 (PST)
Received: from MGG23TF6W0.corp.ebay.com ([202.76.247.146])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-736c11ba2cfsm1193034b3a.122.2025.03.08.06.11.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 08 Mar 2025 06:11:13 -0800 (PST)
From: Jianlin Lv <iecedge@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jianlv@ebay.com,
	iecedge@gmail.com
Subject: [PATCH] nvme-pci: Remove NVME_QUIRK_BOGUS_NID for device vendors
Date: Sat,  8 Mar 2025 22:11:02 +0800
Message-Id: <20250308141102.34101-1-iecedge@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit ac522fc6c316 ("nvme: don't reject probe due to duplicate IDs
for single-ported PCIe devices") merged, vendors no longer need to use
quirks in the PCI ID entry to work around the issue of duplicate IDs.
The NVME_QUIRK_BOGUS_NID flag changes the format of device attribute file
names under /dev/disk/by-id/.
For example, /dev/disk/by-id/nvme-eui.xxx -> /dev/disk/by-id/nvme-nvme.xxx.

Considering that naming formats need to have high stability and
recognizability, it is more prudent to make changes only for rare,
sporadic cases rather than implementing comprehensive changes. Therefore,
this patch remove default setting of NVME_QUIRK_BOGUS_NID flag for vendors,
and the flag is added dynamically only when duplicate IDs is detected,
as implemented in ac522fc6c3165f.

Signed-off-by: Jianlin Lv <iecedge@gmail.com>
---
 drivers/nvme/host/pci.c | 63 +++++------------------------------------
 1 file changed, 7 insertions(+), 56 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 640590b21728..9ae73224d4d7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3592,8 +3592,7 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_DEALLOCATE_ZEROES, },
 	{ PCI_VDEVICE(INTEL, 0x0a54),	/* Intel P4500/P4600 */
 		.driver_data = NVME_QUIRK_STRIPE_SIZE |
-				NVME_QUIRK_IGNORE_DEV_SUBNQN |
-				NVME_QUIRK_BOGUS_NID, },
+				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_VDEVICE(INTEL, 0x0a55),	/* Dell Express Flash P4600 */
 		.driver_data = NVME_QUIRK_STRIPE_SIZE, },
 	{ PCI_VDEVICE(INTEL, 0xf1a5),	/* Intel 600P/P3100 */
@@ -3612,11 +3611,9 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(0x1217, 0x8760), /* O2 Micro 64GB Steam Deck */
 		.driver_data = NVME_QUIRK_DMAPOOL_ALIGN_512, },
 	{ PCI_DEVICE(0x126f, 0x2262),	/* Silicon Motion generic */
-		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
-				NVME_QUIRK_BOGUS_NID, },
+		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0x126f, 0x2263),	/* Silicon Motion unidentified */
-		.driver_data = NVME_QUIRK_NO_NS_DESC_LIST |
-				NVME_QUIRK_BOGUS_NID, },
+		.driver_data = NVME_QUIRK_NO_NS_DESC_LIST, },
 	{ PCI_DEVICE(0x1bb1, 0x0100),   /* Seagate Nytro Flash Storage */
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY |
 				NVME_QUIRK_NO_NS_DESC_LIST, },
@@ -3634,11 +3631,8 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x15b7, 0x5008),   /* Sandisk SN530 */
 		.driver_data = NVME_QUIRK_BROKEN_MSI },
-	{ PCI_DEVICE(0x1987, 0x5012),	/* Phison E12 */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1987, 0x5016),	/* Phison E16 */
-		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN |
-				NVME_QUIRK_BOGUS_NID, },
+		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x1987, 0x5019),  /* phison E19 */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1987, 0x5021),   /* Phison E21 */
@@ -3646,24 +3640,15 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(0x1b4b, 0x1092),	/* Lexar 256 GB SSD */
 		.driver_data = NVME_QUIRK_NO_NS_DESC_LIST |
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
-	{ PCI_DEVICE(0x1cc1, 0x33f8),   /* ADATA IM2P33F8ABR1 1 TB */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x10ec, 0x5762),   /* ADATA SX6000LNP */
-		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN |
-				NVME_QUIRK_BOGUS_NID, },
-	{ PCI_DEVICE(0x10ec, 0x5763),  /* ADATA SX6000PNP */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
+		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x1cc1, 0x8201),   /* ADATA SX8200PNP 512GB */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	 { PCI_DEVICE(0x1344, 0x5407), /* Micron Technology Inc NVMe SSD */
 		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN },
-	 { PCI_DEVICE(0x1344, 0x6001),   /* Micron Nitro NVMe */
-		 .driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1c5c, 0x1504),   /* SK Hynix PC400 */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
-	{ PCI_DEVICE(0x1c5c, 0x174a),   /* SK Hynix P31 SSD */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1c5c, 0x1D59),   /* SK Hynix BC901 */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x15b7, 0x2001),   /*  Sandisk Skyhawk */
@@ -3671,12 +3656,9 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(0x1d97, 0x2263),   /* SPCC */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x144d, 0xa80b),   /* Samsung PM9B1 256G and 512G */
-		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES |
-				NVME_QUIRK_BOGUS_NID, },
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x144d, 0xa809),   /* Samsung MZALQ256HBJD 256G */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
-	{ PCI_DEVICE(0x144d, 0xa802),   /* Samsung SM953 */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1cc4, 0x6303),   /* UMIS RPJTJ512MGE1QDY 512G */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1cc4, 0x6302),   /* UMIS RPJTJ256MGE1QDY 256G */
@@ -3697,43 +3679,12 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x2646, 0x501E),   /* KINGSTON OM3PGP4xxxxQ OS21011 NVMe SSD */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
-	{ PCI_DEVICE(0x1f40, 0x1202),   /* Netac Technologies Co. NV3000 NVMe SSD */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
-	{ PCI_DEVICE(0x1f40, 0x5236),   /* Netac Technologies Co. NV7000 NVMe SSD */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
-	{ PCI_DEVICE(0x1e4B, 0x1001),   /* MAXIO MAP1001 */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
-	{ PCI_DEVICE(0x1e4B, 0x1002),   /* MAXIO MAP1002 */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
-	{ PCI_DEVICE(0x1e4B, 0x1202),   /* MAXIO MAP1202 */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
-	{ PCI_DEVICE(0x1e4B, 0x1602),   /* MAXIO MAP1602 */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
-	{ PCI_DEVICE(0x1cc1, 0x5350),   /* ADATA XPG GAMMIX S50 */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
-	{ PCI_DEVICE(0x1dbe, 0x5216),   /* Acer/INNOGRIT FA100/5216 NVMe SSD */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
-	{ PCI_DEVICE(0x1dbe, 0x5236),   /* ADATA XPG GAMMIX S70 */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1e49, 0x0021),   /* ZHITAI TiPro5000 NVMe SSD */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0x1e49, 0x0041),   /* ZHITAI TiPro7000 NVMe SSD */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
-	{ PCI_DEVICE(0xc0a9, 0x540a),   /* Crucial P2 */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
-	{ PCI_DEVICE(0x1d97, 0x2263), /* Lexar NM610 */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
-	{ PCI_DEVICE(0x1d97, 0x1d97), /* Lexar NM620 */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1d97, 0x2269), /* Lexar NM760 */
-		.driver_data = NVME_QUIRK_BOGUS_NID |
-				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
-	{ PCI_DEVICE(0x10ec, 0x5763), /* TEAMGROUP T-FORCE CARDEA ZERO Z330 SSD */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
-	{ PCI_DEVICE(0x1e4b, 0x1602), /* HS-SSD-FUTURE 2048G  */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
-	{ PCI_DEVICE(0x10ec, 0x5765), /* TEAMGROUP MP33 2TB SSD */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
+		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0061),
 		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0065),
-- 
2.34.1



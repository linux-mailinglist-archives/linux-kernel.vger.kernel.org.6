Return-Path: <linux-kernel+bounces-515440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CAFA364D7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72F5817203D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CF22698B3;
	Fri, 14 Feb 2025 17:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gQpuV36v"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE632690F7
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554816; cv=none; b=kmcNkt6VAfrzkMB5etut7cwx+KHFQkva/E9WaDnLF0FoJ+fqX0jNOWJgxx8RRu6M37AzEhU2hqOxwj0GwLMw5akx0WMiEeAyGNh0Xcap3Kdnpoo1PvbluII0EbzBN3FogGtgxhkR36djXTSQDPL/yUiJY0W3sUcMihmgcXg5VTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554816; c=relaxed/simple;
	bh=x1WpMbPrXt/ixRuU1MPNtZbnxurSV3/WnsYb3wurrDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fUo05Z+FuXg60EZ0bxowH1H1M1I4vGmJUpoWZz2mozTEW6SRfFPJstXCkjiNloVFC949HxAfQQOHlK/ueuU50Xjzc6MmS1hfvmdBGttaXSpqTT32FwCzjLikHDL/ylHZcWcCjp32eEFYXAVp7poogJCCXzv1+ivMuunoPcyUvdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gQpuV36v; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5f6b65c89c4so643465eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739554813; x=1740159613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsOCGGo9ceVGY3SPzwGNmGL7lbsQrpsFZ6ZHHv/lIws=;
        b=gQpuV36vdspRU5zZ2FXNCaga46Ot3BoAeEtI84k8+2qJ/783RJIJA0gnvsCNxZk1yl
         DovhyagfWGKVjCVZAqEYczLTWKHWr6WZ1ySE/LqoCLi+o8YJCgWV1Jy8qlZdzGI0x8c7
         wQrJAm1F1TyX46g5x3ZSzxtccgYiculkUTpM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739554813; x=1740159613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TsOCGGo9ceVGY3SPzwGNmGL7lbsQrpsFZ6ZHHv/lIws=;
        b=sjNlXye2ur07OOgGkyL7ouJT1wdJXn43AWdkSe8wKNsZO4w8NNVOr2Y2n1N1uXvnqe
         B+KGehDaVyIE0+ItekEec8Y7lcsOC2wiqCKVNwM2Nph4zHKic5RktD5LicVB1XtO2v34
         xGfMKxeDy4kFDGSzrszIqtDUJc8aXNH3rCG7DwKJQG9vq5L2iWtXa4delWY/sEsNpxwE
         jcmBNlVDu6TPGouZHyh0p2F7rTvnfo/p9dQJ3M5mTbEVf+gsTRH1uVbv51FkutdbKoTu
         1YKoh7eZysX2Pa7iUxm2IKcOGqI0ENJXcE49fOJ9jd6M+aBX7HjzPXphNuJipHo77sAG
         ZpsA==
X-Forwarded-Encrypted: i=1; AJvYcCX5SevgI1GMEyMRRHdzX1ih8KT4o1xXOSPKSml6Ok8lF7zMe8qokbbrXDbiksQNxt5jMpgXtmKhowbQ1Qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwusklAfla6saYpISXerEwEtT37vSkF6FyakP8WGOoF+JojSUNp
	Qes/JOLuWiibZQ9TZCVcG5KfUli26KIAqAqD04cJM5fU7t0A1iLuoIX6p1KsBg==
X-Gm-Gg: ASbGncsPvog8fCaT+aM/nh5EVLqK2WTl+7futzQ0lsoJiO/m74+wBFEDqcCGNmliNx/
	Ry/B1ZXUyYrZK08P2mhtSNbBlKVFFciB5kith3YZFi0yGCuwlnvEWTMp0DFr3vTzN1TESrz+Nyz
	8woAy2oCAOhgD+zcoSxdz1TQiyOd1QygotwjOhHm5iF6q3zxKmMk540g1p0k3Sp/Bi3FDPDjkTF
	IQPrB9BQbBeXJYLD8CUJgQNOA98tpL7RRJSIbjqM/hIcOxbgoCSVwKsMtcIsveMykOOkfwtMmHT
	eNaAuwpvNUi/Ort3vm0Mf4tSu4N+v2kqi+Qt25oTX120jdxSEt09XxQ1hC1JD4sqF/UcE0w=
X-Google-Smtp-Source: AGHT+IEHK/RYufUjO2+odce57Cx5Dp9JDUKZ5jsTgSO+dN2Z245MJjJKtjxMOKhmnO9Jpvg4aHpnVA==
X-Received: by 2002:a05:6820:310a:b0:5fc:9bb2:f78 with SMTP id 006d021491bc7-5fcaf564190mr4940899eaf.8.1739554813562;
        Fri, 14 Feb 2025 09:40:13 -0800 (PST)
Received: from stbsrv-and-02.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fcb17a4ca4sm1284073eaf.30.2025.02.14.09.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:40:12 -0800 (PST)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 6/8] PCI: brcmstb: Use same constant table for config space access
Date: Fri, 14 Feb 2025 12:39:34 -0500
Message-ID: <20250214173944.47506-7-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250214173944.47506-1-james.quinlan@broadcom.com>
References: <20250214173944.47506-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The constants EXT_CFG_DATA and EXT_CFG_INDEX vary by SOC. One of the
map_bus methods used these constants, the other used different constants.
Fortunately there was no problem because the SoCs that used the latter
map_bus method all had the same register constants.

Remove the redundant constants and adjust the code to use them.  In
addition, update EXT_CFG_DATA to use the 4k-page based config space access
system, which is what the second map_bus method was already using.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index e1059e3365bd..923ac1a03f85 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -150,9 +150,6 @@
 #define  MSI_INT_MASK_SET		0x10
 #define  MSI_INT_MASK_CLR		0x14
 
-#define PCIE_EXT_CFG_DATA				0x8000
-#define PCIE_EXT_CFG_INDEX				0x9000
-
 #define  PCIE_RGR1_SW_INIT_1_PERST_MASK			0x1
 #define  PCIE_RGR1_SW_INIT_1_PERST_SHIFT		0x0
 
@@ -727,8 +724,8 @@ static void __iomem *brcm_pcie_map_bus(struct pci_bus *bus,
 
 	/* For devices, write to the config space index register */
 	idx = PCIE_ECAM_OFFSET(bus->number, devfn, 0);
-	writel(idx, pcie->base + PCIE_EXT_CFG_INDEX);
-	return base + PCIE_EXT_CFG_DATA + PCIE_ECAM_REG(where);
+	writel(idx, base + IDX_ADDR(pcie));
+	return base + DATA_ADDR(pcie) + PCIE_ECAM_REG(where);
 }
 
 static void __iomem *brcm7425_pcie_map_bus(struct pci_bus *bus,
@@ -1711,7 +1708,7 @@ static void brcm_pcie_remove(struct platform_device *pdev)
 static const int pcie_offsets[] = {
 	[RGR1_SW_INIT_1]	= 0x9210,
 	[EXT_CFG_INDEX]		= 0x9000,
-	[EXT_CFG_DATA]		= 0x9004,
+	[EXT_CFG_DATA]		= 0x8000,
 	[PCIE_HARD_DEBUG]	= 0x4204,
 	[PCIE_INTR2_CPU_BASE]	= 0x4300,
 };
@@ -1719,7 +1716,7 @@ static const int pcie_offsets[] = {
 static const int pcie_offsets_bcm7278[] = {
 	[RGR1_SW_INIT_1]	= 0xc010,
 	[EXT_CFG_INDEX]		= 0x9000,
-	[EXT_CFG_DATA]		= 0x9004,
+	[EXT_CFG_DATA]		= 0x8000,
 	[PCIE_HARD_DEBUG]	= 0x4204,
 	[PCIE_INTR2_CPU_BASE]	= 0x4300,
 };
@@ -1733,8 +1730,9 @@ static const int pcie_offsets_bcm7425[] = {
 };
 
 static const int pcie_offsets_bcm7712[] = {
+	[RGR1_SW_INIT_1]	= 0x9210,
 	[EXT_CFG_INDEX]		= 0x9000,
-	[EXT_CFG_DATA]		= 0x9004,
+	[EXT_CFG_DATA]		= 0x8000,
 	[PCIE_HARD_DEBUG]	= 0x4304,
 	[PCIE_INTR2_CPU_BASE]	= 0x4400,
 };
-- 
2.43.0



Return-Path: <linux-kernel+bounces-523654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C59A3D9B2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5ADF3BF9A8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE431F63F0;
	Thu, 20 Feb 2025 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cWs7iRrC"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCB01F63EA
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740053888; cv=none; b=E5R2QtyZzmg8Z9hliYsL3FIPzCr9vVg7+dTe05XhJU4upBsNc2y99WBPBDWhRQoD4A2WmrvLHfA21AS0XuAZ7m1buUaPNOdEiO/BK7RNlaDziag7sGbbLIU8jdRXUVoApLLVXFGev8yPbkgHkNlf0IiA1yMpAhb9oMaEB5353aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740053888; c=relaxed/simple;
	bh=jt77Qfc0tJ/LeMuqZA50hbOhf9DkLh5GwSGqF+4J7yQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lPy2q71o65N4hxVzyFBoqrQ1NxZHBO/oaDeVJ0t6Gex+f3h1osV3+2jAscS2wUCxMRhUAh7IoxsMTYwFaMMHtZbgHf4J3LuMpSeMtU7vN6lu+WcmgNaHptNZYYR3mygznTbiEGorvecjXgqtM0go4FqbI05V42pBlb8qBSjzvpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cWs7iRrC; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220c4159f87so10860595ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 04:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740053886; x=1740658686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQ9El+/rlrHE/18GReAOzP2LKSCPW/1amedPa/4BiFI=;
        b=cWs7iRrCW9ljX/xxQlG8km3uyTE1cMP9vfV3ZECtNKjoYOUL5MtkZPxwZMI6NJUIIj
         KTYH6f1Kv8XvwyBjfBEGIsZdavhkYR1Kmu5EUkqIEjQUEUD+j/PJOchW+bK0mAShk3ds
         aLhzvz/ctMaVDXG7WHJK4ZI3Wo+dtN5HeYbjl8b/pKGJz+wDsUj/CO4csnOFg/Kg26AO
         6xpTpyYY5B77suICiRuJ+9sZyJqkXlEExOkeJyZFCyYV/gKl9V2PK5oJ/806dGKuiaS5
         d5Al0HBIGRTpw2g/vpNIXs0Yi1fz0oZxKnwa6rxpenHIkNOJhH/aWrEN1btiLLGi/Zns
         Ig1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740053886; x=1740658686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WQ9El+/rlrHE/18GReAOzP2LKSCPW/1amedPa/4BiFI=;
        b=HNjDPPG/IM9dFuxFLB/6D0a8dupKYkxrSqNBexlwG9U8iC7Yy3KkyejQck+7gexWiU
         qKR+docFc5DTM/N6NRblDQYB12Sn3CAivKtBq7rJuFt2wW3Qz7reb+3wa8Me73eEJSnY
         8BDlyvm1wPc3x+u4gCa7spLBaCvfEEg8IwuGFoL/7tuk0bQ0tWi3nA4Hta399xNXZqgX
         QJVhj08QMzb6b4su0sa0aeWwt9j65qQQS+u0rTCt7uqTD7s3M0L+ZCbYuVwoBKwjTkfh
         iZGNg+1LkE6GoSuPvq+iLQIrnjaqGPDrNARaYcLArEQUufkDgUSCMzlVrxz57+Svkg1j
         zXaA==
X-Forwarded-Encrypted: i=1; AJvYcCWjZiCVmtOMZ7YJldid3jAC9kV1RGqjdB+XxhjOk4GQtTgYzlkvU5AxXjvVg4/s8DjQXdtmV4qEgZZnRoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlP5mcfyLJn+COCkleGajhIPV08bh3xkTlB7iqPxi0uvu3r0K2
	2L4m9viyHW/+WK5be4xfoG0KQd48k9+bA3WaZGNgN4671q6ckDwpjsbD56pUVh8=
X-Gm-Gg: ASbGncvFEI9dBeUJgoHHjJVdGlqc5MQPHxnkiJs+82a6t7jZLJOgnbvDNoCc+gPf6Fo
	gzksladGIAfxyK5UdCoPnPWBKtbokQO5bZrTYjP4QZX1cZDC62+ea8+SO6RX4Bsw58JNq4gUh2o
	OZFgwFfvt2fz/uu44oeb0792G/kRtLiKpB/6icNVfWVurXg/bl3IyQeTozm/bZFZBTgjzOOZu7k
	l16PRNR4r4h1PDRkteV8eVJIBu+8gJExbEra+6BQGIcHzj/dMRYt6bhHRD9xJzqXA/K22VSRGG8
	KiTGMJ6U/VesP3OTQa0IRAcb/fsOndlOVeiuUyRpOQMiFypSyQ==
X-Google-Smtp-Source: AGHT+IF5DERZr4x7+rVPDYf+5pG+kTBcq8I+/piPH2yH0muu1OSon/ojTej4ajQeJjQ1xdnMPN+njQ==
X-Received: by 2002:a17:902:f789:b0:21f:61a9:be7d with SMTP id d9443c01a7336-221040d75abmr368001905ad.49.1740053886409;
        Thu, 20 Feb 2025 04:18:06 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-221040434d9sm87773895ad.196.2025.02.20.04.18.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 20 Feb 2025 04:18:06 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: xueshuai@linux.alibaba.com,
	renyu.zj@linux.alibaba.com,
	will@kernel.org,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH v4 2/2] perf/dwc_pcie: fix duplicate pci_dev devices
Date: Thu, 20 Feb 2025 20:17:16 +0800
Message-Id: <20250220121716.50324-3-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250220121716.50324-1-cuiyunhui@bytedance.com>
References: <20250220121716.50324-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During platform_device_register, wrongly using struct device
pci_dev as platform_data caused a kmemdup copy of pci_dev. Worse
still, accessing the duplicated device leads to list corruption as its
mutex content (e.g., list, magic) remains the same as the original.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 drivers/perf/dwc_pcie_pmu.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
index 19fa2ba8dd67..f851e070760c 100644
--- a/drivers/perf/dwc_pcie_pmu.c
+++ b/drivers/perf/dwc_pcie_pmu.c
@@ -565,9 +565,7 @@ static int dwc_pcie_register_dev(struct pci_dev *pdev)
 	u32 sbdf;
 
 	sbdf = (pci_domain_nr(pdev->bus) << 16) | PCI_DEVID(pdev->bus->number, pdev->devfn);
-	plat_dev = platform_device_register_data(NULL, "dwc_pcie_pmu", sbdf,
-						 pdev, sizeof(*pdev));
-
+	plat_dev = platform_device_register_simple("dwc_pcie_pmu", sbdf, NULL, 0);
 	if (IS_ERR(plat_dev))
 		return PTR_ERR(plat_dev);
 
@@ -616,18 +614,26 @@ static struct notifier_block dwc_pcie_pmu_nb = {
 
 static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
 {
-	struct pci_dev *pdev = plat_dev->dev.platform_data;
+	struct pci_dev *pdev;
 	struct dwc_pcie_pmu *pcie_pmu;
 	char *name;
 	u32 sbdf;
 	u16 vsec;
 	int ret;
 
+	sbdf = plat_dev->id;
+	pdev = pci_get_domain_bus_and_slot(sbdf >> 16, PCI_BUS_NUM(sbdf & 0xffff),
+					   sbdf & 0xff);
+	if (!pdev) {
+		pr_err("No pdev found for the sbdf 0x%x\n", sbdf);
+		return -ENODEV;
+	}
+
 	vsec = dwc_pcie_des_cap(pdev);
 	if (!vsec)
 		return -ENODEV;
 
-	sbdf = plat_dev->id;
+	pci_dev_put(pdev);
 	name = devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_rootport_%x", sbdf);
 	if (!name)
 		return -ENOMEM;
@@ -642,7 +648,7 @@ static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
 	pcie_pmu->on_cpu = -1;
 	pcie_pmu->pmu = (struct pmu){
 		.name		= name,
-		.parent		= &pdev->dev,
+		.parent		= &plat_dev->dev,
 		.module		= THIS_MODULE,
 		.attr_groups	= dwc_pcie_attr_groups,
 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
-- 
2.39.2



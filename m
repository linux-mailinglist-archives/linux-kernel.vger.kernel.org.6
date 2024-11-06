Return-Path: <linux-kernel+bounces-398681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1624E9BF49F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59B3BB24630
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D8020820C;
	Wed,  6 Nov 2024 17:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="YPn5eH69"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFC7206973
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 17:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730915469; cv=none; b=Cjl2wX/ILykDAve7Sspjcmqbfs+QLHtqmvbMNK/1hFlKddrqVagkLjl2Lx6Y7de2BR6PM9rhB+ekj0T0Oi1jAdwTCfjoR9ZkmbXII44/2FDscOjlhHLvhk/xzUm0MVieq1QnkFPAZehZDZUaATKjcOgwiM6b7CEQty/dS8bMytA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730915469; c=relaxed/simple;
	bh=kGFqsIlFumYIKvxXpVDJi2uzeK9bhsdbBadYRpJVUfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cB+GfaR3BWE/gzb/Ey+hk6PLmqCTQ4HTCNKBtPIqMY/qG5w4eAH324npLnU5Xo5gL64Ly8W2rVUoq4n8i+DGFKsMiEQtHDHbLrPjT5RTzH/1xoQ3n0NU4QW4DL1K9ggleeGZrbU1EK28Q1gVwsXGyYPihUpIHqzcmIfAvc4/69s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=YPn5eH69; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9e8522c10bso14961866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 09:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1730915466; x=1731520266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g96IwKhGkFLWIqbkT7NwpHd+U4DZ81t2GIHo2pf1780=;
        b=YPn5eH69uCOS65GIZg8ew0RrqLlhUqjm/LnpIILfhmBHvU6rAEfm7RxUxZ/EX9LK8O
         IKCQl0MI3ytCIVOQgghRbMqUsztym9b9mmVF4oNaue8mSxxF0JsslNwq+Ky/NJFcEh7N
         yJboavpJAA84fCgrW2WoXENLa04F0lgkHnRoZxzb8gb39QP+DaAyOy5xo58wjiW8gACp
         rdYyEhnVKXfrIwNtByouAZDIdjylnT0IgBf64XQF+ML8BTpWHLx84j4H2JCfbS6CE++l
         6Oin874K6k4zMHUIsDnta4QxPM+C3NxUBCGp2pSDEWH/GFgOaO2mdtErL0oizU3YB5Sn
         7/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730915466; x=1731520266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g96IwKhGkFLWIqbkT7NwpHd+U4DZ81t2GIHo2pf1780=;
        b=Fprp+6+BhLBuhkTVkJ4GhW0oe6vyZU4VP3WoNsPcyV131oU0F+1ZjNDP1ak8vSwhlH
         2I+J0GztVqXinBNv2syZGJJXuSvzoLOifS7idsgEGCfWEVyLnU0KuNIZzqODLgU0QhpO
         +WsgzRZl9shLSIL7irW/Kvt5EUR7wMGYrI3x4PVE2QbK5JIy7CgD5tIGj9g2qlFQZBny
         7LHYuN+SHdIZg2Cvlm7tvusdXJ7DAboUC1CWaBvPv0Zf25IzwHQjs3+Cr6PaeUNMLC7d
         mXIAm4tP64jCEdzNuPeUkGWR5wzAKjC+qXxxfE+tJYshfqf/qn2YZKhZKUcFRTutYgEc
         HWKA==
X-Forwarded-Encrypted: i=1; AJvYcCV8Zo4oENWCSpLvChPHXRK70Zc4pnPdt88sGsQCcCb3A50o3hl7n9uLyIgQeiHVDW7vuPS0Khm4DWpTVsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZPGAkuMR/bPRi5KRJ6Bl2EFLHxv5YhIx6gusXdUbRzSasIuyH
	ofQmvKXOhh/0JFwFOsV+HX74t/wrN0zYScfe6dzH0tHDFC5O5s3IDz3e9mndfG4=
X-Google-Smtp-Source: AGHT+IEFqB7EqZ9/qt6Tv+l9s3WePIJJrBkQGmuE+wise2peEn4wuYWmsni9+gmk+GDjL44CfjLWRg==
X-Received: by 2002:a17:907:948d:b0:a9a:597:8cc9 with SMTP id a640c23a62f3a-a9ed50cb67dmr4422366b.12.1730915465830;
        Wed, 06 Nov 2024 09:51:05 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb16d4d6bsm309041166b.44.2024.11.06.09.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 09:51:05 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Subject: [PATCH 1/2] iommu/riscv: Free irq vectors on pci remove
Date: Wed,  6 Nov 2024 18:51:04 +0100
Message-ID: <20241106175102.219923-5-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106175102.219923-4-ajones@ventanamicro.com>
References: <20241106175102.219923-4-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

riscv_iommu_pci_probe() calls pci_alloc_irq_vectors() which
states pci_free_irq_vectors() must be called on cleanup.

Fixes: 68682e9578fb ("iommu/riscv: Add RISC-V IOMMU PCIe device driver")
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/iommu/riscv/iommu-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/riscv/iommu-pci.c b/drivers/iommu/riscv/iommu-pci.c
index c7a89143014c..25a27e627a0e 100644
--- a/drivers/iommu/riscv/iommu-pci.c
+++ b/drivers/iommu/riscv/iommu-pci.c
@@ -99,6 +99,7 @@ static void riscv_iommu_pci_remove(struct pci_dev *pdev)
 	struct riscv_iommu_device *iommu = dev_get_drvdata(&pdev->dev);
 
 	riscv_iommu_remove(iommu);
+	pci_free_irq_vectors(pdev);
 }
 
 static const struct pci_device_id riscv_iommu_pci_tbl[] = {
-- 
2.47.0



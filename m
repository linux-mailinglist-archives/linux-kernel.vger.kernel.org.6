Return-Path: <linux-kernel+bounces-563220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED47FA639DA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 02:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B97516C524
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 01:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DA026AD0;
	Mon, 17 Mar 2025 01:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gEfgKsHk"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866BF22F01
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 01:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742174049; cv=none; b=YgYa7F2BWo55TpEiY/gliQ0wxxdTJpGvgBi7vTnNftGP0WRtORvZX/tpBwajOKEDqu8EsBTOIhBNU6cgZ3E8rGTr5alnmQfkVXlp1DnJ+IIAAa+BJQ3JDnz9kH1poGZN3KwKCWZtQIroJsUjqKpK3AxvDt7LU+iymO//ZVuJgRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742174049; c=relaxed/simple;
	bh=HBdNRz7NWotgzuk+x/kxszEOIgphn0BH0jzSWHy0fPM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bnLq0oMaf+sm99tLBFp4weLoDfdTIJK2zFq5FQMxvThLIIoWUA+4pjZRfEaSJgeHbm9P1CaDtYYGM+8DB8YPdKGkX97/ATHI0QOIBE/WcyIc35wUmn0f+7boMHpSeu18PwbpYAdJmdspmJZGKtD1vUt2+zWbFrvxwYvmjaXo+RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gEfgKsHk; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ff6cf448b8so3034154a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 18:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742174047; x=1742778847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXru3TCUuPTakrv/YVRqLX7LKq46qhiQdzkoohXODxU=;
        b=gEfgKsHkm0Vl86jhUd+X9IigA8hrTG2cdi1ojK5zHhAemtdoXArjAPz+lCq7BnPc3F
         OwgreBedzUOq8J8g6l4JP2ajaPSrE2RfnIDVEwlN8Sh9yPIy5vWq808YAzCDLOroEC5X
         OKRgOvfV/mGuHRAK5ODOLvAek/rtxPhXsXC1SGrSxanxZss/NzR6upoXtl73AnXS3oLe
         k9XCEJDrweoakTRTsZVv1iZYJ3vKiWpCTbrYQfUT1w9nemqHxlGwCG1I7pGgRDGVi/ef
         7VJ8MtCzni8u/4Mm5nZhNN2JVQkwtpYs1WITuTPsaE5C4jSWqmTO2bJ6LsrbIe+vB7CW
         J4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742174047; x=1742778847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXru3TCUuPTakrv/YVRqLX7LKq46qhiQdzkoohXODxU=;
        b=It6cCDv+lcTUHLXT2AN7zn8a08WG9ibKtee5SQX21trqLQkAf6RdECK4DULU6A+H5Y
         IDxDLo3cYdmSycrcF0R/RJ1okVrVbTsv1HdX9BmpXOnlXWPK9+EIAzQZdpwIyQA7yMmX
         d+4nMy7L8S8SV70ViXeW7C3MYrHo1IXjT7DgenmBMPOLNW38x2hORX0aAi4w7CVfy5EU
         BGZeRR8FnH3z0n2aQQ6iLWY+u00R565zQtrVUkBs3hkRCxaC8z/O4olT1RxJmChnWFAY
         x80o6d61ISbQr4WwyV3d2aUOOnjHFAulXEndZwWJQkLnhX9xrg4PxrMkF74wyiNlQLwh
         nudQ==
X-Forwarded-Encrypted: i=1; AJvYcCXffzgXY3n6xwi+hFAH6t4w3nnEZJ1+N56m+lMMfoTqtHD0Y9YnIUECV/snJ3je3FKUxUyDHgnv9ptqbb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLlA0+44DhdE9HhIXaIskuB6vPjXk3xPUCut6r4C1jhXA/MfK8
	NcSE9GveUf8Phy4IL203wjHHofQzdzFf3n+7eRCB7/jk6PjfCg2tvRG/eQfB6ac=
X-Gm-Gg: ASbGncvkwAqYQpjMvHauWj5tMtw7TZDgOmtM/88UF4/7NPbtN3hJO6dAG7FvWL2KQBo
	GUwGlKU4jhDOGrWO73dijHRELAqeuvcCv6be/xECyWUodoEqfigAkZQBg9csrnKlSK+Fuo36/lk
	Z4dzSXOXFQHtfu+xj7XlufcAisZxQjEXEadI5vfqX6NGzJgGM9ud4JVJ1RtX7v59a5pQWgO81X+
	wAXAJ9ChodFRlBuDcjRvleu3POsxLKVrSJWl/qZJH5aYsI8ilp4N2mlGJeksm5q0A7KsRDrT9Of
	VFjCs54tl+9zIzLFWVM/3XPGCcKPtS8WuVcbowMzRN//EA==
X-Google-Smtp-Source: AGHT+IGOmbtA4Nm1nxJHb0yeQ9L0e+qEg9pRtI7VVMCpHNpNnF2DyuK2Y2lCTtT06AGryzfhV/6wQw==
X-Received: by 2002:a17:90b:5201:b0:2ff:5750:7a34 with SMTP id 98e67ed59e1d1-30151d81d60mr10497286a91.34.1742174046713;
        Sun, 16 Mar 2025 18:14:06 -0700 (PDT)
Received: from gmail.com ([121.37.54.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30153bb94e2sm4756494a91.45.2025.03.16.18.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 18:14:06 -0700 (PDT)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: iommu@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v3] PCI: Declare quirk_huawei_pcie_sva() as pci_fixup_header
Date: Mon, 17 Mar 2025 01:13:52 +0000
Message-Id: <20250317011352.5806-1-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250315101032.5152-1-zhangfei.gao@linaro.org>
References: <20250315101032.5152-1-zhangfei.gao@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper
probe path") fixed the iommu_probe_device() flow to correctly initialize
firmware operations, allowing arm_smmu_probe_device() to be invoked
earlier. This changes the invocation timing of arm_smmu_probe_device
from the final fixup phase to the header fixup phase.

pci_iov_add_virtfn
    pci_device_add
      pci_fixup_device(pci_fixup_header)      <--
      device_add
        bus_notify
          iommu_bus_notifier
  +         iommu_probe_device
  +           arm_smmu_probe_device
    pci_bus_add_device
      pci_fixup_device(pci_fixup_final)       <--
      device_attach
        driver_probe_device
          really_probe
            pci_dma_configure
              acpi_dma_configure_id
  -             iommu_probe_device
  -               arm_smmu_probe_device

This is the pci_iov_add_virtfn().  The non-SR-IOV case is similar in
that pci_device_add() is called from pci_scan_single_device() in the
generic enumeration path, and pci_bus_add_device() is called later,
after all a host bridge has been enumerated.

Declare the fixup as pci_fixup_header to ensure the configuration
happens before arm_smmu_probe_device.

Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
v3: modify commit msg, add Acked-by
v2: modify commit msg

 drivers/pci/quirks.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f840d611c450..a9759889ff5e 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1991,12 +1991,12 @@ static void quirk_huawei_pcie_sva(struct pci_dev *pdev)
 	    device_create_managed_software_node(&pdev->dev, properties, NULL))
 		pci_warn(pdev, "could not add stall property");
 }
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa250, quirk_huawei_pcie_sva);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa251, quirk_huawei_pcie_sva);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa255, quirk_huawei_pcie_sva);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa256, quirk_huawei_pcie_sva);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa258, quirk_huawei_pcie_sva);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa259, quirk_huawei_pcie_sva);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0xa250, quirk_huawei_pcie_sva);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0xa251, quirk_huawei_pcie_sva);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0xa255, quirk_huawei_pcie_sva);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0xa256, quirk_huawei_pcie_sva);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0xa258, quirk_huawei_pcie_sva);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0xa259, quirk_huawei_pcie_sva);
 
 /*
  * It's possible for the MSI to get corrupted if SHPC and ACPI are used
-- 
2.25.1



Return-Path: <linux-kernel+bounces-562532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDD6A62ABF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 11:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 684D03BE577
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 10:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE8E1F4701;
	Sat, 15 Mar 2025 10:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vnUfSK+j"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541241F462F
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 10:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742033614; cv=none; b=NosDi+rMlvSLaamWhPVc82Z2N+ZbUWIoZlFqLZWoEsz2BbTbB/1sEvFTLmULUFgnuqG4l6dg4wjabU5G7D3LLBijDrL8fTOfLHUUyeXQZwmZPGhYvFuN9f10ax5ru/ulzvuRZWKm+2EpK9rNbTe0jlT2WSbweck9Boxl3Ozrvx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742033614; c=relaxed/simple;
	bh=vo1Ew4aLSrrge0Lgz3BYM6r54y2dPTj2RJNNDXpsAMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cBK+QPy/nZUz2nKOSkeMLYP8g3V04q2pQNjHyv/fTOaU3kItvsE9Dnu/yU/1OuCK4UJg9vnGfeHwuvFpOGLwOgToSwZ4/DJKqVHdImInUImcRLCa+xhoC3NXY46rUUPvi6bj4L4RH3hTqvyMKYvIBA5UfynlN7dEUbCLvzpoaDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vnUfSK+j; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-225fbdfc17dso1590635ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 03:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742033612; x=1742638412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyw0PGKWLV1nMfM+kNzqLLYQtPTsmeX5w4ikFyh9R7s=;
        b=vnUfSK+jT8F4QyGrnzVqQfRYAhSsmuXU4o+i7YW0fCxaWCAggy8tsVNOadXzZFLUrw
         QklMxmX56hXc7+9Y25R4ptz5IB0VQ4PNBqyuWXpkrEGPjM7Ze06HoYYjd19FteBBGBGg
         EpHALVm1bVq3hapdgmvJV/XYHeBH86ULNUFJG8LvOGm71ApFHwy+12LpZwokH5sB9Ryc
         99ldqpwIrcO1os6lt/hdstut52/1gHydS0A+O1qBWNrZ1qLWiFzgOSa48mmgxuAPqKcM
         ++EDHuMwQX05c52Lans/6bVodAVsOVfKcfSptycRjmxEIfrU2QwCPjZvLdoaoXenV3QP
         K1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742033612; x=1742638412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yyw0PGKWLV1nMfM+kNzqLLYQtPTsmeX5w4ikFyh9R7s=;
        b=vyxMsZMJdD+AQ/i0A4HcBJL4E94t7S/sP9sljEjY4jnlmtiwJxNPiEk4En5DFy7yJ7
         ZbhEM+zvlQ8xux5XUh5K+6AkY3/DyGBwaBul/9w0W99O4kyEsyMGYb+g+YVxxdI20TZU
         qCwDaTloOYd4Pa2XhtFxGSiFeqPzp4SBe06aOjqf1hvhOqb4X9eQyzuNQv+FYEsTgp06
         ybRd2pNlfkNgBjwAhAdayL5xv8O06ydqSK/EOoT0GXnZ65Qx7mYn6k7Fh4+7ja4azUOE
         Oczx4r25qFd7VG43DZkog87o1whBbT4XV3jgYhsyApwwNno+vo05e+fKrOxrwMs9HL8M
         OG5A==
X-Forwarded-Encrypted: i=1; AJvYcCUJc3FjgxprDfzohcTRbOaTkRi4YSwx7tq4ZVQI5frTgvkNdnBygh9KgxHQzxS+FRH6u5wKq/7QLZ7cGEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd5uF/U26BVmTf8kiY4li7kA9gqlxPClEwqKrDJ4WTbqJeSDje
	VvljU+EsIqpHtFj5IZuJx/CuJP4tZdDFejzMO6/1wrk2Y4gHJQhxldrYGw9F8vU=
X-Gm-Gg: ASbGnct5ez4H9ae7eSogOaBGL8AI+DRYKm3J4WoDzQgLkVEtpJywuMqZcJoKX6i+FI3
	oZpmSJk49s3YZKV/LHgJx2pKDzG491LG9HNs6k+JZ8zJ/Rz8Sl8qCLHK3ObdgK7v9fLUwLmpTsg
	NxwJR5+gsV4UI/CF7t8fR72PqzyJ4mxAUfKjnlX/wTq1+Au0X0lB0ZseQga8tinIIXLsiP69kme
	e57PwsI5r5RLTioXfyN4Ih6b/sOSxzJ6gCK8eSR75cEedEEaHJd+rjR5W4+VSetgOB4avvlq5Cj
	rpyXMgptGZaSIgMcWjxiDtv62LzGk1vIv9/ifIyJg/Kt2w==
X-Google-Smtp-Source: AGHT+IHc+zbfLPsEbvvVLayren4erBe1Dj0SSg+NK2HsIPUFW6sh7RHagO+DW1A24D8x9HdCwjeFHQ==
X-Received: by 2002:a17:903:3c50:b0:224:1579:5e8e with SMTP id d9443c01a7336-225e0a3635emr76218415ad.1.1742033612590;
        Sat, 15 Mar 2025 03:13:32 -0700 (PDT)
Received: from gmail.com ([121.37.54.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c688846csm41957545ad.33.2025.03.15.03.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 03:13:32 -0700 (PDT)
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
Subject: [PATCH v2] PCI: Declare quirk_huawei_pcie_sva() as pci_fixup_header
Date: Sat, 15 Mar 2025 10:13:19 +0000
Message-Id: <20250315101319.5269-1-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250314071058.6713-1-zhangfei.gao@linaro.org>
References: <20250314071058.6713-1-zhangfei.gao@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The commit bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper
probe path") changes the arm_smmu_probe_device() sequence.

The arm_smmu_probe_device() is now called earlier via pci_device_add(),
which calls pci_fixup_device() at the "pci_fixup_header" phase, while
originally it was called from the pci_bus_add_device(), which called
pci_fixup_device() at the "pci_fixup_final" phase.

The callstack before:
[ 1121.314405]  arm_smmu_probe_device+0x48/0x450
[ 1121.314410]  __iommu_probe_device+0xc4/0x3c8
[ 1121.314412]  iommu_probe_device+0x40/0x90
[ 1121.314414]  acpi_dma_configure_id+0xb4/0x100
[ 1121.314417]  pci_dma_configure+0xf8/0x108
[ 1121.314421]  really_probe+0x78/0x278
[ 1121.314425]  __driver_probe_device+0x80/0x140
[ 1121.314427]  driver_probe_device+0x48/0x130
[ 1121.314430]  __device_attach_driver+0xc0/0x108
[ 1121.314432]  bus_for_each_drv+0x8c/0xf8
[ 1121.314435]  __device_attach+0x104/0x1a0
[ 1121.314437]  device_attach+0x1c/0x30
[ 1121.314440]  pci_bus_add_device+0xb8/0x1f0
[ 1121.314442]  pci_iov_add_virtfn+0x2ac/0x300

And after:
[  215.072859]  arm_smmu_probe_device+0x48/0x450
[  215.072871]  __iommu_probe_device+0xc0/0x468
[  215.072875]  iommu_probe_device+0x40/0x90
[  215.072877]  iommu_bus_notifier+0x38/0x68
[  215.072879]  notifier_call_chain+0x80/0x148
[  215.072886]  blocking_notifier_call_chain+0x50/0x80
[  215.072889]  bus_notify+0x44/0x68
[  215.072896]  device_add+0x580/0x768
[  215.072898]  pci_device_add+0x1e8/0x568
[  215.072906]  pci_iov_add_virtfn+0x198/0x300

Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
[kwilczynski: commit log]
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---

v2: Modify commit log

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



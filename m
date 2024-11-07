Return-Path: <linux-kernel+bounces-399319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 403209BFD65
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 05:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3DBEB224EA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 04:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6490018A926;
	Thu,  7 Nov 2024 04:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iH6F1Gud"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219B9372
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 04:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730954242; cv=none; b=Go8CQJsMu+207thGy+koTai/Bzg+8qhSZ/a3h+6ffAjbCmI1ugHv+wdsWIkMp2bqQ59w4ELRfd/QYcxGb9CxpWE9/HYPiw8c0nDa9mLgvrQRNPykvxlBHqW1ztTscFd4Tg7+OOOZZvvkF1zBqw6Mq2UTh8Sddw/rEsz58EF3/ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730954242; c=relaxed/simple;
	bh=djtiKxfwMXlElXRqkoZlRIe/1URcPNqKmbd8HmdJso4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t1iG1Iy2IqwsBFKeW0E08rVqVMEzr9VzT3GK8NntJyMyQoEAu/9uWQWCEgEoZMHyAYCgK8DVnstBHj3dX/ISFgU0juuHg9/BqHDzK+7wAU80xZdmmnBKHKQ8vwKpvSszPa5tygl4d07+y/xJFcWTqeP93uqqVUDE+NjU/RvSnQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iH6F1Gud; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e79f73aaeso341206b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 20:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730954240; x=1731559040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGFL4n7hAh2FjnL+CWJ4ErGkXKiKPRoUD1KeW9udQmQ=;
        b=iH6F1Gud2M0xARS+jGfbfsSIoQDRX8pfNfKL8fpggXUNbaskaWOeUI5OQuCaxDl2Tz
         NC9L2TyRew0xqQcbAjKxYv7MTIOeZofKV/cvehvxDExbccm9o52IhjX5gtJxAx0UyrCt
         Lq8p89mpIKHpCCvgIj3WBBvEM7iAfXIak5InjdSQ2k85kfwzpSW53PbMjs0n+lOyy3/e
         Xjbu6O2c3p/zs7l0CmC2ylPGPfCxGa4VAYyO4LOSfRmZbyASIEOOogtHyr9pE46i8pNO
         FSIEd01079ZncXPhcziCUye0yztklno0DZa7xxJfZDkYcJEEtHIx6uUrm6nsk1ZNJvZf
         A0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730954240; x=1731559040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PGFL4n7hAh2FjnL+CWJ4ErGkXKiKPRoUD1KeW9udQmQ=;
        b=AYkDRg0U81jVK3OshhCoEU91mA0SUbbeMxTdhdl99Bi2VR9/QrVUqqwRS+XycsDreJ
         BOBMGQczXDNG8khEcpQJfsKpbAfP6cWZjOGFWxzDP7LN+rAhrWFmoZTgbscONdfRPJ+B
         DYLH9s4wPS+H2MrMtUFuX9R+Hab66ZCbFmRAc/oWf01BRAGikHuH41ISMSD+LzAYFhKm
         Bbf2AGOz/5fV+vpcjpNrvvxSrCP7QHI3DKlBtBE8oCKHCwAuEVkyjkKPwmcN5VfPgclw
         aB1gr0PfPYY2vDbmkB2wphn/LWlwBj3XDfw1XxBTNJsRiBxidPouiaWgyTntzQ/ur7DO
         3TTg==
X-Forwarded-Encrypted: i=1; AJvYcCUtcZW6SSfxV9qM3ckNvuhbdDP89OtZwooQAwx1XnGazyLPLfoezcChWOOmekSGOZtuTPCZejwc+guM9V8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcCQtRisSkzVvivVGcnaeP1LSCtZOH91K4XqDAYT7aouskfH7I
	crj5WvJuqMNSljB+9bWwPBiVKCJALXb0nQUIz5oBxrbiV5g95JhfDe+tuW2EibU=
X-Google-Smtp-Source: AGHT+IGiwavu5UGXq8CrIZC04nV302KesPSHi8v8p/O2mVfLRC0J4FG7JTtV0e6d9EK7h/RxeaKDAg==
X-Received: by 2002:a05:6a00:2341:b0:71e:6489:d18 with SMTP id d2e1a72fcca58-7206306ed64mr58685515b3a.22.1730954240433;
        Wed, 06 Nov 2024 20:37:20 -0800 (PST)
Received: from localhost.localdomain ([121.37.54.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a4f566sm445337b3a.171.2024.11.06.20.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 20:37:19 -0800 (PST)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	jean-philippe <jean-philippe@linaro.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	baolu.lu@linux.intel.com,
	shamiali2008@gmail.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v2] iommufd: modify iommufd_fault_iopf_enable limitation
Date: Thu,  7 Nov 2024 04:37:11 +0000
Message-Id: <20241107043711.116-1-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241028113209.123-1-zhangfei.gao@linaro.org>
References: <20241028113209.123-1-zhangfei.gao@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommufd_fault_iopf_enable has limitation to PRI on PCI/SRIOV VFs
because the PRI might be a shared resource and current iommu
subsystem is not ready to support enabling/disabling PRI on a VF
without any impact on others.

However, we have devices that appear as PCI but are actually on the
AMBA bus. These fake PCI devices have PASID capability, support
stall as well as SRIOV, so remove the limitation for these devices.

Co-developed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommufd/fault.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index 80efef1c127d..c5b0aa719948 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
+#include <linux/pci-ats.h>
 #include <linux/poll.h>
 #include <uapi/linux/iommufd.h>
 
@@ -27,8 +28,12 @@ static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
 	 * resource between PF and VFs. There is no coordination for this
 	 * shared capability. This waits for a vPRI reset to recover.
 	 */
-	if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
-		return -EINVAL;
+	if (dev_is_pci(dev)) {
+		struct pci_dev *pdev = to_pci_dev(dev);
+
+		if (pdev->is_virtfn && pci_pri_supported(pdev))
+			return -EINVAL;
+	}
 
 	mutex_lock(&idev->iopf_lock);
 	/* Device iopf has already been on. */
-- 
2.25.1



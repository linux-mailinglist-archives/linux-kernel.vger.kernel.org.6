Return-Path: <linux-kernel+bounces-384829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 347B99B2EEE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 660EB1C20BF6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF911D2785;
	Mon, 28 Oct 2024 11:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eEiIMsar"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F3CA59
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730115141; cv=none; b=aTJZzg54M3HSLUsb93uOkMu5TnmaDFGHl/Tt5m/YzABv5N00W1mr92C7kWvLzURjmqsL6o1i78yS0eW0YBO8Aj50swe+IPycQYb6IR6n2LmW0jHm6HPoSsyy2OjT6uFppvOeE4FoLpQbxk6RF3SmyFgOIYklLgvZo4BcBJmuYOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730115141; c=relaxed/simple;
	bh=MpwHSufBcvm9xbl1qnwtR8Ww4UKjQwgRoEtn9RAdfr4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jLL1Xl/eMK74j2UT4Ey4sL3LhDZ0r9PCdjy6yI5AF0IlW3GRByZTo7Vr+7W2sHlyTagVA61qytAiF9DQ0nJZWe4rDeYIdA55ApY49YT41Cx467sM6Mr0hGt7zIfKMlrHEtOvh31pFuh7qp7jVs0zMpsUpwJ9+5mNJi2WRKMVo0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eEiIMsar; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ed67cfc1fcso2526097a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 04:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730115138; x=1730719938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vb0HpRzR6BgtLF4tfspniLayDV2/WdPTrMJnx3jSjzw=;
        b=eEiIMsarO1w1u8xxMs+uHaiaur6xJJ02pcUewdYic89hzNMIuJOkQAN3OyXLS7agSU
         QwZgZ5QS3GWTAa1uSn0+RFKGypz0AbHk9WTVYTajiFIgIvZtgRvR2Tp+Su62xAKfFoZO
         Sb12jCcP4CuyyYSxGdNtqBTyU2ZlnF6gvFGUDredB8wsGOR3kmGCp1MuFsRloUA9Zbg1
         tNG1OooM1ABuOdNSSaXzmI2aLx5sEWYkt4S/ogYQjzS0FjgNkSxkh0Fqwe6H0gs6P7cK
         jH51rj3RFHzVdWacKpkvac08PoG3AhnWIaGZ1hJCp9d3dgC7eGrBhUk4/aRlLsshg0lC
         vw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730115138; x=1730719938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vb0HpRzR6BgtLF4tfspniLayDV2/WdPTrMJnx3jSjzw=;
        b=cvu007ttwiTyMxh+dXG9/VV/YxObieNG2vDeXyEwuLopCgGr+U57LKljKmzEXuQFC2
         jiEtKM9yiiM1/2bD9pssR9bZmQIj0RSEknI7Vh5wdd93v6JkzNnGftAJF0TNUyHx1ejQ
         AYeouHPVtULNpIUivSWwBOK97jlI4g63UWlD4VKoD7FACff7PLc5eP+IsjDOA2H+Fohv
         mAhYiBN9w+wlR0pTjN1D2nEIBclGgb97ozozEJdfXsR7T1jxLMaSAVpYcFxAWoJn1Zz1
         Bf4Vv5vnV+e5cQPHvsiEXHlb4a8fVexFwENd49wjgZ3JoWL6vPQTEsHJK4HK1Hyz8xRW
         tt1w==
X-Forwarded-Encrypted: i=1; AJvYcCU6MQ8lypZxGDM0DPHd/edeq45XlNeEFCNg9plozUeZaqPpK0Dzi8KUeDKtGuBGFFL5gqHwdB2nZN7+Rmk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9W533pHF6l5+57U+tfSA7EAjuWCmAi/T1vC1jYrzbteugCTVu
	YxOZo1MXhhqpIMFIULLfKX1fltExLDe3X+dYfCAfcuTCspC5UpB7wXqDEJKWX50=
X-Google-Smtp-Source: AGHT+IEnLj7PoGhRW4uWLI9cq1+RrSzhC/pHY5nT47lvhGxgKmgL0cDKIHvPlCLTGBOdc+tXVcHU7w==
X-Received: by 2002:a05:6a21:78d:b0:1d2:f09e:c15b with SMTP id adf61e73a8af0-1d9a846a207mr10729246637.25.1730115138196;
        Mon, 28 Oct 2024 04:32:18 -0700 (PDT)
Received: from localhost.localdomain ([121.37.54.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057931cd4sm5523282b3a.70.2024.10.28.04.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 04:32:17 -0700 (PDT)
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
Subject: [PATCH] iommufd: modify iommufd_fault_iopf_enable limitation
Date: Mon, 28 Oct 2024 11:32:09 +0000
Message-Id: <20241028113209.123-1-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.33.0
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

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommufd/fault.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index bca956d496bd..8b3e34250dae 100644
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



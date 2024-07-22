Return-Path: <linux-kernel+bounces-258990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DE9938FAF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59840281453
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 13:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD78416D9AE;
	Mon, 22 Jul 2024 13:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IVlMUY/i"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F0616CD07
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 13:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721653913; cv=none; b=eH+LmhnuGPTPGXRYHpHvZmH1+9fxQHivGlo5xNqLnRGzFMNumg70Se3dxqDfVnzpMSe7fagLceOmlPZI0coZZtmGyvmJEKMjHfFFcthMw5GOtdbVBSHDP8g0BU8negsvIJKnaAgBkb8SOPCeGy/sVgUxuw9SPsw344a7YUoPSvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721653913; c=relaxed/simple;
	bh=Yl54IhhBl5KN5lxPnpBkpytGNX+6KNwM0QpeivEX8uc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uUBii0xVvRZGSMSQ3YTDEpB/czzvG92cWL5lavvhiwZt56MBUy7d8yzPxZnftskMEswGrNSBgPeiTcFGGivvvdfWlFq8sz2ykS0W6iHR/qqADDnHBNQTXV/+wVzss3qHVEUQB8K50apcYeH8bM1uT27K79OAXHMJvUtzA4QL6Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IVlMUY/i; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc56fd4de1so29780385ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 06:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721653911; x=1722258711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WNLdaVhZLCULcVm0BuO6uOnDm8k9XTjZNc3bP/bzyl0=;
        b=IVlMUY/iSdXQ5RGX+Xj+5FLUNieock8eGfBhmxYKqYcB/ZV0NiNigS5g31bKUGpZn8
         H9D319kSJwFOB4Xc8XlpfVkeUSDhA/3PoogmjRV+tz91hfm0q+NskvDD56PcsHSZw1HS
         0eVghYClsYWFn4CwZVJ3xMKc32Fq8BvO9fhdtPCzGurd7NdUiOozVO36ltqUufgKJx7v
         NQZ7gpvgNmFUWoH+otCKtMdF0ra14s4Jr8pWMId1uedmyNuRjWEUBBhvNtaB5hdhQOwJ
         7+PBVyYj9az/gLxe4nXPBqXTvxNR3zJR5skVhMIPmVuJcFbw85+WsyPAEAlgpGooybcd
         Ja6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721653911; x=1722258711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WNLdaVhZLCULcVm0BuO6uOnDm8k9XTjZNc3bP/bzyl0=;
        b=MUvfNSl06lVMu5NmbQohNpnllE7196KW9Kj2vlugHBGoRiACE9x5S6Q5cC/kqD7t94
         D48CFyDa71LtUFJTxJ62ls8xxLnYj9zzT5BFzku++Ry/I8OQuQ9w018UwnJsn9qFR8cA
         j67uD72Xe7mzUAS7JwBkdJ9q+rD0Ga8+//TjZhpUXyOLLjuY938hv2FeW44OAJGLTNaF
         EfTHpmmoT74nGU3iUhD9nDea24CCnow0Bx7Ounec54vAflhp7lrJiwwCp632JggmDsYh
         /dQTewaJ+qu/8HYS66Za0aIGGc25Udnd2vZoEcWmw26WNjREOGEWYXDdHn/K+t8Kkarn
         +7FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVIISf++CXYYCR0MrnFDlB5QKrnmyMr4vckioPtdtp+9aTBsFz7mKVyclDKlu1rnqgdyvhJvA8vKCv/ZWaseeayPiHDN12v/HfhHxn
X-Gm-Message-State: AOJu0Yzy6Z0A7MYa4Fr9G3tEaH4BII7xZ2kTQAtYt9gNzLygAdEGcZcv
	Yv6XbjzVw03ttXUw6Q1INAeg/GmmJSONST+cgMo/7czqcNFViegNpFcB3D/s4MvYxdq5B+vmjt4
	=
X-Google-Smtp-Source: AGHT+IGkI1eeF3+ZjtqrWZ8QSMwy1g3He8uLa7RwxeT+z0eXBTnNP30Q7FcMNTGWn5a1pQb16PjBLg==
X-Received: by 2002:a17:902:680a:b0:1fc:4680:820d with SMTP id d9443c01a7336-1fd74d16bfamr100301405ad.9.1721653910688;
        Mon, 22 Jul 2024 06:11:50 -0700 (PDT)
Received: from localhost.localdomain ([120.60.138.134])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f486a3bsm53945765ad.284.2024.07.22.06.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 06:11:50 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: lpieralisi@kernel.org,
	kw@linux.com
Cc: robh@kernel.org,
	bhelgaas@google.com,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] PCI: qcom: Use OPP only if the platform supports it
Date: Mon, 22 Jul 2024 18:41:28 +0530
Message-Id: <20240722131128.32470-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With commit 5b6272e0efd5 ("PCI: qcom: Add OPP support to scale
performance"), OPP was used to control the interconnect and power domains
if the platform supported OPP. Also to maintain the backward compatibility
with platforms not supporting OPP but just ICC, the above mentioned commit
assumed that if ICC was not available on the platform, it would resort to
OPP.

Unfortunately, some old platforms don't support either ICC or OPP. So on
those platforms, resorting to OPP in the absence of ICC throws below errors
from OPP core during suspend and resume:

qcom-pcie 1c08000.pcie: dev_pm_opp_set_opp: device opp doesn't exist
qcom-pcie 1c08000.pcie: _find_key: OPP table not found (-19)

Also, it doesn't make sense to invoke the OPP APIs when OPP is not
supported by the platform at all. So let's use a flag to identify whether
OPP is supported by the platform or not and use it to control invoking the
OPP APIs.

Fixes: 5b6272e0efd5 ("PCI: qcom: Add OPP support to scale performance")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 0180edf3310e..6f953e32d990 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -261,6 +261,7 @@ struct qcom_pcie {
 	const struct qcom_pcie_cfg *cfg;
 	struct dentry *debugfs;
 	bool suspended;
+	bool use_pm_opp;
 };
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
@@ -1433,7 +1434,7 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
 			dev_err(pci->dev, "Failed to set bandwidth for PCIe-MEM interconnect path: %d\n",
 				ret);
 		}
-	} else {
+	} else if (pcie->use_pm_opp) {
 		freq_mbps = pcie_dev_speed_mbps(pcie_link_speed[speed]);
 		if (freq_mbps < 0)
 			return;
@@ -1592,6 +1593,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 				      max_freq);
 			goto err_pm_runtime_put;
 		}
+
+		pcie->use_pm_opp = true;
 	} else {
 		/* Skip ICC init if OPP is supported as it is handled by OPP */
 		ret = qcom_pcie_icc_init(pcie);
@@ -1683,7 +1686,7 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
 		if (ret)
 			dev_err(dev, "Failed to disable CPU-PCIe interconnect path: %d\n", ret);
 
-		if (!pcie->icc_mem)
+		if (pcie->use_pm_opp)
 			dev_pm_opp_set_opp(pcie->pci->dev, NULL);
 	}
 	return ret;
-- 
2.25.1



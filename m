Return-Path: <linux-kernel+bounces-257057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BFF93749B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 09:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CE072845B2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 07:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D0B5914A;
	Fri, 19 Jul 2024 07:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="Rg8ukAKS"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E595C4AEEA
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 07:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721375792; cv=none; b=fm0QihYRjieuXpO5wxKDqSVw3q6+Ezd3N/v+VmzH/FUi3jA2bY0B5TKgvphtqY3DCOwSNgawySsMiGU9aOkWwyx4uAXuRmhyxL9qHlZeg2kl5QW10/VL+S5WYDvZItqhgKgBSHQT9wWAezhhQl91d5WO+GynqQUI/xxGipSumSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721375792; c=relaxed/simple;
	bh=VVLI7EBeuyh7YB4ZWYo4aVqSu8I3Wae6ccX9RaRy7wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aSy0stJUqLMHlBAiFzTd2suHI41aG2YvGdDtEqL9pxjYIeJvd9glYvyhDQlGrjjAnaoQqiGEedHU5ri5ps3SnYnM2xb2avn7wDie+hvpnnD6F8UdU7tzX3XBO7rufIRGHXk9ltdQSWeVlIFwjOHAaVG+6RbkGk1HRPAA797ygiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=Rg8ukAKS; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-38abd30a1c9so6895515ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 00:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1721375790; x=1721980590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zkHaNFtXIQ/P4HLzQzvdxFcOV87v0OUt5zn/ONL6Gw=;
        b=Rg8ukAKS9ly1i/ZszdUIK5pRhGueH6PPe+ogOtylRNilh+2MzeVDnCAfr6f7U3g1Ds
         qNVbGiUrbWjdQTkgpi25fl3GB8HJsJ3cNe8m2P0+mgQsV1wFx/C7M22pgJCWlPpx82Fy
         G33AXk7TDt5NHW9f+Ca6UPZx7BW2XVEyNI5GZVaSFSxINo2ytdA7RxJIWx77I3YZpjP9
         uDRFOV52Gcc2pTsOExKdovPRJebDsJ3iHVRIuhYnZNNZKv++a/Ve8RHuKw+NM4Wl9KuL
         xgQdrI5PFaq6WbPgIlrX6PnXgB06QGE3+E/GBDa2I4WDhvxe5MpeZ28Wtu8rC2CLuPSh
         bueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721375790; x=1721980590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9zkHaNFtXIQ/P4HLzQzvdxFcOV87v0OUt5zn/ONL6Gw=;
        b=YM89uldtC8fOP3hw26YmJu15vj19DpzksO1lnaWfav0WRf/01fW5T7EMGkIUmUSOaZ
         2EIxK6GqTCqyK4bMakqS2TjRkPt2W3Qo9KeJSi2xVvSFnuOw+OUbHZlNBNsihSjNqYWF
         O9dL3aMvul/x+4mqBz1FTS4GPpMySsbqbQTVhYI8Y7IN4sQLSy7UVP4bik1BNfJRotnG
         gG37t3d6Ch8N3ivTjov8NXOya007JB7BdREp7xD8K1nzO1qojgc9UVNAW3upjjTbic8k
         QE/AFH9TOVjQls7qV9m1UCf0FJ3BdpQ1GhGMDgdeWQd0rEYqRM4sfIRU7b5QJ3pPTps0
         blFA==
X-Forwarded-Encrypted: i=1; AJvYcCXwzXQu7jwkmL7mS/Xq0WPx5ZQkN52kxqLAIiLP97UC2EOjuRprXPLEOKkgmkdVht7wxGnI4JJ+4Ae/6ulwbQl7gwPevVQ2ns4lNHhX
X-Gm-Message-State: AOJu0Yxb2Ul5TErSXshDS5TM9uFVLNlo92APsB6XFaZ7viFBMuzSLrXp
	/RA1qP4E+9/be+6fF9iv4MmLqOHeKyJPZI+eKrRpp9LHIWZ1a4Lwa+/qz9ky2pM=
X-Google-Smtp-Source: AGHT+IE0wORkD6pr4U4z9t7gs611kg67MGiYa52JMh5ONOt3fIFRWAhH+wStlHElGCaFj5DbYOXlXA==
X-Received: by 2002:a92:cda8:0:b0:375:9dd4:d693 with SMTP id e9e14a558f8ab-395553328c2mr95714975ab.3.1721375789914;
        Fri, 19 Jul 2024 00:56:29 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70cff4914b2sm675676b3a.33.2024.07.19.00.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 00:56:29 -0700 (PDT)
From: Jian-Hong Pan <jhp@endlessos.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Johan Hovold <johan@kernel.org>,
	David Box <david.e.box@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@endlessos.org,
	Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH v8 1/4] PCI: vmd: Set PCI devices to D0 before enable PCI PM's L1 substates
Date: Fri, 19 Jul 2024 15:55:31 +0800
Message-ID: <20240719075530.10852-2-jhp@endlessos.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240719075200.10717-2-jhp@endlessos.org>
References: <20240719075200.10717-2-jhp@endlessos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The remapped PCIe Root Port and the child device have PCI PM L1 substates
capability, but they are disabled originally.

Here is a failed example on ASUS B1400CEAE:

Capabilities: [900 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substates+
                  PortCommonModeRestoreTime=32us PortTPowerOnTime=10us
        L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
                   T_CommonMode=0us LTR1.2_Threshold=0ns
        L1SubCtl2: T_PwrOn=10us

Power on all of the VMD remapped PCI devices to D0 before enable PCI-PM L1
PM Substates by following "PCIe r6.0, sec 5.5.4".

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218394
Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
v2:
- Power on the VMD remapped devices with pci_set_power_state_locked()
- Prepare the PCIe LTR parameters before enable L1 Substates
- Add note into the comments of both pci_enable_link_state() and
  pci_enable_link_state_locked() for kernel-doc.
- The original patch set can be split as individual patches.

v3:
- Re-send for the missed version information.
- Split drivers/pci/pcie/aspm.c modification into following patches.
- Fix the comment for enasuring the PCI devices in D0.

v4:
- The same

v5:
- Tweak the commit title and message
- Change the goto label from out_enable_link_state to out_state_change

v6~8:
- The same

 drivers/pci/controller/vmd.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index a726de0af011..d021129d661c 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -751,11 +751,9 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
 	if (!(features & VMD_FEAT_BIOS_PM_QUIRK))
 		return 0;
 
-	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
-
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
 	if (!pos)
-		return 0;
+		goto out_state_change;
 
 	/*
 	 * Skip if the max snoop LTR is non-zero, indicating BIOS has set it
@@ -763,7 +761,7 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
 	 */
 	pci_read_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, &ltr_reg);
 	if (!!(ltr_reg & (PCI_LTR_VALUE_MASK | PCI_LTR_SCALE_MASK)))
-		return 0;
+		goto out_state_change;
 
 	/*
 	 * Set the default values to the maximum required by the platform to
@@ -775,6 +773,13 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
 	pci_write_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, ltr_reg);
 	pci_info(pdev, "VMD: Default LTR value set by driver\n");
 
+out_state_change:
+	/*
+	 * Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
+	 * PCIe r6.0, sec 5.5.4.
+	 */
+	pci_set_power_state_locked(pdev, PCI_D0);
+	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
 	return 0;
 }
 
-- 
2.45.2



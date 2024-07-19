Return-Path: <linux-kernel+bounces-257065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 672DA9374B0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 10:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C82B2812BF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204A25C614;
	Fri, 19 Jul 2024 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="af0l+luh"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5645811A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 08:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721376254; cv=none; b=GqKzfJpYhIJTIHnXyT/rg8fORid/fJt9JOd4qb7zvR6gM34bBqPzOwAQPMfbe6Aclp74lGlnpLGoaYnWJ7EPuDA764fBlFva/vwhkfL2l0s33nDyyO7hc9B2uz2LwWfjpbQtVS+Tms65koq7t4pTQBstr6HL7Am/vQ9Cqd4nbHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721376254; c=relaxed/simple;
	bh=jTRf7xZ3ujh53lj7xh+rpGBs5RvvdwAlNUcJwKLpMmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0A1JY9af5z5k9WRyhyeXvLialgM4YgfkFmoqCeJn8hPn2gRz59tVDmxJbxSCgcUiPZoRCEydBLuMZIhJ1XQlVW6XLlp4QAaaxL4SVcxhEq416zujmhbT3FafG1fJIPbmyUjGlt+adO4Ii75qvlP0ewuNNQzTA2bJAj+tbIn9E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=af0l+luh; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fc49c1f3e5so16166635ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 01:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1721376252; x=1721981052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uY5/vXX2UA8wdmQpH2tTJS3cs9Ik563y6vUWoxRDgb4=;
        b=af0l+luhk+QmrUlBVOekk1yYjiAj9by+5qT/ce0KboCVhtWpMDxm2vlY/ByeQAXfPq
         5pxrlmpLLd33/8bqCn5IltKWC+Sa280OpjHtaL8559Xn23t8le0p4lBGqr9QnLkQyNm8
         4lWSSDanZlG9ZDOSW3KO9nBIRLE779v9Wxi6Mgc2AM4HfLDVz9zkhkCYTcVbMVZdREh+
         rCKydihXlWwkOd0gxnnKrKK+CKOKNtzDSkwJewaYByPoJGIDKhu1Vq/BxHJhjdKR0/Gc
         OloRQkRgP/bAuTT5QYRoBSjDa1GWYt7AUEiHxUNEPSMXWkgTKX1GcWeiV1APCA/fMwT4
         Symw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721376252; x=1721981052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uY5/vXX2UA8wdmQpH2tTJS3cs9Ik563y6vUWoxRDgb4=;
        b=K+cas2TES1Lj3sFTXJRdB7W1XkK/3/v9kFVBdq2pgJ7TCHKXXW7Y43wJBWCuzCWzpw
         SX34HOwNCmXrdDtgGVHYGs05zQqrmacGAGR7Oycseb+YE2Sh62H2Bnm+6siK6/W+l49p
         rk3W52UzjFtQoc/X8YWBmHoTiyxjet5vmRHOSW1yehsuXuXRxW1vrRt0MnpjVLommfgq
         6MlHK63XxIOZYoF/QsF0Rx4i3VOl3LXzHt3PwlyismzFLVx5GdqitKqiYPcZ3mgLNOlm
         V7xYbE4YD2KDHZIpRXRGHtWrTzx/HbaHFIK7XdCln2zMVYYjeW6i7pRJF+sfd1cbgSbf
         vV/A==
X-Forwarded-Encrypted: i=1; AJvYcCVfzc/KsNRu35W61SshD+kgWB5EQffNlHUpj+Wqgb9a3he+OR2FO2hwmCaxNe7Nb1aRBnysA9hBEiwllOr+zhoNf3MweRq0mJ1E73Xj
X-Gm-Message-State: AOJu0Yzz5qWmi9ryO8xrhGREFwYpAceruoiPEU0fTN3oEo7+iodVkaFU
	od7ivHYaqm454E7egqGPHxS1DpXL3QbbH5oXvQxrw2/D5KLSVbw02MAR+9RnNqEFfOobgpRJa/J
	DD9A=
X-Google-Smtp-Source: AGHT+IFCGZ0EyKLoSp8zm5CM41G3ClPJ/b1OF2cL9FgGrTsPn5xM7KvYEBALJOfUsG655oWGIzuVhA==
X-Received: by 2002:a17:902:ea04:b0:1fb:9a83:4496 with SMTP id d9443c01a7336-1fc4e11f2e5mr63727195ad.2.1721376251496;
        Fri, 19 Jul 2024 01:04:11 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fd64b5112csm8263615ad.1.2024.07.19.01.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 01:04:11 -0700 (PDT)
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
	Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@endlessos.org,
	Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH v8 4/4] PCI/ASPM: Fix L1.2 parameters when enable link state
Date: Fri, 19 Jul 2024 16:02:56 +0800
Message-ID: <20240719080255.10998-2-jhp@endlessos.org>
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

Currently, when enable link's L1.2 features with __pci_enable_link_state(),
it configs the link directly without ensuring related L1.2 parameters, such
as T_POWER_ON, Common_Mode_Restore_Time, and LTR_L1.2_THRESHOLD have been
programmed.

This leads the link's L1.2 between PCIe Root Port and child device gets
wrong configs when a caller tries to enabled it.

Here is a failed example on ASUS B1400CEAE with enabled VMD:

10000:e0:06.0 PCI bridge: Intel Corporation 11th Gen Core Processor PCIe Controller (rev 01) (prog-if 00 [Normal decode])
    ...
    Capabilities: [200 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
        	  PortCommonModeRestoreTime=45us PortTPowerOnTime=50us
        L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
        	   T_CommonMode=45us LTR1.2_Threshold=101376ns
        L1SubCtl2: T_PwrOn=50us

10000:e1:00.0 Non-Volatile memory controller: Sandisk Corp WD Blue SN550 NVMe SSD (rev 01) (prog-if 02 [NVM Express])
    ...
    Capabilities: [900 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substates+
                  PortCommonModeRestoreTime=32us PortTPowerOnTime=10us
        L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
                   T_CommonMode=0us LTR1.2_Threshold=0ns
        L1SubCtl2: T_PwrOn=10us

According to "PCIe r6.0, sec 5.5.4", before enabling ASPM L1.2 on the PCIe
Root Port and the child NVMe, they should be programmed with the same
LTR1.2_Threshold value. However, they have different values in this case.

Invoke aspm_calc_l12_info() to program the L1.2 parameters properly before
enable L1.2 bits of L1 PM Substates Control Register in
__pci_enable_link_state().

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218394
Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
---
v2:
- Prepare the PCIe LTR parameters before enable L1 Substates

v3:
- Only enable supported features for the L1 Substates part

v4:
- Focus on fixing L1.2 parameters, instead of re-initializing whole L1SS

v5:
- Fix typo and commit message
- Split introducing aspm_get_l1ss_cap() to "PCI/ASPM: Introduce
  aspm_get_l1ss_cap()"

v6:
- Skipped

v7:
- Pick back and rebase on the new version kernel
- Drop the link state flag check. And, always config link state's timing
  parameters

v8:
- Because pcie_aspm_get_link() might return the link as NULL, move
  getting the link's parent and child devices after check the link is
  not NULL. This avoids NULL memory access.

 drivers/pci/pcie/aspm.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 5db1044c9895..55ff1d26fcea 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1411,9 +1411,15 @@ EXPORT_SYMBOL(pci_disable_link_state);
 static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
 {
 	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
+	u32 parent_l1ss_cap, child_l1ss_cap;
+	struct pci_dev *parent, *child;
 
 	if (!link)
 		return -EINVAL;
+
+	parent = link->pdev;
+	child = link->downstream;
+
 	/*
 	 * A driver requested that ASPM be enabled on this device, but
 	 * if we don't have permission to manage ASPM (e.g., on ACPI
@@ -1428,6 +1434,15 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
 	if (!locked)
 		down_read(&pci_bus_sem);
 	mutex_lock(&aspm_lock);
+	/*
+	 * Ensure L1.2 parameters: Common_Mode_Restore_Times, T_POWER_ON and
+	 * LTR_L1.2_THRESHOLD are programmed properly before enable bits for
+	 * L1.2, per PCIe r6.0, sec 5.5.4.
+	 */
+	parent_l1ss_cap = aspm_get_l1ss_cap(parent);
+	child_l1ss_cap = aspm_get_l1ss_cap(child);
+	aspm_calc_l12_info(link, parent_l1ss_cap, child_l1ss_cap);
+
 	link->aspm_default = pci_calc_aspm_enable_mask(state);
 	pcie_config_aspm_link(link, policy_to_aspm_state(link));
 
-- 
2.45.2



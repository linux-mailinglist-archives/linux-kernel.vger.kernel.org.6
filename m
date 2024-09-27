Return-Path: <linux-kernel+bounces-341624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D291698829D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 12:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86A342838DB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B7D188CD5;
	Fri, 27 Sep 2024 10:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="jSGCrRrA"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A76185956
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 10:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727433413; cv=none; b=IePHif1UJjDiUex/XuGiVCnQR80CvuxNpKqipB9BQeyyoaOaxEFCo5Yi3HXkNtqDzVXS0xTJR1RPUAQqvlloRCL1JC7zLA0ZJE+3HSG5IHHmfOg9ccTyD8bvHrlAOaQmPEuNxU7FImbtz9/HxJ/qMfiSqHrgMClygR+QZ4Gi0gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727433413; c=relaxed/simple;
	bh=y3FXP+giOaa0bTHNOIiOqrz67Of+uUBaKr7xcqryCuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MhQvdaKh83t1tcHEqOwmssCCo9t+bfUXRnnziJ4UV7eZLJA4C3g+rDPfiydYNMuxFrzURUkSsz7pKgB0dokbh1++y7f//dvRHvqQZzMPjYmkomxgB76qf/ifxvG+6QGbNxyRBPJ2xf29INzAbHYrhrGajorBNrB0E/opFBRw0Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=jSGCrRrA; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e06acff261so1479118a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 03:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1727433411; x=1728038211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G55JHJhI3qkxlwOlcFB2xhqazWP5g+D6GuyYd2HAN1Q=;
        b=jSGCrRrAOdE7/wjdcR20hhFGpGuuD/eAAqySx1LVLYIP/mOGevML0Lc1/EV74Y5nOJ
         PBDExRN501LK8WqEtm/eoUfu4+nrdhduVNns8yeNqZlQ0VmnmsOY3Tpr+Pui6FJV2MbZ
         DNSqwA9luvWFZsRcdfNzmG/TgtoK4vvw1oJ5URH4sLojLPtZSwY5Eola3MJfc38ySMb8
         WCVEHbGh89xd2dGJB34g7v1elf4+NWftq2CV5WsouJkdhrWNdTsuOH5wBhOxiUjlOLcy
         r+zh/i1mgblvjbwlhV+y5TLL6xqCY8cOM/c4HL535yAA7bIi6bcirRUbwg0veJGoCAfS
         8+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727433411; x=1728038211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G55JHJhI3qkxlwOlcFB2xhqazWP5g+D6GuyYd2HAN1Q=;
        b=YueqOj7ld592oy/P+TTR0G8nhYaNtTnCPDINIHTR0ZYwUudtcWS9PLZBVQK8B/6m2J
         NbDIdnaG3lHczFi5i3aBxwp6jdDUmBHwJaZbzyYGl5XciaoRl2RO3B8XANHRXILi9RDC
         g36HB8KzwIGqk7J115KqZclVqEHjcboSwEvIdZ/WCwrvuMsExu86Tso4a9l6wRRv4MAv
         2Qu+pOLoboxMPM6wW4X/sWFEnyf6Tqh2OzFo43OSRumkSSkxy4N1rDOktzkaVnQGP/Oh
         t8ZJdBF0p4emGfkBDJXof/fIASr4CLciAA9od2zURBkv7m0rmfbr89kvhclBqtplxgH6
         b/3w==
X-Forwarded-Encrypted: i=1; AJvYcCXgyW66fTB5wK7059hSEIyBN1cCbKFxoWRbSDt/+tyBnvzIX0OBJegIkYpUjpGUXXA7XU+IxtIwy7bCD9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwydVc4eum3J/6ugESyVb6fX8Mt2Quwq2uhltsmvX0/F5XIvDqm
	HeKN2njGOoqw/XfmagS+xUW6OPAXlqv/UkNt7ScZGS5LoMQ8Yrcf8ztUZQS3yHg=
X-Google-Smtp-Source: AGHT+IEOCmycZY2cGaK5utdLVzhwCqkIWWFB/+435nxWSLC1tqzJCayG612KqIrzMA24Q+k1herCcA==
X-Received: by 2002:a17:90b:360c:b0:2d3:c87e:b888 with SMTP id 98e67ed59e1d1-2e0b8ebcd31mr3051772a91.27.1727433411235;
        Fri, 27 Sep 2024 03:36:51 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2e06e1cd35asm5177819a91.24.2024.09.27.03.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 03:36:50 -0700 (PDT)
From: Jian-Hong Pan <jhp@endlessos.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Johan Hovold <johan@kernel.org>,
	David Box <david.e.box@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@endlessos.org,
	Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH v10 1/3] PCI: vmd: Set PCI devices to D0 before enable PCI PM's L1 substates
Date: Fri, 27 Sep 2024 18:36:12 +0800
Message-ID: <20240927103612.24582-1-jhp@endlessos.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240927103231.24244-2-jhp@endlessos.org>
References: <20240927103231.24244-2-jhp@endlessos.org>
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
		   T_CommonMode=0us LTR1.2_Threshold=101376ns
	L1SubCtl2: T_PwrOn=50us

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

v9:
- Update L1 PM Substates information against kernel v6.11 in commit message

v10:
- The same

 drivers/pci/controller/vmd.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 264a180403a0..11870d1fc818 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -740,11 +740,9 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
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
@@ -752,7 +750,7 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
 	 */
 	pci_read_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, &ltr_reg);
 	if (!!(ltr_reg & (PCI_LTR_VALUE_MASK | PCI_LTR_SCALE_MASK)))
-		return 0;
+		goto out_state_change;
 
 	/*
 	 * Set the default values to the maximum required by the platform to
@@ -764,6 +762,13 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
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
2.46.2



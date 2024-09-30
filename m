Return-Path: <linux-kernel+bounces-343613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CABE6989D45
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3984AB24E48
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0622117C9F1;
	Mon, 30 Sep 2024 08:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="uK0hMHep"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E1F13DB92
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 08:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727686247; cv=none; b=eVPAImT6j40vsQUS4GWVisPUTpe+poLCG52Im+Mx+3GR0QQa4x0W79Pp3GIXwgNCEg5z5sNQ0oN2Dz/jJEpCaVVvmg4tIlnWWCAhX82eJ7d2YMilg3LLAUxc1IXweaJI9Iwak0ca9jSJ0GR2Z3zp4PjxH/jWnpc/JVixqLUaE74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727686247; c=relaxed/simple;
	bh=wy8iguslFVZzliXZzcb7u5HzE+VreSnr3UBebpFQFQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rn1m2vxufnlpKxS8vQvFhtQI3SevImcBmnhNKNjGqwlfjzbzEKa50/W0xcSPrv0sRQ60OrOrvcwSwF2vRSbP32NMpk/yjMJNO2Qpaq6DP0mzFkK5OQq7H7FchoZeJ19jFIpIdV6lVF0052P5qR1StvEsUM1q/+3YhjAcJIk5OYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=uK0hMHep; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-710f388621fso2358453a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 01:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1727686245; x=1728291045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLrW+tcCwGzFsdKdM1MlS8ifGjFaL9ZszhdYigwLq14=;
        b=uK0hMHepV9sqegixB0px2uspnWUQRxvkcRhaHvinybFjeJAjE6LUcVgj4zgEvtqTQK
         jE/jft8983KK+Ez/fxtqHgYePAt3xNJX+YH+j9ECraLXdNyZv7vDdtrWm+xgIdFbcIrt
         WjOp7VuPxuzkbC4IiyDBWwEeuNI/tnhrz/1DaNXaGtg5AvdEk6oCYh8HWIAXEyQErJfZ
         MCTmoYEL/pu7y9YEBEOLTw3oflJMoRZxHze3Rf2CuHNxbslz0Sb78WVciHBMjbpieITJ
         dFSJPHxkv3Znqek4nSA2XL7FHCf4nXVXR5oHwFRO23seiNp4PjTj8EM5vEPHrhsMGYKK
         fQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727686245; x=1728291045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLrW+tcCwGzFsdKdM1MlS8ifGjFaL9ZszhdYigwLq14=;
        b=b9sD+pzNQjKYAEjrFJTDJZUzVLC82bbakg7okjRRpOihaawUnNrHGnvneKJsOjvUGS
         AK+uSz8gZGbu2aO0aVBCZ+c3y5LWscmWwb3e0nGvVlSPVGT3CMLmZmTd3TUZdaw6PC7L
         vIoxGawPJYoj3zYa0cqLOShQ4kBiOwrSxn0nyM4JjnJp8TV1Tcd483gCPy2rAUGq00rO
         M/ZpjsYugbrEa5MhDcQKHqB2ghUSxTKJ3qtCCL3QRALkD9ksW02HDWjN2EnK9EqV9Y/X
         NDJ684wjs21qvFDwNezj0t2ZUj0W4OgxsKxq5twgZnmK3Vt/os9OrKyqCA7bJZPeGhXg
         WhYA==
X-Forwarded-Encrypted: i=1; AJvYcCWVhA8OuykMBdtAaf6qdlqnvfwx2j9tuYC9iteN0P6L68oCksY+/IJztxUI+we1sFKAsOaJnzTvJwlVGpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJAOzyNfV9oQD/Fz9fUSprSxjXRc5SJct6o3m65Mnc/aBJIdDo
	kURnrhAE/TsOeMMlzlAN9rw5JOuXP2QpbmiMSxAz6/6TMBCJkz0tvGreFu7DXjI=
X-Google-Smtp-Source: AGHT+IFyyp6eFLEn3sXlZ0ElQTe1UiezE8XG1edMjtjXlT5v9Thax5iUWOArVnhiE0IP7SiSrq6/QQ==
X-Received: by 2002:a05:6830:6009:b0:710:f200:eb55 with SMTP id 46e09a7af769-714fbe751a7mr7138673a34.1.1727686244777;
        Mon, 30 Sep 2024 01:50:44 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71b26498b26sm5734857b3a.9.2024.09.30.01.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 01:50:44 -0700 (PDT)
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
Subject: [PATCH v11 3/3] PCI/ASPM: Make pci_save_aspm_l1ss_state save both child and parent's L1SS configuration
Date: Mon, 30 Sep 2024 16:49:54 +0800
Message-ID: <20240930084953.13454-2-jhp@endlessos.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930082530.12839-2-jhp@endlessos.org>
References: <20240930082530.12839-2-jhp@endlessos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

PCI devices' parameters on the VMD bus have been programmed properly
originally. But, cleared after pci_reset_bus() and have not been restored
correctly. This leads the link's L1.2 between PCIe Root Port and child
device gets wrong configs.

Here is a failed example on ASUS B1400CEAE with enabled VMD. Both PCIe
bridge and NVMe device should have the same LTR1.2_Threshold value.
However, they are configured as different values in this case:

10000:e0:06.0 PCI bridge [0604]: Intel Corporation 11th Gen Core Processor PCIe Controller [8086:9a09] (rev 01) (prog-if 00 [Normal decode])
  ...
  Capabilities: [200 v1] L1 PM Substates
    L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
      PortCommonModeRestoreTime=45us PortTPowerOnTime=50us
    L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
      T_CommonMode=0us LTR1.2_Threshold=0ns
    L1SubCtl2: T_PwrOn=0us

10000:e1:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD Blue SN550 NVMe SSD [15b7:5009] (rev 01) (prog-if 02 [NVM Express])
  ...
  Capabilities: [900 v1] L1 PM Substates
    L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substates+
      PortCommonModeRestoreTime=32us PortTPowerOnTime=10us
    L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
      T_CommonMode=0us LTR1.2_Threshold=101376ns
    L1SubCtl2: T_PwrOn=50us

Here is VMD mapped PCI device tree:

-+-[0000:00]-+-00.0  Intel Corporation Device 9a04
 | ...
 \-[10000:e0]-+-06.0-[e1]----00.0  Sandisk Corp WD Blue SN550 NVMe SSD
              \-17.0  Intel Corporation Tiger Lake-LP SATA Controller

When pci_reset_bus() resets the bus [e1] of the NVMe, it only saves and
restores NVMe's state before and after reset. The bus [e1] has only one
NVMe device, so the NVMe's parent PCIe bridge is missed to be saved.
However, when it restores the NVMe's state, ASPM code restores L1SS for
both the parent bridge and the NVMe in pci_restore_aspm_l1ss_state().
Although the NVMe's L1SS is restored correctly, the parent bridge's L1SS is
restored with a wrong value 0x0. Because, the parent bridge's L1SS was not
saved by pci_save_aspm_l1ss_state() before reset.

So, if the PCI device has a parent, make pci_save_aspm_l1ss_state() save
the parent's L1SS configuration, too. This is symmetric on
pci_restore_aspm_l1ss_state().

Link: https://lore.kernel.org/linux-pci/CAPpJ_eexU0gCHMbXw_z924WxXw0+B6SdS4eG9oGpEX1wmnMLkQ@mail.gmail.com/
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218394
Fixes: 17423360a27a ("PCI/ASPM: Save L1 PM Substates Capability for suspend/resume")
Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
v9:
- Drop the v8 fix about drivers/pci/pcie/aspm.c. Use this in VMD instead.

v10:
- Drop the v9 fix about drivers/pci/controller/vmd.c
- Fix in PCIe ASPM to make it symmetric between pci_save_aspm_l1ss_state()
  and pci_restore_aspm_l1ss_state()

v11:
- Introduce __pci_save_aspm_l1ss_state as a resusable helper function
  which is same as the original pci_configure_aspm_l1ss
- Make pci_save_aspm_l1ss_state invoke __pci_save_aspm_l1ss_state for
  both child and parent devices
- Smooth the commit message

 drivers/pci/pcie/aspm.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index bd0a8a05647e..17cdf372f7e0 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -79,7 +79,7 @@ void pci_configure_aspm_l1ss(struct pci_dev *pdev)
 			ERR_PTR(rc));
 }
 
-void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
+static void __pci_save_aspm_l1ss_state(struct pci_dev *pdev)
 {
 	struct pci_cap_saved_state *save_state;
 	u16 l1ss = pdev->l1ss;
@@ -101,6 +101,24 @@ void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
 	pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, cap++);
 }
 
+void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
+{
+	struct pci_dev *parent;
+
+	__pci_save_aspm_l1ss_state(pdev);
+
+	/*
+	 * To be symmetric on pci_restore_aspm_l1ss_state(), save parent's L1
+	 * substate configuration, if the parent has not saved state.
+	 */
+	if (!pdev->bus || !pdev->bus->self)
+		return;
+
+	parent = pdev->bus->self;
+	if (!parent->state_saved)
+		__pci_save_aspm_l1ss_state(parent);
+}
+
 void pci_restore_aspm_l1ss_state(struct pci_dev *pdev)
 {
 	struct pci_cap_saved_state *pl_save_state, *cl_save_state;
-- 
2.46.2



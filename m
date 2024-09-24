Return-Path: <linux-kernel+bounces-336676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F29C983F19
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F351D1F2294D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 07:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6736146D53;
	Tue, 24 Sep 2024 07:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="ZjUqXY14"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A1780C1C
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 07:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727163050; cv=none; b=TdINgrGF28z8f94YDB6/aY99dRJIRqGTW/wFheNiQJU/DSeEp211AY45dgtH3Ko9KRiah+aASoQ+0x9VbiRN8mLwVDHYWcWION6c95lkCb3QYteqMkXHcaWNY/7iwvX4QmPFdF1ykAG9ghB0xhvVfd/y49100CTIlLzBxwc/v1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727163050; c=relaxed/simple;
	bh=Io2e8sR2b43y3WIcEHaQwF43fQuzPU2cLraygvnVFQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khP3seOFoHeZ35Vcuuie+DhchM4fIMdc+kivSmo87FlI6Ixke0YnTIalm3MzzG4E0cc3nWh0V93tP6iaNhpeI9O/i4V8X3HGAQ+hkNeUJWPdg2Jpqub9Wx01MusVe8B5GHGn1OcBabC5D8bHtq9/wpGjPkUj6Wp3S/40a9P+oX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=ZjUqXY14; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-277ef9a4d11so2142158fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 00:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1727163047; x=1727767847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Vs1iiE3td9GEXbCoIhFdbgrLQRtaEywEsGPYjRBlwo=;
        b=ZjUqXY14qYief/lxiF5oTFAcTyiziy2SKP6qqU1GttFqp7Ko4SqxpbuMf+ficti6dS
         yUOMDf48B9SurlTekzt7oJy7/DtSxQW8aEqcvKBiYM/tktqbBgXno+AkFIXZeUEy1CfJ
         6N8m3sHJoldLMaOxziRMOi0YxdQoLrbCrl0W4vECuJy7sEVlG2T16TNErLWWHT5qBGRT
         D6cTNTt4omaqNzZWLXVNW8aiSxJkKmmEgJmf3lscjZllkdSim3i4zBwDOdrLgOpennEg
         ktuwpNngPy/cHMd7pMRyPhHEdDCotFO6JWFUyp5OCHszfE4BAlWL34slydWfY8flFPu6
         5U2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727163047; x=1727767847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Vs1iiE3td9GEXbCoIhFdbgrLQRtaEywEsGPYjRBlwo=;
        b=uxtxlv4cDuhC1HsBnEVMk93kK8NwmvKhk3TrVuFQsrpVd0f2+4uYR1qaC2auSNUJl6
         8kdIXgYNsqi5D5sNZ19UTgIgyfWrOL7lQf6cLEcUqSXbJFWs4gEUy5CWzr24KaqYyRcb
         Q05XQ0L/YjlQXpl24WzSyxbetU+dm4a2l/qN6v52CddY9xRt5dEccrBSlB7lFwgRZmfC
         kLWM1ajdCas2VGhPOBm5mvHWZFIvKflAxA1joqZSAj3N+PJhhDMmtdidV7MphPilS43h
         +P71IsCDBmxif4dIOeTI53ZQkA40/sLVYTQHB6HIDt33HsGGNxaXDhaWDR3AiALI33DP
         N3gw==
X-Forwarded-Encrypted: i=1; AJvYcCWgsaJmVZ6MD4bnNaYjGNw+IN8UkwerUomhBYVTakjG3ku+awQnxKoTh93gXNZ/kkcw6nQliaTFTjijseg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4EbX3oegKEHcOOfCVfKDgbhfbGqWgRM0ODo4SR7FxHef6p4B8
	b1VtqPABYm/qDVT40kWwGHYf+ENQRxMMI5q/HbserDjx8s0H1MrGZ/PL3FucFzI=
X-Google-Smtp-Source: AGHT+IHezUjchVICcSwZFfFfrE/47nceOgC12FAXIYBCUf1b2OCTgPU2o6ID1sRV3TuR7apW1nA14w==
X-Received: by 2002:a05:6870:5b88:b0:277:eea4:a436 with SMTP id 586e51a60fabf-2803a57f035mr8431095fac.7.1727163047552;
        Tue, 24 Sep 2024 00:30:47 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71afc8342dfsm663723b3a.3.2024.09.24.00.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 00:30:47 -0700 (PDT)
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
Subject: [PATCH v9 3/3] PCI: vmd: Save/restore PCIe bridge states before/after pci_reset_bus()
Date: Tue, 24 Sep 2024 15:29:00 +0800
Message-ID: <20240924072858.15929-3-jhp@endlessos.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240924070551.14976-2-jhp@endlessos.org>
References: <20240924070551.14976-2-jhp@endlessos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
restores NVMe's state before and after reset. Because bus [e1] has only one
device: 10000:e1:00.0 NVMe. The PCIe bridge is missed. However, when it
restores the NVMe's state, it also restores the ASPM L1SS between the PCIe
bridge and the NVMe by pci_restore_aspm_l1ss_state(). The NVMe's L1SS is
restored correctly. But, the PCIe bridge's L1SS is restored with the wrong
value 0x0. Becuase, the PCIe bridge's state is not saved before reset.
That is why pci_restore_aspm_l1ss_state() gets the parent device (PCIe
bridge)'s saved state capability data and restores L1SS with value 0.

So, save the PCIe bridge's state before pci_reset_bus(). Then, restore the
state after pci_reset_bus(). The restoring state also consumes the saving
state.

Link: https://www.spinics.net/lists/linux-pci/msg159267.html
Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
---
v9:
- Drop the v8 fix about drivers/pci/pcie/aspm.c. Use this in VMD instead.

 drivers/pci/controller/vmd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 11870d1fc818..2820005165b4 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -938,9 +938,16 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		if (!list_empty(&child->devices)) {
 			dev = list_first_entry(&child->devices,
 					       struct pci_dev, bus_list);
+			/* To avoid pci_reset_bus restore wrong ASPM L1SS
+			 * configuration due to missed saving parent device's
+			 * states, save & restore the parent device's states
+			 * as well.
+			 */
+			pci_save_state(dev->bus->self);
 			ret = pci_reset_bus(dev);
 			if (ret)
 				pci_warn(dev, "can't reset device: %d\n", ret);
+			pci_restore_state(dev->bus->self);
 
 			break;
 		}
-- 
2.46.1



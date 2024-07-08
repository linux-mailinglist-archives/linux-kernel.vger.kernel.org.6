Return-Path: <linux-kernel+bounces-244551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA0C92A5E0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 17:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 859C6282CDA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 15:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEBB1E898;
	Mon,  8 Jul 2024 15:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZFbTujmY"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E8113B7A3
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 15:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720453105; cv=none; b=GYmgdaVMsJB9dkiwmxyqW9gQ3uMng5DShSIyGJHnyRK9B0WNEw9fzQo2RgWbmqephY/uo7voNNn91NDsfi/i5arclOHPlODLwdGPjVSFRuO2Fwlx+vRH8BGKLVW0ESxx5v6e57URyOjyb6ApnzAu915K9KIEegG3bSUtbtiyXkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720453105; c=relaxed/simple;
	bh=aGp3pPD0oenYfC7jSBCPniKrqyp0afq6xNim1DW4trA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PzEc6U0iknvY3K7Wq5atoGmccFYL44rYm8EDk0bNXqTx6HJJ0pm3fSMxqhpkDnu96g+7Tz+dx9GnkmLYln7Np+AwszzhdFrlb9raYt/gcc7xYv8saFFo6LVfIWMx4tGFUZOPfDm3xL+Uo7Zs1kTJ9HHe3Pcz800+rWJ/VVxvCzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZFbTujmY; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a77c080b521so446896866b.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 08:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720453101; x=1721057901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w34rqWgCcHq9KaDMcF1K9V05O8+jp85pDo61liIVZb8=;
        b=ZFbTujmY41BMVQhEh3J13mHA3VyGKleXAjnPuK00CzX36KND+O73plCYK5Fh3cWLwb
         JWhCVqWq78R/B/dTwUy2hFTC+v9cZmPygWTQpqHkniYin84U/K/kUhGuBfyoxU9bL5IY
         qZThLm/Vwey3Q+AN28C1r3a7BoNepFMwq5Q+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720453101; x=1721057901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w34rqWgCcHq9KaDMcF1K9V05O8+jp85pDo61liIVZb8=;
        b=t2Y7SmYu1tMlzPV99cbFgpXgLND7LDQIIWmzNpSlq+p1i1hmky8JFCrTZUDTVr4ldk
         KBeOiPL/SmMtGdUBMfKttPsPhmLaV1cRzCpGSlOJZqk981yd3fOXFzd4dvEL7BDWPE0j
         VpmpesL3OqwvUaa9KLLAx9sVvokK9gz3nnJHDibl9M69lfgMqBb2Lf2kNn8SL0h7SU2V
         l5NZi7DTjrqyvpn+cpVCaKwm+v9AriGnKYA3IqRKsG63ZZ0rg0EumD9aKWpDLTmcocG8
         9NS/Wd5lCVlmvBHKf+kSpilcUT1pWKqwlvyfxmoUX/kEZt40WvBytSvibXBFJIpMSqUA
         1V1Q==
X-Gm-Message-State: AOJu0YwDa5ckCMoeOCvoJhudGp3xqSsg4lUZUvPM5gsu3UTGoMMcFbZJ
	FV+OMTq4G3o3pXLKEpTqxBvm8pBbT8FFxzWfDpiUxgwPRTF4L0bRjqFsMZqgEw==
X-Google-Smtp-Source: AGHT+IGfJf5E1FlCxXlb7YlvLUM/aRKQi1x9rGPaCigLwsDmfBL68P5j1meHpALFop4+7XnPv7nNBw==
X-Received: by 2002:a17:907:2d94:b0:a77:e715:f10e with SMTP id a640c23a62f3a-a77e715f293mr444110166b.71.1720453101497;
        Mon, 08 Jul 2024 08:38:21 -0700 (PDT)
Received: from danielgeorgem.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a8545adsm3881866b.159.2024.07.08.08.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 08:38:21 -0700 (PDT)
From: George-Daniel Matei <danielgeorgem@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI: r8169: add suspend/resume aspm quirk
Date: Mon,  8 Jul 2024 15:38:15 +0000
Message-ID: <20240708153815.2757367-1-danielgeorgem@chromium.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added aspm suspend/resume hooks that run
before and after suspend and resume to change
the ASPM states of the PCI bus in order to allow
the system suspend while trying to prevent card hangs

Signed-off-by: George-Daniel Matei <danielgeorgem@chromium.org>
---
 drivers/pci/quirks.c | 142 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index dc12d4a06e21..aa3dba2211d3 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6189,6 +6189,148 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b0, aspm_l1_acceptable_latency
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b1, aspm_l1_acceptable_latency);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c0, aspm_l1_acceptable_latency);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c1, aspm_l1_acceptable_latency);
+
+static const struct dmi_system_id chromebox_match_table[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Brask"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
+		}
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aurash"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
+		}
+	},
+		{
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Bujia"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
+		}
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Gaelin"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
+		}
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Gladios"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
+		}
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Hahn"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
+		}
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Jeev"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
+		}
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Kinox"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
+		}
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Kuldax"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
+		}
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Lisbon"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
+		}
+	},
+	{
+			.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Moli"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
+		}
+	},
+	{ }
+};
+
+static void rtl8169_suspend_aspm_settings(struct pci_dev *dev)
+{
+	u16 val = 0;
+
+	if (dmi_check_system(chromebox_match_table)) {
+		//configure parent
+		pcie_capability_clear_and_set_word(dev->bus->self,
+						   PCI_EXP_LNKCTL,
+						   PCI_EXP_LNKCTL_ASPMC,
+						   PCI_EXP_LNKCTL_ASPM_L1);
+
+		pci_read_config_word(dev->bus->self,
+				     dev->bus->self->l1ss + PCI_L1SS_CTL1,
+				     &val);
+		val = (val & ~PCI_L1SS_CTL1_L1SS_MASK) |
+		      PCI_L1SS_CTL1_PCIPM_L1_2 | PCI_L1SS_CTL1_PCIPM_L1_2 |
+		      PCI_L1SS_CTL1_ASPM_L1_1;
+		pci_write_config_word(dev->bus->self,
+				      dev->bus->self->l1ss + PCI_L1SS_CTL1,
+				      val);
+
+		//configure device
+		pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
+						   PCI_EXP_LNKCTL_ASPMC,
+						   PCI_EXP_LNKCTL_ASPM_L1);
+
+		pci_read_config_word(dev, dev->l1ss + PCI_L1SS_CTL1, &val);
+		val = (val & ~PCI_L1SS_CTL1_L1SS_MASK) |
+		      PCI_L1SS_CTL1_PCIPM_L1_2 | PCI_L1SS_CTL1_PCIPM_L1_2 |
+		      PCI_L1SS_CTL1_ASPM_L1_1;
+		pci_write_config_word(dev, dev->l1ss + PCI_L1SS_CTL1, val);
+	}
+}
+
+DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_REALTEK, 0x8168,
+			  rtl8169_suspend_aspm_settings);
+
+static void rtl8169_resume_aspm_settings(struct pci_dev *dev)
+{
+	u16 val = 0;
+
+	if (dmi_check_system(chromebox_match_table)) {
+		//configure device
+		pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
+						   PCI_EXP_LNKCTL_ASPMC, 0);
+
+		pci_read_config_word(dev->bus->self,
+				     dev->bus->self->l1ss + PCI_L1SS_CTL1,
+				     &val);
+		val = val & ~PCI_L1SS_CTL1_L1SS_MASK;
+		pci_write_config_word(dev->bus->self,
+				      dev->bus->self->l1ss + PCI_L1SS_CTL1,
+				      val);
+
+		//configure parent
+		pcie_capability_clear_and_set_word(dev->bus->self,
+						   PCI_EXP_LNKCTL,
+						   PCI_EXP_LNKCTL_ASPMC, 0);
+
+		pci_read_config_word(dev->bus->self,
+				     dev->bus->self->l1ss + PCI_L1SS_CTL1,
+				     &val);
+		val = val & ~PCI_L1SS_CTL1_L1SS_MASK;
+		pci_write_config_word(dev->bus->self,
+				      dev->bus->self->l1ss + PCI_L1SS_CTL1,
+				      val);
+	}
+}
+
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_REALTEK, 0x8168,
+			 rtl8169_resume_aspm_settings);
 #endif
 
 #ifdef CONFIG_PCIE_DPC
-- 
2.45.2.803.g4e1b14247a-goog



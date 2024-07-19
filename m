Return-Path: <linux-kernel+bounces-257058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D7293749E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 09:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FE572848F4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 07:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3716154765;
	Fri, 19 Jul 2024 07:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="XuT+Zi/c"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3305A4AEEA
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 07:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721375967; cv=none; b=TuuKMFKU04Myl/cmE+deih+486/WYx2dItxk2bL5vA0hEmE1jTgQRKqA79lbKPemhKuRJBbF1lnyMkEs4JkyvMrZ5CIiQtoR96AqKNuRnX9qx3bvAKky1/yituJrVa1jKrIo1JyqO5DhQcQ9YU9lFAgCECb3Ad4SziH3P4zpZsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721375967; c=relaxed/simple;
	bh=dG95QewEG8mN5e80OJowMbRNCEU8UUwID07dkXmIk7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UuhC62Zf2Kb172Kwana0Qtpksl9/bYhyzBO4wypDTbrqkO9wHNdBEPLs7NLoqSDglZeJRVz32BFDUzrZ/jyOcShAejk5fNzgUmyYr9166hZUzF2BwwKGi0U4eE1YpdLhqINmgvZDcx734LVCvgj4qTBm243dOY4JRYM5mBEZw3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=XuT+Zi/c; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2cb63ceff6dso778566a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 00:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1721375964; x=1721980764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDVxrTlyCYmX4gNYVSGtw5JAwr1I2e12lJyeUPu4kzA=;
        b=XuT+Zi/cLpndpMZ2iySVTEU3bPXCaEJtuxNmJjnW5abmjg7fQFnMmNorS1wEUjAL8H
         UbEh5k2STottJzn6MxgrJgAoz2SyfGm1iZyrufPsSzvQvV+b1rAWa0Sm4hCXo07OHLyk
         A0uYdebLJWP7GX4+7B6iL1ngcqJd6OZZUwVKv+mRbGd6SjPvMU+18502PZ88OfwSvlcD
         71ErcaUnVLRDjI8cm0Ao6Jph0z3IFRkjZ5Y/4xJKi16ng/h72ORMkXenGH0CR2UGD1Sd
         QRMHYW2oUwHCkKMFnVwhJ7OmNVyA5ADgQ+pQmCahkddN3s8mn1/R/wc0hL65zb4wOwqx
         D0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721375964; x=1721980764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDVxrTlyCYmX4gNYVSGtw5JAwr1I2e12lJyeUPu4kzA=;
        b=byCDvIYDjujMa6jwHVgx5WhHoqpT5Ka0HxcRyl63okZY/0J9+V9vCSvTOJpqxp7fvF
         OEl3/bG5YWSpVv4yUhZaQ2UtGyHLMtmpDiomZKrA/+KSKWUsha3/51LkrBcWnQTy2kro
         1oT5KYeUMdlVJNOuJcWfEeA0y3is3Vr5eCpkb+gh6HwnWX80MqSD0jbFXHTWf+I84oFV
         i7bC97S9Ht6wHDk0UeGy3VSYMg9UidS4aBPUNYf9TiwVoevnGRpj5/LlR4iObM66Mgh5
         bzHUtr6Hgshpb4/DKdZVcsHi4QCv8Iv/r8U+aH3+t4k40ePByu5c+CrZsiPD+AECyem5
         QGUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtDfUIDXW8JYhTWn9ympgt4uEJkaPhbSsQwCEyMAEYsHfn65ANWUrwy81DIodC1XVJf6uMY/HbwBDa3bnjAasWSHgjf7qA7e4HHoJU
X-Gm-Message-State: AOJu0Yw8abWaZo0YXMmSLA1pG4OwU47SAqzL57cGuk/ufN7ZUp7rC0PP
	0cDR+S/n8Vk+amYO89RjxpC8cw3Sn6sKwN5Z3FwFMFvBsYuiHer+kskq6a5B65U=
X-Google-Smtp-Source: AGHT+IHT+6quf4rYKsrBUnn6NfLGKfmvUAKKbfARVQXy1NR/Ekq0ZjIfo2ufGSrvu2kO1esvs/I7NA==
X-Received: by 2002:a17:90a:d181:b0:2c9:7fba:d890 with SMTP id 98e67ed59e1d1-2cb5294bf43mr5302138a91.43.1721375964348;
        Fri, 19 Jul 2024 00:59:24 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2cb7750674csm2058112a91.43.2024.07.19.00.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 00:59:24 -0700 (PDT)
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
	Jian-Hong Pan <jhp@endlessos.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v8 2/4] PCI/ASPM: Add notes about enabling PCI-PM L1SS to pci_enable_link_state(_locked)
Date: Fri, 19 Jul 2024 15:57:54 +0800
Message-ID: <20240719075752.10883-3-jhp@endlessos.org>
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

According to "PCIe r6.0, sec 5.5.4", add note about D0 requirement in
pci_enable_link_state() kernel-doc.

Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
v3:
- Fix as readable comments

v4:
- The same

v5:
- Tweak and simplify the commit message

v6~8:
- The same

 drivers/pci/pcie/aspm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index cee2365e54b8..bd0a8a05647e 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1442,6 +1442,9 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
  * touch the LNKCTL register. Also note that this does not enable states
  * disabled by pci_disable_link_state(). Return 0 or a negative errno.
  *
+ * Note: Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
+ * PCIe r6.0, sec 5.5.4.
+ *
  * @pdev: PCI device
  * @state: Mask of ASPM link states to enable
  */
@@ -1458,6 +1461,9 @@ EXPORT_SYMBOL(pci_enable_link_state);
  * can't touch the LNKCTL register. Also note that this does not enable states
  * disabled by pci_disable_link_state(). Return 0 or a negative errno.
  *
+ * Note: Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
+ * PCIe r6.0, sec 5.5.4.
+ *
  * @pdev: PCI device
  * @state: Mask of ASPM link states to enable
  *
-- 
2.45.2



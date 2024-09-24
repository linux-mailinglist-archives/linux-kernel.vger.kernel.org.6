Return-Path: <linux-kernel+bounces-336673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D90E983F11
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E6441C2268E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 07:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617E91459F7;
	Tue, 24 Sep 2024 07:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="vcSLO3u1"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA1C6E614
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 07:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727162872; cv=none; b=GMWJLlex9uWVSX/X7jzOLkPu8ChePQ8vH690fNREJz6NotgcUrrFBM9G0e0CwEPBGQFS0okKI3j9IXgL1rgNB08sUV9sCClGlpsajB8huI/0Wx2KEHA9mOanIopuIodEbPDQbS5zUSRDcX73QMrlGz4L22YR6zuDlNzgBe7PQVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727162872; c=relaxed/simple;
	bh=wDk5fvI7DTke43bpHTJyGzKtNvv1AEHrlqAhxcXKJyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=usZk13IDasYzVpgV7kXgg5g+6a6AljtIWSGzGtP11Q7rVNhTLZ6/Clh2REapBN5jG5GV4UmLQrVElrA3w6E+mlgJ+LReM4pJgrbCNfS65eKmwZe0MsMB3Y4N7hDyPB68TRifB4XQgp2VdI50pUrsSbVdkPrjssnFqiYDoqwRBzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=vcSLO3u1; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2068acc8a4fso47636495ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 00:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1727162870; x=1727767670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4BdXjDYFtB7GyHLjEK5w/+zeuqBSDXib6zpEUFEHzsk=;
        b=vcSLO3u14gwAzyAJ9QbqfhRAADrAQ/7cKES+KTEINYtZQGFeX2txKIxRGwZhDbmAfv
         Aoqj0Zhmi3fEe0AmCp6jKpEsShvHgmcmEIwt6/ZjmTucf807KEq0zEL/pBdPV5O3KPUu
         eSq9SSqARTMCR4vXY3ZsgeyXuiVpfXSMR9Tm6Py25DUhmoP9RbDWfSuiaqNlKYNvpp1k
         ev9Umm1Y5/ngCDlfOxvNe56eeuMtZwLv2l6oq9OrbhoL3XTIo+3niLgtEmxnbyC0sEON
         umRCuVDo+//bzFcQc0RPvNHtcBrCrSoBq8PNPA+8IqxqY0Op5I5YLwGFQNUb+v7mHp1N
         599A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727162870; x=1727767670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4BdXjDYFtB7GyHLjEK5w/+zeuqBSDXib6zpEUFEHzsk=;
        b=Lk2BKsXbTP8v0xYNUjq/Q/ulZrrutGb8I4XUj1xve3DM0rmqorKHrukmtn0LEmmg40
         d21DQ7dbLVm3w87cdCSTMX//L7A84V5tJR+XKwMSPmVMRFKd8OgKoFAFxjmkIzIGQ9sc
         F0jfN6bANiP8M2pvbOp42vZVrW3rihJV1fwmDNPgRJbHWao7PzUikuPz8OFoWgjIw+JL
         f4jlauykOzfRlh26SO29EdVqFZN2QzG96/JJHGY4v6bTfTtKjnZLfG2vIv5QDz5eXb2J
         RfMHjAiLunZDLGSOFYy+7JVa6tyK1CHn+z4fZKJjK9/QebP9FFBBib4E1yHsvbIuOfd1
         8FTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeO6IVhrAHETunUyyVGHFeA/Asus3vDUndENUomk4uIVrkDphY1qqLqB+lzsFRtL4qbkdW6V6qGNlA8UU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTmqZw62G04kKKVGQicIPoX7XaMylaQwEHOf+dgJiwFyGPZNdp
	Sc77TG/chPjQZfcq29QK47OeqP2+FI80sFnsQAwLf93S/XHq+7vMDScr5pW1xps=
X-Google-Smtp-Source: AGHT+IE+tL5xfdcYObJI4/sBy4cebqhvd85Sg72wdeYMWr3vRZx/oCsnaZOqqeoRvYg+uyBl8hgjsw==
X-Received: by 2002:a17:903:192:b0:207:1825:c65e with SMTP id d9443c01a7336-208d838654amr230680435ad.18.1727162870448;
        Tue, 24 Sep 2024 00:27:50 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20af16e02c8sm5498105ad.31.2024.09.24.00.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 00:27:50 -0700 (PDT)
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
	Jian-Hong Pan <jhp@endlessos.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v9 2/3] PCI/ASPM: Add notes about enabling PCI-PM L1SS to pci_enable_link_state(_locked)
Date: Tue, 24 Sep 2024 15:26:58 +0800
Message-ID: <20240924072657.15887-2-jhp@endlessos.org>
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

v6~9:
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
2.46.1



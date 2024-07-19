Return-Path: <linux-kernel+bounces-257060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0029374A2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 10:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6A2B280A61
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DD56F076;
	Fri, 19 Jul 2024 08:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="fe5nq4Qm"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45738679E5
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 08:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721376058; cv=none; b=WJloOOnw+IkfQbc5pVNFnY36Y4uHmXaIqu8rA+0gObMwaMMm3W/u0HQyGWc/7OqsDIB/MqN52sChzB1L6SadeTq210UQEBuEMx8y6C/18waU2ToUIOOQOtEZeK9PKpGiG0g3In+HHI2wYcv7uQ03Mtod7noD8txNuDNLmqrZG3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721376058; c=relaxed/simple;
	bh=w1k5K+jcQ9Q/ykVMsX/qJoDslBERO24AtB8r7OJuygc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YlRFpIr01SQf2iQiCvRvSNlCrYBE+QTXjm2/715bJ9C//IvBpzOBb/ugZYQGHyra3vQ1GDtPOlk34qbKCs5Gt3mM8KllPNmQYEfPLrxn3UXfXy4o0lDE/rNkPxE7/jLHL8lUfMN70ebRwM6mDEuPHLT2kp/Zb4Z4rISxzFjho70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=fe5nq4Qm; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fbc09ef46aso15093205ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 01:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1721376055; x=1721980855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLDFsfKJCWA+fTu6bBjMm9nM8Y4NH8EbtQ02Y3aYHlI=;
        b=fe5nq4Qm99qD+jby4LK8KDExHNsBpPpG6SVBr5xt7oYJvN7b2YDnl2iylaV7XaWZQX
         NRMg+3flMjD45Rk7sb63dBFS8i4fTeUAoVyodeqqrPU3LeVIoDgDQsODUAD88bcXVWQd
         M/B4DAV27zrILp8XjwhZ5h/DBPrKsi+j8VSf1VwRE9Wpsv1xDv3CGFDVqJORHtPMPZ0c
         G9GkzP1kuWY2HkWzoBoHN1YuFeQOr0phdIU17U4hHaCkae2RIdhtXOV8+PdesuGs/ymX
         7h4koL6ilMVZ4D+aEUrFjKC770s7+dNuDXSVGqBhgvbCcFsijm4M9HRTX7y/v8R4IPx2
         JTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721376055; x=1721980855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLDFsfKJCWA+fTu6bBjMm9nM8Y4NH8EbtQ02Y3aYHlI=;
        b=tX+9x/52VDDUmssyKfrF9NHuxBCEdITUMXLymKVmzFi/SqMp42PEYhltLGYeRsJMvW
         20bnkcW3rlZnm5oaVDmk32haXl4SxK+Iw/8TuwCYl5adEXDlgqTcfhSiJLq7RSTuYgC0
         hicjMEslFdCyLMIUuMTSf8tc1tjQ8o81jgtQhEImF5UhYsYjZwpI/DIbW3r/vW5W9pL5
         B4iu5WoqOHk1D3raDDiYjd1iYxyP6tC4QHmmOIrAtslKekxZZV7Wl/qlfN6O/gowYMEY
         4aMouhtLeSLk4NuiwWgoF152jqZZUN8ReU6t3zsb80K6qdsNZu6gV5Sag/hmYWhEzcRT
         PvWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoCierJ0eBzviGT5nXQyJmOhpPImmeModaeYfpc9iAJlK52SO2r9morvGAuJREz6mrbbXDN5/XG9gftdjqZjAi2nG4lNoLkVCHuAQo
X-Gm-Message-State: AOJu0YxGZfu46d8uxU6+jLVwLyAidBzWfnSxWPmMuPBETE95FrbzAitH
	4KO4GjF4Z5EztfHMlVcwAzRtPVNvMjp+mB7rfJ9zx8iRwkyswTgh2xPsMhGSkuo=
X-Google-Smtp-Source: AGHT+IHWV9JAlT/QGF5Yig86nrNCGmsxqCwu1UVWib6rPn8P85SqUNSnDoKPxgrwWBLSh0X3fR1cSg==
X-Received: by 2002:a17:902:c40b:b0:1fb:72b4:8775 with SMTP id d9443c01a7336-1fc4e56b617mr53354115ad.40.1721376055315;
        Fri, 19 Jul 2024 01:00:55 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fd64d07ad9sm8178055ad.177.2024.07.19.01.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 01:00:54 -0700 (PDT)
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
Subject: [PATCH v8 3/4] PCI/ASPM: Introduce aspm_get_l1ss_cap()
Date: Fri, 19 Jul 2024 15:59:35 +0800
Message-ID: <20240719075934.10950-2-jhp@endlessos.org>
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

Introduce aspm_get_l1ss_cap() which is extracted from aspm_l1ss_init() to
get the PCIe's L1SS capability. This does not change any behavior, but
aspm_get_l1ss_cap() can be reused later.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218394
Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
Reviewed-by: David E. Box <david.e.box@linux.intel.com>
---
v6:
- Skipped

v7:
- Pick back

v8:
- The same

 drivers/pci/pcie/aspm.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index bd0a8a05647e..5db1044c9895 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -611,6 +611,18 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 	}
 }
 
+static u32 aspm_get_l1ss_cap(struct pci_dev *pdev)
+{
+	u32 l1ss_cap;
+
+	pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CAP, &l1ss_cap);
+
+	if (!(l1ss_cap & PCI_L1SS_CAP_L1_PM_SS))
+		l1ss_cap = 0;
+
+	return l1ss_cap;
+}
+
 /* Calculate L1.2 PM substate timing parameters */
 static void aspm_calc_l12_info(struct pcie_link_state *link,
 				u32 parent_l1ss_cap, u32 child_l1ss_cap)
@@ -721,15 +733,8 @@ static void aspm_l1ss_init(struct pcie_link_state *link)
 		return;
 
 	/* Setup L1 substate */
-	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CAP,
-			      &parent_l1ss_cap);
-	pci_read_config_dword(child, child->l1ss + PCI_L1SS_CAP,
-			      &child_l1ss_cap);
-
-	if (!(parent_l1ss_cap & PCI_L1SS_CAP_L1_PM_SS))
-		parent_l1ss_cap = 0;
-	if (!(child_l1ss_cap & PCI_L1SS_CAP_L1_PM_SS))
-		child_l1ss_cap = 0;
+	parent_l1ss_cap = aspm_get_l1ss_cap(parent);
+	child_l1ss_cap = aspm_get_l1ss_cap(child);
 
 	/*
 	 * If we don't have LTR for the entire path from the Root Complex
-- 
2.45.2



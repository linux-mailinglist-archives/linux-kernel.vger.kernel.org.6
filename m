Return-Path: <linux-kernel+bounces-230427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F64917CAD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95D2D1C21FF7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2372D16CD0B;
	Wed, 26 Jun 2024 09:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="N0uEqOZa"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A19761FEA
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 09:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719394816; cv=none; b=Zur1CX5wgYWbW59TZfTWCg3qgjaxY6x+6brmwG+7BLPEhb+vIIKZEzLP51WvSuqU27N236OHWULbtPYdg9hAriByajengz9v+Ug5hHnqtFKFB9hQQqHqVP3BPHgDtzc/5hjIlfXeGlFFH0T7Zo9d2bo6RXDR1/CEaL7giUEODrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719394816; c=relaxed/simple;
	bh=t3x+yPoWJqcunaS/pKWvxbPII/x2hQ1qiSygdYUHM84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jyU0cBTd3akyLKJBtthNoY+3SeNU9A6boYfwYkbBsNe0yi8zyCP24oSU8nVZqWdFhZg3DLzaEKx/BGa75SLH3XM9/cUln7mb1zhilNludQngWgGbK9Q1a8wl/NVIJYPq+PJ9NgPyxhf/F1ljQC+Cu2EAgL8Vavf1plnjiATE0do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=N0uEqOZa; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2c80637ee79so4570537a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 02:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1719394814; x=1719999614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYkL/+OYvrPefgy3yyZJb4UdPCVnAP9ikoloQG2+LAg=;
        b=N0uEqOZaTh/aqHFkpOfdHSZQWREJGX+6QQIzadsbBdSCQvDDRqtnRjp23XHMQk8Nz0
         vIZ3v1L1WC4j7oLxMsVSyOSTqwpAIcqVgbcz+jmJOA3cCcMBadMA4S03Gr2ygGXbE0xR
         U3E3rFigujCbNtXC6/yziIkTR6Q1btkyync3zxI4op/ZtciQGlYXCJzGEPoVhQpyB4uR
         eyrvbJ/DumIgg0qfJxhWUqFMcNzAmidwRLGmRfz1AVJKDwvlLv8Jq3FUuDYTYtk6s3ME
         B2eHBH1QEmhUsMYNKV+MnVGYus3dMF9jgDrd9VA42ngRuxaPfTsv1FgE2QnjZ/Z/j8tb
         GG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719394814; x=1719999614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYkL/+OYvrPefgy3yyZJb4UdPCVnAP9ikoloQG2+LAg=;
        b=GXbjgQi6mg1Am4XxwfNmhBWDOsMMUuHRCNaUaOsr0OKaZ5xKOpgm3S9jCBO4MNuDhb
         JlWxc8sCvCwMVkw7gkGulOeBntE/zGBLRUn2jGVjZKd04GncE7GEFxl4RnPx6+XK/7Nn
         0/BnPufgIfsYWP601ogtoCT43kiEcQtflJNX9bjJ5I9EUrJaFutf2eqMkzAdbPScyarE
         k76Wsc9zzoHWUWgjtFdUm8JB9aHT5JnkPlgu2fk8YDqKTjGox3v7YuZJqR97sz30PxNN
         qHjXds5Bc5R+F15Qomh4b812PdGu/LCcPV/Ogc86deEtmaVOeVjAoh0gXkX0KEHnWpU4
         Xnbw==
X-Forwarded-Encrypted: i=1; AJvYcCUA6iiyNB9AMOWunn7xNkMfyxhGSO2We72schptKkVVAt1sLQ/m39B8iL36Lp4j/eYHzTKpb2mgC8T/j8I/YjjI7jBeezfQv2AxsoZE
X-Gm-Message-State: AOJu0YwdyyCy69m6CQPszUN/mth9loCc2LOM4qNLtXbPzygG2ASjdeI5
	GJrX4kKSJNnVjYO9BnGISEBstrW8wvevM1A115xDfdaV69pYxMdBo+HqZYx53dE=
X-Google-Smtp-Source: AGHT+IG3oKwCrQlC6wo/9oxGXcDpBv5N7NMtxjzsIJEcW7oGLQArvKeicnb3ZhGwKn3EmwKnwHhuvQ==
X-Received: by 2002:a17:90b:4c8f:b0:2c8:a8f:c97 with SMTP id 98e67ed59e1d1-2c86146c865mr7628141a91.37.1719394814219;
        Wed, 26 Jun 2024 02:40:14 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2c8d806f8f7sm1199096a91.35.2024.06.26.02.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 02:40:13 -0700 (PDT)
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
Subject: [PATCH v7 3/4] PCI/ASPM: Introduce aspm_get_l1ss_cap()
Date: Wed, 26 Jun 2024 17:39:12 +0800
Message-ID: <20240626093911.14435-2-jhp@endlessos.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240626092821.14158-2-jhp@endlessos.org>
References: <20240626092821.14158-2-jhp@endlessos.org>
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



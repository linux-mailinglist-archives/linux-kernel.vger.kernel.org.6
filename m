Return-Path: <linux-kernel+bounces-521230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5A2A3B942
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 778A917BC97
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1380F1DE3AE;
	Wed, 19 Feb 2025 09:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="qdcGHmef"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4ADB1C5D69
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 09:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956954; cv=none; b=SAr7ol1cAAPbIM7A/NU3VDsfwDYqAFP7e5HQd7FgtTmKOXq/iSXZYVfrDehT/QEP+yWVf3ky8t3A9WtTkuJe7yoDdkGsqYdYXitcb+SVEDy2rtxxKYzneqbv6d2aJHSR2M/DFkZo+hf52vZHUtN16LjZjjD93Ta6NzNRTdmzzwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956954; c=relaxed/simple;
	bh=Emq0s37HWVf+yMAcB00SXuh2VSIdv4rvq6v00xkLO3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a/W6DBUq4l19uqe36nuTuIm9YzRWYa2mUMiExlMQOHuOkvM9t+EGAoACnrtw+rIpWydkuRYKx1bIhZUbn5PZByjmYPH2kG8v5hgOoq82pk1Phkk7xtiUeQGZdzpPjyfeUxiwZ8oiZoyfYmUpeuMKS6bNrBnGs+J9q9BzT+ZdbwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=qdcGHmef; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220bff984a0so116191965ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 01:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1739956951; x=1740561751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjpV/rOsBTZhvMzmuINLNFZE/6rbEow5DAVU2rYU1PQ=;
        b=qdcGHmefAT+xBHykoCBohWDqLuGjyyk4gBR2fizHuEb3pIKIZEhVoD1ACMHbtbEbZ7
         a1ZdP2SSuu5Q0k8ugHRKDNhZ9p32HVG8hMuLDx/eNQTnkXXK1AjxDvJ70uFgo2LlZ29f
         vgikYZ5iiyl9tcBOQaWXX31305V3D7xoWWspw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739956951; x=1740561751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zjpV/rOsBTZhvMzmuINLNFZE/6rbEow5DAVU2rYU1PQ=;
        b=Dcn/qlc3RyCBc8Jkyxs35tXCjkyhP6dLosGewdoIDLHHZphRobKRKfgjUHvR/IKOQC
         ffez3B9DPOidtTsHA0P+STLoTBmfzYP4Qm+80zES4XPuoUbN4WIuDup6/EpR47QOtaTV
         AwfspnSkKe1zydyUikeu8XMUEDupx9RGGEOBD0a8RpjWx8ZjSQnEk3Fc8jNDpduP3iA2
         6rgHxv1luokWHuAEofVQeFVgeJZzY8k/Mt2JpK4Rhx137nTjqLoGc2nDxBkBMzccaNI0
         GmNmHMa1+3PH2bzx/082HIH9vEwm/vKr3vRULhdNLNsc9DE5uP+wLHkPKsgMuE9n4Plr
         rYRg==
X-Gm-Message-State: AOJu0YzasrMxvbrWzmsAWV/PQV1cZIJlQhMJg3AjQByhTiyl8tDERIRp
	TOG7dp7x/+XUOvdDeHtZBeE2sWuiCZtpCoHkw7ZRZPc9xp69kirPhSTJSTeWLFmn4K6OutMKba5
	+
X-Gm-Gg: ASbGncvIUL2tqocwHba8MXLxCY0oLrOp//h6HoZn1mti/jOrQPN2g0JLJ4Em/qFo2sX
	cd9olUMfXO4i7E9Arnx74sW0XU39eqNkNlA/UXXVbmyD3nqKgXiDfeoWNmd5JLkXL7WW3mzlM+M
	+GsodnogNjBraJip0mFvbMGP+gcEIW8Q62pbfLFV6+6G0bqdS6D4ipz1w50ITl8fRBqlkWBWVi5
	BW2LDa8HE1wdl5yKd8tlTJADCMk2PNLk4SuO9l9JMLR8zg8PpdZTNokly0ID0Ju5xW0AX2zhE4i
	MYcUHAvQRM0hAxOGGPWg
X-Google-Smtp-Source: AGHT+IEJm44nEb0TxcOjkAjrcsD0xsD/CPlwgrhHME8dtzpc5/4Onda8YE7jAeRTGmWr+ZG5phmDmw==
X-Received: by 2002:a17:902:ce87:b0:21f:85ee:f2df with SMTP id d9443c01a7336-22103f16b56mr276089045ad.15.1739956950796;
        Wed, 19 Feb 2025 01:22:30 -0800 (PST)
Received: from localhost ([84.78.159.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d621sm100543165ad.136.2025.02.19.01.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 01:22:30 -0800 (PST)
From: Roger Pau Monne <roger.pau@citrix.com>
To: linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-pci@vger.kernel.org
Cc: Roger Pau Monne <roger.pau@citrix.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 2/3] PCI: vmd: Disable MSI remapping bypass under Xen
Date: Wed, 19 Feb 2025 10:20:56 +0100
Message-ID: <20250219092059.90850-3-roger.pau@citrix.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250219092059.90850-1-roger.pau@citrix.com>
References: <20250219092059.90850-1-roger.pau@citrix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

MSI remapping bypass (directly configuring MSI entries for devices on the
VMD bus) won't work under Xen, as Xen is not aware of devices in such bus,
and hence cannot configure the entries using the pIRQ interface in the PV
case, and in the PVH case traps won't be setup for MSI entries for such
devices.

Until Xen is aware of devices in the VMD bus prevent the
VMD_FEAT_CAN_BYPASS_MSI_REMAP capability from being used when running as
any kind of Xen guest.

The MSI remapping bypass is an optional feature of VMD bridges, and hence
when running under Xen it will be masked and devices will be forced to
redirect its interrupts from the VMD bridge.  That mode of operation must
always be supported by VMD bridges and works when Xen is not aware of
devices behind the VMD bridge.

Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
---
Changes since v2:
 - Adjust patch subject.
 - Adjust code comment.

Changes since v1:
 - Add xen header.
 - Expand comment.
---
 drivers/pci/controller/vmd.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 9d9596947350..e619accca49d 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -17,6 +17,8 @@
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 
+#include <xen/xen.h>
+
 #include <asm/irqdomain.h>
 
 #define VMD_CFGBAR	0
@@ -970,6 +972,24 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	struct vmd_dev *vmd;
 	int err;
 
+	if (xen_domain()) {
+		/*
+		 * Xen doesn't have knowledge about devices in the VMD bus
+		 * because the config space of devices behind the VMD bridge is
+		 * not known to Xen, and hence Xen cannot discover or configure
+		 * them in any way.
+		 *
+		 * Bypass of MSI remapping won't work in that case as direct
+		 * write by Linux to the MSI entries won't result in functional
+		 * interrupts, as Xen is the entity that manages the host
+		 * interrupt controller and must configure interrupts.  However
+		 * multiplexing of interrupts by the VMD bridge will work under
+		 * Xen, so force the usage of that mode which must always be
+		 * supported by VMD bridges.
+		 */
+		features &= ~VMD_FEAT_CAN_BYPASS_MSI_REMAP;
+	}
+
 	if (resource_size(&dev->resource[VMD_CFGBAR]) < (1 << 20))
 		return -ENOMEM;
 
-- 
2.46.0



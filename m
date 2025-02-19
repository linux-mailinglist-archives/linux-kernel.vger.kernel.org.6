Return-Path: <linux-kernel+bounces-521229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C49A3B9AD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 366413BF4E9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DAC188CCA;
	Wed, 19 Feb 2025 09:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="CAxjgUaK"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886EE1B4F0C
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 09:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956937; cv=none; b=nIaspipMQRYjjZOd6Nki8AeIuRC6LJ39iOIZ+7OsqHozl7WmqQAmObGsmXN0L4EoVoc7LhUPwP6fNf4I9wGtCPe3rRJhKIBhDJKeDkQay2qx76/qtZnVyJ04tT03TQpnN9+k2DD+nrtxRsDWpHY19avGQNZsFOfE+haK22b4BkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956937; c=relaxed/simple;
	bh=btOjj/fS6M7wJvEylFDR42rA/D1lmC5FHZJt6IgOwJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XOYNKO27Si2WHFjRNRvoTwWTmiDh08o/1xaw5db39qW7Sbx+PScAPe0uaIn1sepbKFil0t9xpy5E4rLuvX276I1d/qfhXjvs6YkRcyyUw5Bt7sTLwqeyW892WdlLpRg67k96X394xfPpK7gtAzjGgMD9n2R31XMVVKTTq3Nhdtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=CAxjgUaK; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21c2f1b610dso164341785ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 01:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1739956934; x=1740561734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZJg6bVS4EQSvqcvYB18UYZOZ9WdLOPfmEHjgud3AfI=;
        b=CAxjgUaKlQLM0A/P/iynAqDqxtg+mESZwD9QutVmb2Se4iYVnLavbYVm4Si0r0gYuJ
         rLiGQ7WcigU8L36hoZ8RZtjuoVCpD2zdIeSp4S+Ky/bMxGxb6uXUWtCio2GGVEz7dTJ5
         57QrNYaLqBS8tumzTXG0IF1RG7eU7Bl0VXQj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739956934; x=1740561734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ZJg6bVS4EQSvqcvYB18UYZOZ9WdLOPfmEHjgud3AfI=;
        b=OO1+H5YKZkknalIcINJCuAB5iJGEjJ9T5UQjko4aIoku+5xsMfU4TmokEeclZMrkxf
         ABYE1RCtV4DoCOTcK4a68hXNA+Cv3Y4Eqfko0SKm1rEQ/NEMp3IIEB4g6853uzV9amON
         iMJTm/z93VEdEJNGnn45Ixa9G16sXesoy5d/QAkWLL5wWlM3EQiyIJBjSXCmm8seWN1e
         Zem/aZTNvTzDQu8wuvtztt7ALy4wiqe2TMkyyGbPsx/5Sscdjnwzl4oiW7Clf579Xj9b
         uyCTfJ7SdeJWX5E74qd4ahDnN2OByP8V6XDfqQT9ytOLlr7EyB7aagicVu3iVV3pBiiP
         fZKw==
X-Gm-Message-State: AOJu0YyH0OkAHKE0zz67AzZUuN1Zo0eX579JBAR7ILIHQH22mj3evmko
	TprDznDPi9DYpdF+geL41j0pZe1VnbQ/HU7iOB/jXvG0sFFK/ueS00VRHLFzncDmT+gImy3qnrn
	t
X-Gm-Gg: ASbGncs1w8VrqBjmaGW9Pb+LckB+2bt/mg5n13OJa0nlMfSG3L8/N1zxzfFEJHYzjQs
	afNjRmNXq5PulLgAAKjZC3ay+HCyR3PgZvF2Hf1JX7xizc2p78wSrJDv1jE8IqBLBRY+4vLOXvY
	JfginpxpJWa9oKnfgzqXeDwyUst/6m/G71No2HIFsr8ebccGA2/TeHdnFpSBqThAL8YMMQlCtGY
	yXiMcJKbDtnp6QZirPvjwoPx15AAvl6vfdKmgaNEGi6BXMJ8taVa//bRKP7FGceTQ/YI+WiKFZE
	Iq81viBZNmtq34PynMRq
X-Google-Smtp-Source: AGHT+IH2CJE5OkGckIlv4JN5MuajJLAOUuGuc18ZFqOtmBHZImObUq5mVTJXCcZHX2k+NCDuJBVy7A==
X-Received: by 2002:a17:903:41c8:b0:215:853d:38 with SMTP id d9443c01a7336-2210405d2ffmr289308605ad.25.1739956934306;
        Wed, 19 Feb 2025 01:22:14 -0800 (PST)
Received: from localhost ([84.78.159.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5348e68sm101300795ad.28.2025.02.19.01.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 01:22:13 -0800 (PST)
From: Roger Pau Monne <roger.pau@citrix.com>
To: linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org
Cc: Roger Pau Monne <roger.pau@citrix.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: [PATCH v3 1/3] xen/pci: Do not register devices with segments >= 0x10000
Date: Wed, 19 Feb 2025 10:20:55 +0100
Message-ID: <20250219092059.90850-2-roger.pau@citrix.com>
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

The current hypercall interface for doing PCI device operations always uses
a segment field that has a 16 bit width.  However on Linux there are buses
like VMD that hook up devices into the PCI hierarchy at segment >= 0x10000,
after the maximum possible segment enumerated in ACPI.

Attempting to register or manage those devices with Xen would result in
errors at best, or overlaps with existing devices living on the truncated
equivalent segment values.  Note also that the VMD segment numbers are
arbitrarily assigned by the OS, and hence there would need to be some
negotiation between Xen and the OS to agree on how to enumerate VMD
segments and devices behind them.

Skip notifying Xen about those devices.  Given how VMD bridges can
multiplex interrupts on behalf of devices behind them there's no need for
Xen to be aware of such devices for them to be usable by Linux.

Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
Acked-by: Juergen Gross <jgross@suse.com>
---
Changes since v2:
 - Capitalize subject.
 - Add extra comments to note thet 16bit segments value hypercall interface
   limitation.

Changes since v1:
 - Adjust commit message width to 75 columns.
 - Expand commit message.
---
 drivers/xen/pci.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/xen/pci.c b/drivers/xen/pci.c
index 416f231809cb..bfe07adb3e3a 100644
--- a/drivers/xen/pci.c
+++ b/drivers/xen/pci.c
@@ -43,6 +43,18 @@ static int xen_add_device(struct device *dev)
 		pci_mcfg_reserved = true;
 	}
 #endif
+
+	if (pci_domain_nr(pci_dev->bus) >> 16) {
+		/*
+		 * The hypercall interface is limited to 16bit PCI segment
+		 * values, do not attempt to register devices with Xen in
+		 * segments greater or equal than 0x10000.
+		 */
+		dev_info(dev,
+			 "not registering with Xen: invalid PCI segment\n");
+		return 0;
+	}
+
 	if (pci_seg_supported) {
 		DEFINE_RAW_FLEX(struct physdev_pci_device_add, add, optarr, 1);
 
@@ -149,6 +161,16 @@ static int xen_remove_device(struct device *dev)
 	int r;
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 
+	if (pci_domain_nr(pci_dev->bus) >> 16) {
+		/*
+		 * The hypercall interface is limited to 16bit PCI segment
+		 * values.
+		 */
+		dev_info(dev,
+			 "not unregistering with Xen: invalid PCI segment\n");
+		return 0;
+	}
+
 	if (pci_seg_supported) {
 		struct physdev_pci_device device = {
 			.seg = pci_domain_nr(pci_dev->bus),
@@ -182,6 +204,16 @@ int xen_reset_device(const struct pci_dev *dev)
 		.flags = PCI_DEVICE_RESET_FLR,
 	};
 
+	if (pci_domain_nr(dev->bus) >> 16) {
+		/*
+		 * The hypercall interface is limited to 16bit PCI segment
+		 * values.
+		 */
+		dev_info(&dev->dev,
+			 "unable to notify Xen of device reset: invalid PCI segment\n");
+		return 0;
+	}
+
 	return HYPERVISOR_physdev_op(PHYSDEVOP_pci_device_reset, &device);
 }
 EXPORT_SYMBOL_GPL(xen_reset_device);
-- 
2.46.0



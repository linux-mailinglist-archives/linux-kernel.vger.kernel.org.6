Return-Path: <linux-kernel+bounces-207485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B89159017E9
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 20:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4BC71C20BEA
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 18:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626FF4CE05;
	Sun,  9 Jun 2024 18:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2+c6No6"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6325E42AAB
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717958670; cv=none; b=MDkhLWdH5EIDNXqh5UwzbT4uDvcHxmnmz3Tu0ViNxeZwH3t56AWjlEXPAUr4iBcU2IYsbAcoS6/Y1iiadV4w/oWSxqrhed0KiO/z1ZMXQgKO6zGowA6ffrMx+mu+9aKdRnDbgS18giyR4knPFjxiebD0AuJFJkK7mfIQpyq6mGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717958670; c=relaxed/simple;
	bh=z86plG12qr5Z1bSQwt5yOklVzbOK9mShEJuRaLJ/XhM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lbxTGWo5rRBjEVehg9VYrTzYJHsVMbkx47QK4+7EklOWIMJCUC8g8FKQQjwecKYRZ/tmoSHIEeHr5bEhaCHgVWaJaTd5I7//iz7rMxIlH+ZECKdObCGiqVgaYM+vzX4TbLF7RFz5A/L+foJdD0B9NrubyNQmenatV4GxCmFLUp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2+c6No6; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7046e87e9afso293610b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 11:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717958668; x=1718563468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QUUN5jvMypW6P+Pp1YvyXgjvxQ678L4ijvc2XJHbh1A=;
        b=J2+c6No6QVkdkAbZZlbu4AA56f1uO/OPIIaEtykqDoYxLp5beTw1r2MujTL46X+pgr
         aVVwdlY7DU0v1397Hz/gHKecVykV7mTldObsX2cr773IrrGchNXtADNh7UwpIVq9KkhY
         LnXH7i8+EHmbel5r2rTovBn5NgYj+eeG/lLDcxjnz/9Sd2R4RepuryaQIVKl3z/UUXpO
         9q6SJetbTRKxKDIxgOa4s4RJON/KjKo7P13vTcOaMjE8ZBNp6//T2IdZgMD7DcG8/Zx8
         N333VuzuscLPzRsX0t2SAjIHy61Ijfozf1v7XVruU3qsUJ4sKQ7O8VZ1en4BLwjJtrCL
         6xhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717958668; x=1718563468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QUUN5jvMypW6P+Pp1YvyXgjvxQ678L4ijvc2XJHbh1A=;
        b=YJ0pZXq3AVQ5yWwKldT68nzRAHiHgG+Q4c5q7DOB9w8ocE/SN5Gn3u6c4ItCWIjL6U
         GbcXsAnUqBAN/B5bB6JTU00x5KLOS4j6A6TLOQBXqQzlZqwo9um2u9hFggAsW9MH/aww
         t2pLtU1XI7tWdEYVJGpcltafqzVIKnD/B8Jx0Bjj5YOuoXb+CMjfCS69lugNQcfG5gUw
         qvforlzaBEDKpGtbp6AWOWEEQsooPPqu/h9i1xnVNa7nzkuqJ6kHk9KvPqBpYcy883Ns
         iwpGKLwHnnPWFMo8IC5OWFP7n6DUjtdgUABLZydlVu/X4z2cbn8pZt4fp8wU+4uyMYt0
         rVMw==
X-Forwarded-Encrypted: i=1; AJvYcCXWqqCxhEEvwhZ2av4/FW34c30kO8FPmCkFWuRZMwMCyRUAEXxOwe8XyFMj0nOfdER4myy9m0zJ4i7kZ9vwYNi1KJP7vV7iyleEKhhG
X-Gm-Message-State: AOJu0YxjIrr25Ox13y7GZs+A+6tCuVebvAuxrn3SyMXjLHhJzK0CKXDv
	HDBJpsBsgShehtWVcS5rE0X3gHqos0wfQPzyco5UFsubghbyUmEY
X-Google-Smtp-Source: AGHT+IHKKiBJNRWQNNKgV62vwr/OlJ+hKJrqkVpM54C1atGqjWvBWdpuEMXjHXRaNIX0ePqrcNmTIg==
X-Received: by 2002:a05:6a00:17a3:b0:705:96b5:8bf2 with SMTP id d2e1a72fcca58-70596b596a2mr946312b3a.3.1717958668561;
        Sun, 09 Jun 2024 11:44:28 -0700 (PDT)
Received: from dev0.. ([132.154.51.183])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e2b38167a2sm3714385a12.90.2024.06.09.11.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 11:44:28 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: jgross@suse.com,
	sstabellini@kernel.org,
	oleksandr_tyshchenko@epam.com,
	xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	jain.abhinav177@gmail.com
Subject: [PATCH] xen: xen-pciback: Export a bridge and all its children as per TODO
Date: Sun,  9 Jun 2024 18:44:10 +0000
Message-Id: <20240609184410.53500-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check if the device is a bridge.
If it is a bridge, iterate over all its child devices and export them.
Log error if the export fails for any particular device logging details.
Export error string is split across lines as I could see several
other such occurrences in the file.
Please let me know if I should change it in some way.

Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
---
 drivers/xen/xen-pciback/xenbus.c | 39 +++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/xen/xen-pciback/xenbus.c b/drivers/xen/xen-pciback/xenbus.c
index b11e401f1b1e..d15271d33ad6 100644
--- a/drivers/xen/xen-pciback/xenbus.c
+++ b/drivers/xen/xen-pciback/xenbus.c
@@ -258,14 +258,37 @@ static int xen_pcibk_export_device(struct xen_pcibk_device *pdev,
 		xen_register_device_domain_owner(dev, pdev->xdev->otherend_id);
 	}
 
-	/* TODO: It'd be nice to export a bridge and have all of its children
-	 * get exported with it. This may be best done in xend (which will
-	 * have to calculate resource usage anyway) but we probably want to
-	 * put something in here to ensure that if a bridge gets given to a
-	 * driver domain, that all devices under that bridge are not given
-	 * to other driver domains (as he who controls the bridge can disable
-	 * it and stop the other devices from working).
-	 */
+	/* Check if the device is a bridge and export all its children */
+	if ((dev->hdr_type && PCI_HEADER_TYPE_MASK) == PCI_HEADER_TYPE_BRIDGE) {
+		struct pci_dev *child = NULL;
+
+		/* Iterate over all the devices in this bridge */
+		list_for_each_entry(child, &dev->subordinate->devices,
+				bus_list) {
+			dev_dbg(&pdev->xdev->dev,
+				"exporting child device %04x:%02x:%02x.%d\n",
+				child->domain, child->bus->number,
+				PCI_SLOT(child->devfn),
+				PCI_FUNC(child->devfn));
+
+			err = xen_pcibk_export_device(pdev,
+						      child->domain,
+						      child->bus->number,
+						      PCI_SLOT(child->devfn),
+						      PCI_FUNC(child->devfn),
+						      devid);
+			if (err) {
+				dev_err(&pdev->xdev->dev,
+					"failed to export child device : "
+					"%04x:%02x:%02x.%d\n",
+					child->domain,
+					child->bus->number,
+					PCI_SLOT(child->devfn),
+					PCI_FUNC(child->devfn));
+				goto out;
+			}
+		}
+	}
 out:
 	return err;
 }
-- 
2.34.1



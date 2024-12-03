Return-Path: <linux-kernel+bounces-428996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BA89E1603
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA8D91648B1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F081D9337;
	Tue,  3 Dec 2024 08:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ok2pegxT"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D190186284
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 08:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733215292; cv=none; b=Uue1ywyIoZgi5GqNkcHBeYxZa5BzzkrsaSU3XFjYP9Vr742B7VGVEJe2a0BsdpoRBREiQWWwUBnuz0mBKRp+lpLPPrtxpTz+5FYmBh56OWzBgUq00UOukTZYOS9zcoo7KVknl6Pr3fqaXWw0iz+VKqrQBQi3T4GOweatg6srHJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733215292; c=relaxed/simple;
	bh=r9r7FRd26mBvpKsn+15bPXObLy6mfGx2gYncvPam+9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sCW4iqjaNlZT4UsrGbFsZepM0BYT0zOpdquDeZuZpJN50QTBY2JhuNYMxaHCV594tqWcgc/yF5T+LSREVkUUlc/6IW5zWPCCaYdxxN16v9FU+1URgec18uqz+OSvlLkRmt7wOCoKAQtThNhw7emx08NLDX0wWJWQtZPVDrkfQFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ok2pegxT; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434a8640763so44647335e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 00:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733215288; x=1733820088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lIiCQ/LtOWqMxVgD8JOR9CEqnVLqV0EXHWAZs4aGwUk=;
        b=Ok2pegxTiEmrXcR+bfki86rDx+5nGeApPtCmph9MeVw2txEV76XkQYTMJHp5SGwN2P
         KNoGbpj2EyVQwT2tG3yKXjpk8Zqzed4nSn48+iJe9qYVyl0GOWQSSgklH6elFvIu42cB
         QhVNOO092I7xNzcad/2OdBu5Cjfn15yEyT5nKD+2FAhnPgunZL80T7KbWJbG6copA31a
         3uLH+qq6v9crTJmR+qmdlbUvyZTBdMGfKVhNXaR8OuLCtKETHEAO9riV2CxvSab3lNKh
         F2x81fHZie3ssQZJXKuxUIHqezD/eJThGTdOyLgNxF3aSDYDeras6uCLggX/6YeuqlG1
         bUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733215288; x=1733820088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lIiCQ/LtOWqMxVgD8JOR9CEqnVLqV0EXHWAZs4aGwUk=;
        b=InmyM/fUag7jB7gNOLWGgYAJkyFRssS82FErU2AAw/82FnB+PVe5gQjtoD03TUaOrL
         KEi7IF61vMQUWOvl3IRR4RzHaUoFCfq408Zk71yOil1kiRT55L2Xd4KM5VrVeAt5fiMP
         tKQIayj1efleWak4scMKhLwixi6R4tOAo8hk6j2h4n5iqum7WZ6DO7kvzSLXDS8+hsH4
         852FnHciPTIpekE469BheHMaWQssDwgyvkc1rb3SEwq6Ko4943WtEwDpHYH1x1BJwI7n
         t00QIzjsZlfJvOGxgfHb/CKyIlw5PvVjV2Jg0W9sj+JX3ddtyDpJBx1NlTZOFsXyH5kV
         k75w==
X-Forwarded-Encrypted: i=1; AJvYcCWOetWSjWhkzBJLek4LdfaJH31SdvGN0QvRNAvEe1QRNbvzQfMxfA4QEl53Db5WcsIn4dfioxd7NN7u06Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+RofC/d9jW+YYzTi7yu0/mWrRqeOuwohgNGWDQJcqzghu3WMd
	o8t/OZ3NxYNhfzSzCxiPJhWHENB42cPqFccV6nSAf/IcuYZFoDu7D38v2+6A
X-Gm-Gg: ASbGncu9DsYIkF+6cVtwbdID8S1zY8kLpy2LBhKM+Tg+y3doENj0xDhRfV/lYKQ6MKS
	lBLj0zl8jEO2iVOX2zf2u16Oug5NlniuiZk5TN7flB9VAFSD36xiiRIHO9xgSV+TAlYFJwfXur7
	5Jtfcr20aemEjJfWrE0XB2R0/CluVnBvmt4d9w9Z5JRHs1i+KN96/r9A5J78KifraB4aVfopGf5
	SSxVDs9/yV53H9cHY9YRIRsQC5WSDt1l1tI594NsIgOVfVRg7KDxvZDy/8wuZcszqQhSGGXYJia
	AFi6XZ/hOQ==
X-Google-Smtp-Source: AGHT+IHPkPssDtk7PbBN1/qeDFvWsc1gwOmzVsPYao+hA91SJiFqZGXTdrTL5ns8u/UOxTGEx2t+Lw==
X-Received: by 2002:a05:600c:35c9:b0:434:a5b6:273c with SMTP id 5b1f17b1804b1-434d09b1464mr12888965e9.2.1733215288246;
        Tue, 03 Dec 2024 00:41:28 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0d9bc5asm179763695e9.2.2024.12.03.00.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 00:41:27 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: linux@roeck-us.net,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH v3] staging: gpib: Fix i386 build issue
Date: Tue,  3 Dec 2024 09:41:16 +0100
Message-ID: <20241203084116.2228-1-dpenkler@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These drivers cast resource_type_t to void * causing the build to fail.

With CONFIG_X86_PAE enabled the resource_size_t type is a 64bit unsigned int
which cannot be cast to a 32 bit pointer.

Use ioremap() instead of pci_resource_start() / pnp_port_start() to
initialize iobase.

Reported_by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/all/f10e976e-7a04-4454-b38d-39cd18f142da@roeck-us.net/
Fixes: e9dc69956d4d ("staging: gpib: Add Computer Boards GPIB driver")
Fixes: e1339245eba3 ("staging: gpib: Add Computer Equipment Corporation GPIB driver")
Fixes: bb1bd92fa0f2 ("staging: gpib: Add ines GPIB driver")
Fixes: 0cd5b05551e0 ("staging: gpib: Add TNT4882 chip based GPIB driver")

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
v1 -> v2 changed pci_resource_start to pci_resource_len for second parameter of ioremap
v2 -> v3 add changes for cb7210 and tnt4882 drivers

 drivers/staging/gpib/cb7210/cb7210.c        |  6 ++++--
 drivers/staging/gpib/cec/cec_gpib.c         |  3 ++-
 drivers/staging/gpib/ines/ines_gpib.c       |  4 ++--
 drivers/staging/gpib/tnt4882/tnt4882_gpib.c | 12 +++++++-----
 4 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/gpib/cb7210/cb7210.c b/drivers/staging/gpib/cb7210/cb7210.c
index 63df7f3eb3f3..356a3404e128 100644
--- a/drivers/staging/gpib/cb7210/cb7210.c
+++ b/drivers/staging/gpib/cb7210/cb7210.c
@@ -971,11 +971,13 @@ int cb_pci_attach(gpib_board_t *board, const gpib_board_config_t *config)
 	switch (cb_priv->pci_chip) {
 	case PCI_CHIP_AMCC_S5933:
 		cb_priv->amcc_iobase = pci_resource_start(cb_priv->pci_device, 0);
-		nec_priv->iobase = (void *)(pci_resource_start(cb_priv->pci_device, 1));
+		nec_priv->iobase = ioremap(pci_resource_start(cb_priv->pci_device, 1),
+					   pci_resource_len(cb_priv->pci_device, 1));
 		cb_priv->fifo_iobase = pci_resource_start(cb_priv->pci_device, 2);
 		break;
 	case PCI_CHIP_QUANCOM:
-		nec_priv->iobase = (void *)(pci_resource_start(cb_priv->pci_device, 0));
+		nec_priv->iobase = ioremap(pci_resource_start(cb_priv->pci_device, 0),
+					   pci_resource_len(cb_priv->pci_device, 0));
 		cb_priv->fifo_iobase = (unsigned long)nec_priv->iobase;
 		break;
 	default:
diff --git a/drivers/staging/gpib/cec/cec_gpib.c b/drivers/staging/gpib/cec/cec_gpib.c
index 3dc933deb401..26c0cce1e917 100644
--- a/drivers/staging/gpib/cec/cec_gpib.c
+++ b/drivers/staging/gpib/cec/cec_gpib.c
@@ -297,7 +297,8 @@ int cec_pci_attach(gpib_board_t *board, const gpib_board_config_t *config)
 
 	cec_priv->plx_iobase = pci_resource_start(cec_priv->pci_device, 1);
 	pr_info(" plx9050 base address 0x%lx\n", cec_priv->plx_iobase);
-	nec_priv->iobase = (void *)(pci_resource_start(cec_priv->pci_device, 3));
+	nec_priv->iobase = ioremap(pci_resource_start(cec_priv->pci_device, 3),
+				   pci_resource_len(cec_priv->pci_device, 3));
 	pr_info(" nec7210 base address 0x%p\n", nec_priv->iobase);
 
 	isr_flags |= IRQF_SHARED;
diff --git a/drivers/staging/gpib/ines/ines_gpib.c b/drivers/staging/gpib/ines/ines_gpib.c
index 9d8387c3bf01..b5f8ea57fd9d 100644
--- a/drivers/staging/gpib/ines/ines_gpib.c
+++ b/drivers/staging/gpib/ines/ines_gpib.c
@@ -780,8 +780,8 @@ static int ines_common_pci_attach(gpib_board_t *board, const gpib_board_config_t
 
 	if (pci_request_regions(ines_priv->pci_device, "ines-gpib"))
 		return -1;
-	nec_priv->iobase = (void *)(pci_resource_start(ines_priv->pci_device,
-						       found_id.gpib_region));
+	nec_priv->iobase = ioremap(pci_resource_start(ines_priv->pci_device, found_id.gpib_region),
+				   pci_resource_len(ines_priv->pci_device, found_id.gpib_region));
 
 	ines_priv->pci_chip_type = found_id.pci_chip_type;
 	nec_priv->offset = found_id.io_offset;
diff --git a/drivers/staging/gpib/tnt4882/tnt4882_gpib.c b/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
index e49a952fa0d8..1e41a48e6fca 100644
--- a/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
+++ b/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
@@ -1400,7 +1400,8 @@ static int ni_isa_attach_common(gpib_board_t *board, const gpib_board_config_t *
 	struct tnt4882_priv *tnt_priv;
 	struct nec7210_priv *nec_priv;
 	int isr_flags = 0;
-	void *iobase;
+	resource_size_t iobase;
+	unsigned long ibbase;
 	int irq;
 
 	board->status = 0;
@@ -1427,18 +1428,19 @@ static int ni_isa_attach_common(gpib_board_t *board, const gpib_board_config_t *
 		if (retval < 0)
 			return retval;
 		tnt_priv->pnp_dev = dev;
-		iobase = (void *)(pnp_port_start(dev, 0));
+		iobase = pnp_port_start(dev, 0);
 		irq = pnp_irq(dev, 0);
 	} else {
-		iobase = config->ibbase;
+		ibbase = (unsigned long)config->ibbase;
+		iobase = ibbase;
 		irq = config->ibirq;
 	}
 	// allocate ioports
-	if (!request_region((unsigned long)(iobase), atgpib_iosize, "atgpib")) {
+	if (!request_region(iobase, atgpib_iosize, "atgpib")) {
 		pr_err("tnt4882: failed to allocate ioports\n");
 		return -1;
 	}
-	nec_priv->iobase = iobase;
+	nec_priv->iobase = ioremap(iobase, pnp_port_len(tnt_priv->pnp_dev, 0));
 
 	// get irq
 	if (request_irq(irq, tnt4882_interrupt, isr_flags, "atgpib", board)) {
-- 
2.46.2



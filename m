Return-Path: <linux-kernel+bounces-415251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6319D9D3385
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 07:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29009281C54
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 06:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29301581F8;
	Wed, 20 Nov 2024 06:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U8pD2CKA"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794BD156C62
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 06:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732083915; cv=none; b=LFTXpr3WgsJ8jr3k/phfrRizbWwfv8R6JdV/uYbhbooo9ZicdnMRDN8aPlEyJFry3MtcmeSCYarR7IqSWAYgyQsyQeP3FTaP5m1MSjyJaKERZXk2TD03ewjihegQHyAZsgjsju8AZgdnrMiskGdsKiWk4iGOxa4Qm8I6X4q5HSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732083915; c=relaxed/simple;
	bh=ZKZ7wqRxV9VansX75u0xiTrAs0FThBNj2emfiSY9AOk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L/dqvp35VebcHUJ9kR6E7dxCvPPivawsl/ShgaF7ndUgHimGdw8uV1wn6X+/IgjQKBpJ4sdl1KaK6V3L7AwvfI2QgmwhmgRyxh3J32WUdxrSce8ur+wqNv6GGfVuOX5jg3eCBCXk0SfJFiPdfzFbxm5yjgRaUReJyZ1z+2Gtbjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U8pD2CKA; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c805a0753so17420485ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 22:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732083912; x=1732688712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sFKz5oP575/GGKkSd/ejkrlLxXRfRJ0KjhmoJGqH3o8=;
        b=U8pD2CKA+IRPQapBKZS2zXFqCa+KEaOHEBp6FVsC/O0IVOObxT0KbzQH+Yh5g9Y7+X
         0l2i6s0U8dAJzwNv4YvJjDM+LXmT8Xa5sG9FAPiSRWCv4jT00DrYcVnY6JqkWKt6ZmIb
         qzg/bX5prDXmTUOefbeNlexXWF9uYiX2EtNtBpeBs3NNENM28ydZIwZmMFIa9jlwQgmp
         N+7m0N0QPhAmhg5nk9ftED5T6+wDv2F1AcklpYFV81BohCb54wy1ZkEs4+j3adQ7Bcl7
         tDm88fGtluFPbqRYVfhUyk75u/Xbv1zzjDfbHVG2r/5ZC3CquzdZk1P9XKwFz6S4wtBF
         BVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732083912; x=1732688712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sFKz5oP575/GGKkSd/ejkrlLxXRfRJ0KjhmoJGqH3o8=;
        b=OUB7UATcN6WPCFpSA9aa+SEFBiPJ9IIQ0wg83ms0tBKhEejRhBGzFsJHeysyE0hWoo
         X7u9czz5xZmPvO5lcyWx7UZN9SSApu+YA26UO5Whnmqv5ouG87SuLU82KRSV5eh6MKe5
         Hh8Sol0/1Q7aG2DfFa40NvPZtYT7XegljD4BiDzIcdoRNVWObdQiBc1FW8oohBctMmOy
         Ml4brqrg6ViAeHdBNz5NarHPl6jH5CXIx1xi6Ns8MxHpzDZ+dTMEXvN6+Ptsc/wuu615
         fyLkbGGeFgq+4EnhUwE3nEegaLUB2xfbD6X1aiCoD2XNagh69HYRnNGk5IfB4Y0hXUeB
         0VRA==
X-Forwarded-Encrypted: i=1; AJvYcCWSAL2iiMsLXT/jflO8Yuqtx7HyFUmZwIFNIIwSEmX4wkbuxcgNf0DtZKhaFlvgzA0UlLfPl4It2P336A4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhdLNg0OwQtH5G/R0pzw5v6tVP1/bXCIr2Uz4ibScInl1wM9l+
	VRRYxQiTA4unlu0s9ft5B0snugkgYg3naPwia/AGsU1MFoUH8tbea1e2CzLBXQ==
X-Gm-Gg: ASbGncs0mwIqH299kkUi+2z53pRd8ewogOeQ/WvWAxNx2fR06YVu1UH4cxClUW1m+TQ
	VleIUrQaja4CcXrN3Cv8r2zihef54OoMH01w9W1BSbG3VBkeOzDmmxjxC/ie8gEIEyHCSmq+Z5M
	ASfwcVbAYw/5SPBvRLn0W9T17f3MzwXF/upPK8XbgTJD1yPZ7L1m65PTMw6//qwPEvb6JWrPfwW
	Up54Fv8bYoZ1SKhHV83XPT/vZICet5VLtnwxb9YgNMNj5cwT65SB4UndYQofmCTqwD35bQ/A3Y3
	9UY=
X-Google-Smtp-Source: AGHT+IGHiuQVE1t8Q8CRcKG+GcCbtmsWOft9c+j5QdvhCJHhuIzszwKB9MS1lyGgjA5L/zPWEVEGTg==
X-Received: by 2002:a17:902:e804:b0:20c:9e9b:9614 with SMTP id d9443c01a7336-2126a389ddcmr19064835ad.15.1732083911836;
        Tue, 19 Nov 2024 22:25:11 -0800 (PST)
Received: from localhost.localdomain ([120.60.129.189])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21229d7901csm43595145ad.265.2024.11.19.22.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 22:25:11 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bartosz.golaszewski@linaro.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jonathan Currier <dullfire@yahoo.com>
Subject: [PATCH] PCI/pwrctrl: Create device link only if both platform device and supplies are present
Date: Wed, 20 Nov 2024 11:54:59 +0530
Message-Id: <20241120062459.6371-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Checking only for platform device for the PCI devices and creating the
devlink causes regression on SPARCv9 systems as they seem to have platform
device populated elsewhere.

So add a check for supplies in DT to make sure that the devlink is only
created for devices that require pwrctrl support.

Reported-by: Jonathan Currier <dullfire@yahoo.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219513
Fixes: 03cfe0e05650 ("PCI/pwrctl: Ensure that the pwrctl drivers are probed before the PCI client drivers")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 7a061cc860d5..e70f4c089cd4 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -394,7 +394,7 @@ void pci_bus_add_device(struct pci_dev *dev)
 	 * PCI client drivers.
 	 */
 	pdev = of_find_device_by_node(dn);
-	if (pdev) {
+	if (pdev && of_pci_is_supply_present(dn)) {
 		if (!device_link_add(&dev->dev, &pdev->dev,
 				     DL_FLAG_AUTOREMOVE_CONSUMER))
 			pci_err(dev, "failed to add device link between %s and %s\n",
-- 
2.25.1



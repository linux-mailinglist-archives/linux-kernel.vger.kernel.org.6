Return-Path: <linux-kernel+bounces-269929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FA09438F5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 00:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 825311F2301D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 22:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA4216F27F;
	Wed, 31 Jul 2024 22:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZIjnoSEW"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4EE16EBED
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 22:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722464927; cv=none; b=Aws0WljNoaLVQPRH/8Pn6jrx7hPvPZ/rmmTDqmY39YriJN+N1afjS8OvX9y6K9DFWuw2XtF5rc/OxugqZAdeACP6F4L9Ozi1V9hhjhEGYqPeZT9SBvq982hZOUvaOhiQ/mGu7N/ywXg6xsd+DH4hywIJ1iEDo18s+MWxIutUBgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722464927; c=relaxed/simple;
	bh=Axler9r52aj1s9GK2m+ZS5HEzmaURax/pBU9GtjX+YU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Ql074CbaxRBHlzrAy9WNuTFjTtD7RN7ov7IdHM4hzhVeD5Ndtgof3Uk+BNaOe7w0LqT58kyMvRZDtloTC9JaSxk2kFEArCAANOEWRqBc6vWvoJ7Gkl6icWr7kSEdJVp9jmUtCnWlTnvK4DJfY+lOfuYIGDkDE9Z+PjUfST21kVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZIjnoSEW; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-44fe106616eso34150491cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 15:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722464925; x=1723069725; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tJc8HBYFIKOYZ9CyZ9IbVGyaBM2QRYS+Mj0ZBsZxAaw=;
        b=ZIjnoSEWyf8tibkylAARjhWmCx8QJN0arOi04w4k8lPCPag3vBA9raSgQbIynXI8u+
         vqN6zYudvWciuWdwGOiyOd+IE2REt1anYcJ43VYlGxCDeOnKkAo/XicBXbkqqdvizaTR
         I0u3SbRybEN38mDfYbo96LaaR9LuHiD7bk4mQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722464925; x=1723069725;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tJc8HBYFIKOYZ9CyZ9IbVGyaBM2QRYS+Mj0ZBsZxAaw=;
        b=Tx+9wZPzHz4QZML5zeWJjF3J6Uovk4Oa2VjQLCAFw0CcGfTFp0Nikq/sKV8EG1IP0L
         R6gNP1UBtwgGSr2XfLM0DeIWKFBKSsqHlDOEFbqB1E90YTj0dfdFyUzukpKtwL9zvNwl
         bf4np0skltvHRTIcj8VPLvI4l/IOK95xmB65E3KIHsUbhcS2t6EHNWFoqpvq9lxD4lty
         xL9J6sfHGH3hglPJnC7uvxqbOyrSysRQ6biUn2jEND5nAbg5KnerQraAPYKgyHpXapo8
         eLtekyxfuywfN1V2uJW0U+F8PbhgsoORkOZ9tzZU2EqNsi0s+ilGGU7Pz9xTiIzOSPaP
         f2uQ==
X-Forwarded-Encrypted: i=1; AJvYcCW90vB5INDcotOcvUBQ+iOU/A2CG39IQyCoFVE8wB1DRhlWO3HCmW2ajwwb8dxF/2GrX8tgbeq1yHp6s7bBAqI2trujgT5kCCneCnMh
X-Gm-Message-State: AOJu0YzWzTaDLrwgClD6QleCiXZiFtZDIU+D8vWevR5iwQx1WtFkLXLN
	6qzHjYvYbspXIJm/fhde0tGcBrwyyFKPwHIshW+t5X7W1GSJKarPc5fHowZ6oQ==
X-Google-Smtp-Source: AGHT+IGWS8XJqJxSeAH/l9U2iSnwykrx+/R/UPoZ2dJMSXMMtQONEAADXPeWL2Ey1+sfyHjCoQX+JQ==
X-Received: by 2002:a05:622a:1922:b0:44d:6627:4b16 with SMTP id d75a77b69052e-4514f9bdc74mr7720561cf.1.1722464924732;
        Wed, 31 Jul 2024 15:28:44 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe8416c80sm62359181cf.96.2024.07.31.15.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 15:28:44 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 07/12] PCI: brcmstb: Remove two unused constants from driver
Date: Wed, 31 Jul 2024 18:28:21 -0400
Message-Id: <20240731222831.14895-8-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240731222831.14895-1-james.quinlan@broadcom.com>
References: <20240731222831.14895-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Remove two constants in the driver which are no longer
used: RGR1_SW_INIT_1_INIT_MASK and RGR1_SW_INIT_1_INIT_SHIFT.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/pcie-brcmstb.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 9fa1500b8eee..1ae66c639186 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -210,11 +210,6 @@ enum {
 	PCIE_INTR2_CPU_BASE,
 };
 
-enum {
-	RGR1_SW_INIT_1_INIT_MASK,
-	RGR1_SW_INIT_1_INIT_SHIFT,
-};
-
 enum pcie_type {
 	GENERIC,
 	BCM7425,
-- 
2.17.1



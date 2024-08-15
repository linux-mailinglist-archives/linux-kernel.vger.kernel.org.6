Return-Path: <linux-kernel+bounces-288683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17810953DA4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 00:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1CC21F24F92
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 22:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E0E1553A6;
	Thu, 15 Aug 2024 22:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IOGfVlHi"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAB5155A3C
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 22:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723762666; cv=none; b=l8FBvpvl3/hybOTRLfC6h6Iy2VKYXCI0mWZ19NhxQV9idt/Z5sjlbHuGxVx1TxCJWWVxf9/+zOt0ktoBrDJRrhBtt76vqoSW19Vep4JPBqfoM0arojjkOoHqpqnD3EoOL9FYqeKtgpYws5d1nCW5fKLKq3VfURuJjaszZ9wljD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723762666; c=relaxed/simple;
	bh=pq/QmBERYfjLGdavM4Te4UmlwSg/DAfwT+HgNBz7FRs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BamvuxOGTFX3KLMYQHaYu/3omEjNb3K3RBvHFZzc+13XeLKc8VSJ7fHHCJ7UKIZNKDSCTyOvNTkSHzKJvMKNYLqUJm1riVPKtw9jw+U5RStuHxmNrgsOsde+wyzjr01JMyIFXVudMU3dNcRRA1dWiAwsQyG1WM+y/zu+QQIbIEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IOGfVlHi; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7a1c7857a49so1061923a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 15:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723762664; x=1724367464; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CRQkGsiqV7c3oa7/BSip4AQK8e/kbD1gffw1TrJCVrE=;
        b=IOGfVlHiYipCVMQCTsIIrli9BeYmeROJ1qRCeXkkUwbCiLsujE4rikP8VmKuY/RPy3
         Nrfb0xt3EIEN2WLbhW2JgO5RiAy5oeD/UoWN3OUB1JSIAyiFhKOPTDvtHR5SjuMazcJE
         wUM7s6Mmfj3dQNVUF4j5ePIDXkXjWAoR0shnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723762664; x=1724367464;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CRQkGsiqV7c3oa7/BSip4AQK8e/kbD1gffw1TrJCVrE=;
        b=De7Lz3STOdlXbnVecsNEPxIzCC7ZCluz1UzeLkcp2Ul9B1ku3STJlB0FIVIxf9JPIt
         6v0GfhrHvBNOOa4v1xmQXkER1zu23taCCDPg9tXqpOQTYOgzyyC+mXsM5cE0cdS4NQun
         C3DyOXQI8lWBOUjB65jZtRigOzQZdBiOrm1kqDvQc705LH5MoFSnXToYtM6iaIhg+IWY
         OU/bg/F9mzm53bD3+PjV8nY9CeS6VQeEu1TDzhAvdgc5kUJjYd7XaPN9d8IWAmR7Y4iY
         qclIiFLWIIZ/GScpf2WgcBv5KI9nqeKhaLl5XqsoQoPYRZGc+trAWjKHS7N30wldBeFL
         Vo1g==
X-Forwarded-Encrypted: i=1; AJvYcCXya2uIFwXqdVAhXrRhgGcg+P23kDVimfSyKJ4Bu6Ctl7WmdSp8eB9mtMBlxMxM/QIgoaD+TaDvCXs0ix0D7fzOjtkXSzhZks6QU9Uf
X-Gm-Message-State: AOJu0Yx7IvWRCSJMsZVQmEK38Lm+Mz/RtcNz9lL/DAKMbqoN5jvsb+fQ
	U2y/6mkkFwWg1Q08/G/2TrrK6w8+Dqkp2cusrtbGW+G7+wohQ/17b4Vi7sBgnA==
X-Google-Smtp-Source: AGHT+IGsU40PJngMIcYStf9Y9iTSE0jy+3YSJCHPXuJiJMQETsILw9S6JXDYzZrXRLDatiqnRms03g==
X-Received: by 2002:a17:90b:950:b0:2cf:c9ab:e727 with SMTP id 98e67ed59e1d1-2d3e00ef66emr1270794a91.31.1723762663566;
        Thu, 15 Aug 2024 15:57:43 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2e6b2d1sm373997a91.18.2024.08.15.15.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 15:57:43 -0700 (PDT)
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
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 01/13] dt-bindings: PCI: Change brcmstb maintainer and cleanup
Date: Thu, 15 Aug 2024 18:57:14 -0400
Message-Id: <20240815225731.40276-2-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240815225731.40276-1-james.quinlan@broadcom.com>
References: <20240815225731.40276-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Change maintainer: Nicolas has not been active for a while.
It also makes sense for a Broadcom employee to be the
maintainer as many of the details are privy to Broadcom.

Also, alphabetize the compatible strings.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index 11f8ea33240c..a95760357335 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Brcmstb PCIe Host Controller
 
 maintainers:
-  - Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
+  - Jim Quinlan <james.quinlan@broadcom.com>
 
 properties:
   compatible:
@@ -16,11 +16,11 @@ properties:
           - brcm,bcm2711-pcie # The Raspberry Pi 4
           - brcm,bcm4908-pcie
           - brcm,bcm7211-pcie # Broadcom STB version of RPi4
-          - brcm,bcm7278-pcie # Broadcom 7278 Arm
           - brcm,bcm7216-pcie # Broadcom 7216 Arm
-          - brcm,bcm7445-pcie # Broadcom 7445 Arm
+          - brcm,bcm7278-pcie # Broadcom 7278 Arm
           - brcm,bcm7425-pcie # Broadcom 7425 MIPs
           - brcm,bcm7435-pcie # Broadcom 7435 MIPs
+          - brcm,bcm7445-pcie # Broadcom 7445 Arm
 
   reg:
     maxItems: 1
-- 
2.17.1



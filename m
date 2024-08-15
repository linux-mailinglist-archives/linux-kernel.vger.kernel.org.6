Return-Path: <linux-kernel+bounces-288686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEF6953DAE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 00:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E109F1C23504
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 22:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882451591EA;
	Thu, 15 Aug 2024 22:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Sx7nTDbc"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748EB155744
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 22:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723762673; cv=none; b=QLuzZl3oIzJpE1JwjIQJw8fco0EIe4OnNhyuCHfkTZ1f64P7HXoGMJUFUhetDXQgiaX/bau1Ed+2omKG+8d+DEbhAKewWvrIrXg8FyOBkV67epmmoFO6wuygC3ZAkP9jwxJlaCXWMuQc6S5mvvsPRbNIjUCW7CyE65C/3lAghT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723762673; c=relaxed/simple;
	bh=hTD9OmJB81cIRNMB8r5RWcIaSLzWceBhC8SGhS5dFxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ldc7xsBy2RlO0IU7ViYCHYz824sylmij/7pNezrXqNG9pE88rVyvs2llo9YSWbwlQohc8BKfqyxAD4PyznmEtTw033WRB7jhhfo38aQcd+AH6z/Ecdn0GWzEWNUYNBfEYzciedIw/pk1AUB0xHo8/65p2EKR/tT1+xfnIJlcSbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Sx7nTDbc; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7c1324be8easo1826981a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 15:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723762671; x=1724367471; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WH+rdrTcxkg59J1njd2uJ3iEEueSc8kUH0E7SDV6ulc=;
        b=Sx7nTDbcR7yPMvFzZ1GMjVQi9FYvRYiYzfkSXaP4KO+d65ONXB5OFBLYXm1f4H4Cqc
         SFDd4WxWIiWzNMCIakWUXaUiAm5GKc+PCBGZRpJXAUYtcVCEe2qkGtXg0N/EHA04pLQY
         5uMCf0NkEF08sAu59olL+6QYG9Qkl+ih0Gz0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723762671; x=1724367471;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WH+rdrTcxkg59J1njd2uJ3iEEueSc8kUH0E7SDV6ulc=;
        b=GHS0VPvUYoWWBj/BfqNabEagWbXhofoo1W4LwFSLmnqZz7qOnFWmulB4Df+ihmdzzW
         4aIdX3D+IU+MN1r5XuFM1YALMCaSebT/m+LQla/DBJgYHYA8bs0MRx1ecBbzWCVWYiWG
         DoVPrKjN7XZiiVs6z8PqRJiUbHzQAsXtm/BY/mdCusLpTN6sErUYSrMmJNv5XuLvLDCs
         wBVmX6c7xctJAsp5T8JS8k0968o/OAWdGVPWP7C701eMMc0Da4TKPYcTd6xQTdzQ+Otd
         9OgAFXcPgdQhU+ir0Z4IoQp1YE+IeEmkmLG24jSEjinHnzfP7qfHUDD7Qa8ed17tlVSY
         TIXw==
X-Forwarded-Encrypted: i=1; AJvYcCUFzd2nekEXUNCUU6EjomLLLxeM02sAKF+AxhCMcE576eCorPEs+I3SauJFSbgiGFYTXbchLXwhIcdPAoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YydrQShj3dlaTAEN90MKbJ+xeli4HRJEVJzAYOG4Shj2Q5Gdl+Y
	nCGqhD2aXLxEwb8KseszDLdjDPSr/jUJq1DYw3YQ5KqDWdEA7d7LATIPTxKR4w==
X-Google-Smtp-Source: AGHT+IG376HhZUZrhW7Ph9mF+C01Bg0t7yn8TgdDnPPnyffSrZWUI6fa4Ar3i5RUImonP2U2TFaBsQ==
X-Received: by 2002:a17:90a:b114:b0:2cf:f860:f13b with SMTP id 98e67ed59e1d1-2d3e45d598bmr1129974a91.17.1723762671402;
        Thu, 15 Aug 2024 15:57:51 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2e6b2d1sm373997a91.18.2024.08.15.15.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 15:57:51 -0700 (PDT)
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
Subject: [PATCH v6 03/13] dt-bindings: PCI: brcmstb: Add 7712 SoC description
Date: Thu, 15 Aug 2024 18:57:16 -0400
Message-Id: <20240815225731.40276-4-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240815225731.40276-1-james.quinlan@broadcom.com>
References: <20240815225731.40276-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add description for the 7712 SoC, a Broadcom STB sibling chip of the RPi 5.
The 7712 uses three reset controllers: rescal, for phy reset calibration;
bridge, for the bridge between the PCIe bus and the memory bus; and swinit,
which is a "soft" initialization of the PCIe HW.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pci/brcm,stb-pcie.yaml           | 28 +++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index 7d2552192153..0925c520195a 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -21,6 +21,7 @@ properties:
           - brcm,bcm7425-pcie # Broadcom 7425 MIPs
           - brcm,bcm7435-pcie # Broadcom 7435 MIPs
           - brcm,bcm7445-pcie # Broadcom 7445 Arm
+          - brcm,bcm7712-pcie # Broadcom STB sibling of Rpi 5
 
   reg:
     maxItems: 1
@@ -96,10 +97,12 @@ properties:
       maxItems: 3
 
   resets:
-    maxItems: 1
+    minItems: 1
+    maxItems: 3
 
   reset-names:
-    maxItems: 1
+    minItems: 1
+    maxItems: 3
 
 required:
   - compatible
@@ -151,6 +154,27 @@ allOf:
         - resets
         - reset-names
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: brcm,bcm7712-pcie
+    then:
+      properties:
+        resets:
+          minItems: 3
+          maxItems: 3
+
+        reset-names:
+          items:
+            - const: rescal
+            - const: bridge
+            - const: swinit
+
+      required:
+        - resets
+        - reset-names
+
 unevaluatedProperties: false
 
 examples:
-- 
2.17.1



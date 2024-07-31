Return-Path: <linux-kernel+bounces-269924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9A69438DF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 00:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C7D1284211
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 22:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8654616DC3F;
	Wed, 31 Jul 2024 22:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RXeyd7CV"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436D316D9BD
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 22:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722464919; cv=none; b=CpT33AxE0sb5So8bpUZEMXMFb06xghGnEoVxrr2IBSznyW4/OQcBzolB5x1Yd2vIMB3TrYjSEh48VfjvaAKf1jZkNj+k7TP5zVM6pTI3GsZmKGNk9oJay25nKmt5ga5V4OhYPvxkW1IzRn9tsvd6AAjMW4YzOk1qQYV348lvTmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722464919; c=relaxed/simple;
	bh=mAoM+jm0P713mKZxMhykPOMr8VcVpW3lJ0JPpibSWzM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=d3U/DYEvy1+gu3G3e8aMd3MM+HHEb31/FxjPKkl3XxlyaaRAgkeEJ96tjAHsUKrONwxd9ipcwVnjRbJixJfIh7cYdT55VLJb1mLd8lggfAkEHIPZuqeVVjVmvjacHxNrElc5/DwlbuCTZccShbC7CoNmcFRP6i6LrjRbyIxpnkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RXeyd7CV; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-70940c9657dso3214268a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 15:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722464917; x=1723069717; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MEzSqlnsH2j9tRB5+9ly7frUJhXv2tJmhe1jZ23vhJ0=;
        b=RXeyd7CVF82M+8IeZtSpbzFhBrQKqFvVlxy9Mt4trRy1ahUJugA0vBwBxA+MKjbCIa
         N3hv3utV370A59jTjbrn0Mlt+IeHJQTQhBvXgIh/fizqbJO4kB2FAYcVA+/jSnNvRLeM
         tuJOKgIIXoo1+vsjtMXVSMJZCFLZQWDBXifQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722464917; x=1723069717;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MEzSqlnsH2j9tRB5+9ly7frUJhXv2tJmhe1jZ23vhJ0=;
        b=S8nZpcpHMsKGxDDOwlJ/6wHXVXEiESlaWJJqJ6QzuRQU/VSpozve4QhGkgoxW/PU5Z
         pwyk9hivEC0SuL5kqw2cT4uJ9yRct1F7AlUXT1uhOILb6UfzaLBOuvVW8kzi7EhlV7z5
         tnkvuhMPZ0jNmkWUDpkgnaue65MmirUR/Pr1ukbMiOwpIM9O8Pq4OwY8GHMHC8hlUSDP
         Vb2ciSaUx9wflCPew9t000xF1Xz7bJP5jEKOAM6uBaURx4DClZGXwLlMJ1mfV5+OWNQ9
         vswF6c7PIAmsKKB6bB1/aVlRm0xizWn1GkM8A8tOyU2FGaGNotrzNReizAtQbrp26leN
         Pdgw==
X-Forwarded-Encrypted: i=1; AJvYcCVdlDcXjaOflZA3X29MwW8ASDTeFHtJT+NeifD7Buf8AEb499h+NZ0wg2zvwnN973bq6MbGSVgS0Rp6IiSv63Yh1LN0KeLC3ASW588+
X-Gm-Message-State: AOJu0YzT1uSI7hpZhFyLB512cdLiasenq5JVj4Aw/KNjuVL+eGezQx7e
	fm6SPFIJpMZmF/X20F5mMKwY4iznroLCMFm0aQ2+rZo/VPAGh3dernqLKt9g7Q==
X-Google-Smtp-Source: AGHT+IHhsa4xXStr5djydA447oqZ0eywB6dQmFgO7T5029BQXALrAgyEhVKlX9qDw4OJNWb9FlBZHQ==
X-Received: by 2002:a05:6830:dc2:b0:709:441a:351b with SMTP id 46e09a7af769-7096b7da64cmr506886a34.8.1722464917301;
        Wed, 31 Jul 2024 15:28:37 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe8416c80sm62359181cf.96.2024.07.31.15.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 15:28:36 -0700 (PDT)
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
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE),
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 02/12] dt-bindings: PCI: brcmstb: Add 7712 SoC description
Date: Wed, 31 Jul 2024 18:28:16 -0400
Message-Id: <20240731222831.14895-3-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240731222831.14895-1-james.quinlan@broadcom.com>
References: <20240731222831.14895-1-james.quinlan@broadcom.com>
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



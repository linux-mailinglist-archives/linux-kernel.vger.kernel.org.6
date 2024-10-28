Return-Path: <linux-kernel+bounces-385416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3DE9B36F2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A9F12828A7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD151DED5E;
	Mon, 28 Oct 2024 16:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjoRu3Yd"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F97F189F58;
	Mon, 28 Oct 2024 16:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133871; cv=none; b=RH5JOEG96yn05UwI4eN7nDjQhRx+1gQqU1yc1ciO0GMyz+NdPzBRqOzXoTWzorG6cEmzYv6wunA1opzdzev6GyrT9rZdcEBdT8uvsKAWXx/aP3Pd0R4p+1ekAmGIyKsT6leE2TZWVpd8yuan43n0qRgyBu6zQEG9ucEQAqp3ta4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133871; c=relaxed/simple;
	bh=VYXYBYtZZtmYHYEH++bEHUARDCjOd5EUg4f7Zg6dWOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hxV4MDhHGKIVNojKJ4vpnE3h4HuVqY7DnNf/lUIrk9ZZDXH2kWzcdA9HcUocnMsu8MfLUrD1tjDDGSFSBWtzy9J0mEDxzIkvQnL7cO6IDb3zfLN1Gci03w9v78xIWMyUqRHI81rmdG4+lmfkWa5YqqEPfJzr+WMpAuT6P29UNZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjoRu3Yd; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20cf6eea3c0so35795695ad.0;
        Mon, 28 Oct 2024 09:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730133868; x=1730738668; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dXjXaMc1+NjmQK/N1YVEu7l1Gn/kANyJvtlcEB9iCKI=;
        b=jjoRu3Yd1f1nhoC/HyO8GNekD7wv24PsAjn4p1y9EMiwONKvs+C2hm3cvGf8n/DRm9
         Awt3jcJm7BiIzCfqi3sW6qTYenloLw/TYLeB+m85YelldaFYZXN6H5LWtOWG3of+g8OI
         imE26W/0VogCoTy7NEEtKyOGvneU7IOFwa+tvJWJRyc+PxpEvOpD5T0isYrwnSxGq7oa
         hwnwWXvGLhBGJCMvPVuUnG3d3eH+8F9O8umnLgKQ9x2UCv+FxzCa5qMO1HGRR7nBZT+F
         +ZPesxdrN2scA/9aYDZBG/g1eQBy4ss2OQ9ls4wpZ4yk9j+E09XDV+ZEwbLZyRz2eAXX
         IdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730133868; x=1730738668;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dXjXaMc1+NjmQK/N1YVEu7l1Gn/kANyJvtlcEB9iCKI=;
        b=P9E+Z7o0ClR89x33UQ9bMrUjpTJIGdP7LmZ5GJSvGYsQmJPsAdIdeTvxBrtEi1nwyz
         wcPDGebUp80o5gsI5Y509CYpxHmExTorIY7ocNV76P/93tOdx67/h0f25A2xPDCJzjTt
         XP3AXe+4z7S44SqKZz4azlj4AS70B+umQIjGZDwV85tyxDCNq+kmvdBBKkgbi3j6FmvT
         gf/mfdzilAcnidgcEdRgouxCLLSp5jSflQCHFDxB1IKqKPvjLWmMv1Zi3s/hVMz6xsQc
         Vq1Cb5p3eOYNWa/1Tgvhx34l+cXySoDK6uNrTuMvc3zAZTF3K/D8weoPEaZeIvk/F883
         f+Eg==
X-Forwarded-Encrypted: i=1; AJvYcCWnJgYiW1IlTW6b7Sa15G/phehdRxvcVB1ttz8cYWuZa3EQhCTc+0pBBsF1Co4jJIm1GT8Z72ltiEn4SbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAIuut7xEKn4f1YcPNvswng9GBNc5c3boKXjjCR0Chs46gcHLl
	kf+7IDbZS/fIuOPR24b/kb5pWrFS7NbEhgNGYlc700FwOjUqv6nWgRRDQM14mcM=
X-Google-Smtp-Source: AGHT+IEoqZmHqm6VAVqxfSwuXHWEddFHtQFD30kf+K8fdWv/AuPsHvUw8j0J5Wk9KXaGWw2byK+M7g==
X-Received: by 2002:a17:902:ecc3:b0:20c:f292:3a21 with SMTP id d9443c01a7336-210c6892a36mr128561235ad.15.1730133868261;
        Mon, 28 Oct 2024 09:44:28 -0700 (PDT)
Received: from Emma ([2401:4900:1c96:f151:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc044f82sm52646685ad.258.2024.10.28.09.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 09:44:27 -0700 (PDT)
From: Karan Sanghavi <karansanghvi98@gmail.com>
Date: Mon, 28 Oct 2024 16:44:12 +0000
Subject: [PATCH v4] dt-bindings: power: Convert raspberrypi,bcm2835-power
 to Dt schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-raspberrypi-bcm2835-power-v4-1-acf44abd45ff@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFy/H2cC/43NwQ6DIAyA4VdZOI9FCojstPdYdkCsSjLFwOJmj
 O8+9GR2MEtPf5N+nUnE4DCS62kmAUcXne9TiPOJ2Nb0DVJXpSaQgWAZ0zSYOJQYwjQ4WtoOCi7
 p4N8YqDQCOCux0FKTdD8ErN1ns++P1K2LLx+m7dXI1u0/6sgoo0qiBlFZroS8NZ1xz4v1HVnVE
 XYSwJEESWJGmCKNVFz9Snwv5UcST1KeA8NMyYrzei8ty/IFyppN2FYBAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Alexander Aring <alex.aring@gmail.com>, Eric Anholt <eric@anholt.net>, 
 Karan Sanghavi <karansanghvi98@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730133864; l=4072;
 i=karansanghvi98@gmail.com; s=20241017; h=from:subject:message-id;
 bh=VYXYBYtZZtmYHYEH++bEHUARDCjOd5EUg4f7Zg6dWOE=;
 b=SxiVf23KimpjOkVKsF4/k3vHDNwyubJt+SdtqEl7+QYLfn+WnZ0z2mrcRUCInTQ/sC8RBJm50
 fs/4Yjc4BBWCgAMHKe+CjF7l09yo6bUvg0LyIpivuqZfq1Xbmumrsu8
X-Developer-Key: i=karansanghvi98@gmail.com; a=ed25519;
 pk=UAcbefT1C06npNVDJHdgpPqTm4WE9IhaA1fmJb3A37Y=

Convert the raspberrypi,bcm2835-power binding to Dt schema

Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
---
Changes in v4:
- Corrected misindentations and random differences.
- Link to v3: https://lore.kernel.org/r/20241026-raspberrypi-bcm2835-power-v3-1-6621e075d33f@gmail.com

Changes in v3:
- Applied changes as per the feedback received for title and description
- Removed power label and renamed node to power-controller	
- Moved the file from bindings/soc/bcm to bindings/power
- Link to v2: https://lore.kernel.org/r/20241022-raspberrypi-bcm2835-power-v2-1-1a4a8a8a5737@gmail.com

Changes in v2:
- Added original file maintainers
- Removed unnecessary headers from example and formating from description 
- Link to v1: https://lore.kernel.org/r/20241019-raspberrypi-bcm2835-power-v1-1-75e924dc3745@gmail.com
---
 .../bindings/power/raspberrypi,bcm2835-power.yaml  | 42 +++++++++++++++++++
 .../bindings/soc/bcm/raspberrypi,bcm2835-power.txt | 47 ----------------------
 2 files changed, 42 insertions(+), 47 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/raspberrypi,bcm2835-power.yaml b/Documentation/devicetree/bindings/power/raspberrypi,bcm2835-power.yaml
new file mode 100644
index 000000000000..259e1d9b3fab
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/raspberrypi,bcm2835-power.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/raspberrypi,bcm2835-power.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM2835 power domain
+
+maintainers:
+  - Alexander Aring <alex.aring@gmail.com>
+  - Eric Anholt <eric@anholt.net>
+
+description:
+  The Raspberry Pi power domain manages power for various subsystems
+  in the Raspberry Pi BCM2835 SoC.
+
+properties:
+  compatible:
+    enum:
+      - raspberrypi,bcm2835-power
+
+  firmware:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Reference to the RPi firmware device node
+
+  "#power-domain-cells":
+    const: 1
+
+required:
+  - compatible
+  - firmware
+  - "#power-domain-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    power-controller {
+      compatible = "raspberrypi,bcm2835-power";
+      firmware = <&firmware>;
+      #power-domain-cells = <1>;
+    };
diff --git a/Documentation/devicetree/bindings/soc/bcm/raspberrypi,bcm2835-power.txt b/Documentation/devicetree/bindings/soc/bcm/raspberrypi,bcm2835-power.txt
deleted file mode 100644
index 30942cf7992b..000000000000
--- a/Documentation/devicetree/bindings/soc/bcm/raspberrypi,bcm2835-power.txt
+++ /dev/null
@@ -1,47 +0,0 @@
-Raspberry Pi power domain driver
-
-Required properties:
-
-- compatible:		Should be "raspberrypi,bcm2835-power".
-- firmware:		Reference to the RPi firmware device node.
-- #power-domain-cells:	Should be <1>, we providing multiple power domains.
-
-The valid defines for power domain are:
-
- RPI_POWER_DOMAIN_I2C0
- RPI_POWER_DOMAIN_I2C1
- RPI_POWER_DOMAIN_I2C2
- RPI_POWER_DOMAIN_VIDEO_SCALER
- RPI_POWER_DOMAIN_VPU1
- RPI_POWER_DOMAIN_HDMI
- RPI_POWER_DOMAIN_USB
- RPI_POWER_DOMAIN_VEC
- RPI_POWER_DOMAIN_JPEG
- RPI_POWER_DOMAIN_H264
- RPI_POWER_DOMAIN_V3D
- RPI_POWER_DOMAIN_ISP
- RPI_POWER_DOMAIN_UNICAM0
- RPI_POWER_DOMAIN_UNICAM1
- RPI_POWER_DOMAIN_CCP2RX
- RPI_POWER_DOMAIN_CSI2
- RPI_POWER_DOMAIN_CPI
- RPI_POWER_DOMAIN_DSI0
- RPI_POWER_DOMAIN_DSI1
- RPI_POWER_DOMAIN_TRANSPOSER
- RPI_POWER_DOMAIN_CCP2TX
- RPI_POWER_DOMAIN_CDP
- RPI_POWER_DOMAIN_ARM
-
-Example:
-
-power: power {
-	compatible = "raspberrypi,bcm2835-power";
-	firmware = <&firmware>;
-	#power-domain-cells = <1>;
-};
-
-Example for using power domain:
-
-&usb {
-       power-domains = <&power RPI_POWER_DOMAIN_USB>;
-};

---
base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
change-id: 20241019-raspberrypi-bcm2835-power-5a4231be8959

Best regards,
-- 
Karan Sanghavi <karansanghvi98@gmail.com>



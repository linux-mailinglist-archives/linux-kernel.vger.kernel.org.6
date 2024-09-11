Return-Path: <linux-kernel+bounces-325125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D9197554D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC9228841E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377071A2622;
	Wed, 11 Sep 2024 14:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="MQVWXSeO"
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C7819E973
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 14:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726064886; cv=none; b=FB523NlCXfDtvgcC/gTEayZA6kssr629WdY6ltHyyVvZRSk0Pmu4JimsYvgd2/KBxJ6t2/bkxvVQ7mmknVONnjIOErfkwUDk8GdCTN6GzgufA+649vreQxciwSNTdLC/PxzAtNTwQtPXHO4il4iY6LCaFaw0IgMizys6giaA6+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726064886; c=relaxed/simple;
	bh=bvB7UmeHkRb7yfH1nDvmOVlGFumWUUvfkn5d5HzsWdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S4lEQ8GGOI6r5eHkZaIbTOk6svQlKQxbLi1LQ+d7XVN6GXEStaYXh7sfpMLD2DjB8f3vamwZllWR9KGQWwyB6dji1erbestsCvwJECKey6zr555YmmYJszc4KTWyGpK4/Hq0tQz3jynw2p9mBLga+86CLR6KyvmeI0zPH+cFW+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=MQVWXSeO; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-6bce380eb96so4178304a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 07:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1726064884; x=1726669684; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pHzBg2St8KC9MTBvt8ke8cxG8WKshDc3eLooksnIRmE=;
        b=MQVWXSeOT9AiyD/ELIoVgfFucdYinm+P3mjoF8gwpmpfHm9RiS+TRyR53UNSAeJI6e
         /v7XNFNs1PQq/Ab+Jy1Qd3OgCQcuhn3nQyNrOKa9CXZTXukRqYIJNs2JDgJnAR2H+LjM
         LdcwbG27mVm6o7xI6ygnDpMJr9tjYjzgtsc+x9xC/KQd3dLsEImgTekzcX9x/AH5JX3X
         YM4PyVk7p8M+yZXh4Y3RLFhYXAqiJ6XxOTZICDpDtDCsUMHPukBDwYwV128GGizAFsSK
         +jITWG2nOF3cw/lpKat71e/B8CSZI78ZqtcA9opuk0zf61i3aFzNH5BggYv+EWFBdRWN
         I95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726064884; x=1726669684;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHzBg2St8KC9MTBvt8ke8cxG8WKshDc3eLooksnIRmE=;
        b=S06+kUfsKVWN5Qxjr+9/zOcTNCVokumrZFGxt85Z3qEnKL21IkIEBYoOifUf7QgzOh
         CUMTrBqM9n/kB/bYB1bBGyG1spbf6fsKaYVnjZb/gr/kcl+6fnHsrUZVFAHelJWEepgp
         0CFDCrHuojFX490KM+k++Qhh9/WjBufG1l//bD/fkVUfJRfR09IwXzVsow70cr+8DozJ
         2yZxtE0bvwUQ3yuvMs191FdaSqZP0Ujz8CLxO7wnhyVRz1qyhEf3O2UPYuJZHivUTVNG
         mrgSpL4oofRRGquZDQNXR20QdaxS/Fo8APv3CjLeFMgJNoSIiA3IjZzzIuACClsHSA2c
         Mapw==
X-Gm-Message-State: AOJu0Yyo/Os9dL2HHD26GbSSVdY+0naySd1QA14o1zQkhikisWM+Rmph
	0I224XbYe37b6bd1VfgXY8DWZxFJPBuCtFBOiZlEi5N4Ejy78bTLAitfRTEZvg==
X-Google-Smtp-Source: AGHT+IHrUIfQbv5AN7Xe8j4SPuyNBG/fmpYAyLy0qzTADvtIG9r/hxpLBd4G7kq++lMyZOfVqXoYCw==
X-Received: by 2002:a05:6a21:a24c:b0:1c6:a65f:299 with SMTP id adf61e73a8af0-1cf5e0b0f15mr6316863637.21.1726064884284;
        Wed, 11 Sep 2024 07:28:04 -0700 (PDT)
Received: from [172.16.118.100] ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadbfe46c9sm10639116a91.11.2024.09.11.07.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 07:28:04 -0700 (PDT)
From: Ayush Singh <ayush@beagleboard.org>
Date: Wed, 11 Sep 2024 19:57:19 +0530
Subject: [PATCH 2/8] dt-bindings: connector: Add MikorBUS connector
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-mikrobus-dt-v1-2-3ded4dc879e7@beagleboard.org>
References: <20240911-mikrobus-dt-v1-0-3ded4dc879e7@beagleboard.org>
In-Reply-To: <20240911-mikrobus-dt-v1-0-3ded4dc879e7@beagleboard.org>
To: fabien.parent@linaro.org, d-gole@ti.com, lorforlinux@beagleboard.org, 
 jkridner@beagleboard.org, robertcnelson@beagleboard.org, 
 Andrew Davis <afd@ti.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Derek Kiernan <derek.kiernan@amd.com>, 
 Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Ayush Singh <ayush@beagleboard.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2947; i=ayush@beagleboard.org;
 h=from:subject:message-id; bh=bvB7UmeHkRb7yfH1nDvmOVlGFumWUUvfkn5d5HzsWdc=;
 b=owEBbQKS/ZANAwAIAQXO9ceJ5Vp0AcsmYgBm4ajVf1aUzhSg3g8lMTcWQQvps+sHJjBBiD7Xs
 SrIX/+QkiiJAjMEAAEIAB0WIQTfzBMe8k8tZW+lBNYFzvXHieVadAUCZuGo1QAKCRAFzvXHieVa
 dHEkD/kBcosApl+NDTha5IyXyoMZ2/VMJYYb9jHEMuIeh0sCz4/R99nJGGDh1QqObyzxtd5TjNZ
 sg7kEiloFxGZillTwOFtnKYZ0M+6+lMmKerv0eM0efboEmZ8AgGzlmRfsGQ3tWN80BWa1Lk35BI
 aS8JZ4PU2OG6/eSuWgP4Ma1Jc6YjWaGM++dXij1XvDv+WEQdBVrKW000lbVH0gWzzvdlZyzVV+I
 l9BbIpHSr+AThn5Ct78dRkKpqjpzMGfFI5JVfz17yhHQKv0JnTq7XkyC/Sdd1X9GIv3Ultsom9Q
 l3ESMf3rJl2Ys6f7xGy7VCXJbcZdjP1xKnwLNPCz7DrcuGZt76AzJra2Ji9JD8HCMzwcdL7Izsg
 vXKagN2tnyHM54Mjs815DpfzHGnQqRJ5c1+oU2kEbDbyH4mF9tAWoFYaTkUTU/hgOap8g1Rb2Uk
 i0H0HztxWVxUvpbEofXHGeee14TxETeS4fsJSgRV0P8GmsoLnAFmWI8KrDvIfMH7hnMlfdNv0pB
 yoM7SbVpDpbvkkC7Q3HaWThv9HSZX4klCgPk6RDanF+w/gFh6x9GrpKtBhascCz6Wcz6NbB8kAb
 KEKPAO77QpY6/XEQKCd3TK0S4jSDxsfrpgm/J2SnLebG3ASfy+pGcrb7CMVK6NNkjMTZDbrTp8P
 rEL5KP6r4Dc3g0g==
X-Developer-Key: i=ayush@beagleboard.org; a=openpgp;
 fpr=DFCC131EF24F2D656FA504D605CEF5C789E55A74

Add DT bindings for mikroBUS interface. MikroBUS [0] is an open standard
developed by MikroElektronika for connecting add-on boards to
microcontrollers or microprocessors.

MikroBUS connector node will optionally act as nexus nodes for routing
GPIOs and PWM.

For GPIOs, the following pin numbering should be followed:

  0: PWM
  1: INT
  2: RX
  3: TX
  4: SCL
  5: SDA
  6: MOSI
  7: MISO
  8: SCK
  9: CS
  10: RST
  11: AN

For PWM, the PWM pin should be on channel 0.

I am not quite sure how to deal with the nexus node properties
(#gpio-cells, gpio-map, gpio-map-mask, gpio-map-pass-thru) since they
seem to conflict with upstream gpio schema (gpio-controller is a
dependency of #gpio-cells).

[0]: https://www.mikroe.com/

Signed-off-by: Ayush Singh <ayush@beagleboard.org>
---
 .../bindings/connector/mikrobus-connector.yaml     | 40 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 +++
 2 files changed, 45 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/mikrobus-connector.yaml b/Documentation/devicetree/bindings/connector/mikrobus-connector.yaml
new file mode 100644
index 000000000000..603e4627076c
--- /dev/null
+++ b/Documentation/devicetree/bindings/connector/mikrobus-connector.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+#
+# Copyright (c) Ayush Singh <ayush@beagleboard.org>
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/connector/mikrobus-connector.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: mikroBUS add-on board socket
+
+maintainers:
+  - Ayush Singh <ayush@beagleboard.org>
+
+properties:
+  compatible:
+    const: mikrobus-connector
+
+required:
+  - compatible
+
+additionalProperties: true
+
+examples:
+  - |
+    mikrobus_connector0: mikrobus-connector0 {
+      status = "okay";
+      compatible = "mikrobus-connector";
+
+      #gpio-cells = <2>;
+      gpio-map =
+      <0 0 &main_gpio1 11 0>, <1 0 &main_gpio1 9 0>,
+      <2 0 &main_gpio1 24 0>, <3 0 &main_gpio1 25 0>,
+      <4 0 &main_gpio1 22 0>, <5 0 &main_gpio1 23 0>,
+      <6 0 &main_gpio1 7 0>, <7 0 &main_gpio1 8 0>,
+      <8 0 &main_gpio1 14 0>, <9 0 &main_gpio1 13 0>,
+      <10 0 &main_gpio1 12 0>, <11 0 &main_gpio1 10 0>;
+      gpio-map-mask = <0xf 0x0>;
+      gpio-map-pass-thru = <0x0 0x1>;
+    };
+
diff --git a/MAINTAINERS b/MAINTAINERS
index 0a3d9e17295a..0cc27446b18a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15429,6 +15429,11 @@ M:	Oliver Neukum <oliver@neukum.org>
 S:	Maintained
 F:	drivers/usb/image/microtek.*
 
+MIKROBUS CONNECTOR
+M:	Ayush Singh <ayush@beagleboard.org>
+S:	Maintained
+F:	Documentation/devicetree/bindings/connector/mikrobus-connector.yaml
+
 MIKROTIK CRS3XX 98DX3236 BOARD SUPPORT
 M:	Luka Kovacic <luka.kovacic@sartura.hr>
 M:	Luka Perkov <luka.perkov@sartura.hr>

-- 
2.46.0



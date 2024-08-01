Return-Path: <linux-kernel+bounces-270645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF129442BE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 07:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 868161C215FC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 05:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0648414A0B2;
	Thu,  1 Aug 2024 05:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHjQyuqP"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94091494A5;
	Thu,  1 Aug 2024 05:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722490674; cv=none; b=t/KL1oCoLkY4z0U1uFax4bqCHRehr+LQ/vT4g3fmHMOex9IOxkZd6GthBpdXrbjBGaOOIKNNEXWPKDPi8UDftNNXk6uyDICQr0AzJW75W1Yr7DQLVYDVu9a2RgWYhTvkbheKMYEbdSQuTZmF4ADhV7p8TnJ8b9q2K9ZlmnljXC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722490674; c=relaxed/simple;
	bh=VgErsO9Bu9i1N0q7g4chdZ8Ywx5KcoaxHc4DksL9CZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TdIytVycsMJ7cron2QMEzOeY2PRNj53UHmnrIzCg/iPgupvpWXfkviTW8p7Lt11KDfd1hQRuxqIHb+7tJfJjCfGkQ9YFYKqR3wdtXmo4WIo58QkVViSmdVm6RxSJaQgofC0FG2wh06atWDDwaSsHgvc69mh3Mf5L+6PLN2i3cag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHjQyuqP; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7093472356dso3851819a34.0;
        Wed, 31 Jul 2024 22:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722490672; x=1723095472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3MNgSOYTjr0yotm20dGZhPscWJIs6USm/mz1o5vZIGA=;
        b=dHjQyuqPbegkT7gpCmHzpZbwg2VUVlKWMCCkxwV3DegpbA3Wru7K3uiGZqgIQRqE55
         nPAYqFx/JxlIciRhEzXSsmRLLhjLHaxG6XwrbwlP2X2wxIpmZ1eqOm2Th/si1HF39K13
         G6zOGXN2dGbCxa16KVFw87J3zarzJSQHYGDLO4KwHikI5E5NlIe+HtCINwa8ahkjMzK8
         wmrBVrIMRUHRz1+K4GddJfABAfgrPIRit75LVZ0BqhVKSaWU8muRLQFf11GcRlsRj1fN
         US9zAIH4xczPBd3PehgJ0pxhDzVhH3Rviv0w5BxuI48cP7ASG6BY0xy8uu8gC3iaJiLG
         pqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722490672; x=1723095472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3MNgSOYTjr0yotm20dGZhPscWJIs6USm/mz1o5vZIGA=;
        b=h0BN8SdlCfzE+lDY1oLLJhCux2OLliVH08XsW750E0NjJbfz00LGTZLoccfBcsWZnI
         j8ZGX0fNXNdPGSrILghI/a90uWKmbY/DlOd5T9MBu0+Z1SD3A0lbtqVQpf9noJKC68Br
         kM6aT+7BKNj/7sIg54WwPj1eff039BeGDPlzN5nxLjVt7yDRIS73SZfBiS/sL/5yjESE
         pL4aNP6TbcLiEULo+ofTmmo6/P/hB2sYNfbVseAj+2ul9PcCxPM99nLn4Ls+u3mz1iRt
         IWwMkPm9zCYdRw6BGKfwhlGcrH5Lz+Vi4yWeQxPfRNkAswaJ2eiIM65OsG/IJC/D28rC
         8duQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbl1Wmn2djGoypNzsIphTQIbUJpbnc+5VScjFBAdjeUEH+eNUvhryI/r/ujGj4mSqblyJ35x/kj9RtQ0kRZYuMCCEgJGAyS1LEszktqh6ggcROqVGPuHe8UZJJD8x1rhvH3l72CHb3SQ==
X-Gm-Message-State: AOJu0Yx0cJA8/Ia8eFrwqryoaM/OHGO2uE7SGgnuD3hd0NFecNPeaPy5
	lS39pQz6fZnv6YFg8lCdFpRWx366lP1uud6M2/lp3M+QdVfI9CPN
X-Google-Smtp-Source: AGHT+IFHj5gZE5I/GE+V4PctpDOeXJbUvmybA0nK1W+z6o1ml7knwia+MEFR3nWUNKILeEaXSFbfWQ==
X-Received: by 2002:a05:6830:681a:b0:709:472d:f35a with SMTP id 46e09a7af769-7096b838521mr1315004a34.2.1722490671798;
        Wed, 31 Jul 2024 22:37:51 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead72b89csm11106876b3a.94.2024.07.31.22.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 22:37:51 -0700 (PDT)
From: Hui-Ping Chen <hpchen0nvt@gmail.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui-Ping Chen <hpchen0nvt@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: phy: nuvoton,ma35-usb2-phy: add new bindings
Date: Thu,  1 Aug 2024 05:37:43 +0000
Message-Id: <20240801053744.807884-2-hpchen0nvt@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240801053744.807884-1-hpchen0nvt@gmail.com>
References: <20240801053744.807884-1-hpchen0nvt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dt-bindings for USB2 PHY found on the Nuvoton MA35 SoC.

Signed-off-by: Hui-Ping Chen <hpchen0nvt@gmail.com>
---
 .../bindings/phy/nuvoton,ma35d1-usb2-phy.yaml | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/nuvoton,ma35d1-usb2-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/nuvoton,ma35d1-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/nuvoton,ma35d1-usb2-phy.yaml
new file mode 100644
index 000000000000..fff858c909a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/nuvoton,ma35d1-usb2-phy.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/nuvoton,ma35d1-usb2-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton MA35D1 USB2 phy
+
+maintainers:
+  - Hui-Ping Chen <hpchen0nvt@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,ma35d1-usb2-phy
+
+  "#phy-cells":
+    const: 0
+
+  clocks:
+    maxItems: 1
+
+  nuvoton,sys:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to syscon for checking the PHY clock status.
+
+required:
+  - compatible
+  - "#phy-cells"
+  - clocks
+  - nuvoton,sys
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
+
+    usb_phy: usb-phy {
+        compatible = "nuvoton,ma35d1-usb2-phy";
+        clocks = <&clk USBD_GATE>;
+        nuvoton,sys = <&sys>;
+        #phy-cells = <0>;
+    };
-- 
2.25.1



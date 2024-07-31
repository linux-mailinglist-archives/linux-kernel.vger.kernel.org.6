Return-Path: <linux-kernel+bounces-268403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F047194243D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 03:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 366941C22D90
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 01:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3272E10A0C;
	Wed, 31 Jul 2024 01:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CF4+bUQH"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B7FCA64;
	Wed, 31 Jul 2024 01:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722390201; cv=none; b=mOqPlRn+DcrpkKJQ5e+92e3PSbaiWobnpu0/cfDJrHGKtn+0XB6+VOcfl1YxrtxSySZU+yiiwosch1A5yjGrRU2FNfUCYumYfeLkQWtPYhWm1iDDd4/kXpmIiKNFawFvxvz16i+rmKNk3q5/T6ADtm+E9lwqQNt87uds/8GRZaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722390201; c=relaxed/simple;
	bh=beGK8MkLUwnyhiIQrjSeZjxpoX7GVaUmKaLkXjCPN1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hjTvFt16BkhkLRjMX5cFs11/RX8Z0B126STNhDaVznYWj/ONtvXqQyLTUhfteaSctoV0g4WZdZPa/maa+xyt3vKbGp5EnLTH4CPcKShKdjmMWEyZt0r4/FSQgRL/zHEndwBhUX/M0Umc8vQlAQ95eoHe26kdlXenteIANtyGm6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CF4+bUQH; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-79b530ba612so3303387a12.2;
        Tue, 30 Jul 2024 18:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722390199; x=1722994999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZ8O+vI9iMeU7lzBnuuDEYO9Q3c4Oim5G6C7n9hzAnM=;
        b=CF4+bUQH2t0t4ayb9gxoUUutVOykL0S/HTRChuC270ilL/3DjpJQmOtDlz9LwCQQwH
         fsURgt43EKOfCxpDhbMzCjP5bfAAd5GdkKV+8qlr/UNN1CNkzj5+S2EyY4CxkofhafRB
         1R2aqRMHJYhyCBxLTAp4ntU1K5BpR2WpFJC3RmzlaPoW7G7cjvSZ9qf0ubwoMRWxrRsm
         9sYXux6yeAfSABqNDP3XM9+XMkSz5pbRY4x34OoT9DHoLbzOHw9qWeUKHf+AsJowSrlE
         vJLzFozzVPjQgrzJbwy5msHdwKpmE2XJ4hbjqH/KKS3yoWN6tt73sPX/5AUMIAiUVRO4
         wq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722390199; x=1722994999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZ8O+vI9iMeU7lzBnuuDEYO9Q3c4Oim5G6C7n9hzAnM=;
        b=h3kxBQGPNfxbCfpyHOxwAve2/50M1TQ+fcFiOWCr3Yq4sJoyFib6Jm/rKNiIRHjJWO
         U1giHwjv47UIqJezVHnOAYJx4a5lqCxgi3TGeQq/uDxkbNabSsoMVnOht6Yn8rlrinYG
         waXmZ1CvtfLh6WYqKEK4v/xUS6ktILHYBCRxFQc5rWO8e+xWmaQxfGPdggl2WLuRrVsN
         pSlVrem1CGjWXsYgnRRmlpDoWRQ2ST22R3lPFysj03/HuJj5JIfySskqjsv++jIxNpkh
         a/qHPG7wqbJ3ED44McGr/W2mYgTNCN6oyKb06YbsdjQsmN/rK+EamEbWXKNckGqxA+Es
         tRzg==
X-Forwarded-Encrypted: i=1; AJvYcCWU0jMZWLYFNhngju3M4NNdbxkg2rYGl4ldT5I/zyuYMOaTUxnVmQHCUatDnTKCvvnx1imKnNrjj/wDf6JtkFqb8MgYc+B6DdvGD3ANPXz4Z0KRlFoOfTo5Br/HAX0sWmKOoecRfCCRww==
X-Gm-Message-State: AOJu0YzCwLEPW7RDIN2trecTTpdv2MmAZ8VYqkFVQJvQcdAz8KNr6PgV
	AQd2CwvNK1oJBHOcXmJI5zs0Q6bKUGeuJL5G0MqtsP/mIM1rId4iydJ1Jg==
X-Google-Smtp-Source: AGHT+IGBSGW5Hjv7lt2usmrL3Nc25eHWKHi9cOd/Y6DYU4MeuofbTxsItcTkkF0X5wuQVsAUtH+9tg==
X-Received: by 2002:a05:6a21:460c:b0:1c0:e69f:f237 with SMTP id adf61e73a8af0-1c4a12b1ac6mr11737561637.21.1722390199407;
        Tue, 30 Jul 2024 18:43:19 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8a48aasm9003534b3a.196.2024.07.30.18.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 18:43:19 -0700 (PDT)
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
Subject: [PATCH v2 1/2] dt-bindings: phy: nuvoton,ma35-usb2-phy: add new bindings
Date: Wed, 31 Jul 2024 01:43:12 +0000
Message-Id: <20240731014313.113417-2-hpchen0nvt@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240731014313.113417-1-hpchen0nvt@gmail.com>
References: <20240731014313.113417-1-hpchen0nvt@gmail.com>
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
 .../bindings/phy/nuvoton,ma35d1-usb2-phy.yaml | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/nuvoton,ma35d1-usb2-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/nuvoton,ma35d1-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/nuvoton,ma35d1-usb2-phy.yaml
new file mode 100644
index 000000000000..88e297ba4ecf
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/nuvoton,ma35d1-usb2-phy.yaml
@@ -0,0 +1,47 @@
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
+      phandle of the system-management node.
+      This driver has some status bits located in the sys,
+      it is necessary to reference the sys link.
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



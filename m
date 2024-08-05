Return-Path: <linux-kernel+bounces-274125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D08659473B2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 05:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DB7B1C20E82
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 03:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F791411E6;
	Mon,  5 Aug 2024 03:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKIeAnkd"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5D513D52A;
	Mon,  5 Aug 2024 03:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722827045; cv=none; b=g9SZD3vjFCvEPfXdXZDJs9/nEb8+wsYN4HLqymVjKyYWmd54R8PSmCmPCLr+qP/cgLldfkwmUbBqGPLEyfVklRI5ogwOoR98YXZTxxFhZOgFLMuRszmojPtR2hiwSeL+uId9pVhR5cPbxW26fc7iQPU39YfjCkqT4VjB1J+qsQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722827045; c=relaxed/simple;
	bh=+gjCNlCvtF38nxtzkVbo0vUS6ECeZCMrM9MjhVcTHTI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V1I5DneyyDIUXmBY2clOumlfDtQ8lNZ0U7lHGEiH/07TE+I3uP/h0wVAaSm6T1I11jzDmuaV5n3pC4bJ3+AT970o3HumDo0WMhGnVRISdnolZlr1sOL+yYa7C4lk7Ses/T5jWZYj5sy6WcAvPjp8l0y17aJE86K4LSAO6CUyT+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKIeAnkd; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5d5eec95a74so4781310eaf.1;
        Sun, 04 Aug 2024 20:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722827043; x=1723431843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OeLEqRbJ5ogQTiwcu7e5krCu6dlyH8p4Ktqs+pgoy6k=;
        b=NKIeAnkdtEcGw/90Iw+ote0pFcDiRcZgnNymPTLlGjTMvPgmWMDa7If8qk9GBvYUuL
         na8kISSe2lmG39PJTgFvxuoEgXQMW4CQ0R7sKtu8Qr6N0BAbtFkQDQ5DAHlSXQ0cZkBQ
         1KCOW/P369iaDBB9+O5Y6q35ib5Bmehk2NRDqGyBY3NzXzgvficpuAMZ1RwRLbt3w6WG
         yAeg/qiEgduR7R88Zf7mGwEzDjpS+2TYM8QONbVgVVGveNI+bxxvkkz/8HB7yFAC/UeC
         zqCE5iyGJbCM6yspXuVO7rNtE4x05wqNSA6aAk0/J775S1ngesyZVLgME0MaivfJTnP3
         ADvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722827043; x=1723431843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OeLEqRbJ5ogQTiwcu7e5krCu6dlyH8p4Ktqs+pgoy6k=;
        b=B/ywgREvTsJ3jc2I0iKo3fsODjNvvPhwRzMWmy3AqLQlCyvi5X7eODWps7cZZpUl45
         1osPhiiRJSxOr30fwh4Ls7CdMys1CpjNP+lrLcQRN2GmiDwnSkiHKLgqz83KrWUlR2T9
         J46lQRLyX+iRAaSCkUcx1EUbku7VZKKQtEkz8Kvh4sgOmA84ofXoJ3ol6m/1uZSAey/k
         uPq4b8o8xc7YKP6SkBYJ29ssiyOQxAdE1d/Ndv6/0YHBV25ni99A80eynteeV/Gu+w8q
         fvtAXsguYIJdKRjJ9iRkebqYYP5kPhFs2x+2d8Nz9NFrLwD3EewNa+4x5bbS+Vuct3pv
         YGew==
X-Forwarded-Encrypted: i=1; AJvYcCXXNBta/6BSe/v2PqiJXG7PkJj7uepgUtLu8ISotDlQoQjffZ1fqnKDzKLTF60LAKjpbHIOuvIAu+rZC5ZBV1/Klp0Z4Eb5pfcz0XM2Vrkt1ZgHGOqkxRSaINjp3RCKCmwWR+Ci7uXAeg==
X-Gm-Message-State: AOJu0YyH3vPWrk3r7ihmm4Zz7Wk63xGwFx9TXV4iCpAlEEoOd2s2rwhK
	Gg6echPhz9yKg157e+SJzMIr8oUcrdy6mz2aeOr27uZVIUE7m2NM
X-Google-Smtp-Source: AGHT+IEoLhMpn3V+sb+8eAmZ8YOqmSu50oKdiZnOvuQLOFWlOncRH7/2EYKSO3vHKrgCJ5TKFQXKDg==
X-Received: by 2002:a05:6870:7187:b0:260:e611:c09 with SMTP id 586e51a60fabf-26891f27131mr12971163fac.47.1722827043648;
        Sun, 04 Aug 2024 20:04:03 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b762e9c2dasm3823210a12.8.2024.08.04.20.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 20:04:03 -0700 (PDT)
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
	Hui-Ping Chen <hpchen0nvt@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/2] dt-bindings: phy: nuvoton,ma35-usb2-phy: add new bindings
Date: Mon,  5 Aug 2024 03:03:55 +0000
Message-Id: <20240805030356.14565-2-hpchen0nvt@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240805030356.14565-1-hpchen0nvt@gmail.com>
References: <20240805030356.14565-1-hpchen0nvt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dt-bindings for USB2 PHY found on the Nuvoton MA35 SoC.

Signed-off-by: Hui-Ping Chen <hpchen0nvt@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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



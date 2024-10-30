Return-Path: <linux-kernel+bounces-389317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1769B6B4F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4109B28303E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED81A1BD9D9;
	Wed, 30 Oct 2024 17:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtdRKT0o"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2D51BD9DD;
	Wed, 30 Oct 2024 17:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730310569; cv=none; b=rsDzn7hHm7eiyXuA18sGTYKtcPA9sGUMAbr+bYDjOG3v3riKNugNZed+SrQByPKEj7KJYue3/t5J06LUFEYqT/4pNqvt8BmfP+/fm9DaeDQ36ivPOYTDJ6lzFlpDxMMwP9sKAF7owzFE/JvTFx0FyK7pnwkS3JEpuVP0mXSz87k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730310569; c=relaxed/simple;
	bh=GAZfApuun/WBM9hWKbBWrJplY1pQnpd5AbvrAfACmCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AxpJVc2ukrenoa0v7ISrCEmpT2S8A32ybxT74ewOvMOBXgmUoe7TbwtdKvI6ldo4SEb/G4z3KB+DSbVqy1CNnh4IitzFAZ/bi7tfTIF/qxvCGxq/O7A3q9awCYmhQHXWGU05Uvt0XVw/WjM7SRvjwn5XYdCViZBv0wPDTvtuvTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtdRKT0o; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a99f1fd20c4so9476266b.0;
        Wed, 30 Oct 2024 10:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730310565; x=1730915365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cs3z5H8OfPpGCjxObwmP+XcGRDtkoeJFhbDKmfanh24=;
        b=UtdRKT0onUUSijzHSMKz2Sl1OtWKSGIJZhLKYVo3/b8q+G6XHOumQ9xGAoWiW5vloD
         CVcbDzvHiiMgr0qvtmH07HO01agA2rhmtYkNXK6La8PNxBJLD+Ki3OKleC5ziIDJStug
         cGV4FPdesYvC/KgpzXzQDKaVTgCXY2A8kK2vVrkpXEFJ039FbSRyOjNqX8Zn38V7Cy5e
         Jr2xkUIGZ+dj0ghrJCuXODaLmNFIEBABbsL2Pfd11GJpUYUF8c5kg5JEA48BwlQmxmFu
         Jj4YWPF6Ata7JgnM70RfHpmf8bCuAd9Zdn1HUrYzzZPq+XfLg1Hwtl0O3syNU9MQR9pK
         tG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730310565; x=1730915365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cs3z5H8OfPpGCjxObwmP+XcGRDtkoeJFhbDKmfanh24=;
        b=L0Vrs7rPbUAYQkA3xdzf4LelX7qIN0X/EhxmLHDCRT3tVNOmd7QgIzPpD+4XrorfFt
         M1txx5cTpTccQEn2VSBDD6wDIirUADUhKjucPfhj+xI2GPYbr/jKfTI6WaiEHSD+dIAa
         GCMuJkNWVOkDJV+H4mxnpixFJjzboqCPzgP8WPtQjrGY/tkr4hDMCz9CwzmuSEsTRy9a
         bn5lOuA4tfVCbuxOUC1zHN8RGlEe3Cf2uHNrIYDb8bCaU6gd/3FobVdv0Vl7YNJKkRfH
         kYDXK7GWDS9CMp8/HjcpStOsw+GV09vQrkRkKIg1v/RFMDfRPpO/f+hvQsRcETL28sw7
         pUAA==
X-Forwarded-Encrypted: i=1; AJvYcCUJJbkICM/WymSZcPYjeIidZ+5hFOZjArBNNn6+iJFwmpSh18AYGOz/8zkP1Jukt67kQceghHwxiFDLQgG6@vger.kernel.org, AJvYcCVzKZXvoQn2YGbyRxvMFB4n8YoLDhv7ATcMWauZax/Lk7p1lT63s9rPeaVw+pH/GCgUVy/E+u3/piI4@vger.kernel.org
X-Gm-Message-State: AOJu0YzNDVn3ul5VUK7j9L+FfAKqSHtMkZlNC40RtePF2hOCKW8uxoYE
	idesE+I7f4PYWa8MwaGjUFAur68nnkOsl70DvoDkTDJGouVNNGcZ
X-Google-Smtp-Source: AGHT+IHD5f1I0hVjw4pIe4XnGiwCH5azKiu1sv5qB8tVdjTSV8ZEo9Du6ea9XN4bKxBsUPhREn/cNg==
X-Received: by 2002:a17:906:f58a:b0:a99:6036:90a with SMTP id a640c23a62f3a-a9e508cf502mr31698866b.14.1730310565004;
        Wed, 30 Oct 2024 10:49:25 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f29950asm582718866b.122.2024.10.30.10.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 10:49:24 -0700 (PDT)
Date: Wed, 30 Oct 2024 18:49:22 +0100
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: sound: sprd,sc9860-mcdt: convert to YAML
Message-ID: <140ee384c1c351ffa3abefa8dd3246d1625dda8d.1730310275.git.stano.jakubek@gmail.com>
References: <9fc646b70a73e7a6c513771d69b0edcd140f09d7.1730310275.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fc646b70a73e7a6c513771d69b0edcd140f09d7.1730310275.git.stano.jakubek@gmail.com>

Convert the Spreadtrum Multi-Channel Data Transfer controller bindings
to DT schema. Adjust filename to match compatible.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 .../bindings/sound/sprd,sc9860-mcdt.yaml      | 47 +++++++++++++++++++
 .../devicetree/bindings/sound/sprd-mcdt.txt   | 19 --------
 2 files changed, 47 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/sprd,sc9860-mcdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/sprd-mcdt.txt

diff --git a/Documentation/devicetree/bindings/sound/sprd,sc9860-mcdt.yaml b/Documentation/devicetree/bindings/sound/sprd,sc9860-mcdt.yaml
new file mode 100644
index 000000000000..3b66bedeff97
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/sprd,sc9860-mcdt.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/sprd,sc9860-mcdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Spreadtrum Multi-Channel Data Transfer controller
+
+description:
+  The Multi-channel data transfer controller is used for sound stream
+  transmission between the audio subsystem and other AP/CP subsystem. It
+  supports 10 DAC channels and 10 ADC channels, and each channel can be
+  configured with DMA mode or interrupt mode.
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+properties:
+  compatible:
+    const: sprd,sc9860-mcdt
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    mcdt@41490000 {
+      compatible = "sprd,sc9860-mcdt";
+      reg = <0x41490000 0x170>;
+      interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/sound/sprd-mcdt.txt b/Documentation/devicetree/bindings/sound/sprd-mcdt.txt
deleted file mode 100644
index 274ba0acbfd6..000000000000
--- a/Documentation/devicetree/bindings/sound/sprd-mcdt.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-Spreadtrum Multi-Channel Data Transfer Binding
-
-The Multi-channel data transfer controller is used for sound stream
-transmission between audio subsystem and other AP/CP subsystem. It
-supports 10 DAC channel and 10 ADC channel, and each channel can be
-configured with DMA mode or interrupt mode.
-
-Required properties:
-- compatible: Should be "sprd,sc9860-mcdt".
-- reg: Should contain registers address and length.
-- interrupts: Should contain one interrupt shared by all channel.
-
-Example:
-
-mcdt@41490000 {
-	compatible = "sprd,sc9860-mcdt";
-	reg = <0 0x41490000 0 0x170>;
-	interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
-};
-- 
2.43.0



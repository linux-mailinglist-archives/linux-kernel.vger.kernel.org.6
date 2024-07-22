Return-Path: <linux-kernel+bounces-258526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C662993892A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 08:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 778AB281283
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 06:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F01617C6C;
	Mon, 22 Jul 2024 06:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vwoqDLTJ"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD5E18042
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 06:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721631223; cv=none; b=XTZGZnl9fI3GageXB37hQcVUxLzsZR8WWqGPcATQxsCkqcuXXflSZSui//GfUz1oc1T5ibJ2QIZkHvgR+xb6EPm6oRj/NDKOHFpSYDKXVEFZx0TsL5DB1TZQ8N6xgg6mqQy68NjHE6NP0JHR7XTytDnVy4Zg42S+xDur3TYwP4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721631223; c=relaxed/simple;
	bh=WVoFkdQ/0FpyCHJrAYCh9k+mXMPqgGmWwmumiaugOMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PxXD4dyBvoHeGOIaMlbuAGfM+wc/TyhpWO1NYwe2s44PlbsCGGrx+pLIRAc2lW2hVMjH7uva3QN9jpnEuPBlxBsYE9eVoI9rtTE0umh3dwwdNKSG5BAZ55Ln/UpT6EHlhYOriSgsnIxvYWCF4VAqM8cWB3HY8BXb9x+VDA4mzbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vwoqDLTJ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5854ac817afso2239530a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 23:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721631219; x=1722236019; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oFgfVYXqfttnG8T9cixZ5XkV74OKDwZYpy7meDYMP0M=;
        b=vwoqDLTJ4KWZBt3vLCHTU9vWHOUE67ASxGZF6gwACJQaVNcqx5KCWQrFpk9MO2zJrZ
         pg9rZiJqp0M3yigz9eUVs/AyOnwV0jvBM/qAGVcmeJb2lV7T/piWQ6XEy4oPj8bejYkY
         dlyRkIi1Qz3z6GJoq6UVSN1gVfd78R0J8yQf7fynL162fTccN8KqWFDY1uXkUxte7xO8
         5j4HpgEDsOLaNXSyocipq5fiLTyqlT3jbpI27XgZq9kvlW49T6LxfcrRXwGAHvr50/Dm
         Oq2ZNrnLLmiEkByDOba0Nw67X9OkUE+X31Z01MBqZSTeqE3qMq647Vie5/3qENc6HFCm
         OTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721631219; x=1722236019;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oFgfVYXqfttnG8T9cixZ5XkV74OKDwZYpy7meDYMP0M=;
        b=Dx4zqXXFVoZXHexvrB4RTJG+A5GUUt50iT6RyKafUoE/uypTq5D1k2miErfyA8bzN/
         I8qpd/67+i/GC5lm+zo52/0epKFJ3X5+Hgzsd/7xpcYfuZKhksZHqHouKcBZ1E8B4FzT
         Pntl+N/6endRlW5lqFBOs5QhadlUxlmMsgWQO3lbyBwtUbVawdqGwkywlKXJvcKnl7Hr
         4JlzqiSlEToAfu8C+UBNo6n1f2Q4dnfVysmDCMGVe2TQx67uMcdtChOLonwtZdoopL3b
         cI+oT60b3m1GCN1UgY9z6f3ntMVynQV8I+uPD3t1FPlcq0MSH3TOGZ5FuwfrUPG80znX
         WFFw==
X-Forwarded-Encrypted: i=1; AJvYcCWVzj7zyRU362yJFygXiSmiCQR9HukVsBXRRhn1j66B7rIlxTzp9lW9DKU8FDIBYA+HriIBzjZx/ZjPi6/8ijCLepl1nuguIopE//wf
X-Gm-Message-State: AOJu0YzgVmKX+L+jKF4UiUoWvscE5RuLlvdEu8jjm0hmUSc7RANCVtNr
	CWTujVCZUoPat2fCF7G36ItG7r1P0j8aqSWBWMGy5XSVTxF+ElDvC9blFJxuDGQ=
X-Google-Smtp-Source: AGHT+IEHhb46ND7/HhCRLyD1pbb5Rh9Z6wHgmKMjc9iBHjznZYxhxWAQKWtm5tYoeiTXtFRODEMTHQ==
X-Received: by 2002:a50:8d5d:0:b0:57c:aab2:7311 with SMTP id 4fb4d7f45d1cf-5a47afeeba0mr3651422a12.29.1721631219073;
        Sun, 21 Jul 2024 23:53:39 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5a69c1f56a0sm1982126a12.64.2024.07.21.23.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 23:53:38 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Mon, 22 Jul 2024 08:53:30 +0200
Subject: [PATCH v7 01/16] ASoC: dt-bindings: mediatek,mt8365-afe: Add audio
 afe document
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-audio-i350-v7-1-6518d953a141@baylibre.com>
References: <20240226-audio-i350-v7-0-6518d953a141@baylibre.com>
In-Reply-To: <20240226-audio-i350-v7-0-6518d953a141@baylibre.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lee Jones <lee@kernel.org>, Flora Fu <flora.fu@mediatek.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 Alexandre Mergnat <amergnat@baylibre.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4718; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=WVoFkdQ/0FpyCHJrAYCh9k+mXMPqgGmWwmumiaugOMk=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmngHwLFngyxrL87eubthRMEqrtmcE1ra3B84beWYU
 Eri93AGJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZp4B8AAKCRArRkmdfjHURS/CD/
 oDx9+6WwfdVuAjAhMk9XEl5/6hq57sC3wCa8K21WCsz3j0Bn5g1p20Imc2X8RFLTqj7h1ejQFuKKOD
 5WINTAUzzVO6+n16PxA1zplZ3NczbUGNydCHr+tcfFFqueKMcB+sZUSlOyOSS5yI4ZWFZVUmu9hnT4
 ilG3dMrRal8FnM5i9BiT7450UmAiKczmqFP6HenNMdO4LzmpU9cNVbO1uOIzwHUvdMMo9qg2jH8Xcd
 z/ELx2LTV9/oNJBRlUnLGEe56LXgdKSspAKCIN1esDRLF3tppTjyiKh+92xr95hf9Z2R/PfzK7jAUb
 m+6lW1QSE0Kbh8GXQCwUN29Qmt1QB/mx/5R5mscTnPlnILOXkVbNjTWKjYdfMP5nZI69Kc5WYy6igB
 Q/CunFmsGxll1xLdJrzHHHc4MmPVCgzgJb1oJfcG9M4fBjUeKbYUbt6I3cWAzx9KKKMx3BhilGhfhK
 6nAnYvz7+nJsV86dZorH0GwkHhWCoivHVji3mjQ4rTwsp9C2HshZaSZ/QdH+eXL4wuROoTIGbjGReP
 gVIT9JiHerwKGyJdixa30ZotEJKq6UjUJnyhP7yvHTz60qGXGX2xBCraJo2yvAoZ0sTtYfgbBMp4uG
 AfZjWRpbXY/FlAR8k/h4+yPpSmRwkK49LBFcCvTQVE+dfp2RlDZXkZCGD4oA==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Add MT8365 audio front-end bindings

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 .../bindings/sound/mediatek,mt8365-afe.yaml        | 130 +++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt8365-afe.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt8365-afe.yaml
new file mode 100644
index 000000000000..45ad56d37234
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mediatek,mt8365-afe.yaml
@@ -0,0 +1,130 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/mediatek,mt8365-afe.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Audio Front End PCM controller for MT8365
+
+maintainers:
+  - Alexandre Mergnat <amergnat@baylibre.com>
+
+properties:
+  compatible:
+    const: mediatek,mt8365-afe-pcm
+
+  reg:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 0
+
+  clocks:
+    items:
+      - description: 26M clock
+      - description: mux for audio clock
+      - description: audio i2s0 mck
+      - description: audio i2s1 mck
+      - description: audio i2s2 mck
+      - description: audio i2s3 mck
+      - description: engen 1 clock
+      - description: engen 2 clock
+      - description: audio 1 clock
+      - description: audio 2 clock
+      - description: mux for i2s0
+      - description: mux for i2s1
+      - description: mux for i2s2
+      - description: mux for i2s3
+
+  clock-names:
+    items:
+      - const: top_clk26m_clk
+      - const: top_audio_sel
+      - const: audio_i2s0_m
+      - const: audio_i2s1_m
+      - const: audio_i2s2_m
+      - const: audio_i2s3_m
+      - const: engen1
+      - const: engen2
+      - const: aud1
+      - const: aud2
+      - const: i2s0_m_sel
+      - const: i2s1_m_sel
+      - const: i2s2_m_sel
+      - const: i2s3_m_sel
+
+  interrupts:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  mediatek,dmic-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Indicates how many data pins are used to transmit two channels of PDM
+      signal. 1 means two wires, 0 means one wire. Default value is 0.
+    enum:
+      - 0 # one wire
+      - 1 # two wires
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mediatek,mt8365-clk.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/power/mediatek,mt8365-power.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        audio-controller@11220000 {
+            compatible = "mediatek,mt8365-afe-pcm";
+            reg = <0 0x11220000 0 0x1000>;
+            #sound-dai-cells = <0>;
+            clocks = <&clk26m>,
+                     <&topckgen CLK_TOP_AUDIO_SEL>,
+                     <&topckgen CLK_TOP_AUD_I2S0_M>,
+                     <&topckgen CLK_TOP_AUD_I2S1_M>,
+                     <&topckgen CLK_TOP_AUD_I2S2_M>,
+                     <&topckgen CLK_TOP_AUD_I2S3_M>,
+                     <&topckgen CLK_TOP_AUD_ENGEN1_SEL>,
+                     <&topckgen CLK_TOP_AUD_ENGEN2_SEL>,
+                     <&topckgen CLK_TOP_AUD_1_SEL>,
+                     <&topckgen CLK_TOP_AUD_2_SEL>,
+                     <&topckgen CLK_TOP_APLL_I2S0_SEL>,
+                     <&topckgen CLK_TOP_APLL_I2S1_SEL>,
+                     <&topckgen CLK_TOP_APLL_I2S2_SEL>,
+                     <&topckgen CLK_TOP_APLL_I2S3_SEL>;
+            clock-names = "top_clk26m_clk",
+                          "top_audio_sel",
+                          "audio_i2s0_m",
+                          "audio_i2s1_m",
+                          "audio_i2s2_m",
+                          "audio_i2s3_m",
+                          "engen1",
+                          "engen2",
+                          "aud1",
+                          "aud2",
+                          "i2s0_m_sel",
+                          "i2s1_m_sel",
+                          "i2s2_m_sel",
+                          "i2s3_m_sel";
+            interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_LOW>;
+            power-domains = <&spm MT8365_POWER_DOMAIN_AUDIO>;
+            mediatek,dmic-mode = <1>;
+        };
+    };
+
+...

-- 
2.25.1



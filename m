Return-Path: <linux-kernel+bounces-223246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF83C911029
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75288288448
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6501BA87A;
	Thu, 20 Jun 2024 17:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="KoztGGCH"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD971CEA1B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 17:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906325; cv=none; b=EZdiep3D63MEUjMhXwfr2UtKp742vgZuX0aem8V6jGGC7TvLPfpNOy5Q92cZ636PlknJse2UUlz7hYahne+ZopDMIkkZgjw+Un3Fr7kzFO+3Pta2lzwg4NapMlKwizXXdBQgxvTyxXjhvadRhpO1X2D0b0lp8yaS35k6D0U78OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906325; c=relaxed/simple;
	bh=4DQrIUMsTm81JssGC9KBdVsofE3jqG6GAjcZIQrb7tc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WBYuv5sl3SjSPksa27B0kPqG4Vq8aDTzM1mvFAbBfF4SI1QYudS7cK53dlFpTprwjF+sWGHtyovJkzFXhj1JqUa1/fObXzg5kJxxMAS5jB+AU/zk56mRsGz1vjEfZ0F6J4vzVG/czfhzWv0oi1kIMiaPYZj/jMMQplY9AovIr80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com; spf=pass smtp.mailfrom=timesys.com; dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b=KoztGGCH; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timesys.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6ef64b092cso136120866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 10:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1718906322; x=1719511122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POfTgIlDMKnuctYd9TdkfbMoA75Hg7wnTz1QoAWu+kM=;
        b=KoztGGCHFSS8tzWS8xmLpfOXPobgYuXHsk14gimU/XxPPsWFerDe+/fHc/ryuL5+Lf
         CMHIstaNBcpyRoU3FSZtyzIpN7e9gIUlV3kiHy1uygZoKkJb/RGaitvfroIdVkWZHWyb
         mTZzTYFFRbGAVWvjJzukVaJdGrH93/Mf1UVfEsriON1wIW2QxYFbPMHJ8ZaB32Fil8Yg
         8w1zRudXZuVgKvvuKiXg1S9WjbJt3MfsjzIn2jT45gj42n26vJYBQa4ThFT/hzwWfLi0
         toOUSnbYs/mnfLLZOg7+KHKSDao3Lx1BGOdBQRu0Kb4pbtNoan0qt/jBVnPVeFGsRJdW
         sAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906322; x=1719511122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POfTgIlDMKnuctYd9TdkfbMoA75Hg7wnTz1QoAWu+kM=;
        b=qVFZtU6U+kukU4OoPcVUqUsOJzCSsHwMqLbbztPVP7OfAzeit/QpfO2nGkbDp9M/zs
         KqbseJJaI+R4IXhAxUqBmK89JL2toE9E2+jQOZUkyhZSqRn5aUXC3wkYtByagmEKNkGO
         5ygCHfrtpW22BBQRcrMES9D5V3dRiJsBZuRn3n56GmXmrjSoh7tpqqBdofQ88jUJutWy
         gped0SEFKmtOn0xZSDAbyuKUoy9ePjkhAydk4YqV01izSrIoj4ihU8EfYSjBVambjRL0
         lLkv56ULnL3/U26W69NQG0X86GyUqitkQb6Do7nNibhr3jcMpDLnyRT6VUyvIcWhT2rj
         BYdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWy179HQIPPFL7j7VV00Y5x9xEsBmHau5Cvsa3UbENRBQNVRFXP1El1GlRXxowZ4scse7OXXUWfgf0OwT/kCIlKXkjeeLBHU2VUkpbB
X-Gm-Message-State: AOJu0YwF9NimLZEsO6zp0pxQLJWom5UWal9wLHbYt6qsRxoWQwC/JxxA
	KcBCvPTaHVSEJCOwDtT3Ffk65Ou0rirCp2svglE0IDv9BM2m80Rsuk2z+aTqbHA=
X-Google-Smtp-Source: AGHT+IHTrvjRefjDyJtTKiBTdA/7eaPFIlKAqed0dBKu9bDkvkontU8BQ0nzLod+LvZtaEx3jpBdyA==
X-Received: by 2002:a17:907:8b8b:b0:a6f:ad2f:ac5d with SMTP id a640c23a62f3a-a6fad2fad21mr380433766b.6.1718906321968;
        Thu, 20 Jun 2024 10:58:41 -0700 (PDT)
Received: from localhost.localdomain ([91.216.213.152])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f42e80sm781370766b.186.2024.06.20.10.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:58:41 -0700 (PDT)
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"J.M.B. Downing" <jonathan.downing@nautel.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Yangtao Li <frank.li@vivo.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Li Zetao <lizetao1@huawei.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Chancel Liu <chancel.liu@nxp.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-mtd@lists.infradead.org
Cc: Markus Elfring <Markus.Elfring@web.de>
Subject: [Patch v4 03/10] ASoC: dt-bindings: lpc32xx: Add lpc32xx i2s DT binding
Date: Thu, 20 Jun 2024 19:56:34 +0200
Message-Id: <20240620175657.358273-4-piotr.wojtaszczyk@timesys.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240620175657.358273-1-piotr.wojtaszczyk@timesys.com>
References: <20240620175657.358273-1-piotr.wojtaszczyk@timesys.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add nxp,lpc3220-i2s DT binding documentation.

Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
---
Changes for v4:
- Custom dma-vc-names property with standard dmas and dma-names
- Added to MAINTAINERS

Changes for v3:
- Added '$ref: dai-common.yaml#' and '#sound-dai-cells'
- Dropped all clock-names, references
- Dropped status property from the example
- Added interrupts property
- 'make dt_binding_check' pass

Changes for v2:
- Added maintainers field
- Dropped clock-names
- Dropped unused unneded interrupts field

 .../bindings/sound/nxp,lpc3220-i2s.yaml       | 73 +++++++++++++++++++
 MAINTAINERS                                   | 10 +++
 2 files changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/nxp,lpc3220-i2s.yaml

diff --git a/Documentation/devicetree/bindings/sound/nxp,lpc3220-i2s.yaml b/Documentation/devicetree/bindings/sound/nxp,lpc3220-i2s.yaml
new file mode 100644
index 000000000000..40a0877a8aba
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nxp,lpc3220-i2s.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/nxp,lpc3220-i2s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP LPC32XX I2S Controller
+
+description:
+  The I2S controller in LPC32XX SoCs, ASoC DAI.
+
+maintainers:
+  - J.M.B. Downing <jonathan.downing@nautel.com>
+  - Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - nxp,lpc3220-i2s
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: input clock of the peripheral.
+
+  dmas:
+    items:
+      - description: RX DMA Channel
+      - description: TX DMA Channel
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
+
+  "#sound-dai-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - dmas
+  - dma-names
+  - '#sound-dai-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/lpc32xx-clock.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2s@20094000 {
+      compatible = "nxp,lpc3220-i2s";
+      reg = <0x20094000 0x1000>;
+      interrupts = <22 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&clk LPC32XX_CLK_I2S0>;
+      dmas = <&dma 0 1>, <&dma 13 1>;
+      dma-names = "rx", "tx";
+      #sound-dai-cells = <0>;
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index f7adf9f66dfa..fadf1baafd89 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8918,6 +8918,16 @@ S:	Maintained
 F:	sound/soc/fsl/fsl*
 F:	sound/soc/fsl/imx*
 
+FREESCALE SOC LPC32XX SOUND DRIVERS
+M:	J.M.B. Downing <jonathan.downing@nautel.com>
+M:	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
+R:	Vladimir Zapolskiy <vz@mleia.com>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	linuxppc-dev@lists.ozlabs.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/sound/nxp,lpc3220-i2s.yaml
+N:	lpc32xx
+
 FREESCALE SOC SOUND QMC DRIVER
 M:	Herve Codina <herve.codina@bootlin.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
-- 
2.25.1



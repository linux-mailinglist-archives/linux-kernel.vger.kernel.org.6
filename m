Return-Path: <linux-kernel+bounces-209595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2625903827
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 200CB2887C3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAD217836F;
	Tue, 11 Jun 2024 09:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="mbiD2GPs"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECF61779BD
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 09:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718099329; cv=none; b=ENesRLXCLUWRoLSh7Ciqs7ptGslHN81spU1M2mrLcdOU/2Vt3Mn+0k5XS10NVPzc+ODr3kBNIoDnRRhLKjuXcwHCRawC9LGEs07QxGDElOfPFr88VwZL/6dv0GePX800NFuWqYq9CvhluhYi69rQZChPm+w/K6GURGu1aUmYqmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718099329; c=relaxed/simple;
	bh=rY1E63AFRlnvfo6oM5WyAgqbtSr3Iiigk/dvnbD7cdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NX7MObi6t/Ee/JfqLcOr/Nv0MN08zHpZY3kzT0prWHr7XWctvAsRvQPxQENRyssbD6bk7pY65PexgnNYFMiO2i4yibhJL1Nad75NfyvOy8JwgaYM8xLQul4FwHGlhqdG3iVBUs3VJH0HxLVx77aOZx71pGVepikSOWfwPLndyC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com; spf=pass smtp.mailfrom=timesys.com; dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b=mbiD2GPs; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timesys.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57c68c3f8adso996069a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 02:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1718099325; x=1718704125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3URf1bqoxt6RvPsq+unfHOhtdPyrUcD08+rrLeED5Co=;
        b=mbiD2GPsD6Euborju0ealfurXCJ9AUldpWjr+zUpduWNfqoI5gwBAbs138T2aiLOVB
         KNd6f2Htb6jJkJhztl7EG1dNAmpQJigtjWbdHyTfb/EL2OzDaOfJ1St9Pgg/8Mff1Ji1
         63xZBSOS9QPEI4GCWw7HcJiIGff5qkwyp0p/zaJd/Y99xn3pBRk7x4Id96aysuTB9Z5i
         QRvhI5MHe3ZeeBcYIgeWRJSqdmjj19ZyXEpN61B7Pr8E8iBkmQSKCkLcEYSE/ej0oi40
         BW65Cy6jLpXAazSe3FRXECggmCXtZnA82hmrp53/GP/ZusXo2k59yEovTru+qVhyqQ4g
         Xg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718099325; x=1718704125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3URf1bqoxt6RvPsq+unfHOhtdPyrUcD08+rrLeED5Co=;
        b=dE0JyYgbkT6jPslGJpuUKo94pT6AIQS4Sj8A8kfUjevzLb/u/bNDQJ4hsk1Rn6oMFZ
         BcuhWrCFvTbzQ6UD4eU87ae5/53lV5Xt/DHqsMAEnpngZP1JFrmuo0d2ti81bOwy0/tj
         aGFT3Y6s3ZQ51XdXLv+CupJolc1xOdeklEE2hRmonh7WSE3xsnWbspB7VcRGIqQtsbpM
         yxmNjoodxtGEwe0lFi/yDxWH0TSzaWpJuuTqbFdifs3dDBrVB8LQ+W4Fqgi9yZM2seYY
         KCv2oh4C1UTYCHOddtmyf4rNbuhJM92PSWX8l9fgJ1ysqjmZsaTIPhaDPr4fl6NBhhgV
         RwcA==
X-Forwarded-Encrypted: i=1; AJvYcCX2vn5HNOi71SylYxgAbr9PFTsVKY7wj4+FakOhKgrQh64rABtfRxIl1gADS9gYIhAAu8sHjpuQIbg3GZx3FwkSMM7SZe8EuVEuTkf0
X-Gm-Message-State: AOJu0YxKVoGWXmLPakFWW4/bWuiIb1/pH7PkXtdW307aywoUo0JdDGCi
	MCy5CyEd7PYWDjWHbBROaaRf0vYBmugLAw4vHvs855p1AuZUV10cEXTq1BgRmb0=
X-Google-Smtp-Source: AGHT+IF14ZNnXOfobI/WB8lXVND+Ohqa5JoXFDW/TfmN1pVZr0QdPr6CGSC0zuZrHL1qY/x7lEYXOA==
X-Received: by 2002:a50:d712:0:b0:579:e6ff:c61f with SMTP id 4fb4d7f45d1cf-57c508fd7f6mr11085689a12.25.1718099325105;
        Tue, 11 Jun 2024 02:48:45 -0700 (PDT)
Received: from localhost.localdomain ([91.216.213.152])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae2340f6sm9059647a12.90.2024.06.11.02.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 02:48:44 -0700 (PDT)
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
To: 
Cc: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Russell King <linux@armlinux.org.uk>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Chancel Liu <chancel.liu@nxp.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [Patch v2 2/2] ASoC: dt-bindings: lpc32xx: Add lpc32xx i2s DT binding
Date: Tue, 11 Jun 2024 11:47:52 +0200
Message-Id: <20240611094810.27475-2-piotr.wojtaszczyk@timesys.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240611094810.27475-1-piotr.wojtaszczyk@timesys.com>
References: <[PATCH] ASoC: fsl: Add i2s and pcm drivers for LPC32xx CPUs>
 <20240611094810.27475-1-piotr.wojtaszczyk@timesys.com>
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
Changes for v2:
- Added maintainers field
- Dropped clock-names
- Dropped unused unneded interrupts field

 .../bindings/sound/nxp,lpc3220-i2s.yaml       | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/nxp,lpc3220-i2s.yaml

diff --git a/Documentation/devicetree/bindings/sound/nxp,lpc3220-i2s.yaml b/Documentation/devicetree/bindings/sound/nxp,lpc3220-i2s.yaml
new file mode 100644
index 000000000000..66e48d8a5a1b
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nxp,lpc3220-i2s.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/nxp,lpc3220-i2s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP LPC32XX I2S Controller
+
+description:
+  The I2S controller in LPC32XX SoCs to interface codecs and other audo devices.
+
+maintainers:
+  - Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
+
+properties:
+  compatible:
+    enum:
+      - nxp,lpc3220-i2s
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: input clock of the peripheral.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/lpc32xx-clock.h>
+
+    i2s0: i2s@20094000 {
+      compatible = "nxp,lpc3220-i2s";
+      reg = <0x20094000 0x1000>;
+      clocks = <&clk LPC32XX_CLK_I2S0>;
+      clock-names = "i2s_clk";
+      status = "disabled";
+    };
+
+...
-- 
2.25.1



Return-Path: <linux-kernel+bounces-553136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA2EA5845D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 14:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F8B1188C1F8
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 13:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C331DF248;
	Sun,  9 Mar 2025 13:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4s4s4k/"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9391DDA0E;
	Sun,  9 Mar 2025 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741527047; cv=none; b=JdeT6Nc21dgLYqFVF3T7mU/ARYbNGtze9MFspMTgJFmoKD/vJzGjyw94Fzt5H1+j9K1QO9Wq807Z7xXmKVIvrRiDv6jhtg7rKvh5UxX5cBk8f08VZ+M5A222cCrp4e7aVApZv11mNB7VcLdnfQD8g7o1x8Fimkcv6joqtf9oSEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741527047; c=relaxed/simple;
	bh=gZ/TFJVo109Yat5rmhoB8A3/+/GmwoPyvtGc6nbAgUo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WHUDp+Umm8c1F95dRepETazpsORe80Hv2nrNd0ihJfZm6W9zg0/KlRJgEFHow9lzsPOKfHMK4FOK00KKgpSB3LhEMhf3uct+YoiUUVzLqcOVYoevpBOVUmHVDt92OfUtRYR2I4JDZgg22tDKHZ+uUkCR7T8B6WbYDA4ofHsZ4OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4s4s4k/; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3911748893aso2090275f8f.3;
        Sun, 09 Mar 2025 06:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741527043; x=1742131843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LmZAJnwVdeb36PC0uWDUFCDQtkHDVfLiHfmoIbAgzmQ=;
        b=N4s4s4k/E6x78ZgQ1vgOBr2fCdK0sRVAl4h6EJHPgCg3a/Sb8RildoHk8/nSiwlrxm
         qzv6TcYgWhcPPe53XrSmx9AArHDJhzWPPc6kZGi97SuzLps00+bhhnLiWEd+4ulDFOvA
         BkN4/f9TogARwlyDP8N2elK/iqE8+j6KQ3pCqsJr2pj8mFbfG5wjg6wgMtXtDDbJ74zO
         tOiGOhcrVxTXr0dGeAph6gQvdVJNx1sCvZFypA5TIwU8EcevS62xwWGsi1BIl31yZTWv
         wSQNHjmGj7AskC5PRj5cDvgKwI6WG9XabfwrQOy6wNjo86xeQd2sGoeDpUk7ouCzp2Pr
         bSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741527043; x=1742131843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LmZAJnwVdeb36PC0uWDUFCDQtkHDVfLiHfmoIbAgzmQ=;
        b=nqADztqyebuCpE+7wOuAYKj18wwOI+OvgSJ1rN81zgtQM6ulJN8f7Td0NIg88avcAG
         U+kH1CmRvqYqxveCwA1YFOYXXClHxWLm8RdQzDqP5qMfiez8bUPhcct2goq8gOWjLu/7
         N/xOJ73ILIPpkfYZEJ75CMa8026vqTwL/DRyhvhwTAdUTK57OZBO7cRb/l1SE2ufRP7Q
         SnETUDoGxwi1aSyd8VIVAq8S4PLaPIyKAMUoHNqSP3Ju5qPiRmIXcqPugFvVceuRixoW
         qsvshhnMFx9eoc009+W2YwXdS9yXXqLLxF2d6Uh63S9GXjjFlPhpCAmcxNkz3nOPEDFR
         zx0g==
X-Forwarded-Encrypted: i=1; AJvYcCU4I42WqB06xkqorhjR+JreOEid4NlGr264fbkHG6Rnoy68gNOFMI3k3lPOk/LGnsT3rJltqoH3XZO1FnbU@vger.kernel.org, AJvYcCV7UxWtImgNqJS3PJldGPU1Tk6Hl3gyCruA7B2TNQhgXIu2q09GXcvJ2qbr6cWdB0VxzU/Z4EU78smj@vger.kernel.org, AJvYcCVC0OIAiXUm0THy5JCXs82A7EPwV2EGBZuYAZRB9BYjNzeZWhbpvxMdehZEeoy1q/FueB66H3AbGwZb@vger.kernel.org, AJvYcCWWATcSZ2FZ3s4mwTAP4G69ab3sXah4oUXwSYmT7HmZ4+CM7QjhLhbwl3CJc0aSFVEZqiO7SEQPHVXy@vger.kernel.org
X-Gm-Message-State: AOJu0YxoMIae3tEf17dwSYbYVtU4Q5BrRLZ5YqsNiO4s1n5/fGifx6pe
	EMSTn/yegEilLR4S3+6Wn4kYnQfPP0lIQt1yahW96u849qWsl8Vr
X-Gm-Gg: ASbGncudkidwJlUzn2LoxaeNQUh7iBg+C2DRxGlP64HgKUTdUBiwxwRhBfuzQA8kLUU
	0vlcb+GusCH4kV9eAtvFVwxcOep3OiAY3blU1aN/dyRanZxODOcTZPBQkVx/TDyRgAbo1BEexqb
	KUeoDid2X2miu08yuYpnEmOkTtlPI3jwAP+p+X3YqbIh3JmlH5/+rKWooi7xKnKOTK0qD37nfQu
	HgqIXla+afm/wMThLGsSI6/I2/0t2/ypWd67d+Nl4q8cTRXYFdm5ty/9Kmf+DjG+14lF+Mnnwi3
	xofSoAah6msFz+sSYtIe9fKecyOpZh5abJDb+WKcOzlWDb0AqjxrWHcbroeytDQW7PmhFrGTAs+
	QGxRQZa+Km9GxhA==
X-Google-Smtp-Source: AGHT+IHYvjueTBKth2+iZLDZ1shgffPIvVWESl7zWZ3vriip/pFaWdphySinGg260hn/heKTJUJu2A==
X-Received: by 2002:a5d:64ce:0:b0:391:3bba:7f18 with SMTP id ffacd0b85a97d-3913bba8128mr2142759f8f.12.1741527042854;
        Sun, 09 Mar 2025 06:30:42 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3912bee262esm11867536f8f.0.2025.03.09.06.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 06:30:42 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Danzberger <dd@embedd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Guo Ren <guoren@kernel.org>,
	Yangyu Chen <cyy@cyyself.name>,
	Ben Hutchings <ben@decadent.org.uk>,
	Felix Fietkau <nbd@nbd.name>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-usb@vger.kernel.org,
	upstream@airoha.com
Subject: [PATCH 03/13] dt-bindings: soc: airoha: add SCU SSR Serdes port binding
Date: Sun,  9 Mar 2025 14:29:34 +0100
Message-ID: <20250309132959.19045-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309132959.19045-1-ansuelsmth@gmail.com>
References: <20250309132959.19045-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Airoha AN7581 SCU SSR Serdes port binding to define what mode is
supported by each Serdes port. These special binding are needed to
identify and provide the port mode from any user driver.

These modes are mutually exclusive and driver needs to correctly
validate the current mode for the Serdes port in use.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 MAINTAINERS                              |  6 ++++++
 include/dt-bindings/soc/airoha,scu-ssr.h | 24 ++++++++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 include/dt-bindings/soc/airoha,scu-ssr.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3eee238c2ea2..d3125268d63f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -736,6 +736,12 @@ F:	Documentation/devicetree/bindings/phy/airoha,en7581-pcie-phy.yaml
 F:	drivers/phy/phy-airoha-pcie-regs.h
 F:	drivers/phy/phy-airoha-pcie.c
 
+AIROHA SCU SSR DRIVER
+M:	Christian Marangi <ansuelsmth@gmail.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	include/dt-bindings/soc/airoha,scu-ssr.h
+
 AIROHA SPI SNFI DRIVER
 M:	Lorenzo Bianconi <lorenzo@kernel.org>
 M:	Ray Liu <ray.liu@airoha.com>
diff --git a/include/dt-bindings/soc/airoha,scu-ssr.h b/include/dt-bindings/soc/airoha,scu-ssr.h
new file mode 100644
index 000000000000..b14457c10d77
--- /dev/null
+++ b/include/dt-bindings/soc/airoha,scu-ssr.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef __DT_BINDINGS_AIROHA_SCU_SSR_H
+#define __DT_BINDINGS_AIROHA_SCU_SSR_H
+
+/* WiFi1 port can be PCIe0 2 line, PCIe0 1 line or Ethernet (USXGMII/HSGMII) */
+#define AIROHA_SCU_SSR_WIFI1_PCIE0_2LINE	0
+#define AIROHA_SCU_SSR_WIFI1_PCIE0		1
+#define AIROHA_SCU_SSR_WIFI1_ETHERNET		2
+
+/* WiFi2 port can be PCIe0 2 line, PCIe1 1 line or Ethernet (USXGMII/HSGMII) */
+#define AIROHA_SCU_SSR_WIFI2_PCIE0_2LINE	0
+#define AIROHA_SCU_SSR_WIFI2_PCIE1		1
+#define AIROHA_SCU_SSR_WIFI2_ETHERNET		2
+
+/* USB1 port can be USB 3.0 port or Ethernet (HSGMII) */
+#define AIROHA_SCU_SSR_USB1_USB			0
+#define AIROHA_SCU_SSR_USB1_ETHERNET		1
+
+/* USB2 port can be USB 3.0 port or PCIe2 1 line */
+#define AIROHA_SCU_SSR_USB2_USB			0
+#define AIROHA_SCU_SSR_USB2_PCIE2		1
+
+#endif /* __DT_BINDINGS_AIROHA_SCU_SSR_H */
-- 
2.48.1



Return-Path: <linux-kernel+bounces-569735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0685AA6A6CF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24D3B981C3D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74016226D03;
	Thu, 20 Mar 2025 13:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljt8MSEa"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E461A226177;
	Thu, 20 Mar 2025 13:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742475714; cv=none; b=GCl2iFA+9KutoNBuCiKMDrm2Oo5BN9BmB1ww4uXX9GpQoyFfTeSMWA4u6/7ueM/QwYkHTpt8LGSXnrOZvDceshwQ7iModZ27tQqetdXHSDbeKVL5pFlN/MZ1J0u5+R+SAnzOyhawqcBhtilNfG4/0iTGg6Eq20z5X3Hdgq13+WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742475714; c=relaxed/simple;
	bh=cvxqxT98F3LDty/TItoLYj8kR76vHU0PoKW3McIA5Ac=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RrdwXjN0hxFlK4v8J+JLkOKx7HSAMAbVGRR+PXrQyRSjb3Fv2/3lt/xfo1nsBUVTWXhklpuGAMIFeEdGX7hNiEGrSihC/d1nR9v8XF1TkuG9B/A7bRD0elqYCjbo4VgBmuLzEUtzz+VGZHQTl115+EBRC7LYGeeIqaMQx+QTiX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljt8MSEa; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so352006f8f.0;
        Thu, 20 Mar 2025 06:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742475711; x=1743080511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/2i/cLqH70rFIGQEh0as4tKq9BI5pDp8ooCRLadLuPs=;
        b=ljt8MSEaMyy1OvCf6vWom8+7dN3yEMu+vR9MVeybt0l6FSmubumyp6Gkzoauj1jAra
         ll0Qv3hZ9QtZcfIbW9ITCZ4PmR2ndC83ss4Xtx2Olk6XCUrL5ivbumNWu+7RcNV5yO5V
         3fL3rkrQyw2K5FfXPMB9gWyFwUTO0w670CrtmCmsv24JMD+VU9JABxKHkuyC47fItFHu
         sViykLce6e+NyCi3WkYr98D5CInnY0ZJgr97g49J91JXTFwDwAvNzQH10bOTbkE6EBsB
         NZosML1DY7qGo2mYtc9CA4tiV1lxXjOz2gY/iEy0rPXZjH/KHKCef3GE8J9YmXdRNxhL
         T29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742475711; x=1743080511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/2i/cLqH70rFIGQEh0as4tKq9BI5pDp8ooCRLadLuPs=;
        b=wO4OhQ57FDJiNPwyUu4EyG2izNlIgkCvh8psBh6ralmt2GuVac/uBa8gEiZ43EcMXW
         C7xC8Y6trh2yp044Iw9NnI2dh+IUSesg4ZSjEZN7c/cpHebFpuev7mqaWffLeiVAbnB+
         iqTrYDWIg1vI3LRuTeu7iSkWdGTN7peHdjyl56WaRba7lStSzrKWu3kwI5Q5NY5i1XU0
         o9y86gOI65PZrdGU1cisNgX2R1O9Tu5M29uasQX0dsJXSrk9scLrebEeoJ645lzSfDft
         SzkK2B2BHbiSK3SEPAW0f6ti+VDquyk+6NxrMvs0xeR83FyCnNpZGue0+JBKFaXzLxtB
         hgMw==
X-Forwarded-Encrypted: i=1; AJvYcCUB0tgyh3bsbaTIhnPtdyQVkDxbDkSILmHddaSr4bIYdgul8Bm3EObt8ksd9atMz2duvRkIV/vV/mze@vger.kernel.org, AJvYcCV+5XuwmCAk4S7jxVFoR/RseoVm/VBmlRrFevcnR7yxztiMkkJR06Rda1cro+tJdWg0Xf1zuM7v501kXM0/@vger.kernel.org, AJvYcCV4c2bMIbwEHP3S/OtKL5vrIzQyxn3tgERVMc0Iw4Wk7LMM8UI8t2AcH9d8EiWWgLr7fBIpksWYCaJV@vger.kernel.org, AJvYcCVIWkj6E7ev1dmQyAKlM2D6o2kxGzfC2RjQPnopathNmC5/fE/h3OjdqMhwROo2/SvIChe3rm5/88aW@vger.kernel.org
X-Gm-Message-State: AOJu0YwskSKMPox5P4Pa8ojL/R+pgnGQ63nQUUrg5DXrsv0u53gD7+m0
	5W3aZRiX1VQEUh3NWCMOIf9zYJqoFpoGB9fpHJ7Jqqqk69FZO6N+
X-Gm-Gg: ASbGncugVfBGOlkr8pOmx6Pqz7d6sqB6urVK1OAtN1DMste47Iwx5GVJpQ6HoPzD6o/
	tsX+P74bTU8FgZbzMxqFWXSFh3Zoy8RTnlmFHERrtEuVSoFqZmrg22cEMib3E/oAZJwVkpv4M6W
	Q3oMCiTvEMLF1QYHpxYaPwft563kn84Z0QBZIB592SStUo2Husqjw03e3bN5MfExMVvUM5OcUm0
	lV/pFmz6kb1iJHSZT98DXBU3yPNoZd9jNzkYcX7oKFYbWwMc4OZXu4VyoeaKTuDgtbMm7KfC19i
	xvocvUF6VxbxPCYptHK4NpIFxUlGc1sx9rFYotVg+JbYMOsdqCQlpn5ESeBGUHVt4182Ct0kYXh
	ik3aeUwMB8QTzFg==
X-Google-Smtp-Source: AGHT+IGPoVf9Gxeq+Z6YkgZOF9dLEtuHhARuJ5TNPwOSxmTqplkNjLTuQh6kUIXQk8Ui4saz4dpBhQ==
X-Received: by 2002:a05:6000:1564:b0:391:4095:49b7 with SMTP id ffacd0b85a97d-399739c8f6dmr6626914f8f.25.1742475709979;
        Thu, 20 Mar 2025 06:01:49 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-397f2837e61sm18492328f8f.97.2025.03.20.06.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 06:01:49 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Danzberger <dd@embedd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Linus Walleij <linus.walleij@linaro.org>,
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
Subject: [PATCH v2 11/11] arm64: dts: airoha: en7581: add USB nodes
Date: Thu, 20 Mar 2025 14:00:34 +0100
Message-ID: <20250320130054.4804-12-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250320130054.4804-1-ansuelsmth@gmail.com>
References: <20250320130054.4804-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add USB nodes required for USB support of Airoha EN7581 with the correct
define of Serdes Port and Monitor Clock for USB 2.0 calibration.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm64/boot/dts/airoha/en7581.dtsi | 49 ++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/airoha/en7581.dtsi b/arch/arm64/boot/dts/airoha/en7581.dtsi
index 26b136940917..d1cec63bb77f 100644
--- a/arch/arm64/boot/dts/airoha/en7581.dtsi
+++ b/arch/arm64/boot/dts/airoha/en7581.dtsi
@@ -3,7 +3,10 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/en7523-clk.h>
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/phy/airoha,an7581-usb-phy.h>
 #include <dt-bindings/reset/airoha,en7581-reset.h>
+#include <dt-bindings/soc/airoha,scu-ssr.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -195,6 +198,52 @@ rng@1faa1000 {
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		usb0: usb@1fab0000 {
+			compatible = "mediatek,mtk-xhci";
+			reg = <0x0 0x1fab0000 0x0 0x3e00>,
+				<0x0 0x1fab3e00 0x0 0x100>;
+			reg-names = "mac", "ippc";
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+
+			phys = <&usb0_phy PHY_TYPE_USB2>, <&usb0_phy PHY_TYPE_USB3>;
+
+			status = "disabled";
+		};
+
+		usb0_phy: phy@1fac0000 {
+			compatible = "airoha,an7581-usb-phy";
+			reg = <0x0 0x1fac0000 0x0 0x10000>;
+
+			airoha,scu = <&scuclk>;
+			airoha,usb2-monitor-clk-sel = <AIROHA_USB2_MONCLK_SEL1>;
+			airoha,serdes-port = <AIROHA_SCU_SERDES_USB1>;
+
+			#phy-cells = <1>;
+		};
+
+		usb1: usb@1fad0000 {
+			compatible = "mediatek,mtk-xhci";
+			reg = <0x0 0x1fad0000 0x0 0x3e00>,
+				<0x0 0x1fad3e00 0x0 0x100>;
+			reg-names = "mac", "ippc";
+			interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
+
+			phys = <&usb1_phy PHY_TYPE_USB2>, <&usb1_phy PHY_TYPE_USB3>;
+
+			status = "disabled";
+		};
+
+		usb1_phy: phy@1fae0000 {
+			compatible = "airoha,an7581-usb-phy";
+			reg = <0x0 0x1fae0000 0x0 0x10000>;
+
+			airoha,scu = <&scuclk>;
+			airoha,usb2-monitor-clk-sel = <AIROHA_USB2_MONCLK_SEL2>;
+			airoha,serdes-port = <AIROHA_SCU_SERDES_USB2>;
+
+			#phy-cells = <1>;
+		};
+
 		system-controller@1fbf0200 {
 			compatible = "airoha,en7581-gpio-sysctl", "syscon",
 				     "simple-mfd";
-- 
2.48.1



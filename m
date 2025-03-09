Return-Path: <linux-kernel+bounces-553146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0525AA58485
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 14:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA61618911A5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 13:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E3520C019;
	Sun,  9 Mar 2025 13:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKqV2HIZ"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C901F8759;
	Sun,  9 Mar 2025 13:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741527062; cv=none; b=LDCBTnRnMgmxBc8QMVJ9pQH3PGh6weicO34RAiKsIBeRJW0u1tPuHKa9o/96Gxyg8gwAg0Kc77qHGVkzqh8CDy56TbTWgBHseI/zgxb7Mk+a4AexZuSoxAdq7GUFm4c7WmvWxNpfKfIjsPL3hcOa8SiWdMTARtnwIco16mHQZHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741527062; c=relaxed/simple;
	bh=aVuFqOdr80HqAFZupDZ37gDkuuBV/y6GSWN/z2KbYZU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TvAInUzyk1TTXo6dX2Yv+c0JfIFr/OH50b+whsK0NGWqavJ8El5XX6DpWITBsi7yK8JAySF3sJzsmclzUWa/DlKYrXBA1k8gdnVAkEb3IXrjGiavW2JBfzeoDKRLnqO2BNIbGr+jyCqADD42FBBljy51ITVmCe70ceeptrqsdkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKqV2HIZ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39104c1cbbdso1597664f8f.3;
        Sun, 09 Mar 2025 06:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741527059; x=1742131859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PUXPbCfIsepDY+Mn7pTqtiR4N56X9o4JrkeUo/O+gyc=;
        b=iKqV2HIZowYItzc86M+rgrpTPYeco0PLLbegiIAuIBBjEjGo8lX9K2hsW6ItkBvUb0
         rJ3lN+V43cM9B0tQGczub2B8+e0UcrzDsXHME9rxcVAlEuwlUvz40UyR0vNUeYIgX4t8
         fENm74piiwZB99xZinT6y1Ss9luCIOOmO17/z6I4JMsCsGnifS6rB2FuVrZS+W6U7Mus
         AT+/PGDBDgMQCLUeyEM3Rd9cfP7PN3Fu84F25cSXcGp51uOzyP75hYADE5euERTLOIR5
         JTmZECGBS+j4s/uvrvGlHxuVPnKBwMvCC7d+TKPkTNNbGe0xGVtePNqNdT6q7yCw4hEY
         6Lfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741527059; x=1742131859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUXPbCfIsepDY+Mn7pTqtiR4N56X9o4JrkeUo/O+gyc=;
        b=ceyQYAyit9MmZOfxJGvmULb5LguH70iR0IEY7mP9xAyV3knfC//yd6jqE1SNYdwoZU
         A+NEIkVSNKjAFyln9uC+vdOhpCh0uzCj34fyZzcKrEe4IfGu4ogUfIVBEBr8gscb0k63
         chEOczwahCH+nVm0LW+E7Ju1ik4r/qluDM5OaLKKX07k7EJMrbaHy83VQ8M/p5k6ikCi
         gymO+ujnIe8D5LGxUl2TXOPXqLuABhlE8KdVCfVWHpO0mXv3k4Lw3Cy3NiP8EMR2a5vu
         Y7qMLzf4mXo4W9PmIGrMAyqAvCWG1s2ZVTg5NBHxrnVyQ0WM+pwWWK0nnUwHQp2xwmqw
         niQA==
X-Forwarded-Encrypted: i=1; AJvYcCUNTBn/uAH5XAlyrYsck+PR6b0SDNC8Oz1yKvm6NgagKrYocppKOn5SzaGtqPZs2St6gVNWWw7OER4b@vger.kernel.org, AJvYcCVEFJdYbTiY2P3AoOCk/KwHfmL97LMn+tulDjxqe7+LsQ3NJopLxcvpjEeHBVoAE3zyBNLH6Rej/WKV@vger.kernel.org, AJvYcCWP57Mr+9stLlMPBbJJm9TeX+Yzsb6dbBIWfZfeInR7tf/52ZtUgfdf5ji9T35+9L7yOwX1J/FJ6gF/@vger.kernel.org, AJvYcCXJ50KHL4zbL9PpBH14hSmnlGFtnWOAcNeZPKbEW9xYN1UGRK1CgXabKoWYEBRTKDVJ2/EdJ2Fc2ex1vX6T@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+XvT52v9YoQMRhe4yDQlJINQr1fMqRx7rASLitke/2Hr6z1n0
	NtnWFbtT45uwZS0KWD4F2F4//Qci1MiO/qtyXFv4w44sEXF+amEL
X-Gm-Gg: ASbGncvkNL5VXF5FZWftHmazrxc81apOhYuLdsO4lK6610zy+vC1yWHLClkYBydoGmc
	ZMLXN4JVlT8+Iu0yJoz/SdiXkp9YsxbT/qu3A5fJR8EezpiclUGG6r7naW3dGsWbjxnQd5s4FhX
	kLqkwFsrZCRO7oeZuoorBjQQoIlKu2SEo2XO5Fn/esMGV704vgcWpT19ni3DZRK4LYCjGIvdCg+
	4XJjRu7LcwIuSwOXiflFlCse7o762yc4KbNpAciDWDcZ5NFlsZwjVmA0VeTsWMD9zCuIoJelucr
	XlLurKptnielpFOignYeop9zjFA1O0vSl1IpMikmOAiEAV8KejFm9yTvosb+j/3ZXrVpSBsECjw
	Rc4PY3AI0X8imEA==
X-Google-Smtp-Source: AGHT+IHb6GE+RdsoNUn0+3sL37pgWMjh5/VzLN7RX2rS7tVvUpl9i16EKbDnFhvFgXvM+UgMM2DmzQ==
X-Received: by 2002:a05:6000:1846:b0:391:2192:ccd6 with SMTP id ffacd0b85a97d-39132dd6afcmr7499960f8f.39.1741527059081;
        Sun, 09 Mar 2025 06:30:59 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3912bee262esm11867536f8f.0.2025.03.09.06.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 06:30:58 -0700 (PDT)
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
Subject: [PATCH 13/13] arm64: dts: airoha: en7581: add USB and SCU SSR nodes
Date: Sun,  9 Mar 2025 14:29:44 +0100
Message-ID: <20250309132959.19045-14-ansuelsmth@gmail.com>
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

Add SCU SSR and USB nodes required for USB support of Airoha EN7581. SCU
SSR node is required to read and configure the current Serdes mode of
the USB PHYs.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm64/boot/dts/airoha/en7581.dtsi | 61 ++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/airoha/en7581.dtsi b/arch/arm64/boot/dts/airoha/en7581.dtsi
index dfc12fa99748..5975da11ace0 100644
--- a/arch/arm64/boot/dts/airoha/en7581.dtsi
+++ b/arch/arm64/boot/dts/airoha/en7581.dtsi
@@ -3,6 +3,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/en7523-clk.h>
+#include <dt-bindings/phy/phy.h>
 #include <dt-bindings/reset/airoha,en7581-reset.h>
 
 / {
@@ -183,6 +184,10 @@ scuclk: clock-controller {
 				#clock-cells = <1>;
 				#reset-cells = <1>;
 			};
+
+			scu_ssr: system-controller {
+				compatible = "airoha,an7581-scu-ssr";
+			};
 		};
 
 		uart1: serial@1fbf0000 {
@@ -200,6 +205,62 @@ rng@1faa1000 {
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		usb0: usb@1fab0000 {
+			compatible = "mediatek,mtk-xhci";
+			reg = <0x0 0x1fab0000 0x0 0x3e00>,
+				<0x0 0x1fab3e00 0x0 0x100>;
+			reg-names = "mac", "ippc";
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+
+			phys = <&usb0_u2 PHY_TYPE_USB2>, <&usb0_u3 PHY_TYPE_USB3>;
+
+			status = "disabled";
+		};
+
+		phy@1fac0000 {
+			compatible = "airoha,an7581-usb-phy";
+			reg = <0x0 0x1fac0000 0x0 0x10000>;
+
+			airoha,port-id = <0>;
+			airoha,scu-ssr = <&scu_ssr>;
+
+			usb0_u2: usb2-phy {
+				#phy-cells = <1>;
+			};
+
+			usb0_u3: usb3-phy {
+				#phy-cells = <1>;
+			};
+		};
+
+		usb1: usb@1fad0000 {
+			compatible = "mediatek,mtk-xhci";
+			reg = <0x0 0x1fad0000 0x0 0x3e00>,
+				<0x0 0x1fad3e00 0x0 0x100>;
+			reg-names = "mac", "ippc";
+			interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
+
+			phys = <&usb1_u2 PHY_TYPE_USB2>, <&usb0_u3 PHY_TYPE_USB3>;
+
+			status = "disabled";
+		};
+
+		phy@1fae0000 {
+			compatible = "airoha,an7581-usb-phy";
+			reg = <0x0 0x1fae0000 0x0 0x10000>;
+
+			airoha,port-id = <1>;
+			airoha,scu-ssr = <&scu_ssr>;
+
+			usb1_u2: usb2-phy {
+				#phy-cells = <1>;
+			};
+
+			usb1_u3: usb3-phy {
+				#phy-cells = <1>;
+			};
+		};
+
 		system-controller@1fbf0200 {
 			compatible = "airoha,en7581-gpio-sysctl", "syscon",
 				     "simple-mfd";
-- 
2.48.1



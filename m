Return-Path: <linux-kernel+bounces-204493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E15D8FEFC5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2293D285146
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB5B1AD9EE;
	Thu,  6 Jun 2024 14:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYz97BZB"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B138619D09B;
	Thu,  6 Jun 2024 14:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684653; cv=none; b=rCnVNOSQvx3cH1WYiZrNPMzM2sR4vUHVmlSfaEhIAMAamB+9gBD0X5JINpn6grZ5hoiD5j+zloz/UkRoJcLVIjg+sGOGBkp3a2tEE1qTy9A0aTswiXLe1L/NDbyNCiQ8xvxAfWOL62xSTqhbIVTY/wQAWhusOrPoLS7oHHPlMTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684653; c=relaxed/simple;
	bh=ZdpFKueYPK+WEfUg3Gqz23LkOndZ3SLipHGnj6qgiUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2YGwYvjTm1yvuZMKQu4iXsjqbU4vIFyfwkeQBFDy1qO9DuxcsgatSRowG6EPlntVjH+11sYN/lxEQZRz18ja95BiGkG1RqMkLonlp345x+S33CBD8wF2MDDE2WtTg2snLty58r+uUFNM0p7ClKBNCpVl1+aYuE5hjs8X/dpSeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYz97BZB; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57864327f6eso518173a12.1;
        Thu, 06 Jun 2024 07:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717684650; x=1718289450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6e1IO8wa8L/zyDqKfvDJQSO9H57/3PySfWDoeUhjP78=;
        b=AYz97BZBtunnETP89dklvH84DrWxZv/l4ix7tc1JetY+jYa2L+6PaiwpjSvKapyL/2
         87wl33TWlNL7tEbDtnLPg2GT8Gkw1XdlJCzrBSB8ys63tNUYuSyR9B5IiDBLCKj5Huy5
         jMS5/Us5rWYPQFfyCBSJpXWaU2EUGC82EF2f5WnKdmFjeazmdQuM5rD6TPTLXS1Ui4iO
         juBe+i9dd+UfRZLPR3i2ZRfAZcQpJLuNR4wK/I9oWU93w+z0N5iGYcfoGIGxazzJbwWs
         5E8tHz/kfx3UkRU1FsRNB/IeCKlTWyEJD+AiKSzl6pQfq6UkK6fo+WLqTKAfqcRZPkC4
         tzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717684650; x=1718289450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6e1IO8wa8L/zyDqKfvDJQSO9H57/3PySfWDoeUhjP78=;
        b=R5uWMHy4xZgtg8k0zwbRIpmu+xF1ng9bgK/uFyjw7ErrinVRw3n7z1JgCal41SpU6K
         v7UlQn95bPMhqj1/CfZwV7xXlIKnTvK7bEzuOudyL2mm/IB4JiEZJ0BD7m8+5CDbfEiB
         3dShg//TJvhumvtx+ZqFvtPGNv29x3IMS/sUDoNzOt+Iwy4kS4u/lpXOm7F3N4sJKHE6
         1k4IcEmD0hmT4du1S9JTLfzK0NVk4xNaaKTKtNBVK4cMgWPRjcxrDLUs62sCw6TpkqqI
         WHBomYdOL470kD63GE9l950I5d7QONX4xeNgri1l7HEbUdX4r0VR0J7Kc6Q5tAq2L1bE
         s9+g==
X-Forwarded-Encrypted: i=1; AJvYcCVzCpSr0U5jCrn0SqlBLNCL4/KtpJQTv7KGstG9vp8dqpgSNoVoFLUwkAAOI78IZT2xBg9az7cic5UfXrTCcLmD+TiE17jXv01gq+MZLc/2zzJTwbS0ITp6ybu48h8uGESdvdnGOnQAP8XH2oCNOKUUvnDjsYLK2EpKz3wL3hZD0dhLwg==
X-Gm-Message-State: AOJu0Yx1ODWutmx/TQ4BcVyw3/ASmwU9H/FAq/s4pUfY4AUIieF5Mz7m
	RoU2TBolsTQxEul+PzJzHiyREDIrc1xpdbEemAHMiwBdtKu+JDU=
X-Google-Smtp-Source: AGHT+IGTguIsiQuctF52YO2KaIAv/wxplXc7Xf93KtnhaWBBwggvhPDzJlNlzZ3hmNeOjD5ieyF3QQ==
X-Received: by 2002:a50:d7db:0:b0:578:69be:6e7a with SMTP id 4fb4d7f45d1cf-57aa53e0569mr2595265a12.1.1717684649733;
        Thu, 06 Jun 2024 07:37:29 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:ed9f:91b7:21f2:3109])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae1008adsm1190925a12.38.2024.06.06.07.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 07:37:29 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v3 5/5] ARM: dts: rockchip: Add SFC for RK3128
Date: Thu,  6 Jun 2024 16:34:02 +0200
Message-ID: <20240606143401.32454-7-knaerzche@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606143401.32454-2-knaerzche@gmail.com>
References: <20240606143401.32454-2-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the Serial Flash Controller and it's pincontrols.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes since v2:
Fixed pinux settings for the chipselect pincontrols which originated from
contradictory documentation: Datasheet [0] (page 29/31) says it is func4
(when start counting with func1), while TRM [1] (page 185) says func3
(register value 0x2). It turned out TRM is correct as with setting cs
pincontrols to func4 the spi chip is not detected, while func3 is fine.

[0] https://www.armdesigner.com/download/Rockchip_RK3128_datasheet_V1.2.pdf, 
[1] https://www.t-firefly.com/download/fireprime/docs/rk3128_trm/chapter-5-general-register-file(grf).pdf


 arch/arm/boot/dts/rockchip/rk3128.dtsi | 35 ++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
index a7ab0904564f..c37aed28bd10 100644
--- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
@@ -399,6 +399,15 @@ usb_host_ohci: usb@101e0000 {
 		status = "disabled";
 	};
 
+	sfc: spi@1020c000 {
+		compatible = "rockchip,sfc";
+		reg = <0x1020c000 0x8000>;
+		interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_SFC>, <&cru HCLK_SFC>;
+		clock-names = "clk_sfc", "hclk_sfc";
+		status = "disabled";
+	};
+
 	sdmmc: mmc@10214000 {
 		compatible = "rockchip,rk3128-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x10214000 0x4000>;
@@ -1155,6 +1164,32 @@ sdmmc_bus4: sdmmc-bus4 {
 			};
 		};
 
+		sfc {
+			sfc_bus2: sfc-bus2 {
+				rockchip,pins = <1 RK_PD0 3 &pcfg_pull_default>,
+						<1 RK_PD1 3 &pcfg_pull_default>;
+			};
+
+			sfc_bus4: sfc-bus4 {
+				rockchip,pins = <1 RK_PD0 3 &pcfg_pull_default>,
+						<1 RK_PD1 3 &pcfg_pull_default>,
+						<1 RK_PD2 3 &pcfg_pull_default>,
+						<1 RK_PD3 3 &pcfg_pull_default>;
+			};
+
+			sfc_clk: sfc-clk {
+				rockchip,pins = <2 RK_PA4 3 &pcfg_pull_none>;
+			};
+
+			sfc_cs0: sfc-cs0 {
+				rockchip,pins = <2 RK_PA2 2 &pcfg_pull_default>;
+			};
+
+			sfc_cs1: sfc-cs1 {
+				rockchip,pins = <2 RK_PA3 2 &pcfg_pull_default>;
+			};
+		};
+
 		spdif {
 			spdif_tx: spdif-tx {
 				rockchip,pins = <3 RK_PD3 1 &pcfg_pull_none>;
-- 
2.45.2



Return-Path: <linux-kernel+bounces-202973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4188FD3E7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 19:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D19B5288F8E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3291C155C9E;
	Wed,  5 Jun 2024 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIdQGSDb"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BC213A269;
	Wed,  5 Jun 2024 17:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717608121; cv=none; b=M+eZKpuGvz4wtbvBjJoqByQAdA6iD2090SEpFKuzhuwRFK7i361g+nm19tJDrsXJ7tuEevXlo6rdQzAv+1m2+aCrRkVAWSuuV33uqSDcgd6G17qEun0Y/WzMXaqAyVnrQSLb+hVd700au1+eHZzxeLfyFu/saGs+pj57eBsre+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717608121; c=relaxed/simple;
	bh=AQXObQDUzMQES1hvJtdiEAsAUh5MhWHJcqhhTYjm7jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ccCsn9SF0GQrVtAsxR93MH//ySPBAD7Qmxh/0+fDQc75t3KCgNragulr2yzwkLikSZ08eEhovOyVHkooJvp6yYRDwpbE8cp4bVHeGRXbynFbichCvepqLBHSRjGujSLLJnZQj8nLnx2UHOeHxzDPRO7I7XwpZ369Ri/u3Cj/SuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIdQGSDb; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52b976b5d22so153109e87.1;
        Wed, 05 Jun 2024 10:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717608118; x=1718212918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSnrzfQSI7FFWe4M7p38YadUmYRLzv+fLcrRvYhlfvQ=;
        b=jIdQGSDby5xwTz8c+pypQyTFaA17tdXDxp9BtaNA/+lTB6lw2NhtjfT1LtSAvDUis4
         Olw3M1Hl8iSH/xJ8JLst0v6ypUKz1oxL4NZyDzO4mwafsjZmsdUeZF38L5EXPOkyXjr3
         cgnXQ8BSTUCjMcC283rHCT0Dj51xvfm4Z4wIFkVYNSO0S4SqpqhbgsAAC85mQ0iAVroL
         JkYc5PoWmmQeJh8cobfNPYX9Udb0Nymig4a1a8yplrhxeugFHelVRej9+n0raWC+kRI3
         ScRI9zZOcNqyQ0l3wtYEDTU2Lovvcbyfrw8J2EklQ6MkJShbf4c7L58XErvNNOUF/xg/
         DskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717608118; x=1718212918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSnrzfQSI7FFWe4M7p38YadUmYRLzv+fLcrRvYhlfvQ=;
        b=Av/X0hT1xLhmexxJXmm39UwvP9rrDniw/5mBmF+POVqyHfTyI9BhyAl+ziGyLiXD2A
         7bohZX01tSXQbRzU8vXYjmPrkh2tPNiQGBe/WS/gPbW8dC1cTnar0w84xp/Qw7zXytDe
         IgcIAUMweyTA6WRsXlmMxYbCnrQC1YkrDcNA18VLD7XVrtoiDOz0zFgBGHuOepTaXbRI
         Jcz/OhWR7QQr6hXtCJ4kKsUGEUP+ZjWLJpO/vuWYpVe/X9VmcvG07qrTHD0z7S8fDLbD
         YZlrHrLaDrBjpwaP52L3/8prqv6iA5FvajUEl+BWjH5OVxx675p0baiyAUDaQoWdCgO6
         2/Lw==
X-Forwarded-Encrypted: i=1; AJvYcCXn7pzpFdEC7RanZlpMNUlp2hf7ly/5Ky6Nw2+mxfEzX9US6nwpsrO7ZG2/PUi1Xm5fnBj3NkVwpihGBGOrmEIw9aFsYjUFoWfJ//+6TzQYyJM5fVP4mamcWp7Zw7C9PLO+5n0Krsp9BHGzLqeN78QncaUZ/7sm81vgEeNrr/PFpLeKng==
X-Gm-Message-State: AOJu0YzhWpkpmsy/islgpf+d8eTEUvtW7J5ZFu3JTNEi3i7D2EueNgHb
	yDBjaQcRb0aWnXGmIZegjzUsceI7xALWGECLK2wLP+AX2xlodrBZQytk
X-Google-Smtp-Source: AGHT+IGvhcnG7M1Vbx/YQj99uXW0A5K4R73XVFCAylehvWPGYqkTm8EPKbShM4S7aRYehR6yW6Nflg==
X-Received: by 2002:a05:6512:5d3:b0:52b:51f9:a37d with SMTP id 2adb3069b0e04-52bab5084b1mr1671148e87.56.1717608118030;
        Wed, 05 Jun 2024 10:21:58 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:34f:df25:1c86:f2e7])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31c6d594sm9666663a12.69.2024.06.05.10.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 10:21:57 -0700 (PDT)
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
Subject: [PATCH 3/3] ARM: dts: rockchip: Add SFC for RK3128
Date: Wed,  5 Jun 2024 19:21:54 +0200
Message-ID: <20240605172154.193047-4-knaerzche@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240605172154.193047-1-knaerzche@gmail.com>
References: <20240605172154.193047-1-knaerzche@gmail.com>
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
 arch/arm/boot/dts/rockchip/rk3128.dtsi | 35 ++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
index a7ab0904564f..22e2a35dedb1 100644
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
+				rockchip,pins = <2 RK_PA2 3 &pcfg_pull_default>;
+			};
+
+			sfc_cs1: sfc-cs1 {
+				rockchip,pins = <2 RK_PA3 3 &pcfg_pull_default>;
+			};
+		};
+
 		spdif {
 			spdif_tx: spdif-tx {
 				rockchip,pins = <3 RK_PD3 1 &pcfg_pull_none>;
-- 
2.45.2



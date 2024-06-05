Return-Path: <linux-kernel+bounces-203212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B4B8FD7F0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 027C81C24450
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E6615EFA3;
	Wed,  5 Jun 2024 20:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+5XH+KT"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD081667E3;
	Wed,  5 Jun 2024 20:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717620743; cv=none; b=ktQ5RC7nigM/RzKGL5cb0IDdYvm2/4lcY+e3VKcsYFidj9kC6ENcvo2L57fMAy6q6QzgSqwlRuY9kKXRjqThmKTCwv4rtfamT16AdyCTHz1wTWu/ont9n9A7gx6yFT2lqb/BPb6t7jleBUl1lI/ZKanXXigP0Etuaep2ffyUQkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717620743; c=relaxed/simple;
	bh=XbbvUFHICWvu13gNhRXL0Fye9J8RtUmvNrF/SgzD6jI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n/BfLMUzDTkj2HEXPqcYK0fhUTwp37mg4ORBi4t3c2ffSZumk8HJfHqYDVHgrYbD4A5qFnYCVEqV0EriwRc4yTqLq2z6QlOk29RJ4kOgGu3dTtaca0/yQkFK2f8LykAlP4td08kJBAhWofZjqPm7xC1PbD35R//qxkXyXCb77cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+5XH+KT; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-35e4d6f7c5cso221953f8f.2;
        Wed, 05 Jun 2024 13:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717620739; x=1718225539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhHtvxGUyohTCTNa+GzFt+gMuFh5QKejQOFzumSpgUQ=;
        b=A+5XH+KTgZ6mcbPmNkieVGXL1AJneDCJDO+D8OPmOvegTYHBlCR2y5umiOd8EamYte
         rtdPTwitjSGzdURR3tc4LWGKfnO6sqnQsw9A8qZCcZ8gMNAz1XmVz0Kdh2VYjKG4k1xT
         Xv92OPkGz310CuqAY6eHdjUVVFe2gDqbyBeQIMiWPuPIlmB8NOUIbJAn7XV2QQOFKmQs
         /QKGLrqKApnRd4R/e4saUW3lQCHmarlyi9990qj9GOMDs97oycQxSAtvfwazsbiPFHB4
         z+pAbkh6IFTz/zNGKL7snKGIDbEWcPKJtJmNZAdBZMveu77fQMjTg/vLu7loSGytsOB5
         cCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717620739; x=1718225539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jhHtvxGUyohTCTNa+GzFt+gMuFh5QKejQOFzumSpgUQ=;
        b=g0AkGPfHqBYC6Xc9dwSQzS7FSrEg38q1qzfKiEqSNfnEJxD/PhbFJgPrXVBUldDmB7
         p62wY20qp5IOBJ7tKLyRf4luZdGCzDkJ4AHN6vqBZEpzHhHyHx/jtzIxX4nW7sr6UzTz
         wQEv2R/+3ILYuPoKpXdn7Dymxl6PIWo6lFhAyYnDo6Sho+sZdy3j9qpHJ+CVblMOO0zn
         lxRaHBW+MrNT5mVsnlWTbTOD6pUlzmWxQ3RtIt651aHS7zX8h4s5q/LOZ+ZZmY8tJ0aZ
         04BKg54fVk3zqPUxrpOSsp06kW188eA8VLPd7bsAgWGLM/iZi9HpqM5QihI7AvbK1WgR
         b6lw==
X-Forwarded-Encrypted: i=1; AJvYcCWTsMnNZahYQVKHqp22SP18JWcnE47EqYF4LmGTnHQHAOG01u0K6A68vRA7+oU3L0xZSGkfTXgwbYyRu/YKGJvTrM98qbSNc/4zdmm+GASUjksxJLnwrb5X8nDYJI/d9PNxxPxpM6OwkR39O3WzTeJCL3HUh7Ihqspes7VKYOt0CiOXlQ==
X-Gm-Message-State: AOJu0Yx4L9o8IfoQ0ZAVEU0GEeJh7TZeD14Xzaq/UUUJ1gZgKUWHZH3t
	Ks76xgXh++jVfRRde7ifDB6OkGY6ZvqInW6LJ54wQ170j9umCF8=
X-Google-Smtp-Source: AGHT+IFCUf/nSWcFwovwvBwGIMkEfxcyaPdZQUK7IjGCB4qaZIM7Vbj8k1JhhipZFwk6qW+PghjHTw==
X-Received: by 2002:a5d:5886:0:b0:357:bd78:4954 with SMTP id ffacd0b85a97d-35e8833a4ebmr3356057f8f.30.1717620738877;
        Wed, 05 Jun 2024 13:52:18 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:5211:58fe:dfef:c48c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c71bb5affsm72265866b.147.2024.06.05.13.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 13:52:18 -0700 (PDT)
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
Subject: [PATCH v2 5/5] ARM: dts: rockchip: Add SFC for RK3128
Date: Wed,  5 Jun 2024 22:52:09 +0200
Message-ID: <20240605205209.232005-11-knaerzche@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240605205209.232005-1-knaerzche@gmail.com>
References: <20240605205209.232005-1-knaerzche@gmail.com>
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
changes since v1:
 - none

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



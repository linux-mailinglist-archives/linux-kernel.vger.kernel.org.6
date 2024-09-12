Return-Path: <linux-kernel+bounces-325868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA9E975F42
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 04:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 718B21C21E5C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 02:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6D514B97E;
	Thu, 12 Sep 2024 02:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clM2cC2V"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B2313E02E;
	Thu, 12 Sep 2024 02:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726109543; cv=none; b=UVwKrynjXJyF1rdoEBlsFxccZ6uTJ6NvbqBPEgYSiq9e6XVDf1KOlzSyuO/b9TkoL2dPvjIv4SOe8V/MoKTpo38SGY9WzEH4KgZbu3xMqBBK9Hakj27QLo4dLQAw/B9SzNm4jLSM75wjoLMVOREpVWeK6URc9vKqPoCU+FDh8dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726109543; c=relaxed/simple;
	bh=OTNqcrAKE06GUdOETfo5Qkz1ipzfNrgs7GKHtqe8cAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bCdp0r1d+jBXJ7mxdt2MxIk5tJ7uip6zkjkAReVvVDGmZ6659uAZRgAgvp1PVuCUdU46EgKJHOGfgwEnbo5l8L1jDy/bt2TzmuU5evv4SZehRU+4Isf7FWvFlyXLhRQ776iU4Wa1XSjfU+YYVDIpI6Eu+8WFilal7NqW0S/USXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clM2cC2V; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fee6435a34so4693965ad.0;
        Wed, 11 Sep 2024 19:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726109541; x=1726714341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTLH1fwbTqdCfrwZp0L80p0RJpAcuj1IYnPdAurgWzI=;
        b=clM2cC2VYBpMw6PS/tLeSVLbaIwjMOMuPz4vbGpdHJcSujxYZSPFIlDIGRIAqxGXYF
         IDQ6ucMkCqyjTktdr99doftgt+dMP3+I6trlA4l46YDl8WNgDM32y4fYgJeV28UyqxUf
         qxA6DgvEjhQzxkdgsYb/U3XVFOCgAwr+tE9R7fKYaXbmeXg5IR4I314sCHzlVdcjV+Yb
         Xe/87T3R9VCsVGrtOiNL74pjyKlBFgfbtScXWipG77o5ZrAhdLeyW7s1lUg5PjrQQLGl
         rASesavdfXOrAK6Q1O/PMwfCgXuDdOU7SevaO9PsA3+mXaLFqrp5MAUnDQ22sfc4+Txy
         yetg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726109541; x=1726714341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lTLH1fwbTqdCfrwZp0L80p0RJpAcuj1IYnPdAurgWzI=;
        b=jbY+fjVXU5Im27DWGh4Lq1wZXz1Vbqau8ifDQb61OcicA7uerF9SUXPqMYfxfbQqOg
         EHQrGp7RDITkz0fCNitPW0O9SiW/YUpScDvKgh+ZyJcScLpzwPbMs2x/C3uae7wVknBi
         A94tmaAGOX0E1xe6wbBQywbCifAbkgKAWPLLeyr8HLNy0XZb2fYaKR+kNs0dgwq5ss1I
         pHfDL2tcCT/qMAJ0AvF3fN9P42GZ9GhKN2gcWYzpZ7WrHnsAVjG2BE3pIgPEszB+e9cB
         dxM0XkVd+OyXpkZrgZMEmDs45+Jo3CZlQsNKZ0hDZ0dHIymDdvLHSIXLdBY4vA9vw2u4
         xqMw==
X-Forwarded-Encrypted: i=1; AJvYcCU++M+nIZHKrNWAQR1MSD5sHjZZONNFHJabeAV9N/pBSpGV69VCrc4Eys8PmRjo5wMmxII+lTnuxxUGDwRq@vger.kernel.org, AJvYcCXQfeGZbj1mMQ97/I5Yz++XI6Ns5yyhjVrNzV/jDsBYRpR5t6+6xH3cDLDTy2HCRdJ9XuviG518zKdK@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8DxUdxZFZTqlOzzPnc/qOSNaaJFIq26dzJFlY+Tbt0WRaFGYx
	NTivjtLqSJ9VLv5ULEmXfM4PsjHvXvkWieN0twpBlzAXU6tqME+q
X-Google-Smtp-Source: AGHT+IE4pgAMpAAF0j5qIkNUhLayqNKxMnq6pu3b8huQcVGkx2rCVOsWcbdufVpuBI8i32PPDllUZw==
X-Received: by 2002:a05:6a20:b71c:b0:1cf:e5e5:263d with SMTP id adf61e73a8af0-1cfe5e526e2mr7224637.35.1726109541031;
        Wed, 11 Sep 2024 19:52:21 -0700 (PDT)
Received: from luna.turtle.lan ([2601:1c2:c184:dc00::315])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fbbf877sm569023a12.50.2024.09.11.19.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 19:52:20 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ondrej Jirman <megi@xff.cz>,
	Chris Morgan <macromorgan@hotmail.com>,
	Alex Zhao <zzc@rock-chips.com>,
	Dragan Simic <dsimic@manjaro.org>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Jing Luo <jing@jing.rocks>,
	Kever Yang <kever.yang@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Daniel=20Kukie=C5=82a?= <daniel@kukiela.pl>,
	Joshua Riek <jjriek@verizon.net>,
	Sam Edwards <CFSworks@gmail.com>,
	soxrok2212 <soxrok2212@gmail.com>
Subject: [PATCH 3/5] arm64: dts: rockchip: Enable automatic fan control on Turing RK1
Date: Wed, 11 Sep 2024 19:50:32 -0700
Message-ID: <20240912025034.180233-4-CFSworks@gmail.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240912025034.180233-1-CFSworks@gmail.com>
References: <20240912025034.180233-1-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds thermal trip points and cooling maps to the Turing RK1
in order to enable automatic control of the external PWM fan. The fan is
not active below 45C, as the heatsink alone can generally keep the chip
in this temperature region at idle load. This cooling profile errs on
the side of quietness, since the RK1 is commonly deployed in a Turing
Pi 2 clusterboard alongside three others, with additional cooling
provided at the chassis level.

Helped-by: soxrok2212 <soxrok2212@gmail.com>
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 .../boot/dts/rockchip/rk3588-turing-rk1.dtsi  | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
index 9bcb5acdea54..f6a12fe12d45 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
@@ -208,6 +208,59 @@ rgmii_phy: ethernet-phy@1 {
 	};
 };
 
+&package_thermal {
+	trips {
+		package_active1: trip-active1 {
+			temperature = <45000>;
+			hysteresis = <5000>;
+			type = "active";
+		};
+		package_active2: trip-active2 {
+			temperature = <50000>;
+			hysteresis = <5000>;
+			type = "active";
+		};
+		package_active3: trip-active3 {
+			temperature = <60000>;
+			hysteresis = <5000>;
+			type = "active";
+		};
+		package_active4: trip-active4 {
+			temperature = <70000>;
+			hysteresis = <5000>;
+			type = "active";
+		};
+		package_active5: trip-active5 {
+			temperature = <80000>;
+			hysteresis = <5000>;
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map1 {
+			trip = <&package_active1>;
+			cooling-device = <&fan 1 1>;
+		};
+		map2 {
+			trip = <&package_active2>;
+			cooling-device = <&fan 2 2>;
+		};
+		map3 {
+			trip = <&package_active3>;
+			cooling-device = <&fan 3 3>;
+		};
+		map4 {
+			trip = <&package_active4>;
+			cooling-device = <&fan 4 4>;
+		};
+		map5 {
+			trip = <&package_active5>;
+			cooling-device = <&fan 5 5>;
+		};
+	};
+};
+
 &pcie2x1l1 {
 	linux,pci-domain = <1>;
 	pinctrl-names = "default";
-- 
2.44.2



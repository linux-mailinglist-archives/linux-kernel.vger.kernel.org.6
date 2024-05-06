Return-Path: <linux-kernel+bounces-170362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 816AD8BD5B1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 21:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BBA62820CF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 19:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D0615CD79;
	Mon,  6 May 2024 19:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRrVckZY"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D14215B54F;
	Mon,  6 May 2024 19:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715024646; cv=none; b=DKSVOZBJ03xDU17dX8LVJqKH0cUJuoqf3NxldfDnxBkkIQ1nQZpwN0OfhCVmRH0HoeIRs0JGTO7XjQ6rq/tIGLqKLKPrD/Fv2D7W/1MWeuoWA3QgeAupzq4wR6E5v4Dlv+aCnMYxYl6ZLIDRmEyERsbWUz/yDlYr4o1sV+poFCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715024646; c=relaxed/simple;
	bh=wjlH4Lt5S7mcx5jnJNpBQbgACYP+Lvxy1N0d55tJixs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fo2z62Qgc+GQlREe9NZBIM0Ly/SNgzrH+dnpXp7sxolxjyMCNv0VcsEVrurjy3Q+56Hs62WLFZQwZolCm5atXAtk5xvbzvr+Flo348g4m5cGxPdDbL99l/B9yiClnSYcaCdOHtCipN7QHiolWNRWYHxg36ONxbXS+zwODUNxpIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRrVckZY; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a59ad344f7dso434099566b.0;
        Mon, 06 May 2024 12:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715024643; x=1715629443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPo30HLErisAcogmRAQBmaHjRdsPf6mxSQ2qeztK2Sw=;
        b=CRrVckZYvWMRFB+7wj0wLjfATPj6wWMI5TKwM2GCO/FiHm52/gn9bA5T+ms4dGa0db
         DU8TR/Ca6z8SyK+TODW3UiDV5k1ECNspInbj/yt3+ry/XxsFVDH10c3okf6i3QoHV2q+
         ULFJIlbg+QSBzKieT755z/ekY9be7QXoI7MvHQmZOaRmEG+w8VERoK7JGnab33vfin8a
         41YXDWlcIUjtOGT5TEkeLbKxrHuGpos5SrJybjBerU9PiE/8QHg0FqabZwyyOHqCwkkU
         AoGQo05EJ4uZR191/y/zZ3y83rRwggrfKoEho2R4IlpBApc6wkshh6VLhAveIkTyne9T
         P44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715024643; x=1715629443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oPo30HLErisAcogmRAQBmaHjRdsPf6mxSQ2qeztK2Sw=;
        b=QxsLDWb97JkaxtenVreuWzQDNTZu+ee6ENgkqENRzL4q0qHlGg2rCyQ/Tqee9iSeXg
         u9LkVYDyPYbGOXhSEi/QWkvi6xLwtyrtzIhyWICPlrDVdeLpyFrB0xE0DjFgV+SSZMxo
         4hLI8ywaayWoTu8dhJNV7n4yyGxQWmSils0XIA9E57pDR2p5XN0mnpZIZf6aSho4wYHg
         UuKd+d4Qfs1Zup0NHCD3OVaivZPhwyjRFPeh4XQKP71UF+iKMOGAnls38ecauBhII2KC
         O32CBbXiInxoQAIAXBh4N2BRYaeuKZKCRvPJ1AjckWa3d1Fw1+Tk7DMj9A3p6+x8Tspt
         +VyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJitviFKZoQWFM8VjKQvyrQAb/16Xn+kaTddenYqhxbRe/CRgU39r5Jk4UkN8VXIY+uCnNXcsENZeX9Ssi7SnAImsxR7KM83HzrJC+dzyuBm4PL8RhXnNadRT1DN4x9V1avO9h5oc/38+TufKsExDj365UwKvTplnuft7cvUYIGj7wbg==
X-Gm-Message-State: AOJu0Yxbbdbt1p6Y66hhGv8zsRzD0KHBlhSxyaEl2MTrM//M+UIjfDl7
	IaYJ1DhoW3i5NlbmGfhOfPWmimdvEJe3Syiul7X6rgNZR3ImMig=
X-Google-Smtp-Source: AGHT+IHSrrVeS/vienMxLpjAA24SO1Al2k+NRtJh5keVZVgcxbiYBpQB1pEWoo3HKzaMNkd68QRWQw==
X-Received: by 2002:a17:907:97d2:b0:a59:c9ad:bd26 with SMTP id js18-20020a17090797d200b00a59c9adbd26mr2965779ejc.12.1715024643508;
        Mon, 06 May 2024 12:44:03 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:1c62:e77:6753:5729])
        by smtp.gmail.com with ESMTPSA id f13-20020a1709067f8d00b00a59d146f034sm1367321ejr.132.2024.05.06.12.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 12:44:03 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 7/7] ARM: dts: rockchip: Add DSI for RK3128
Date: Mon,  6 May 2024 21:43:42 +0200
Message-ID: <20240506194343.282119-8-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240506194343.282119-1-knaerzche@gmail.com>
References: <20240506194343.282119-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the Designware MIPI DSI controller and it's port nodes.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk3128.dtsi | 36 ++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
index d16a9d03ba2b..93885338a80b 100644
--- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
@@ -276,6 +276,42 @@ vop_out_hdmi: endpoint@0 {
 				reg = <0>;
 				remote-endpoint = <&hdmi_in_vop>;
 			};
+
+			vop_out_dsi: endpoint@1 {
+				reg = <1>;
+				remote-endpoint = <&dsi_in_vop>;
+			};
+		};
+	};
+
+	dsi: dsi@10110000 {
+		compatible = "rockchip,rk3128-mipi-dsi", "snps,dw-mipi-dsi";
+		reg = <0x10110000 0x4000>;
+		interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru PCLK_MIPI>;
+		clock-names = "pclk";
+		phys = <&dphy>;
+		phy-names = "dphy";
+		resets = <&cru SRST_VIO_MIPI_DSI>;
+		reset-names = "apb";
+		rockchip,grf = <&grf>;
+		power-domains = <&power RK3128_PD_VIO>;
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			dsi_in: port@0 {
+				reg = <0>;
+				dsi_in_vop: endpoint {
+					remote-endpoint = <&vop_out_dsi>;
+				};
+			};
+
+			dsi_out: port@1 {
+				reg = <1>;
+			};
 		};
 	};
 
-- 
2.43.2



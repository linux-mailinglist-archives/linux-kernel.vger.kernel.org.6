Return-Path: <linux-kernel+bounces-309031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77911966572
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 306C72848E6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA801B5EA6;
	Fri, 30 Aug 2024 15:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9/TC42j"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D1E192D98;
	Fri, 30 Aug 2024 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031765; cv=none; b=P2phJtgU80YOws0bvrWpCS1UY4UMgGHRsHLRgx02azUB0QH56gegMQXamU4bdHt7N6r7Kmd+B2F0EN+CgpY+hIUVE+41wwZ4OdWDDMLDuaYw44OiGmtuPnnZHlYXIXmcMLkq0A38UGemI5xLpQM5BnuFjf3g6P93r5tvWIJ+9QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031765; c=relaxed/simple;
	bh=p/WRyqZpeSIZmXbneiNcA85BgVx6dYrJbxl49Qtah/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CrcvJibc6/0J8DfkBReM8Kjep/wJPGRoXM/hljMZObiVCMVA6AqtI6Bz8rMOxVy/4UQQPuq+DpVnOtKBdsE/DdMy+VXn5nsJlc8G6Rpw2SeYxg9kCEVsttPEeECnFaVtS/SuDlsiXnJ1FdmMcJKiV58T+FzOf30/nnOlbrULzpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9/TC42j; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-82a3096ae9aso19715639f.0;
        Fri, 30 Aug 2024 08:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725031763; x=1725636563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTbfsd8NvXwzdBfTnE3JqlL7neYrWLzy9hOrmppNIdI=;
        b=N9/TC42jIPg141nHGTQIvVysDFXpWjrKXE5wbT7/iMKU+IN7uunhX3UnZb/BBfve4d
         cHhvDAtHzwujbev/fnBhUqy167P8dvpswfQfAlGuzaKQwBEQCYh18fMvaDFHUMqrsGP6
         qDyUqiq4gpVX8g13K0L9lWSbThE/5VXrCWPQJYsrA1JRTuv3oQg+/tsHrvpvKxh05eGc
         do1PBLhgNenOMlb8Ihkui5ucxV/4izWq2Mdc9RJIsCo7JkdNIVxaJW3Evk0SwEjdNqOX
         7+Y9s1kDnYd8uWU4vJqEOs0kkXWUai12yKHDQMeMeaeGH5ypD3qSLHf4q0HxS2YOKS6J
         VNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725031763; x=1725636563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTbfsd8NvXwzdBfTnE3JqlL7neYrWLzy9hOrmppNIdI=;
        b=BcGClKBLspp6QlUr+QxoQ9LCyPeuWSS2fT2mjrHbszHjNyav1lQZqM7JrGkap/5b9w
         oA6Wn6JAC5L2866FiTTF7s8ut3qeB6Lfsf9UFu6zFuNSDMIaLkopVBvN0pOMcm4jL+qc
         mzUAF/rez3owsYJReMF9w97WTxO7XT/T0xRN53ZCPtDJJeAVrakUUaHqW7+TfeeRn1Or
         360frkFdGicJ7F60QIYJNyG6CSlakNVe1eiygNV8gLSsFoH2p2vfvIrThXkVx+t8ue7K
         uU7AF0xzbXJytOdY5r5sWGBVM7cFopqIoaryg7S677z5drvxpY1T+PEFgPsmWY30Xb1J
         Gcww==
X-Forwarded-Encrypted: i=1; AJvYcCVWhGsfaVp29x0b42fDADSmz6/3UrRITiG6tp17QP5Ktxzb9bi+GKMQ3OxR/yfV8gb0Mmv+6JfJmvqs9NNm@vger.kernel.org, AJvYcCWyGWiOH1qC2T2CRjbfbRTeTr/A1tZ4tpS61OzLMeT6XW9TXRzL9zi/omBCE680X8aqEYaW6HHtMP9F@vger.kernel.org
X-Gm-Message-State: AOJu0YwOEfQmKAeJrBmVbHJ0pq/TRR6PHkXajw9xtQx442twtywoYdyx
	k1xTryS7VkD5fy/8WKFxBDA9UJ72NHe6Fk6gjbWmmjmtRZVmlRIE
X-Google-Smtp-Source: AGHT+IEXGRlQ5gn33om3VWyG+YHGotjBlsNvFVFeEDYCIhlYkI3wne4qPmIsXyn/6trLmn+Wp0F5NA==
X-Received: by 2002:a05:6602:160c:b0:82a:2385:74a6 with SMTP id ca18e2360f4ac-82a238575c7mr412786839f.5.1725031763161;
        Fri, 30 Aug 2024 08:29:23 -0700 (PDT)
Received: from localhost.localdomain (174-20-195-90.mpls.qwest.net. [174.20.195.90])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2eaa1e7sm778553173.132.2024.08.30.08.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 08:29:22 -0700 (PDT)
From: Shimrra Shai <shimrrashai@gmail.com>
To: shimrrashai@gmail.com
Cc: Laurent.pinchart@ideasonboard.com,
	aarnoud@me.com,
	airlied@gmail.com,
	algea.cao@rock-chips.com,
	andrzej.hajda@intel.com,
	andy.yan@rock-chips.com,
	conor+dt@kernel.org,
	cristian.ciocaltea@collabora.com,
	daniel@ffwll.ch,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	heiko@sntech.de,
	hjc@rock-chips.com,
	jernej.skrabec@gmail.com,
	jonas@kwiboo.se,
	krzk+dt@kernel.org,
	ldearquer@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	maarten.lankhorst@linux.intel.com,
	markyao0591@gmail.com,
	mripard@kernel.org,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	tzimmermann@suse.de
Subject: [PATCH v5? 6/6] dts: rockchip: add HDMI0 entry for RK3588 and change VO0/1 GRF compatibles
Date: Fri, 30 Aug 2024 10:29:12 -0500
Message-ID: <20240830152912.9092-1-shimrrashai@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830152132.8894-1-shimrrashai@gmail.com>
References: <20240830152132.8894-1-shimrrashai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index b6e4df180..76cb0f7f7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -582,13 +582,13 @@ vop_grf: syscon@fd5a4000 {
 	};

 	vo0_grf: syscon@fd5a6000 {
-		compatible = "rockchip,rk3588-vo-grf", "syscon";
+		compatible = "rockchip,rk3588-vo0-grf", "syscon";
 		reg = <0x0 0xfd5a6000 0x0 0x2000>;
 		clocks = <&cru PCLK_VO0GRF>;
 	};

 	vo1_grf: syscon@fd5a8000 {
-		compatible = "rockchip,rk3588-vo-grf", "syscon";
+		compatible = "rockchip,rk3588-vo1-grf", "syscon";
 		reg = <0x0 0xfd5a8000 0x0 0x100>;
 		clocks = <&cru PCLK_VO1GRF>;
 	};
@@ -1254,6 +1254,46 @@ i2s9_8ch: i2s@fddfc000 {
 		status = "disabled";
 	};

+	hdmi0: hdmi@fde80000 {
+		compatible = "rockchip,rk3588-dw-hdmi-qp";
+		reg = <0x0 0xfde80000 0x0 0x20000>;
+		clocks = <&cru PCLK_HDMITX0>,
+			 <&cru CLK_HDMITX0_EARC>,
+			 <&cru CLK_HDMITX0_REF>,
+			 <&cru MCLK_I2S5_8CH_TX>,
+			 <&cru CLK_HDMIHDP0>,
+			 <&cru HCLK_VO1>;
+		clock-names = "pclk", "earc", "ref", "aud", "hdp", "hclk_vo1";
+		interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "avp", "cec", "earc", "main", "hpd";
+		phys = <&hdptxphy_hdmi0>;
+		phy-names = "hdmi";
+		power-domains = <&power RK3588_PD_VO1>;
+		resets = <&cru SRST_HDMITX0_REF>, <&cru SRST_HDMIHDP0>;
+		reset-names = "ref", "hdp";
+		rockchip,grf = <&sys_grf>;
+		rockchip,vo1-grf = <&vo1_grf>;
+		#sound-dai-cells = <0>;
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			hdmi0_in: port@0 {
+				reg = <0>;
+			};
+
+			hdmi0_out: port@1 {
+				reg = <1>;
+			};
+		};
+	};
+
 	qos_gpu_m0: qos@fdf35000 {
 		compatible = "rockchip,rk3588-qos", "syscon";
 		reg = <0x0 0xfdf35000 0x0 0x20>;


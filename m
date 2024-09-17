Return-Path: <linux-kernel+bounces-331353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3325197ABB3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A4B91C27B30
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 06:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939101292CE;
	Tue, 17 Sep 2024 06:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbfMy4FG"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7594C66;
	Tue, 17 Sep 2024 06:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726556315; cv=none; b=M8p81B/8P8Fb4RW0h4vaw0OmA0Hj/GxC57qNFNrgx1xlzK8B4a/tSmW9ayJyoqjGk8z44RscrIlqXMacRE7YFMH6I/eShmVz/f9BnlFZvcCNKDSrmbwvK/ecgFEYoUAhWsxpzQdG3zf5e2OOhbQ/ccxFrhMD1FchWeEG1EFQxFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726556315; c=relaxed/simple;
	bh=HvKjEaTed6/+RfsVR4nP0piQihMfmcB16bZRUl8o+qs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ejOPa9lAMRhPu57igV1o3ChavQNY6sS2vRy5dsz87cemTRFfLF0cmZVP9s8+9YJB5DauCKzJZL3OgysrGmqDsyCQWV1ue51fJvJgVsxrHP9nvLn0KOae4CIF9dQSdvQAX1ZvonZZlHpeCCcJrhKaTXjTg+U88t68o58LfDCVA7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbfMy4FG; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-535dc4ec181so4428973e87.3;
        Mon, 16 Sep 2024 23:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726556311; x=1727161111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7wsxkt8kD2tv/Cwg977j2CL2XAhPdhs/VJmk8MeTU4=;
        b=NbfMy4FGHRha1nwE79dqvnR9AtkWh4WYzVf7YTzZ9OkWnf/qVFf/KebkoKyNmjQjAo
         JNNa0Eww8vu9BQamt8VNzTVn+Lpc52Jw+SiUpJ9y5MM0vgVMHG3aBwTCCq3ZrgXf4867
         Ba/GB6RGums06WVZY1OXpXTnC66KbKdGoWCLHnHHJ46KVB9VF6pW1E0aTpmOX2SDO9ti
         wXILlkFEfxFlTKZrPhSAEx0CswSwKsbWfacOD7132YV1MO5QcDhXTgZuvyZWzpJZRyV1
         RKbJsjfExaSY+HDPJdx3w17uvlGCGisM3KI6hpOyp0FzMJxuhfWNNZ6UhqJB0XLj0Tf3
         mtrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726556311; x=1727161111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z7wsxkt8kD2tv/Cwg977j2CL2XAhPdhs/VJmk8MeTU4=;
        b=nik5QGXmb1IUmcsPfWycrEjlugFOJqdRnF7Dsf5c7oItELZQr9KmR8/vpSij+9DtgI
         2ktuHSPlQDvHp1uAD/naLyyy6+0yi0xGWcypOQ/nfmqQLG5at6qgSZxk7DGVzq7Ve/Ux
         wSxVLoPz4llfjVVpaUXM5w+3nCcP3mYqMjOaQnyiHb2Kziptl8YTzTrHZ2d1tWp2iyd9
         2QMM772JVn3mnnSoh1Nz0MopMZQYaHwnrZMe1S6u9VlqVm9JCXtcrXbTPC4mtJq6NrIE
         7hEzo//nR9QQLjcxaM/BdmYFtfCfpQD9kyULnBWxTvIk3bTOJsnxDuW6YNxxuTn9iLdX
         0a6A==
X-Forwarded-Encrypted: i=1; AJvYcCXdMawe4hsJLzmdj2nP//K9hZDl1p1RObSivuyI5ZN3auD4O51nDwCdIAUgMKGQ77SEvQiTntOzK0IL86A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFd+dGa6rU735qvP3KTWbLQQHP0tLRjZGnX5zpKYfo99jfpuLs
	atBE+23KcPmhetVCayXe4hpIakSAmzMD9zOhrYFAuOUAEzDCFlVM
X-Google-Smtp-Source: AGHT+IGkjhSF7e+whaWFPHV7ed3DYwsF94+etu0W20gL9z5Qoa7dvhLLxv9lP4XynRZRJ9Hm9pDrxQ==
X-Received: by 2002:a05:6512:ba8:b0:52f:413:7e8c with SMTP id 2adb3069b0e04-53678fb6a90mr9664342e87.14.1726556311324;
        Mon, 16 Sep 2024 23:58:31 -0700 (PDT)
Received: from ld-100007.ds1.internal (77.119.220.220.wireless.dyn.drei.com. [77.119.220.220])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a90610f4510sm405100666b.67.2024.09.16.23.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 23:58:31 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	aisheng.dong@nxp.com,
	Frank.Li@nxp.com
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	diogompaissilva@gmail.com
Subject: [PATCH v2] arm64: dts: imx8: Fix lvds0 device tree
Date: Tue, 17 Sep 2024 08:58:01 +0200
Message-Id: <20240917065801.2579750-1-diogompaissilva@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some clock output names on lvds0 device tree were duplicated from mipi1,
which caused an -EEXIST when registering these clocks during probe.

Fixes: 0fba24b3b956 ("arm64: dts: imx8: add basic lvds0 and lvds1 subsystem")
Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-lvds0.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-lvds0.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-lvds0.dtsi
index d00036204a8c..dad0dc8fb431 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-lvds0.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-lvds0.dtsi
@@ -14,7 +14,7 @@ qm_lvds0_lis_lpcg: qxp_mipi1_lis_lpcg: clock-controller@56243000 {
 		compatible = "fsl,imx8qxp-lpcg";
 		reg = <0x56243000 0x4>;
 		#clock-cells = <1>;
-		clock-output-names = "mipi1_lis_lpcg_ipg_clk";
+		clock-output-names = "lvds0_lis_lpcg_ipg_clk";
 		power-domains = <&pd IMX_SC_R_MIPI_1>;
 	};
 
@@ -22,9 +22,9 @@ qm_lvds0_pwm_lpcg: qxp_mipi1_pwm_lpcg: clock-controller@5624300c {
 		compatible = "fsl,imx8qxp-lpcg";
 		reg = <0x5624300c 0x4>;
 		#clock-cells = <1>;
-		clock-output-names = "mipi1_pwm_lpcg_clk",
-				     "mipi1_pwm_lpcg_ipg_clk",
-				     "mipi1_pwm_lpcg_32k_clk";
+		clock-output-names = "lvds0_pwm_lpcg_clk",
+				     "lvds0_pwm_lpcg_ipg_clk",
+				     "lvds0_pwm_lpcg_32k_clk";
 		power-domains = <&pd IMX_SC_R_MIPI_1_PWM_0>;
 	};
 
@@ -32,8 +32,8 @@ qm_lvds0_i2c0_lpcg: qxp_mipi1_i2c0_lpcg: clock-controller@56243010 {
 		compatible = "fsl,imx8qxp-lpcg";
 		reg = <0x56243010 0x4>;
 		#clock-cells = <1>;
-		clock-output-names = "mipi1_i2c0_lpcg_clk",
-				     "mipi1_i2c0_lpcg_ipg_clk";
+		clock-output-names = "lvds0_i2c0_lpcg_clk",
+				     "lvds0_i2c0_lpcg_ipg_clk";
 		power-domains = <&pd IMX_SC_R_MIPI_1_I2C_0>;
 	};
 
-- 
2.34.1



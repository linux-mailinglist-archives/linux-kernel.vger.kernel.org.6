Return-Path: <linux-kernel+bounces-332871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC9997C011
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 20:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E4D31C20C35
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 18:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3CA1CA6B3;
	Wed, 18 Sep 2024 18:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AH6Ed4P/"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9A61CA6A9;
	Wed, 18 Sep 2024 18:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726683742; cv=none; b=CPRiCj+K/umvH7/GafXrLx+Z4AybSImiUH60nX5FLPwdNZoPg/dU/kmzlcINugZSK2HNJqsqGcb4JGKWUlclcfbvxG5xyMiODX0cttSqtEGkZSpTrhWExg589pGmIYG/FS6C7lc0tNRN4Ys6KZp/vgFOd8dZDZDJf+4DG7Jv87U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726683742; c=relaxed/simple;
	bh=tPPolANXFudZukym9KFwXomjOeqaddIywz6B3npeFX0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K0rAZ4ooJ6YBJ8rIrhQ9A6oBDoo553V1LKtTYptMBHytH/Dd6NBKL8BkpXTscSxiutJ5yZfhVUm+WRwKjmfDPHf9T39CrjMI924ZsmzbL0u2MFz5PZHOHRiksLTzsdWisPsjCBab7GpWxj5HZgwc8So5WeDmasBoQrb/+WP4fV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AH6Ed4P/; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c260b19f71so18556a12.1;
        Wed, 18 Sep 2024 11:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726683738; x=1727288538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9pnB/66IiiBxwPue9k5AJc8T5aJ3texuVaLDQqQnrlo=;
        b=AH6Ed4P/Yp/YPDCCx1n6Y+eA11jaho2/0fKQk5eZucDGH66ewPeFvf5rUMb37h6bAl
         DNFWxSUeulsQad7h6D8CkpNfKkuSpvv3CyvJCK2m56+vYuctFXTDLgs9GzRs0hhDWnKd
         ohkwr+ammKqooKLsRWDOlwcz16056UTsnZnx9MqMb5qaw9l+rk7vDgqiuikK/54TMTvN
         7CluxOuvsGrVF5sJNaZq1mT8BD77WFjguCTy+fNO+utILqINIeiGuvzjT06XPhWWamUO
         PU+821AYc/Kwj1MHWVqk7FKDyBmgptW7uNMwj76rYFIWIbkphBuy3WalppSZLmqABwvI
         YyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726683738; x=1727288538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9pnB/66IiiBxwPue9k5AJc8T5aJ3texuVaLDQqQnrlo=;
        b=sNi+Wf8TbpM4KiidxVlFD1mt4DN4cy7FYoHH0Rd/Yt0+zlsowhbFxtLfIiVvjxO2mk
         55MilB+/S458pPoRnhcDW7R0gYUrFHlFx24BeeLN7f0HmwDW+xI1BamlXdcDavCDPW6H
         bHpyQJFwsmm210tyQcQc28XeSw9rfiwa2vcWFK8CL5iawi7bz+MfV8+M2Pe/jSkKE9rn
         qQ8hmZWi51RyeHX9k0cGx7YGCrZLatYIDWCzA9i1lBLuQhTpPk7Ro2hRQUBSt20B1gwF
         OUC+WX1X+pDnW53qW4QSa8arruE4Qrk6o2vcn1fJ6wkv0VbtEpeoB8XaQl3U5LJTLbQx
         HoKw==
X-Forwarded-Encrypted: i=1; AJvYcCWLPp912sGC4/7rM7PiQmfSKAa2g3Fi3I/QYW0CvlcTt3qq3gimTQ7Xs4IYKk8yWbratTUfN+0hlV82Egg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6aikHGyIcbNoFKQtj7Zg3M83n6MfQdkI1YZJKYkXgmnpAu6zh
	MhZOWyCWeHdNP8l0+JCxEFdlcz2aql6RJY4/utqfEPUZ/PgjNcFL+wpIz44o
X-Google-Smtp-Source: AGHT+IFLWoD9g3KIUXWE4OYaPCJDDEreIkagIcss6zDxUmRyhLSrCsW3Dv/hxMtDn3gbm+0lHG8v8g==
X-Received: by 2002:a05:6402:321c:b0:5c2:7699:fb6f with SMTP id 4fb4d7f45d1cf-5c413e1fd66mr20241398a12.15.1726683738183;
        Wed, 18 Sep 2024 11:22:18 -0700 (PDT)
Received: from playground.localdomain ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb5312dsm5200146a12.23.2024.09.18.11.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 11:22:16 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] arm64: dts: imx8qxp: configure dsp node for rproc usage
Date: Wed, 18 Sep 2024 14:21:14 -0400
Message-Id: <20240918182117.86221-3-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240918182117.86221-1-laurentiumihalcea111@gmail.com>
References: <20240918182117.86221-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Currently, the dsp node is configured for SOF usage, which
is not the "default" case and should be done in a separate
SOF DTS. As such, configure the dsp node for rproc usage,
which is the "default" case.

This also includes the addition of the 2 optional
power domains which may be required by some applications.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 .../boot/dts/freescale/imx8-ss-audio.dtsi     | 20 +++++++++----------
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 15 +++++++++++++-
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi    | 19 ++++++++++++++++++
 3 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
index ff5df0fed9e9..28970211dd67 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
@@ -431,22 +431,20 @@ dsp_ram_lpcg: clock-controller@59590000 {
 	};
 
 	dsp: dsp@596e8000 {
-		compatible = "fsl,imx8qxp-dsp";
+		compatible = "fsl,imx8qxp-hifi4";
 		reg = <0x596e8000 0x88000>;
 		clocks = <&dsp_lpcg IMX_LPCG_CLK_5>,
 			 <&dsp_ram_lpcg IMX_LPCG_CLK_4>,
 			 <&dsp_lpcg IMX_LPCG_CLK_7>;
 		clock-names = "ipg", "ocram", "core";
-		power-domains = <&pd IMX_SC_R_MU_13A>,
-			<&pd IMX_SC_R_MU_13B>,
-			<&pd IMX_SC_R_DSP>,
-			<&pd IMX_SC_R_DSP_RAM>;
-		mbox-names = "txdb0", "txdb1",
-			"rxdb0", "rxdb1";
-		mboxes = <&lsio_mu13 2 0>,
-			<&lsio_mu13 2 1>,
-			<&lsio_mu13 3 0>,
-			<&lsio_mu13 3 1>;
+		power-domains = <&pd IMX_SC_R_MU_13B>,
+				<&pd IMX_SC_R_IRQSTR_DSP>,
+				<&pd IMX_SC_R_MU_2A>;
+		mbox-names = "tx", "rx", "rxdb";
+		mboxes = <&lsio_mu13 0 0>,
+			 <&lsio_mu13 1 0>,
+			 <&lsio_mu13 3 0>;
+		firmware-name = "imx/dsp/hifi4.bin";
 		status = "disabled";
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 936ba5ecdcac..527933a3eb5c 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -63,7 +63,8 @@ sound-wm8960 {
 };
 
 &dsp {
-	memory-region = <&dsp_reserved>;
+	memory-region = <&dsp_vdev0buffer>, <&dsp_vdev0vring0>,
+			<&dsp_vdev0vring1>, <&dsp_reserved>;
 	status = "okay";
 };
 
@@ -71,6 +72,18 @@ &dsp_reserved {
 	status = "okay";
 };
 
+&dsp_vdev0buffer {
+	status = "okay";
+};
+
+&dsp_vdev0vring0 {
+	status = "okay";
+};
+
+&dsp_vdev0vring1 {
+	status = "okay";
+};
+
 &fec1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec1>;
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 0313f295de2e..9522a65b3e22 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -186,6 +186,25 @@ dsp_reserved: dsp@92400000 {
 			status = "disabled";
 		};
 
+		dsp_vdev0vring0: vdev0vring0@942f0000 {
+			reg = <0 0x942f0000 0 0x8000>;
+			no-map;
+			status = "disabled";
+		};
+
+		dsp_vdev0vring1: vdev0vring1@942f8000 {
+			reg = <0 0x942f8000 0 0x8000>;
+			no-map;
+			status = "disabled";
+		};
+
+		dsp_vdev0buffer: vdev0buffer@94300000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x94300000 0 0x100000>;
+			no-map;
+			status = "disabled";
+		};
+
 		encoder_rpc: encoder-rpc@94400000 {
 			reg = <0 0x94400000 0 0x700000>;
 			no-map;
-- 
2.34.1



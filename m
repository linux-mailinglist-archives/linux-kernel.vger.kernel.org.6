Return-Path: <linux-kernel+bounces-374708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2949A6ED7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 804DF1F21698
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE271CEE94;
	Mon, 21 Oct 2024 15:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvS+qyG4"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7051CCB48;
	Mon, 21 Oct 2024 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729525994; cv=none; b=HSHjzPWCbEZWEP5bmSe1f1ovTEmPtcsxm8nhBbpW5oIXRstN/bItdjNAFIgU1Tr5FUbZlU0T/wtENzz8zkPAlyjY7GMSYNuf5jxrxfdRGkox4szoVEIKbp4TWNwPfx8cJq2ksqhr2YHq6/IkFRQr/BTGR2ALSs/yKk9mdAvecV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729525994; c=relaxed/simple;
	bh=LOVLjthvbNs+8JH4PocahA1b9cBmmHZO0vdEAllJHeg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fp5+JanojmP0Rwi65YGVo/moCGDUP7Bdf6/B2sFkwBy1pMuYoKCtDzj9jtqwuctBIULA0eXJt+D4tlvYYoIdduCFmmNTBj+NrW6IhKHG8G6ARlXoTaqKt/z9SUGnUU0yGYkOfrNkjNZl1lXIJIP1DktOUCFOlt38Gb6P56kAsjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvS+qyG4; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9a0cee600aso586544766b.1;
        Mon, 21 Oct 2024 08:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729525991; x=1730130791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CuD770AfqfA3+1we34OBIdyNk7AWxBeNDLvWt4wIKKM=;
        b=DvS+qyG4ekABlPtwps1Dx8lEH+6XC60eDi87sVUX1cDPt6wzYDFpvgWgVbELDjF+YZ
         QKHjK+2rdeeHqAyt2RVi2cX6czsUCOGBi4K5aDtX3TDxDLOAO1acdHzhY29tiCYh8re8
         /QODPmenX+nI0wVmmN3b7Ko/EFAWTc7gOVTAmXJo5aEWfBJYcWnKLGgln02cyp95ioIw
         3DsbIiiAZvUy0KYirSoGrTnp/jSdpgGuDAAqA+kJWtwGpgf6I8+71dUNa0ZORq6vQ0c8
         fNO7xVCdGDbokObKpupFBQB23Afk4aohZ2nDFwxpy1EBWQgFbo6dO1lPeQYKgg40NHIQ
         NQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729525991; x=1730130791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CuD770AfqfA3+1we34OBIdyNk7AWxBeNDLvWt4wIKKM=;
        b=XyZrhfCqLsmVumkg1yRXJ7cCsCye2GN+YeCEmu4FWUwsaViR8hIs55qPqFTMSs7ayK
         zj2lyE0SVPDJGPMQZkK6XQ98eQpMc/WH9IUz4xeXnraTR/TeJLk1TJal8wUngf75g7gN
         aQEQLPRGv0EoMOsOTRHKSm74P/JgrptAhc3zUs9+j4U10G0+93bq54J57cRlhdjmGzNn
         ogtA5y7+rObmxQ3ExnPadQj2K83uB+GPWCeLe+S+Ej/xZoD/Sev3Bxv16Q686ZNAVP3Q
         ZimyEfeJ6/8S382ifRHXuLuI8lxDsYsY1EjSkjt0QD148Wqh9CN7qPZ9FSwS07qQWQrp
         1JMw==
X-Forwarded-Encrypted: i=1; AJvYcCXt58J3ez3qvnXVgQDz9z6b+WXjuICDPGCQrtcHJ2x8g987gnst6nEXbmD2AdRY6/s6sKV2EzlTHnbiRH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvjOp/LDkePZyL2E3/6JVoQ0yqfOlIe6YPPS/bb3h8MWNeBSBR
	FHGf8EVpFJwcjkkovdCc5c0EabPEyGHYX+Zp6QfpSWR23yq0gLmV
X-Google-Smtp-Source: AGHT+IF2yoAl368N+XO3JdI5vISlD5ad11UbPnetJqRjyiBddDG9lg6QDzjrGFMhrCckyRSVQHLPig==
X-Received: by 2002:a17:907:9693:b0:a9a:3cf:cdb8 with SMTP id a640c23a62f3a-a9a69ba6e93mr1093227666b.36.1729525991109;
        Mon, 21 Oct 2024 08:53:11 -0700 (PDT)
Received: from playground.localdomain ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912edfd0sm218614366b.67.2024.10.21.08.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 08:53:10 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>,
	Tushar Khandelwal <Tushar.Khandelwal@arm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Frank Li <Frank.li@nxp.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 6/6] arm64: dts: imx8qm-mek: enable dsp node for rproc usage
Date: Mon, 21 Oct 2024 11:52:21 -0400
Message-Id: <20241021155221.112073-7-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021155221.112073-1-laurentiumihalcea111@gmail.com>
References: <20241021155221.112073-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Set the status of the dsp node to "okay" and assign and add its reserved
memory regions.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 27 ++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 62203eed6a6c..d51da3b6b3aa 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -92,6 +92,27 @@ vdevbuffer: memory@90400000 {
 			reg = <0 0x90400000 0 0x100000>;
 			no-map;
 		};
+
+		dsp_reserved: memory@92400000 {
+			reg = <0 0x92400000 0 0x1000000>;
+			no-map;
+		};
+
+		dsp_vdev0vring0: memory@942f0000 {
+			reg = <0 0x942f0000 0 0x8000>;
+			no-map;
+		};
+
+		dsp_vdev0vring1: memory@942f8000 {
+			reg = <0 0x942f8000 0 0x8000>;
+			no-map;
+		};
+
+		dsp_vdev0buffer: memory@94300000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x94300000 0 0x100000>;
+			no-map;
+		};
 	};
 
 	lvds_backlight0: backlight-lvds0 {
@@ -640,6 +661,12 @@ &sai7 {
 	status = "okay";
 };
 
+&vpu_dsp {
+	memory-region = <&dsp_vdev0buffer>, <&dsp_vdev0vring0>,
+			<&dsp_vdev0vring1>, <&dsp_reserved>;
+	status = "okay";
+};
+
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
-- 
2.34.1



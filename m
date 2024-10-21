Return-Path: <linux-kernel+bounces-374704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F8A9A6ECE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4CC1F21033
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EDB1CDA18;
	Mon, 21 Oct 2024 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnu7kVxT"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AC91CCEEA;
	Mon, 21 Oct 2024 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729525987; cv=none; b=kmUyIdss3I1hL6KabGoi9hT+fPb3ACfue7yR8WZw822bk8/lZpEWCEqJVGSl6FvTTB/fggkYgS7l1zxdMFbVBu3f2HuEC5xjmWea/CMiTvga5+x5cEkk4IeiYlzHqkK5+nYqTyfU4UMxlNkelbNiPyimrMIRDkmaFwPtEBDeWdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729525987; c=relaxed/simple;
	bh=aHNIg5OGX+TEVsp9sHHJ9mDSCCmiLBrqL7nScghLPQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X6wQADHTdgyXJH91ayeltVPL6u3eE24q+kzBUTLX2ruE7V7cqqLPaSPbezbHxDdb26uc42vHtZFqoXpVF34lTayoZUYddIMggLHNxzGBBjpNwF3xQPxojH8ef1RrKuVAWdpboDLz1YbfRqtmWfnpZAinG9fGqFxt4tdA4Jy2vb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnu7kVxT; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9932aa108cso680850066b.2;
        Mon, 21 Oct 2024 08:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729525983; x=1730130783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8NU6xaU+/gHYs3WP937bfG8Ssm1Eyb+DSVQQgrlKdA=;
        b=bnu7kVxTI36Ttr1uwK1KO1VoTcy5jUgn2vdp8mobGUY9QVSY4NCxmy0185uku0VC4L
         MfZxGMwsOITTntQ8Ifejcm4bJPvAcm5sod318ynGdzmu+rTcz7AOPlQp9cP/lYY/7Z+Q
         1CGHaqLP3C/XKh3ruUYZk+NnRZrKvdzBkSR4N1ebmhB+pUH0plGMTFzDDWyL1NGQLNcy
         VcVXZe6g7/WnsP2fmVgwgQg2OsD2eWCrSKPCSkc2tnv+QZ5wVdWeGshQkgLrNMvOBa+c
         vSncZbWElikcpu2HQN40KtxU72mHbhdAf2BL2wQJp2F6hL4MEhbShHMbw96llAd6JqnV
         /Igg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729525983; x=1730130783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T8NU6xaU+/gHYs3WP937bfG8Ssm1Eyb+DSVQQgrlKdA=;
        b=dPM+6BCuFT8HBkldwp0P8x/63zZvHqvzoWtJdT4Vba89HY89tz4nYL5hNvaZztyJvy
         HHDKpPqh4A0/vaQg4QhqQhDin3utLkdP87WvVIrcdnOce8C3oGU10Bkla2A6nrHI3j9U
         sF+tRGfmTgLLr1iieFx1qe4bAD0eOb77XZPss4v1l8HzkNhj5dBerJztXy5z+9ocIhlQ
         BfdmvktyXEc0MS4E9LrjPH+8dI+B57CgoogfbcB9wIwRANvBTfojKG3P3V8eHVp5i97C
         sxHVDoOiXd2tyMqNSw8/Pde8mOnpfd0+BIZTyTYX3EDBouAAD9io273H7plIukgv28hM
         ad2w==
X-Forwarded-Encrypted: i=1; AJvYcCVkS3NFCZpUPfEvuUQyhT2el2MsnIvEh1T48dEVuMGrlGR5uYSxVZtwXLsd3PjBteySn2QvNxTypCwI8CM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPc6kw40ZfWc1tVe1jft1seQWVRuQLLPrTd933f0NlH8u7+7yB
	SERllcHjfzxqUV0E+XChuxLy3dc+EmChn5GFQwx3l5G7UvMg2/6h
X-Google-Smtp-Source: AGHT+IE7VmTplSzaBge5LnjVsaDHPckhTTbMQH/FFB5snlb+eRZHFk6ZJLJ8QNK5VZw5GdOB9/5Klw==
X-Received: by 2002:a17:907:7ba0:b0:a99:caf5:c897 with SMTP id a640c23a62f3a-a9a69a752c5mr1147624966b.20.1729525983134;
        Mon, 21 Oct 2024 08:53:03 -0700 (PDT)
Received: from playground.localdomain ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912edfd0sm218614366b.67.2024.10.21.08.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 08:53:02 -0700 (PDT)
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
Subject: [PATCH v4 2/6] arm64: dts: imx8-ss-audio: configure dsp node for rproc usage
Date: Mon, 21 Oct 2024 11:52:17 -0400
Message-Id: <20241021155221.112073-3-laurentiumihalcea111@gmail.com>
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

The 'dsp' node is currently configured for running an audio firmware.
Since the firmware requires that some audio-related IPs be disabled in
Linux, this will clash with the configurations from the imx8 board DTs
(i.e: imx8qm-mek, imx8qxp-mek, etc...), thus making the dsp unusable
(since the firmware won't function properly).

To avoid this issue, configure the 'dsp' node for rproc. This way, users
will be able to use the dsp alongside the board-level audio configuration
as long as the firmware doesn't need the audio IPs.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 .../boot/dts/freescale/imx8-ss-audio.dtsi     | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
index ff5df0fed9e9..a60ebb718789 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
@@ -431,22 +431,19 @@ dsp_ram_lpcg: clock-controller@59590000 {
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
+				<&pd IMX_SC_R_MU_2A>;
+		mbox-names = "tx", "rx", "rxdb";
+		mboxes = <&lsio_mu13 0 0>,
+			 <&lsio_mu13 1 0>,
+			 <&lsio_mu13 3 0>;
+		firmware-name = "imx/dsp/hifi4.bin";
 		status = "disabled";
 	};
 
-- 
2.34.1



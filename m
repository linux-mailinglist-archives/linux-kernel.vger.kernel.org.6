Return-Path: <linux-kernel+bounces-309821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D703B9670B9
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 12:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14F171C213A0
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 10:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B12417BB08;
	Sat, 31 Aug 2024 10:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="joxfg+wU"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986CD16C854
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 10:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725099097; cv=none; b=sjb9CBdH1nan3YXsD6/kFBtDJQY/jd2ZLvA7hBKPFSFgScISL+KIet660TXTEasWFTZ2Turh4WgDVuDtu4fmqTmZrv4aclmNRnkNZUMidIrrDCxb0AGdZf0zJRQO85aZtaRF02j1Agtg/Yks211C0woH6DdEvIsLBcEV9ur06R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725099097; c=relaxed/simple;
	bh=eK9lwHTGrE9nYN6gnIQ8mYnUNzrrnjm32O0cFnJTIKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q7nhx2qxopEGja5qiuthk8a/sKXmIj1YvJYmHCf5An4PyQr+Cn47pqS+MDnDllgXEhwS8lPglx1F0cvINC+s+F79Pt3cZX52XIvVt5tWG+Ye13a23CD5DscKofUNk4BGHb+QRNSQsuMZc9Q/pLlFb8h4xbMqj6A/W4HB11U6kNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=joxfg+wU; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c243ef5237so90288a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 03:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725099093; x=1725703893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HB1tlgukKY1KvsXWQTxeELXSE2pe2uY+begkTD0612E=;
        b=joxfg+wUU8v1TZmwm1Rf9r9TdPBUNw4ZFrQ10iw8LjTng1TLE4FjUT2TZ1xU20Qvdz
         WHklzz+SzIspxoYGBbrzsYOnqYQ2Gipgoi5q0gcf4Rqq/ulRmPK8X6Wyagovn6kMeGLU
         wf4/K7hcLyP5sTer+tUIxjjMOV3BpTxBef+lE1PBeQ8D8PkRfQdq9g+zQUG7RN6xZb/w
         FoSjfqgdZdrN1n0bUkVCR5Y3gh0u3d4aLty8YHOFwAtYMPz8mAY/ilYP53OZnEV1rD31
         UcyhPIfRVMNWIsTfT9G+SP5ZR+AdxM6j0o1aDreNrQ+cP+qfC4IPCpIBx0Fu38eewhJA
         DYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725099093; x=1725703893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HB1tlgukKY1KvsXWQTxeELXSE2pe2uY+begkTD0612E=;
        b=hFzVlxxPJj+6dfMlX3OcbliTStGii5sEqf6AvglpQHxlwT9aJv72uBvXnXOAtAQine
         QQBiw4D4Vy1WupDCwCjFLr5OSW2xtoy4qrvw5twZAl1ROAMFP+UtZKxQBJqnZBLKbd0Y
         UV/fTDdIJYCI9Ot3JV0in0nYYtfmvwuck0MX1A99DeZMxVOx3pzQJYXEgn4hKlrZ07kb
         kk1Kl5i+/zSz22bs2rgwmRXFP50UINhJ8qgk+cvrsRi4VUxYUcuk4bfuEINTrm5c7sIW
         3vJRExkB95RFGoP81KoiAkdh5p42e9m3dpCx45s+l5pXlayNFw6jjRPIgFf81D1zSSrA
         ujkg==
X-Forwarded-Encrypted: i=1; AJvYcCWoazitOR1ZyiDqH2/ZBx8uiQuESmM/e/xfeN6gntWPtYeNW2+EzbP0u/ErnLQWOVd+38SejAy3XvLmc2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIoOX9sEwCwfqxRaGyM5/sdrJX/c1rdz+9nt+BPqsatQ/vfQXR
	n+NghPWJ7yPqs7Da+ar0nDSCWRLXouJ9qzbGovKnhbLXajH6dQ4C2nFuyjQpU3o=
X-Google-Smtp-Source: AGHT+IFwVGnm/EKQ8MW41lLfc+/EkRKkHINcUVfO3ryyMSVQwViKKq7XhFYFirZ0oz/oMNb/3Yf2CQ==
X-Received: by 2002:a17:907:3f87:b0:a80:ed7a:c114 with SMTP id a640c23a62f3a-a89a2ff7874mr144197666b.0.1725099092826;
        Sat, 31 Aug 2024 03:11:32 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988feae4dsm311707266b.31.2024.08.31.03.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 03:11:32 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Matteo Lisi <matteo.lisi@engicam.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Parthiban Nallathambi <parthiban@linumiz.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: imx6ul-geam: fix fsl,pins property in tscgrp pinctrl
Date: Sat, 31 Aug 2024 12:11:28 +0200
Message-ID: <20240831101129.15640-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The property is "fsl,pins", not "fsl,pin".  Wrong property means the pin
configuration was not applied.  Fixes dtbs_check warnings:

  imx6ul-geam.dtb: pinctrl@20e0000: tscgrp: 'fsl,pins' is a required property
  imx6ul-geam.dtb: pinctrl@20e0000: tscgrp: 'fsl,pin' does not match any of the regexes: 'pinctrl-[0-9]+'

Cc: <stable@vger.kernel.org>
Fixes: a58e4e608bc8 ("ARM: dts: imx6ul-geam: Add Engicam IMX6UL GEA M6UL initial support")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts
index cdbb8c435cd6..601d89b904cd 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts
@@ -365,7 +365,7 @@ MX6UL_PAD_ENET1_RX_ER__PWM8_OUT   0x110b0
 	};
 
 	pinctrl_tsc: tscgrp {
-		fsl,pin = <
+		fsl,pins = <
 			MX6UL_PAD_GPIO1_IO01__GPIO1_IO01	0xb0
 			MX6UL_PAD_GPIO1_IO02__GPIO1_IO02	0xb0
 			MX6UL_PAD_GPIO1_IO03__GPIO1_IO03	0xb0
-- 
2.43.0



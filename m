Return-Path: <linux-kernel+bounces-329834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3E8979683
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 13:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B379B22331
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 11:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AA91C68AF;
	Sun, 15 Sep 2024 11:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grWTU6BJ"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE351C688B;
	Sun, 15 Sep 2024 11:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726400705; cv=none; b=NTswAGsImU6hBPwxx5pqADDuOWedpOX3Sd+zm6mqSX4tC4fm0/hQPITFWwdqQXgp5vy8QiZ9VkMLq8vCzhsC6Y5covNWDP624+f/gPrAc2YFxNjKINkSbW4S9T3imFVGlHV8Yh8dozk04FOPKszZ37F08qzGaNTNsLE9nYihD3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726400705; c=relaxed/simple;
	bh=trGYvef1NRcTImv2sKMZbzFz6CbygD17mBnDSAM+jLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q1CmtQNzd1zEJQFZrJaCCcBm7xFGJ5EZaPH6df7heip5wPeiOot5jh+eHet2DPlPzt+WeehrgYHaJZ02mihpy5RKVDWkNANVDm84wb9FCi0y8F2+j1IuxXgqhmWXgbTMjZXASnY+Z0y7xHJcPNUoMWaBXGcHD33+8QCpZ9v+b7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grWTU6BJ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8d2b24b7a8so841787866b.1;
        Sun, 15 Sep 2024 04:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726400702; x=1727005502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0P2hxKwdxVDqMdDwluWUiTWf66FQH3XHEjGda3h0CiY=;
        b=grWTU6BJuyyqWh3TkGrVle9iUw6d6vG70qGsMyyprmtiRkl+SMmHwOAkUEZ4miKf8y
         3IpfTLmtA4soWGhWpQ0KxSedv+/GTd8VxSzEvcG6+LfK1mYs5TEjPk2C/XR/yYF1E6OW
         eDtkeE4xTPER/AwRT/XALrIBxsqTgAbUTDU16E6rTDc+IUzud9fIgqWt+boGxlzby3kb
         pVYTTWtPr7UC5Rirxp0nzpZBvdu5yI6AeHmUDOmyqWkaCmDW1L7Zi1ZuJIJDQFsyHz4M
         UYNfA2OHAwMG6iFU5Yt523akYFrn5TUEWB4sWDTULBgDrsINDrXXaXG+CJ4YDywT+W8t
         gjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726400702; x=1727005502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0P2hxKwdxVDqMdDwluWUiTWf66FQH3XHEjGda3h0CiY=;
        b=OS+DNVKbPWziOGx+1vcfh6RTWupjK8zCFHBqSv4wfuJze9dHn56T5PTAb0n+VGHoZ+
         E3Htgk28OaybPbWuV1f6g4z8+eIFpzuynAUFQ6pTrs7iiqXte0v0JBEYVrH+1lS/2Xw7
         USwgvEgyckoogTWfl7INaXi1mJtFizGA2j7k1H8MUIQVb0743Et4FzYzzL1pb72yNrpB
         U/WlteHqcWPDZdOr99hxQ/uvoOWMmzTmFcCDUKpZmij/qwcsQxyhgjqa6jN97t37sOlh
         c1k+ZA+C0CVRtx7YgBkEyLonvDv7ha3Av+9GtZPIHDugy3z+ngy6O884oqHNguDBHj2f
         L0bw==
X-Forwarded-Encrypted: i=1; AJvYcCWX20DVHqIOBme4vH18vDGkZSeNmi9s/tRaNzlZfbkFB6px7eiyOtTwcnHxURP4Ute43Tr4DJf+ypBkzQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAPiH4aSZ5tOEArv0W5MjNR1PM3iVkCUxfXvo7j7Z2xBTH49Ui
	S7r9sh8v6OO8rxjxp5tayxwWn/KaNFs1RpT0jpZDR0aPOdhnUsaD
X-Google-Smtp-Source: AGHT+IHQUf1QLxUkSnrIqQ7HPP67wJOXZ12chmF4CZglFGMRIxAR7mfoNhBT3K0qO2QgAqcv/UJ4Yg==
X-Received: by 2002:a17:906:6a1a:b0:a72:7b17:5d68 with SMTP id a640c23a62f3a-a902a3d11e9mr1210434666b.3.1726400702032;
        Sun, 15 Sep 2024 04:45:02 -0700 (PDT)
Received: from playground.localdomain ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a906109676esm188778266b.33.2024.09.15.04.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 04:45:01 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
X-Google-Original-From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liu Ying <victor.liu@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] arm64: dts: imx8ulp: add AVD-SIM node
Date: Sun, 15 Sep 2024 07:43:11 -0400
Message-Id: <20240915114311.75496-4-laurentiu.mihalcea@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240915114311.75496-1-laurentiu.mihalcea@nxp.com>
References: <20240915114311.75496-1-laurentiu.mihalcea@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add node for imx8ulp's AVD-SIM module. This also
includes its children.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index e32d5afcf4a9..1ffa4da23042 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -614,6 +614,19 @@ per_bridge5: bus@2d800000 {
 			#size-cells = <1>;
 			ranges;
 
+			avd_sim: syscon@2da50000 {
+				compatible = "nxp,imx8ulp-avd-sim-reset", "syscon";
+				reg = <0x2da50000 0x38>;
+				clocks = <&pcc5 IMX8ULP_CLK_AVD_SIM>;
+				#reset-cells = <1>;
+
+				mux: mux-controller {
+					compatible = "mmio-mux";
+					#mux-control-cells = <1>;
+					mux-reg-masks = <0x8 0x00000200>;
+				};
+			};
+
 			cgc2: clock-controller@2da60000 {
 				compatible = "fsl,imx8ulp-cgc2";
 				reg = <0x2da60000 0x10000>;
-- 
2.34.1



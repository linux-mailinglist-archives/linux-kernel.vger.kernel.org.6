Return-Path: <linux-kernel+bounces-207365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCFC90162C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 15:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E33272814DC
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 13:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3B34597A;
	Sun,  9 Jun 2024 13:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1EGoU1P"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723E13FB8B;
	Sun,  9 Jun 2024 13:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717938081; cv=none; b=uxm5/HZ7msrIIVJxcizm6Q0O4Vpd0wOTNi5f02qC/4mwOZr9DZ67frn7UCq/p/P2wqh0iCMLlTPRvujUORfSpKO30p2ms9aAij0sUmXooGkNqroLM2pZjA7dhC+ZTE4Vw8Odoi7d/Njb+PTjqUbxwFt4bSJ2a0OEuidfYxt6HXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717938081; c=relaxed/simple;
	bh=yy9gl9pQz3F5fgfnipmdtFV0zJl13QipSJnEg+3xNDo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tZVOH7aPuTtLDy+68+QzMUcatqWfiDycMIY6BFgBZ8ys9xGnaJYMA/g7Ti3XJPh8CvYTn+oqLKnVTGnf4z1YBv6erRK6r+VxvpyxwCXOA1kJ1GaEpik4FTxNtphN0Kga3U864lN2Rqz/LcLDQ1wlva5KVtvbNX7P/stc7LZj9Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1EGoU1P; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57c6994e2f1so702546a12.0;
        Sun, 09 Jun 2024 06:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717938078; x=1718542878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXLPtmmwbw0kH9maBt8kI0QUZhZ3U60BovT7L6yY3xs=;
        b=D1EGoU1PLHH3cFzHh+GYb2QTmuE8TD9nhRf6WHxSWOKBIhOQzReTTjSqJB9c/zydkL
         zkPIQ9CjGUZppPHQIpfHcgd6Wy6Hj8LadRQLE+VzAd+5hTw0etk3x9S4fXxl0i8QImZ9
         TExwTcKMUMEi4K0Pp3LtTLGOeLF+aHnZyNSjDwXvLhiY/Lx7ux5A25KRc3StC1TVYcL2
         UbQQnZHAX73KKJgFZBZ7xB1VwZlGC7vBCBDFOFBsB1MHXZbZKpmquIbueuRgyZ/Bx4o0
         0B2ARj7s8dGCmMb94n1WgM/6NJFsA5yakOg2PB5+ec/d4eWxJyAt12oBuIQPvd3D92X4
         fRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717938078; x=1718542878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXLPtmmwbw0kH9maBt8kI0QUZhZ3U60BovT7L6yY3xs=;
        b=Z7//TI5yi4NjIp3/bZlTWRkj9ct7Mh3EKssAT49tmqf00wRHbwpmYrgYA1mUMn6Eyi
         K1PSVMPYUINk8Lm5udtK57w2PjZCFA72/hGvfqQcNDesu+TBiwxLXfPwgwFcieQVI20/
         EqVp56JEJqhSOzp0/N6OV8I4SkdBRQac9ZCPh01sFNihMkt/xj6X3lYEWTG6q11HOcWk
         uhVE8QcXSYp2NVsD7j3eiB3SXJCYiHLrWunslDPleRxQ+iJ3TTw74ZYczwTGSHHVP6GM
         EJ9ezOk5q7Ab2SO2rdyjPEZ3BjTvY6v5z3/usEz61bFvZ1unJl/WU6dDAIUuJS8KaDHV
         1o6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtcTLe1/EzL39sXU5ZuyK0ubyb8MlBNrpkdQGAOrhduPciEZKrw4DQ/nd1zzFfsKi+4EGPHyhYjz6V/o+4pVlz+fl1+VHH8X3uVanR1U+/soedBMP9i7/KodvDXsSXRwk0k9montyu+Q==
X-Gm-Message-State: AOJu0YzFIu8uoSPBlPCq2MhVviRgB5bMG+7ej4NEE52XEm2xJeDe2EoD
	fY85f+ikEsHRoUaiodDCYreVYY1Wv2pYBhnA+UtztS88cuHYcmLC
X-Google-Smtp-Source: AGHT+IE9cuXF727TvRThgldcemuwA9M4zGggMb69uY2vp+iF779s8nKt7+bEy+hu202ctfIWzJUajQ==
X-Received: by 2002:a50:c308:0:b0:57c:6d89:eaef with SMTP id 4fb4d7f45d1cf-57c6d89f0damr2532005a12.18.1717938077578;
        Sun, 09 Jun 2024 06:01:17 -0700 (PDT)
Received: from lmc-playground.localdomain ([188.25.209.252])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f1841fceasm85961266b.70.2024.06.09.06.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 06:01:17 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liu Ying <victor.liu@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: laurentiu.mihalcea@nxp.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: dts: imx8ulp: add AVD-SIM node
Date: Sun,  9 Jun 2024 15:59:01 +0300
Message-Id: <20240609125901.76274-4-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240609125901.76274-1-laurentiumihalcea111@gmail.com>
References: <20240609125901.76274-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

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



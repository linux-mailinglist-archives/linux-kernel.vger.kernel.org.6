Return-Path: <linux-kernel+bounces-252845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 542779318C0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 18:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F316A1F21F84
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E511454724;
	Mon, 15 Jul 2024 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nChWDdjQ"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CF5219ED;
	Mon, 15 Jul 2024 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721062010; cv=none; b=Sng15hTj5z+OFWswOWCo3drc6x0xcBj/Me+MlGszDz/QuyA1aIvDbs8hpmz3KOvVxDyckQ7bYxdGST/9Q+Sbc8QAoitBId42IDLph9kr2JCiuHYdIGs2aOXuJOzZeZDo+U1JiFJvFTb1DQFiuIecb6WwPVjLi6aTi2T3n2/Q3OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721062010; c=relaxed/simple;
	bh=yy9gl9pQz3F5fgfnipmdtFV0zJl13QipSJnEg+3xNDo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RapbzH/TZGD2VZ0mMpaotkbtABIM8On0ucSUb5G2aNe0K9pRvU5R2kow++ji/9Qb37cdDUX6L0JIB4zjUEpDLG6je8woz+fBOeGFgoUlaiYNZWgLbowVRDXaLVEK/pmVpHlx1Gpb9pII/WmEBb+r/yEiaCd/hsKKCHZFvp4fEis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nChWDdjQ; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52ea33671ffso4588976e87.3;
        Mon, 15 Jul 2024 09:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721062007; x=1721666807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXLPtmmwbw0kH9maBt8kI0QUZhZ3U60BovT7L6yY3xs=;
        b=nChWDdjQHkPTo0nhrHAyVU9Opg/2lM2TjwWUMFFcoM/ebvpt6gjlXX4ZBGctgxomA9
         YRYCm+md1R3R9qFvlAJgDwasHyErgrzyPp9k60I9kbHX2D8l5PSBpb8pd1YoZ2yBYrHm
         R1OmANjV8xOMyccYMuWE9APD6UTTRaI1WB5mkQauQczvljEVZcQ07zWVsmtIYqXgos/L
         wGUsERH4PhwZXXgUisrmprteXcmIjO82pwHnKER9HVybkis7EFdZZrVuMSjBril+wOVV
         hm+zhGmsJdh5vVlNXTNlRMFwxmV9aLDae6QGD/Hc+KROqwhb5EHFuQgd7SXghK9gf8BH
         lacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721062007; x=1721666807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXLPtmmwbw0kH9maBt8kI0QUZhZ3U60BovT7L6yY3xs=;
        b=tsoivWyZejPJd0vyAKimgJ/S48LUYF7Nol5cBQKqn8MiVr4PapdhMRxE5qEb/7g9d0
         OUY1IZvb677WLidHoAh1/njom1/E/Q4o5gfgYHi4ZAaaa9Jwaqjd4JsJ1yovQruKMBVD
         WH+ekRhUtxh5wOD4B4tV+A0uou5VeMCYBSCbWxJVjIMoG9KiALuBuRZKErMX2NgeG550
         kCOgPAnVVdENefQtGbLbx5y8X4EjW05hwo/EmBaGbFrpFmvOXMLTSjomPsvL9GRL6Z5s
         VK9/FzwclM+hie0Z1jJLPJUaO8J8h0IschecianC2JaohXQ7eBsZS5TrEDgz8bImnFOM
         xEXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQClTvdbIcdHph9zUvcMPq+/7M54PTH9gZJTRdIHqVxCM7Xo6wRaHcm9UQenwmMOgNzE4KLfBc0aYuQz8y+ffWvF4RdHT65ncykn+B
X-Gm-Message-State: AOJu0YzRJch9JJ7WLyum59hztxT0FcX0gFL74SNQFtqzwBwFqoIxhhVx
	2Zj89hCD4Qm45nkb3lhtrmUC1KFO4N6h9Xkd+6udZ8CGZVWEOTuN
X-Google-Smtp-Source: AGHT+IG72IQ0ziiaJH2CaciU0vlZKlLL8khi4i7uyxWcd0QoI/uPAG9YPE4h/aM4tCxzi/2HTELIUg==
X-Received: by 2002:a05:6512:e9b:b0:52c:dfa0:dca0 with SMTP id 2adb3069b0e04-52ede1c782amr51714e87.43.1721062006412;
        Mon, 15 Jul 2024 09:46:46 -0700 (PDT)
Received: from playground.localdomain ([188.25.209.252])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5e7749esm94316975e9.2.2024.07.15.09.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 09:46:45 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
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
Subject: [PATCH v3 3/3] arm64: dts: imx8ulp: add AVD-SIM node
Date: Mon, 15 Jul 2024 12:45:14 -0400
Message-Id: <20240715164514.8718-4-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240715164514.8718-1-laurentiumihalcea111@gmail.com>
References: <20240715164514.8718-1-laurentiumihalcea111@gmail.com>
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



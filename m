Return-Path: <linux-kernel+bounces-197882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF0A8D7052
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 15:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B03E528429C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 13:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF14C152516;
	Sat,  1 Jun 2024 13:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mzh4rCvo"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6634B152162;
	Sat,  1 Jun 2024 13:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717249962; cv=none; b=M7o5Kookte8gleOrfY7TMM8lcCDaP9atNmFzbWZlrfdwCSzey8y8uC71AOPJa6UBUazHVwtEKnVUuyUrjPNFPtaHTB3fO9vAreigeqypOlIwYkw3X1LpSGxdB0tNrxyzXcYgyd/ZXNskwqJfw6T5e8F1owesjnpwM3B5sAGgJeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717249962; c=relaxed/simple;
	bh=1Dgwy0Q+GhrrVZfVCPhz54VGa+v3vTl0ATIGpU3b1r0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FviM5bqqkFLFy2id9tvAP0la3zuSy+zPpLMhy9c1/JhPXIDYIE/PS4Y9BT16CLrCKtR/LS+14VCpC+txGS1LGKk82Qq2EiXmVujlxRDo2Gozo8s3/SadJDqcoThZJW0urJXEFGZUw1bmN0Ml+rChEkNlDwIlQPb12MqpcQ6Q7ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mzh4rCvo; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-374599be371so9513785ab.0;
        Sat, 01 Jun 2024 06:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717249958; x=1717854758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGka72aXhHw6B/ugmJ5D8SFrSBdPwgiFasgjGAhEvSI=;
        b=Mzh4rCvoXFT9cN7iDwxjrxjopj3sLwdWqit2s4+em9lDkF4a+gMTZuTeUGUrzOKcvF
         U0cGBEE5aQ+edq2VWprNAfXlzWWU5u0nlI6iyemeABS3/HlwQwvRG/yZlUkoMfFdJeaQ
         BqpHR9ygS2fCvQ4ZHUt5mFhs9VB5y+bZwwQlGupFNZU0PzP3fsgTaJ/DiGslH/qe7uuk
         zse+k4arB8skBreb4ml5PeMuXeSUFqUeHgH7O0du43vxhNOnFhZJV9lmJwVXf5UGebIY
         fLxpnXokLrwVDxAMuQTjIL6VpjAaYQyZZvX1LFMBNN3YAcu7b3FkLab7E2Ab3dnoungv
         WCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717249958; x=1717854758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGka72aXhHw6B/ugmJ5D8SFrSBdPwgiFasgjGAhEvSI=;
        b=XOPFjH8CB1mk8KA4QW7gmCON6mOjxgayiYqyspPBnr76grPEt5uykLcD3e859c4zfT
         KA0aBswqcASVFQ/v2kFnCKOdfa4luPEiQccNYr8RcgDvTrcf30Kb8OxUIo7DYQrYCl9d
         e4JjqBJF7InwEqRd5GXjLl2LYjjV3uYdDqeyQjAIxy+J7/DmMGZu8iPlkrNVUqHbN3uF
         aLr3ElX6iihV2hKASh+zL5xlKP2JvcWRKVV00iwv9uRW3I7yjEVLJYJt7jgidHbm3ruv
         n15muCtQMmkZaGnrMJSw6rFeLjlBv8YmE7aSDwrDFUgyEiykU3DOq/h8AmmdNLPIgMXh
         uF/A==
X-Forwarded-Encrypted: i=1; AJvYcCXhjbaAn1WlSe/ZX88nBx1NXfjDSC9kkxe15dvR8Qfdx6m00PpXdCKKMFVI4o3CfvcWdO5xKP/qbrXM9uzHJ8zh1qgMmTfJHuXoGv41MlGbDP5YfagyIHEkKoHXf4+JZ+M3g2HYvJeEWA==
X-Gm-Message-State: AOJu0YyUdRAmlAsVEP8jItecn7Ytpeu98S7ABjz68E6YL0NQSe4+V6KN
	8NLLNtQhBrGLVUxIE8kKPmT/Ux2D9Ujz3ycfLivx/YkiI/HLP1iJ
X-Google-Smtp-Source: AGHT+IHNarKWZy9HAtQK8XU6dQr4Zrxypy/AD5KjenkEvnfFzfikvYAeTK9czkeEyJLIysD+wU5U3A==
X-Received: by 2002:a92:cd8a:0:b0:373:1137:cc1e with SMTP id e9e14a558f8ab-3747e20bf3fmr60551865ab.7.1717249958498;
        Sat, 01 Jun 2024 06:52:38 -0700 (PDT)
Received: from aford-System-Version.lan ([2601:447:d002:5be:e0b7:c613:ee:e8f3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b56e7824d4sm556349173.172.2024.06.01.06.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 06:52:37 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/2] arm64: dts: imx8mp-beacon-kit: Fix errors found from CHECK_DTBS
Date: Sat,  1 Jun 2024 08:52:29 -0500
Message-ID: <20240601135230.89980-2-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240601135230.89980-1-aford173@gmail.com>
References: <20240601135230.89980-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The adv7535 has some unnecessary entries which can be removed since
they were not setup properly anyway and the defaults work just fine.
Removing them and adding some required regulators make the errors
detected from CHECK_DTBS go away:

 reg-names:1: 'edid' was expected
 reg-names:2: 'cec' was expected
 'avdd-supply' is a required property
 'dvdd-supply' is a required property
 'pvdd-supply' is a required property
 'a2vdd-supply' is a required property
 'v3p3-supply' is a required property

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  No Change

V3:  Update commit message, no functional changes.

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
index da836172ae46..5c4b68c18bb2 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
@@ -302,12 +302,19 @@ pca6416_3: gpio@20 {
 
 	adv_bridge: hdmi@3d {
 		compatible = "adi,adv7535";
-		reg = <0x3d>, <0x3c>, <0x3e>, <0x3f>;
-		reg-names = "main", "cec", "edid", "packet";
+		reg = <0x3d>;
+		reg-names = "main";
 		interrupt-parent = <&gpio4>;
 		interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
 		adi,dsi-lanes = <4>;
 		#sound-dai-cells = <0>;
+		avdd-supply = <&buck5>;
+		dvdd-supply = <&buck5>;
+		pvdd-supply = <&buck5>;
+		a2vdd-supply = <&buck5>;
+		v1p2-supply = <&buck5>;
+		v3p3-supply = <&buck4>;
+
 
 		ports {
 			#address-cells = <1>;
-- 
2.43.0



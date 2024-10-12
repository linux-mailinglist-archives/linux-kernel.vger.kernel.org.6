Return-Path: <linux-kernel+bounces-362494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B4699B598
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 16:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77CD8283A91
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 14:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702D519CCFA;
	Sat, 12 Oct 2024 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NX7zJbNO"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B2119C548
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 14:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728744028; cv=none; b=WAbhodYcjjazXVJuzIqNYWBo49l+yvvKeU093VQg1RAo9mGYYPT6LRdaYSbTsBjtBXNoyL9cEQHfKBCm/stiY21HI++XUg8iRUZH5fhD3hxT23yhH4baheJqM6McnkqUW9boxYabJacgL4ZcdWLgbqH88VrPkaJwyeaHAwo2U04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728744028; c=relaxed/simple;
	bh=B9BqpeoJguVWS7gI+XD6rHIo0W/hrym3/3+lBaC2IGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f7x+mrCOYAhpRLTLbtSKqYlYTXeQvRpFMqpCSSkGLgZzWD4HTXSY2/PTV8XG9gRGGuFQow4ihP1aiWEjrn5+WxTSSp5anXZr3at+SxTj0iGXd0U4JF7W3WYXdVMMAUd3wRqUPtXZqyvZ+Yqf3yP66q0nfumUHeeooMYRawFQ+B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NX7zJbNO; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a99ea294480so63761166b.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 07:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728744025; x=1729348825; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gttVsMS4Fqvh3Tt7h6KmD5HQ1g1j9lzENne/NicL/Zs=;
        b=NX7zJbNOfbKf/KKnMOH3OzSOSHkRmtG/aoKuZtiCfTLcopL0ILWVOszScAvOnIEF/x
         2FWkB8s21SINy/cVVwabh8yuLrO88ayke2aMwjjjNM/mfSzUGG0FQh85PMBIuwQ7yV0s
         n5M3DwkmHe5yW/NQSiT+pH2Y2H6XOHkPs3JTbxbhcg9HqS952H2vxMtYcfi74Skjx6dt
         ZgIgjkoyjxibJVoRWSM6PI4aCyi6FDeW/TF9KCP2psrtgeTpv8rJdDV5ecgF4gaseFUW
         cSohS1033Y28wr6884d40D1jS/o31qzQT3YFjhdssaKQC+k95aFCQ62Sme+fHQL0hCTh
         B4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728744025; x=1729348825;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gttVsMS4Fqvh3Tt7h6KmD5HQ1g1j9lzENne/NicL/Zs=;
        b=Tv6t7U1hd7LDXNaRmtITi1KpxRUmQ1p2tCgJgvOw3OCSEhjkdwwarXeGE9F/ND9Gim
         deWLdbUsrQ0QjPYlpXMfLjyUU+jHBvRwHQ1hxpn9mWinwsLa9mR4+BebIVmTC84XryZY
         biogrmGT9zHpuxLoRvTYLtYwpDuDFsohkxROGDBBaopT3Qucdftcgofa783us8T9TXHB
         dl0iVUyzDmVAw6/6yN28+EyyFy7T2kxhS9oEgZiK8A8xsswl+d5VOCj43RP7s0LQ+WZh
         hZOdQSruxNO9d01mAmF0ajhZRXCIGSmIkx5jMqpfnLdu1gDvV0IoilSv20a/jsTj1IIF
         Z35g==
X-Forwarded-Encrypted: i=1; AJvYcCVR/Zm2SWh726xS3xuQHstEAXvE3KIV/XTNFwi1KkGqzLYyLwAn+/4fgNonNEKTEzxmVG4TP3IWpZvTe1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXgdjoKR5DoG/eEkkLYpe9B0kERZXYtIkA4fMl+n75ea40nc55
	Ur0I/iewnoVsr0hQo3+uZHoiXusgv4Mi8UXiPVHEnDhJguQKjJH+LaWmgWE3K8M=
X-Google-Smtp-Source: AGHT+IHt5b4bByB1WvcuC38k97IWVU58hfVMsjj5FiJWbVwYm1/FeLRBTfW/P+tmVBSwJRaQRUR0MQ==
X-Received: by 2002:a05:6402:40c8:b0:5c9:34b4:69a8 with SMTP id 4fb4d7f45d1cf-5c95ac09860mr3965894a12.6.1728744025513;
        Sat, 12 Oct 2024 07:40:25 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83ae:2517:2666:43c9:d0d3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80cb013sm328446266b.131.2024.10.12.07.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 07:40:24 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Sat, 12 Oct 2024 16:39:31 +0200
Subject: [PATCH v3 5/6] arm64: dts: ti: am62-lp-sk: Add vddshv_canuart
 regulator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241012-topic-am62-partialio-v6-12-b4-v3-5-f7c6c2739681@baylibre.com>
References: <20241012-topic-am62-partialio-v6-12-b4-v3-0-f7c6c2739681@baylibre.com>
In-Reply-To: <20241012-topic-am62-partialio-v6-12-b4-v3-0-f7c6c2739681@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Anand Gadiyar <gadiyar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Vishal Mahaveer <vishalm@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1333; i=msp@baylibre.com;
 h=from:subject:message-id; bh=B9BqpeoJguVWS7gI+XD6rHIo0W/hrym3/3+lBaC2IGI=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNK5utxEp3dO6Us5KRkTecpIP3rpPckzfV6XN1V8ltM4O
 avp0X6xjlIWBjEOBlkxRZa7Hxa+q5O7viBi3SNHmDmsTCBDGLg4BWAiU08xMky9qLng0OL70vHO
 t45nefrmlZ6pfP1YZt2SqfxTfy8QO5LHyDB97YNZf1KYS0M+7/u57mBcRdhGgzOSMpyT3TR/8WR
 N72QBAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

vddshv_canuart on am62-lp-sk is used to power a few units specific units
of the SoC that remain active in a special low power mode. Model this
relationship explicitly.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
index 529360b5e6fe052dd99f04b74c129193922f76ac..783ad65e6165ea74010c3240069fc6d99a0cd035 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
@@ -80,6 +80,17 @@ vcc_3v3_sys: regulator-5 {
 		regulator-always-on;
 		regulator-boot-on;
 	};
+
+	vddshv_canuart: regulator-7 {
+		/* TPS22965DSGT */
+		compatible = "regulator-fixed";
+		regulator-name = "vddshv_canuart";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_3v3_main>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
 };
 
 &main_pmx0 {
@@ -242,3 +253,11 @@ &tlv320aic3106 {
 &gpmc0 {
 	ranges = <0 0 0x00 0x51000000 0x01000000>; /* CS0 space. Min partition = 16MB */
 };
+
+&mcu_mcan0 {
+	vio-supply = <&vddshv_canuart>;
+};
+
+&mcu_mcan1 {
+	vio-supply = <&vddshv_canuart>;
+};

-- 
2.45.2



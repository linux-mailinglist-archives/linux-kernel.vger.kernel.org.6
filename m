Return-Path: <linux-kernel+bounces-362493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D46FB99B596
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 16:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 121341C215E5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 14:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2670195F17;
	Sat, 12 Oct 2024 14:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ITYfrMzt"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422E8199FC1
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 14:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728744027; cv=none; b=cqaSmc6hsea/j+XIDdWgxPfonmhxqT/RtNlIFZEKlcF5EZQxYj+LPanfNfSY2k4SYvW2fUipTLv6dSA/KnoB/bF2vxYiOWaz0g9APqw4yUrl5An1/PlsolKE617pcqeDWy+WFAjmBCjIQjTictAFypq5VanDuoDq3JuV5yyzqlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728744027; c=relaxed/simple;
	bh=XhzApypE5f+qCrdy/4fKvPPdyBST0xn9vF9MGvotmC4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hdhT69F+gj5Hf34dlFontiEgCC45TID+4c5+f0sv1hq4G/guJKYS5xzfZwJXiCdoJ2Bx4M+HPRM6zjoUmSn1qxq4n4Z4PN+4PrVwJwb5tDa8N8t7+Z6YH1/Lt6au2nrlMFf5sDmeE27eGzp4Uz8Xvmj7/9TsJUf7WVfHjzyd9Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ITYfrMzt; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c928611371so4139841a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 07:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728744023; x=1729348823; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9N1QRWG1+vGqch+tHQPBAnNZwJAl+Fys3rUYZOZKJwk=;
        b=ITYfrMztTNroca9k/qIOS2xCVyaMqOpdXPkAF0GwiMOHgLDFJVrEXC38aGuChA3DN0
         Er0ILh2eZitIqp8zEtVkjXB6+bl65iv31r9OggfFW29lZYZv4Vs1TL+5KQNuwhT/4hLg
         Nj1zKiWkaCGY9rcFlgkFOu5GNfH6wVapVFDEutNs/fdS5hm54SawiyD/Xm/YUagrO1A/
         AXnWRwHcKNevFGq6ICETyStnVYNAAFhV+U0oTB6wkh89YamyVgpoZEtmjyYnU2JxCzoq
         6Bw6AA+Vd3+F2L1FNK5FFNufXonmulRvy+x1qRijrEcAzKjk4KSWOhLJ7n+QqPjcvIHk
         9JnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728744023; x=1729348823;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9N1QRWG1+vGqch+tHQPBAnNZwJAl+Fys3rUYZOZKJwk=;
        b=DH3vq3YXUoNDEOuhGyqjb5R2jOu4B6vEK2Y8kXfJP2KeBYY4yfeEQgn75Q5mgIaFkS
         g5W6wEi6NPnUb+jYcFaW8EB++bLwMi8g3ZY2gKhyxlfcCOcgaJ6dtK2mX/LzjTXm2ajr
         K5iHVH7WmSt2Ye/QJ72Tax4Ot+l0ios9lEDUcRQUcGfJfrSNFfJ9/brnIY8JaqZna32Z
         sF4Zpo4Tp/IrKTxr3GkBbMh/E8RXiLAVsmiZYVwdV1IfFD7EMlFqCL4eXDc83Jh0ksaP
         1rv8gpF//+9PiGHSbEOmnfE65xVGmm3/TAdPe2oxexw4+epQxCs0vhZ55eFsvvQ25Whq
         BfWA==
X-Forwarded-Encrypted: i=1; AJvYcCWrxvf6xe62ddF0riCN3WdiiOkiHsbhpVmaNd1xkpqFuXJPZjHIgKF9KlEjm5K7cKQm2DpPYwPStX1ZZ/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrwvba/417d/jiUcIIZGevAsG2ifj6NGqPqzOyli4xfQ1PwpZI
	i3JHeHwuTR7vNZbS/8Mcl9HeTOBFAOJju4K7HRUeTc4rTPi9F7NDcLeSOi2B9rE=
X-Google-Smtp-Source: AGHT+IFB/80TsoIFcqOP89wUuKPAaBM6QE7qOspyWm7HaILKW2tXt8EZeLi+xkFDPhSFFTfLKDwO9g==
X-Received: by 2002:a05:6402:42d4:b0:5c9:4281:451e with SMTP id 4fb4d7f45d1cf-5c948c88378mr4204260a12.1.1728744023446;
        Sat, 12 Oct 2024 07:40:23 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83ae:2517:2666:43c9:d0d3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c9370d22fesm2905032a12.19.2024.10.12.07.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 07:40:22 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Sat, 12 Oct 2024 16:39:30 +0200
Subject: [PATCH v3 4/6] arm64: dts: ti: am62-lp-sk: Add vcc_3v3_sys
 regulator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241012-topic-am62-partialio-v6-12-b4-v3-4-f7c6c2739681@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1572; i=msp@baylibre.com;
 h=from:subject:message-id; bh=XhzApypE5f+qCrdy/4fKvPPdyBST0xn9vF9MGvotmC4=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNK5uhzdZY6nmczOe3lfMv7Imklsn4+8eJuk97Xwg2aR5
 KbnfNrvO0pZGMQ4GGTFFFnuflj4rk7u+oKIdY8cYeawMoEMYeDiFICJvI5i+F+ce/demWLfp8UV
 m3Ywsyh0Cp9Yrr/qt1Yd4+JJghss799mZHiXGDxlHrf5ddeO2zYrr/M57Ohdx1pw77p58Z9PRz8
 tOMgJAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

vcc_3v3_main is currently modeled slightly wrong. vcc_3v3_main has a
parent called vcc_3v3_sys which is currently not present. Add the
regulator for vcc_3v3_sys to be able to describe other regulators in the
next patch.

Fixes: e6a51ffabfc1 ("arm64: ti: dts: Add support for AM62x LP SK")
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
index 8e9fc00a6b3c7459a360f9e1d6bbb60e68c460ab..529360b5e6fe052dd99f04b74c129193922f76ac 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
@@ -34,10 +34,10 @@ vcc_5v0: regulator-1 {
 		regulator-boot-on;
 	};
 
-	vcc_3v3_sys: regulator-2 {
+	vcc_3v3_main: regulator-2 {
 		/* output of LM61460-Q1 */
 		compatible = "regulator-fixed";
-		regulator-name = "vcc_3v3_sys";
+		regulator-name = "vcc_3v3_main";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		vin-supply = <&vmain_pd>;
@@ -70,6 +70,16 @@ vddshv_sdio: regulator-4 {
 		states = <1800000 0x0>,
 			 <3300000 0x1>;
 	};
+
+	vcc_3v3_sys: regulator-5 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_3v3_sys";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_3v3_main>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
 };
 
 &main_pmx0 {

-- 
2.45.2



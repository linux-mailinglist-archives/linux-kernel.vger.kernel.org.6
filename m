Return-Path: <linux-kernel+bounces-304034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C849618F0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 23:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42666B224D5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 21:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7241D4161;
	Tue, 27 Aug 2024 21:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rqt3zNZv"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5DF1D363B;
	Tue, 27 Aug 2024 21:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724792488; cv=none; b=JQdguhDRUApXEDRz0/RLRVC4IcdGYtc+dJON36XXqgenOPaipFsZZgaIZG5ldnLFxiEXNHzzLRybxXSAFo9ezvUNm17lhEHbJtaJs7ExEaq+ZrLJ9mSArOQv2tudmTSgB4FicYffIs2B8gekdQmLQMffOLl4UZi+ax76EHPcuDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724792488; c=relaxed/simple;
	bh=RNhLy3kONeDz/+IGq0BW6Nukk5PX4HbKNZTyiChMq2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u6etgfwtW0tg+83uLwhUebdasvWG605YU9eH0VW4q7IPUOGXmqhpPsB9shX7U+3XfplriEYuO+vsIUJWdj7MU2YWTa6A+cOnBxOqVnh7AG9Cj7YCO25eO1QNPormUdg4YUMax1O1ED2TB5XBHIxR/aYKs+Ek/qVpN6nEqGYQTg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rqt3zNZv; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f4f2868783so55431531fa.2;
        Tue, 27 Aug 2024 14:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724792483; x=1725397283; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oxD/2bn0T/dFXzCPoiChAlaQk6ipCE9icGUJFuoXA1Q=;
        b=Rqt3zNZvqDYP8pKxKsWk4zP8m++mnZgb3+wrAu+jM3pdxsJAqpzARmKbGSspneBb1Z
         DRNdYAs0wvcN50YAyNZ8hiZWoofptZ3tvHEBXmZ+hH22gKnQXi6v0G7AxHoP+OzIql98
         XNCQfP0cuu+LxGFrzhCOFmSeOXkvGR923doSx1nt/u9gtSYpHHJtCB/7g/G8GglP5px+
         evEEGbbICl/aXODhz4BeTIJiwkC/FhJxxAEtqIPgIK13mYgZxyBcoHMxm0M2s/NR20+J
         ejqSTRxp1L0BgznK0QlsJJLACT04cbM/jNNArK5cPX3qkjeQRNlbH2A9n8VG1bmnzLuE
         zxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724792483; x=1725397283;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oxD/2bn0T/dFXzCPoiChAlaQk6ipCE9icGUJFuoXA1Q=;
        b=QgSZkmy0I58A3N5CNJ0p+BAJDjjWITfx6masactRPjvzocCScs7k8XLrZE2jaMQ+LG
         jsrvX3SL2D5IYbCF/sNpKQ3AlR1tkQNSyQDDlPTVx6a+g1/mld4dnRquDaEPKELVsiBc
         aFo30AsuDbByW5RkyiWBp2aAbijZryc7ERkScMI442g5uEfAaocTEjuI0YmLOAkImAr+
         egyJhJIOAsO+UuM0A+WJ9p44cHsz8YbFX1/QvyEwGout5CxWvvsklhpFEY8NfR60zi7q
         Vk5Xaaq1Qt/D5pKiFv+IVvie5pl3/xhPuTCidVU+MLrhpYfp2GMDOOV9RdtdCmg0F6h4
         6iMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGLBzIck8mY8rKzKqpcqjs5+zzBuXNTii1GSuMDh+GVHWYjAS139w0juItc04sSs3969Ez29OUKUh7dl4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu4SjH9QOx+eiCzylV6jU/Vs7JY2wS0LOnyDVb4mNT8tm79nN7
	EX+RBkNYDI8cOSm8QwdlFH0cbW0qD0xzU4jjo4bHZnHiSHEpyuX6/Xw3EjMabKI=
X-Google-Smtp-Source: AGHT+IHMIJqq+qMc5SFSWqS83HaQQxSJIoBoIh0xhJc6PI4T9xwpLUgf2R1siupu5MnfzMii4vuZpQ==
X-Received: by 2002:a2e:612:0:b0:2f3:ad82:53fd with SMTP id 38308e7fff4ca-2f514a44f48mr23852671fa.28.1724792482231;
        Tue, 27 Aug 2024 14:01:22 -0700 (PDT)
Received: from cleve-worktop. (85-193-33-82.rib.o2.cz. [85.193.33.82])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb1c3114sm1405835a12.13.2024.08.27.14.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 14:01:21 -0700 (PDT)
From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
Date: Tue, 27 Aug 2024 23:00:43 +0200
Subject: [PATCH v2 1/3] Fix NanoPi NEO Plus2 regulators
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240827-nanopi-neo-plus2-regfix-v2-1-497684ec82c7@gmail.com>
References: <20240827-nanopi-neo-plus2-regfix-v2-0-497684ec82c7@gmail.com>
In-Reply-To: <20240827-nanopi-neo-plus2-regfix-v2-0-497684ec82c7@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724792480; l=2036;
 i=cleverline1mc@gmail.com; s=20240824; h=from:subject:message-id;
 bh=RNhLy3kONeDz/+IGq0BW6Nukk5PX4HbKNZTyiChMq2M=;
 b=9/Mx2+cAHE81RhNqFvprgXDsszsk21dvPoYTZw5zCCYnSpD3rhc7njBnEaHii6djEqcV1725u
 5hpQHzHHVJxARzZQUiinsjRclqW3BCgVK6jlV19RzVEPptPlcYZu1vJ
X-Developer-Key: i=cleverline1mc@gmail.com; a=ed25519;
 pk=CQifx5FUgTQKAoj5VCYrwYHi235AkXQ5yT1P6gkaBxM=

Added the main board 5 V supply regulator,
a 2.5 V supply regulator for GMAC PHY IO and correct vin-supply elements.

Signed-off-by: Kryštof Černý <cleverline1mc@gmail.com>
---
 .../dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts   | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
index b69032c44557..dee4cd82636b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts
@@ -45,16 +45,40 @@ reg_gmac_3v3: gmac-3v3 {
 		startup-delay-us = <100000>;
 		enable-active-high;
 		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&reg_vcc3v3>;
+	};
+
+	reg_gmac_2v5: gmac-2v5 {
+		/* 2V5 supply for GMAC PHY IO */
+		compatible = "regulator-fixed";
+		regulator-name = "gmac-2v5";
+		regulator-min-microvolt = <2500000>;
+		regulator-max-microvolt = <2500000>;
+		regulator-always-on;
+		vin-supply = <&reg_vcc3v3>;
+	};
+
+	reg_vcc5v: regulator-vcc5v {
+		/* board 5V supply from micro USB or pin headers */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
 	};
 
 	reg_vcc3v3: vcc3v3 {
+		/* board 3V3 supply by SY8089A */
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		vin-supply = <&reg_vcc5v>;
 	};
 
 	vdd_cpux: gpio-regulator {
+		/* cpu voltage regulator MP2143DJ */
 		compatible = "regulator-gpio";
 		regulator-name = "vdd-cpux";
 		regulator-type = "voltage";
@@ -66,6 +90,7 @@ vdd_cpux: gpio-regulator {
 		gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>;
 		gpios-states = <0x1>;
 		states = <1100000 0>, <1300000 1>;
+		vin-supply = <&reg_vcc5v>;
 	};
 
 	wifi_pwrseq: pwrseq {

-- 
2.39.2



Return-Path: <linux-kernel+bounces-570822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1164A6B506
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C31B34806E4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4131EE001;
	Fri, 21 Mar 2025 07:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYg6zzb8"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668631EDA1B;
	Fri, 21 Mar 2025 07:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742542121; cv=none; b=LvU6eO/Kb4qJBSJuWFGDRtgsX5SljROMlalVfx0yAQOK0WZsjX5FTiMLAoO/8r1CJjdKmW/YccHTEszaWbUaIPUJRJjiQ9xzpbTR7tdnAffiLt8PedjCK0KZ6gxsFZ02F5SmYRCyCGdXjSIv6jeq/9NPZDTa5GnuirZ6zMjgdUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742542121; c=relaxed/simple;
	bh=2rDyUX5mX4sDiO8XhZEFmbAdAa78bSLytJVw4UPc5d4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BgkZyprKL4ro5sOeDNG0wG2X4MMPx3XcS5gmJV00EvsgfpJOrebcM3jKnm43G9E/HhLmNzjAjuM81GsCCBHXI0Vr7kM7ImbDTn9VKQqSIV47wHgnGEraeN4Od8wb8T0Fc33XW3sflLBdS7hhPZspY6PNIp5cQW7a3Bkm7rZUNgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYg6zzb8; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22398e09e39so33457615ad.3;
        Fri, 21 Mar 2025 00:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742542119; x=1743146919; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BS/TmVUgFRyZOyjVnszJqpF/8S31xxnZs1Y2Qe+EyN0=;
        b=LYg6zzb8PY7afgamOPhSfKyFF01VPdvpyKegdSsOnkMMTU+l8+YC3qyorTkAj83JkN
         cz6JyfVdXHsXI5BqB8T08Eb/3BfiGyU+B0LZbDeyzP7xfVBIQkmi4Ha+2NNazhGSKq4k
         aPe6HL0yob4IHDdceYw1HHrtFRSmBcMmfur798iyNLBK+ykmvtwxh+kiWTnA0LypuLWt
         OmnGc9Px90feGPgM1Iq/FT/ZZ7VI+PCjRMS12+53dYJhib+AS8faCx//ROOCQ6ro3x3N
         FNny8yHpOnpcOVt4MqcNckJ7S+UKjYwo1lYFx8TuBEQE/G8FWkAkzoUfbJc7mVh9qAW6
         zyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742542119; x=1743146919;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BS/TmVUgFRyZOyjVnszJqpF/8S31xxnZs1Y2Qe+EyN0=;
        b=SZAXnSE6qdmq5AJUKC6eaunnYWNw4DF62RM8X//0fUliPdQ/425wrRIMWlwgWjR248
         nQzWZrYX1/Bo7ZPUbXhy0zZd3LMNoLQW/tmi57mKMmVsMLsGnLSS3+L3eeB6ZaL+P2CZ
         doA7sZConuQSBvg1qsgFdz7xoayVHy3/qnTXyF/FhBd3FlLiFvobqG9Ip0JP4SR5W4WG
         COKFDEEp4Y2pyYGCj0yQlKWM/INZ71nhda7L+VGszXWrHemva0a28fn26xQHJ3i5Ghjv
         zwD2pumEfzDsc7uyDCvSZkKu6Do432U2WwKmdWni6FyCHUTCOyIRMkDfxvzbATC/yyyK
         LjZw==
X-Forwarded-Encrypted: i=1; AJvYcCWdqLNoK7CxQXUAUp3wQW+AOpfNKY1vt/4X8n1/5M4UG5hgu8syQSwMktzLyGDLD3jUaqse1MfTELdsDyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4UxmHhH59e+/XC7lyoMpY5w2AgPJ4jioGQrY5qwkQvyxijHGa
	cu3BgYVkI11jbNihXdpiJ9vAAm0t5c9dgsSKS2fqYNr6nW1VbYhv
X-Gm-Gg: ASbGncvhLtFCPcx8dCwS7K512/xM3LBDB1jJvJnRtBv/TqYnWSBtyQHbMo3sGU3g3jk
	FHXp0ElzDIDawmH1CMBgTb6OXYjbWw5ABeJTDB/CEUQ69/jbJbQ5YX/sOT0T5bD5o2HL/jkyjtG
	mrrfSpcoI2RSKjkTuC3OVDCLM18fg9UHJpFK1iteNF4qOJgjxYzJL613r0VzL1jVVwgzlwRVEeV
	Ir+uysUTl9IeiRdOr8g+YxcTH6on9OK8WXbYW17i3TRFTwtJEgocBpUVnDB/V1CrnwAzywxOhD8
	T7z65jlzHt2Az9kzanE41+A16poJQrii1M6ZFqKVtYy6p9I+NrVbS/rf2Yd/ODBjANoeWt/NhV0
	9aDD+bmYtWOf9xebjPFk27Q==
X-Google-Smtp-Source: AGHT+IHTntVL00x9Ot2AtrftECNKQGtuavdLeqMD3j9ehPfSEF0bdNza6lVh0Gk1ZXq42/xU5C0Akw==
X-Received: by 2002:a17:902:c949:b0:220:da88:2009 with SMTP id d9443c01a7336-22780e23fcfmr29362215ad.45.1742542119351;
        Fri, 21 Mar 2025 00:28:39 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f396fasm9862265ad.27.2025.03.21.00.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 00:28:39 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Fri, 21 Mar 2025 15:26:06 +0800
Subject: [PATCH v6 05/10] ARM: dts: aspeed: catalina: Add second source fan
 controller support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-potin-catalina-dts-update-20250102-v6-5-4bd85efeb9b4@gmail.com>
References: <20250321-potin-catalina-dts-update-20250102-v6-0-4bd85efeb9b4@gmail.com>
In-Reply-To: <20250321-potin-catalina-dts-update-20250102-v6-0-4bd85efeb9b4@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742542103; l=2501;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=2rDyUX5mX4sDiO8XhZEFmbAdAa78bSLytJVw4UPc5d4=;
 b=m3Q7dfRD9bnw8tKiRxDF+GNGHdX4hLaO9nLnypaLt9IE/146J8937vtLCgJBp6r36hqN448Ol
 LT8oNDoehWPB1MJzmGWlPMUq96YhNi1gl7ixdFUCAY2DOz8Rsp3Ymvp
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add device tree nodes for the NCT7363 fan controllers on the second-source
Power Distribution Board (PDB).

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 76 ++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 792b739b1103..f0c8aca152e7 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -467,6 +467,82 @@ i2c1mux0ch2: i2c@2 {
 			#size-cells = <0>;
 			reg = <0x2>;
 
+			fanctl2: fan-controller@1 {
+				compatible = "nuvoton,nct7363";
+				reg = <0x01>;
+				#pwm-cells = <2>;
+
+				fan-9 {
+					pwms = <&fanctl2 0 40000>;
+					tach-ch = /bits/ 8 <0x09>;
+				};
+				fan-11 {
+					pwms = <&fanctl2 0 40000>;
+					tach-ch = /bits/ 8 <0x0b>;
+				};
+				fan-10 {
+					pwms = <&fanctl2 4 40000>;
+					tach-ch = /bits/ 8 <0x0a>;
+				};
+				fan-13 {
+					pwms = <&fanctl2 4 40000>;
+					tach-ch = /bits/ 8 <0x0d>;
+				};
+				fan-15 {
+					pwms = <&fanctl2 6 40000>;
+					tach-ch = /bits/ 8 <0x0f>;
+				};
+				fan-1 {
+					pwms = <&fanctl2 6 40000>;
+					tach-ch = /bits/ 8 <0x01>;
+				};
+				fan-0 {
+					pwms = <&fanctl2 10 40000>;
+					tach-ch = /bits/ 8 <0x00>;
+				};
+				fan-3 {
+					pwms = <&fanctl2 10 40000>;
+					tach-ch = /bits/ 8 <0x03>;
+				};
+			};
+			fanctl3: fan-controller@2 {
+				compatible = "nuvoton,nct7363";
+				reg = <0x02>;
+				#pwm-cells = <2>;
+
+				fan-9 {
+					pwms = <&fanctl3 0 40000>;
+					tach-ch = /bits/ 8 <0x09>;
+				};
+				fan-11 {
+					pwms = <&fanctl3 0 40000>;
+					tach-ch = /bits/ 8 <0x0b>;
+				};
+				fan-10 {
+					pwms = <&fanctl3 4 40000>;
+					tach-ch = /bits/ 8 <0x0a>;
+				};
+				fan-13 {
+					pwms = <&fanctl3 4 40000>;
+					tach-ch = /bits/ 8 <0x0d>;
+				};
+				fan-15 {
+					pwms = <&fanctl3 6 40000>;
+					tach-ch = /bits/ 8 <0x0f>;
+				};
+				fan-1 {
+					pwms = <&fanctl3 6 40000>;
+					tach-ch = /bits/ 8 <0x01>;
+				};
+				fan-0 {
+					pwms = <&fanctl3 10 40000>;
+					tach-ch = /bits/ 8 <0x00>;
+				};
+				fan-3 {
+					pwms = <&fanctl3 10 40000>;
+					tach-ch = /bits/ 8 <0x03>;
+				};
+			};
 			fanctl0: fan-controller@21{
 				compatible = "maxim,max31790";
 				reg = <0x21>;

-- 
2.31.1



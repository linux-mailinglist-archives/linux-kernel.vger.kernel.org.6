Return-Path: <linux-kernel+bounces-568439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F71A6956E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C1393B934B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEF91E5710;
	Wed, 19 Mar 2025 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ws3rrIn8"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6D2204C36;
	Wed, 19 Mar 2025 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742403011; cv=none; b=X/UMNWhIfq6gmtpIdD55jN9wCSLoGI79YRoOm8NC2cvDSyXPYTke+WGeGvNBPOkOZC7bA3uGJ+Ii09ZTob6hNnLGtlYsjPBoeR5OxVMuWgwkDvG2zrMy7Jr91NnHGiNCC+0IS9M8dDXaa50ULZtQ5qL9d7BDwXuPCLdjmunullQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742403011; c=relaxed/simple;
	bh=VwzUdaWLbo+jZAMlNm4WzSN7aYJ6nvuUMBx/RwUbPbs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UXMws2/4DuuVQZhjeCm4veKUolbg/iVRkPQrbwwvUnHjpjcgO/FONLfBI2VzgOADFIXMizKwDmds/D2EB9LQYVSP/HQaA7OXiPvJzdKUlXf3LO9AWJcj5h1eXXBjADNSpLAKj8XJo32CJf8mpP0ael0AQHbfpZdhttCV/UAuTro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ws3rrIn8; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-300f92661fcso8017070a91.3;
        Wed, 19 Mar 2025 09:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742403010; x=1743007810; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ngZTefyBGyxy77j50qn1xy3c/VWYHIJSa1eOUcrG18=;
        b=Ws3rrIn86CY9RbuQf2cjHyPNJUvf3lIptAX54XY7PQRrzis7GKccp+wjaLJxvJQJ70
         7CZbNrLC/T9mxgv/WEwsPgrwYG54p+qQIERVMMdkTKPxLoB2zvdtbx6DIdhaVPE7yLtJ
         MCk7WfaTlfx0b6lxGL5qwCmMeWpcVjzQo8aBKOGl3oya/Gz38Jj67WXJsO1H2pWr+qse
         H27Kz4BJGzMoqtnuGSArhV1w3/XeAPekHFZB8UoKEFEwuS98a8n/Ge/70hOgog2Z+g9I
         1oSFeJ4KN3HGuRd/7WF+CY2A1LErq4TjqSkDMIiReRpQv4iTeD2MLEh5777CFFvy8mbW
         12Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742403010; x=1743007810;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ngZTefyBGyxy77j50qn1xy3c/VWYHIJSa1eOUcrG18=;
        b=olQ2178n0RUbmWw496QmBLxBJQe0RDTtq7FY2LuUfe4SUVy44PApGbKPfir8UVvHkw
         iia6ZI/O1O2NB4wR6Rj50PUnnxgpsI8viB263UhSwTDUeHZfcYqq9pDQKIUKMV3IL44s
         9yZriy8ToHwaYr6TrlcB9LCYp8dHGJhHWpA/B8xo+/taQiUFCwJ1KA6P10hyo5trlhys
         coRg8sFU+MtQH02mBSVG3Gar+eB8q4fMKp8Jp2K65cUthahWIcZBUprllyfgYekrMDXa
         9AoQ5s7MNtrpNMqLtgcmsDU9FejwgAUGPj7QuIXbtgIVQUfDZsI/h9gvAEXwqVCdo3iZ
         fVJg==
X-Forwarded-Encrypted: i=1; AJvYcCX8yNcy9WDnnRj5P+EONAijEAxn3Lg7tPsz+vp8oM40bzQ7K1HViERJC3/XidfQKe3xYdhJGVRXqfOyVi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxniKITr7wcFZfH8PjG9DPMoTapJOtGWEig5wq2M0fWuLerlpIh
	2FH908640Sjt8TDLcwR/W6JSlB9D4q7iwUKufbGdmSPxg/bsr1b5
X-Gm-Gg: ASbGnctNHIcboNObiDtjUfg0K9o4OdVSqHzF+gmiGQ9AMq3TUZMEiA2OAm2Q973QJ8I
	wYMgdLDYaYRk3ds7V6xxlGGw4OP00MqA2GUcYOJfxqBgu0p2amJgUagJv+ptN+onDepkCD6OwVK
	HbRIrNlMNuert6equHJSZHslMrfb2Pas+8GHeZd2C3ygoKAAf2BlColxaJ8VVNq577oBKwAo0SR
	V71Ki70VSjRYbEwfoGowS1Rx3i8lulTuIzysibeH7QqhakzIrf+5U4vEqVG94Q23B97+JLLJ9wD
	L5bGSjzIgGlQpQj+dEvC2EknbwElnlgewsV16IPSJcLnrck/a6ySByXP8sgSOxIAvDKhR05vues
	kl4jmgvYpDFrQUQI5iyQS+g==
X-Google-Smtp-Source: AGHT+IFGwL1CO1u75jugTjFaP80dxgbnUNCsFmdXJEhQH78p4+pXb4ZaZeDBowc1bD7HnapyTqrUtg==
X-Received: by 2002:a17:90b:1f8d:b0:2fe:e0a9:49d4 with SMTP id 98e67ed59e1d1-301bde5c92fmr5660572a91.2.1742403009662;
        Wed, 19 Mar 2025 09:50:09 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf576bc2sm1863641a91.5.2025.03.19.09.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 09:50:09 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 20 Mar 2025 00:47:28 +0800
Subject: [PATCH v4 7/8] ARM: dts: aspeed: catalina: Remove INA238 and
 INA230 nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-potin-catalina-dts-update-20250102-v4-7-7c34b8139014@gmail.com>
References: <20250320-potin-catalina-dts-update-20250102-v4-0-7c34b8139014@gmail.com>
In-Reply-To: <20250320-potin-catalina-dts-update-20250102-v4-0-7c34b8139014@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742402988; l=2136;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=VwzUdaWLbo+jZAMlNm4WzSN7aYJ6nvuUMBx/RwUbPbs=;
 b=1PduDxVu6+2Hiajen7lyNzA2t/FUX66kkW39JkHz63PwJ6LEGPels3iXGsQqpTf6xSzmpoQo5
 dl6tas3CgarAn6iRvsJtEz9rFVlpmEKtZZjQMzQLy4qMpn7KMHhZtKO
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Remove INA238 and INA230 power sensor nodes from the device tree (DTS) due
to incompatibility with the second-source ISL28022, which shares the same
I2C address.

Move the driver probe to userspace to handle sensor dynamically.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 45 ----------------------
 1 file changed, 45 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index fb4b236d36c0..573701bb7fee 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -304,27 +304,6 @@ i2c30mux0ch7: i2c@7 {
 					#address-cells = <1>;
 					#size-cells = <0>;
 					reg = <7>;
-
-					power-sensor@40 {
-						compatible = "ti,ina230";
-						reg = <0x40>;
-						shunt-resistor = <2000>;
-					};
-					power-sensor@41 {
-						compatible = "ti,ina230";
-						reg = <0x41>;
-						shunt-resistor = <2000>;
-					};
-					power-sensor@44 {
-						compatible = "ti,ina230";
-						reg = <0x44>;
-						shunt-resistor = <2000>;
-					};
-					power-sensor@45 {
-						compatible = "ti,ina230";
-						reg = <0x45>;
-						shunt-resistor = <2000>;
-					};
 				};
 			};
 		};
@@ -492,35 +471,11 @@ power-sensor@22 {
 				compatible = "mps,mp5990";
 				reg = <0x22>;
 			};
-			power-sensor@41 {
-				compatible = "ti,ina238";
-				reg = <0x41>;
-				shunt-resistor = <500>;
-			};
-			power-sensor@42 {
-				compatible = "ti,ina238";
-				reg = <0x42>;
-				shunt-resistor = <500>;
-			};
-			power-sensor@44 {
-				compatible = "ti,ina238";
-				reg = <0x44>;
-				shunt-resistor = <500>;
-			};
 		};
 		i2c1mux0ch1: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x1>;
-
-			power-sensor@41 {
-				compatible = "ti,ina238";
-				reg = <0x41>;
-			};
-			power-sensor@43 {
-				compatible = "ti,ina238";
-				reg = <0x43>;
-			};
 		};
 		i2c1mux0ch2: i2c@2 {
 			#address-cells = <1>;

-- 
2.31.1



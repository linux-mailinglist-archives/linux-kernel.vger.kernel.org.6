Return-Path: <linux-kernel+bounces-569936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CB6A6A9DF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A765E18982AA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487D31E9901;
	Thu, 20 Mar 2025 15:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3yV4RF8"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ABC22371E;
	Thu, 20 Mar 2025 15:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742484289; cv=none; b=UfL1C0fd5T2P0EA/0Bn17b4TpkIxRKhWgrw6BChD0tftKJOP8siGg81xy/uG+m8qpLdNPVxDvaj6u+jAYlVx9WGjHjNytYCVuPmV9P1Fn6r3qFuJY4JcnbOTS5VdsfXnT/nqPh1umgX5wwqJiE7BqzCZnomy7LqldAog+o9Tqsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742484289; c=relaxed/simple;
	bh=QdPjNftOZyhcrxaBENJ2ZcCMQ0d2Elbpse3JT06Zbt8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ezPPQ5sWe3s0BM7maRj2GrNxB5nMcccsqHmpRtdloZf+2KeAWEILpYtz8FYBodgi9/7vBs+bAK/EyzCoj1iJXTv/iwU2VCo/gJGEMHevK66HBDfleYRtC3sN/bFnEf73UijtUg0ulgvQhsDFmOMmlOikpOvQ9MOp8m0C5pa7wLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3yV4RF8; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-223f4c06e9fso16382075ad.1;
        Thu, 20 Mar 2025 08:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742484287; x=1743089087; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sUfisYcWp0a9uSKCTzhEOlOpswYrDKtyklCDtr9oI7U=;
        b=K3yV4RF8wZ+SxBZtq7NY/YIfvmop+dghTW1rkEF+++7Ia3QkFi3E5MILmU0MgvktPg
         QUrSJestzDePZe5KelTK6mNWq8OWDbl4Dn1lW6Bh9CuHH9zXt/zWraOPBwXMkCtrK3mm
         jNokagoBoTt4mx6JNdovn1Dlsi+kCoroLQCJbH0Ou83gj7drv0GvwFpVF0chwYm12+0t
         FqKIzXHTH3X3dgttdeZLwP4yz2TTmpozRfTRwndzNb0EBaHBxaRfcxGubo2ng66jfZyL
         gKKQ/AoJxi7vlM2E4Ws0o0EsXCGoiMdY4zdJusClehUuql05S6bu7NCtBYIGnjwOZCWy
         KyBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742484287; x=1743089087;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUfisYcWp0a9uSKCTzhEOlOpswYrDKtyklCDtr9oI7U=;
        b=rTSK0o7YNBlDYTI4cXGmvRSFiWiJk+TR9wb4jAc2scyg8GtwPCH+1/amJVba2W6HSy
         V7ltfjYl9P/yyDtMEsQGMWRWzqAt0WTFlNzB6VQwfGrPDTbbbfyx8U6pqFlzyp6T5zU3
         VqoTe282qtI+Kydk4i6Wh4aS1Gw4nAPJO2N8aZRD5kltOmy/uSc4BkJBiVNXvvpISoCv
         U8SwMTY5gfxeOvD4haz7PIDI/8uknQs+03xMPYATcxu53KPLRdqxFD+/t/7ee5SPu6LX
         CCOjG7HT4/UheQBk22/mEIIKoRlKUADHymoIPFQ2O+VGNezN9BKsTC5BrLHtfPdP3KsD
         29kg==
X-Forwarded-Encrypted: i=1; AJvYcCX2QzIjYF/crrF9WK+otGRqhFzdaIUUYbSxLbleFxouPtAGYLC7sNqYrYQQyRsvCTqqDrnc0CztpTch7l4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7aFa1aqn8RsMf6btxVMPsCwFwFFPfdsasYkJ0M6npuoZnBGsn
	T6howGPmQcRzq2KVlIDISf2Hscu72pxwP1/m4Uzy/tTuGZY+py/q
X-Gm-Gg: ASbGncvUe7HZ1cVmQQMCh5Sp76guRVcnhqQZbAECYR6i9zrbUI5du7ZBrBTNNbAy6Rr
	ZUpNFF3h1BPNOOqRGlrZbPKkVQZ8AcNw6Yi72fi4z8tidmklgVZ43KkGZ2OYRn7Bqeb5UqW7TXU
	eeVXFLzRvf2OrTWBEEx2CHu3BmQc9dzgFi0yEQX43y+uLUKhN9lez5wTHIWOkaXKetM7QnGqvpe
	91rtrR3XgglXtg26SEeves/mfT3LSd3dlyCe2TCRrei5oA21Z0ShjpnGPoexksnkFVj8/EXATID
	TE3MIpWAL8R+Mnpjpza5uGYVl89KR5lbnd+sn2OqF3itVK5NxVeQhXCKvkeNbM9wr+KpEew3Vtt
	DBHg1GbrlYqN+3ZYbvy+ETQ==
X-Google-Smtp-Source: AGHT+IEhD+AwDbS1bWQ1xV8+/CAKiat6otvbsanGzMCX+jMw60SVH48Jml3Jk1BukssYExoZ1JfSjA==
X-Received: by 2002:a17:903:1a27:b0:21f:98fc:8414 with SMTP id d9443c01a7336-2265e7c2830mr65399575ad.26.1742484287128;
        Thu, 20 Mar 2025 08:24:47 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4a8fsm136905515ad.234.2025.03.20.08.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 08:24:46 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 20 Mar 2025 23:21:57 +0800
Subject: [PATCH v5 07/10] ARM: dts: aspeed: catalina: Remove INA238 and
 INA230 nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-potin-catalina-dts-update-20250102-v5-7-e161be6583a7@gmail.com>
References: <20250320-potin-catalina-dts-update-20250102-v5-0-e161be6583a7@gmail.com>
In-Reply-To: <20250320-potin-catalina-dts-update-20250102-v5-0-e161be6583a7@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742484265; l=2083;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=QdPjNftOZyhcrxaBENJ2ZcCMQ0d2Elbpse3JT06Zbt8=;
 b=ahiqRaLzLCuBq51XXJGrLe1R+4sfoCcFv/8CoxoOuZot1U3ktNGhpx9+KLCyQx04a92RUgyp5
 LimJ83PUITOBAM65OVPGU6vgHp/CdOyT0QXMr9zq1HR18oRBnRzLvxr
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
index cf8a31b50074..1e1bcc9ac2f0 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -432,35 +432,11 @@ power-sensor@22 {
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
@@ -753,27 +729,6 @@ i2c5mux0ch7: i2c@7 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <7>;
-
-			power-sensor@40 {
-				compatible = "ti,ina230";
-				reg = <0x40>;
-				shunt-resistor = <2000>;
-			};
-			power-sensor@41 {
-				compatible = "ti,ina230";
-				reg = <0x41>;
-				shunt-resistor = <2000>;
-			};
-			power-sensor@44 {
-				compatible = "ti,ina230";
-				reg = <0x44>;
-				shunt-resistor = <2000>;
-			};
-			power-sensor@45 {
-				compatible = "ti,ina230";
-				reg = <0x45>;
-				shunt-resistor = <2000>;
-			};
 		};
 	};
 };

-- 
2.31.1



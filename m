Return-Path: <linux-kernel+bounces-569935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4140EA6A9D3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991824863E4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683261E98E7;
	Thu, 20 Mar 2025 15:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WT2f77W2"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CB9222596;
	Thu, 20 Mar 2025 15:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742484286; cv=none; b=n6XViIXrSBE0Xj865RWnZBAHOJz04TaUPM+tlymcJIfFO/oJ9VakSoHzRl9HV6f9jnoUn8omZX4nGs5os/xoDop1wTsbS8fmzAfT+4eygiW0FWmZmSuivuwqffjqrZxZNXNHdj5lTmU+Omn3gX15H2cgONa+/nk5qjw3jgwM94k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742484286; c=relaxed/simple;
	bh=bBJquWmbhZlBT0E9fzqTISanbT0nOLqq8zl6vtcWbDs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PBNBNfIpZX5dOeGQjd1WDt7DvYxgIcIfQUgaeWUiEjQrLhpAeAE6QNG0QZR1OESaLUPYOeIZKCDM2zA9i5UnP1EnGxEr4az7o/237leVHuS0vIuZ/L8ywp5ELY5vCt5TQZjniEt42PgilgvijCssVnuZ0i0Lb4/7QhEjiXTXSmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WT2f77W2; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-224100e9a5cso18263515ad.2;
        Thu, 20 Mar 2025 08:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742484285; x=1743089085; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BdO66wmJYQ3an/CxnUlug2JV7sb1pt8dsfeshj9bVHI=;
        b=WT2f77W2I+tawEXNk3Gpki7JRpoQKAMez11gJ3B/lI9Z2HzFUHo/ZeIdd1M1PVcBZx
         +0OLZ2qWbdsWmjJbEH88+IUkQagllJvfGqJ1JEAnlMauw2b58LySAQimw1eXpQkj+j6+
         /RlPws7WJwkSC+5T5F8of6WF84F3F8jyKoH5UovvIHwAdEqo0N7GK2thbcMJFMmaIz6c
         Q/XpfSCbJlFNf2Bdkqk1tR64Fulm91ZlurLos7UKDl0Wzd366E8eZjXXJ2FKTQjgRt2w
         xvUWELQG8x+KfjWuh+1Ia0+2swJgkxCamGdlWqZEGTwkygz8L1Zr415sM2yDrcnMBEIf
         FtEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742484285; x=1743089085;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BdO66wmJYQ3an/CxnUlug2JV7sb1pt8dsfeshj9bVHI=;
        b=Tni7PbTvA3erUTR5mftvlbPwv0Thp2XTJvUgeoxG647QeasbXhWxdVqwouXy4bAs02
         ACmDSBtTEyEuF/FRLF5SJJdfVx6ZIm212haaZoFvirQ0Agf1jcbbzTQWgVaVSW1Mpkdh
         X+v0DEFX3lu1p1bTHwi1b1xu8MUjpiZrl5mINNWETndLGTYpQM/kFdn3H7BaruFmEhHb
         K32Ddfu9DxTymB9Ge9E0NN9deyH5WS3xZw53lgLs3/6TI0c6UNpII7eyXa0+WQ+tqr34
         8WR8MiafaS+clyfVYYby5EOgXqgFIcZnV2fYZiSGSalpzp6en5zMc7ZuWBsGay4BM/Tv
         Dr+A==
X-Forwarded-Encrypted: i=1; AJvYcCV/d9vGvOE3TJxCTGrh4bJo+w1fEPBUfLz9l4wY7Plv+8O9+Td9RpemMbQt/2Jlqj1dsv+6ZSTdLtRCGwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGwvWQAL8+BfsIYVpeSuvY8rTaHBvxOWHbfIyJDUL/S4Hsjf/m
	cqOh/EkQ3HVgg37lNDlzQfJiAwxB6OfsRO5qvT0cnyB0EHjCYumu
X-Gm-Gg: ASbGncuwFsVl7bH7b3TaDWYcUaVeDkRla7G8bW16B5adOHn6NAjLFWUZr1XWW7pzXlV
	QJ9qUH+DNfhT0M+7udXO4Bm3DF9/apJaz4kSJ8Wfdye9Yqdf0XrK6rBoIGTM6oUEovc36Wfl0Gu
	9HyHQOvJPZOAoFgpGZULVzxogp5eBBtBAW2NBbzgL0Zo/hj2pl7XPkTviWJvkf2z/VOeMorJtE+
	06Fl2FYfznefdYpcOf4HY80pTNlB3UPGrr4y11H+mmPYZ0aSjEWMwjzibd1IGUrcj2fcmUp683W
	VznrKt1NK7Yrw8pbw6oUiiDBPhbfR3v1JIbeeLF8rJDHAwGez+7N71Ew4fI6lboZTuwP/90ZYXC
	lC8l4MTJ/S5/x/fLUDz8Zow==
X-Google-Smtp-Source: AGHT+IE0FDg/RvatznD5nSPBO0u6iFrPVYdj39Zl3XVqmYw9j17E38UUu3Xc7F1pPw2qEsugW3y4Rg==
X-Received: by 2002:a17:903:320e:b0:223:fabd:4f99 with SMTP id d9443c01a7336-2265ed68d0dmr64182055ad.5.1742484284467;
        Thu, 20 Mar 2025 08:24:44 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4a8fsm136905515ad.234.2025.03.20.08.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 08:24:44 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 20 Mar 2025 23:21:56 +0800
Subject: [PATCH v5 06/10] ARM: dts: aspeed: catalina: Add second source HSC
 node support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-potin-catalina-dts-update-20250102-v5-6-e161be6583a7@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742484265; l=979;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=bBJquWmbhZlBT0E9fzqTISanbT0nOLqq8zl6vtcWbDs=;
 b=nY7Z5IkRbcS1V5IGJjWbsZaB1Q3BvpU6kh56rBgCZUHC3bvVeo1uNTaxziEpT3fNRvoeEldAt
 plVdW1akqN3AcuEdgCyo2mqwpTyxRFgQu4v7AIIo8yta+XVuO35qHk9
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add device tree nodes for the XDP710 Hot-Swap Controller (HSC) to support
the Power Distribution Board (PDB) with a second-source configuration.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 9cbb296dcd9e..cf8a31b50074 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -562,6 +562,14 @@ i2c1mux0ch4: i2c@4 {
 			#size-cells = <0>;
 			reg = <0x4>;
 
+			power-monitor@13 {
+				compatible = "infineon,xdp710";
+				reg = <0x13>;
+			};
+			power-monitor@1c {
+				compatible = "infineon,xdp710";
+				reg = <0x1c>;
+			};
 			power-monitor@42 {
 				compatible = "lltc,ltc4287";
 				reg = <0x42>;

-- 
2.31.1



Return-Path: <linux-kernel+bounces-569941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B80D2A6A9F2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8194C189A2DE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31962226CE7;
	Thu, 20 Mar 2025 15:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2kJLj8W"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFCD225A5B;
	Thu, 20 Mar 2025 15:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742484298; cv=none; b=IkCsCONSFEJxzH+Wed7z4ZAdeiAB0CPqc2zF2BQd02bvmPyvI9j0PCtoGYxoaOs8zvBMZ3f2ZcCGvChFR2cXQgnMKl0x886tsosXRbuHqMSptJT9ZvbngaRx7O1fDwi1kz5OauTfC+mivQydS3iU/lbqUstZEEk5GxL2KXKAwyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742484298; c=relaxed/simple;
	bh=mctbch+3SZnEdii4zFZGF0Iv2O1sUwEaKoFRoL6RcjM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T5on0R4id2X8ZrhNJIkcaNiEB1yhvUHD/WZrYzhCQCgy5k1rojzqFzA773Pv7fvgPcng75/l2NP14kcBY3No1ktO0fYVnyyyu/hf+E21Mib32k+ORiaBUAJdOIr1ekDuTL8KvjmS47dFRC0uMSqG34rXhj+O/WKPHVJokpwxThI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2kJLj8W; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2235189adaeso18919635ad.0;
        Thu, 20 Mar 2025 08:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742484295; x=1743089095; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=778YCnhGu8OwS5VD6l1aN21sioD9+bOBBeqngUJxkTg=;
        b=h2kJLj8WBtK+rWlNrvtPRqfMf46aH96vE7FsiSElHc0d+5W5CWJKYJfBhge47LWZ8X
         6hd7RT2azyCmltaAKUQL4o8Gj6n3LGDNjwJxcDUZ8Zjl/zxfmqgt7ZCkzhAa3kTwRBZG
         F8N+srk+L3Ya6wOSbEuOtuPHV7LndpNha7Hi0oCp6O9N8opHoijbXQnyhL+JQnyXnUXP
         K7E1cgRJSBTOTN6keN100TSIX0cVaZtvKmEoXYRHlBSxgBgqueB6fAb6iDJ4TZRzPGAn
         clf5T/9Iw6ATrQ2XegiyVn+1pcJURkyQP8oWbAwwHGf9Zj42jd6rPyBEzZ10tnAmIYCT
         xBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742484295; x=1743089095;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=778YCnhGu8OwS5VD6l1aN21sioD9+bOBBeqngUJxkTg=;
        b=gmoL1yt4dO2nP4XqnBQbhrSkhc0ydHa8Ghwh9BUhJ0ZfKYroYctqlv0sBVYCmCbEGT
         YWUCq/+I6JET+iw4ZdgCoc8cTl+uV4D6WmeJRMccWAJqYz3fqiPhRI8pwb2WhzoGsutj
         ColZfbDuMTIciqOdc7fqpk3XvWla3cVFZ6wT0OPP5X+9slYbpENmwWaXNFYMMggSJYKt
         Kkd9EwZLjiWPaA5a2r9NnNQ5sxUkhTgby85s2ZMlqA5NRDd6Oao+IDZ0if8pCPAEII/8
         KWsgZysqf5q+hETE4Vod1zsqDCwcO+VU6sdLBS3BJnRP6Amn7NE7rtKukAsNFI/jeU2C
         0Rsg==
X-Forwarded-Encrypted: i=1; AJvYcCVV0N6HeYfmVAIXxUDzzw89Wi0rVbOnQfbgJTKMNpn/5iw639Lnlq3tU1NRFIkQmB8Qq/UcXURQ6guGjYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRKorMdyBfEXELgMplOa1XSWviQA09eVKWQsyrAe28CUsV1dDe
	t50tB6Wc97fBcacqyP1coaK7mkM2l4F7AauOXZFnPRECzIFFav5NYPpqsQ==
X-Gm-Gg: ASbGncv44fitfv0fEdq8f1gjNEj1Fow7CJzLduJ5ojmHA+Zg+67Z/Q4miFfRkLYWBAx
	eGun4RgOCkNDWRsMJuQWo6QcxLi2yh5ShA87ezinIqruR3efNdInHK/BQJ4rzpLYrEpgHHDIN4Y
	4qEfPWVk0A1hyo51hbQGAqJ8X9berjls35MEBvRbZH5gF9gYHjQ6dNf7fKXOUFuIiSM522Iu/Xh
	T1ibGJBX2xK/eBhBoFiRPnR8MRGhRNtkNAjw4+jj8Em3E+8oc7PJ0ey6ryk5j3rli/gIQhDviEb
	U77GTXkOraTea+AY8S/8BlieES1Z200jILIsp6UJrgHHAabPyWH0rO9FeKEDd1Fu7mGkFV+aMa6
	0sMPPtS20u7CoTmruhCxAhw==
X-Google-Smtp-Source: AGHT+IEm0o3IjdN4CK7bI1ZR5Cl6pbpHzpKB84eZ6aOsv2wGsYmuyJSpIXKgRxVZphiibOVU45xSMQ==
X-Received: by 2002:a17:903:228d:b0:220:ff82:1c60 with SMTP id d9443c01a7336-2265e6d467bmr56146505ad.14.1742484295352;
        Thu, 20 Mar 2025 08:24:55 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4a8fsm136905515ad.234.2025.03.20.08.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 08:24:54 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 20 Mar 2025 23:22:00 +0800
Subject: [PATCH v5 10/10] ARM: dts: aspeed: catalina: Enable MCTP support
 for NIC management
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-potin-catalina-dts-update-20250102-v5-10-e161be6583a7@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742484265; l=1803;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=mctbch+3SZnEdii4zFZGF0Iv2O1sUwEaKoFRoL6RcjM=;
 b=sqz6o+Uq8neZCbmc+XIXb5EqpCCu/Sv7ukNsWuZdglpzn1ESmULH+w516OO76HCLaZ4morgBT
 FpcXpZ2i6XdARxIH0ltRokrlXGjzJ9Dyv/tnxJ3kxTdAhSEYff8vmD+
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add the `mctp-controller` property and MCTP nodes to enable support for
backend NIC management via PLDM over MCTP.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 653afacc7af4..6eb6c5889113 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -186,18 +186,23 @@ flash@1 {
 
 &i2c0 {
 	status = "okay";
+	multi-master;
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
 
 	i2c-mux@71 {
 		compatible = "nxp,pca9546";
 		reg = <0x71>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		i2c-mux-idle-disconnect;
 
 		i2c0mux0ch0: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+			mctp-controller;
 
 			// IOB0 NIC0 TEMP
 			temperature-sensor@1f {
@@ -214,6 +219,7 @@ i2c0mux0ch2: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
+			mctp-controller;
 
 			// IOB0 NIC1 TEMP
 			temperature-sensor@1f {
@@ -305,12 +311,12 @@ i2c-mux@75 {
 		reg = <0x75>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		i2c-mux-idle-disconnect;
 
 		i2c0mux3ch0: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+			mctp-controller;
 
 			// IOB1 NIC0 TEMP
 			temperature-sensor@1f {
@@ -327,6 +333,7 @@ i2c0mux3ch2: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
+			mctp-controller;
 
 			// IOB1 NIC1 TEMP
 			temperature-sensor@1f {

-- 
2.31.1



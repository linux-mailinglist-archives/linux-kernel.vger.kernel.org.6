Return-Path: <linux-kernel+bounces-569934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5E1A6A9DA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F7671896F75
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA76221717;
	Thu, 20 Mar 2025 15:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FiLnYZwG"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5339221F00;
	Thu, 20 Mar 2025 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742484284; cv=none; b=YVKg093TXfgzBeMG4HE9vafn8LKuI1Ecc33RbWTvLNVNUTT0Hnzl+5b92kApw6z/iCFNJqlnYSXL9JYmWSpdiAFBtkGt405A0yYWcoheTez+ZK0r+H665eR/hvasNARloFWA/TQb6aqoZgbfF9nTJwH9MH4a5L3iQ1O1n0l9ebY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742484284; c=relaxed/simple;
	bh=zyB2uaDDv1BAG0YqbiEdmRLnG2B1bXVWmRwVAs+kqS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tw7ww5tze9uQZTX83VgvjIDVOdZOEtjPPJhem4jlLu2LDm519WPikVxd4GAJZWcpKDNfha7d9x9cyhvaLXgbJIRV8aYQjX00LiNpLFtNPywCcckwopoa35Hd0IFBYLyR3BuXtZRIo2/HY0mwLHE/NQujMvK6KIBHMBAGv5tNA50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FiLnYZwG; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-225b5448519so18087935ad.0;
        Thu, 20 Mar 2025 08:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742484282; x=1743089082; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HhPGWpSJf4aEvLnPhTJquxIyNv0KK5Phy3xNH0kC5O0=;
        b=FiLnYZwG2TMjXqid47FH7H2hsC4j1689LCKMow1drLsfJDbLhCa0jksaC9T8clfRCT
         a2UstkJU8WQ3otVVqnPOqKH9m2Q7gx33/AsMwZkYoH/cjEqhcmpEHiF7Hsvzrw19wAjx
         b49h4YOmTk+dYgBi7s2EEh4OQ5sD43OGHz5iAg+s4wTZimtLTpjtuO+YpoPmqMit36Lm
         /FEKq0NXCiyIOrX9tnwX31i+m7FHPcgHYpQRgbWZ0d0N5iqmWo2A9pOkcjXtXs6M1DOE
         e/KDa8JksxlRVNxkb6RjRZdetmPneoW1NYZjPteJrfKw/5xw1fjTMQfTg9cRQQSSGiGs
         uHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742484282; x=1743089082;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhPGWpSJf4aEvLnPhTJquxIyNv0KK5Phy3xNH0kC5O0=;
        b=wrPDpQOdCSRV8dlf1RgUAwduMqGrmy8jmaBZqLOvc/e0EtJmAPD+wisHJvbaZ33Sv4
         WfUQ/KUENoDOiVJxm6Odl0EQKkcgPh+hwjNkLYsPcoZ4YZz3xm8zcRWcWYENy3lWP3bB
         9FJ1jI9moR5NwSQ9G9TiIk8jYSGNxXx30O44e9IBGCI36g53scxhPE+YxZ0tcEvSJBel
         EX+hrB12EVt06pBIfQZA6akhvq0jiYuRwdEYQyg8gJzN4vfJq0TWmA8lhJO4IdNrIf1m
         ZjZFnZkZ5ixljHZN0R3XWIi0XBXnFo+ew13mzk38TVOLndSv4UFxIn3oZs+LJGYYaLJs
         sAbw==
X-Forwarded-Encrypted: i=1; AJvYcCUNmT6gVDGugdIi7nrqo6gftXKRBP6eg1MSCmgzqlE4LVbXA4h4KOz7tlIE8Ejgos+PVBv1lDKST0qKZqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YweSkmiJfexgkZ6TYGy/1DjE2yZp5+8zhPIzNFdxlzM0OjkzAc9
	Fjv5AdORllW0PgDodsYytKP5r95rH+ZPan4YFKf/VunTOFacC/rk
X-Gm-Gg: ASbGncvynxHV/xB+Wv2CM0CHNpa3uefyNYTYhtOnLRWdKbIq5d7BT0EcXkf/AgzAI+K
	RCoo12b7TmvNUZ33hepcWRLP+O/ASO8cez8lEf53G765SPMkXFPlg25+6T2vDr4mxYKGraKKY0s
	kjCuDjjwziqhB4n8hI7wJEi2K7FzXx+pS3CgNlbeXLP7SNlKjnucZnPKqCenbHUGtxpYAQyfzlC
	SgkV/lWJW3HDny972EUJ7EJd0yF33krIznbjChTVfGH15PgQ+JMSPLTuT0zTAiz4xr5YKM+1Vd4
	eJPcjFFCRn0bIHZfGcCX66mIX69Hi2H8wbqk3RouOfULjWlB0ZIwBghND+WLZK+kUIe+XIFQA5M
	Qe48yIuE6IWz955OhpdCTJn13JsTrCgan
X-Google-Smtp-Source: AGHT+IGkYoRpTwvX0SPQrV2WZJvZ/92oS7+7U7y4cTjAdvt5uiAV4eA9Zp8uehwfG/gclRTVojzHSg==
X-Received: by 2002:a17:902:cf07:b0:223:53fb:e1dd with SMTP id d9443c01a7336-22649928472mr115859395ad.9.1742484281811;
        Thu, 20 Mar 2025 08:24:41 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4a8fsm136905515ad.234.2025.03.20.08.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 08:24:41 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 20 Mar 2025 23:21:55 +0800
Subject: [PATCH v5 05/10] ARM: dts: aspeed: catalina: Add second source fan
 controller support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-potin-catalina-dts-update-20250102-v5-5-e161be6583a7@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742484265; l=2445;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=zyB2uaDDv1BAG0YqbiEdmRLnG2B1bXVWmRwVAs+kqS8=;
 b=yaNv8/tBD1Dp9LskMzc98/pZcRkIlWncgoAtHa/Wg9TwNWL4CEXyC5gYPtOviqhsSEpoBkEsx
 4B7gSQTFjQDDSpT4l2vBGBkj0T+OQloWQevOabCyJnZBfpDX4KalonZ
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add device tree nodes for the NCT7363 fan controllers on the second-source
Power Distribution Board (PDB).

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 76 ++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index fd22add90449..9cbb296dcd9e 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -467,6 +467,82 @@ i2c1mux0ch2: i2c@2 {
 			#size-cells = <0>;
 			reg = <0x2>;
 
+			hwmon0: hwmon@1 {
+				compatible = "nuvoton,nct7363";
+				reg = <0x01>;
+				#pwm-cells = <2>;
+
+				fan-9 {
+					pwms = <&hwmon0 0 40000>;
+					tach-ch = /bits/ 8 <0x09>;
+				};
+				fan-11 {
+					pwms = <&hwmon0 0 40000>;
+					tach-ch = /bits/ 8 <0x0b>;
+				};
+				fan-10 {
+					pwms = <&hwmon0 4 40000>;
+					tach-ch = /bits/ 8 <0x0a>;
+				};
+				fan-13 {
+					pwms = <&hwmon0 4 40000>;
+					tach-ch = /bits/ 8 <0x0d>;
+				};
+				fan-15 {
+					pwms = <&hwmon0 6 40000>;
+					tach-ch = /bits/ 8 <0x0f>;
+				};
+				fan-1 {
+					pwms = <&hwmon0 6 40000>;
+					tach-ch = /bits/ 8 <0x01>;
+				};
+				fan-0 {
+					pwms = <&hwmon0 10 40000>;
+					tach-ch = /bits/ 8 <0x00>;
+				};
+				fan-3 {
+					pwms = <&hwmon0 10 40000>;
+					tach-ch = /bits/ 8 <0x03>;
+				};
+			};
+			hwmon1: hwmon@2 {
+				compatible = "nuvoton,nct7363";
+				reg = <0x02>;
+				#pwm-cells = <2>;
+
+				fan-9 {
+					pwms = <&hwmon1 0 40000>;
+					tach-ch = /bits/ 8 <0x09>;
+				};
+				fan-11 {
+					pwms = <&hwmon1 0 40000>;
+					tach-ch = /bits/ 8 <0x0b>;
+				};
+				fan-10 {
+					pwms = <&hwmon1 4 40000>;
+					tach-ch = /bits/ 8 <0x0a>;
+				};
+				fan-13 {
+					pwms = <&hwmon1 4 40000>;
+					tach-ch = /bits/ 8 <0x0d>;
+				};
+				fan-15 {
+					pwms = <&hwmon1 6 40000>;
+					tach-ch = /bits/ 8 <0x0f>;
+				};
+				fan-1 {
+					pwms = <&hwmon1 6 40000>;
+					tach-ch = /bits/ 8 <0x01>;
+				};
+				fan-0 {
+					pwms = <&hwmon1 10 40000>;
+					tach-ch = /bits/ 8 <0x00>;
+				};
+				fan-3 {
+					pwms = <&hwmon1 10 40000>;
+					tach-ch = /bits/ 8 <0x03>;
+				};
+			};
 			pwm@21{
 				compatible = "maxim,max31790";
 				reg = <0x21>;

-- 
2.31.1



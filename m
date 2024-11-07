Return-Path: <linux-kernel+bounces-399902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B98E39C0610
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C8D51F23BA9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D786720F5D9;
	Thu,  7 Nov 2024 12:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuzdGjFk"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C451B210186;
	Thu,  7 Nov 2024 12:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730983349; cv=none; b=gQSvmflKp4QxtmfgU0yXvLk0Q6RjIYM3nBO1Odr6uoXjq7BEwa7puH1zxFbjBO0rL1tGut16dykU/8P1h3cqAG92VCTS6o/NS+qwANEJhuB0W9DTFUPsRK5o6fDDa3w+bYBQqCWJ63R7xkpMJGimMuruicf4KeObrh3uvU1tUag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730983349; c=relaxed/simple;
	bh=YtgoH8nC8HzrEXlSjsTGbSqJDdm7lP26pU2kbrrMZgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eiYUKXkCBBmOg5d9itqbxZqYVxlnjMDmRFicC9rmxAqtTSJXMviR9vBuATdpBqAv0OD1OdXt7RMKOWrxPMfk4jmj3e0bLCdHIG4uWX37hpkFVTQsy9/5bYYtvJQ7FskWlJfvKMf3nnlxsJrdLKolZdWlC18tUSlqztc1gcsbRKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuzdGjFk; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20cf6eea3c0so9559165ad.0;
        Thu, 07 Nov 2024 04:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730983346; x=1731588146; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1lFEM2XRj+4jfdUpSmt8rXreEAc43KfUaW7x9In1LlQ=;
        b=AuzdGjFkE+hCszZuyDw4Lhl9cYJK6AslBTvpPT8ap1+mTy/Q6OgkUosP0IQYeeT7zx
         nWTYoT89YsH27+et8wB2s29sGyR2/k43VH89YUJj5goiFirOzj7Do+4BNicPpYHDnUot
         XYuge7KIeVgj/PH6f30Em1EIOPbogA8CnscyLnQt7hsKIP/VGhtIE8U8z+x5XUkvcFfT
         vIq3XJojjEq/NX39eFCsK7RwuJX1FSH+4/Xw9y+8O5mdD2E1UAslAiBMU2PMFFCHH5aV
         rfF74nP9nv6fS2XUw5Nd6V71h76hLh/WmsXkXjlu6suy9C6F9xIHk4NpZ39oeApa39/4
         j4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730983346; x=1731588146;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lFEM2XRj+4jfdUpSmt8rXreEAc43KfUaW7x9In1LlQ=;
        b=FaqlcRF8rzFwQRC+FMwunT3XQxd4DW/JmNcODcE4crJxTmkjQb366zDXwm9gHe03FQ
         Y0+QW7QOrUWAPPto08DenMrlT70PxN1pOjqqFBX18vrqWYc69HjC88ciNTpcgRpCvFEc
         drnJz/QsQm7IBh8dX1MrUAZYZeCI0fLKLAtVGUpsxYFc8cnLjG+rnjsRCfDIJokzxNO9
         1O5F06shMKu5Bn0Obw0e/ZhHOxJKX770vOE9h/e7wtOjB/iDk8KwooX7Kd4vQM/xBezu
         QkDjNvr1bv+2XL6/fLnBN9Jsvxme7H8TiOXF8DKRlOWLTzoJNkrYXW+pN/6ke/vsZAJA
         yAkg==
X-Forwarded-Encrypted: i=1; AJvYcCW8KPEPb9PXCI5w+24lGnUuxzWKq+kFFBMTzXAk6RSI0dW302SYSamlYXlQ8LVnV8goXyaxoZT2gVHiIUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHp1kh/pL5Fv3wpcCpjiFUPDQ6IpsDmeNr63n6JBtJljRg7/2e
	dFNiWcD09/g8AG/DczTCLSviWEzeIwfVxayE0izsYKOPw/3qd/dI
X-Google-Smtp-Source: AGHT+IFuD+Xx2XTx19q908xHLwUL9xed5Q6pQGCkFR2QHhE8PIBdNyA98Icm/09ejWxglfMpDVTuYw==
X-Received: by 2002:a17:902:db0f:b0:20c:cf39:fe3c with SMTP id d9443c01a7336-210c6c34824mr585270765ad.41.1730983345945;
        Thu, 07 Nov 2024 04:42:25 -0800 (PST)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e412d8sm11101975ad.113.2024.11.07.04.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 04:42:25 -0800 (PST)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 07 Nov 2024 20:39:58 +0800
Subject: [PATCH v2 2/2] ARM: dts: aspeed: catalina: add hdd board cpld
 ioexp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-catalina-cpld-ioexp-update-v2-2-d7742eabc0e6@gmail.com>
References: <20241107-catalina-cpld-ioexp-update-v2-0-d7742eabc0e6@gmail.com>
In-Reply-To: <20241107-catalina-cpld-ioexp-update-v2-0-d7742eabc0e6@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Potin Lai <potin.lai@quantatw.com>, Cosmo Chou <cosmo.chou@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730983338; l=2806;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=YtgoH8nC8HzrEXlSjsTGbSqJDdm7lP26pU2kbrrMZgg=;
 b=fgk9z23oAMZdgTzX2DJ9eMhOC0Bh5c6Lmv07tC0TXF+/bgCq4twQdVIo5L2vKAQYhk41GZd76
 caMnNjnvwhLCoIWH3dRlsHRdQwMCRoERqqdvKvGDzODn4JHY73fjrKk
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add HDD board CPLD IO expender based on latest DVT HDD board CPLD
firmware implementation.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 65 ++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 10a9fca1b803..102d71234932 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -632,6 +632,36 @@ eeprom@51 {
 
 &i2c3 {
 	status = "okay";
+
+	// HDD CPLD IOEXP 0x10
+	io_expander13: gpio@10 {
+		compatible = "nxp,pca9555";
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(I, 6) IRQ_TYPE_LEVEL_LOW>;
+		reg = <0x10>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	// HDD CPLD IOEXP 0x11
+	io_expander14: gpio@11 {
+		compatible = "nxp,pca9555";
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(I, 6) IRQ_TYPE_LEVEL_LOW>;
+		reg = <0x11>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	// HDD CPLD IOEXP 0x12
+	io_expander15: gpio@12 {
+		compatible = "nxp,pca9555";
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(I, 6) IRQ_TYPE_LEVEL_LOW>;
+		reg = <0x12>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
 };
 
 &i2c4 {
@@ -1067,3 +1097,38 @@ &io_expander12 {
 		"PRSNT_CHASSIS1_LEAK_CABLE_R_N","PRSNT_CHASSIS0_LEAK_CABLE_R_N";
 };
 
+&io_expander13 {
+	gpio-line-names =
+		"wP3V3_RUNTIME_FLT_HDD0","wP12V_RUNTIME_FLT_HDD0",
+		"wP3V3_AUX_RUNTIME_FLT_HDD0","",
+		"Host_PERST_SEQPWR_FLT_HDD0","wP3V3_SEQPWR_FLT_HDD0",
+		"wP12V_SEQPWR_FLT_HDD0","wP3V3_AUX_SEQPWR_FLT_HDD0",
+		"wP3V3_RUNTIME_FLT_HDD1","wP12V_RUNTIME_FLT_HDD1",
+		"wP3V3_AUX_RUNTIME_FLT_HDD1","",
+		"Host_PERST_SEQPWR_FLT_HDD1","wP3V3_SEQPWR_FLT_HDD1",
+		"wP12V_SEQPWR_FLT_HDD1","wP3V3_AUX_SEQPWR_FLT_HDD1";
+};
+
+&io_expander14 {
+	gpio-line-names =
+		"wP3V3_RUNTIME_FLT_HDD2","wP12V_RUNTIME_FLT_HDD2",
+		"wP3V3_AUX_RUNTIME_FLT_HDD2","",
+		"Host_PERST_SEQPWR_FLT_HDD2","wP3V3_SEQPWR_FLT_HDD2",
+		"wP12V_SEQPWR_FLT_HDD2","wP3V3_AUX_SEQPWR_FLT_HDD2",
+		"wP3V3_RUNTIME_FLT_HDD3","wP12V_RUNTIME_FLT_HDD3",
+		"wP3V3_AUX_RUNTIME_FLT_HDD3","",
+		"Host_PERST_SEQPWR_FLT_HDD3","wP3V3_SEQPWR_FLT_HDD3",
+		"wP12V_SEQPWR_FLT_HDD3","wP3V3_AUX_SEQPWR_FLT_HDD3";
+};
+
+&io_expander15 {
+	gpio-line-names =
+		"P3V3_HDD3_FAULT_R","P3V3_HDD2_FAULT_R",
+		"P3V3_HDD1_FAULT_R","P3V3_HDD0_FAULT_R",
+		"P12V_HDD3_FLT_L","P12V_HDD2_FLT_L",
+		"P12V_HDD1_FLT_L","P12V_HDD0_FLT_L",
+		"HDD_23_PWRBRK_N_R","HDD_01_PWRBRK_N_R",
+		"","",
+		"HDD3_PRSNT_N_R","HDD2_PRSNT_N_R",
+		"HDD1_PRSNT_N_R","HDD0_PRSNT_N_R";
+};

-- 
2.31.1



Return-Path: <linux-kernel+bounces-397862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD209BE189
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F01E21F247D0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6891D95AA;
	Wed,  6 Nov 2024 09:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaw4auC9"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0CD1D90D7;
	Wed,  6 Nov 2024 09:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883692; cv=none; b=Au1hNQuLMVR/PxAljzZX/vcVlh+MLSOL2WPWRLCZms3IpGwX864R48jzlIX0AU3+yJ+/s5o6SBIpBC9nxO3xsF0fsFWMCJvgp2EeY4dgErbUrdU2cMemDHVoZc/tsKSv6FTviKObAUWjl5PJbRo0ElEFpQCPqn0hx2PKdeX9U6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883692; c=relaxed/simple;
	bh=Ma7zHm/VTawO0uhZBJJdi+x5g2IFHZE6w9ObR9Dz8mM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fB16A6jQX3VG2+JZ4Ae4bHliiuDE0co1gthZP7r2vDUz9UfYEpbM2e7CKdxxVPssfDGrXb0aPv+MMeUXSlEF27/WA7c6KxZ/cVVG1jHXJEDARqXKPzWGNC3UA6yZ0UZ2cHtpwprjZrm8bvYzpGbKVPJ9PKLORTCBbZ59zc97ud8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eaw4auC9; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20cd76c513cso50704365ad.3;
        Wed, 06 Nov 2024 01:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730883690; x=1731488490; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sGC6TPqRGXu1mF5aeFEhak+3rB765Th2HjWB1mjw0KQ=;
        b=eaw4auC9Lit20tq+bXyvY0kSZQoDuSNAoA28JAkBQjU85tlW/jZOjirDxRdP5/o+qY
         /ZVtytHTIpqOJWRaBMSybhqN6Fpa+a5ltJkFEvVF5vXsJEu16H1y3osqoawXu+MiNp5z
         KP1zWmvVXUXft1X3DzIAc8riYWfSBcCBbHWO+Gdq6UyGP6kjrLa+Jnxzilpxx3GVz0kj
         igIVAdzwNgUD/Qsz7OWs8XaZzDNYtI2/FFGB7/00spHz3t1cbmQXakpMmGmdn3urhVlV
         2VKAaW0vb/6ajOvgdam7WqpJL9JCUTNWyh3Ona5ABlFa6eutHPZTy8GH8ixRFqmB0xCv
         Mouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730883690; x=1731488490;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGC6TPqRGXu1mF5aeFEhak+3rB765Th2HjWB1mjw0KQ=;
        b=apUoQdJYP7c7oQUdaqGi96Ki6JjDB3tFwJnuQCwISelDtT8/NZNr+le5bFR9XyAlNm
         BC55KyR9HYnhoI6SG0irs/xFlguVSVq+ENUCBA3+44b39rLf1QL4d6DoEkjsTa/vOrDj
         in9bbi81+275J2hv6dvRJynNQRHWhBdCr2jraGSYmceIBMxE+hIGPNv4QyBmGBEaPmtQ
         rv3Q14ER/TRWhU4sp+m8MzeHr20QwY9rWaiYFIyVDtIpxhpPYZkeCf3o5I8CzO26kP+f
         qj7RFnd/oA8f2SYmSYRCSsIMW2lAJ18Dk4xjxdLEAbEwVJu+KOSGYKzFQi97Xd1kmhmn
         vesA==
X-Forwarded-Encrypted: i=1; AJvYcCW3qIq5WC+/SVXDaAUb8ypTlo6d3CtGsdXzRTOpfcOIYFEYEYWj/xkYjS9Zj7FSDHw77to+ZsbQL5JcDC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxMys0sgzw2jQLkfahsL4jmcDC9vIH+KXRLMq9Qaz5rtw3GwD2
	cca4SZ3NYT8NHU0pwfsSY5OUEB/BqqU/kQ973xpUaWZG/ERPvoQR
X-Google-Smtp-Source: AGHT+IEERyee8yuMkqt0ER6m9QzckotlvCf7D5ZemQxV4YVnYPTWKduYZ7ohuFoSiKwCKIa+Cet3hw==
X-Received: by 2002:a17:902:dace:b0:20c:5cdd:a91 with SMTP id d9443c01a7336-210f76d6870mr381219045ad.41.1730883689798;
        Wed, 06 Nov 2024 01:01:29 -0800 (PST)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d380fsm91317665ad.240.2024.11.06.01.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 01:01:29 -0800 (PST)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Wed, 06 Nov 2024 16:58:52 +0800
Subject: [PATCH 2/2] ARM: dts: aspeed: catalina: add hdd board cpld ioexp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241106-catalina-cpld-ioexp-update-v1-2-3437bcfcb608@gmail.com>
References: <20241106-catalina-cpld-ioexp-update-v1-0-3437bcfcb608@gmail.com>
In-Reply-To: <20241106-catalina-cpld-ioexp-update-v1-0-3437bcfcb608@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Potin Lai <potin.lai@quantatw.com>, Cosmo Chou <cosmo.chou@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730883681; l=2784;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=Ma7zHm/VTawO0uhZBJJdi+x5g2IFHZE6w9ObR9Dz8mM=;
 b=9Mfn75WH2EHATjpkT8yHXktIYSE/oom0no6vIbpn29BER7AETsF/1yGpaSr1mOLp8P1Z7Jnx7
 BC/PFZV9qOlBWzy0AXX0GZ8TtazizPmWZFVoFLekpIsrhZ5YsIhjCBL
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add HDD board CPLD IO expender based on latest CPLD firmware support.

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



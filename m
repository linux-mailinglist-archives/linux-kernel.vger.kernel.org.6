Return-Path: <linux-kernel+bounces-298321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D207A95C5B9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 539B31F21C2B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 06:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7082513A41F;
	Fri, 23 Aug 2024 06:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CibmFnwt"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2988813635F;
	Fri, 23 Aug 2024 06:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724395414; cv=none; b=Nb25ei+yXnvPWOnf1RaDbLIlHFVLsSrzS5HtEN3JrZfPpY4IkLsDmRzMqqW+KVD0etjWdXSe0k3AurCYhQNsV3LOOdKaPThzPEKMfZwmBqRPRMXolg8yHK4jbjfDd9Q9drT5Q+1kUclkB5VEFrA0wnsHN4MafFXOKK/AQjjQ0vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724395414; c=relaxed/simple;
	bh=8B2Kdifg6ohVXbBcb3ikIS2CYpY8L4Xytwog8dey6KQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J2PZMTTLmV6QzlDuuFqGpuYbIvIFNurk+WxIerzX2TH0j8px1yzboZ+GwfajQ5qVrfbu3ZLA+9PNMox4OKtWaA70Ob2cxLqwTL5dPwgW+s3wAyyQ0OAS0TGa2N4gbxRXJo9HJVFPW7OM5VQNH6KJczkGPtbeqC0YtDowmV5NHfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CibmFnwt; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-201cd78c6a3so11504515ad.1;
        Thu, 22 Aug 2024 23:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724395412; x=1725000212; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u9haRtJlDhH3as0n0sIs6bufmr/5Xn4xEdxe/ZlTMKs=;
        b=CibmFnwtfKHTRIsRB/Jzbw6E7AsQTKWXhO/s6ky4z7zTvFVPYfs9dXoBTZE+hN7OXi
         AxwIxjAusEiPsftNei89eAwnxtkMNsLScEf9hTesMQ7rml4bPZQQBOoK620DLgpSXuLj
         SJSXVK5ytts35vbGwYWj8lu6o/2GuhVaTxZRHimwA/GQfC/uu0AUwGGLUCp7hcLG1Br1
         QvpywkJfGyl5JTESewRKM/TXCY4prdH1U0if3nP5CScGiA5z3bgeVzOT8llMM2zVEUvI
         8uyR6uSgApN0fEgePjTixSouZEoKhUbERiM3uiXK4+RwX5Ax0E7TyUlXb8z/7MbCXaUf
         ZhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724395412; x=1725000212;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9haRtJlDhH3as0n0sIs6bufmr/5Xn4xEdxe/ZlTMKs=;
        b=kGCl/ulLwYGwO9ivX36Av/BLTIVjUqztUpgDIE75jIGqqkv7prtjPFWtO5Mpq9JfPG
         43DOrJt2r+9gYX/a2ptb+NCZGqNFiEg6Ohjz4yG/HCV/sAPFK3B8m4DVCrpFz+LhS6cv
         URDZSd69/c5gDDqgTu0a1bQAkIYkS2XZlte8Gn3PCr6/n637yeN+6Vl/9xXwrKPEk9qG
         fF+T9jl41pxKIJgEK9XuBGse6xacuWB3aoWmTvSwYdtsH8bkNBRD4V88fy7Wz89MtKkm
         cj9xhPTPinirkkBA87HdHt2VVNQ7PeD8IQXe/9sfuus3JotJ5XjYcU26SPsDbvz3TaUG
         vCzA==
X-Forwarded-Encrypted: i=1; AJvYcCVCbudQ3/B01PBCetGUjARunDwoGcx4znG/+SRnFCPZG1aNhCmbcPpwNrP9XIaN826qGfLZVIXHxvZR09s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhx1uX95IdqEQ86Q5F92Mnjv6xQ++xdnMZS3ucuVOY1nP7MMJ6
	mlS/IBTcB/N3j1NFcZ9ajp6H5gWz92ncv3wuOJYJGQqYNKMX0jeAOyYMZA==
X-Google-Smtp-Source: AGHT+IGHykukqXZCzMYZVYv87LpFox5BqZBfXjmpajZXWlmjvOg6skq9Mncp7YM2zOm8mjE8YAroaQ==
X-Received: by 2002:a17:902:ccc9:b0:203:a0c7:3156 with SMTP id d9443c01a7336-203a0c73186mr12510605ad.5.1724395411681;
        Thu, 22 Aug 2024 23:43:31 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385565468sm22339945ad.11.2024.08.22.23.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 23:43:31 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Fri, 23 Aug 2024 14:41:10 +0800
Subject: [PATCH 1/2] ARM: dts: aspeed: catalina: add pdb cpld io expander
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-catalina-ioexp-update-v1-1-4bfd8dad819c@gmail.com>
References: <20240823-catalina-ioexp-update-v1-0-4bfd8dad819c@gmail.com>
In-Reply-To: <20240823-catalina-ioexp-update-v1-0-4bfd8dad819c@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Potin Lai <potin.lai.pt@gmail.com>, Potin Lai <potin.lai@quantatw.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724395406; l=4747;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=8B2Kdifg6ohVXbBcb3ikIS2CYpY8L4Xytwog8dey6KQ=;
 b=M9JD45yHv2R8YpQiCh7GfQE1oGz/q/z8CmjFuFDwq4to3offqfYPnUn6fjJdwm5TPjdveOA+Z
 dt/h24syl+nCjA53OEiQMSH+a0OCTotHzzYXg3ZZ8Vt4MI1YJlbAZEX
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add more IO expanders which emulate by PDB CPLD.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 131 +++++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index a62c30f2c0df..3a00182084a5 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -762,6 +762,66 @@ eeprom@57 {
 
 &i2c14 {
 	status = "okay";
+
+	// PDB CPLD IOEXP 0x10
+	io_expander9: gpio@10 {
+		compatible = "nxp,pca9555";
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(I, 6) IRQ_TYPE_LEVEL_LOW>;
+		reg = <0x10>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	// PDB CPLD IOEXP 0x11
+	io_expander10: gpio@11 {
+		compatible = "nxp,pca9555";
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(I, 6) IRQ_TYPE_LEVEL_LOW>;
+		reg = <0x11>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	// PDB CPLD IOEXP 0x12
+	io_expander11: gpio@12 {
+		compatible = "nxp,pca9555";
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(I, 6) IRQ_TYPE_LEVEL_LOW>;
+		reg = <0x12>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	// PDB CPLD IOEXP 0x13
+	io_expander12: gpio@13 {
+		compatible = "nxp,pca9555";
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(I, 6) IRQ_TYPE_LEVEL_LOW>;
+		reg = <0x13>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	// PDB CPLD IOEXP 0x14
+	io_expander13: gpio@14 {
+		compatible = "nxp,pca9555";
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(I, 6) IRQ_TYPE_LEVEL_LOW>;
+		reg = <0x14>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	// PDB CPLD IOEXP 0x15
+	io_expander14: gpio@15 {
+		compatible = "nxp,pca9555";
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(I, 6) IRQ_TYPE_LEVEL_LOW>;
+		reg = <0x15>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
 };
 
 &i2c15 {
@@ -977,3 +1037,74 @@ &io_expander8 {
 		"SEC_FNP_L_CX0","SEC_FNP_L_CX1",
 		"","","","";
 };
+
+&io_expander9 {
+	gpio-line-names =
+		"LEAK3_DETECT_R","LEAK1_DETECT_R",
+		"LEAK2_DETECT_R","LEAK0_DETECT_R",
+		"CHASSIS3_LEAK_Q_N_PLD","CHASSIS1_LEAK_Q_N_PLD",
+		"CHASSIS2_LEAK_Q_N_PLD","CHASSIS0_LEAK_Q_N_PLD",
+		"P12V_AUX_FAN_ALERT_PLD_N","P12V_AUX_FAN_OC_PLD_N",
+		"P12V_AUX_FAN_FAULT_PLD_N","LEAK_DETECT_RMC_N_R",
+		"RSVD_RMC_GPIO3_R","SMB_RJ45_FIO_TMP_ALERT",
+		"","";
+};
+
+&io_expander10 {
+	gpio-line-names =
+		"FM_P12V_NIC1_FLTB_R_N","FM_P3V3_NIC1_FAULT_R_N",
+		"OCP_V3_2_PWRBRK_FROM_HOST_ISO_PLD_N",
+		"P12V_AUX_NIC1_SENSE_ALERT_R_N",
+		"FM_P12V_NIC0_FLTB_R_N","FM_P3V3_NIC0_FAULT_R_N",
+		"OCP_SFF_PWRBRK_FROM_HOST_ISO_PLD_N",
+		"P12V_AUX_NIC0_SENSE_ALERT_R_N",
+		"P12V_AUX_PSU_SMB_ALERT_R_L","P12V_SCM_SENSE_ALERT_R_N",
+		"NODEB_PSU_SMB_ALERT_R_L","NODEA_PSU_SMB_ALERT_R_L",
+		"P52V_SENSE_ALERT_PLD_N","P48V_HS2_FAULT_N_PLD",
+		"P48V_HS1_FAULT_N_PLD","";
+};
+
+&io_expander11 {
+	gpio-line-names =
+		"FAN_7_PRESENT_N","FAN_6_PRESENT_N",
+		"FAN_5_PRESENT_N","FAN_4_PRESENT_N",
+		"FAN_3_PRESENT_N","FAN_2_PRESENT_N",
+		"FAN_1_PRESENT_N","FAN_0_PRESENT_N",
+		"PRSNT_CHASSIS3_LEAK_CABLE_R_N","PRSNT_CHASSIS1_LEAK_CABLE_R_N",
+		"PRSNT_CHASSIS2_LEAK_CABLE_R_N","PRSNT_CHASSIS0_LEAK_CABLE_R_N",
+		"PRSNT_RJ45_FIO_N_R","PRSNT_HDDBD_POWER_CABLE_N",
+		"PRSNT_OSFP_POWER_CABLE_N","";
+};
+
+&io_expander12 {
+	gpio-line-names =
+		"RST_OCP_V3_1_R_N","NIC0_PERST_N",
+		"OCP_SFF_PERST_FROM_HOST_ISO_PLD_N","OCP_SFF_MAIN_PWR_EN",
+		"FM_OCP_SFF_PWR_GOOD_PLD","OCP_SFF_AUX_PWR_PLD_EN_R",
+		"HP_LVC3_OCP_V3_1_PWRGD_PLD","HP_OCP_V3_1_HSC_PWRGD_PLD_R",
+		"RST_OCP_V3_2_R_N","NIC1_PERST_N",
+		"OCP_V3_2_PERST_FROM_HOST_ISO_PLD_N","OCP_V3_2_MAIN_PWR_EN",
+		"FM_OCP_V3_2_PWR_GOOD_PLD","OCP_V3_2_AUX_PWR_PLD_EN_R",
+		"HP_LVC3_OCP_V3_2_PWRGD_PLD","HP_OCP_V3_2_HSC_PWRGD_PLD_R";
+};
+
+&io_expander13 {
+	gpio-line-names =
+		"NODEA_NODEB_PWOK_PLD_ISO_R","PWR_EN_NICS",
+		"PWRGD_P12V_AUX_FAN_PLD","P12V_AUX_FAN_EN_PLD",
+		"PWRGD_P3V3_AUX_PLD","PWRGD_P12V_AUX_PLD_ISO_R",
+		"FM_MAIN_PWREN_FROM_RMC_R","FM_MAIN_PWREN_RMC_EN_ISO_R",
+		"PWRGD_RMC_R","PWRGD_P12V_AUX_FAN_PLD",
+		"P12V_AUX_FAN_EN_PLD","FM_SYS_THROTTLE_N",
+		"HP_LVC3_OCP_V3_2_PRSNT2_PLD_N","HP_LVC3_OCP_V3_1_PRSNT2_PLD_N",
+		"","";
+};
+
+&io_expander14 {
+	gpio-line-names =
+		"","","","","","","","",
+		"FM_BOARD_BMC_SKU_ID3","FM_BOARD_BMC_SKU_ID2",
+		"FM_BOARD_BMC_SKU_ID1","FM_BOARD_BMC_SKU_ID0",
+		"FAB_BMC_REV_ID2","FAB_BMC_REV_ID1",
+		"FAB_BMC_REV_ID0","";
+};

-- 
2.31.1



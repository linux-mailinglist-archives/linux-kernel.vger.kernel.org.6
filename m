Return-Path: <linux-kernel+bounces-397861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4660B9BE187
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05B54281CA2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B6D1D90BD;
	Wed,  6 Nov 2024 09:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfFzij/2"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6B21D7E37;
	Wed,  6 Nov 2024 09:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883689; cv=none; b=TXweveo9xd9ep3c9ZIFetaimkc10DvV/HtUP1NPDpxYwhxnqOZKC4WtZWcuXoEszBsQ9oPiLuhYbfo/A6uEYXKQjL7yXHsMcA8/ayqKEQlalF1GFaaYjCzh6xybvIKtfydc+KcqVBotbCrt2fXkugynj3njtmnQgw6sVSfXeiKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883689; c=relaxed/simple;
	bh=nyuZFMsNp/CjM9UzYTg0cqEV/NdG/xPxUypZLXNSJj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U2WZ2MmSVOvzEoo5kQXfVJMvSQ6ZPf/vfyWc08FdeDfTc5ckh6ig+Jo5Y/DHlkxk0AbCt51Da0vO0ryMe6NfrLADUPdw+g578LFV19gWqUHFuPqHGsQP7LXyps9VznYkRmz7LG6BPSoehbbadw5MEW1wSP1UJlOZxP2lhmdRFAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfFzij/2; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2110a622d76so49250795ad.3;
        Wed, 06 Nov 2024 01:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730883687; x=1731488487; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gkHWyYIKfFDhAZ5vn6/ZhGd9wV02p4FQmn3m/eJ5Tsc=;
        b=gfFzij/25NOx2X+1iaxesrAhgPY4bbPR9b6eSdvmYguMK9dbprfCx3+if0pd8MsXw0
         3C9R9Xa0DUbQXN/zaLZ1sfwf+c4/kDIWcNfG9/mmwi6TJ9LUuplw41FlJGLq2US8S8j1
         /RqA5Qnm9vSXdFJVoSTx/so+waTYq1OsO5IQXUSCz8BjeUld1/y7I3ApsiCZwanz93Na
         iR8m9rMnfbGP2fHYOgPb4FnBRKzW+2DAK+HWdvhDKfJOIZdzulMY6murcNH/7B/jMi9M
         Iddv1Dds5Budpj1LTI4FDHtaZQHUjbSIXh8G1INAV87kbxAbkdEpZhQLI5EBH8HPhUZZ
         I+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730883687; x=1731488487;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkHWyYIKfFDhAZ5vn6/ZhGd9wV02p4FQmn3m/eJ5Tsc=;
        b=dcQtxNEJDomauR34oBZKemnuZKLWy8ymQ3e3iKVikM/rfQKhmF4Lwi8taSgTOMYed+
         AqtA5iJ5F/K38o8VZAQsUZNoy20G69WZU/BLKoecemaLxx9/emI5AavrDOJpMWqSv4aM
         tWsXh/sb0vvEENn6FzBl6YcwbCWC1OF+0ldtr+HaoodPuU7DKew48u6TgTfEWnisJOhI
         8Kps5QqMniOL83isZvINwGg0uHFSSa97hiYT6bR6K9sbofQL850cowYl/iGkNJn6PEPb
         tuZx4x6pIuKEtU/klB2CN1WwETQe5tb50LlFcl9MNnrSFVmXqsHho0i2fWLpkyajKhf9
         WDDA==
X-Forwarded-Encrypted: i=1; AJvYcCU/ZwCcSPb4nlWdFCJGK6jRPFTsHEgRwM0rgbJkvyFNITe8gCCclxiw1TCFo6LJixgBsZKMAoIfs926TnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzbHV1JdzXGD04BU0VN8xhG9AjX7IE6TH9yqmIRgnXiIh9zPgd
	AUtnV0k2dRfhazi0C/P1i9JTzp9hdoiGPBF5YDdvC936W7r8VEFB
X-Google-Smtp-Source: AGHT+IHkffsRtd6EA2zoMDxncdUpDGCX04PghiP3RUmDMHfbnoPeC+5oXmEJ9X6fEookxlW1OKhnOg==
X-Received: by 2002:a17:902:db0f:b0:20c:9c09:8280 with SMTP id d9443c01a7336-210c6cc207amr494628845ad.54.1730883687187;
        Wed, 06 Nov 2024 01:01:27 -0800 (PST)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d380fsm91317665ad.240.2024.11.06.01.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 01:01:26 -0800 (PST)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Wed, 06 Nov 2024 16:58:51 +0800
Subject: [PATCH 1/2] ARM: dts: aspeed: catalina: update pdb board cpld
 ioexp linename
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241106-catalina-cpld-ioexp-update-v1-1-3437bcfcb608@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730883681; l=5069;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=nyuZFMsNp/CjM9UzYTg0cqEV/NdG/xPxUypZLXNSJj8=;
 b=Ze0ie0kcmnjxo/e5uJQYgqpRrMIjUT1WXgfcU6c8AqMXDe68EhULrw20/M9OKtdFRqbSHmuKZ
 nsLJsIq2guHAK5hSFXmN0DT4nM77oThw4ZITq853Oe8pam8MrMEQ4I0
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Update the GPIO linename of each PDB CPLD IO expander based on latest
CPLD firmware.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 99 +++++++---------------
 1 file changed, 29 insertions(+), 70 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 82835e96317d..10a9fca1b803 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -802,26 +802,6 @@ io_expander12: gpio@13 {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
-
-	// PDB CPLD IOEXP 0x14
-	io_expander13: gpio@14 {
-		compatible = "nxp,pca9555";
-		interrupt-parent = <&gpio0>;
-		interrupts = <ASPEED_GPIO(I, 6) IRQ_TYPE_LEVEL_LOW>;
-		reg = <0x14>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
-	// PDB CPLD IOEXP 0x15
-	io_expander14: gpio@15 {
-		compatible = "nxp,pca9555";
-		interrupt-parent = <&gpio0>;
-		interrupts = <ASPEED_GPIO(I, 6) IRQ_TYPE_LEVEL_LOW>;
-		reg = <0x15>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
 };
 
 &i2c15 {
@@ -1040,71 +1020,50 @@ &io_expander8 {
 
 &io_expander9 {
 	gpio-line-names =
-		"LEAK3_DETECT_R","LEAK1_DETECT_R",
-		"LEAK2_DETECT_R","LEAK0_DETECT_R",
-		"CHASSIS3_LEAK_Q_N_PLD","CHASSIS1_LEAK_Q_N_PLD",
-		"CHASSIS2_LEAK_Q_N_PLD","CHASSIS0_LEAK_Q_N_PLD",
-		"P12V_AUX_FAN_ALERT_PLD_N","P12V_AUX_FAN_OC_PLD_N",
-		"P12V_AUX_FAN_FAULT_PLD_N","LEAK_DETECT_RMC_N_R",
-		"RSVD_RMC_GPIO3_R","SMB_RJ45_FIO_TMP_ALERT",
-		"","";
+		"wSequence_Latch_State_N","wP12V_N1N2_RUNTIME_FLT_N",
+		"wP12V_FAN_RUNTIME_FLT_N","wP12V_AUX_RUNTIME_FLT_N",
+		"wHost_PERST_SEQPWR_FLT_N","wP12V_N1N2_SEQPWR_FLT_N",
+		"wP12V_FAN_SEQPWR_FLT_N","wP12V_AUX_SEQPWR_FLT_N",
+		"wP12V_RUNTIME_FLT_NIC1_N","wAUX_RUNTIME_FLT_NIC1_N",
+		"wP12V_SEQPWR_FLT_NIC1_N","wAUX_SEQPWR_FLT_NIC1_N",
+		"wP12V_RUNTIME_FLT_NIC0_N","wAUX_RUNTIME_FLT_NIC0_N",
+		"wP12V_SEQPWR_FLT_NIC0_N","wAUX_SEQPWR_FLT_NIC0_N";
 };
 
 &io_expander10 {
 	gpio-line-names =
 		"FM_P12V_NIC1_FLTB_R_N","FM_P3V3_NIC1_FAULT_R_N",
-		"OCP_V3_2_PWRBRK_FROM_HOST_ISO_PLD_N",
-		"P12V_AUX_NIC1_SENSE_ALERT_R_N",
 		"FM_P12V_NIC0_FLTB_R_N","FM_P3V3_NIC0_FAULT_R_N",
-		"OCP_SFF_PWRBRK_FROM_HOST_ISO_PLD_N",
-		"P12V_AUX_NIC0_SENSE_ALERT_R_N",
+		"P48V_HS2_FAULT_N_PLD","P48V_HS1_FAULT_N_PLD",
+		"P12V_AUX_FAN_OC_PLD_N","P12V_AUX_FAN_FAULT_PLD_N",
+		"","",
+		"","",
+		"","FM_SYS_THROTTLE_N",
+		"OCP_V3_2_PWRBRK_FROM_HOST_ISO_PLD_N",
+		"OCP_SFF_PWRBRK_FROM_HOST_ISO_PLD_N";
+};
+
+&io_expander11 {
+	gpio-line-names =
 		"P12V_AUX_PSU_SMB_ALERT_R_L","P12V_SCM_SENSE_ALERT_R_N",
+		"P12V_AUX_NIC1_SENSE_ALERT_R_N","P12V_AUX_NIC0_SENSE_ALERT_R_N",
 		"NODEB_PSU_SMB_ALERT_R_L","NODEA_PSU_SMB_ALERT_R_L",
-		"P52V_SENSE_ALERT_PLD_N","P48V_HS2_FAULT_N_PLD",
-		"P48V_HS1_FAULT_N_PLD","";
+		"P12V_AUX_FAN_ALERT_PLD_N","P52V_SENSE_ALERT_PLD_N",
+		"PRSNT_RJ45_FIO_N_R","FM_MAIN_PWREN_RMC_EN_ISO_R",
+		"CHASSIS3_LEAK_Q_N_PLD","CHASSIS2_LEAK_Q_N_PLD",
+		"CHASSIS1_LEAK_Q_N_PLD","CHASSIS0_LEAK_Q_N_PLD",
+		"","SMB_RJ45_FIO_TMP_ALERT";
 };
 
-&io_expander11 {
+&io_expander12 {
 	gpio-line-names =
 		"FAN_7_PRESENT_N","FAN_6_PRESENT_N",
 		"FAN_5_PRESENT_N","FAN_4_PRESENT_N",
 		"FAN_3_PRESENT_N","FAN_2_PRESENT_N",
 		"FAN_1_PRESENT_N","FAN_0_PRESENT_N",
-		"PRSNT_CHASSIS3_LEAK_CABLE_R_N","PRSNT_CHASSIS1_LEAK_CABLE_R_N",
-		"PRSNT_CHASSIS2_LEAK_CABLE_R_N","PRSNT_CHASSIS0_LEAK_CABLE_R_N",
-		"PRSNT_RJ45_FIO_N_R","PRSNT_HDDBD_POWER_CABLE_N",
-		"PRSNT_OSFP_POWER_CABLE_N","";
-};
-
-&io_expander12 {
-	gpio-line-names =
-		"RST_OCP_V3_1_R_N","NIC0_PERST_N",
-		"OCP_SFF_PERST_FROM_HOST_ISO_PLD_N","OCP_SFF_MAIN_PWR_EN",
-		"FM_OCP_SFF_PWR_GOOD_PLD","OCP_SFF_AUX_PWR_PLD_EN_R",
-		"HP_LVC3_OCP_V3_1_PWRGD_PLD","HP_OCP_V3_1_HSC_PWRGD_PLD_R",
-		"RST_OCP_V3_2_R_N","NIC1_PERST_N",
-		"OCP_V3_2_PERST_FROM_HOST_ISO_PLD_N","OCP_V3_2_MAIN_PWR_EN",
-		"FM_OCP_V3_2_PWR_GOOD_PLD","OCP_V3_2_AUX_PWR_PLD_EN_R",
-		"HP_LVC3_OCP_V3_2_PWRGD_PLD","HP_OCP_V3_2_HSC_PWRGD_PLD_R";
-};
-
-&io_expander13 {
-	gpio-line-names =
-		"NODEA_NODEB_PWOK_PLD_ISO_R","PWR_EN_NICS",
-		"PWRGD_P12V_AUX_FAN_PLD","P12V_AUX_FAN_EN_PLD",
-		"PWRGD_P3V3_AUX_PLD","PWRGD_P12V_AUX_PLD_ISO_R",
-		"FM_MAIN_PWREN_FROM_RMC_R","FM_MAIN_PWREN_RMC_EN_ISO_R",
-		"PWRGD_RMC_R","PWRGD_P12V_AUX_FAN_PLD",
-		"P12V_AUX_FAN_EN_PLD","FM_SYS_THROTTLE_N",
 		"HP_LVC3_OCP_V3_2_PRSNT2_PLD_N","HP_LVC3_OCP_V3_1_PRSNT2_PLD_N",
-		"","";
+		"PRSNT_HDDBD_POWER_CABLE_N","PRSNT_OSFP0_POWER_CABLE_N",
+		"PRSNT_CHASSIS3_LEAK_CABLE_R_N","PRSNT_CHASSIS2_LEAK_CABLE_R_N",
+		"PRSNT_CHASSIS1_LEAK_CABLE_R_N","PRSNT_CHASSIS0_LEAK_CABLE_R_N";
 };
 
-&io_expander14 {
-	gpio-line-names =
-		"","","","","","","","",
-		"FM_BOARD_BMC_SKU_ID3","FM_BOARD_BMC_SKU_ID2",
-		"FM_BOARD_BMC_SKU_ID1","FM_BOARD_BMC_SKU_ID0",
-		"FAB_BMC_REV_ID2","FAB_BMC_REV_ID1",
-		"FAB_BMC_REV_ID0","";
-};

-- 
2.31.1



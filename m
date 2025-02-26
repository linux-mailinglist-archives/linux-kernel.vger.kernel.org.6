Return-Path: <linux-kernel+bounces-534037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47813A461E7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56B483AA37C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A7E221713;
	Wed, 26 Feb 2025 14:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="PIDCdYmk"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DD421D3C4
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579039; cv=none; b=UhOzZLEYZAQTKVu5dYy++/02OhZtP/qGMB5cKS8bg0wajpDNEpcAPQ31dAiNY+jPq9JjNOcMRE6C4KXn38AqtYBhWrf37W74AOSizCs6LKKW/6pEvgEgXVYiw7ADftwR42lQXDC1NLZzdzKnpBeapfBwT50oXkDMu67vKCnyCKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579039; c=relaxed/simple;
	bh=fn8elkgRSR/QPq4nFjI5143Zz5iXEhgsAPkbVKceBko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uabLHrXscnAEvSrd/FnldxerE9gBb4sPDGeIgSyO4fU9nhSqKJSkMBXy9l6EOErQuxOUVGrK8IGtfNuuD5yb5dzxTCRuv/ZuZCBoJV1u/8kCdWG1NDmma/OHCyxbmCnRTqd9+T9uWPgjJEARqNCrnGNPZLeuAcOq1NVT+GCbTAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=PIDCdYmk; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38f1e8efef5so4021704f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1740579036; x=1741183836; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/K2OVzTJIisVIYeYej3QITbMMoKoqZpffJDULuTMdQ=;
        b=PIDCdYmkb+viuEaKGbYhv8RhEv7bB4X5HcqmHkAMSNwDmC20DLBSqgr20/i7DFYvTs
         TQmAz991JunpZkQfqV8QjmI+3YKDsMZt6Gnma6exmWMQ6qhZw9lgY9HCC36pAl2ifBdN
         N/oaoXuxwq7Dw903SRJRk+yWPWadJsD4+fd4c5z5yJzW485Ux3Vcx5AJZu093zwrOBqb
         X1xCxE6FFHltlc7vpQYT1EKo6jAI9UQK2iOEyOhVjqgNQWFNx3Hiy8VaynCJImCNitpY
         qh+mEy0r9hMHa9Z8qD9SRnRBR3LjSoOzATYQVEaya+YmhNykDBo7icK+71f327ZFtKvM
         Do0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740579036; x=1741183836;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/K2OVzTJIisVIYeYej3QITbMMoKoqZpffJDULuTMdQ=;
        b=AuMcmDMteGfqM/Z7punx+clBV/tVL4tO6ruiRWOUdgPhrX42jQZ/cfHjc7/iqET5zs
         XtZIqXRxuv4v+qU3Le8zPpMHtOJweKcQFcGLBbkZ+SbCpWUcJi3KesoJMf9tl2M2EsWH
         6gO2DBfp1++Zwl2mknUkTI9XLRcZFwCXpLIikutzAa3Y49au9yAqyiE9KHxP6COashnk
         FZUBDIPAkcQuYkO7JrCZKhedAYndizuZ7QPOA37/SzG/ybhZKKDnDRJAbItZ3aQiHPIk
         O9OJWGNB81PSqs5iG+cmtRGEmOgxaaXmlOGbo1FpEAaFb57nwnVdJvPOodDP6XYmtt9p
         rjtw==
X-Forwarded-Encrypted: i=1; AJvYcCXb6ZVo1MjKr8JSM7Sx1zxcff8aKR//uOHbGDtHCHF/wdaQzI8qITDzn5PjLzutvYLzlpPUl27vaEHpF1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs5Ik+AOJmsiQYDnjtiGm3Ugb74H7BKd2uC4cVKuIQxehscySC
	bOyo00stHi3vmrDWjwnynkNCj6T169yE3nZAQTb1JrvXb2HxWBhajABK+xnC0Ok=
X-Gm-Gg: ASbGncvtGvrrl/cZXlVGf/mi65QOzVMc6QTVh5zLaDVeXbFRU0cn+hKWulTmNMeiziL
	OV4isfQtAFbBzpDc3AAO31ZsshbVeIm4bWi+EmJllV1OioBn8JtnI6s2MsHuuPc/qV2ECwxrBON
	TvxGb7m8grd+T94MkPqUpT8FjmqzQn15Bsha37E8HJ47PYo9KFMIHViHaCeWEsdMHXvN4dcy2NY
	MsiRrO3mdTDucvUNMDxyDw1fG7VavuBf8W2CqzExBpQCZ2QGAMIziIKy/BkhVcoLyyDeHmXXEHX
	VyXeMRjxU+I3tRqN6jjILp2GrIsSO6kxVODYEtJrhTAN2FlZ8mIXk6BDETLvK4GDprjoKY5KQ+Y
	=
X-Google-Smtp-Source: AGHT+IHoDmGXmyYKL/H0wIDHVZGgyglIAMrlTqOFlOQMhza3hOMOrfR6i0sWAbH8R3O6AiDzN0jNyA==
X-Received: by 2002:a05:6000:1fad:b0:390:dfbb:640 with SMTP id ffacd0b85a97d-390dfbb06dbmr443616f8f.45.1740579035700;
        Wed, 26 Feb 2025 06:10:35 -0800 (PST)
Received: from [100.64.0.4] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd70be4csm5755889f8f.0.2025.02.26.06.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 06:10:34 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 26 Feb 2025 15:10:18 +0100
Subject: [PATCH 1/3] arm64: dts: qcom: qcm6490-fairphone-fp5: Add PTN36502
 redriver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-fp5-pmic-glink-dp-v1-1-e6661d38652c@fairphone.com>
References: <20250226-fp5-pmic-glink-dp-v1-0-e6661d38652c@fairphone.com>
In-Reply-To: <20250226-fp5-pmic-glink-dp-v1-0-e6661d38652c@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2

Add a node for the "Type-C USB 3.1 Gen 1 and DisplayPort v1.2 combo
redriver" found on this device.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 32 +++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
index 582b19277de414fa9cbb8f9929c6eebd697e8033..3c134d28e0c1965de55356af9c19c1331b029669 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
@@ -166,6 +166,23 @@ vreg_oled_vci: regulator-oled-vci {
 		regulator-boot-on;
 	};
 
+	vreg_usb_redrive_1v8: regulator-usb-redrive-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "USB_REDRIVE_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		gpio = <&tlmm 61 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		vin-supply = <&vreg_bob>;
+
+		regulator-boot-on;
+
+		pinctrl-0 = <&usb_redrive_1v8_en_default>;
+		pinctrl-names = "default";
+	};
+
 	reserved-memory {
 		cont_splash_mem: cont-splash@e1000000 {
 			reg = <0x0 0xe1000000 0x0 0x2300000>;
@@ -747,7 +764,12 @@ &i2c2 {
 &i2c4 {
 	status = "okay";
 
-	/* PTN36502 USB redriver @ 1a */
+	typec-mux@1a {
+		compatible = "nxp,ptn36502";
+		reg = <0x1a>;
+
+		vdd18-supply = <&vreg_usb_redrive_1v8>;
+	};
 };
 
 &i2c9 {
@@ -1183,6 +1205,14 @@ sw_ctrl_default: sw-ctrl-default-state {
 		function = "gpio";
 		bias-pull-down;
 	};
+
+	usb_redrive_1v8_en_default: usb-redrive-1v8-en-default-state {
+		pins = "gpio61";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		output-high;
+	};
 };
 
 &uart5 {

-- 
2.48.1



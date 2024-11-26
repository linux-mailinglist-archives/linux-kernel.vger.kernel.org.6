Return-Path: <linux-kernel+bounces-422147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FE09D9522
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 11:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23F141664B8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 10:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7826E1BFE0C;
	Tue, 26 Nov 2024 10:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZNLNE8qZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3401B4F08
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 10:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732615716; cv=none; b=k2CxhPW4Iwap3uNsHe0esZx00g/ZHfJyyjwRj3hs838JKtBC06l0vm3Iqg7B96Eva1HxJZtcPcAnfSnNTrSCX0q8xuY6ar5bbg5lVrctlpWNE/DdmSGXJ2iqVJNsyvdS5U96OSil/XJk6CeWdBRfaWI8QVovj+fX4PX7NFoP0ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732615716; c=relaxed/simple;
	bh=5lJZ/nF8cuFm2xPe38in1zalOui1QM9koL2E5RnWTsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=h44Oqle1FEeRMidOCD1l8aj0zNLsGhMQK+nyETnU7r7q7GVuAalV8w/nn1vKYllX0K1OqSg9ipSpAiosXGz+EQ23sCwMtE5Jq5N/9a/sBuOlFkeeHX7atm9E8HRtMZqXlO9hTRI9E9DntPMxc3RlhvVPcGeCyns2hHQ22DgCHu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZNLNE8qZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732615713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Fq9q0biky9OpRw0dbtbwOh/TCxHi9sqzOOofCo6yTKw=;
	b=ZNLNE8qZ+drDfzeYl7JBXprUK5fln4N0Zrv/6PMKDJoTz6TbjJuMmHd0zGUqxCKxT6GDDs
	VLjIlEP0O0hR0hto5uV1563deLc7D/M5ILfrXiz43/CUDjjOyKNJHbigmiYJBqRx2zzr8i
	PP0U+ABT1dBi/v/g/eY7cYI/A4ipIYc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-1TMbgP29OLCVA2dmw90Cvg-1; Tue, 26 Nov 2024 05:08:27 -0500
X-MC-Unique: 1TMbgP29OLCVA2dmw90Cvg-1
X-Mimecast-MFC-AGG-ID: 1TMbgP29OLCVA2dmw90Cvg
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-434a0c4643eso2370865e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 02:08:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732615706; x=1733220506;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fq9q0biky9OpRw0dbtbwOh/TCxHi9sqzOOofCo6yTKw=;
        b=hLwn7m/auD7eIBuFbFJDSlKBwYGQnWEfoijTqPKXoL0B5shuG5EgoNVu6GkA65To4n
         wnXtZuCysGI6suUE6V3qnwFNNwlvY8PjG4OuatjclwySJKk11DMuM7MoDpiYgsf1XXfN
         GFOaCvl+FTJSD0kB7hEoxIPdTB7ElV5M5tcPnKP392mLKR3YhUsyRDtbnIAEkMGaUWF9
         Bw36/OtGX/C3XKH8sc3JTdVKNjdE2cC0e7wKgFyKJ/HnDPkmZ0N3PUjqxztFFGn2kEw1
         diE7Be98L9JMZRcoU9SpT+JYk8klz/IfDuM4qirRcabbgRIDh6sxWi1yQOrsPAsJL0oq
         ajig==
X-Forwarded-Encrypted: i=1; AJvYcCWlwemSUNayRh2NN5s05f/1GI3Gzx4TpBUyNcOzlx4bQW8dLPPtgsI0EVJfHVM1AiuVcqLoCeu9CuTrp7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YznlmWtNkcY6fLulGII82dhKzgkour4XRyD2tUcbU+p/GVjAJIl
	Q6OERTdAAPTMmHyP/hNQ78ZtbLWrN5bnotj7GSYRcsaVt0qrCfEUELqq2s2cqRHTnat2FLkYkH5
	EeKwZkjYLpotvo6lTImDrPuFSBr3tyCsoI/0IaWUwSbo+T9uiRYa76c6X+gDUYQ==
X-Gm-Gg: ASbGncuPi5/x2G4JnjHcHAshss4NLx0eCRPuqXleaoT9VzqBjHGUVbIdxRO1mEi88AW
	D4BbUWaOvfZ8hpU5XF0G60KHJJk0jbxfmEk9aHnqb+PwGQLXGrA4MHxre4CTExbVmK6mqNpqJUo
	vyTerWjQKK9u497T2k+Z1/GmGdQUO9maXFmqiQ1bWP887Epq7dMm7VPLP46Fm8NSyZyrQ0WTrjP
	DI/tlOYDy3DhdromUOXBz/rlMzlE1LUgvaiDK6vtdjxepFHiPIJjf8g+a8hSTSJG/p6tCwT8cmt
	u1lNhHrFblup2mN4
X-Received: by 2002:a05:600c:5490:b0:42c:b63d:df3 with SMTP id 5b1f17b1804b1-434a35089e5mr13353305e9.0.1732615706552;
        Tue, 26 Nov 2024 02:08:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcdvb3S8cnPM7PxynTPeWCPWcNAxtPzHc8ZlB/++BpaqHt+EG4RUx3doFnbJGVCosm9yICXg==
X-Received: by 2002:a05:600c:5490:b0:42c:b63d:df3 with SMTP id 5b1f17b1804b1-434a35089e5mr13353195e9.0.1732615706130;
        Tue, 26 Nov 2024 02:08:26 -0800 (PST)
Received: from [192.168.1.51] (50.red-83-45-91.dynamicip.rima-tde.net. [83.45.91.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fb4ecd8sm12851203f8f.60.2024.11.26.02.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 02:08:25 -0800 (PST)
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Tue, 26 Nov 2024 11:08:19 +0100
Subject: [PATCH] arm64: dts: ti: k3-am69-sk: Add USB SuperSpeed support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241126-am69sk-dt-usb-v1-1-aa55aed7b89e@redhat.com>
X-B4-Tracking: v=1; b=H4sIABKeRWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQyMz3cRcM8vibN2UEt3S4iRdC0tDC4PUNFOLNIsUJaCegqLUtMwKsHn
 RsbW1AD6mwZFfAAAA
X-Change-ID: 20241126-am69sk-dt-usb-89180ef58f8d
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dasnavis Sabiya <sabiya.d@ti.com>, 
 Enric Balletbo i Serra <eballetb@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732615705; l=2485;
 i=eballetb@redhat.com; s=20241113; h=from:subject:message-id;
 bh=bT/35JMF1+qLpDfXB2Q3jx1Ol/t4nxsjkwGX8bY51Jo=;
 b=7jrfrXs1ya8OfzpPtuUbESrW1gPpkkr97NF+q5NtsQDPkoHtxktfWvCWP3xFRyuifAGaqF1sa
 CY6Hs9aSQoPAGPlL1ge9DEYSisj6VWHBHQ2Kv9gb5vkRvlYiHceUzg3
X-Developer-Key: i=eballetb@redhat.com; a=ed25519;
 pk=xAM6APjLnjm98JkE7JdP1GytrxFUrcDLr+fvzW1Dlyw=

From: Dasnavis Sabiya <sabiya.d@ti.com>

AM69 SK board has two stacked USB3 connectors:
   1. USB3 (Stacked TypeA + TypeC)
   2. USB3 TypeA Hub interfaced through TUSB8041.

The board uses SERDES0 Lane 3 for USB3 IP. So update the
SerDes lane info for PCIe and USB. Add the pin mux data
and enable USB 3.0 support with its respective SERDES settings.

Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
Signed-off-by: Enric Balletbo i Serra <eballetb@redhat.com>
---
I've been carrying this patch for quite long time in my builds to have
support for USB on my AM69-SK board without problems. For some reason this
patch was never send to upstream or I couldn't find it. So I took the
opportunity, now that I rebased my build, to send upstream.

I have maintained the original author of the downstream patch as is
basically his work.
---
 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index 1e36965a14032ca07143230855e04b9549f1d0d1..72797f4b689c1d069bf395d6d4fe1846dc4e4297 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -484,6 +484,12 @@ J784S4_IOPAD(0x09C, PIN_OUTPUT, 0) /* (AF35) MCAN7_TX */
 		>;
 	};
 
+	main_usbss0_pins_default: main-usbss0-default-pins {
+		pinctrl-single,pins = <
+			J784S4_IOPAD(0x0EC, PIN_OUTPUT, 6) /* (AN37) TIMER_IO1.USB0_DRVVBUS */
+		>;
+	};
+
 };
 
 &wkup_pmx0 {
@@ -1299,6 +1305,14 @@ serdes0_pcie_link: phy@0 {
 		cdns,phy-type = <PHY_TYPE_PCIE>;
 		resets = <&serdes_wiz0 1>, <&serdes_wiz0 2>, <&serdes_wiz0 3>;
 	};
+
+	serdes0_usb_link: phy@3 {
+		reg = <3>;
+		cdns,num-lanes = <1>;
+		#phy-cells = <0>;
+		cdns,phy-type = <PHY_TYPE_USB3>;
+		resets = <&serdes_wiz0 4>;
+	};
 };
 
 &serdes_wiz1 {
@@ -1339,3 +1353,22 @@ &pcie3_rc {
 	phy-names = "pcie-phy";
 	num-lanes = <1>;
 };
+
+&usb_serdes_mux {
+	idle-states = <0>; /* USB0 to SERDES0 */
+};
+
+&usbss0 {
+	status = "okay";
+	pinctrl-0 = <&main_usbss0_pins_default>;
+	pinctrl-names = "default";
+	ti,vbus-divider;
+};
+
+&usb0 {
+	status = "okay";
+	dr_mode = "host";
+	maximum-speed = "super-speed";
+	phys = <&serdes0_usb_link>;
+	phy-names = "cdns3,usb3-phy";
+};

---
base-commit: 7eef7e306d3c40a0c5b9ff6adc9b273cc894dbd5
change-id: 20241126-am69sk-dt-usb-89180ef58f8d

Best regards,
-- 
Enric Balletbo i Serra <eballetb@redhat.com>



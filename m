Return-Path: <linux-kernel+bounces-319485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBB396FD3D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 23:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3E391F25879
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 21:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA28F158874;
	Fri,  6 Sep 2024 21:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h5WDz9z0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99616155C8C
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 21:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725657692; cv=none; b=Qpytf6mRIElSJ+fkxzhERsmIsPP+RV9fmObJLP0JZyOy3iia+TW7zbc+Q5eeoL6zBHurQf6mQZsc3IDs+vzI/CRt5FOjJ5E+eOgKmuB4P/n5mYBe2TW99M0Ed27RDndLQ7rd1NeKn6LOH2kx2ALZQsl+JbVntxZujGa60wHv6Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725657692; c=relaxed/simple;
	bh=4wrh8hQahACI+ZZpHT3lvTI36XIBS7sjGAZbt6wWCAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KKNg9/TZuJksy1Gk1juHbO/esByRt/CAOnnLm1IWDWqdOSPVwK3TcqRRP3yZHRue/TqpzvJzsUfNMkDVnYg539QvysswkciK7KDo2u+TtjZFxf3ZPCu10yZPst03UT02bIM4YxVq5EnyUMbEcBe/nX49blhKq3HRXifJ2ZuYZTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h5WDz9z0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725657689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rtuaKfmFG/cjqohk67SqCEs+Y7825qb5YDfTf6uC31Y=;
	b=h5WDz9z04Gdf0Z+ca1NOd2E6qqkEyQav/fbGp87xrKKHurnC9lpz21Lswtum3xKXu8YWkh
	DStFgQ0AL2T+SOtzxqosXOFXcDHb2N7f3jXzgYbqdZHte8OTDutNXDidXQBSTpLCcNO3IB
	qCO1vpnN2VejTXeZRYtSytaIKlIQz8E=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-qZCsB4ByNiOjbliTQBaVWg-1; Fri, 06 Sep 2024 17:21:28 -0400
X-MC-Unique: qZCsB4ByNiOjbliTQBaVWg-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4581d15ced1so9189811cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 14:21:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725657688; x=1726262488;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtuaKfmFG/cjqohk67SqCEs+Y7825qb5YDfTf6uC31Y=;
        b=JG8Qe+I1p8/NqCBvr/5FzkuGsLzb3xRsZYE6oNkXe2ZzKZGFo/Zv35aGUTdXUdHKvX
         7VXyASEO1sO8dk1jitHLskowEvUBSFwTTGQ2ybe3Hhm8sefQMNu587IsccjSQdxQla6P
         o0er2lXVZDzyiPX2yOkKF1855+9nr87dY17nvFUfSJdQJFH8cvQOkGDgPR6ZEgLq20E5
         eoYOzo2yPIJp7aXY/QflbYNjKDasRCe7i88EuMu1yVqqRjU7gtcLG5BB1nZe+0rrsKRJ
         GRm5p9OhvwuSzGms2s9MsZMH6o+2Lb0r1tmw3+vAwTKnmy5SDr4SgN7nB/1eYmNGh78b
         W1cg==
X-Forwarded-Encrypted: i=1; AJvYcCVkW0OxvJZvwVh6364VNR6lVPUwJ5QeQzCOA8i5onm6K2PK8yGGlBQA+vq+v7sm4uTiHBcfgQsHbF/j4k4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0kFa9LVH8ELQFBsVEVBsTTIftuE66gtraZ8dJgHBFc9nmGhG2
	34rzho1mSieV7nfdJTMEr+Jsb78dNmnSryF76uhSFV8l+aVkoOBYSrAMOzFCU/ojiFl5xy761Pv
	KB0gLydJvaXfLWmoeWs97hehRlCqtS08JbHSGR8icrq7cvxz7xeazsQ/hf7F52Q==
X-Received: by 2002:ac8:5956:0:b0:457:c6a3:acd2 with SMTP id d75a77b69052e-4580c74f3admr58722381cf.45.1725657687949;
        Fri, 06 Sep 2024 14:21:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFeTR/ORUTYHQZelmlFZlukyarwqQ1ssQ4OjtqV04N6yUGBj8UBHL2vsrn0D2ycJ4sqIBAgw==
X-Received: by 2002:ac8:5956:0:b0:457:c6a3:acd2 with SMTP id d75a77b69052e-4580c74f3admr58722021cf.45.1725657687514;
        Fri, 06 Sep 2024 14:21:27 -0700 (PDT)
Received: from x1gen2nano.local ([2600:1700:1ff0:d0e0::40])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4581add3a5esm4554791cf.74.2024.09.06.14.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 14:21:27 -0700 (PDT)
From: Andrew Halaney <ahalaney@redhat.com>
Date: Fri, 06 Sep 2024 16:21:02 -0500
Subject: [PATCH RFC/RFT 1/2] arm64: dts: ti: k3-j784s4-evm: Mark tps659413
 and children as bootph-all
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-j784s4-tps6594-bootph-v1-1-c5b58d43bf04@redhat.com>
References: <20240906-j784s4-tps6594-bootph-v1-0-c5b58d43bf04@redhat.com>
In-Reply-To: <20240906-j784s4-tps6594-bootph-v1-0-c5b58d43bf04@redhat.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Keerthy <j-keerthy@ti.com>, Neha Malcom Francis <n-francis@ti.com>, 
 Eric Chanudet <echanude@redhat.com>, Enric Balletbo <eballetb@redhat.com>, 
 Udit Kumar <u-kumar1@ti.com>, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>
X-Mailer: b4 0.14.1

In order for the MCU domain to access this PMIC and its children in
u-boot SPL, the nodes need to be marked appropriately otherwise they
are not seen by SPL.

This is necessary if the MCU domain is to program the TPS6594 MCU ESM
state machine, which is required to wire up the watchdog in a manner
that will reset the board.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index 6695ebbcb4d0..044a428136df 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -642,6 +642,7 @@ eeprom@50 {
 	};
 
 	tps659413: pmic@48 {
+		bootph-all;
 		compatible = "ti,tps6594-q1";
 		reg = <0x48>;
 		system-power-controller;
@@ -662,7 +663,10 @@ tps659413: pmic@48 {
 		ldo4-supply = <&vsys_3v3>;
 
 		regulators {
+			bootph-all;
+
 			bucka12: buck12 {
+				bootph-all;
 				regulator-name = "vdd_ddr_1v1";
 				regulator-min-microvolt = <1100000>;
 				regulator-max-microvolt = <1100000>;
@@ -671,6 +675,7 @@ bucka12: buck12 {
 			};
 
 			bucka3: buck3 {
+				bootph-all;
 				regulator-name = "vdd_ram_0v85";
 				regulator-min-microvolt = <850000>;
 				regulator-max-microvolt = <850000>;
@@ -679,6 +684,7 @@ bucka3: buck3 {
 			};
 
 			bucka4: buck4 {
+				bootph-all;
 				regulator-name = "vdd_io_1v8";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
@@ -687,6 +693,7 @@ bucka4: buck4 {
 			};
 
 			bucka5: buck5 {
+				bootph-all;
 				regulator-name = "vdd_mcu_0v85";
 				regulator-min-microvolt = <850000>;
 				regulator-max-microvolt = <850000>;
@@ -695,6 +702,7 @@ bucka5: buck5 {
 			};
 
 			ldoa1: ldo1 {
+				bootph-all;
 				regulator-name = "vdd_mcuio_1v8";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
@@ -703,6 +711,7 @@ ldoa1: ldo1 {
 			};
 
 			ldoa2: ldo2 {
+				bootph-all;
 				regulator-name = "vdd_mcuio_3v3";
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
@@ -711,6 +720,7 @@ ldoa2: ldo2 {
 			};
 
 			ldoa3: ldo3 {
+				bootph-all;
 				regulator-name = "vds_dll_0v8";
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <800000>;
@@ -719,6 +729,7 @@ ldoa3: ldo3 {
 			};
 
 			ldoa4: ldo4 {
+				bootph-all;
 				regulator-name = "vda_mcu_1v8";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;

-- 
2.46.0



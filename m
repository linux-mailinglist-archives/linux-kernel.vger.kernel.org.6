Return-Path: <linux-kernel+bounces-371379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 582A39A3A4B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF8891F28C08
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8FB200B89;
	Fri, 18 Oct 2024 09:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ls/AhFx3"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CED4190665
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729244575; cv=none; b=WYFpXuNXNOAUJQY9C2arBn7Kp+9Sf8GPuatka+A5cHOnTSmMcmUw1K4lZAPwN90hzBkXRodcx3C9HwIHASJxQnsup9SV/5BlJKNLQySOyFAFkdKzeAjOf7QSrEDHuKuy8ccI5moIU6NyeqoPh4y37sxb4dvf58VU9aJdfo45gFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729244575; c=relaxed/simple;
	bh=goetKS06Cs0zBry8+Bo9tHIjGbRiGmdmJDgP7hIR1M4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jVrk/1CxhlO3VR5AHnxnhdiRc6oerEB2FDqwEouMeBOUnevPo062VxjqmNn07XXMAeDWdPdh0aABD2xtTIspvmV/M3bBOcquoJJE9KJpXeeXaluY/WwpzKiG149XuNNIpK3zgjbNNrZrC7nTY1q2gCyagGmImzcZ9jZmHQpLA1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jakiela.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ls/AhFx3; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jakiela.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e28fdb4f35fso3255070276.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 02:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729244572; x=1729849372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLLeXqOR+j4J5K80kKtmagY5cg9UQK6bpjzIEEsrbRk=;
        b=Ls/AhFx3qrllPWq6X7s9YAt8yjS/QQquDUGjdXa7Gj4zGLtUN2t0Tm25xu9p69LO3O
         i5PxljGrjTUUyS99coSIGMb7mN9gQvc1Gfh5Lp9DCfVQ/SF4tEZirO4nXj0FEa6RScO+
         w+gYr6Oo93oHKfjEGQzg/AAaaEvifNleS06d2YBrLAHCt3Ti0m29KvI7qeA8BOYECC5u
         S3nb5u54TLiN6CwaQXatufeoYUVXRtYqLho/8ATZms8tqJdOepyeACQhRln+JAreojRi
         0VYFJhqsKEaKVqY7IKvdUVD1ACpZD2+ud+Gv3kfNJrd5KgqtOeuFjiN57gwTwni8fKA8
         p+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729244572; x=1729849372;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLLeXqOR+j4J5K80kKtmagY5cg9UQK6bpjzIEEsrbRk=;
        b=CoqglXxrSaM9u6a/ZZORTNMSZpolFbzuolRUZveUzv/sdKugtiJ3og5I4i1y93nqib
         /MtN+Ru20JDuHrtps3G9RH+hAuSTRG3s/0ZBUTgW23EJxSyUZO4JdeghRDcAxOde512/
         2rKnCr/hlG8lMCA00Lu/kD3T1s6udzgfbHkWXThPq5fvWaRSZPTZm8PMOB5qVr0/e4Si
         J+RevNsLsjN+QECuCGwpv36851GOLwPbzxef+CgVcVXXsBG195nmCSnMZZ25RBoQZHis
         z/P3ueDuGG2xeHChI1u/3WAU56NSGzQ/WcvwIEHohHDS6Z6B6D5OQSuXvovG/B868n70
         0VAw==
X-Forwarded-Encrypted: i=1; AJvYcCXeNE0Te4JDof6ZQ7FThdFIapWX7BGcUCYWjFutqVIOEslig0L7D0O+iivynOshr2ulIV2Vb3T4Vl3iyyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzWOSWPveiZxvZ0QjHek4p092CS7yx5I8nX66cffaT/vm6M/Ew
	IBu884s37/lkkybdXhWRKAuymlc7Zd3emeJzwRWKGu+pIV3h2Cv5BEKHGO7F7M+UnPCfjBYVt7k
	e8I4uHg==
X-Google-Smtp-Source: AGHT+IGSb0cw0pG+y/p+bObtKjZ2/Bbc3rekx20QPwcvKWAaCsQSzG1nltOqjouiHxq2r34MIkLGayvZUvNB
X-Received: from malysz.c.googlers.com ([fda3:e722:ac3:cc00:cb:de80:ac1c:6aa9])
 (user=jakiela job=sendgmr) by 2002:a5b:702:0:b0:e0e:8b26:484e with SMTP id
 3f1490d57ef6-e2bb1699b0fmr1108276.8.1729244572306; Fri, 18 Oct 2024 02:42:52
 -0700 (PDT)
Date: Fri, 18 Oct 2024 09:42:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241018094234.2633366-1-jakiela@google.com>
Subject: [PATCH] arm64: dts: mt8186: Update regulators voltages
From: "=?UTF-8?q?Albert=20Jakie=C5=82a?=" <jakiela@google.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	"=?UTF-8?q?Albert=20Jakie=C5=82a?=" <jakiela@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update minimum and maximum voltages and add
missing regulators.

Signed-off-by: Albert Jakie=C5=82a <jakiela@google.com>
---
 .../boot/dts/mediatek/mt8186-corsola.dtsi     | 107 +++++++++++-------
 1 file changed, 63 insertions(+), 44 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi b/arch/arm64/=
boot/dts/mediatek/mt8186-corsola.dtsi
index 682c6ad2574d..62158eac45d0 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
@@ -1302,8 +1302,8 @@ mt6366_regulators: regulators {
=20
 			vcore {
 				regulator-name =3D "pp0750_dvdd_core";
-				regulator-min-microvolt =3D <550000>;
-				regulator-max-microvolt =3D <800000>;
+				regulator-min-microvolt =3D <500000>;
+				regulator-max-microvolt =3D <1293750>;
 				regulator-ramp-delay =3D <6250>;
 				regulator-enable-ramp-delay =3D <200>;
 				regulator-allowed-modes =3D <MT6397_BUCK_MODE_AUTO
@@ -1313,8 +1313,8 @@ vcore {
=20
 			mt6366_vdram1_reg: vdram1 {
 				regulator-name =3D "pp1125_emi_vdd2";
-				regulator-min-microvolt =3D <1125000>;
-				regulator-max-microvolt =3D <1125000>;
+				regulator-min-microvolt =3D <500000>;
+				regulator-max-microvolt =3D <2087500>;
 				regulator-ramp-delay =3D <12500>;
 				regulator-enable-ramp-delay =3D <0>;
 				regulator-allowed-modes =3D <MT6397_BUCK_MODE_AUTO
@@ -1322,6 +1322,16 @@ mt6366_vdram1_reg: vdram1 {
 				regulator-always-on;
 			};
=20
+			mt6366_vpa_reg: vpa {
+				regulator-name =3D "ppvar_dvdd_vpa";
+				regulator-min-microvolt =3D <500000>;
+				regulator-max-microvolt =3D <3650000>;
+				regulator-ramp-delay =3D <50000>;
+				regulator-enable-ramp-delay =3D <250>;
+				regulator-allowed-modes =3D <MT6397_BUCK_MODE_AUTO
+							   MT6397_BUCK_MODE_FORCE_PWM>;
+			};
+
 			mt6366_vgpu_reg: vgpu {
 				/*
 				 * Called "ppvar_dvdd_gpu" in the schematic.
@@ -1330,19 +1340,17 @@ mt6366_vgpu_reg: vgpu {
 				 */
 				regulator-name =3D "ppvar_dvdd_vgpu";
 				regulator-min-microvolt =3D <500000>;
-				regulator-max-microvolt =3D <950000>;
+				regulator-max-microvolt =3D <1293750>;
 				regulator-ramp-delay =3D <6250>;
 				regulator-enable-ramp-delay =3D <200>;
 				regulator-allowed-modes =3D <MT6397_BUCK_MODE_AUTO
 							   MT6397_BUCK_MODE_FORCE_PWM>;
-				regulator-coupled-with =3D <&mt6366_vsram_gpu_reg>;
-				regulator-coupled-max-spread =3D <10000>;
 			};
=20
 			mt6366_vproc11_reg: vproc11 {
 				regulator-name =3D "ppvar_dvdd_proc_bc_mt6366";
-				regulator-min-microvolt =3D <600000>;
-				regulator-max-microvolt =3D <1200000>;
+				regulator-min-microvolt =3D <500000>;
+				regulator-max-microvolt =3D <1293750>;
 				regulator-ramp-delay =3D <6250>;
 				regulator-enable-ramp-delay =3D <200>;
 				regulator-allowed-modes =3D <MT6397_BUCK_MODE_AUTO
@@ -1352,8 +1360,8 @@ mt6366_vproc11_reg: vproc11 {
=20
 			mt6366_vproc12_reg: vproc12 {
 				regulator-name =3D "ppvar_dvdd_proc_lc";
-				regulator-min-microvolt =3D <600000>;
-				regulator-max-microvolt =3D <1200000>;
+				regulator-min-microvolt =3D <500000>;
+				regulator-max-microvolt =3D <1293750>;
 				regulator-ramp-delay =3D <6250>;
 				regulator-enable-ramp-delay =3D <200>;
 				regulator-allowed-modes =3D <MT6397_BUCK_MODE_AUTO
@@ -1361,10 +1369,21 @@ mt6366_vproc12_reg: vproc12 {
 				regulator-always-on;
 			};
=20
+			mt6366_vmodem_reg: vmodem {
+				regulator-name =3D "ppvar_vmodem";
+				regulator-min-microvolt =3D <500000>;
+				regulator-max-microvolt =3D <1293750>;
+				regulator-ramp-delay =3D <6250>;
+				regulator-enable-ramp-delay =3D <900>;
+				regulator-allowed-modes =3D <MT6397_BUCK_MODE_AUTO
+							   MT6397_BUCK_MODE_FORCE_PWM>;
+				regulator-always-on;
+			};
+
 			mt6366_vs1_reg: vs1 {
 				regulator-name =3D "pp2000_vs1";
-				regulator-min-microvolt =3D <2000000>;
-				regulator-max-microvolt =3D <2000000>;
+				regulator-min-microvolt =3D <1000000>;
+				regulator-max-microvolt =3D <2587500>;
 				regulator-ramp-delay =3D <12500>;
 				regulator-enable-ramp-delay =3D <0>;
 				regulator-always-on;
@@ -1372,8 +1391,8 @@ mt6366_vs1_reg: vs1 {
=20
 			mt6366_vs2_reg: vs2 {
 				regulator-name =3D "pp1350_vs2";
-				regulator-min-microvolt =3D <1350000>;
-				regulator-max-microvolt =3D <1350000>;
+				regulator-min-microvolt =3D <500000>;
+				regulator-max-microvolt =3D <2087500>;
 				regulator-ramp-delay =3D <12500>;
 				regulator-enable-ramp-delay =3D <0>;
 				regulator-always-on;
@@ -1397,7 +1416,7 @@ mt6366_vaud28_reg: vaud28 {
 			mt6366_vaux18_reg: vaux18 {
 				regulator-name =3D "pp1840_vaux18";
 				regulator-min-microvolt =3D <1800000>;
-				regulator-max-microvolt =3D <1840000>;
+				regulator-max-microvolt =3D <1800000>;
 				regulator-enable-ramp-delay =3D <270>;
 			};
=20
@@ -1410,8 +1429,8 @@ mt6366_vbif28_reg: vbif28 {
=20
 			mt6366_vcn18_reg: vcn18 {
 				regulator-name =3D "pp1800_vcn18_x";
-				regulator-min-microvolt =3D <1800000>;
-				regulator-max-microvolt =3D <1800000>;
+				regulator-min-microvolt =3D <600000>;
+				regulator-max-microvolt =3D <2100000>;
 				regulator-enable-ramp-delay =3D <270>;
 			};
=20
@@ -1424,8 +1443,8 @@ mt6366_vcn28_reg: vcn28 {
=20
 			mt6366_vefuse_reg: vefuse {
 				regulator-name =3D "pp1800_vefuse";
-				regulator-min-microvolt =3D <1800000>;
-				regulator-max-microvolt =3D <1800000>;
+				regulator-min-microvolt =3D <1700000>;
+				regulator-max-microvolt =3D <1900000>;
 				regulator-enable-ramp-delay =3D <270>;
 			};
=20
@@ -1438,15 +1457,15 @@ mt6366_vfe28_reg: vfe28 {
=20
 			mt6366_vemc_reg: vemc {
 				regulator-name =3D "pp3000_vemc";
-				regulator-min-microvolt =3D <3000000>;
-				regulator-max-microvolt =3D <3000000>;
+				regulator-min-microvolt =3D <2900000>;
+				regulator-max-microvolt =3D <3300000>;
 				regulator-enable-ramp-delay =3D <60>;
 			};
=20
 			mt6366_vibr_reg: vibr {
 				regulator-name =3D "pp2800_vibr_x";
-				regulator-min-microvolt =3D <2800000>;
-				regulator-max-microvolt =3D <2800000>;
+				regulator-min-microvolt =3D <1200000>;
+				regulator-max-microvolt =3D <3300000>;
 				regulator-enable-ramp-delay =3D <60>;
 			};
=20
@@ -1482,30 +1501,30 @@ mt6366_vmc_reg: vmc {
=20
 			mt6366_vmddr_reg: vmddr {
 				regulator-name =3D "pm0750_emi_vmddr";
-				regulator-min-microvolt =3D <700000>;
-				regulator-max-microvolt =3D <750000>;
+				regulator-min-microvolt =3D <600000>;
+				regulator-max-microvolt =3D <2100000>;
 				regulator-enable-ramp-delay =3D <325>;
 				regulator-always-on;
 			};
=20
 			mt6366_vmch_reg: vmch {
 				regulator-name =3D "pp3000_vmch";
-				regulator-min-microvolt =3D <3000000>;
-				regulator-max-microvolt =3D <3000000>;
+				regulator-min-microvolt =3D <2900000>;
+				regulator-max-microvolt =3D <3300000>;
 				regulator-enable-ramp-delay =3D <60>;
 			};
=20
 			mt6366_vcn33_reg: vcn33 {
 				regulator-name =3D "pp3300_vcn33_x";
 				regulator-min-microvolt =3D <3300000>;
-				regulator-max-microvolt =3D <3300000>;
+				regulator-max-microvolt =3D <3500000>;
 				regulator-enable-ramp-delay =3D <270>;
 			};
=20
 			vdram2 {
 				regulator-name =3D "pp0600_emi_vddq";
 				regulator-min-microvolt =3D <600000>;
-				regulator-max-microvolt =3D <600000>;
+				regulator-max-microvolt =3D <1800000>;
 				regulator-enable-ramp-delay =3D <3300>;
 				regulator-always-on;
 			};
@@ -1518,6 +1537,7 @@ mt6366_vrf12_reg: vrf12 {
 			};
=20
 			mt6366_vrf18_reg: vrf18 {
+				compatible =3D "regulator-fixed";
 				regulator-name =3D "pp1800_vrf18_x";
 				regulator-min-microvolt =3D <1800000>;
 				regulator-max-microvolt =3D <1800000>;
@@ -1526,8 +1546,8 @@ mt6366_vrf18_reg: vrf18 {
=20
 			vsim1 {
 				regulator-name =3D "pp1860_vsim1_x";
-				regulator-min-microvolt =3D <1800000>;
-				regulator-max-microvolt =3D <1860000>;
+				regulator-min-microvolt =3D <1700000>;
+				regulator-max-microvolt =3D <3100000>;
 				regulator-enable-ramp-delay =3D <540>;
 			};
=20
@@ -1540,18 +1560,17 @@ mt6366_vsim2_reg: vsim2 {
=20
 			mt6366_vsram_gpu_reg: vsram-gpu {
 				regulator-name =3D "pp0900_dvdd_sram_gpu";
-				regulator-min-microvolt =3D <850000>;
-				regulator-max-microvolt =3D <1050000>;
+				regulator-min-microvolt =3D <500000>;
+				regulator-max-microvolt =3D <1293750>;
 				regulator-ramp-delay =3D <6250>;
 				regulator-enable-ramp-delay =3D <240>;
-				regulator-coupled-with =3D <&mt6366_vgpu_reg>;
-				regulator-coupled-max-spread =3D <10000>;
+				regulator-always-on;
 			};
=20
 			mt6366_vsram_others_reg: vsram-others {
 				regulator-name =3D "pp0900_dvdd_sram_core";
-				regulator-min-microvolt =3D <900000>;
-				regulator-max-microvolt =3D <900000>;
+				regulator-min-microvolt =3D <500000>;
+				regulator-max-microvolt =3D <1293750>;
 				regulator-ramp-delay =3D <6250>;
 				regulator-enable-ramp-delay =3D <240>;
 				regulator-always-on;
@@ -1559,8 +1578,8 @@ mt6366_vsram_others_reg: vsram-others {
=20
 			mt6366_vsram_proc11_reg: vsram-proc11 {
 				regulator-name =3D "pp0900_dvdd_sram_bc";
-				regulator-min-microvolt =3D <850000>;
-				regulator-max-microvolt =3D <1120000>;
+				regulator-min-microvolt =3D <500000>;
+				regulator-max-microvolt =3D <1293750>;
 				regulator-ramp-delay =3D <6250>;
 				regulator-enable-ramp-delay =3D <240>;
 				regulator-always-on;
@@ -1568,8 +1587,8 @@ mt6366_vsram_proc11_reg: vsram-proc11 {
=20
 			mt6366_vsram_proc12_reg: vsram-proc12 {
 				regulator-name =3D "pp0900_dvdd_sram_lc";
-				regulator-min-microvolt =3D <850000>;
-				regulator-max-microvolt =3D <1120000>;
+				regulator-min-microvolt =3D <500000>;
+				regulator-max-microvolt =3D <1293750>;
 				regulator-ramp-delay =3D <6250>;
 				regulator-enable-ramp-delay =3D <240>;
 				regulator-always-on;
@@ -1578,7 +1597,7 @@ mt6366_vsram_proc12_reg: vsram-proc12 {
 			vusb {
 				regulator-name =3D "pp3070_vusb";
 				regulator-min-microvolt =3D <3000000>;
-				regulator-max-microvolt =3D <3070000>;
+				regulator-max-microvolt =3D <3100000>;
 				regulator-enable-ramp-delay =3D <270>;
 				regulator-always-on;
 			};
@@ -1586,7 +1605,7 @@ vusb {
 			vxo22 {
 				regulator-name =3D "pp2240_vxo22";
 				regulator-min-microvolt =3D <2200000>;
-				regulator-max-microvolt =3D <2240000>;
+				regulator-max-microvolt =3D <2200000>;
 				regulator-enable-ramp-delay =3D <120>;
 				/* Feeds DCXO internally */
 				regulator-always-on;
--=20
2.47.0.rc1.288.g06298d1525-goog



Return-Path: <linux-kernel+bounces-419376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 015289D6D1A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 09:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7664B1618C8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 08:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAC515575D;
	Sun, 24 Nov 2024 08:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVESRYx9"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A362136E;
	Sun, 24 Nov 2024 08:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732437302; cv=none; b=Hu/GT/Y+K2bBZo4AZImINXfdnjRVv8Vkx7hgoqNTXbnsO7sG4If+uB+pF334h03Pk1YyelOidDAUBbUwlMJasJpe6VWK3k3t3p9l9lSj6YBwic6+hpEPmZVK9VxZR6/V5B3jCeU6jGyd80PdwlAv8Qo01ZQVFy2FcyixLSx9kVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732437302; c=relaxed/simple;
	bh=HcSsa6SY91Up+78a65sn73xGv1vE1vpwP2o0+BzOMsU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F0G45Rom+RT5PUdoaVs6TU0GHwqs+2TSO5hm3sail6RMiVvndjxjzK8GTE+s2zL9bo0LqciPHrAs4V53qNODfazdPax9vJv+fMSToksAEXhjMnmFu6euPSq6rmHYEfZf5esUFvrUrJwumtWq0oeLqWhUkudY1hwHmIt91RxQv14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVESRYx9; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-382411ea5eeso1904654f8f.0;
        Sun, 24 Nov 2024 00:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732437298; x=1733042098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r4wZNAYoXyTS6KWqhdId+e/j9up0DyZ5zMGlnmmsV7E=;
        b=nVESRYx9rIIQZ0OosCM12eI/bwAm2dshb328/ij+1Vw8q2ZdPNSO3xSaHwpI0bO/7P
         6r9fmkv4CvuOoDldMJqK5y0FCwabjtmLyx1gUVGVdn7I4cfZd3RzFQYriLSabP5ENZfX
         PNBvISlRWabi7N4pg3lbYLirCFE6hIlpM6TAksb21GRLwP5LUNVm+SEJwSemWAJIjgLm
         G1oknLYkB7WfvIAPl7PuuquT1brRmIRgHToBbiPXuIAH1n0VPoVdTFaK0mczKAiM6BjA
         MtCRWemI8Dg6eOq+VyRNWUiR2wlPx/YpxqP261TXGL/9zSAo5hCH50wJBKCu4FORfhwI
         1DHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732437298; x=1733042098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r4wZNAYoXyTS6KWqhdId+e/j9up0DyZ5zMGlnmmsV7E=;
        b=IJOK+gUwrF8SoXfx3auxA7MdTNVYU3nmcGa3Rnt4UdMh2mGhe26QTmUYMCx6u9pguF
         rcXlUgEIOfaVfNoDPF09FBdsfeewx55Ii7tfLgxQSIn+nv//GjrmOnfa/nsSpuyw+PEg
         /kmohYz5nQ+QvUt2rmUKS/Rb5h52ujH1SyVX+SqqRfc6Nt0ZvyzQyNl86iavmBHZ+blZ
         zJ6xhnCp7/g8skXvPP/Q0sNKJPJIY4LFa82tPcIm1brMcn6kD25Ei334rL6Dl6m8UYJt
         T4fTkKextvdvL0oBJOrKNrF68Hs9EnPNyOngIuDIzgvhA9CEXcKZ2aFChcGi+loinDrY
         NJWA==
X-Forwarded-Encrypted: i=1; AJvYcCV2RfC3u6ApsgTMHFi+fQ7axi5lpn7pshD60AgJHRwkXEEbKpyK2wJ/I06NCWOujK+X5BY4rgcHtArouxdM@vger.kernel.org, AJvYcCXaJ9mxy8Kd9tyaAtU30fVbpRE+ap2dIG/Y54h778gUfcdSJKinUZzH+XomBx6SnxTW4dNHYRQ+ScEm@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ9hWlMQcEkGKIOk4iQJsImoDua4/A0aUmNUWnunb5xDRNC2Kq
	Le2c+di8PqY38L9ftE70EDn/mNFVWCLpk+VFY1M/5yhIV9uY86fU
X-Gm-Gg: ASbGncuWkuQdfZpnea39dk0nqPXCJW8pyRaKtumRYae8fjtoBXSafzOJTw8cZlMMr/T
	6KhLs+l9OGDqVFVq6FjbKps/OpbUFrb8LkqdH18Z9W4+Mcn8YWDoZG+vbU+mxMC2qgnTdTSnm8U
	kqnfLmlHPw4JjZJDNr7QdBKJooMZmF4xnSAUZzflm4Se8SNMRuI1PsjPb3oWKZlvZwipXxix+gG
	whdEpNY1SW+s2kUvKxsVZApM157wzjkIGr/XzeY4rdRmpKYcruHyIo=
X-Google-Smtp-Source: AGHT+IF5cabE2Tx7RTeVKjrsbOyjk5UWacuIke+YxdcwrSskiev6s1JwXABaTjTX/jeVSCAVboeljw==
X-Received: by 2002:a05:6000:79b:b0:384:ff3e:e0a6 with SMTP id ffacd0b85a97d-384ff3ee0b0mr3986555f8f.5.1732437297456;
        Sun, 24 Nov 2024 00:34:57 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433cde1151esm84949895e9.16.2024.11.24.00.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 00:34:56 -0800 (PST)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] WIP: arm64: dts: meson: drop broadcom compatible from reference board SDIO nodes
Date: Sun, 24 Nov 2024 08:34:53 +0000
Message-Id: <20241124083453.900368-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the Broadcom compatible and use a generic sdio identifier with the Amlogic
reference boards. This allows a wider range of Android STB devices with QCA9377
and RTL8189ES/FS chips to have working WiFi when booting from the reference dtb
files. There is no observed impact on Broadcom devices.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi      | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts  | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p231.dts  | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxm-q200.dts        | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxm-q201.dts        | 3 +--
 6 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
index 52d57773a77f..1736bd2e96e2 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
@@ -178,9 +178,8 @@ &sd_emmc_a {
 	vmmc-supply = <&vddao_3v3>;
 	vqmmc-supply = <&vddio_boot>;
 
-	brcmf: wifi@1 {
+	sdio: wifi@1 {
 		reg = <1>;
-		compatible = "brcm,bcm4329-fmac";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts
index c1470416faad..7dffeb5931c9 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts
@@ -102,8 +102,7 @@ hdmi_tx_tmds_out: endpoint {
 };
 
 &sd_emmc_a {
-	brcmf: wifi@1 {
+	sdio: wifi@1 {
 		reg = <1>;
-		compatible = "brcm,bcm4329-fmac";
 	};
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p231.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p231.dts
index 92c425d0259c..ff9145d49090 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p231.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p231.dts
@@ -21,8 +21,7 @@ &ethmac {
 };
 
 &sd_emmc_a {
-	brcmf: wifi@1 {
+	sdio: wifi@1 {
 		reg = <1>;
-		compatible = "brcm,bcm4329-fmac";
 	};
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
index 7e7dc87ede2d..b52a830efcce 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
@@ -134,9 +134,8 @@ &sd_emmc_a {
 	vmmc-supply = <&vddao_3v3>;
 	vqmmc-supply = <&vddio_boot>;
 
-	brcmf: wifi@1 {
+	sdio: wifi@1 {
 		reg = <1>;
-		compatible = "brcm,bcm4329-fmac";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-q200.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-q200.dts
index d4858afa0e9c..feb31207773f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-q200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-q200.dts
@@ -72,8 +72,7 @@ external_phy: ethernet-phy@0 {
 };
 
 &sd_emmc_a {
-	brcmf: wifi@1 {
+	sdio: wifi@1 {
 		reg = <1>;
-		compatible = "brcm,bcm4329-fmac";
 	};
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-q201.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-q201.dts
index d02b80d77378..6c8bec1853ac 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-q201.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-q201.dts
@@ -21,8 +21,7 @@ &ethmac {
 };
 
 &sd_emmc_a {
-	brcmf: wifi@1 {
+	sdio: wifi@1 {
 		reg = <1>;
-		compatible = "brcm,bcm4329-fmac";
 	};
 };
-- 
2.34.1



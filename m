Return-Path: <linux-kernel+bounces-423024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 953069DA185
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 05:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48FC5284F1D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 04:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EB013A869;
	Wed, 27 Nov 2024 04:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBJ0XCim"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250B214F90;
	Wed, 27 Nov 2024 04:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732682046; cv=none; b=NThtD+Gppt98nijlzhyCPTC/iNKY8kFUsfDwFl6KWb5X2uyR4F/4N6tPpWw+7Pps5VnXgH7+eu2jBYTKPkjtjlNJg12lLukIsYjpQL82lrXwS1E4wnG5iBXUK8co+221EQgctVNXieYVuo9W+AF1oetJFlOKgm2lApd+1Ob+ox0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732682046; c=relaxed/simple;
	bh=esaoqFsdsjq6dGqzkJX1+DvjhcClDspLFiMqk0Y1wgU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qjinoEvFYdHzfRePoua5XiYIyFNez4lZPm8zML3Cwnh0+D2gm93DktOVubqelli5jyt8ZfH3TUbCUvwL2AbgpNhI26Ip2iOAZW8fHx8vfhyIoVeFQnJGicV9/kVLV3nGO5+T9IU/4c0nGKGCIm2VPC0vW6a07rdESq6gufFZifU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBJ0XCim; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434a8b94fb5so2141005e9.0;
        Tue, 26 Nov 2024 20:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732682043; x=1733286843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nE9I1uPOR4sQF959XXKFUqSwci9J/1L0qLYIRegyl2k=;
        b=EBJ0XCimwsH4wtw/3aeyzWQWosOlbbQd/OQi6YCvze0X5bMcU6CiLODz4iCXe7SOK2
         /aCT2wuQhHilW19WOiKMancL+MAVCC6qSIo7QVvw77PYrZojXiDOHnhs2tn7I4HVD/xh
         m02U9sur84DkQFLSbgzlWMsH2+uHov4co6Pi2+WWwci+hf6FhNUkIoZrRx03ZLZOBl55
         +tkeZEYotdkXTENUCgT5HU1gp/cUlOs/QhoeFcRs0uTJg6eS0SEC7y9djNP+y+7+hIXW
         yl0LXvl0bJaBEVpI60N9hUHsK5kOIdmbo15oYNsJeP51Keh1edHCxy1ppvu65/oXzmMs
         8IMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732682043; x=1733286843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nE9I1uPOR4sQF959XXKFUqSwci9J/1L0qLYIRegyl2k=;
        b=dd778PdbTKNaUASWGxuhuOwSwDJod851ATavxpfFKSs6OSfq1URWEq0z/iLylDY8Je
         VNaqTjdSCdI4yHxek88x594edUjax+7OlNlsHPHIaYGRh8ScTBz+VbASWsrF/EoAeW8M
         FcUZWn/Bq44rE+mLbzz3JEoGA4FtdywMsSpJ7w30mU9C+wfBAAbgZ6eJ9zKIOyCFelr5
         d5G4VV1T+BuIMi1almyPn9mzCkXUd7wcyt0CVqNjL1SdUS/5dx5rE6ep8JRdUY9+M1Mc
         crM5c0onBWRtwWZxhvCKPGT/O2JgniH71+whUF/Omh93re73723iCuJvweEXKKTFOe52
         BX/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGktxyCDeSimTCtc5GXDJBaK7bzquZqj5jzy4A5LAWin+6pacUAQrVUWlZMlNA5A4S6dAl5YP5AphIoC8H@vger.kernel.org, AJvYcCXQXwr+ObsONQ7Ve5kBo3FZIn4p2ulOe5ZwqcmNGJtJNC/Jf8D8MtpKLjijqqNVHRu6jQTqfq6ZJLxE@vger.kernel.org
X-Gm-Message-State: AOJu0YwODsoMU2euvYaSYmZ+k9eVnV6dHzqRqK2Gw8ya8iOwpvjL6eHY
	TUMH5jmh7yKmUf5PVK3V/0TFCJ0BEAOkdcJ0dFW/tr+Ajwqsp/Kz
X-Gm-Gg: ASbGnctAYe9JwUb0P/EhBNggcs790p8jVgap933gUKYH96qk9tINWdSOKtgi9QjtGEp
	JA+dMy1p/oO56KEyqHj7zLE93JmHmgbk5wYFslQ3NA5bWPxhnR5jiBOwe6iIFfXO+Ebv/Uq74lx
	U1X63NNzLiCTWXJ/b7pGVqA3OIHdfnc5EjpUd16BVavyrpZgyymLvmI1wRU9oEHJCFPaMFg6Xqm
	OTKvODrF6sabyvACjHaK/N9vKD/YOv9tRxS6YicrkbMi/3smNcrBCc=
X-Google-Smtp-Source: AGHT+IHFTh4QPCHLqYQqSQVx7EWaLp6Y5TlpjfC3lTUuw+N9BykWXKF0iN1qJk77JxXDjEBKXKGF6A==
X-Received: by 2002:a05:600c:214a:b0:434:9d3c:31ec with SMTP id 5b1f17b1804b1-434a4e988b5mr44514395e9.10.1732682043182;
        Tue, 26 Nov 2024 20:34:03 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e256esm7503415e9.32.2024.11.26.20.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 20:34:02 -0800 (PST)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2] arm64: dts: meson: remove broadcom wifi compatible from GX reference boards
Date: Wed, 27 Nov 2024 04:33:58 +0000
Message-Id: <20241127043358.3799737-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Amlogic GX reference boards shipped with Broadcom SDIO modules and
this is described in device-tree files. These boards are rare, but
their device-trees are commonly used to boot no-name Android STB's
that closely follow the vendor reference design. For cost reasons
these boxes often use non-Broadcom RTL8189ES/FS and QCA9377 SDIO
modules, and for availability reasons the chipset/module used can
change between batches of the same device.

Testing shows the only requirement for WiFi driver probe and load
is presence of the correct 'reg' value, and all Amlogic boards use
the same <1> value. Removing the 'brcm,bcm4329-fmac' compatible
allows a wider range of Android STB boards to boot from reference
design device-trees and have working WiFi. Also convert the 'brcmf'
node name to a more generic 'sdio' to reflect we are not always
using the Broadcom brcmfmac driver now.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
Changes since v1:
- correct and reduce subject/description line length
- provide a better explanation of the change

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



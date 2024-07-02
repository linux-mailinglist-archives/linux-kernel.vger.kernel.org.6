Return-Path: <linux-kernel+bounces-237975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2C1924175
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 16:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64D1E1C22AF3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987F31BA873;
	Tue,  2 Jul 2024 14:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lx4AguWH"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CEE171653
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719932066; cv=none; b=bjrQlD7SoJnyZqdPSKGZU6TUxatr624/k4PupVPO8tte9yII62hSsD8ouwIZuQj0B5DXUKvoTR7LHdV0RG0SRHT3PxVkWOxECgmk46CMo4v4G5Sm+J5t2NM/SRnbfCTejGvMybfRbhEANZHfPo8DaWG/7Aj50OcFDEzyXasovDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719932066; c=relaxed/simple;
	bh=VNh1sKgxu/QGgs/OsnATnI6GGjc22mmN4KtUto7Pwxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=olcNukT+B6D7ErRPCNKoo//1dwnFzdPVBsOSgFUyFSW0a7rIrNUWqkWoge1CmDZinvo5qAnhOnluIO3MWk1UUVzbi7rR5knBzeA4QVwmLeSQD1qY/xTFyKH0yC55FFCBT3npGUf+wL5KIGyPuzz7Q6rYRX6Y12H5IMCsRVATFXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lx4AguWH; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52e93d1432fso96036e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 07:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719932062; x=1720536862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5LwpiUOo/zV8ut5Kk94sM4XFR+9BUnK4is30VOnYj5s=;
        b=lx4AguWHzHiTnNWVab+Il3fXZMdicKIn/FVdws7EGAdCpstfEOZKyO6Jk9jy3k+kPU
         dipQeWE+z1NmRPqggtumSinwGcc0NKG0AMTY7mQxarzDmHvgjBOsj6tpP2FzO0Dh0X+2
         ovvoeWJF6lHFtWQfGbUHwNIKHPpvrwwHTBucmj8DPqosSWkplbmikcIudjZ597pM+61N
         tBkytoJncU93tVib8lYsnIgR4Nzf4y09VdMvxnTx+rdCgltcxYa1JE8DSn3Uc+KBvj7A
         T1BB9WWI/rd23kCSNCu72VtNohjcgBRQAoimoEq0RxB0fVOFzlAzfvB6lMRWjfJSx7rA
         0BSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719932062; x=1720536862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5LwpiUOo/zV8ut5Kk94sM4XFR+9BUnK4is30VOnYj5s=;
        b=Af/yt5fid0IUuo85bPs1D0PvEW/CWu2NEs0X98FDQxWXu+9Ol+IY70DNJHuuFoumw4
         hRPOieT8kkyYkVPflP+SFD8eAOxXKdqkFKYo4QagZ95REmfUeqKShgTC4A4bwTyhuWGx
         N7zESFyTbjLx4SNqOHgXZ5MZjiOFOc7mcbhmcBLMFZHWgbfjmGL4fqi3iFAyc4+PETF4
         jO4gn/J6awmrZaGjaa3xKTCxK7B3KIoDSW55w197l/c+8zWU7vQbDVptDzjwQAPaXQIP
         +t1aveNZGarwbYOebMEtgzqBWkKeTR7w+qPLzFFPxdO6axsaKpdu7XGB99TTlyLKYYhn
         KyYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvsiECYBrFz0NKXZC1PwqtFJJHANGmGOZj1n0aEyD/x6G7peIinlsMLKcwCyRsnkVTWXIL0L2RsQFQ8nb7wZliDtHASqvuJu5jHfjR
X-Gm-Message-State: AOJu0Yw91HfcBt72ldAxehW3seIyVgHwFqTMjMvlSLzwsuJwVPalBA8g
	lJzW2frD6S5QrqTMbtV/yPB2jSDEObgQDfUtbD8O//N079aBD9hu+wp3xShkTGI=
X-Google-Smtp-Source: AGHT+IH7NNPhg1UZ2JBspUs6kRfUIg18h9HT+vprDWdBkd9V1+0A4sBtLCApPZHN0e3lsyVWgLNmQQ==
X-Received: by 2002:a05:6512:3b90:b0:52e:93da:f921 with SMTP id 2adb3069b0e04-52e93dafb22mr43279e87.19.1719932061649;
        Tue, 02 Jul 2024 07:54:21 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b097bcbsm201843155e9.35.2024.07.02.07.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 07:54:21 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: layerscape: fix thermal node names length
Date: Tue,  2 Jul 2024 16:54:17 +0200
Message-ID: <20240702145417.47423-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linux kernel expects thermal zone node names to be maximum of 19
characters (see THERMAL_NAME_LENGTH, including terminating NUL byte) and
bindings/dtbs_check points that:

  fsl-ls2088a-rdb.dtb: thermal-zones: 'core-cluster1-thermal', 'core-cluster2-thermal', 'core-cluster3-thermal', 'core-cluster4-thermal'
    do not match any of the regexes: '^[a-zA-Z][a-zA-Z0-9\\-]{1,10}-thermal$', 'pinctrl-[0-9]+'

Name longer than 19 characters leads to driver probe errors when
registering such thermal zone.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

See also:
https://lore.kernel.org/linux-devicetree/20240702145248.47184-1-krzysztof.kozlowski@linaro.org/T/#u
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 8 ++++----
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 6b6e3ee950e5..acf293310f7a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -175,7 +175,7 @@ ddr-ctrler-crit {
 			};
 		};
 
-		core-cluster-thermal {
+		cluster-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 1>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 17f4e3171120..ab4c919e3e16 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -214,7 +214,7 @@ fman-crit {
 			};
 		};
 
-		core-cluster-thermal {
+		cluster-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 3>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 200e52622f99..55019866d6a2 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -182,7 +182,7 @@ fman-crit {
 			};
 		};
 
-		core-cluster-thermal {
+		cluster-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 3>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 8ce4b6aae79d..e3a7db21fe29 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -131,7 +131,7 @@ its: msi-controller@6020000 {
 	};
 
 	thermal-zones {
-		core-cluster-thermal {
+		cluster-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 0>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index bde89de2576e..1b306d6802ce 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -122,7 +122,7 @@ ddr-ctrler3-crit {
 			};
 		};
 
-		core-cluster1-thermal {
+		cluster1-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 4>;
@@ -151,7 +151,7 @@ map0 {
 			};
 		};
 
-		core-cluster2-thermal {
+		cluster2-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 5>;
@@ -180,7 +180,7 @@ map0 {
 			};
 		};
 
-		core-cluster3-thermal {
+		cluster3-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 6>;
@@ -209,7 +209,7 @@ map0 {
 			};
 		};
 
-		core-cluster4-thermal {
+		cluster4-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 7>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 26c7ca31e22e..bd75a658767d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -492,7 +492,7 @@ map0 {
 			};
 		};
 
-		ddr-cluster5-thermal {
+		ddr-ctrl5-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 1>;
-- 
2.43.0



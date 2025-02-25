Return-Path: <linux-kernel+bounces-531041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F62A43B6E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D9643B5E28
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD099266B51;
	Tue, 25 Feb 2025 10:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FUFXCAYa"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734FB199931
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478842; cv=none; b=JwmusdT488LQbuNmB9CPhoAH7Zl92CoscjbVEFdJVvSMXuXiI9qD60RFAmd5jH9zur+FNQi03Z1nVN06A3TIyqd0pz9lptrLRmOKsUEVHp7JVxUrvOZUM7LDoP1BGS5RxwBfqEfHTmOa95GbewqvZvG/qUe9bsUXmuG1ELDfuQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478842; c=relaxed/simple;
	bh=3gNOUzctXpsYMZme95M0wK8S8AMUTll3AeAdeanqip8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d8AskXtXAjeb27OLH/yUfo07PX4kg+OkAdoulOsD8vAbFnXPN9y2knp05vKijff9pwKS8xBSgKlLT7Ilo24pw6sFNKeGak9JOiT4xfjovnwXx8PO/UUZcqO2QtQ7LewYhinrBPYjRreDKveLCmAdruLqq/Fb9iWaj4oO4JjjXwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FUFXCAYa; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abb9e81c408so93185766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 02:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740478839; x=1741083639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aMAiIGxOhs/NRNnqxe1Q5w1Z2sjpATlomzVPp7WhyYE=;
        b=FUFXCAYatArtXh0+NYN2nKxxLEcH13WbLIgXiNf/g4TiC4tRIGXJD3Tw9oVebktSUa
         PabbevfRoIqoa13TlKs8ABOrtSZAmw86F96l8BfNOdsu4+3/yhjCr5PFnvVtvZ4W/Nl5
         mUBiw+gz/XByG7GkIu8V6/n4COzM7lb7Sg6gqnHvU1Rb8M5g2pT/dX518E1r0Jg1+5Od
         0iksDgZLkPWVGVOb+17xzmpxQwZz0oJUwBgF07qd6Hex822SWqdHpLUI0SSWO2gqSQiO
         EJXOMtPm48X1Nnu+n3cxOZp4KBnjohmxSXP9IOVEneyKX/KfcTrG0jXW310aVbmPXe5N
         hiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740478839; x=1741083639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aMAiIGxOhs/NRNnqxe1Q5w1Z2sjpATlomzVPp7WhyYE=;
        b=oxUMOCVelz3ArmjJkzboVO7wdY5DW9uiSKeVFHDtc5SzOIACLQFwIJSSmTpmwPFsrv
         LVduLU6dp6RWD7xChtUz9HvmHK1JeCKT/pviTfv7fpzW9NcehAdOUb4FkWn9bdLcWmse
         /ZPigGl7Vm5U3QjJYw4nCsciwWatR2chIPXaDoxKJpyEfWg9Ia1utMu28eyGTpE1Jo2u
         TCRTFi2C/C+s2IQcWM664qvoUuOH6JblCsVYXtGXj+oBpzn5zkNFCuZ+9VN5jNnbybBI
         FeVn5e7tn453t8YgUZdi1wHGF4siq2tU7/K2r+duXmufSm4OIDSCB5p/cvEFB6xm97pw
         136g==
X-Forwarded-Encrypted: i=1; AJvYcCWTfcGz0k5ruJustdBM+C97EsOWvtdiEkA2hCNsZ68erHlJhUCGbrVH0YDLEdRAHEnjjHCwEWoKkd7rl+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBFWyhg/H6dfN7L78nDrxgOZHaSnBRDm2J6P8CHxY+JtQBI7y2
	wLf+NzmK2/ij+F0ofVtzJMbVvYYZPb43Mynr9M8F8o4goxVftIZrnL9XGeaoS1c=
X-Gm-Gg: ASbGncuvid8bil+VYb8H/J7I+I9/7dvJaG7iVaYZgpg9EJFcVu96xypaolC9jXKNm5B
	YqRjblvVjez5hsIUxp9pa3I9+zZhOmdjGkxuaiZ0k/sA8CVklzmDQRlsz92nU27tptiTjniQupc
	r4wotQQjDTSLtuhc2CytV20+SfQTvVacNXXVvpboPm7kKCuRQ3+ZMe3TmschoDTGfw0ghNbBay9
	hM0pnqQTzsuuPTIG966JYWmQgDdVsY2fX2B7qJRBr5V8K+QQck90NRkuY/BiwcG9/olheH2U+eH
	T/hslUNPsp85gomb8L+W1lkeJ5nvwLM/6NAjkfq2ifqwXieVzannIjZ192d7602+V5G4XFfDNVw
	=
X-Google-Smtp-Source: AGHT+IEZErkXFchQBHcjhpLOcz0ntlnRWjG+dqb6HL0cgbpdGQt3G9rUQQ9bKlCBwVV+K4XlTqA59A==
X-Received: by 2002:a17:906:fb09:b0:abe:9c69:b71e with SMTP id a640c23a62f3a-abe9c69c1d6mr280644666b.3.1740478838702;
        Tue, 25 Feb 2025 02:20:38 -0800 (PST)
Received: from krzk-bin.. (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed2010decsm116931666b.98.2025.02.25.02.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 02:20:38 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH RFC] arm64: dts: rockchip: Switch to undeprecated qcom,calibration-variant on RK3399
Date: Tue, 25 Feb 2025 11:20:36 +0100
Message-ID: <20250225102036.107913-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The property qcom,ath10k-calibration-variant was deprecated in favor of
recently introduced generic qcom,calibration-variant, common to all
Qualcomm Atheros WiFi bindings.

Change will affect out of tree users, like other projects, of this DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Dependency/RFC!

RFC, because this should be merged release after driver support is
merged:
https://lore.kernel.org/linux-devicetree/20250225-b-wifi-qcom-calibration-variant-v1-0-3b2aa3f89c53@linaro.org/T/#t
---
 arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-dumo.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-dumo.dts b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-dumo.dts
index 9e4b12ed62cb..be3ae473e562 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-dumo.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-dumo.dts
@@ -36,6 +36,6 @@ wifi@0,0 {
 		compatible = "qcom,ath10k";
 		reg = <0x00000000 0x0 0x00000000 0x0 0x00000000>,
 		      <0x03000010 0x0 0x00000000 0x0 0x00200000>;
-		qcom,ath10k-calibration-variant = "GO_DUMO";
+		qcom,calibration-variant = "GO_DUMO";
 	};
 };
-- 
2.43.0



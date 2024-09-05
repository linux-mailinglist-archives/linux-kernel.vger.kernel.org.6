Return-Path: <linux-kernel+bounces-317463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0112396DEAE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5179284169
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F8719E837;
	Thu,  5 Sep 2024 15:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s+VEosnF"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6B119E822
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 15:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725551087; cv=none; b=b0pKbbC4xOU3H/kcgxmgdS5G5MA1wmVEazEigi0dLCtI1qcA4zQwo+nTEsz//g/din1xvvxwQuSpy++CiqCyPtCct9c1q9KivpGAZvnUv5nMbtaGM4osDxBJNYxBrGhJsCaAokOvxW/VQ0EpdSgjAMuipLrXz2R4Xk1Sy3nIi98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725551087; c=relaxed/simple;
	bh=zXnRoQugAQFzL6m+lLOR53GnH5aQ31cO9ZRivznecsE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BjiZ+gQn67qmr3e1mTnKjIbt/NKkxfPK6o3rGTmTv1ATLMsqzoUk4i/7vgwKdTb0w2P/3nWrI6+hrfPJ+U0QwpQ9ICnZCohB0tX/YDQ4C3POx5Y/KDA/l4aqcdTzsHvB8TC37Dzvy9Xxf5PYjLzk2RxOt7G1f5dCTH4SrQDW8tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s+VEosnF; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8629ddffbaso7176666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 08:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725551084; x=1726155884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wa/CPlyiytH758pjN+uFI/9Rw3cBIvqnA2CafEpkkmw=;
        b=s+VEosnFkr2Z9dEjoacs0TnDnPGQZnhZpyiEEbg7N7VGRWrfiLcEPqiFD0oLoXrEoE
         gzPxAhgDzh+KBZmtnXyElxEmqrTKXcwmj1JEvPY4BRS7sS9oQQxjOKsjYdJGNAte2z/O
         vTPw/OngA1abcN6IYke84NryiP3VQ+5U33Cmit5+j4CcRuKjDqLCqAoHGv8QqU0HBXui
         ZCvqsJSn/Pyu/HRlbZs1shxUpNwoyL6NbgbOXFS6XuchXoHOvlB/RsnLSOQtBZGnjwci
         0Jqbf6asxEt627JIlsGM0sp0LCdqZiTDZHKncHOEzPK3CH9fjEZUXSKm3I2ut2M1PQZS
         idtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725551084; x=1726155884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wa/CPlyiytH758pjN+uFI/9Rw3cBIvqnA2CafEpkkmw=;
        b=tzc3fIZZci2XzDU/AAaKU/66ujSjLzaA/d/OISLPPW89/CN/M992UPIrQ7philPGnc
         H7qaKCDLcP7MsWjbro4E4/CBbwJyratk06PUfAL0mAk4bIRkvU/GxJU//gErUfMmkrjP
         KgPQrT3Hpdo5Gh2NGNeA53wj5qa3d5GJZUZqgcEX5scGo/o7vs18hJWQBFvWyP3Uwx/M
         KEpB7g56sP8mdA69+DMQylm7FonPuKNTThh0NYSHJSCDDqbn0ev8sxqMBykGLLGQyOpm
         KIJ8qytDzlcsTCL1gXUIHeEvcU2idIguJWicQUdj8Jp8BHmQWCHrWxWhFxbUjj+op9SW
         XYTA==
X-Forwarded-Encrypted: i=1; AJvYcCWv3WX2kGrIH0tB1hT6hfq3pFfNsqqrR5s5lexvVZCdxBTSVaTmfuys23i2tzoipaoVTPGYxEYrXFpSIa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUJbTQiCV91MtNaMIHV2JEdrLJ8jUo747Ars22vxbfRm1zOwn9
	GFVFfZ+qiNJWzw4CBZXwRXX/ItNG6VbT2TlSYN/Sf7zFZa68QjscFNB2DDdu5Nw=
X-Google-Smtp-Source: AGHT+IH0XZsN1jEBJtaUvI2q+jcEpl8sXaD1DG1NiRLPikvOwQ6DxcWU+6XmbfEF425L+fXjXCa08Q==
X-Received: by 2002:a17:907:1c10:b0:a80:b63b:eba0 with SMTP id a640c23a62f3a-a89a35a146cmr833057566b.4.1725551084173;
        Thu, 05 Sep 2024 08:44:44 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a82a9c438sm5810166b.204.2024.09.05.08.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 08:44:43 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: ti: minor whitespace cleanup
Date: Thu,  5 Sep 2024 17:44:40 +0200
Message-ID: <20240905154440.424488-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DTS code coding style expects exactly one space before '{'
character.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/ti/k3-am642-evm.dts   | 2 +-
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 97ca16f00cd2..6813c7ce8bcd 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -450,7 +450,7 @@ AM64X_IOPAD(0x0158, PIN_INPUT, 0) /* (AA6) PRG1_MDIO0_MDIO */
 		>;
 	};
 
-	icssg1_rgmii1_pins_default: icssg1-rgmii1-default-pins{
+	icssg1_rgmii1_pins_default: icssg1-rgmii1-default-pins {
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x00b8, PIN_INPUT, 2) /* (Y7) PRG1_PRU0_GPO0.PRG1_RGMII1_RD0 */
 			AM64X_IOPAD(0x00bc, PIN_INPUT, 2) /* (U8) PRG1_PRU0_GPO1.PRG1_RGMII1_RD1 */
diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
index ed6f4ba08afc..3ac2d45a0558 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
@@ -135,7 +135,7 @@ usbss1: usb@f920000 {
 		ranges;
 		status = "disabled";
 
-		usb1: usb@31200000{
+		usb1: usb@31200000 {
 			compatible = "cdns,usb3";
 			reg = <0x00 0x31200000 0x00 0x10000>,
 			      <0x00 0x31210000 0x00 0x10000>,
-- 
2.43.0



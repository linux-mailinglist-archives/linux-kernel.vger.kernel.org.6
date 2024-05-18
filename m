Return-Path: <linux-kernel+bounces-182953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D90E8C922D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 22:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BA1BB21740
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 20:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755896CDD8;
	Sat, 18 May 2024 20:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SbJOThYD"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6F06BB54
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 20:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716062856; cv=none; b=GIkFJPcAqR16vmrVArY/qQaocFi8lvA+RCXSM6mWDTpkF+5ZHRNj6UbTWkMsmejJGWH7fip/DSlxeOIgDQEIeLz/kvuYlU5K/y62n7MA5kogOLIAG3RyJFofSFou1LB9vSlz/1PdtxaotWT3BZNh1Jtu+rhc6prZ/V/XEi1M460=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716062856; c=relaxed/simple;
	bh=wpSPUSl5kP38TMyuibl3QbQUYCxvQqbE3qZT+7W1avU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YMRN413OV8XRe1btSGZdbOR6ZRiiJiVXQcnz8Xzlr5iD02Rz1SSwk+k9fZ71LvObrmJfKb8Qe/Ki/5JwFKhlWcEq8fkMAlOvfMsVhkH6KCb2YDZPYx/SYTELeK/k0f9QNTRHcghXBl1qzTHywyyQjASY8q+tlu01mn/u0nwNFwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SbJOThYD; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59ab4f60a6so498164066b.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 13:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716062853; x=1716667653; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dQwOyKTR3rsncCcZYmEoeJapZ7QMbyHcL4mYarDVTks=;
        b=SbJOThYDw8ruoXq/Rh3AeFiVTJ6xVrEA9Oos6Y/02WI6bPBrDaSUIQBGP7IdvRlBwN
         l4+8/1JYjhPV4QOSoKC4we+PuoclIfSTIsm6Lka0sza+nInesYig/98n+zT70e5nTNEr
         HfVhNQBIlvrMG/tsanMQoeDQLLzfWI4bB+PvdUf9NK+u0bKyUfprhVOiKetY4MC+BcEM
         UBPJe11VccpnFy6OO/5wfjoWzGfZ4AFQcZzJ9/GQUuxgXVU5TvXT1CX1c7tx30HLNyTH
         A4XIJP5q322IdhD1uuEzW1fSnbBSdUbFT3z2KhF11QSDzujIYZaJQZ3G/4qyWzXgzb09
         0x6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716062853; x=1716667653;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQwOyKTR3rsncCcZYmEoeJapZ7QMbyHcL4mYarDVTks=;
        b=pUlfwsQTQXI3EMIboejGigid56L8Vp5EKijs3SUpgc1QZzrm3nD0wqs9EznTGB1ua/
         NU8CbKtAQK4ugSZESc+0Avpmq96GMFiXWQRxWlk+vP2SZJ53ymSFSpnZ+FRvJ2kfZaiK
         wrjuo5MQ4gCyOCZMWtp3jdgWTPGP8JQ5EMeV0zAq6q3UTCilICOXIrNe/cbpiQIF/roE
         4IXYR3iKwc0poRPTh+dd3lph1cQES5kwFegTGdpu6r5jAIAw43PI2wCxocdVu9N1dmRP
         pzDOjnaI4Km2XRmyKyA6dT0P6ZeGljRQQD1r2E411gFdXCOkC6vZwFIdQQDUtudLsr0A
         Nqzw==
X-Forwarded-Encrypted: i=1; AJvYcCXSuqtcBuUkxK7i/FAGEC2bJHfTdsZZz0nTrin0SQENSUbjyJRQ3Yez64D9CDTyivfcaFNlMExoluZfwcauytPK1lNOoa/+OvWVWCPh
X-Gm-Message-State: AOJu0YwGTFnaV0nt/TNt7Pe/la2EZ+o0+CXa74llDJizz0Xp9TcO475C
	V0HDKzRYHdIiIvlU2viUtgi6kWP8qmJO9a3uJ2OCKxWLrwzhlsinlPHloZBwSWQ=
X-Google-Smtp-Source: AGHT+IGuaWD3MeBrsUVyyUeEQYILxW1BE/fsCLBcMc9qLTh1BdESQ22zX2/X3isPnS9jF25LVh1EPg==
X-Received: by 2002:a17:906:3e4d:b0:a59:edbc:193d with SMTP id a640c23a62f3a-a5a2d65f29fmr2296024766b.55.1716062853791;
        Sat, 18 May 2024 13:07:33 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b177desm1248364566b.207.2024.05.18.13.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 13:07:33 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 18 May 2024 22:07:20 +0200
Subject: [PATCH 5/5] arm64: dts: ti: k3-am62a: use a specific MCU
 controller compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240518-dt-bindings-ti-soc-mfd-v1-5-b3952f104c9a@linaro.org>
References: <20240518-dt-bindings-ti-soc-mfd-v1-0-b3952f104c9a@linaro.org>
In-Reply-To: <20240518-dt-bindings-ti-soc-mfd-v1-0-b3952f104c9a@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Roger Quadros <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1226;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=wpSPUSl5kP38TMyuibl3QbQUYCxvQqbE3qZT+7W1avU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmSQp8fpXlbh+z70zx8ejPZ7B6kRtt/r4vvpZ/Z
 0bAXMegSqeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZkkKfAAKCRDBN2bmhouD
 10CWD/wO2i020uBV0CR8hGBU7/LmFstUbety2yXbz8rii8DpEJhXd577ena/RBgquAKkoZuDZ0B
 cZWbQYkB0HTdW6g+3iM7lcCM2szcb8+5B6ltTNKhet+avcZg3d2/8eMTnL+xJeoeWLYtX2rTaGS
 6vtzldZybXGs/YTXFTqFkDwHi0m1DefGoS/9eqtHq0/pjxyJ/3W9E7mYKQrkkGh9sEuJ1cRzaJZ
 S+j4CddtRxoqY+GlJXQW1CPaveNZ7z9lxFfbbCdpotJ6mUoig/p9FN1dFs6Thep324LeWL13eNE
 lWRO4PUZfVqm9/RKCD15MoeVPitzzB1uxfLUTXpfQWCrxgFgXpcg+M1H94mx9jdRHVcyEoqIjyw
 m0an5Sdv8LzdJKgV1YmGe+VJZatgXywgtUdxRcSeVEo6jn/yz5dzQuUJBjm7KD26l9a9wa+2iTv
 Gwoko+NFc6Usfz5eFvTzKwoIWfqDqFY1J0IRcEU5xGg2wh5Wr3tCqQUwDl9RK9MTm040Qei4+Da
 5zIa2wUHSc9dnUpZuTBNTdyrqYo2N9VCxpBYiBeFvQ38CvM0GKMt0ggALor+4x/nijmjT4tQJSu
 +RDag84M3SD/cpwxiQ7EyJLDNgzuoI3k/pHgFpnaVJT5kiJic6GDj/K1kUWubf2gbzDRXjyrTLy
 7UVD5wDvmjOOy9g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

SoCs (and associated MCUs) should use dedicated compatibles for their
nodes, not re-use one coming from an another SoC.  Using an incorrect
compatible does not allow to properly match/validate children of the
MCU device and causes dtbs_check warnings:

  k3-am62a7-sk.dtb: syscon@43000000: 'syscon@4008', 'syscon@4018' do not match any of the regexes:
    '^chipid@[0-9a-f]+$', '^clock-controller@[0-9a-f]+$', '^mux-controller@[0-9a-f]+$', 'phy@[0-9a-f]+$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
index 98043e9aa316..d12c8c194a46 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
@@ -7,7 +7,7 @@
 
 &cbass_wakeup {
 	wkup_conf: syscon@43000000 {
-		compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
+		compatible = "ti,am62a-system-controller", "syscon", "simple-mfd";
 		reg = <0x00 0x43000000 0x00 0x20000>;
 		#address-cells = <1>;
 		#size-cells = <1>;

-- 
2.43.0



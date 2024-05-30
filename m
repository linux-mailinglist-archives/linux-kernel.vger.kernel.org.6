Return-Path: <linux-kernel+bounces-195564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2E48D4EA5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 17:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C913B218B8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 15:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F95517C214;
	Thu, 30 May 2024 15:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="B9ay13eR"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9769817D8A1
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 15:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717081577; cv=none; b=UA8G+uPpd0cRKfU0dqO5yNVZRKDQ4pQwnL2BY0vFHjct2KfW9yrQw7WvQn+WnIPwC53NRIjOtWLgVV5ab7ovqlHBWkybs0RAgasOVkyOiUKhLw0rzaPbMTonWeXiuzn2QTIPysxErBjn2TN2IjaKlfTeAv9k1Ceoq33IUmfaLD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717081577; c=relaxed/simple;
	bh=r46t+UbdZsFkZ6PKeLxNyX7d6B5FRFqXFHDi3FXc7Dc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y88VRHnYim8E2ZaI2zYW1ZcWBBoKP8GqRRsb/NwnwF9AFc9HxM644cIfX/XhMrMs0xr3Nvwgd+ADd5aLhLndj9E0uzS4oiqvcbkkdzDyYQ5bH3C3Awkwlg7EltMM+twuNSgzl8kJQDLwgN3oUbsmfzfHTUKdFuSIZkbaHQV8ZL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=B9ay13eR; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a630ff4ac84so701166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 08:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1717081574; x=1717686374; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aktSMI6DpVcgUPsFDDefqr2n9jbKbhFj+3ua7mOz+48=;
        b=B9ay13eRHx2YCl3nG+tohHlpYLK+mHlifH3NfG7BLnAXHZ013P3Ra67NDaiwQE10ZU
         KKzidM1s4rPA+tOngVPHPQFrSWp7mtuzje2EcYrM2sMkglQSON0F8N1CC+bRrMori385
         JuFa8g7Xe0aZXrwg3sY+530fvHaOTM9pFh5G+1W7lwYstrllgMKbeW3UidBRFKzD8Lz1
         2EqPFUNLj7uOFieMhMLM1Z+3bwLzV98bKBpdmh/5ZgutccaUZ8L+mJ3ECg6HX44qCpuI
         vEMyJfh1JGD4fCp2zfbNkoR185MJh4qk9pYwhK1hQ9kUNGLIm33ud6FHvS9/De52nHDf
         L8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717081574; x=1717686374;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aktSMI6DpVcgUPsFDDefqr2n9jbKbhFj+3ua7mOz+48=;
        b=Km6T80zenb6FvaJwwP7tlS2FX//eszfajKI3j5dNkIYJ6Zs8B63vXZLgGeJwuNsUVB
         yvAGyVT4u8RMK/+HuX1EUmDel2XxfR6TiEzNlXSvOBWaE0b3gG7NDEBzDmVuAT2xLvNz
         xxee5EY24u4QgBc6Ifw8To/cs6gZWFfQ1NbEgsIYK1O73bMpg7fghwOfPPT1EPQaqlm3
         qkJkjNn+Sw0Q3WTHP0GYMBQERohxKALOmtgDXWR8ARJdUhBPg1fr/Y03orCjGSFM1Fcd
         u+OkaeDDbmmFCsqNCwwFFDDLnwwTbzP1wE/+uYTj81cAK5QAycjiKkT70P5DlkUW5Ryw
         7Sxg==
X-Forwarded-Encrypted: i=1; AJvYcCViQUM5NxPMTFcGupaHMwZuokQiCvBsZ5Jeq86m9MCBvc+ThCT1pejsJMu9GT1nJQY457yY/jobKzrqLy6nf8jTaziQYoZOlXI8PjzE
X-Gm-Message-State: AOJu0Yx4XFQkY85nxH85vsPQLYjb3bg3RkT6/v0WEvCwZ4byplt+mZP9
	siBmF5KAgClnV9VFt7lsnC/GQehKp1YpW0XuIz/xlMQBWkAdgH5rOyTjSw3PM3o=
X-Google-Smtp-Source: AGHT+IEHzFbX4tiyXk81YyWM3vVVyfjaUrcaS+9dBD1mfUbWUGyIFKKKPTITHm/gH/bQeokYyo4eyA==
X-Received: by 2002:a17:906:5904:b0:a63:41f7:d44 with SMTP id a640c23a62f3a-a65e8e6c5e8mr162513766b.34.1717081573882;
        Thu, 30 May 2024 08:06:13 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67430f8457sm13531066b.122.2024.05.30.08.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 08:06:13 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Thu, 30 May 2024 17:05:47 +0200
Subject: [PATCH v3 1/3] arm64: dts: qcom: pm7250b: Add node for PMIC VBUS
 booster
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-fp4-tcpm-v3-1-612d4bbd5e09@fairphone.com>
References: <20240530-fp4-tcpm-v3-0-612d4bbd5e09@fairphone.com>
In-Reply-To: <20240530-fp4-tcpm-v3-0-612d4bbd5e09@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.13.0

Add the required DTS node for the USB VBUS output regulator, which is
available on PM7250B. This will provide the VBUS source to connected
peripherals.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/pm7250b.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm7250b.dtsi b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
index 3bf7cf5d1700..4faed25a787f 100644
--- a/arch/arm64/boot/dts/qcom/pm7250b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
@@ -45,6 +45,12 @@ pmic@PM7250B_SID {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pm7250b_vbus: usb-vbus-regulator@1100 {
+			compatible = "qcom,pm7250b-vbus-reg", "qcom,pm8150b-vbus-reg";
+			reg = <0x1100>;
+			status = "disabled";
+		};
+
 		pm7250b_temp: temp-alarm@2400 {
 			compatible = "qcom,spmi-temp-alarm";
 			reg = <0x2400>;

-- 
2.45.1



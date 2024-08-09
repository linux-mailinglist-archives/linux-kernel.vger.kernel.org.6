Return-Path: <linux-kernel+bounces-280737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 791B694CE60
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD154B20FC1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C3F1917F8;
	Fri,  9 Aug 2024 10:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XHUP5RYo"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7418618FDBC
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 10:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723198380; cv=none; b=e7XoveBmbeVX/J9XW5F0deqGtv3x91bWlRMfIQoQ/eYZBghdQdGzo1QkrNtfT62x9tDs7CHnj+lLFopigFzi7LdU32n9TKYo0IwLb9DLYDGxPi7jegTpATkndhWjugymhlEpUBGgwjalrya0XJnMdPrK2Y0nRdT1WEiRWk146I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723198380; c=relaxed/simple;
	bh=aQW9daCK+DazrmP2CfvTcxBVOXT8VzUcSmts4V69YMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Uuve6nF/oXMql4p+hf5xK08yyJr1QI9FwbK5F4KDZTNOAFQwOFiTf4Cg8meTN2v6K7yE9ClTnas8WoSUyfZrZ2B5dK37IFA6sGZI9NvMZP94mVHjNp8mZ7tYMT++x9U2ckvRXXITnWuCRAkov447ypGa1ENVLDgLursVPztF7Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XHUP5RYo; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5bba25c1e15so2223449a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 03:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723198376; x=1723803176; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rilrT7/IjMbXVgMURnQL8NL/sfhS1Oc4diIFcldpBSs=;
        b=XHUP5RYoLOt6CR29AY3FL0zjedJGJf7e5eBwTEcBTzNUOyTtye8Ymror22iDp5UdFG
         IbEZgqkBSA4wzLOaI2YzK/4XNdkYSMZ5wqSgObV5TIB3/7YRdhmQST2jiAMYtRzlq7RP
         LRo3LfkFdDCRg1nUMhr7a7lUqjtPA2CpA+FvL9VnyTXAvRbEdQBy+muaJH1mE10NfA+e
         fFg3UiGqxM4pHlcdQJGGDGi9c/MSWuptT6iE2MW/EsXRqbchrJh8s9cZIt4PuUAoaocU
         6ZieDY72W0IBx+GqZ5qFTJ7gLqodDECQSkDQXIzQ9W7odDMJKRkF7wTyIntPjvrn1S6h
         p7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723198376; x=1723803176;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rilrT7/IjMbXVgMURnQL8NL/sfhS1Oc4diIFcldpBSs=;
        b=sZHpcQvJQpGEpKy8rxHqetomtCwHFxemUZR9CFhZo4gFCUpwgUiBDdGJjwc+45/Utp
         BbwrIdrvgTGbT2cMrCbJ8oB9IkbcPcGyNuZaHkjEKgAApGwctCz6xjXF+3u8+9JnBwcj
         PDt0IXeyW2cyeVdSkdbK+fDBiSmvQGLZguHxLH7KDDIOzn7ZToSMJugplMuLeL+z3bS+
         v1zIzCQ0NuBXMf+BT/m4X7obvyvbyaIIJhxpju4ThlWg2Bsv77yyT1kMWmujTAuhsFx5
         UJxUBCt85QZuc7ssdv+iAng4y4YoZ/dSZ6EVqSfp2dvznjdZjTtAfZgYwGuali0V+0aT
         fR3A==
X-Forwarded-Encrypted: i=1; AJvYcCV/GVqPLrLwnOaV9hDEbrVdc+JlonS4MNzM2hFolhFduCKbnBQmKw87ZI/Hs5QqrntKu/CBA5y0FcKIGJoO9nz/0lMyXNZ0A8qb92ZU
X-Gm-Message-State: AOJu0YztHv+ncJRykPuu5fCwhrNOpx8WT6wd3Yf2au2w7CLxsQaKkpza
	HmraoDyx9SHFY6wfTWaqh2eMfpV/9ND+SrIpcUHFRU5pwKnbov2iCYm7Cs/3OzhkyE2oL+S5XPI
	CE/M=
X-Google-Smtp-Source: AGHT+IEmnaJ9bQ5ZBdtVQd2FJNPVrknPU4mVC2unYQXy8BxmPv05p8cNt1l4yXZYx3UlWxty34jg0w==
X-Received: by 2002:a17:906:f59b:b0:a7a:acae:340c with SMTP id a640c23a62f3a-a80aa542aefmr86457766b.13.1723198376265;
        Fri, 09 Aug 2024 03:12:56 -0700 (PDT)
Received: from [127.0.1.1] ([82.79.186.176])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bc4230sm828105766b.32.2024.08.09.03.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 03:12:55 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Fri, 09 Aug 2024 13:12:43 +0300
Subject: [PATCH] arm64: dts: qcom: x1e80100: Add HS PHY IRQs to USB1
 SS[0-2]
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-x1e80100-dts-usb-1-ss0-2-add-hs-phy-irqs-v1-1-9e1bc62fa407@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJrrtWYC/x2NwQ6CQAwFf4X07Eu6KyrxV4wHpMXtBXELZg3h3
 914nDnMbOSaTZ2uzUZZP+b2miqEQ0ND6qenwqQyRY4tX+IZJWjHgRmyOFZ/IMCdEdGLIDnm9IX
 lt4Ol7Y5VjjycqObmrKOV/+p23/cfC9rNk3oAAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2082; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=aQW9daCK+DazrmP2CfvTcxBVOXT8VzUcSmts4V69YMk=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBmteuhqUsDsoM+KQ5k+IjJzJyZ6CRVsRtFrSZK5
 bZ8ivG9+L2JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZrXroQAKCRAbX0TJAJUV
 Vh+xD/0S/5l4vZvltDwRrT4pUJiLVGhpPxTIDBfj/6Rqbr7mm0Q78H6fpcZrQ5X3k2s/CMTmGzU
 fzNy9POZA7KdG7YfwOUnI42+O/UHkgNdLcuQt0QyLpnXDJZbYYER1ikylDXqgZIZ8n8dWoCzOjz
 2mGMiIg5eIx9w28Eu/36HWpOqVYJv5xddbP0ggwuknzuKTgfpJPDOjqBdNdK4LRrZXvedytcCm5
 fLmNVOtNN70r3nEgLwAZY4W0SzZL9CAm6N5dgOCj8a4Zq3hQgfDHfOXgyjGGdCqxZMXo1N5OOeS
 RQOFipqdu5QxEYAYcXUUGitEe7JTjjsCZA7UO7YSFqD7njmA5c7vQUnjYd1QMfxkTY0OjGJSxOg
 GOsHRSGunmgt1D/kHSLIyD0UmKM3bq1RVKHK+O6oPFchAMruw0LoS0NvQ/gcPjW5PmSqUo0rCWV
 UT0GpcjGawCerIhDUioqbD69aag+hJ4zZLSlp5APH3RuaNGQRUEfHXAGshdTGcbob7TOs9zBLA+
 qG9KD//FIpwAZuwKZJ6FhRJa/PDOpihRRIwgRd+VTwvS7ggd+HQyJNFVJh/6Z9g0qBXsrwDZXmd
 dIKlpz0HW6juKud2Ie8G02O+lp/0oLvtncDHcMHAvbEPW/5YyzDK39M6XVmEnsS+57tB+g3ZK5h
 OowA1L8wRVS3nRQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Add missing HS PHY IRQs to all 3 USB1 SS instances.

Fixes: 4af46b7bd66f ("arm64: dts: qcom: x1e80100: Add USB nodes")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 326283822aee..254643650fa7 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -3871,10 +3871,12 @@ usb_1_ss2: usb@a0f8800 {
 					       <200000000>;
 
 			interrupts-extended = <&intc GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 363 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 58 IRQ_TYPE_EDGE_BOTH>,
 					      <&pdc 57 IRQ_TYPE_EDGE_BOTH>,
 					      <&pdc 10 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "pwr_event",
+					  "hs_phy_irq",
 					  "dp_hs_phy_irq",
 					  "dm_hs_phy_irq",
 					  "ss_phy_irq";
@@ -4045,10 +4047,12 @@ usb_1_ss0: usb@a6f8800 {
 					       <200000000>;
 
 			interrupts-extended = <&intc GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 368 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 61 IRQ_TYPE_EDGE_BOTH>,
 					      <&pdc 15 IRQ_TYPE_EDGE_BOTH>,
 					      <&pdc 17 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "pwr_event",
+					  "hs_phy_irq",
 					  "dp_hs_phy_irq",
 					  "dm_hs_phy_irq",
 					  "ss_phy_irq";
@@ -4136,10 +4140,12 @@ usb_1_ss1: usb@a8f8800 {
 					       <200000000>;
 
 			interrupts-extended = <&intc GIC_SPI 372 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 369 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 60 IRQ_TYPE_EDGE_BOTH>,
 					      <&pdc 11 IRQ_TYPE_EDGE_BOTH>,
 					      <&pdc 47 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "pwr_event",
+					  "hs_phy_irq",
 					  "dp_hs_phy_irq",
 					  "dm_hs_phy_irq",
 					  "ss_phy_irq";

---
base-commit: 61c01d2e181adfba02fe09764f9fca1de2be0dbe
change-id: 20240726-x1e80100-dts-usb-1-ss0-2-add-hs-phy-irqs-0d483addf0c5

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>



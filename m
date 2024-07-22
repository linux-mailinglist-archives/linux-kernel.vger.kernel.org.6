Return-Path: <linux-kernel+bounces-258910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 209E3938E4F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 13:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4627281E97
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEC216CD3F;
	Mon, 22 Jul 2024 11:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="banfmzLN"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B66516CD3B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721648920; cv=none; b=C2bQfaJtjaIZtWqtFnADiik0751xLHxSaoweGTBwljI29WNraDQXJU1rvRWv2AMVNkVJ7A2MJSMtg270WuztYTyuQq32KxeDG/Dpn2iOWpLC/VHuTeLKl2IoZmNOtv2LvQ51YAhqxqJjsbHVQNF3eRPiWkgr1wFszmWqt38ugAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721648920; c=relaxed/simple;
	bh=nrlJd+Ezz8jJzKd5NAOf6vI4+HmgnsfcDU38N6Fy5LI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TjbuO7wmdN+IYSfzFoYDzv5ggNd8Ycz5qhNwNiVAdUjC0pdjMMLnbtrNsBJSPmv7DClcl4Z4Je4nw+jWEbNyrom82KpPYdR9qpkghee1SoveRZPVNnv0lL7eVhAA4AWmzxo2vx/Yjrbrht/xMuKOieEM3xCo5tjHrf9TBkinD/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=banfmzLN; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ef27bfd15bso16713201fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 04:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721648917; x=1722253717; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0hOhlrxeucftWXo7wmrL/LNpoHU5doSIU8ZyTIc9YDA=;
        b=banfmzLNVNBXZtLtgUOS4j7I1oS1z5iLOT8O7ajHiq5LQlwrcboGi3YrZ4e5qEbXR9
         wse93BoL7K6Y5FsCCISIB/pS/JxC0ashxuit8bvEiVEjw/oxscLE2JHV96pzsL2CZlSu
         ChRsdPjVGdsGU1UNljuUIfrGHAbHEjj5iqsfYKe9KcaDJAzWaFOpglvmzJTxj/B3bogi
         R2bQmGgFBVokHH6BLQo/urpSxhijv16lZdcI9mw9tt8xJu70yDg35hzRW6oE/JzdPTf1
         z4G96rHh5G6qUXUPn1b7NXceaoVj3IVv8dIv5DbXC2H52KxBozE1shIP/PbGuHLCz19U
         H/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721648917; x=1722253717;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0hOhlrxeucftWXo7wmrL/LNpoHU5doSIU8ZyTIc9YDA=;
        b=e55REIpotZs40Zy7gRqCnC2SRl6FrfDu2DBib0n5EkrsKsGrwxh12pigCQnbLYoPnQ
         hSyUNiOVOW0AjaNO4ELiCJ4gOueHVFlIzOyilVyH6A1AJBef3IimXHNhpBe1SVZ0G3xS
         T2s7x5kFmjRTRZ0dh/XhJJkzsxjeKbuT6ahli2HNUi5uPw7g1u4XVR9trXc826dakKwE
         UyOBVdwRDcFYsil+guau/qzzJqzzWgl7Ehuy+hJAHHp4tbDL54ZVpcd9fOkOFFi59G7+
         aYw5ZCyCZclvIc6zU2FhzYRaX7bZMmwnxTUDBWnBCtVzfpIv27uVWkyFI5y33f+4W1ts
         9UGA==
X-Forwarded-Encrypted: i=1; AJvYcCVjfcZvX05041FprgZCvTcId/UReLjI5Ue+Fvaq9peO9ngA5BcVYiSw1eNxgAtGRugiVFlR7LXVkg8hh/WjXrZjrk3X3BEzoEKla75c
X-Gm-Message-State: AOJu0YwhIEQsUEiyL1B6ED2HO8Uf2EDnPZAbCCbqU9owTFTDEUoGOI8y
	trc66UX8/Fz6bjYPZ2XUiPSf4ofLtJp1wYGCnz7iB+DtasolqEiZO/lKvEfgNlU=
X-Google-Smtp-Source: AGHT+IH8XICqaHV/dw+1/5h8ErduoIP+Z7bRbFtbr7wPSzjXxnwDcn8C+vyse3chd/HIaJ1/0vsaUw==
X-Received: by 2002:a2e:7212:0:b0:2ef:2c4b:b799 with SMTP id 38308e7fff4ca-2ef2c4bb8d6mr24913191fa.28.1721648917311;
        Mon, 22 Jul 2024 04:48:37 -0700 (PDT)
Received: from [192.168.1.191] ([2a0a:ef40:ee7:2401:197d:e048:a80f:bc44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d68fa17csm125681235e9.2.2024.07.22.04.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 04:48:36 -0700 (PDT)
From: Rayyan Ansari <rayyan.ansari@linaro.org>
Date: Mon, 22 Jul 2024 12:47:56 +0100
Subject: [PATCH 2/3] arm64: dts: qcom: pmi8950: Remove address from lpg
 node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-pmic-bindings-v1-2-555942b3c4e1@linaro.org>
References: <20240722-pmic-bindings-v1-0-555942b3c4e1@linaro.org>
In-Reply-To: <20240722-pmic-bindings-v1-0-555942b3c4e1@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Rayyan Ansari <rayyan.ansari@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=768;
 i=rayyan.ansari@linaro.org; h=from:subject:message-id;
 bh=nrlJd+Ezz8jJzKd5NAOf6vI4+HmgnsfcDU38N6Fy5LI=;
 b=owGbwMvMwCXmtuJiX/SRuS2Mp9WSGNLmuQuF3hbgLW50+u61VDr52Lr9/Dln9vzzYdX0k2Cr3
 XvgJhdPRykLgxgXg6yYIsvhpi9rXm93ErqyveoUzBxWJpAhDFycAjCR2kkMv9luf0rmkqx6qMQy
 aXt6QLPjN48GCykuvpOrPfkYmwxj2xn+yrPMKl/AdPrjkZtB+klz5G6G9qssCHXQt9pYfdrJr/Q
 oKwA=
X-Developer-Key: i=rayyan.ansari@linaro.org; a=openpgp;
 fpr=C382F4ACEBB74212D4B77ACA46A8D18E5BC49D84

Remove the address in both the reg property and node name, as it is
hardcoded in the driver, meaning it is unneeded.

Signed-off-by: Rayyan Ansari <rayyan.ansari@linaro.org>
---
 arch/arm64/boot/dts/qcom/pmi8950.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pmi8950.dtsi b/arch/arm64/boot/dts/qcom/pmi8950.dtsi
index b4822cb17a37..4aff437263a2 100644
--- a/arch/arm64/boot/dts/qcom/pmi8950.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8950.dtsi
@@ -84,9 +84,8 @@ pmic@3 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		pmi8950_pwm: pwm@b000 {
+		pmi8950_pwm: pwm {
 			compatible = "qcom,pmi8950-pwm";
-			reg = <0xb000 0x100>;
 			#pwm-cells = <2>;
 
 			status = "disabled";

-- 
2.45.2



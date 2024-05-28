Return-Path: <linux-kernel+bounces-193056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 302E18D263C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C26151F2A33D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A5D1802A9;
	Tue, 28 May 2024 20:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BDBkY5Fc"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FABD17DE29
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 20:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716929025; cv=none; b=Q+FfAGSYIFeMEB7NfU94taGL8b+6Qw3HZG1KoVoFHmiFNyZaYrqHituCwzzh4JIfl21v5Xc2bs75g3vWCIM/+xuoPnIBxUkA6RkrFnW6VRJ6i/ZWbg7pmHT6i6vpUU2WZlpbvcT1T5hiHXo7S2rephAjcWid2BBNSZUdUYgpQeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716929025; c=relaxed/simple;
	bh=efm+IHUJ1gyGBEQDbtWwDLgNHtx+hRJSWzbFoBIcMe8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FSCcGme1MDA7VkEyKS83nzQ3aAxKx0O/0z2ydTbuo2oF7Ek0uk0KPK0Zb2bo4Bm1XD+kDi4ImLfw40eYUqBVp9ZG2gudTmwnKO1FQz9g/14NT1WtJSbF1w8F7YTmkX2Dhnlam9QLJ5pWyqPVY29OXcRFHbGwQuWCfR3PCrqEd9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BDBkY5Fc; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52962423ed8so1553381e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 13:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716929021; x=1717533821; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EmcXmv0vM7R1Q30++GJfNW0y7hLTKdDFrf+Tedwk3q8=;
        b=BDBkY5FcE6f5cxfSZYm2Tw12qdUSXyyhKRGPoZ1xgSeIUhGDdhFpRU7qcnY1kYrcHD
         SpQfeuU5iKp0to4ukVEBOnSC6zO1aApNk9iMlUAqjNMvzuewzUsTWuhflroS/ydhpbyY
         eve4fznNHDoK4m8cP8NMpT0DNhPbwE9QmnhW0RLjYd/CXEyCl8jyuIHCf3G+94+Cu9pu
         WZbRrSyUkxnOER+uK8dM9I+p48gb08O+PUAjbRETpKGBO/1g8rcLbI6RlUaPwrWw0Zxr
         61VzEA6uRpzM2N3u76zlxu1PFNkzGTvTeJHD06z1CZqjCfjrE269+zZy0AzZa2l69VyG
         GfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716929021; x=1717533821;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EmcXmv0vM7R1Q30++GJfNW0y7hLTKdDFrf+Tedwk3q8=;
        b=COqhVPlFIHCGWi5NCq3wGNwuN9rVbwKQy/clgWEZ9YSirGR0nFfFJMEmFqtuzHHlW0
         YaNeP4R8jc39cK8G3mRhKSs8mell7TCRX9Dg7Qj+vj8er1NGOLGu7TMsVG3qzHg9Y9bE
         Y+U8J+mBu3LAuIPsyuy7EnBGH5z/X8bQKE6NVLGJ1lnJQueovvGfwaM4PpBnQKZ+7iGO
         a79r12L2TmlZpWFYfrxPRHIM/zVbYYqRTpAtHHcb9vQ/XQfymlKsn7c2Ow/LUGOsMq8J
         rx6dA6Oq7TgBgt3Wx6f5aoOAtlWjzZe8lbpYIIABD+eoOghbMMceHyrzVk+x3yddGt4Q
         blww==
X-Forwarded-Encrypted: i=1; AJvYcCXstDCAqAjcT853An4I1hB0ptu4GviH+uERczlo3VMOK3xsGN7xPzmLe6k6nXKS3it6bwP1XB9QUivL991dk7i4eXYyAIomF8FE/aEX
X-Gm-Message-State: AOJu0Yz47bkZ1SRsTjnZ6MZv5tbJ7pIlyOJM+bu8p/VK0vy8BUkxg4Zz
	0cIatdepZL99NdvUO9qDigRicr9vKpnt4OaA0DanLBt9k+nwElVeIOEApoZ3gkA=
X-Google-Smtp-Source: AGHT+IFNpzCTrqaTcYkcEY6nP/9aGb8McoGYnt4x25NGIDAOtDme4ULq8b1blATxcvIvX8L4x31fvw==
X-Received: by 2002:a19:9104:0:b0:51a:bebb:690c with SMTP id 2adb3069b0e04-529645e331fmr8152294e87.12.1716929021550;
        Tue, 28 May 2024 13:43:41 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5297066b885sm1095493e87.127.2024.05.28.13.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 13:43:41 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 28 May 2024 23:43:25 +0300
Subject: [PATCH 07/10] ARM: dts: qcom: msm8660: drop #power-domain-cells
 property of GCC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-qcom-gdscs-v1-7-03cf1b102a4f@linaro.org>
References: <20240528-qcom-gdscs-v1-0-03cf1b102a4f@linaro.org>
In-Reply-To: <20240528-qcom-gdscs-v1-0-03cf1b102a4f@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Robert Marko <robimarko@gmail.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=824;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=efm+IHUJ1gyGBEQDbtWwDLgNHtx+hRJSWzbFoBIcMe8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmVkH1PiaA7rMYukGgZW/ppDwT/j0XCoKa/xJ7e
 ytJq3x1L7GJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZlZB9QAKCRCLPIo+Aiko
 1XHjCAClBiTfjCpf1OW82jhz6TmnZNpwcb83AFpnS4PlCGcjBbRosPVnb2roSsDDVPTVImuG5J1
 ZvsrptyUH14OWU0UgjvLWmfImws4YBEQe8TnIFHHtuD07g8qtACsTPzxGxIeV9ppmZLcH4TtiBm
 OFrq4YZGg+RDHRspPrVINi+5MxZm43CejKyAWzYnKhIxpEfdvwR5xxdsA1PRJJpaMUTJ1JlWaBh
 reLZDuX9Ln8Mkl4E5Pe4dBdM5qywjETymneM+8Hx5btVNc3h9jA6ZE/78OTPkZgmNKe6u4v+rBE
 n4a2EaSVeduvVX4N2x0OkcgIjkfCUzQsn3wvIJ4X+kpn3zKA
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

On MSM8660 the Global Clock Controller (GCC) doesn't provide power
domains. Drop the #power-domain-cells property from the controller
device node.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-msm8660.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8660.dtsi
index 455ba4bf1bf4..a66c474cd1aa 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8660.dtsi
@@ -113,7 +113,6 @@ tlmm: pinctrl@800000 {
 		gcc: clock-controller@900000 {
 			compatible = "qcom,gcc-msm8660";
 			#clock-cells = <1>;
-			#power-domain-cells = <1>;
 			#reset-cells = <1>;
 			reg = <0x900000 0x4000>;
 			clocks = <&pxo_board>, <&cxo_board>;

-- 
2.39.2



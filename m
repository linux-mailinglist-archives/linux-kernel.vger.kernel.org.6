Return-Path: <linux-kernel+bounces-437305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 850FF9E9194
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FC951887522
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A4A224897;
	Mon,  9 Dec 2024 11:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D69ceDVl"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B022236F3
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 11:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742182; cv=none; b=H46/PPWYbz7gvuGNzq3l7xtnfsiF7Np/M3wdZethE2LTpDqgP8nBN/YMq9rQbzBCNBXRfwmPX7t28sHs+nvNp7JeEkU/tphXUYMsNQjcODFITKIkZLhH0+C+OSfPFp1QaL8dzPHdJFhrB2AgfV4AvOw/JlKYRBEnCM06Fuwrdp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742182; c=relaxed/simple;
	bh=KNZAbjmVONlwWaLzG4pKciOZsI12f8QX5famGIgKN4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pE2kXctdFOqngXYybQMqB8bBgJbXQhYroDU+xwYb7lgj4pQODrr06zW9VEgVR8/eZ59QVaFqLBL8h/CY8YhUqrrbsTI4GncV2di+FmghFLFWaexfq9sie1GB/anRXe1qKmItHrGtheFDOP+vMJVVkZ/a8HICFkRfooZ9gNNpQEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D69ceDVl; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d3cd8e59fdso269634a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 03:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733742177; x=1734346977; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QAaVRwVOSTNlQl4wGWGQTJ+u4VaoEY9iNcXW/N9EBYU=;
        b=D69ceDVlrj0Hb2usuqW+BgelxANFJZBKe26UFx8jxdrcy4dJ/j7OhxU9t/S0iU5jz7
         v1cYM95ex96WsrrZiYKTRFO9J4rlZFkz6UbcA6kV9ic0hYmCtUmTBweKIcicX1VMZwdK
         qNerzb5ocRI12H2Inr4QK0KaLwbow0k8X8yQ0OeO0U0vD62/PBEH/2kFTd6JyfGepNml
         iHKpIfQPycTjGmIK6doKM/VFcYB6NgnCVXrV8794l+IAN889XeJtcDzrCFM1RQuv3b8X
         VQPdxJL2Dvbax4yZRZjDpH/iBR+jacA0S6jpoeFHenBd7yFrvBYbCNqoEgtDYO3Wputz
         y2iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733742177; x=1734346977;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAaVRwVOSTNlQl4wGWGQTJ+u4VaoEY9iNcXW/N9EBYU=;
        b=YocL+SKLEx39ycVisnciBwHm6qpcVtSj+UGkMDT8x9rjb0eLRQLyY0rkB2bstWloL0
         pE12Y9J8DwWAsN2rbdN3mWIg5WXtC8fA0g5R7WqgzJrw54ii6kYfpCc/0AlymOt+mVkb
         NsEpQweR1FtJO0HxfPQgtAWw9nIXD6t29ATq5r0Y1hvknpb/AuxNnj28x7z55RcuEP2m
         OjSdOw/VBr9IxeRc1jFBhOhPcnSqaE5ET6vYlXVhTrIXq1yDK0J6KyKFeA87Szg7IlUp
         a8VL8XfgHbWVUSGkikG1W6SYgQ5vEtCnNqpvSQoTEKxdC1c+px1ovjiMNoRzIrb7v5gd
         vJQg==
X-Forwarded-Encrypted: i=1; AJvYcCVG5yXsiZxpNI2jngNMBvxVrOX2oM+UnpVp6jgsVt47VuT8l8w/7q+1bqUiHnscWDD8ozi5ul/G+juwVAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYd51tfK/dM35lsb8jRY6NcFQgP+fv5ARf5JShDbXdyJjULIy2
	XHvRgSdsB12iRWJun/+VQZ0toVDCQJte6CifZOjaTyy5D4r1wY51jSqCErAU6Mo=
X-Gm-Gg: ASbGncvK+GhXEOlrxpwS35fzQcBnNnI1HB5bi2DU3o+3CiUYF+W6bkdJ06NJx9AVu4Z
	wKp47Kh5Zx6XY36akr/f/pXck1Im0C0zb1C1nD7KPfXTpogA1DvNJ5b+B7kNz2pNZ8VgUa/XfwN
	IKF6IVyd35vEB+dLHr7JuWyD7KR9jPLj6opZpp4FxfxQJ59RFc8tm0hqtfxUVzCavI3cFliopUE
	M7rK3NJUJR3RApZSpmeMWiboe47BKNTJgYiL8Nx5bi9bO1ay5Z4b2ZhFlbtFmKsfirTew==
X-Google-Smtp-Source: AGHT+IFsh0IW4nVrVem66RNZuyFbrM3YfAFlvCILgj28pLdq3AkrGuyNbqWT9+sMesCAjx85bwbB+w==
X-Received: by 2002:a05:6402:849:b0:5cf:ca6e:400d with SMTP id 4fb4d7f45d1cf-5d3be69a983mr4023479a12.3.1733742177555;
        Mon, 09 Dec 2024 03:02:57 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3dd4f641bsm3348818a12.51.2024.12.09.03.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 03:02:57 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 09 Dec 2024 12:02:21 +0100
Subject: [PATCH v2 16/19] arm64: dts: qcom: sm6350: Fix MPSS memory length
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-dts-qcom-cdsp-mpss-base-address-v2-16-d85a3bd5cced@linaro.org>
References: <20241209-dts-qcom-cdsp-mpss-base-address-v2-0-d85a3bd5cced@linaro.org>
In-Reply-To: <20241209-dts-qcom-cdsp-mpss-base-address-v2-0-d85a3bd5cced@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Abel Vesa <abel.vesa@linaro.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1249;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=KNZAbjmVONlwWaLzG4pKciOZsI12f8QX5famGIgKN4s=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnVs4+BohC3aei1nVmhWl5xl8DDIChkIexXA1wx
 sWvfaQ4HB2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ1bOPgAKCRDBN2bmhouD
 1/50D/4ribLsjmgHdAPHMj+++vUUCZGI385wfyv6nbt13SqwY0Kwp+WqcC6R/1H7Ez/LCdhLN/9
 aAASrCx3ezkzMG68dTDi+b4MDW7XeWa8H5v7U07TO2li6xWLAUUVopfIGIVIlBn72Eaz+eeogzP
 nRgzRVzGt04OLDOYyE3orpGpr5/r+0Cl1YeHPhDC/el6Y8wBp1ETXXu+z5uVS4CsFnXcNkFNH81
 XsW7+XEXo1pC10klyML9bmawd5xz3PNNH2GqVeVIGzIUbRDbpA7XwzI9Ro8+GMWv2DKyLQUjE88
 uS+VrNFbcAHLIOMqM7K61Ix7Xvnq0ob5dcTYM+aqz06os8QhIumGPdd3Ajegz3cGO/tHCpcnzqy
 IKSh/40NA68pgB6XC/pxzMlRcNaFWawkktkVX8hbW3TnsMpWnQ+yYAHg6V9FXRcBChPCj0FQxCU
 qSMOwzgUfal+qQqIUxTCERNDg2OUW1rF4NWInaqEmTCd8m+awhuz+lpLmf2RVSMaDU9K8ArA6MX
 0S5dgH6Bs8K+R4pQzd7NjT9e30DM/wBa69EOAulQEXoggBEfTTDIYH4lcPxWj9yyqDvmEgvJOax
 278y/YbypFscvzP04/Mq/YGu7/huS8cKh0KmQ77Aadollgwse1mryLpotlEFJjbuLZ3W3R+y5kG
 b0NIR+FfDg+KIXg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The address space in MPSS/Modem PAS (Peripheral Authentication Service)
remoteproc node should point to the QDSP PUB address space
(QDSP6...SS_PUB) which has a length of 0x10000.  Value of 0x4040 was
copied from older DTS, but it grew since then.

This should have no functional impact on Linux users, because PAS loader
does not use this address space at all.

Cc: stable@vger.kernel.org
Tested-by: Luca Weiss <luca.weiss@fairphone.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 3df506c2745ea27f956ef7d7a4b5fbaf6285c428..64b9602c912c970b49f57e7f2b3d557c44717d38 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1503,7 +1503,7 @@ gpucc: clock-controller@3d90000 {
 
 		mpss: remoteproc@4080000 {
 			compatible = "qcom,sm6350-mpss-pas";
-			reg = <0x0 0x04080000 0x0 0x4040>;
+			reg = <0x0 0x04080000 0x0 0x10000>;
 
 			interrupts-extended = <&intc GIC_SPI 136 IRQ_TYPE_EDGE_RISING>,
 					      <&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,

-- 
2.43.0



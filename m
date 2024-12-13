Return-Path: <linux-kernel+bounces-445018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F979F1006
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A8061888C94
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CDA1F37C1;
	Fri, 13 Dec 2024 14:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aJS+INke"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631061F1902
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101695; cv=none; b=VarofaRpfxu2ygyZchBWEI4ZAu7OaXS5SMmUQS4ryKAD5lBZGhJmSiFjYxtnUlPbPCsDBvtm9TXFQ84iA8I7dZr79phRLJpatf14X2i2cMkp0ljErMJEZ8xRWhB+ZLIt1IgCBpk70AgXIqezDJeEwvW5Ua0Oh5XU2LsIiy5VeGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101695; c=relaxed/simple;
	bh=4XlWKfnmTuQGxdgudvxQgYEWyzNKQNtSzL8TC+5d//c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fs5Q+HP9p9mdQ0EqFaCse9OZlcFnpw7LUnqkIUlfKhs/osZTLKk44nMkfCBUkMSexJ/2KNKWbnERTEaG27yd8LCPqoh28VAngZeEjkuMDRUOOdltKdnV+vpbNIsZ4cN9Rs5rdGgPmy9tI43wTG2ghNfmMjlMa5G3Gr383G4wPJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aJS+INke; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43616c12d72so2328045e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734101692; x=1734706492; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iO10RQLOSphsKOuYcR9GWLEZ5zCmIXSgPjuSN5APqZ4=;
        b=aJS+INkeWk0VpMd4rV9JoJ5EtzIZ0alQbAI4u5Br7zX95KAnaWghmW+cRZkmvcdVVL
         mpCQXel8p1hM2qVF9Zgmua2Yw7Pfj2wpZgoTZtfOqx+pbIwvy0sTLmnEE+MziadG//Qs
         k8EzM+prDcy35HTyJJblhaPJDZ61Rhw59xSm1wnc/K92dvUeDqmCvEUFZRPqu5mqdYzm
         rY35+owAtfSpnmn/tRO3AShVL6nareRMeK6lhl0wHp289VJPXzYwtZNgNW73I0Y9yLI2
         9nZcCeNeG0p6BtPwwiNuvh3iVCl3QiW+Fg9SWm1NIxY4GBC3JG+YGCyPvtnuFPuBrjOc
         SEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734101692; x=1734706492;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iO10RQLOSphsKOuYcR9GWLEZ5zCmIXSgPjuSN5APqZ4=;
        b=nEMlwIlyxJQWgiGJ+eATylkORa6OwZVR1ENI2yxnVgRGH1OxYg3a/FM/gXORDyZlmh
         fIYmtML3UqbjzzIzXoGcUC7JCSluEVQcZ8P1t8R3I3MHPZ580zOadm7OcSQAZVbcC0HL
         OKkLHe3CXfTRsfIbQCYXZHMwFN0X3IKT4pYWGZGhVO+eubpZ0FxLGIGA4jvS2oj2yNLJ
         IiIB0wLZWpE9yGczZbo1GFrhRWfsA1wwbaLY5k1k+jH9NyrZbNEvPQkShhAHY6taDLuN
         hrrFWuJbQ0me/Bp7eSg97YP44B+i9TOgl86FPG4BR91S+cEzTmB9oAQqMXvZHq2eBy35
         VwxA==
X-Forwarded-Encrypted: i=1; AJvYcCXrmmUDi0zlssIIke2s6OO3/gN4azIkxRe1veiFO3qWqkVVutYr0Dz+fT7FkFSxpLBcdew2DOjll0kyNTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsXxp4gVZPSZ6SNVzmETm/+mq85O25d0txqqBn2WQ16JUMlgbm
	26gxNoyhiOAXpTwdq9mm5WeJpnNwYpRLKE2B6mPG47vH0lri2BkZtmxv3DGfiJ/d6ObHlerrbFR
	v
X-Gm-Gg: ASbGncvBY2xXVPE9qzmw2mJlYHZaylf2Y7pPlQZT6kLKL4pvFEQlYoKFTe/tPOEIPnK
	PqpT2O3/3iZYeTDfi/CJU6Zsc+esg5zefMUgek7UASslOV885pWrLIOBtqQztalbedJB2353RPS
	hXIzuRV0LBly1mRJHftP24vlBuex+Ot7ZRtrD+JJwnBr4DI1tta1W9FtUXNTZ+Yu1Af2iojASI2
	ijkqW38Wq8q3fPjEFpxKucDwS14tp2nh4RjLyzO8V2jOe3pMQ/N1nbjTX11yAEe+QAQBTJy
X-Google-Smtp-Source: AGHT+IFkbSFYO2tVIHGBhWsmKJwrpbF1iONLkfAHBKHALsaJ9F+2v5aak2onv6WRegZrdIFRTiXJ/w==
X-Received: by 2002:a05:600c:3b88:b0:436:1902:23b5 with SMTP id 5b1f17b1804b1-4362aaa6c13mr8919775e9.4.1734101691888;
        Fri, 13 Dec 2024 06:54:51 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436256b42c8sm51547305e9.29.2024.12.13.06.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 06:54:51 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 13 Dec 2024 15:54:07 +0100
Subject: [PATCH RFT v3 18/23] arm64: dts: qcom: sm6375: Fix CDSP memory
 base and length
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-dts-qcom-cdsp-mpss-base-address-v3-18-2e0036fccd8d@linaro.org>
References: <20241213-dts-qcom-cdsp-mpss-base-address-v3-0-2e0036fccd8d@linaro.org>
In-Reply-To: <20241213-dts-qcom-cdsp-mpss-base-address-v3-0-2e0036fccd8d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1366;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=4XlWKfnmTuQGxdgudvxQgYEWyzNKQNtSzL8TC+5d//c=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnXEqXAe7QiuUxwnp8Xq0Cx8DNlbmLHHJs4DlFq
 z56lnUcBE2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ1xKlwAKCRDBN2bmhouD
 1/1WD/0bApfHPfJtZWmqEVIefN4S6IDWERep/K6tH5g00/vHu9lndzrNZ3ZI2+fsXJrryYXZoBs
 jk3PlhtbG/mQ0yXIOHuXkbopdQSqqkRrIqSlknhSB6Z8NqLwITQfrvqQ6Q+zE7zuy3Zm4X1hsJp
 eMsHVQ1J2ALvoX78TfHxuvgxCwIF7JrjyEHFHaiFTkjFyiYhIjXTQXeF2nCtj1dRCeKGsMb4gTR
 SOaxTGFrpa8JjuZVITWd2QADOH8NBIgqC4ogDtHieZx1+gL+QulAIsf7l4N6ws/XQz8pPmr+wcY
 R4rGsO8rc4T0eIWb/Nvlppht/pR7/Zw3TN9/59jxZwXD8iAGXmk0Ez4YJ5jp/1hSLLNsxU7V3LQ
 7AoddbXRXE+3H03FLonOSWlnajE64V/iMRE24y5H+58xrXHni5WzAiN86AOObbB/vXofF9NN5cY
 JlBWiI6Z4kOw8EEPlYQdfyFMnVUsdEoJn9J5xlsTtx8B0uCHlDvAcFNmGax2KLJr07DuVAp9IU5
 0C4Qv2/B/8fHfV8vApLwraRp4GiYAj4VDvyJzf2sVZO7M1JLNrgve8mN3lFOVoKmsPYZzFaLlBQ
 a6WvC4ehtSQliUG0h1FMUOBLlPNBq0cXfBdhkV9InUUYw32H8vX/78I7ceNrj09blzPSFwGiP1G
 rLndnRS+l1hVIow==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The address space in CDSP PAS (Peripheral Authentication Service)
remoteproc node should point to the QDSP PUB address space
(QDSP6...SS_PUB): 0x0b30_0000 with length of 0x10000.

0x0b00_0000, value used so far, is the main region of CDSP.

Correct the base address and length, which should have no functional
impact on Linux users, because PAS loader does not use this address
space at all.

Fixes: fe6fd26aeddf ("arm64: dts: qcom: sm6375: Add ADSP&CDSP")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6375.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index 613319021238a1fec44660cd9740a980edeb3f10..bb6511cb451b1c45ed2669f208fe3ed00848b481 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -1595,9 +1595,9 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
 			};
 		};
 
-		remoteproc_cdsp: remoteproc@b000000 {
+		remoteproc_cdsp: remoteproc@b300000 {
 			compatible = "qcom,sm6375-cdsp-pas";
-			reg = <0x0 0x0b000000 0x0 0x100000>;
+			reg = <0x0 0x0b300000 0x0 0x10000>;
 
 			interrupts-extended = <&intc GIC_SPI 265 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_cdsp_in 0 IRQ_TYPE_EDGE_RISING>,

-- 
2.43.0



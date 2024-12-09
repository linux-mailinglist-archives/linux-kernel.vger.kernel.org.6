Return-Path: <linux-kernel+bounces-437308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E70D39E919D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CEF21885BFA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9BC227577;
	Mon,  9 Dec 2024 11:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wn8wWw4m"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436382248AD
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 11:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742187; cv=none; b=lAzMzBep7iKRH2PrENhOmGDfxyhqiV+kquyLqCIRGtcUiZ+BpDYJWfB9HZnkhwXSpKQIJbHIWm6vjucIa7c/zSbWlLb1NYx2+CQbFI08oBTbygC3IxCgrNtixQBnABqbGrbn3m1hI0WS1e9rfslgUNna/bXRiG5JogO6Wxf3ZUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742187; c=relaxed/simple;
	bh=TbHlMdWDbh+udm1eEV5kveS9te5ak6OhnhlUSegMb6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aXMlFchGIsC9Sk3Dmt6merzsZnqR2ncMzc5A6oxfDzHVka1eIEN7VC3GE7s1jkloYLhsYTFQ8e0dqC5si/zGWkPFaD1jZiz1S+1MbqLVUBLF1zjl+d2IEVWk2prQ5W7cf/+BtqHYQh0BynQYF2JfOk5y0oz/uCKbb3WTKYoEYvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wn8wWw4m; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d3c1f68ef1so493023a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 03:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733742182; x=1734346982; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1PGh5NFsA/7r2mvIfUSdrK5+hBRX+q+43rwMtzht8l8=;
        b=Wn8wWw4m2qrFNCRR16mQy1qh44BcTny9iYLd+3z3QNhB+rxNQEZBfcGm2t3rtzxi4P
         QK1GegbBgb93p6b2SXoi8fygHvuch34d6r3LgRxVvTfdYHtAxnQqgWncsUgM5H2XaIwE
         8qIvGl3FXOQFiPS2lNYPRuM9g+K56A39A1U4ktSC2sfljq12bRSE8iM7112iND5aLj5G
         Ha5Oq9hlt80r/9ymrupe0qorejMpOW4maXJTep5Tdpuz9TrvpswlSLvx6D8dzxDGUc9D
         LLqK3qa9Dz1Yvvr78dO6z8N5xh8TPJQJvnYxZBtrJM95Oi5uoMh+x6aulGYRyqez9vL8
         KvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733742182; x=1734346982;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1PGh5NFsA/7r2mvIfUSdrK5+hBRX+q+43rwMtzht8l8=;
        b=Peeyi0fjDLL5ieTBi6rBBt1vSVpJAg0ONYT6LMhkVvAYqJyijsI3qyZ/jNiN+VTJte
         buX0sI+dOaotY8NLO029+mth8wQ6RGogAfwdlomAbMpWkjlSLjWG907oAHkXVsB7JfhZ
         LuCnfbm4lzV4Wcg2rTHHuxZrbikHILUgn8+j/J/j72vn/HQbrqAxglBwBDMEYORY1Nm+
         DWqvW4/O0p8i6JtyJ3RW1TgiARn0AJrMYkxMsz0ZkpRhn99pnMARMVyIbpygSd1Emwsa
         ZYWM5MHxqTyVWt1upeMO5sVu0+E+4kSLhq/X2ewx17ByOrrPeRB4eXHLL7DCtSeZrx9F
         dnDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaPmaTbTYT3beIWFhMdgcSu4Fa0AfH2JPd7FpezMSUQpQmG+3umotdYWEILrvXaalSvi2DAjq/KCWEg0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoQ2N7d5Xp8UqxbiDda4K8VnrS8DLKaMJfGM8suboqHd+lum5t
	tFv7pXgkC+AzwOKhez7+z3WifjRg6GSu0i00AsdA8kF4FoATsnhPOpFCWpwVCXU=
X-Gm-Gg: ASbGncvAsV64rVrCKV7wvdJ9t7IQMVmkEud1w93zI1Q4YYYWc9ZLo5W3H0IrrcAGvPr
	C+C7TjmhywCFGdQOAa+aCPBCTY9Wt24h2RgkNdOVWY74lKz3V1v2A8yRrzJehaGvpJJ8NTesaq3
	NN5A0E8r66ydTGb0bdOkHScmikDdfZVsqVLEUUTfwKVgHabqMU/tCqr7DGS6chD520QOHJds/Yy
	XtvDBexGYUPfsmNeXxiC9ef2YHKqMquE2p/UhVFhdKNYOFKGnllrj9KnNK+Rg/I0szzCA==
X-Google-Smtp-Source: AGHT+IGw0l10v67XPvkXru8OIXevsMlvVUgDms89p6OtDUU2h8ORgTmYOVeKloxOyTlF3+4Cu2aHBQ==
X-Received: by 2002:a05:6402:354c:b0:5d0:b7c5:c40b with SMTP id 4fb4d7f45d1cf-5d3be69548fmr4369394a12.1.1733742182618;
        Mon, 09 Dec 2024 03:03:02 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3dd4f641bsm3348818a12.51.2024.12.09.03.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 03:03:02 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 09 Dec 2024 12:02:24 +0100
Subject: [PATCH RFT v2 19/19] arm64: dts: qcom: sm6375: Fix MPSS memory
 base and length
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-dts-qcom-cdsp-mpss-base-address-v2-19-d85a3bd5cced@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1398;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=TbHlMdWDbh+udm1eEV5kveS9te5ak6OhnhlUSegMb6E=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnVs5Bb6MMUcJ3WfYJjdjsnRNK8167vZP1hJo9t
 tvDdqIoRHOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ1bOQQAKCRDBN2bmhouD
 13zfD/9A/D2AzS9QGRSBH4WcIoQyCbtF8SM0XMszV/F9V3RYn2a2EM7lzOnys0rTACGxQs8mflK
 Oi+egBL/s57oFcyvRI+Pb4OfGn2IhGrP66pWdvmRN1OXpM9EqBtHox4aG1z1kQDqlZHuCXIwdVG
 OauuBM+hHzn0zkUfsuzVlRIFgF6YL4A21F4SDvEC6oDnbzPV2qsnSDtzHG1TXkNlFAho6HD7IJK
 ToEJmNfnEfuoqtnJCRUGeCh9Ua60ClRU60GULCD4RqDbFEEsrKWgu5x8RRtQEWskWcQ9gdc7NAk
 E8TDpzmfDPoxyQ34w8HJ4Ik7f3VpxpxZ8ni+r6jomhpZYG2yf5nM1SY9XCbNEGNJQeardcJdVxo
 h3fjb2/O9fAVEIpZG+n2wJqqjN0wl2XyKT8tc6M08ASAXE4FqzI51F19pJdMfTFicSYscQ0Or6t
 B45kf8jn9WLsOniPBkWRo3axewIlliKLvqNnvR36b2tPZEI7L6qkwUmHvepnfiXoDrTckcq6Yb2
 SjfEDozyPshkVt22hxP+9aZxJIN29H5nA+l4nZRB0WzWz3Jka5oI9ih2SHjWlrncHEhs8JfzCPs
 jOG7YWC1ThMpDCfKUDKQv74ryswdssMDv6ZUAlVFRgcBBox1Msm5szqnBFFrpSxI6v+iHLmjUra
 9MJYiQ262f/imTg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The address space in MPSS/Modem PAS (Peripheral Authentication Service)
remoteproc node should point to the QDSP PUB address space
(QDSP6...SS_PUB): 0x0608_0000 with length of 0x10000.

0x0600_0000, value used so far, is the main region of Modem.

Correct the base address and length, which should have no functional
impact on Linux users, because PAS loader does not use this address
space at all.

Fixes: 31cc61104f68 ("arm64: dts: qcom: sm6375: Add modem nodes")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6375.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index bb6511cb451b1c45ed2669f208fe3ed00848b481..4f1d4b233697005aa48dbf80700fb28980d88cc8 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -1516,9 +1516,9 @@ gpucc: clock-controller@5990000 {
 			#power-domain-cells = <1>;
 		};
 
-		remoteproc_mss: remoteproc@6000000 {
+		remoteproc_mss: remoteproc@6080000 {
 			compatible = "qcom,sm6375-mpss-pas";
-			reg = <0 0x06000000 0 0x4040>;
+			reg = <0x0 0x06080000 0x0 0x10000>;
 
 			interrupts-extended = <&intc GIC_SPI 307 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_modem_in 0 IRQ_TYPE_EDGE_RISING>,

-- 
2.43.0



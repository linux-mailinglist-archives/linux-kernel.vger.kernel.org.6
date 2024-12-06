Return-Path: <linux-kernel+bounces-435205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DCF9E745F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A137516C000
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FBD211483;
	Fri,  6 Dec 2024 15:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RYdYiiQa"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42722211482
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733499198; cv=none; b=FYc7PaOxAyCcXsHAtI3e8LHHXn7TSj7OhO5RbFZMHR9pn2pBPOeTRtvVrjjz+ddt5TWoZ1vl/M9flSrvFMrdIoaWfRzCbHu2hgJK5mlT3q4GHkwrD8/lnTAmpZ36v7kW4xoAtjCvNi7ADvpc2UV/99i31XGqrzxDXa5+r+A5fSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733499198; c=relaxed/simple;
	bh=NfgQA/XgYVV5OKpmwdBaDSEA9tYYVgnK+RFM1b7SHis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Arj4ugzOTzObsLYEkgSgRsZdZe8f44AplLxfjkZa/suPYmLGk63Pbw3aYb3rxyiVhHqNgrdL00ZfZa0W2Lqub+KLVuHGFBqm8rSpluNbZ+ZLO4MLAlAFjTclD9FCT+jSPIDSwnVYRAMmPkb+MLkrZAe3lsCcDfd9k0JnpVBG7WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RYdYiiQa; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4349ec4708bso1627325e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 07:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733499194; x=1734103994; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XUPiOrNH1n//ypUMYkuFABYWmDpGewo2IYrQwWO/Hmo=;
        b=RYdYiiQa6nZKhGRgJwDEQdH7edErO8ixday4XABiQHNUQSB55ml0TTKhzYaIJJ2pRd
         I+JTvp72RWWJJgT17U7z59CYrQAe8PotS/f9GIkuqcPdK1zwwoEmDUVHYo14OlATnaYF
         u0xUJujMDNH0RjYtJ/K2vir1wxYqMZ2/YlYr4CpWH8Wjfd+efIaVAK2a7eTY4v3A/1qE
         O0YSdf6ndEvKYRsp+4smIhBvM0DHz+lVF+bFZBOt8zbkKrbuQXbCGwS5dSW7z+5pdtbc
         kiPWKDldZwonbmnnSJJlv9EMc3x0okWHikQBBuipedRMrwuNogPFo04JA6iWMqTxPLGa
         KySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733499194; x=1734103994;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XUPiOrNH1n//ypUMYkuFABYWmDpGewo2IYrQwWO/Hmo=;
        b=AK1dp4zW4wl62tAVh52diYmg5o0Sy6nk59YDgng+kOFuPAZqShQtfSGfx6YXcpucjL
         QCQOJkzgqs0QygrijBs/OQwP01BoIZOnbBe1g9aRhdcztTgIURxIu7QiwE4nTTYGNX1d
         iv18Lj14SZ9WZy34e7p6BcdL5gPoAiQTCrcSt2m5srRIAuIlCLE5ICUZZDY/cwGZKwSs
         ttCcrFSPrLSjz8zXGKQH9mYp4ul5E1zOBCImzzD7rMIMYrPOVohgh/PWejn/7Wkv96/i
         /bliLBjAQsM12S8WFlbljccTvNg6zTKyJ1hSJCT8OMYCqXgcLclapJWg6ZDxPGxBUhc9
         yEzA==
X-Forwarded-Encrypted: i=1; AJvYcCVd5EzEWNNLaC4zq3fdT7yCIniNFizH1rydZ5IVxQ2Gfi1uf1eOwgw0LTfcJSToKPtDnb/5857nBX/pm+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+TvyPNK1+9MLG75k9T3BI9Tc6uUHYwqHrpWv9c7m7SMufd3aS
	4kq/ArRoUk7VHzFqSF7PDOOz6y4Oce1RFSnxzH43urmrJRByqbAhphLvlJGP2chVedysWCbWIUu
	JXic=
X-Gm-Gg: ASbGncv4jdbPOmFIPj7hGvCI0y03Ld+G0qzNyYPjoHu8dJZ8B3Ahxff8iKH7aDu7Ids
	TptWBkUUIwC5cJfx+DE8EmTUtBjWiAVhP04DXliumwB/81JBXAGSyDIba1ZWlSdPFw7fOPq7bhq
	6tcdL9/lP9v9KzksCXq4n/DD3ToLQ0HL6IkorjVggrQ+vqp7RhLgo3AxIX0NB+onb7bv7+u6laO
	cQU1AUjU8G+tSHWxQzW0BHxYJeIxLcfxhIP8wiZpyrdYbUMG+M2NyH+Kr5d5Jm0gw==
X-Google-Smtp-Source: AGHT+IHsfF2SF/D7VBvpaAS3fQYFRZPPB8EB9awEa5wMqz3c7QRczyX7ZckR4/hvQo29OpO1kvFX/g==
X-Received: by 2002:a5d:6c69:0:b0:385:df17:214f with SMTP id ffacd0b85a97d-3862b3ce0abmr1001003f8f.9.1733499194594;
        Fri, 06 Dec 2024 07:33:14 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da113580sm61158035e9.29.2024.12.06.07.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 07:33:14 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 06 Dec 2024 16:32:38 +0100
Subject: [PATCH 14/19] arm64: dts: qcom: x1e80100: Fix CDSP memory length
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-dts-qcom-cdsp-mpss-base-address-v1-14-2f349e4d5a63@linaro.org>
References: <20241206-dts-qcom-cdsp-mpss-base-address-v1-0-2f349e4d5a63@linaro.org>
In-Reply-To: <20241206-dts-qcom-cdsp-mpss-base-address-v1-0-2f349e4d5a63@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1319;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=NfgQA/XgYVV5OKpmwdBaDSEA9tYYVgnK+RFM1b7SHis=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnUxkZ6ub70bFE0D21V+kLjHa6z+PNFujD54aOI
 gZ5MXjJAPKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ1MZGQAKCRDBN2bmhouD
 16HlEACXWFc1OEdkJJOzRlWZuH/A00VGfEqUqcTZagGskJEwUyLknQojgbv1p6+1TN7abp0toqZ
 Vxks48Iy7AA6Cfs7w6PTVh184v15KsaIJ8WabofmUFNZ5VBNyG5hFRUckqS6XhK+0+2Wa+DZj5E
 o8aZXug0R+8PY4j4EwILf4ccxRuF814mxBY962pvbD/y57T7pLDVYdMyzslMWD1CuoQjCFIRRMv
 C/yCnGL8Ih7tqHduD9TIZA7DxTA7/MVBZ/JZw3hjgclSMwalTK46nJWDikr1fyMKLv1fB0uauWH
 PKy2rpXxXEvrhwqYtELTVX5CpNihhxP2zo2MGtDpMwTJOUoyDAt0kttsx7GYLjzrnV0SI5RJTsU
 +UHzrDD7A3jNo0mw5VH2W309uQop+SYhR8fifDQMAII/fSeYeooTrT0fu/YXjOpB7pewgO7EUCo
 t3c32BAey7uv4UQZHLTShpMMqmR85GK6bkmMB6qYIqxlm2qDJcosqj+F4o5UC4Flx14QanKYj+I
 vBj42NdZaiHvzH3At+EHd1d7/2OEcleKUGw0lzRTYPqOVWw7UAfFRK0Pc4oGGkfrlzJtF8YzOH2
 ozBqn8QJ+RbFg470ePJZ3/kGJ2HB1vYqrkQwz/SnVh+NXZxEUiH0+7Exe/JV7issLyW/+H6AOlp
 s1zcmxjdmkZNbzQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The address space in CDSP PAS (Peripheral Authentication Service)
remoteproc node should point to the QDSP PUB address space
(QDSP6...SS_PUB) which has a length of 0x10000.  Value of 0x1400000 was
copied from older DTS, but it does not look accurate at all.

This should have no functional impact on Linux users, because PAS loader
does not use this address space at all.

Fixes: 5f2a9cd4b104 ("arm64: dts: qcom: x1e80100: Add ADSP/CDSP remoteproc nodes")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 9df6903b5d59aadda26d9e0d4d9f951c5c3add7b..bc2187700ead2f368172040b23e1343cf0895012 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -6458,7 +6458,7 @@ system-cache-controller@25000000 {
 
 		remoteproc_cdsp: remoteproc@32300000 {
 			compatible = "qcom,x1e80100-cdsp-pas";
-			reg = <0 0x32300000 0 0x1400000>;
+			reg = <0x0 0x32300000 0x0 0x10000>;
 
 			interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_cdsp_in 0 IRQ_TYPE_EDGE_RISING>,

-- 
2.43.0



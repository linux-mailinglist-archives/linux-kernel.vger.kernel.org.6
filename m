Return-Path: <linux-kernel+bounces-435208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DC39E7472
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85CC716D5AB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48F820D4F6;
	Fri,  6 Dec 2024 15:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TCMiLwzD"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E772F212B12
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 15:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733499202; cv=none; b=ujnWfeieu6oR3iypJnrY6tvIm4oBw1Z1vxq2Pr16NL3fnIJVJZsVgz8Eskxd+ODpdn3ft/SxzuYPvec/dLbPxdPmwKdamYLXaQ8V9NFL0iFg8y7HwErupknplUPK+gezXORr8xfJrftzcrn2/arLa24YA3UYHsAKNBHZhscxdOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733499202; c=relaxed/simple;
	bh=kkscAfqjZ1iO8Mt1cf8ePp07BRkZZiJewMrsa6+GGrY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N2zPdvrmMWQ6m1gLGXh8g5XIq/FasYA/c0RvvEOo1zlw2XPHm9EOhC6UdR97t154bOthJPUQLcH6OzUVYKMOSSb2HG72YraFbvXeSm+CUVLYnVnYFFvWQCOT0N0qi2mmQQlQW9p+8d9f/Y9ldLqS6nTvqLwRWubzQNWrAmZixOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TCMiLwzD; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4349d25eb5bso2358255e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 07:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733499199; x=1734103999; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6BnGnc4auB4BfoL4yYa22p83zP4f8oOwWvOviDPs2/c=;
        b=TCMiLwzD600xfxOVK4VndYXFW7z6Ca+WYG30OBnfkdDxwuqJ/6/bqFSo93ogBq7goh
         L8ZhP/FcD6DmWobXRv4G1LuRm1Qjb1AIrbbv8Ad8tNe8IVG+suBGUJRWPGGSxZqWjIvE
         VJfKqylCbcOyWNLNjb4yF9YdAgTUCNSAjOT7/iPmiU879Mzkx/HPXZaPph64KAZrKTvW
         Za27AClzSUrFNBcnC0MnvZBOD5gg5H0yu2Q7MIke8+B7wThqy+IJaHBITUG3U7UmenlL
         iye98HgHzBB8tHDZRcugCFeHxc0eer+e521rAlxvFpDeEsZe9C2cWl2n8aWqMScPj9zj
         bz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733499199; x=1734103999;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6BnGnc4auB4BfoL4yYa22p83zP4f8oOwWvOviDPs2/c=;
        b=BRp+bBCj3Z/g2V63CGdPXfq5jtAgLDZVKkJTD7/BuqP8PwVTudsViE+f3bn2kncnWS
         8rCRrXLJ/ChGRQ01Q8XT+OOjfdgy514yx0ttfsa/QtwdJp+z8S/xLfe6EBJPap9tgGFl
         DfslYybIlgWjcxJaCqXA82jUX35PdO91R7lpGbbxDV1iuop8PMff7gEV7GhQS+YxXxlZ
         TcfkNMCnHOtW3IFR5uHjknxwS5V3NJZBaMZjcWkfsMIxogVkqWuyvZmxzq1bTm81SfRQ
         1/cXmK6HHNo4NlFT3nrmDLhsRNVw4r3lJP42CvsUjnWrI+AsPjHuDjH0FvLcEqOKRXuG
         yg3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9O9emJaZrPFyffAhfdWtbcmPxtPCcbWMVE57T+qaeif8kq9srgBeqQacHPV0UHxsXtLS/W12cqeMtOxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyClDaWclb/XUh1rXz2PUiTlAtrykAxXZ/jiRTlzpJm7iMTb3g+
	UFQbCigDVPCU058Yp79Yllf5yin/zrNtAfH+hjkBZjr7k4YM8cecgXNIXjVdvjE=
X-Gm-Gg: ASbGncuaWmlteHuFz3jqbl0JnQkmnSMoqnI06Tt7zwQkYa06APRQ9KhYcJ1+KOLhUg0
	nMs6FjAV8dF7JawaRR+3VLqOk7g5MfIn9/cr+Cp5rt4ImoqZX0K536rhdPcp5s1EsxhkQjUMjSJ
	1jAG/DlUoa5EPx8AXhgjL644YNZPfrwY+pAUrws90/yu6GGaPcOWQyiFSAu65h01vJOK1ZePGnW
	zp2VNzbDeQI3C+B3gxzHl1mUC387qp0kOFg+DHzVoiuTwGeiYnxfGhG1U+kgJqBNQ==
X-Google-Smtp-Source: AGHT+IHW8yw/YhGJATjIua1R/QkBwPk8egcLxQaKinzVwo2PrRzL0SkuE5xX0HZKWE6tHukKXxmEeA==
X-Received: by 2002:a05:600c:1c0e:b0:42c:aeee:80a with SMTP id 5b1f17b1804b1-434dded5411mr13050055e9.7.1733499199422;
        Fri, 06 Dec 2024 07:33:19 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da113580sm61158035e9.29.2024.12.06.07.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 07:33:18 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 06 Dec 2024 16:32:41 +0100
Subject: [PATCH PATCH RFT 17/19] arm64: dts: qcom: sm6375: Fix ADSP memory
 length
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-dts-qcom-cdsp-mpss-base-address-v1-17-2f349e4d5a63@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1182;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=kkscAfqjZ1iO8Mt1cf8ePp07BRkZZiJewMrsa6+GGrY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnUxkcAnTUFvNyeHCDmpqbmXC4GmVZlHIn6Zepo
 SXGawu0J/OJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ1MZHAAKCRDBN2bmhouD
 1/b4EACBi1MmGseo0B6tLqP2lzi5bapvLWgNhfDTuTKAk9aWUGPgCBucLyjN59pzPmgLH5l1HAI
 t3LOMjq43olOyvNIf8ZrlUgz3xnEo9snbRcEs9UTl53Ys9hHtTMRXExZUA9bd8Zgre2kJLceRxs
 dGbL05kjJsyxoRa5mIz87ux+9hKsJpY/Ebu2CGaYDTdTjnSed7dP/1RoT40oNGOj9848/p85N6d
 4Mjg93onmj139Bo0LfG5Rd0XI+hqbkIcuR2zirxPNHNzfZ77mhfnZG8wxh4hR+L3ymlIij4H1EN
 B7TJsndyvJyqKQtq+xHrxDvu5lFK2BQA3KArZHd62CYkuULtX8pH1yeGtqfXEJImxXZNoGwQQPF
 9cF/5G4d2IPIvzqIc3Khc5OhE6ZW+EVBf9fMAxt5rRvVERat5v/dZY4GSXGSIrhNepquuL/gUOb
 61XYKM3knUXH2PD8okT0qyt/rJyMps6moX5Z60E2SlLnBrB/uxHhct4J1YEIcP90/uP4CvQRBfI
 tf6ceaVU1syPv0j6SyBES7GiB2rfHkAH62kcZhPfvIh+kwEnGKpMv+xRKVT/Ick5+x5mCL07EaI
 sMZ2i9Z0oQq4eWCc081pOYlK3O3zCK7MaihBn4+oJGq71q4jcP/8fLStW5HujaRVl44WqUtSmVA
 MupLjYKoLHOBg/w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The address space in ADSP (Peripheral Authentication Service) remoteproc
node should point to the QDSP PUB address space (QDSP6...SS_PUB) which
has a length of 0x10000.

This should have no functional impact on Linux users, because PAS loader
does not use this address space at all.

Fixes: fe6fd26aeddf ("arm64: dts: qcom: sm6375: Add ADSP&CDSP")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6375.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index e0b1c54e98c0e8d244b5f658eaee2af5001c3855..613319021238a1fec44660cd9740a980edeb3f10 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -1559,7 +1559,7 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
 
 		remoteproc_adsp: remoteproc@a400000 {
 			compatible = "qcom,sm6375-adsp-pas";
-			reg = <0 0x0a400000 0 0x100>;
+			reg = <0 0x0a400000 0 0x10000>;
 
 			interrupts-extended = <&intc GIC_SPI 282 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,

-- 
2.43.0



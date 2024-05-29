Return-Path: <linux-kernel+bounces-194307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F099D8D39DD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FEEE1F259B2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495E018732A;
	Wed, 29 May 2024 14:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UhiOb32e"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516D817F36A
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 14:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716994035; cv=none; b=MzWAuPWGC1OY95xEmwG/Wgrw+6lLbyHJsWG6lv0//yN7aYWybY8A7TaJelkTVmIZyCSFh0xzbOMRwvc5fSy0xb7uGodmEFse/+vM86i4jcV08/VIyP4Wi8PntQwmDWkoBCWD06xKTJWtl0hxvZ9GFEflZx/N+BJwNED1INr94+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716994035; c=relaxed/simple;
	bh=PEHi7ElPElAQh4wpEEgIk9SSCUfmS0J4zLyn6bxTemU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zhd4WuzGbzDowmx+F8LJ/CQ2Pqrf1D3lhcLGob5afJutLK4pqFwnWBIzFQLAIvADZi2Fy6hMQmRVEqLMJhiWbTCBVRfMQoYmX+fAevoUZH935LB8eR6v3gGBQzpzPxZjmB8kFUCkIWixAncoHGXoLgovi11fvD67jVOfkMyNFqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UhiOb32e; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e73359b8fbso25806571fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 07:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716994031; x=1717598831; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D+5IDaDxmLJYEEF04xGosabjUmZ/r1+usaWRvgSJUE4=;
        b=UhiOb32empUPGPs5qFmm4Xk0Y3vYBxE9xf8jR5o9q0HPWWWB+vaWgutxyrweLAvPsl
         rnpCUmvxSQzukpFzUzfJHI7iqbMq/vZ6aV7eUmLHMhKXhbr2Ez9TW8yaCzgwbo90j+D3
         oPbj1LBeZ6msSxqiRhlsnj7t90OXXlcrHjqcCTYidW5IeXYwhoxSe1DxuezXWNogkosA
         rn/ZHYNwkxZDx7AHA6Ma2SQ0n6ukFsMKxgcBo3+fel77VvyEwU94vd3EnmvYmstEv4ON
         YbICl9EHbKhLgxg5oMcvHFgOqIBtNWPlRh3rbuxRzv+3JqJNse+2jTimegnBae+1Gtpe
         CYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716994031; x=1717598831;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+5IDaDxmLJYEEF04xGosabjUmZ/r1+usaWRvgSJUE4=;
        b=Y0yorhq6AQExj+vK5fsRr8m465vMghemAr892M+okYGa7p7J2YdxJ6R4c3lMJIAeUx
         uJ+3kG3rsOhdezIwFdHf1J+YJjHwCXAk9PyISoHDEil6MEQFViYYrIVgtOZ4W3Uov0PW
         8h0YGIO0y4BS1QnzhhGuvHaaO5mKGnG2yuFNFDdAsvKA/QU6X1vW5i8Uz4YJbZIzZqaD
         nk06w+xTMEEXKNhOdTBzk5tDD426sZ3m8JiCwBuwStxOZVRKghb5fh+UarVDGMIoAXcM
         JAk25H6McB8+sY9Oep7kS4s1izNMyzQsnA4guSzIQDccMFXtxITz/teElXlT9Myf2jm9
         5xtA==
X-Forwarded-Encrypted: i=1; AJvYcCUS7Itp20uMHk4PeY1Q9gFIPMj+FzxAovK4324r/kVPUeQ8D2H5UDFHBY6yZvnhIMiUDVXekvLxNf0ZqI2X7W+B4lXWaVUCbrgENpc2
X-Gm-Message-State: AOJu0Yz6ITQpFB5YEc+i6S19Vs9htSFen7RaAyhDE4DKG3jWt81hWsOK
	PQAf2AlilPoPIFRUONoW3YVEwhc/M8R9ehoHH9LA45Uru5sU/IW7krDZj4WWnC0=
X-Google-Smtp-Source: AGHT+IHyzBt0vFlT47Nkr+5aQqplRRmlZB3g4ktnii85wIIRfXok3tTI7LEUqqWqK0YpKCFbcj3cJw==
X-Received: by 2002:a05:651c:104f:b0:2e7:16c9:2e0c with SMTP id 38308e7fff4ca-2e95b097724mr135903141fa.15.1716994031651;
        Wed, 29 May 2024 07:47:11 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e98c45df0csm3791951fa.68.2024.05.29.07.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 07:47:11 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 29 May 2024 17:47:09 +0300
Subject: [PATCH v2 11/14] arm64: dts: qcom: ipq5332: drop
 #power-domain-cells property of GCC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-qcom-gdscs-v2-11-69c63d0ae1e7@linaro.org>
References: <20240529-qcom-gdscs-v2-0-69c63d0ae1e7@linaro.org>
In-Reply-To: <20240529-qcom-gdscs-v2-0-69c63d0ae1e7@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=766;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=PEHi7ElPElAQh4wpEEgIk9SSCUfmS0J4zLyn6bxTemU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmVz/mRDt0AMJZqMVl/b8bAz7RVeHcmiPgq6uEl
 lPnCg6XBAOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZlc/5gAKCRCLPIo+Aiko
 1T5YCACco0POIcKCzu0sS/jEmLLULHh2w/LZ5e8eMvMidHYOre9vmjPu9VdpdFRUXuJDFV9oZLa
 NK17p9gny79n2SOkiEd+YBmQ6uyZBL8+4lx2SaS/GoRh0uy8o3TSchqHwNcFAmWD+VARfGZ+eEn
 kOr/Wtq4Onnu67cK1gFpATKSe+lmIi9T6u9LK2aCh+vSP9F9tOinJu6K13bmoDRMCgPemwsyzCE
 b7+GgpkavEJmXnlqWXabApuuSr06RfD8qGCvn2k25/39Wb7EW8jJ8b6xe5V5YpOmERsurbopWE7
 oRwZmplnGMcjAqBweLwTz/tbJ1HHKXDbT+2Ssgvz7UKOxHQx
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

On IPQ5332 the Global Clock Controller (GCC) doesn't provide power
domains. Drop the #power-domain-cells property from the controller
device node.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index 770d9c2fb456..573656587c0d 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -208,7 +208,6 @@ gcc: clock-controller@1800000 {
 			reg = <0x01800000 0x80000>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
-			#power-domain-cells = <1>;
 			clocks = <&xo_board>,
 				 <&sleep_clk>,
 				 <0>,

-- 
2.39.2



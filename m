Return-Path: <linux-kernel+bounces-426045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 671759DEE30
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 02:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99478163771
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C01219E7E0;
	Sat, 30 Nov 2024 01:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OeQilQOW"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABB919D064
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 01:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732931108; cv=none; b=gNZ8TlHh3yxVqwGccLSfjKkwoVikoKH6scf6q9vM8B3v1r3LOKCowHrqakExe9hbdra2aCh2Ib6BZIuEVWEpJFDe4AxOoME53y/IYTY60QPWDMfLMMXiWfhEgS+1fxdaiEisTvmTxTbWDKz8+Uei5kQpBC1tD2LDSTSEjKFn85w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732931108; c=relaxed/simple;
	bh=kRo+lLE1W0MzRHuVjiZ53lpqFjRc/n5gL1+u9Wg23vI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kq7/j7fDuMxJ+ABy+j74YcNbEAbgMhd/qsz4kAEQScq2vfmnvJOhne/0tyQZGG7HaFDpNTNyKL8xCOlS9LcTYp0328ouFqOKlpDNIhbNFLDIcqmjvXt+4Ka+Kpxg2QvVyK6rFa3IwQGSTwGzkeeumV3BVqbAryf3exYB+5BaZ1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OeQilQOW; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53de771c5ebso2829069e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732931105; x=1733535905; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vWJlRrn7HaBkpMiZ8jEbjKA4hpcZtQM8jkZV0zeKFag=;
        b=OeQilQOWm8jE5BzOKNtAUzi+Em7fcCuTKcBFP88sjXc64qRAKFThW+qM//lSqNr/ou
         9z/f95b9UlbndyNQg8LBUM8VAARNaYYpV46s+MVEyDItGX1eaRNwTGcoyF6pnJgG03ZY
         omGk1lpXK34WBVNC4UBYuGcZPdog6+YaLy0zcgwk5Rx5XEdplGn29PrCTDyJST8+vmM3
         KSyY/6zuMVylF0y8kABWusi6eIAs9ob0XwvlPiz0ImacIavs0xibVGNZVuR4edeoMeE8
         WQb1YxT5BApOvNMCYIG6WGtWz1pb7D88TsnC02RZFqbBDUS7faAnMMy7r54wiw35gyoi
         3SVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732931105; x=1733535905;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vWJlRrn7HaBkpMiZ8jEbjKA4hpcZtQM8jkZV0zeKFag=;
        b=jTvEYRw1IAmeFL1p9ECNQorUScmZjbwB4k0irMQcq580JmEXcmBoKyz1HQp1WhLgY2
         4cTnuvnubY4ZoWe25wl2WbY3fZSS0FVVrtBMavUAyk8tIsmnz3ujJyXzeuJ0u8NaaIg6
         fHQHs7IerJmW13fdfuW0cszxgvZ/B1ZzvWqxsHoxoyB2rPnX9jmmB/TuuiRIFwsVSO5C
         wphYdVLh9ctEhFSLQPTu9xLjcztBunUOgSf1B5SmCF1dZZZt6s2XEn2BK0AaZRPDlYRR
         RcIXibPiQI7efntjr7jf4Rv6A9vRPjDDiRVGJWtaCdpjx2NSnbi0mJvILD3fK984fCXw
         9nxg==
X-Forwarded-Encrypted: i=1; AJvYcCXtyyUikDzcgz4sAcCMgdrE2F711tv1Re2wt+Bgy6jRdteeYUehvVEJGaz8qTu3AVlp3BxU+7P3UQJxP/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Ba62YmTc0N+VwmHFpA7jzdD+K/wScxC0gWFJcFwZdqquBbE2
	2rYM2HDH4mMshOSP2otR2BMeoE7LWjqUSMUEnqsbUxYbflkWVboWBASKVEbwHqg=
X-Gm-Gg: ASbGncvCIvOHk6p/7+b4SEuGzZe2ZCSXe0OmMLeugtvrQnBd52MQPxax61GLVevJRdz
	A6zJCFIx+klEelRg0U6fYX14a4YE9n08UMq+i9/f2VElVDWU73QsHARs+zhZ8w7LFWgiooum7mc
	ZcnZWPBhweZD5CKmRoCzHyn/Tr7SMFi1vRHUWQFQmRn/naEbE28dcR/n/FwBgd08tiFGLk1l13e
	jcPk0blp+RSjxoiAzCjq8fSg69D81OWDYk+q64UmwRuYx0J5n0EyKWVhg==
X-Google-Smtp-Source: AGHT+IHtpAzMikEAK7LIlcO0JKtu8SItRJVZ6GzYK/XMB1Hrlh9NqSRl9WgPX6B73s7i21+jukDupw==
X-Received: by 2002:a05:6512:1249:b0:53d:e5cc:d06d with SMTP id 2adb3069b0e04-53df00d97c0mr8785917e87.27.1732931104656;
        Fri, 29 Nov 2024 17:45:04 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64a0742sm631946e87.261.2024.11.29.17.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 17:45:03 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 30 Nov 2024 03:44:27 +0200
Subject: [PATCH v2 15/31] arm64: dts: qcom: sm8450: correct sleep clock
 frequency
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241130-fix-board-clocks-v2-15-b9a35858657e@linaro.org>
References: <20241130-fix-board-clocks-v2-0-b9a35858657e@linaro.org>
In-Reply-To: <20241130-fix-board-clocks-v2-0-b9a35858657e@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Leo Yan <leo.yan@linux.dev>, Joseph Gates <jgates@squareup.com>, 
 Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, 
 Stephan Gerhold <stephan@gerhold.net>, Zac Crosby <zac@squareup.com>, 
 =?utf-8?q?Bastian_K=C3=B6cher?= <git@kchr.de>, 
 Andy Gross <andy.gross@linaro.org>, Jeremy McNicoll <jeremymc@redhat.com>, 
 Rohit Agarwal <quic_rohiagar@quicinc.com>, 
 Melody Olvera <quic_molvera@quicinc.com>, 
 Bhupesh Sharma <bhupesh.sharma@linaro.org>, 
 cros-qcom-dts-watchers@chromium.org, Stephen Boyd <swboyd@chromium.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Martin Botka <martin.botka@somainline.org>, 
 Jonathan Marek <jonathan@marek.ca>, Vinod Koul <vkoul@kernel.org>, 
 Tengfei Fan <quic_tengfan@quicinc.com>, 
 Fenglin Wu <quic_fenglinw@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Abel Vesa <abel.vesa@linaro.org>, 
 Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Sibi Sankar <quic_sibis@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Jun Nie <jun.nie@linaro.org>, 
 James Willcox <jwillcox@squareup.com>, Max Chen <mchen@squareup.com>, 
 Vincent Knecht <vincent.knecht@mailoo.org>, Benjamin Li <benl@squareup.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=891;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=kRo+lLE1W0MzRHuVjiZ53lpqFjRc/n5gL1+u9Wg23vI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnSm31ZCubTdxrQSYCqGPtgwvvXuH0vanV5BbkQ
 E+EKRfB7JmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0pt9QAKCRCLPIo+Aiko
 1eSBB/wKjVAzUj5M6b+XByRsvi0UZPlpv5qTLjszhyTKQzXl2fkADYu43wP5syy0QdmbuQ9oV9f
 Pk24fHsozeixUuPa+Z6EvgRX83KZiU/7t9t8czMg+tvMIzv5BtW0aXD3GwGZ55ure1p/UpNygKx
 U7DZrgFebI1njHwsrPfHpsH73HqKw6WQsPS5iJ2j4C9pd7VkanjsEcGzZFgxzrYEm78cwINl6Zz
 /tJc/vKNrB9bIVGKVX+vJbotSAj1ky9FNTJAXzQc6EzhqfT1JyqDB1JKqMofM+EARBprGS8BfOp
 G5mv4xPQba21kxtcVJsJM0ML9/me3tQ/1n1hOmMS6RQeDGoV
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The SM8450 platform uses PMK8350 to provide sleep clock. According to the
documentation, that clock has 32.7645 kHz frequency. Correct the sleep
clock definition.

Fixes: 5188049c9b36 ("arm64: dts: qcom: Add base SM8450 DTSI")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 53147aa6f7e4acb102dd5dee51f0aec164b971c7..7a0b901799bc327b9d31bd84e8a00fd62b451596 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -43,7 +43,7 @@ xo_board: xo-board {
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
-			clock-frequency = <32000>;
+			clock-frequency = <32764>;
 		};
 	};
 

-- 
2.39.5



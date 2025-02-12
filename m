Return-Path: <linux-kernel+bounces-511580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB33A32CF0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B143E16AE8B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCAF263891;
	Wed, 12 Feb 2025 17:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zCOJZoAk"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1335D2627FB
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379871; cv=none; b=pUBnvp9Lyg32opNfzD+TNdPRtIL540CpIhXrf1ejeVrlS1CUofKPYdTHbIZkILIMzjObDuhPehpVzEOnhAKUT74IXuF+pRGSig/Lw4CserZo2LO6aMObH5qGpphsANoambnc0Cex6h5s2PevXfIQdrOjf2TS1EF7ZtbTXf+E5og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379871; c=relaxed/simple;
	bh=9GblvGNDG9q8+pnXs2ne763R+S7EoCxIKfwKsAhOSec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q+MUGnF+OmuVp7y4qBUc3akmxHcNBkvnO6jZVbUICw3UzK8vAH+bVe0bja7IfSxpNNcyOEznr7RoXP/du4RkD7OvWVmbPtuxtTkp0kdFSvEYDu1oy9bqXDDjzUi7ICSE/AaRD7ou44C6G76L6oPWK4cABP+HrHRoUQjm3ihWnyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zCOJZoAk; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab7430e27b2so1342305166b.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 09:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739379867; x=1739984667; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2u45ykvEMjVQISq5rnr9y3KabZa4tYoR1OiGAmXhk4I=;
        b=zCOJZoAkmZwNn/VaSbD0Kh5rRawMeIm8UJGZhx37Iy5x0RZ6Tv2IU5YaamE4o8YP3n
         W5kLzFlG6B1h+OxvZMDKg0q/Yp780eKg5d9Aa/7mDMvhfrvuUVQbjm2aAcgin4+36e9V
         r5ZNRwqtdIE33iVQISV+HxMKbXRJYbsAGl/7rk35zN1b2h3xp/Nl0FdCNr/dC2nPTAa9
         CVCRsffpIGEW+z09RTkvuL9hu1BI2Q5+JTdwvz+HL/IylVqpptc8RfODS54hmIEU0RAt
         F06xoSmKwiZUN2mJMM6Cs3ct9WKCkj3hJyBP0jK7O/DzY5t3scb9ZbOvdkXn1IOBhinm
         xJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739379867; x=1739984667;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2u45ykvEMjVQISq5rnr9y3KabZa4tYoR1OiGAmXhk4I=;
        b=vVYOBfTB5K0X7HXWzbOM6GNOcXC6uHfNw0E8fEZCNt0JaBA+/pO0P/Ge3nxzdOt30X
         dNpp6Ra6c+8fLkFDs5aJR5paWIAbXLeci0QxD4joWcgA1qsjyV9ejx1SGwNRrOWOr1eQ
         WU1eH3gaWSwoqyiiwoQwwqw7e+/k+iwuNiMo0FpDb6vjK9kZjtLqTMe2ZyMD+QkgeNiC
         iW5YGqEAgvmoj2iIwSOVBHXLdncA1K3pb0ruw9hUFtTRis12NQGa75PuKi6z5edyDJM1
         JUJ7hy39L7DmaujHjY5ney8ZHsDCODsbNXErjRs6OtGSuxseVqXVJuGNkoW80PGsCH9Q
         WwqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNElPMliX2UMaB4Fw9VEPice8eHCYtXMh9ch+voR2uKMd+AKIZ7/s3zHhCjjPAVjOldMAv1ZkiHpNHjm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZO+lHCw6O29I3KKnvSeo+kyqnkM3X0p8aIGXrobiaiar5KM+y
	z3l2OKK4f9PNOVXKsjp9SxbKTkww6fA5b8lJ7G35itP8t35XKIuW+c92nbEdk4A=
X-Gm-Gg: ASbGncunqbNB0MdykpkuvboNCsCeOsVGt/TEODSwOyrYkS1jHIDROiwdzqxfE1Wr9c/
	UfbJLLeJV0smSlezY8qxS8KLHQhgrzKF0arpfdWzbURLQcGWa/gJqibG3BI8tUh7xeE9uhXy9Nf
	s+x9+B/EsXcPcflUiguek3YBl1RUBkD2Yqgw2uG2LM76nNUIv7mEpOR52OCxGe713pZ0ewWp4PO
	pEUqs+7PJK3HjGm19bT4HuvvV2Pt2bGfE3BSHY5XWWd6oTSqb3H0G3dDxnHg2qZji4ZJxTzcPF2
	6JuzVPLis0oqX9VWvjv75GljQ7Bi
X-Google-Smtp-Source: AGHT+IFU/2F6t8+fSl2upjgpc8WvZ1eQ0SNs2R3uJxgo7UkoEsUqfjjBa1zq+PYhAKq2aV9hNjVY/Q==
X-Received: by 2002:a17:907:1c8c:b0:ab7:ee47:9928 with SMTP id a640c23a62f3a-ab7f334aa8amr340585366b.12.1739379866508;
        Wed, 12 Feb 2025 09:04:26 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:52e8:f77:3aca:520e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5deb9f6e46bsm819230a12.71.2025.02.12.09.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:04:26 -0800 (PST)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Wed, 12 Feb 2025 18:03:54 +0100
Subject: [PATCH 8/8] dmaengine: qcom: bam_dma: Fix DT error handling for
 num-channels/ees
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-bam-dma-fixes-v1-8-f560889e65d8@linaro.org>
References: <20250212-bam-dma-fixes-v1-0-f560889e65d8@linaro.org>
In-Reply-To: <20250212-bam-dma-fixes-v1-0-f560889e65d8@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Yuvaraj Ranganathan <quic_yrangana@quicinc.com>, 
 Anusha Rao <quic_anusha@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, linux-arm-msm@vger.kernel.org, 
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2

When we don't have a clock specified in the device tree, we have no way to
ensure the BAM is on. This is often the case for remotely-controlled or
remotely-powered BAM instances. In this case, we need to read num-channels
from the DT to have all the necessary information to complete probing.

However, at the moment invalid device trees without clock and without
num-channels still continue probing, because the error handling is missing
return statements. The driver will then later try to read the number of
channels from the registers. This is unsafe, because it relies on boot
firmware and lucky timing to succeed. Unfortunately, the lack of proper
error handling here has been abused for several Qualcomm SoCs upstream,
causing early boot crashes in several situations [1, 2].

Avoid these early crashes by erroring out when any of the required DT
properties are missing. Note that this will break some of the existing DTs
upstream (mainly BAM instances related to the crypto engine). However,
clearly these DTs have never been tested properly, since the error in the
kernel log was just ignored. It's safer to disable the crypto engine for
these broken DTBs.

[1]: https://lore.kernel.org/r/CY01EKQVWE36.B9X5TDXAREPF@fairphone.com/
[2]: https://lore.kernel.org/r/20230626145959.646747-1-krzysztof.kozlowski@linaro.org/

Cc: stable@vger.kernel.org
Fixes: 48d163b1aa6e ("dmaengine: qcom: bam_dma: get num-channels and num-ees from dt")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/dma/qcom/bam_dma.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index c14557efd577046adc74fa83fd45eb239977b5fa..a2f1f8902c7f88398a5412e8673e24b3c10bb86f 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -1291,13 +1291,17 @@ static int bam_dma_probe(struct platform_device *pdev)
 	if (!bdev->bamclk) {
 		ret = of_property_read_u32(pdev->dev.of_node, "num-channels",
 					   &bdev->num_channels);
-		if (ret)
+		if (ret) {
 			dev_err(bdev->dev, "num-channels unspecified in dt\n");
+			return ret;
+		}
 
 		ret = of_property_read_u32(pdev->dev.of_node, "qcom,num-ees",
 					   &bdev->num_ees);
-		if (ret)
+		if (ret) {
 			dev_err(bdev->dev, "num-ees unspecified in dt\n");
+			return ret;
+		}
 	}
 
 	ret = clk_prepare_enable(bdev->bamclk);

-- 
2.47.2



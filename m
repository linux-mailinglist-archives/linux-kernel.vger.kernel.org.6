Return-Path: <linux-kernel+bounces-355352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 690D399510B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D391E282A7D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDE51DF987;
	Tue,  8 Oct 2024 14:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z0IuMkiE"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5DE1DF978
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 14:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728396386; cv=none; b=ul1akshAIvSjmUzxVWhlu7yZyLdoE1vRKo2fLQP97tiBAwVgH34ZFeaoeDTc7QhuDbdAejGK39byqaBaoKOT0vtLy4ehjTRtyaxr7IUutQRCB74eMcpDHNo0kTCL33Yz6eZNQ4k7pTJqL53OaG6gT/6i0besHUZB6FaJvARRHtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728396386; c=relaxed/simple;
	bh=PpC5o/uIB4phTXYAzVmWIOfHpPyE4vcqVFr/9XJFZyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PEv4PAKZ1KuzMGHhtHXrhbQAxR5E/wVjIuRsi69Xf3D7Ge2SGP7E65AoYPF+cEyFe87Nvx2gxMh8UT9LWRPbQRH+jpcTruAWyWjLCJ6/GMFoRZkkQDI7k+ljrUIeD9Yt/sa+ozIptVpg5hG7nlAtnHl9kOHCd9dG1eeJse6E07M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z0IuMkiE; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9952ea05c5so332131866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 07:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728396383; x=1729001183; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ktJ6wdKOCXAImmreMGg6WO7z4W9EqJwBoMihOz6W5jc=;
        b=z0IuMkiEOOIWP81kN+yLbZweBPQOW7nDneSY+mBhEZvTO6jCFJJHNt8jG+4yY58dbz
         sxYmW3+r2lebl/GVAec7PwDvQHnmd8LWmx9QrGflI7AuDqYbn7Fshz6sLBr62xOQq378
         38Z/Ip8oOAoDbWta7KYIMKebZ+ElLemt0QD2ksrcrEOt0Q2kCJFJ6RSLbr0D0Fq8y3K7
         XStr8CMyobS0NSWsrIhNJG2UVJbkrzgk8JUo5VT4q7p0X+ljpFEA8HeLmQlAWUmTMeHa
         xsiiWYZJ2oQd5nwZxBzRtNNT7WRiaw4Udz5maF6Hlfz8cYA10+WAi0VZtbc73b9yOBGp
         lKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728396383; x=1729001183;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktJ6wdKOCXAImmreMGg6WO7z4W9EqJwBoMihOz6W5jc=;
        b=ACMQ5OcAetY4AZGyFDhY5VZce7YWVRDWZe907/WVVSwZlCRlHvuH1Xw0q/ysYfV5r6
         tEnjtFpTiIelaSInCN7j/i3ihKrLRcXHcluOWPNFjqFrRptxtl6JzMUeOS/aoAvLpE+8
         ng7E933Xb8OwTHVaKmFM4ZnPIKkXOV6JZ/YN0haGZtOeiKVxe+mM8lyB51/SWaBXqSyI
         Wy0EamvtSVCk0aBzmaLrmRkASNA1/HEVXBtxQEitu0aA+UFLyX22QVxgTfO0cqnqi1/v
         Nrw2LtNXYTYWXqaxv1s6OOr4gvqni5N1N6ANKxt0XLG0D3xQRjNir7HADjKDgETh1/US
         ym3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWmGug7MABdZTXbCD8pF6TOv0ajL7dTkoVqv4DHZI9Lz03Qr6mcVx0TEnZiGyDEdZ1lay/GLOtlfNaMulY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5FHCI4+0JwjyOEG/16C6XdxfYzq31xlNnFBujT9dg2jx5dp9G
	0WlU2WWwWl2van401U+gS9zXnCp7xQmeNEfj3U7wrCCIFObCdvXleroPyYDCEIA=
X-Google-Smtp-Source: AGHT+IFR87e/nGt2Y/8NqIzyiZRGGtML+mee42U2sTxd4fg3loou7SnR+V0iuVGlNJ1r1lJjgZmzyA==
X-Received: by 2002:a17:906:fd88:b0:a77:b01b:f949 with SMTP id a640c23a62f3a-a991bd72aaemr1860977166b.35.1728396382700;
        Tue, 08 Oct 2024 07:06:22 -0700 (PDT)
Received: from [127.0.1.1] ([82.77.84.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a994f50fcd4sm320714266b.171.2024.10.08.07.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:06:22 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 08 Oct 2024 17:05:55 +0300
Subject: [PATCH 1/4] dt-bindings: mmc: sdhci-msm: Document the X1E80100
 SDHCI Controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-x1e80100-qcp-sdhc-v1-1-dfef4c92ae31@linaro.org>
References: <20241008-x1e80100-qcp-sdhc-v1-0-dfef4c92ae31@linaro.org>
In-Reply-To: <20241008-x1e80100-qcp-sdhc-v1-0-dfef4c92ae31@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=814; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=PpC5o/uIB4phTXYAzVmWIOfHpPyE4vcqVFr/9XJFZyE=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnBTxVB3VAMFdEnxtfi3e8ncyROcCOIeiYQhjme
 iVmE4o+KpGJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZwU8VQAKCRAbX0TJAJUV
 VuNID/4uDm/7pY2jAlc2B0sEzGG7ez/fWAuFuMBDNaP1GlYFn8Qpap6DNjPZ9w94OBvMJmfwmnV
 K2akzjB1Ty8qi+KeJUB5fb3Dr745vH/tnVfx+scpkPQ7BqBml8BgqN5+jxCfO7AhfoUEIJe0d9W
 OBg1OANmZId9TPUQWEZcpoWX0QQkPDx5rLvVXLCb+6ihdZCCNrbqwrnNEnmUrth2dPu63PmkyRe
 C8lr2BmK1qtceRFZPQLAviNB+mxTbBb5L7mfkEabzoj0BHZZAOyHlLDNYveUWJ1VRscztVNjNxq
 XsBwLciyuIeKfDsKgEhzYann3+rGRa0f0ajx8EPtIAWFrLKnmtYQ/cwHUnBDQYSdwU5KSQVPSQD
 5Yr9EAtfA/5iY+q1sF3BNlT7pee2Jcqt44oo36tKLAm8+FS5/q4Rbrc+/yUgEk2HNAG/R9em/6U
 /wREA0XeD1viyg22I7cjjRE2zdgle17lwfhrNN8Un+foLJqZedSC4QZHsjy0JgyaUNaAbJgYyiw
 Yhy2IPmniapk+CV01ICkT36lVcq7gRWREdZoJVRZpVxaoapDFEWof8HqevEAQMGy27/sCCzzx9r
 NLVMwMGE1F1TPolT6yIWUinOmD7ESqF0ATa3IncbZWU+mNYAyT7VYE9ZjM152Rb8NLkn0xPNHMv
 +IlXQWbmY5bYsOg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Document the SDHCI Controller on the X1E80100 Platform.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 11979b026d211050270d018c03fa73c107e7c10f..8c7e016306f14be20e4a3cff289317ed603633f3 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -62,6 +62,7 @@ properties:
               - qcom,sm8450-sdhci
               - qcom,sm8550-sdhci
               - qcom,sm8650-sdhci
+              - qcom,x1e80100-sdhci
           - const: qcom,sdhci-msm-v5 # for sdcc version 5.0
 
   reg:

-- 
2.34.1



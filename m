Return-Path: <linux-kernel+bounces-381973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF869B071D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D87B92818E3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE9420BB3E;
	Fri, 25 Oct 2024 15:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g3nrBNY9"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E2A1FB881
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 15:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868645; cv=none; b=QQIORqIRJFzP85gTAJCNPM1MEpyGf0Zf2uAQal/671q1JrZRoIspFXx6Npx04zla32pBe+Oxe9cC1/ZvkgNuq821uNU4NRosS7lve/smNoME/cPS4dpGVhTGIqWxZ12dengu2mbVMzKaQtJ/cNp+4hml+sabz0cRJHmtmRGsjwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868645; c=relaxed/simple;
	bh=mHXA679fTLSBfLWh8pBmR4AEa9V2nbcklgPIdka6VnY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gr21BFsrstZMoHITNxa7Qu6iRPfWgnZYOIY1oJ+exWHcnt2+wKTaVpvhprdYY1pXlLm82L44Xvi9b9MtYK79OdxySuozIvTaPydKJh7f1CLY1hNaIz6/r6ORl8cgoA9Na/2jT1R8HqSnQ61NPjyO/NTvcSHgNDQYzz0Cpb5PiBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g3nrBNY9; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539e3f35268so2811812e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729868641; x=1730473441; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yljl+967ibX2I7aSbp1Ln8dspkbFoWgzBqO671H8u2g=;
        b=g3nrBNY9zmK9Yo+Odc+0gHmAvx+6h3uyNPia5WebrEYtliJCbhJi24DGvYD423bvYL
         dmc6/8ceSZLmGpAdKnNHLDhqaT6mHnk+bXHhMObimtigBQd8eo6CsWDYOJ6v8NnJEmOX
         hGsM7U52yr7BU1PL9hB9zjYp8uj1bsqZuzVtc4tEfrYKJVDtfm161leMdpwK2Z2EgeVH
         BjY6bhvtXtEPMrLm1Msnx2LOsgCVkwKXYpcwcSHoBBnlWsQ3yeAdv2+nnipSQCQDzzgy
         SQnaIb/37udVqKGcMMaySsvoF9Rb4Ooq/t/qI3RA8+AO+ZzMqTNJtDEu7TuY6V7fkwd7
         t8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729868641; x=1730473441;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yljl+967ibX2I7aSbp1Ln8dspkbFoWgzBqO671H8u2g=;
        b=MhQiexWseziit5TBnNjMdkva1FwtlBBbxkgic+y/MNIlk6tIu4w//Jn+ZILn69g3X8
         stFO74dFIFxG+bqiGKLvrG252D2laKVBgoFSfXb9I9JKZjmISQuz2IlBpMkX8dMTZ0ae
         xJLW1TGm2rZYHoGk9U8H+ot1/sQZSU4LxZ5SvzBcUOXL6GcpAyShGNkZfCW1p75nDJOe
         2rR7YisEI8Fn2wRKzhGFm3TUzjlHz73Hrg4awNltLR7+ZXE0ws4XegtXrAruVExsqxls
         /rfzDPTayPxSYkLcIo9VcRyFCcSAVY4eXa4E+ojqAJSsqNKyyI1TG0o3HslMhsVktVVs
         ICjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfxTGkvFsViingZuYyqRZMyhi2vh5a+3ngBUYhOCKuT42TrVpjXaGPOaMUb7fnPO7TSxa/xwsh2n0EgGI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/v1g7rylLRdqAo0tGPzwVuU0KLOBEWCWm1bf/gnCl9kbvlElv
	rHPsZ8NtHipuIAifK5pfmAxR2hCIdXZ/IzFj/LEIAtwSPSQcKEWlmmzTHevgJnA=
X-Google-Smtp-Source: AGHT+IGRdVgNIQNl7U761e1+szjrsqjcP0+l1q+achwbWKzkFkLd8qICXqlF0ukCjOl5ZqZ44TuiTQ==
X-Received: by 2002:a05:6512:3f17:b0:535:645b:fb33 with SMTP id 2adb3069b0e04-53b1a2f21b5mr5072553e87.2.1729868640664;
        Fri, 25 Oct 2024 08:04:00 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e10a915sm209542e87.12.2024.10.25.08.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 08:03:59 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 25 Oct 2024 18:03:37 +0300
Subject: [PATCH v3 03/11] dt-bindings: clock: qcom,sm8550-tcsr: Add
 SAR2130P compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-sar2130p-clocks-v3-3-48f1842fd156@linaro.org>
References: <20241025-sar2130p-clocks-v3-0-48f1842fd156@linaro.org>
In-Reply-To: <20241025-sar2130p-clocks-v3-0-48f1842fd156@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=992;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=mHXA679fTLSBfLWh8pBmR4AEa9V2nbcklgPIdka6VnY=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnG7NTNKoQ4rWqeM/jEqOVW9ZOebj6juoiFbSKC
 oo+Oh5dE8yJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZxuzUwAKCRAU23LtvoBl
 uLVYD/4hrM1vmtXA2QPfaA51PEgQK1wH3OoQeoXsH9h/YcrVZqsLL9R2bGPGhvBnZ8XcUhs18Oz
 ft+VyfR2VS0CGDXwJBOREEl/5KYqsD/tff0oNWQiFn6LvLYbCpr7BYpuiaNdQRyjleeeEm2Dip/
 +a/1oNNIeTmNmxqFC1cb3KGr6i7sqCoTO/fK6wctIXe1LU3mcETHCwOrENzU/De4kK4pBmR5EUE
 YtHkrYAJUFcx2LOPoIFDOhW36rG1quJ4Kpd79jkEW7DuVn0FVqXu1fRi8qGGFev2YBHMe+o8UW9
 inLQ11/EB3DVx2T/dlwJcxLXOhRlZ/LTVLqM4DW/rfZ0eUnUK3PZ/O/VCAJH7xSX8KMMRehAcDn
 Mp8+RffetNEUmkiasBCSHbOLfA45ZW+iCP2G8qa2U4EKnc+3rVEjGENpUoYUwuTO3syBkDrbUCO
 KKu9i89Uh1hj4wUp/tfS7dHtA9WQzymQi2UX97Pc1FecTg1GZ3PH1ISp6Gv2qUQtupqiunLp8oU
 WD4tPZzhHQedUjaMp/9KvGCfx63iP9fVeXWvYwlifqYZcuaDGYX9ucGaAk+R8W4Ep8B01qd1jzU
 Mv4ThPBUYvQIB5Z+yrzGpUGdMdGORe7YJ92kKG6Z/mTpd+ITJ4BhMOxe7RUg/NbNL06lbm1QEOD
 4o1o3LI+uPgqkqA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Document compatible for the TCSR Clock Controller on SAR2130P platform.
It is mostly compatible with the SM8550, except that it doesn't provide
UFS clocks.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
index 48fdd562d7439424ebf4cc7ff43cc0c381bde524..3b546deb514af2ffe35d80337335509e8f6a559d 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
@@ -21,6 +21,7 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,sar2130p-tcsr
           - qcom,sm8550-tcsr
           - qcom,sm8650-tcsr
           - qcom,x1e80100-tcsr

-- 
2.39.5



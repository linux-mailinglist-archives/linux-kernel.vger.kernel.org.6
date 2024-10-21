Return-Path: <linux-kernel+bounces-374097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4A29A6331
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D64FD1F21454
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B7D1E7C36;
	Mon, 21 Oct 2024 10:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kTvT7p+1"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F179C1E766E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729506654; cv=none; b=ttDUbg2ok1FHcdLivf47jrB5U5k6UgEMrCfqWZs41rj8ohuRRIM8XfzTzpIGHeNz2jIkszwjy1lClp6Vao1IWb1oJMyDxAe7b+DoRpQhW6/T39udlDSy37XMkeC+A0sDt0eetTt98qORegeyOPVfFBjrtls5XRyDvHasZrv1H98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729506654; c=relaxed/simple;
	bh=1S0e8INDTJp4RQZO2xifYyW0FBrz3v2kT78lT89hhEk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RklpyyGAf19JpNVv8z6Sfc9kw2Q1KOYV07NikXHMWOK6el46pAvN19WW3Soff+lX4nUYrmX68CZKTs74n3zH6TO47Xgav4/f6fZQXYXAzO2BbBCGEWAB42Kq8pEbAQ+EPpsFYxH8MkY8UuS1DZQhSsquRI44+CYKiodZrGfYvbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kTvT7p+1; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb5111747cso47309951fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 03:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729506650; x=1730111450; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dQiTcshw9Ox4It49mqmwWy0sWX4h7q2ja8AFVlIbjLQ=;
        b=kTvT7p+1ag9exQk1AeyV1bqJEaNOG/EEiyNZC6CXdCjN2EELGuDePI1LqTqPcHtVLX
         QOHDj3B6j6WQzSkMw3JY/o9A0DrJ1dPVRkgUD4Iab+B1Qx/ohcNRfNRTeKPyeZS7aPQ7
         AUieRMT5Jnu1Fdu8sOokBlIn8/4QbXAvKN7PFeSfogFpqTy9P3p15enoDan2IT3Y9v2F
         vc6/OVHpqX5EAziFJqflQYGiAAACNzg0tpgayYvqyDhOrU9JCj+ge7gM2JnyORpYNsQ8
         AS0yF5j8IS7JsMQT+MP+RUK1drc1e/nmzrSy3aXNAzpNfD/aBp1i1jpVIz4q6EE+e2Z2
         x82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729506650; x=1730111450;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQiTcshw9Ox4It49mqmwWy0sWX4h7q2ja8AFVlIbjLQ=;
        b=N5ias+TmjD0HoPA6xp5gyBxd7NqaSkV01hy6I+MY9gA4oWnoltiQHVMRl8VPC2WQnE
         qGvfBakLjWp7xydTjyRfdGaNUKNmmWjetLpmjAwtm2mMHn48K+mbwfGspl/tM+b01j5H
         cV1iUY7VbfRWwd1pl8vZi5hsk/Sk3nk3/lqqdcmmRzorxrXfXr54yrWd+35qAPUaL9Nh
         Yjk+gG7xsNOa2LOSW8200sjvuaHf1AMAv6q7VGAwrwXn9SISkWpfYyoGlZv6SwFs40WE
         uuD0SNRDjcP4TIO5jME6OXu4uZYkPabgli6MNZS2X7u6EKCb6YgZas6w5+Axpt8VIN2r
         2WxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVM9qvOTeq8X1BHGJeIMDl0jDyurbU6KFQ+KrR5/3xE4gd5VCurZG+m9YduNYXHO+bb1vK5SHKSPO3T7Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSHi1WegpxDh1ipBnnMzTi0keDLxjX4TA00dyPzNoaQwkSZjBZ
	NnrQr9NpOqcudJBCimd5gIFE3rQixjwCPBB6l9e5XNVb3rBxgiVJ7ealxm+eSYQ=
X-Google-Smtp-Source: AGHT+IFdlpTLDL6uAYyvCauFygr27m1FoT6MtjFdr97ltgm4aJVC2CgQpEhbCFZHza/cCrXb9elX9w==
X-Received: by 2002:a2e:4a12:0:b0:2fb:b59:816a with SMTP id 38308e7fff4ca-2fb832268bdmr30572101fa.45.1729506649961;
        Mon, 21 Oct 2024 03:30:49 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb9ae1217bsm4522711fa.112.2024.10.21.03.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 03:30:48 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 21 Oct 2024 13:30:32 +0300
Subject: [PATCH v2 04/11] dt-bindings: clock: qcom,sm8550-dispcc: Add
 SAR2130P compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-sar2130p-clocks-v2-4-383e5eb123a2@linaro.org>
References: <20241021-sar2130p-clocks-v2-0-383e5eb123a2@linaro.org>
In-Reply-To: <20241021-sar2130p-clocks-v2-0-383e5eb123a2@linaro.org>
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
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=912;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=1S0e8INDTJp4RQZO2xifYyW0FBrz3v2kT78lT89hhEk=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnFi1LoEgArHwHyvEnghZXjDksFVQgTU920IZf7
 M9whm+DPmyJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZxYtSwAKCRAU23LtvoBl
 uBWPD/4iQROZaL0D58KWTrit6SzEuGMOfHuzbHZ7M2HUOHm72tW3Ws27trklsAWjsrJEfrauMbK
 UFXHbUyz5oleiJt4LqnhI5zU8p1tCWTeScjn7ROnhvlb/YWZzIPO1tjzTlt3ir6NoHyYPk+r/CJ
 qFrizxvo2cV9i2HkUGzDNrvOfIBX1l36BYo1VA/1bqMq5eHkKozt7YqjnyN1qOafPAGmKJJuU49
 O5YUcfmpGXkjnodArFXYMJlVDHV7floI4gOAyH9BStUmbza0o2lSu6eTynROeU895e82YIx/VKo
 W39EgjTN5w2qo55vSw7N0rkFOircnT4CVdzvXckb422twwqW1sYpyOF1hCEY7eSVIXVUpZgbC82
 4fehRDCrFBJGqnbcuDD83fHqu+CDDcnWfHkhNTKfHXAGvoL/H1NyvuiKV1mHVzhoIBF6UYdVAcn
 R/PR3uL9SAKlRgLCgTD4b7681dEJ80xDK6CAczG+uyqPW6tAVG6zps2sdodLDe9MEtj2CvbTeGa
 YyOmmpPqr5hxv0dEm9Jta6aZeqXlVU82xwMpODc7wCai9NDbMiO1+uE204CP+62IfmVDP63Q2Wo
 eKDhoLw8iv+s+3kQv0hzKehiCh2/U3OPFlmw8rpB2WDXqrh6EJyHaoo2mivnoQhUovqa8tFy2zl
 XYnMmjTq6tHyAuw==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Document compatible for the Display Clock Controller on SAR2130P
platform.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml
index c17035a180dbf3dde715a281bc54165122739618..c57d55a9293c214c4c101902cdd9603074e2243d 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml
@@ -22,6 +22,7 @@ description: |
 properties:
   compatible:
     enum:
+      - qcom,sar2130p-dispcc
       - qcom,sm8550-dispcc
       - qcom,sm8650-dispcc
       - qcom,x1e80100-dispcc

-- 
2.39.5



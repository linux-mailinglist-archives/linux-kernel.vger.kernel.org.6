Return-Path: <linux-kernel+bounces-193054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 317FC8D2636
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63DF81C25E0C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C100717F37E;
	Tue, 28 May 2024 20:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wQmJnPYB"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B5817B42D
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 20:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716929023; cv=none; b=PYd/goLsncoLKSgDvfKDgUhJ7AXWhyNlJUgXICLrCERlQ0D9x+nP8E0US3TlyiZSST7w7BQRkfxoctM/siO4AyfzpAZIpnltJcjmlCD4BKnevmym8fmulBBCFfoslA5lgMcNk78eyqlHJ+KtN5yoVbGoBhT76/9rdMdwuf5IIas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716929023; c=relaxed/simple;
	bh=lRpLU4+n+2LPk/ccH5bPtiArjYLyhzunyjvm2wkPD+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=phFaSGUhk2wTzuhMR2OeNA0PwkEOYZ8TVwbGUb8KXfjBEtAPLm/0DCBUu3zvV5FX3sg/rUH0hpARZTW+abYTghtsQs6MyXZCBDpYENqwT3392gmnVxi9O8b/jTXdqBMjAoQ9IEghU2uDJLMfo+t364B5aVrEzG3eLGc8nXus8qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wQmJnPYB; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5238b5c080cso1527031e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 13:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716929019; x=1717533819; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7WcDNJo8QuorG4DoTByzRTK1XRQEYsY7LkR0kcQObUY=;
        b=wQmJnPYBiKenjphgjOaxBtVeKvdu2ses90EQgEAYg+8K48YtGq4dvrwzBmWVp28DPE
         +1FD3XAI1TqBvvFtu8F9uOxBjUnE+dxpXv1Htoy9KOkHYHe/oVgIeTaN5VtLzuvH4VVy
         IBwZ+JPrwFY7XssUwvN1IC101ps6V8tU7xI516YWATAZQxNXtKGnvKfFIvvGzv6Doi9O
         sbYAUk4vt+B/RlcxpoRQm/7NqQfqAy0eXVpFIGj0W8F3IxC4B4Frn1Xqu9WtDoukih6m
         HL8z9er8W9sO0iIfmtOguFjleLenEkqhiZVYgTjyI9lRLGRSkIF8L5yUW3ZEphSj3BD8
         eQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716929019; x=1717533819;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7WcDNJo8QuorG4DoTByzRTK1XRQEYsY7LkR0kcQObUY=;
        b=lFSuNSprZ97s2iM7sISzDLz650ISXb3If3s1oKDYIvRSLV+3rtsJZgj2k01jVp9i1Q
         13r2jgCl3pIJXLZwy4s5/qM/M2hApSnI0SbLp1S1QwQSejBnaEGw9ZfZTf5YmM281uuV
         2PTAuMxxSUL2o9qOHo51uIBOIiA1dPqHJEO++AKZqlOIYIGa6J46zsROMH/SvQbopn1W
         1XG+j9IN8YX6SVG7koZjWvYmKI54XkzATN62yrkCX2kcTqH4jc4jQcQDU8MT009NaA7X
         k8NYFjfROFUWWywau58DN9yOMwQwCFnaxJVzFFTC+9OWej2I+5Ve26u9xbvvigf+lGqP
         t9BA==
X-Forwarded-Encrypted: i=1; AJvYcCWcpI8zkg9m+7bxma3R10Q2nUSGUBV6ukHZcQWNqqR4wVMIFBT3OzsMIMiBwYEJy78Qzs/xpnPnVoN7uNzup5nfWQ2C/BCiHCcMcV+P
X-Gm-Message-State: AOJu0Yz48VJbjyeWKnlheoqypc0jv2tInwX2j3nzJ5MqgPqn2UIpw8Uf
	ZvRNq4eMA5BLFLXMviYgsf9ag4cCV2X0toH/G38MwyqK+5ICotYVGJ5TcSi45zw=
X-Google-Smtp-Source: AGHT+IE6TOYRfPyp56T2x/YFpRdUUS2FUm0G5zXSaM5Vo6P3jCeoLbnt2IK1SzCCeiOuN26Vxsxy6A==
X-Received: by 2002:a19:9115:0:b0:529:5f9a:c543 with SMTP id 2adb3069b0e04-529666d5f40mr7774874e87.42.1716929019204;
        Tue, 28 May 2024 13:43:39 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5297066b885sm1095493e87.127.2024.05.28.13.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 13:43:38 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 28 May 2024 23:43:23 +0300
Subject: [PATCH 05/10] dt-bindings: clock: qcom,gcc-nopd.yaml: force node
 name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-qcom-gdscs-v1-5-03cf1b102a4f@linaro.org>
References: <20240528-qcom-gdscs-v1-0-03cf1b102a4f@linaro.org>
In-Reply-To: <20240528-qcom-gdscs-v1-0-03cf1b102a4f@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=867;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=lRpLU4+n+2LPk/ccH5bPtiArjYLyhzunyjvm2wkPD+Y=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmVkH1z80cEJ+UZPNWqNWl9M97zzHG4+bkLeIyo
 TpUETu+qveJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZlZB9QAKCRCLPIo+Aiko
 1Xq3B/93AKIiN/qZRW8mCOdHldfd0aw9sGmlYmLZcsnFSqjzouQTQhrnW8OK105nc6VfcFHMSSD
 zjzip8DBOqL2rlppfkT53uAZz3WPBdCxtHH3o/tD+1r2hiZO6YNQPYk8zrE5pBKdwHpSXpBsiJJ
 X1UcGtOIAEfSskfrKLlXJodA3U85FNZkqu/2pLP6EH5mRUfncdwLwYH97GJ5NVmdSETlhqiAKNp
 5UC6U0O9tVODWJpzlrOf+ff7sQNm9NR0HAi+a3Tn1LqO/GL6S/6ocwzqkVgNVLL3Y32RP7npNTP
 ZXyOQB1DxOYS7wbSRzsjWcq4QTqyQEFwpGVkcLV7WBt9eWY3
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Force GCC device nodes to have the name 'clock-controller'. Several
platforms used 'gcc' here.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/clock/qcom,gcc-nopd.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-nopd.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-nopd.yaml
index a941e75a930a..fa9a3d3a3c67 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-nopd.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-nopd.yaml
@@ -14,7 +14,12 @@ description: |
   Common bindings for Qualcomm global clock control module providing the
   clocks and resets.
 
+select: false
+
 properties:
+  $nodename:
+    pattern: "^clock-controller@[0-9a-f]+$"
+
   '#clock-cells':
     const: 1
 

-- 
2.39.2



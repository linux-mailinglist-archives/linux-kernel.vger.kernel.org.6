Return-Path: <linux-kernel+bounces-414339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB88C9D267F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CB851F22C2E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 13:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A311E1CDA24;
	Tue, 19 Nov 2024 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OfWaAXN0"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FA91CCB5F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 13:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732021838; cv=none; b=PNme9zMJpls7EfTZ9wKUQFVtTda1RZnvkf0yoxM/NgE/ISqn+K646SZ8LvbzgQq76iPKQcQ9BctdubdrmnS7w77GVuZt3oLW9RCzPb8TUkcKwR0SX68/wJvyngr25XFkWAfJx4lRf8HIBl5rkyUD9PaWWwOzSkR2Fsssx6Vxtb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732021838; c=relaxed/simple;
	bh=+Z/PdD2MYfcpiCWwU8ARGvFmCClzUqxWTTx33AL6Y8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CjLpzW7rAAGLI7znH5bYjrr0cyycmWuIsvtvIOvRUzP2F/RIrdUq4SUnRPWzAeOIXryoKf3NscchN/pn9fQUcuudH/scb+DcnWEI46K8MF7sPiG/+oeM/kVQxHbJTRmK1Mq24ynjJp4ZTwlwBJnnPEXbhnYH0wOU+SpHrRw4Ijw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OfWaAXN0; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43169902057so45586815e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 05:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732021835; x=1732626635; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vLg4Ldyb3QyH8qI2mLCFcOUNVAsIDeqLMDJbc+hKrrM=;
        b=OfWaAXN0w8BpXd6aMfcE7DJ8fZ9gufPDHRZWgi9XnFGYpgdyH3Rz43E8Tz+y3UwZ2V
         3q4RSftD6zBtUOzB3FL89XKmFQC8ntr61LmedQkAI6boWUqa5uiagJX7OJw+7bYTeW57
         HItDlwKvrM1kP67z42KYM/HDJPTQBl+EkkLyrnBVL3J1t8v/9FBgXRxDlbU/YVo0gVsG
         OdTY6/UXXxLVf9XnJvB6DdvJ97Y2FXeigKCF08IXhwlMcAdbF+aMXyyGzrR+s+vTDRMh
         kEUNHjC3MbEJS2FI2UBIg/jqbZxPAi5TuTjLCObGAbkIX9XMpVoynoTu44kL4hUJDEse
         RYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732021835; x=1732626635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vLg4Ldyb3QyH8qI2mLCFcOUNVAsIDeqLMDJbc+hKrrM=;
        b=lAgt7oYAXO1v59o+JycZmW6RWkhGu+Q/2jWbr9Q/4hI319bYI6ANc2cE1IT3OWjnCJ
         qgbK2nw3LdOOjM8ssSIza7MeazE3MsAIQ2nLhG8/L1gl55Tt2iq040E60twDracljYJ8
         6Ev+TG4mw7XZvOjvhba5UlgueENDOnu8nO6qocMza0BDA6eq8wgcwLsEasdwm6PQfPwR
         ZZ4PczZjfQdpbnDhEVdRVOQIjthvuvOC7ioFlAifUi6kr9/vEpfprnNFmy1m/fIGpvsP
         Pwqhbra9eE5+jW4rsjSWaAQzsAQfDm1SJED3RouYVBhlkHSjZ/nO6d8oHjVr3Vedjbxo
         ku9A==
X-Forwarded-Encrypted: i=1; AJvYcCWB59noQeBxIezJrJna3C1J4gcLHlFOqDpMgAxjisOuEMPYleICWKncITm3l5f1Vkpsb5Nql0fL5ruFUSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLvJj6StFtbwMMvzG3H84ljQ+0codzKVeLc5+HmHgEce0XQJnc
	f/yQhTGKf42g/fGsuRef+RX04q8a/oSc/R8z0hHYYv8O1u23HlOdf8/WlVgMcEY=
X-Google-Smtp-Source: AGHT+IGJzaFaJz3YJohGuDkgPzfL38B4e04J3jb4J8DFuGIWIjaFuEed7tFXmMa3NleNtFete+AYwg==
X-Received: by 2002:a05:600c:c0d:b0:431:680e:95ff with SMTP id 5b1f17b1804b1-432df72b93cmr138509745e9.9.1732021834697;
        Tue, 19 Nov 2024 05:10:34 -0800 (PST)
Received: from [127.0.1.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab76dafsm192016185e9.10.2024.11.19.05.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 05:10:34 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Tue, 19 Nov 2024 13:10:30 +0000
Subject: [PATCH 1/6] dt-bindings: i2c: qcom-cci: Document x1e80100
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-b4-linux-next-24-11-18-dtsi-x1e80100-camss-v1-1-54075d75f654@linaro.org>
References: <20241119-b4-linux-next-24-11-18-dtsi-x1e80100-camss-v1-0-54075d75f654@linaro.org>
In-Reply-To: <20241119-b4-linux-next-24-11-18-dtsi-x1e80100-camss-v1-0-54075d75f654@linaro.org>
To: Loic Poulain <loic.poulain@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Jagadeesh Kona <quic_jkona@quicinc.com>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-clk@vger.kernel.org, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.15-dev-355e8

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
index ef26ba6eda28e95875853fe5043fe11deb5af088..89f852ca0d6b8a6b57b596eca0a3765efd058f39 100644
--- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
+++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
@@ -34,6 +34,7 @@ properties:
               - qcom,sm8450-cci
               - qcom,sm8550-cci
               - qcom,sm8650-cci
+              - qcom,x1e80100-cci
           - const: qcom,msm8996-cci # CCI v2
 
   "#address-cells":
@@ -205,6 +206,7 @@ allOf:
           contains:
             enum:
               - qcom,sc8280xp-cci
+              - qcom,x1e80100-cci
     then:
       properties:
         clocks:

-- 
2.45.2



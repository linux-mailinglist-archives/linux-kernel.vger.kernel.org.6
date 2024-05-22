Return-Path: <linux-kernel+bounces-186139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E82E8CC045
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEFBA282F45
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 11:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FEA839F4;
	Wed, 22 May 2024 11:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mTWxnShD"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B529F8288C
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 11:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716377415; cv=none; b=l8rRP2wBsPROr3OeT3rkqh8QHAzI6d4xvbDh1nxL6DKdTbXvNG33rG582b/436lE+BtUE99wYwCDMhk24QBT3zhrt3EpXCikRv2yWVpL+MEyHvo5zKvDduOPqbX21JsumDaR8vQGbJN5FzKpZhfkk8osVx3eQ9nwkfGsoSnI36I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716377415; c=relaxed/simple;
	bh=8fClpFzgbj956EFn+uaJ6XnDcz4bIDEVxAzQg1CwQNQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=daEov74cqySNaHi3hhH8uSxIpAX0pyJCHOKzmzBtuE906iAugEfN83/X9VPnieP5qFO+QyEreDsttTKszi1iGbWH1dRBOYx3j4h+sSdx0h6RejPzWm+jHN7n4ICFYUaZFJqE34ToOSJVNWFdNXCKtH9c7QrhpxZ4nHNtFzRsAow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mTWxnShD; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59c448b44aso977558066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 04:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716377411; x=1716982211; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YZoiqpvOKZDIGgJEiGUZklf8/EHotP3f2aXxSG+hvYE=;
        b=mTWxnShDD6qW3a6j4koCt4teJu+mT5nvGaLkGgFGtM3snjpiy1sGhdp2O9gq3LKahE
         oOBYoqii4KAEo43ofcU6hGzJ9CMeb8vfgEmOIKuM6xtHvZ7nPr2womhWbKrjt5kDRzhG
         DrgytcPc0NtZ4kL0dHmddCFni9+ItAYmMxhTpEnAAkyh+ljns/TP7nMQ6mnKDjkUmuFq
         pkNUtTVmXIBOfESME3Ax9tEzqRubXzm72HF66Paxjm0JGPzLZPa3ZV3bdYRjdiqOjE7p
         6QCxLDzQ+QDZXOFoN4JxyyuaFQlrGbezlEGzvXpmUa01ud8eBWO7iXtRWbahs2Ul2AKN
         Hzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716377411; x=1716982211;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZoiqpvOKZDIGgJEiGUZklf8/EHotP3f2aXxSG+hvYE=;
        b=uBYGqQ+PNsoGX8g/cw9F0rJrhILdVoEtMWKLoveE+pwwzW0E3AnAPIbmb2wLLxH22+
         KPVPHbtWm5QlLIUpA4rzYnr7toXnpixD3OiJ5F1i4Txowb9vkAuIork//+8Vm2sD2k1v
         eOcge0Us9280vFnjXGqBt0Axg3UZT8LdQgUyVIbQ9ARdAlfs9jARpAkNKsAmKzEUR1lE
         hfa0yAl7258sBwnC4DKIsDrFY+ZZlLaztxhygoF002gzIddxxk7KuxyAdmGb4weuzrEY
         RVD9+Uq9VHvHli8Z27ycFQ6sgN3/cTQ9M/LSLdGNQXqHO9+YohDCz+yTlAVWh0YmEOou
         9NNw==
X-Forwarded-Encrypted: i=1; AJvYcCVWadvCqL+VxU8QTmgmtkVYoxXteA1Na0S0lVk4kWG0IEl9lp6MDaIlPh/4q10pEFEpdG0inguJQWqr2SODJaZ0W3YN52pfRV0SPXMR
X-Gm-Message-State: AOJu0YwDLNoks8AACii++34I6bfLjyaDR3JIIox+XkDfAa0Nm5um4xOu
	8X8P6Rr7rtjWNFu5LlelRNejBi0h6I9kaO3hLcBlmAUN4gFrGuxj0SOBRbDA1fV3Z9Ny08d/dal
	KPPQ=
X-Google-Smtp-Source: AGHT+IHsu8+uMqmAFNEqXh0NM9TQOod+Je5R+HNL20bB1H5C4/766DKxa0EsQmQkXNDRxRajWzKPiA==
X-Received: by 2002:a17:906:404:b0:a5a:377e:4c4a with SMTP id a640c23a62f3a-a622816dd71mr103849066b.63.1716377411043;
        Wed, 22 May 2024 04:30:11 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:f41:c55:53ae:4d0a:75f4:a9ea:5025])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01652sm1768363066b.167.2024.05.22.04.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 04:30:10 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 22 May 2024 13:30:04 +0200
Subject: [PATCH 1/2] dt-bindings: pinctrl: qcom,pmic-gpio: Document PMC8380
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-topic-pmc8380_gpio-v1-1-7298afa9e181@linaro.org>
References: <20240522-topic-pmc8380_gpio-v1-0-7298afa9e181@linaro.org>
In-Reply-To: <20240522-topic-pmc8380_gpio-v1-0-7298afa9e181@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14-dev

PMC8380 is a new PMIC used with X1 SoCs. Document it

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
index 50846a2d09c8..a52949526a2a 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
@@ -57,6 +57,7 @@ properties:
           - qcom,pma8084-gpio
           - qcom,pmc8180-gpio
           - qcom,pmc8180c-gpio
+          - qcom,pmc8380-gpio
           - qcom,pmd8028-gpio
           - qcom,pmi632-gpio
           - qcom,pmi8950-gpio

-- 
2.43.0



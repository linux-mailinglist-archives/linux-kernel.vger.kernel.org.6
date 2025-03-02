Return-Path: <linux-kernel+bounces-540173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 513A6A4AEF1
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 03:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86E663B3AA7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 02:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B534514A60C;
	Sun,  2 Mar 2025 02:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ij8evwgD"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405BD41C72
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 02:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740883807; cv=none; b=fy+duk2SNU+a4kyYn9Fp9xY9lOx69D5CBHsDgNaWjXyeBLdGena/kj+D7JhVn0TIHHwFEW0UPAK3p1Pu97TiOWiVhprACCFu3CMzcwKD77e1Au3ku4wyhjXbsw/5PP5Aa4vEVIXtlSoqd7L/i/FUgWV5gm929Nxq7rKfaOH09zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740883807; c=relaxed/simple;
	bh=6ScO6d/vD41aSSHc3m/TNsRC6O9XMMje0w18/CgtKz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B2pinBtvtA0isqutsnq8978+WleYj1T9OZSWVplGHdppTQDw2G2T4R7kAwKAO9ATgO3rbcwWMZa2lZNzIciJm4gHujwxIiO4u9QT2KeVygKFCOfjQYmu56D7X/x/t3XVXn6XMxT5ONdvyCuFAADriIOYjNLSW5Dw8m22Z94NgK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ij8evwgD; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-390e702d481so1387027f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 18:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740883803; x=1741488603; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l2dsCl7aelSQACC2hAibA/NG78Rv8OzFHgcMb4grt70=;
        b=Ij8evwgDClxjlp7aRRkY0MPflAHB4vWSlNW6KEJgh+0topDBtTtfND5BKOS/cllZuQ
         KqdfebTv8GJGJsXGuJjTSfXVmOGejOIWBi8hyFd3fZGhPLR+3pwIhX/KpOQ+N9N6FS65
         WD7HBXC7TjOczgrFLhc07tPQWAiveJSUGihDDqxSTE/JejV4jmqx4fR0J8JFXYaIFVR0
         KR3imcQpDZAkxoUkYXXLChoBRKcdqjjlNSfSKa5JwbHsvwbeXALC6ulNqnWtJF83rngA
         BtrCtsAbofZZUBSr3ObVd8gNVWmz8wbDDQQ0JqzfkpsNNDme5TX5S8GRYL4VSwkXz3bF
         BwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740883803; x=1741488603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l2dsCl7aelSQACC2hAibA/NG78Rv8OzFHgcMb4grt70=;
        b=T1aKqboPh86ktKdBvrpIEODzXO2W/lffrr4yzu1zvBmxCzOOOqeIAXlp95Kt8OX60J
         wSZEksqlAneCY7Q1ypH4emOkMURunfkJ8wLJp6cEnhGNL5/w0hrMmuA2xmkJjVarQ/Bu
         rl+E9qMqhuC1u+dtTNHTIIGldeZLcjsQUjh89vdmQAFDIrXQ1C1+bmkxYqFNKeErrQzz
         yBH0wXKFsNZp4m6eF/CzEhQptXBHMakrHgYTEkxSBpxY0Qo/LPy1trSvkh3DMW8BgULT
         K9V7cEAB8GMbuulSRi2lyI1T+whx1OBOMnCNTKumWn/1kowhb9CpPC5gN39s91jf56nB
         NOig==
X-Forwarded-Encrypted: i=1; AJvYcCV5qPZr7Y6OfJxnFR/JyHBM89+U5WnOxdNDxeacroOI91rgvo7Hfk5s7gTjINusThWON0lox5NqFjqiuNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3v7vNQEOPGb4Md6k2J7wuAXe0U6Wyf9IMyQPFy3Q7u2PRyaxr
	p3C3r3z8niIdWiVoDjhWyJja2aFOKlh+IYAfnj3JxckprpbkA+Up6XspsjvdbNM=
X-Gm-Gg: ASbGncszQjHb3PxUj5NqJhAW4dJSaX/q0zbXV0SzgC0evqOsVtszNaNi2xmRa7NwzIL
	D0ZDUJ+hv1pnXylrltWK3PZEVBxsNTM97Kk9S8U2cA9C5Q4T74MxCWvFyOYP9OsjjqnMLcIcE2A
	KlEGkKHbmsF84Am+pwGztteZgDjFWfBJ4qco+gv06OOghmeZP8BZdGD4TZd5mv3pOWV80E7hCWW
	rfwAhu+yJBwS3eg6ZGu2PkAFPL8FC5YV+NWTxBK9LqF39AEYSkTYivwDwFadTMaU67heg1Wb1ag
	H9YhCQeJhg4J8EWm/eOo7QZWjxsr8y0MrvTKrnqbqMMsmJ6J0xfyOQ==
X-Google-Smtp-Source: AGHT+IFxHCKQFyUj24+tuV6wSHKQy4LhNfQvVRey7/Nm7Du1PU4gaJP8VBFQeZCerX6w7bwI5hKemg==
X-Received: by 2002:a05:6000:4022:b0:390:ffd0:4138 with SMTP id ffacd0b85a97d-390ffd04350mr1322985f8f.24.1740883803448;
        Sat, 01 Mar 2025 18:50:03 -0800 (PST)
Received: from [127.0.1.1] ([2a02:c7c:7213:c700:e992:6869:474c:a63f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba532b0dsm137845975e9.13.2025.03.01.18.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 18:50:02 -0800 (PST)
From: Alexey Klimov <alexey.klimov@linaro.org>
Date: Sun, 02 Mar 2025 02:49:51 +0000
Subject: [PATCH 1/5] dt-bindings: pinctrl: qcom,sm6115-lpass-lpi: add
 QCM2290 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250302-rb1_hdmi_sound_first-v1-1-81a87ae1503c@linaro.org>
References: <20250302-rb1_hdmi_sound_first-v1-0-81a87ae1503c@linaro.org>
In-Reply-To: <20250302-rb1_hdmi_sound_first-v1-0-81a87ae1503c@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
 Alexey Klimov <alexey.klimov@linaro.org>
X-Mailer: b4 0.14.2

Add a compatible for the LPASS LPI pin controller on QCM2290. It seems
to be compatible with sm6115 LPASS pinctrl.

Cc: Konrad Dybcio <konradybcio@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 .../bindings/pinctrl/qcom,sm6115-lpass-lpi-pinctrl.yaml           | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-lpass-lpi-pinctrl.yaml
index f4cf2ce86fcd425b7522918442de25c836bf24f0..ec1cd684753ad22050ae349a2e7acbb2545a9070 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-lpass-lpi-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-lpass-lpi-pinctrl.yaml
@@ -16,7 +16,13 @@ description:
 
 properties:
   compatible:
-    const: qcom,sm6115-lpass-lpi-pinctrl
+    oneOf:
+      - enum:
+          - qcom,sm6115-lpass-lpi-pinctrl
+      - items:
+          - enum:
+              - qcom,qcm2290-lpass-lpi-pinctrl
+          - const: qcom,sm6115-lpass-lpi-pinctrl
 
   reg:
     items:

-- 
2.47.2



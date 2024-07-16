Return-Path: <linux-kernel+bounces-253835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2AD9327A2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8637A28569C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0ED19AD71;
	Tue, 16 Jul 2024 13:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PZQU9Rc1"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AC281732
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721137147; cv=none; b=nZx2uOL7PqL+6tHZ/IijJoFgRzVbH/f3E7sTRe9sbyRdGqjtkUfBRjYbveutJsfXWcFrKCA30i4aEcuoBtfA2I6VkNSjekNOV8dminQekJor3LsP8KURK7/tsiJGKk4CyNT2jdqVI1SHwRhWss3TnRctpbAKs3/9QsLs2WbDIyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721137147; c=relaxed/simple;
	bh=X7bklE2GsqthkplIQvZDv5rg3XCkY1GEHEuOa1Ws1NY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yn0hgJ3eyC9RBM6jnPRRitJLvufpd82Y7mariKq5LUsyXMH2u2+3xFw1QKp3QeCXMnVtYSS9eX3bz55JIv9ZFEDKQ/CFsGHJ6TKyQtkLsrjhCi1aOS45N+h+NtITNMFbgRQarB/GPFjxuGxDyJY/RccbKwTRHjaRQ2zG9oruCb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PZQU9Rc1; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42793fc0a6dso37494525e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 06:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721137144; x=1721741944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hoRw9TcQOEMBdmZxq6Nd1FUggtL3OxOdKdUjU7Ar674=;
        b=PZQU9Rc1uamUErcSkYo19qR9o9/Qg+Fl+7O1SBqoh+4cT234bFkHAWfW9/3P9NCfG6
         CyKIFlw6jJ8JgtrXoNeYdgNzUeu0wclCpvkTi4BpyFy2nk6zJ7pQClwJmah1juz8g2Xf
         vCVYNQr1tuhi4/5Q+eBwJUAMUoQ3p780kMURErG7+VciGybWg2hfmhi3f02TlbNtL9d2
         zBUr0hqiWHnNfOpZ6jaoioBy2KBvm8vuCz3bVOk/gx4Mui7mnb6ykjAFK5cvR8+FiusK
         rUli2JRfz+CfagRELvymZ1cP6MiSRrT5zrTFLNuI32eSduncjaPYK20c1UvKh8C8NACm
         fJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721137144; x=1721741944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hoRw9TcQOEMBdmZxq6Nd1FUggtL3OxOdKdUjU7Ar674=;
        b=FEfw+eXJUHW4qjutJpScuDqJF4FZlnPECbhQvNvh01yMWlYyRdufb9F8eygBxGXO9z
         iRlo4ZfGiDt0zqZJgV2hPQn2dB9farl0vJ99VQ/QF2wl9gmW+JTKQ+uWSyP8HlRoKPeF
         ea8KlfFcSH6ngOj9B4r5sf9nHj24s+6n7yx9zHaJKuap1BE5iYLWNmf+i2HbnneB2KyU
         9gyZ9rD5GlKj/FqoKIM/NOcJllQAhCS0pfxgzJHvGZK00+GrLNft3yyuDEUwNB7EMGyM
         aIj/7lgDR+tx19HUWrd7hbJ/kqZOqPajmttQ9eFRGBV87iyRt1m3AhhF5PqkQYWVSQ9Z
         +OKA==
X-Forwarded-Encrypted: i=1; AJvYcCXPYPIwN2VwFCKexZnVbVyGaCNQTseHsP426UxLRJuoxzDeNYG4Ql9dey22y12KHKLy7I98ULY3wRtmFe1ww+GMkFo1xDW7TW26aURK
X-Gm-Message-State: AOJu0YxT8v7EQYCdI9RZNkty49tVOiL0JcIox1sfBVRyh2eUVvjZ92bV
	JSVQsX6/FNAVj2AygFXbQAFBxiyKaYABMpLpHtNpToS0/NQg2nmaMOdtZTng/bA=
X-Google-Smtp-Source: AGHT+IGXs0HjAx3DBf4LWEbRloC7TAHjz/hinusld4TqeGA/WwEle1cNhCho1exyWsBz602KmeEFJA==
X-Received: by 2002:a5d:6143:0:b0:367:9877:750e with SMTP id ffacd0b85a97d-3682609b526mr1426499f8f.25.1721137144212;
        Tue, 16 Jul 2024 06:39:04 -0700 (PDT)
Received: from rayyan-pc.broadband ([2a0a:ef40:ee7:2401:197d:e048:a80f:bc44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dabf0e4sm9106564f8f.33.2024.07.16.06.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 06:39:03 -0700 (PDT)
From: Rayyan Ansari <rayyan.ansari@linaro.org>
To: devicetree@vger.kernel.org
Cc: Rayyan Ansari <rayyan.ansari@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: thermal: qcom-tsens: Document ipq6018 temperature sensor
Date: Tue, 16 Jul 2024 14:38:02 +0100
Message-ID: <20240716133803.82907-1-rayyan.ansari@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the ipq6018 temperature sensor, which is used in ipq6018.dtsi
and is compatible with the ipq8074 temperature sensor.

Signed-off-by: Rayyan Ansari <rayyan.ansari@linaro.org>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 99d9c526c0b6..d6f333a7bcd1 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -76,6 +76,7 @@ properties:
       - description: v2 of TSENS with combined interrupt
         items:
           - enum:
+              - qcom,ipq6018-tsens
               - qcom,ipq9574-tsens
           - const: qcom,ipq8074-tsens
 
-- 
2.45.2



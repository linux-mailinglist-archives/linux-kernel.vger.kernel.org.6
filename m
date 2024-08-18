Return-Path: <linux-kernel+bounces-291160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43ABE955E24
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 19:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDA6F1F211A0
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 17:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FCC155A59;
	Sun, 18 Aug 2024 17:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U+Bj/nrs"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769C615572C
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 17:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724002198; cv=none; b=F8PYcQ2tcS3O08wUIsTScKhUYqdDtTF5vjkyac26c0yWyF7GoI5pvcuubtMaDmnbDfnQ+VU4Ta73DB5ejPu16tmp1DYJoFMENCO2P3SrxF+otB7zFbs6dHU/ciN2afId6VENkq7zIMPm8YgeahwMOhIwk4y06qb+RhgNMgExgyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724002198; c=relaxed/simple;
	bh=RQ3Lbz4xnyeSZAdJGZGVBRvmJ4qONoB82rnZnZvCrDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gkr0T68K2JqpaWJZiwQOMkdGcFIHDAKjB6E3kZiQkuS6CJxrz/Nc8XW6Urc5cKKhfih2GzTfCs6waFQQFAd36prpfUDJISSSg7kz6Y69vllKe6hH8kkrbHiyYAsOsVda0UjdEhfqVKu3VW6O+37yu9uiXAgJA+kJYMQSjtrbIxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U+Bj/nrs; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-371b098e699so983071f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 10:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724002195; x=1724606995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KbwvlIVMV8xryLkD19IewQWLhOQT8FXVqlEUYqJE2Z0=;
        b=U+Bj/nrszUnTm/6XBHYONqYtWpiqcZvk6GUJduOo05arwopycosnQBE+NI9x1QUuM6
         FwnShm+tqhUq4pRTRZZwKfeOCKD89H/F7y54JLcNQ4IZZ25jZq2M0RcwRhoLxfHaMiWR
         DZgnp4TF4lCWIUj2b5srTG7NwMp4Xno/NbD9rjDfvmtXiD3sYy4tHcFm2XXTIqVpa8oe
         WpXMKWfoyT5zfE9knXESrFCGSH8estDAvwv3TUF6Tgf4zFOYulEgnACgsDcO8G7RVyri
         CzI6i3vepPydoSR/suRi76n5mmF4Kh8ISvp2WNcSHGkPGC/1HmLpVO4H/DvzGEOvqExq
         PKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724002195; x=1724606995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KbwvlIVMV8xryLkD19IewQWLhOQT8FXVqlEUYqJE2Z0=;
        b=tZMh93AYXz+lj8eARiT/3kBsei6GX4KYBeE6hAcxYC1rA2Aoqd+6zCG+iUcOdV1iyr
         yXMr+eRms27rfanyMxTrfvbsAXo0wGXPxpkrDCpBpnVq4CtxFKegT1nka8ZkpC9ETjAB
         koj/lHWKeMD1WfRXELXxVEM8zjcZFw6g/TJMIIl0NF9tA1ZXoguLu3h25H/4rIet+Pph
         P8xMS6Hadzszrj1ZIPGGxjBzWp3LEF5pVClGJVITf87L/lG6DbLNHHmXNBDwJUXjEv3Q
         McxEaouvKg9i8qVlUGtpMKsxmWdcMtm+PqJUwCrnGUv9hsfWfSC5Vi4pVWu7UaL36hsz
         +rcg==
X-Forwarded-Encrypted: i=1; AJvYcCUVG5JSGf8t3bVhQFu34Q8eJIGI1kOx2LvbrifFx4YqnARiNar2XNyba7Y0I6jkrraUSGSks1l4sPwkFT7ppZVTTF6iJRV8akKRVKf8
X-Gm-Message-State: AOJu0YwTt8jLt58KX0n3EBoT7x5BbHzb/tNjnMroW+FjeBQOcqjQNBNx
	UHhPnTH+CRCkYqikRnXOTQJ7z4dr0zCIp3q3M5Yy2M45g1hSLlWUePBHelJNVX4=
X-Google-Smtp-Source: AGHT+IFp3b5dXt3VaeULNgHqcg4QFbzuh6p5X7dQPwN9gftdTacq8ZYzKU9ZBjnuXrL9t5XVlwI1Bw==
X-Received: by 2002:a5d:5c88:0:b0:371:a92d:8673 with SMTP id ffacd0b85a97d-371a92d87a7mr3528329f8f.44.1724002194776;
        Sun, 18 Aug 2024 10:29:54 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718984c0d0sm8486522f8f.38.2024.08.18.10.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 10:29:54 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: iio: st,stm32-adc: add top-level constraints
Date: Sun, 18 Aug 2024 19:29:51 +0200
Message-ID: <20240818172951.121983-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Properties with variable number of items per each device are expected to
have widest constraints in top-level "properties:" block and further
customized (narrowed) in "if:then:".  Add missing top-level constraints
for clock-names.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
index ec34c48d4878..ef9dcc365eab 100644
--- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
@@ -54,7 +54,9 @@ properties:
           It's not present on stm32f4.
           It's required on stm32h7 and stm32mp1.
 
-  clock-names: true
+  clock-names:
+    minItems: 1
+    maxItems: 2
 
   st,max-clk-rate-hz:
     description:
-- 
2.43.0



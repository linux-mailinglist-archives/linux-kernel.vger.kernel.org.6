Return-Path: <linux-kernel+bounces-573659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EC9A6DA51
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9264E16C890
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0C825EFAD;
	Mon, 24 Mar 2025 12:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UvYKnx3m"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E34D25EFA6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 12:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742820690; cv=none; b=XXcsMIumrTqz39EYVuWps6J+o3S5/6UKm+LET3fqdGZF/Ia4/kjGjvIqiBm2y7WBkCPrJL06baEJXDR8n7pNNjJg50sJwPkNVUhN5YKMy5rN5i8CFAQmg/ryvqI3MFFe+6JMPEivYQCrt/ug0rLMRbSGPrg4oyv5ZTLsxYpaDyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742820690; c=relaxed/simple;
	bh=gJaq8RPqUAN+et8YhiVDjIFuSQejqYIg6fSq5dFj3qg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OEP6vMZSbzYYHdmitrCpXdig/C2iOGSCkoBUH0xstu8qJfTOXTeVqqHLc6EULRfQ9heDM1MtLlIZlv0aOczExKRdHpxHCf8UKeQazMnmzbvkLJjwu71yZsbGs83D5W/gpcU8G8UETrhJF/SZLC20mjt7aa/kllMP1zK42lU3Cfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UvYKnx3m; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-391295490c8so205050f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 05:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742820687; x=1743425487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k+BJ+7THLiliR29tVlkgB3kjwlhmbpdD7FSEPWqRuBI=;
        b=UvYKnx3m7S06dtS+k+vkwr+chxuDcBD+rmSjyyMEIUv+ZUpgqnEr4G5O9qcZUoAHW0
         FU7e6U1IOg24XZQtJ7N5wbrJw9baUvSCFTfXwrejr8oASlzcg6CMI2xeZMOSKqg5vPIl
         W9xgVxu7IVt7e+0tcZ6uf8FH0PU3Fv+v/+DxS7RWcRgKtTp797PTNXJUzv9uWbrZgQ1A
         N0sh4noSDxXzoPpaT5TD7cnXvfsEq6DvCvRQEyB5+51oM5TUJKrUwe8jQ7t/N+NsGcnz
         fm+KDnChpkpkksW+RAAx42kb0rMm9VoCIbTaBTOFgBUnd23bfptyEi8Yy+bdP/Y9mOcL
         xPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742820687; x=1743425487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k+BJ+7THLiliR29tVlkgB3kjwlhmbpdD7FSEPWqRuBI=;
        b=ePBhdIMDh37dblyKVucnRm1KkgMJshJ7F43t2dGlsu2+sfeHzWVHvNNikSY8hBH89y
         r9Zq7zmHswl3lZ8E+iwc7Bjud6DopvKu1wCuZZHc/d9OXDGJHAuMmDTxLrUWO3tT9YTf
         TBvijdyUjBLE1sHJM5T87LOBImgfKzd0CV1U+QDXeFL+lKjC3ebs4DYkHq9jIUL8zmOw
         /Ckkajv6ac9XPQjWYE08bu8YaRwJ6E/EunqnSocRDaQNM1jbx3MKKgixK5NU2uP55cpV
         MTMedQQX1xUl43UsUYdmLpGOtN0p380MsCYZCbjnF1k0BDT9z/xLBLA0KNrwe9NbvG9/
         Jlag==
X-Forwarded-Encrypted: i=1; AJvYcCUzsjQyVHCQ2QwaqQlxm0/siuIQYyGF5MQlkI+bb3GCspGGXEv41NJCj5YfaZRhuGPdA6pmAX8OYLythEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKGYY/Epr44IKWpePFOokgg5L4RCkBbMkynAh6tmGHpoRPCui0
	h97ly8Qm1eYZnSTkOG/PB4vPa4TBHNAzTpFx4npXwWP42bM0DvVgHa8IaH3XMpw=
X-Gm-Gg: ASbGncu+xqV8FGUNcSEZKC0AFfzRVPnXXbVMcPoG4jI/QQZCqOPTsxImjU/Xfjz3wZ5
	U/p0Ax9iBpAYkGdY+Ga4RQ83e1cG57zbUl33+VdqCPEsN6jWKT6HJY59Ik2TQGG3zPG0hdwT5Ae
	yhMoY6G0MqWz/Z5yAkqye/5vZhNOJ8KqGkA/iDl7166UbrgothWggHQpLuiTXVa7s08yEkvyKRl
	p8qpB/3pKbQvD6byHpct3f7cmRTPpu/xPpqIHvGBNDVVZzpQtKvEsb95ml/WCY8J54nZ81HK3kZ
	IIQEgLX8XAYciveL5xn7GvGoM61go/n75aiX0NvUNbzZeslgm+DaJjfC1B9TABKNZasX
X-Google-Smtp-Source: AGHT+IHtbpqb7/yrKBns7JX7jJ+To/S9FySobLcAWSc8zEQ+fAohSakLZvO59BmPMVdFT7bvOMCw6w==
X-Received: by 2002:a5d:5889:0:b0:385:de67:229e with SMTP id ffacd0b85a97d-3997f9487fdmr4124399f8f.11.1742820687355;
        Mon, 24 Mar 2025 05:51:27 -0700 (PDT)
Received: from krzk-bin.. ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a3372sm10769917f8f.21.2025.03.24.05.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 05:51:26 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rodolfo Giometti <giometti@enneenne.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: pps: gpio: Correct indentation and style in DTS example
Date: Mon, 24 Mar 2025 13:51:22 +0100
Message-ID: <20250324125122.81810-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DTS example in the bindings should be indented with 2- or 4-spaces and
aligned with opening '- |', so correct any differences like 3-spaces or
mixtures 2- and 4-spaces in one binding.

No functional changes here, but saves some comments during reviews of
new patches built on existing code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pps/pps-gpio.yaml     | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/pps/pps-gpio.yaml b/Documentation/devicetree/bindings/pps/pps-gpio.yaml
index fd4adfa8d2d4..383a838744eb 100644
--- a/Documentation/devicetree/bindings/pps/pps-gpio.yaml
+++ b/Documentation/devicetree/bindings/pps/pps-gpio.yaml
@@ -36,14 +36,14 @@ additionalProperties: false
 
 examples:
   - |
-      #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/gpio/gpio.h>
 
-      pps {
-          compatible = "pps-gpio";
-          pinctrl-names = "default";
-          pinctrl-0 = <&pinctrl_pps>;
-          gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>;
-          assert-falling-edge;
-          echo-gpios = <&gpio1 27 GPIO_ACTIVE_HIGH>;
-          echo-active-ms = <100>;
-      };
+    pps {
+        compatible = "pps-gpio";
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_pps>;
+        gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>;
+        assert-falling-edge;
+        echo-gpios = <&gpio1 27 GPIO_ACTIVE_HIGH>;
+        echo-active-ms = <100>;
+    };
-- 
2.43.0



Return-Path: <linux-kernel+bounces-550782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 318EEA56410
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E57B53B681D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D872A20D50F;
	Fri,  7 Mar 2025 09:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tuoEXp4M"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8990E20D4E0
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 09:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741339998; cv=none; b=j3+6OQV7YFNkEt0sG3sV4U3IvE8DFsUQ+cc2xw9iqJkrw91M/9XShKZV9r5R0W7JJEQrKorqHW2+vKFCXANMT7JkBAzGSerMW/pFgNv2UxdaPbXQ9o1QDEhiaVnM7b0o/A8bZpDGMmeZQ+LdO5a/9kY2vG9xz9mv33vLyr/xflM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741339998; c=relaxed/simple;
	bh=f6+JfLU/1QFiRs0zJLu13R4ni0sWGfII1CyAkkteBPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LDEzxMdH8GQ7zSa2k/9NlLxhfu/UViQZHaKEgQpRCMTMlAD6CpFHvvRDR6KM5fn5T8x5fjINdRpo1Rd4zC++RYQdGN+fwMDE1yy4Ku6uOgaKEiICHDguTOkfNcJ2lDNVTXy51wSpnyXLOVO/MSfIbYMNRlUlObeCpBX24hJCAm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tuoEXp4M; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e5ea062471so54342a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 01:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741339994; x=1741944794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fU0HHdQ1hyz6Oi/pxgyRXXgGFlp0DgTNlBw/r19mLUE=;
        b=tuoEXp4MCXqWFa33f111JLpTrEcuR0hQ3u7Hli6VAsKF9HK22gpN1o5QTYlGbVK1xt
         CTEH7U7AWV3sRBBhx7/0S3BUjV0JLdYBjGlaJ/6m/wk0PmaA132L/rceatLF+aGxBBvD
         2Wfc4exbDizDs8aCSOftuvqaWJlXbP8WUpg3ZzokiTyJ1gmKqtN8jcs5vbgBSzwkXQhr
         8lQ2CC3PT02tJfzgLQsC8l7y+SDW+PGYeebXE35nOQQ4N3emfxtR/XqhWPTRYKgaYNqN
         vDGhhuXiZkNoyrO2iNJ274EohjgJ6zNSVYuTSf8+bXlq4RgyosAO0RJKjXjXQEYw8qlb
         CrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741339994; x=1741944794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fU0HHdQ1hyz6Oi/pxgyRXXgGFlp0DgTNlBw/r19mLUE=;
        b=svGEzS6mzhW2SCkie1Q+cYTonPSQqIFdYoi6XYKnskSd5F29pnss67W2AKnNlxOJvJ
         B9AhCuwt8MRL2batskBAMhYTvvDL30UJbBMQ4Iae2dqO/6ols4PFRhFfQL8DD9l+/agk
         2TbCm6PF01dIX4eAN7ozs9QV9SkM8kboA0JUhPSIQo4vVR4yjYAGoglAEtyA+qI/bdYI
         K3jPR8TYBn4fBTd9tAJ3xO20g0nUoaZKo4DbvsIRWwLV4ryaSh3kND0MJUw0C1bQ88XB
         9t39m0YGGWgys9UK0lpufwN8J12pt/LWTDJxboDGjXUpqmeMroFNtO587hd/gMFtOo3k
         iSZA==
X-Forwarded-Encrypted: i=1; AJvYcCX2hTbyo0Nin2+O6Aj5VT+j6dL8FwKh9dlfm7PBk1TWnyQeFlcuWHi8Sjein/a+nEdAWrvHUuwlzhmvbU8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw08pxkS7eybVvqjyyUhYGk3L9vn32Nv2qrZOTptt6PzKHluGhB
	fnBsnKAQSaA1ui7kdU2latU2C6lwpQ6PfI7hjv8GIg/LYYG00/Ta56MHm3w3FTk=
X-Gm-Gg: ASbGnctRQhjzhAXEYC2dqDsX/NwHj7px2aYLQXyIuH7rPjrUn/eFTvy/CdGVxdg9B48
	UM1jmXcXRKr9iFZ1sncwpi9xlRkevl6QrsX9aWUTaVWfK9OPqS0iR3+ufplcx1tDDuggAVCDmB5
	ynugdC8Gqr672Uu0qzxChj3O7CfJSPOAq9jlPC/z82ABpT5G5JvE1aV2VuBkYAqQQVP9/DyN1sU
	hr9xFig5b9BoeTzohMVfUN3MZmiMesX5JosstE7Z7p2JTde6ZM2n8C1WaHqa2jEAT/kJzWO+fOa
	AdPG6juyjInt+VhlNsmtU0+U22IUm/lr4Q6ivcvSklgWDvcrg5V01f1XSxQ=
X-Google-Smtp-Source: AGHT+IEAJGcNFFbHug7ITx5iMdjawlkckyUu9cdR2GxHKINK8WVBM4YprSaxysEv0Z5OJYbITLcdkQ==
X-Received: by 2002:a05:6402:51c9:b0:5e5:e17f:22fc with SMTP id 4fb4d7f45d1cf-5e5e22ae3c4mr1030915a12.2.1741339993683;
        Fri, 07 Mar 2025 01:33:13 -0800 (PST)
Received: from krzk-bin.. ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c74a82ecsm2275091a12.37.2025.03.07.01.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 01:33:13 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Daniel Golle <daniel@makrotopia.org>,
	Aurelien Jarno <aurelien@aurel32.net>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] dt-bindings: rng: rockchip,rk3588-rng: Drop unnecessary status from example
Date: Fri,  7 Mar 2025 10:33:09 +0100
Message-ID: <20250307093309.44950-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device nodes are enabled by default, so no need for 'status = "okay"' in
the DTS example.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Drop unnecessary full stop in subject prefix after ':'.
2. Add Rb tag.
---
 Documentation/devicetree/bindings/rng/rockchip,rk3588-rng.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rng/rockchip,rk3588-rng.yaml b/Documentation/devicetree/bindings/rng/rockchip,rk3588-rng.yaml
index 757967212f55..ca71b400bcae 100644
--- a/Documentation/devicetree/bindings/rng/rockchip,rk3588-rng.yaml
+++ b/Documentation/devicetree/bindings/rng/rockchip,rk3588-rng.yaml
@@ -53,7 +53,6 @@ examples:
         interrupts = <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH 0>;
         clocks = <&scmi_clk SCMI_HCLK_SECURE_NS>;
         resets = <&scmi_reset SCMI_SRST_H_TRNG_NS>;
-        status = "okay";
       };
     };
 
-- 
2.43.0



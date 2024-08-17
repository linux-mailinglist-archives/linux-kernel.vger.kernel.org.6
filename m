Return-Path: <linux-kernel+bounces-290651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6779556E0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 11:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CF09B21CB3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 09:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9515149C4D;
	Sat, 17 Aug 2024 09:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rsI63r6i"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC9414601C
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 09:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723887974; cv=none; b=SkkW1HGpssiRUjfyG2M+NJUHuoJiwUnKII5rFWpDFr20COJvFGMLio6PHek3Vaz8gm2+PVbje6xJxW/h3xCSV8gYD0CzxlNaVrHLg50xOFRvP5RuaFZpTtrRWOviMdGBVREXMyBdpzToXmSGWhbret3+T6DP4I1pwtP2OOucfOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723887974; c=relaxed/simple;
	bh=pRB6jjAwbq5n3iepo1Uhq/05UYrGiUHreEyKsYxNTp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sh8HwgD/IKsDvVFm2aBxxUGD7hIOYh/MQpHOhiBYpBBhYo8kCJWLcJFkRFwY/MhVLhdlR4rWLhBZaBktL78SyxlgempLPVJbcAHrzDRr2z6XSHKCZ62suLnG7BiU/hQCc+Mj3PitFVhosR5D8lU1ruHMS1H8v7uhE0nqqPymrB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rsI63r6i; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37196681d3bso878606f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 02:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723887970; x=1724492770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zVDbexPoYK9/xw9F/1lJ7dYaXx4jW1aArgheQ/v7dU=;
        b=rsI63r6ibiosZNGU/I8kIcBh/zEZ21PNwGo3pKUcgsOGZ88EcFAdfc0qxHmanf4qcH
         jQYDaif0tkFZ6YCyodUG86CsE/afSzzuSYfbc45jHc8m+apqfJ0TdczCoGPvptbx7xV0
         dYGbrNTuoS+gXJY80RNNullY0WxGkipIqOATKwrG/4EPN/1cswjip6k6L79OCBZ/GBq9
         fiSJ/HtannoR/Vv6whjL7sW5ymyOObB/uRakIrQTj6XfrKl6MeGX/jQ9DpVKTKDaL9PV
         UT7y5UZAdKOsrXKG87uxeZgrzVGMnnj5AQWNj6tNwBJ2PAHdamJP18jEiP+sC2xjt2Ks
         B/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723887970; x=1724492770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8zVDbexPoYK9/xw9F/1lJ7dYaXx4jW1aArgheQ/v7dU=;
        b=p+L2VkgIOPUc5YA2xkPzDCa+BLr+HMa+dhpOYbL+HO2I8Q5tQBeg4eEb6Y5qu/q+IT
         1KNS3BNEIEotqBccfVGOIIhxUcNKLBOyQzdiGJ8uK19hcViHYEFOyJ7xoCukWah88psr
         ie17jGLU2tx8TsW3PQfOPW4JOpfz47e8PXvAn2mpVmwS5YtBaSnMKwOfBrKwajbFh4Sk
         UWVBwCwaesrXr4kB8o0Ei+lMp691vxOK4micDcnBAt+ox3MJqqHgyAvBeq1DeBjGA0nc
         fk1D0q6/535DbBEqahpbjzIYFlzicZSynsWmgPp6N+QFuAhJXh2ek7VrboWx1ab5tYTc
         pHRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCPNpXTts6X8PiL4+Z2LqATTxrWQ5OW1il4++klRJzZG2euhFzzDmUi5o2B+r0XeQZBn0liMRVhOygm1aI6e2g+4IREekctivNk6Z3
X-Gm-Message-State: AOJu0YyD/fGLlidHdx5lkuGxwunx01lRDuja0cl58MHl8Rpx0PkOB7Zr
	H6lih67pXFEJH3BOSYdJLTqUFTZzgMsMlYRGF0InyQzLP64HEfOK9Cnz/lnnlp8=
X-Google-Smtp-Source: AGHT+IHSZBCNPge3RyrSlkoKALJwN1ic4HFYxJS+brE6Zk7NO3r6FTp8PvLIn6jN3bvzXNHpgupzRg==
X-Received: by 2002:a5d:5102:0:b0:371:7cd1:86ef with SMTP id ffacd0b85a97d-3719464182dmr3810954f8f.22.1723887970354;
        Sat, 17 Aug 2024 02:46:10 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded2931asm97641815e9.17.2024.08.17.02.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 02:46:09 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Taniya Das <quic_tdas@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] dt-bindings: clock: qcom,sc7280-lpasscorecc: add top-level constraints
Date: Sat, 17 Aug 2024 11:46:05 +0200
Message-ID: <20240817094605.27185-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240817094605.27185-1-krzysztof.kozlowski@linaro.org>
References: <20240817094605.27185-1-krzysztof.kozlowski@linaro.org>
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
for reg, clocks and clock-names.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Taniya Das <quic_tdas@quicinc.com>
---
 .../bindings/clock/qcom,sc7280-lpasscorecc.yaml      | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml
index 5e6737c39897..488d63959424 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml
@@ -25,11 +25,17 @@ properties:
       - qcom,sc7280-lpasscorecc
       - qcom,sc7280-lpasshm
 
-  reg: true
+  reg:
+    minItems: 1
+    maxItems: 2
 
-  clocks: true
+  clocks:
+    minItems: 1
+    maxItems: 3
 
-  clock-names: true
+  clock-names:
+    minItems: 1
+    maxItems: 3
 
   '#clock-cells':
     const: 1
-- 
2.43.0



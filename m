Return-Path: <linux-kernel+bounces-276078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0AA948E1F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7903BB21424
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAC41C462C;
	Tue,  6 Aug 2024 11:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wpNbaTNg"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E6D1C3F35
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 11:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722944984; cv=none; b=fEhk3amH8IEcxPQGQJ5pKVUiGc0S6RNCS1sPbGoDF0iieUOEbD/iyfVlTfjWQqyUl676XzGon+oQLQEOr3VPtWt4S1w1nbMmpZLkP1YB52yFDE2eus5Zo2eiRybXhGGKgxO5v2inUUW3W5ohDc1CFPilo0iaZ6L/a7VwM3SSyGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722944984; c=relaxed/simple;
	bh=qAxAXkSzlzsy3YZMDd8hkLWqB7BSzVrCOez5JOG9HB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzR/NcFxxrLavJ2cwISe0I1xaQcUQ5Qb4DPrvP6u8XnOUYe6zTCQm+44O+H27bwbjk9zLMwrsPc53EyGXOf+UchLgRaUwvkmkr52JI4qkS6KyMhBgcK16uEyu9J2hbnUH7uGcd2NFMDAmzwfXWI19Hc7+wJtF24BfbtRBLYx8hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wpNbaTNg; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42817bee9e8so3649495e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 04:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722944981; x=1723549781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+W/spHaH4ZPrFJzwLUAvkjiFq7Yei24v520B0MhGrw=;
        b=wpNbaTNgSFvn4N3OIKPWCOjxoy7EsTRSqCUe99fyKqiJYgBYtf4TFHaHaPciyYWtjx
         bufSOD+BPB5rq5SOlYLNxHQEop/joNiToonuqwsYQ7PldYsukHAYKe1zDzM/W3J1HVmk
         cxDTGC6hiqPP5ZBNFut21NTMSXBe1o1yU4MIhL9aVuDwXAGVdxm3pHR4ukSD2RfSBRii
         K2t/Awvh2i+H63MrknPjaIBLwvtTthd22OsCuMIlmddLui9BvPfGbmcuK/fIYE8k0xv+
         KpWESIRQ6d+7xfP8LYvnQXjCYTsnaamz1mszVJSGPcKaBBlzndvBLTKTaCzuaxfM5u6V
         Vpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722944981; x=1723549781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q+W/spHaH4ZPrFJzwLUAvkjiFq7Yei24v520B0MhGrw=;
        b=sVGJUHJD3kupbI2ifDTQW5ZupRejt/QoULC0ICdX6UL3H6ShZtAS1oPY/qjZ1enpf6
         2PLMi1pwZTrnev5hNosxjXTl6q89oHq7NWB+PcCiH+0TnEcNF3svWixyIWxdPgjRH2WT
         zSiLk7W7XK3PhJiXvzEQhiEBh8fIsrMVPEJyC5zRAM3/70JO55YCIQ2A2Vi8/rsoLYmt
         1ca3ke5m8/VcUlIxJyy8nQuVmMk8svtrDsVp9VPYql5pmrEcQqFt9sw4tAqBO46VBoKE
         lZbpyldeoJemXHQ2p5yvSMn1XoaiFC4AxOfsSMbQNsFB92fLt0M6y4Citx5zxPGbKodX
         nNFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSCr+zl4FejgWgYSSNk/arHkk+mpQf115RTr/hYFISs0xyIWrs4uDwlV9k2FMofyc3P0ilJcBbIsiaG3ytJaVmpo9/O5ZJwL40LXTX
X-Gm-Message-State: AOJu0YyUUwZz9KsOC5j26Qu3C2jGTr0DC1YqrvBZV1kkoAqgtr7h3QDK
	K9VGRj20bwjPhiwJbI0pUxaz1KuiyRKLt001bSNgZvM5Q+7vLVL+yMR06/bqqsc=
X-Google-Smtp-Source: AGHT+IF2nxOVw8Nfp4RadNqv6qJ7oMtw9VFIh5K7+RrZpNtzMo+RT0FI7T/1iBoDUzrE75hfcrLE1Q==
X-Received: by 2002:a05:600c:524c:b0:426:5ef5:bcb1 with SMTP id 5b1f17b1804b1-428e6af80aamr99654155e9.6.1722944980982;
        Tue, 06 Aug 2024 04:49:40 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e0357asm180287485e9.12.2024.08.06.04.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 04:49:40 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/4] ASoC: dt-bindings: qcom,wcd938x: Correct reset GPIO polarity in example
Date: Tue,  6 Aug 2024 13:49:30 +0200
Message-ID: <20240806114931.40090-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240806114931.40090-1-krzysztof.kozlowski@linaro.org>
References: <20240806114931.40090-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reset GPIO of WCD9380/WCD9385 is active low and that's how it is
routed on typical boards, so correct the example DTS to use expected
polarity.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
index cf6c3787adfe..10531350c336 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
@@ -34,9 +34,10 @@ unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
     codec {
         compatible = "qcom,wcd9380-codec";
-        reset-gpios = <&tlmm 32 0>;
+        reset-gpios = <&tlmm 32 GPIO_ACTIVE_LOW>;
         #sound-dai-cells = <1>;
         qcom,tx-device = <&wcd938x_tx>;
         qcom,rx-device = <&wcd938x_rx>;
-- 
2.43.0



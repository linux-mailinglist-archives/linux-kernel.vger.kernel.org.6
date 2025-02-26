Return-Path: <linux-kernel+bounces-533643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 219C4A45D0F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E0D17A5B56
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7E72153C2;
	Wed, 26 Feb 2025 11:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EyQxRAVp"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED288215170
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 11:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740569362; cv=none; b=hulRh9Q/azKXcCAO7qje2rF1vU/kPlj4W5YKUn80RizOJUXsxex0Svhtd2wet6PpkNWyS0MJ3DgS1IXO99355RGNvFKthY5hIM4/EmqUlF3cnD6/1UT10dZzTzAtQItgdEPX3VgkzNn/at2/UVMe38Tge42vS7FmdXE5f7hIkpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740569362; c=relaxed/simple;
	bh=LA0Cvsrq+8BiKo6ol0t+mnrkriJeADHplK/m/Yv3P2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YWf/N8MYoGDpALMEGtVq31BHmRTJDWgdThzG0vtpNZLfAP+cie4aYOljBDBVUjOEVTfN+nwQ+/67wo0REE3hH9TQgsbLVoM9YdH/5bojGqLQkl7KvNNOpAWlqd/lwNDQYf/3Rh4NSkY8nVaKnuH/SxZ8MQ5zqFsVstxRDSHBVsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EyQxRAVp; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5dc5a32c313so1338331a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 03:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740569358; x=1741174158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s/LD16G1ckmo606r8mTAAXLS++qBREtl47/upA6EvrE=;
        b=EyQxRAVpiJvtjEplkmTMnyNi0OwYgp9+GtZo975owiswoF0HcyZnvRlLp+F7riwg6n
         1CiyKJvlIFJomsTktLtqI2sri0+GNrOGbzsf0aYMPKVvo5AtWpazYAIOBOEpAsYCFg9n
         k4kMgDZQqm5GH1CSJ7TXfolA24HgnYvspPm9fj9Jod+nNb21vDjSHXWF3rc/2OCgYIT/
         updspicA2sGDmadm+Ls0Jv7AQBUOR1mitV84/zPBDICn1Q/4S6CYBvtRn+XytM4eJwnX
         POdTCae5J3WqYbiK9rAbfJANUv0jJvMQImg2re299GyQ0TnMCUKR/tp6JWSmdqdxgafa
         1N3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740569358; x=1741174158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/LD16G1ckmo606r8mTAAXLS++qBREtl47/upA6EvrE=;
        b=ZnwN4MY/7QaDlvIoIFzuEg7Rf1uMpa3yfPc56EHRlRg7JW0XUKC2D1UYxKHiQePzXL
         Z4Kl/XWJ+5Bt4sswZHI1MJXaNDCAcElsffMZK59T9Gj4fmJ5j9xeB4rISEq+a2r8pYNr
         fxV3jgSSLxtPedHNNMYONUki1hIlKgAm85Z7xBcAd0YjjgX3PB764QeMzTmN0cPikHAs
         SLWBvrU3znAgg9A0wFPCHIZhfccG3FJQiadDJ/SX4LiSLvUC2giJupNUxME3uUUPDZ9b
         Db1hZ4/klYC0ulvQ3V2Wr+sQojfkXtLG04VAqF2awNPeSnnATK6KbhdS+4eTNUAPTc8N
         xa2A==
X-Forwarded-Encrypted: i=1; AJvYcCVm1++1vtTJrnaQSIcy2trSfAoPfNtTn8di8jS7wVGMcEnF52o7LgFmThC0nbzpP8pBrYD7AXz07ySPpgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhYuJj2zV0AkNzI08eY/NX64RvZOfY6OBs1we3CHfEDhJIzUMB
	xRY4Ils7NJMh4aydwP8tAJEhExv9T8ApnsGWFpmvhupzFBrRNxkewwALrbW3uhw=
X-Gm-Gg: ASbGncsUAkanVyqyAsAcXE2KX0DgcxQyctwIB4PJCHVekXfpQw+lgc6JPThnPU+ScDu
	hCuZ0Jxfd35zI/5orcOwyyHtVZjGHS0D8nb0bCdhC4NEL0vghySbK48l3brV0FFUqP3YTUgUqmt
	/VFp/+eWeZBL+yvv2vyaHfGEPpAQNTvkpXNd9N4jL603gpfn3sMfvArz0IUs1ZsVE9cSyW8+1jm
	WKcRmlrzSc64+P0/yTZFzTlc3veHxlGnXvZ7VD1OYSNUgWPjRRUzZ0klEGmbcXU0z5qJC5/zuWi
	51AaWfmp64HP+I5b7ftyidQPB1VTqMIAfmc7/gdhDZ+w9vS07K/U+WrQr+efKuQNHJYq8Bq0NVc
	=
X-Google-Smtp-Source: AGHT+IEfpVAmUdzqLH8Eb8qd4lEgmjl7ga6R1U3aAJPOZ5WOBG4ayDyk9a/gfYM6yY4U7qdRUnbeng==
X-Received: by 2002:a50:ee19:0:b0:5e4:afaa:8d6a with SMTP id 4fb4d7f45d1cf-5e4afaa8f65mr292393a12.0.1740569358168;
        Wed, 26 Feb 2025 03:29:18 -0800 (PST)
Received: from krzk-bin.. (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e45b7174cesm2610049a12.34.2025.02.26.03.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 03:29:17 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mao Jinlong <quic_jinlmao@quicinc.com>,
	Tao Zhang <quic_taozha@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: coresight: qcom,coresight-tpda: Fix too many 'reg'
Date: Wed, 26 Feb 2025 12:29:13 +0100
Message-ID: <20250226112914.94361-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Binding listed variable number of IO addresses without defining them,
however example DTS code, all in-tree DTS and Linux kernel driver
mention only one address space, so drop the second to make binding
precise and correctly describe the hardware.

Fixes: a8fbe1442c2b ("dt-bindings: arm: Adds CoreSight TPDA hardware definitions")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
index b748cf21a4d7..4539a67d8bf8 100644
--- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
@@ -55,8 +55,7 @@ properties:
       - const: arm,primecell
 
   reg:
-    minItems: 1
-    maxItems: 2
+    maxItems: 1
 
   clocks:
     maxItems: 1
-- 
2.43.0



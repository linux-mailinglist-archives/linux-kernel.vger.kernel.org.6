Return-Path: <linux-kernel+bounces-548498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE85A545A9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7692218837DA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241F420897A;
	Thu,  6 Mar 2025 08:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dMegtc2A"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D202080DA
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 08:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741251538; cv=none; b=WWs3zyGDELIrIMtAlbiayCkmkVTE5y3XPcbrGHSl1Wl49qu9DhsC/jUmcmc0QBoBxrp/9sGhVypgwQ7EaXoPu8zt5rUgwxLau9BWje5ANn7Jm8qNDRf4qoTf7HBx4R0KOJmcxO74MaBaDu52ByktW/kpoKiNAx4OeIsntLwjQP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741251538; c=relaxed/simple;
	bh=h8r+LBE+AI2ozP6h7eTjG3J4/BjLDXG10kpvMQ2oQN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MRbIosG9azvYKWkj49vYuq7kojQilNX4TQDa1a8IZTgfrTaPVk4tF91GnReMoOVYrqEj/z8R8+R2SFWZ/qcXIzSLZtHpDPL1gGiCWQigdSnCsL5HLnp3uSLw04oywVd/Rs1DvpIaRFMFKF5DshmsB1WwCno79jeTVsXnFHW6WXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dMegtc2A; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43bca8cabc8so308735e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 00:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741251535; x=1741856335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hEmsvIcMhwbu7qmMBTCnWlLRUTQP6Sh0jelKQ7eVPQ=;
        b=dMegtc2AgzVA1a5u67kGMZfWNM6Y2LiF3j33GyVUqWf6SkLWzu4w6S46qfUGkDb4GF
         cWglMRcyrJzUohaMbBZgI2jQrruFryCXRNMZSEPpDKcRPtRe7z9eR0SHhaMRP3hvLVT/
         VwWG9bM/xsRGhvR2KP5PGpj36t7Gbn5Z+Y2Yy+mbvhwM44fCQD91Wc0xTis0sz2RC6P0
         gbyauqLKeBK0ke+s81PVqBg9sARw6ShhzqbWGRwmZrKcJgJFwIeplITKA56D0qfBmkwh
         HxqQjjS/cpX4oYOvObL9vJp8pUNdYQdvE9KaYx5rLATq5yaOpguLZ2WYp7uxRY2CvpsZ
         OEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741251535; x=1741856335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8hEmsvIcMhwbu7qmMBTCnWlLRUTQP6Sh0jelKQ7eVPQ=;
        b=C/fGgPq+an9Ikjykecf8MSQJvhJElPFaPnwacF3KqbyYSFgRv0mMlPd6w//VWvrEt9
         nk9TJXnbn2pD50BgdRLsu/rQROCfCY9AVrBvyBzmi9CMGTGzWqtX1J06S5umAqsSxZYB
         XC5gNwV5trlfTp/eS3mW0AkN8TOgBeJNLN68POCv4CT1SL5wiGqa4M/LSMYCjaOLQW+J
         ogFePyyT8wCfHZup157rjhLYcQMb02AIs2OEksoNYDgSgZtRafCTs++ZQ3kH/3tuD1cl
         Gl+qA3YJLCHmw9gFdO6VlHnKrwO9M+dh4S4xd3P/PixYIKZLGnnrlWJSVtRzEBEyCHUS
         ngOg==
X-Forwarded-Encrypted: i=1; AJvYcCW0rpdoydPeKz9itzlpNVAmNDNHi/PoIwULvM/ZBnAFm1wg0o+wh7Iangdl2d8O80e3lIrzXuJJOIMXdC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1jCLfem3t8Qtpgv47Fa7rzFtfrZj/0f7MLp9ThH6dUhQet5sN
	1SOHELRlTa1HN8rdG9igwMNVYZVhxAyaOaYq0HRi1kJL4rRWrqg4r7dk7PtlAFw=
X-Gm-Gg: ASbGncu6tLbk7bpwXr0XFFliCkGNLpTcnhlfnPQBsGpqr+s6PTYXWmrfuHQrCPbRx0B
	xCrCUtp1VJ0I7pQxcxiUfS+/vy54QPjUZ89iXxOsTlKnDrFLtPGrQtx2RjWYh4cBg0zazOM2qBF
	jBcqnyuISU9sQVGLK0mm2ot1mcXe3mWg/NLNB6eneX80zsJzzuCmMdws12p6z3usDrt8DjUBoBZ
	owWxpzd74eJKMm2msR4L95r5oZuXuR1VpIaBzug60frNOS+B6oEtOdxBIKgUZw4VjHwiXtElMI4
	b583OADYnWNwOlPxNQ55NiLhzzfHy/yvaVO3GJThGt7Sed834vm4mzxFpZ0=
X-Google-Smtp-Source: AGHT+IHIwsYxtasUsH7F1cqK4+j6EXhOQvlZn/zl/WS+mfi7XrhQaNW7pJTzxIk7YBr7G3/zWRlTbA==
X-Received: by 2002:a05:600c:b8e:b0:439:90f5:3919 with SMTP id 5b1f17b1804b1-43bd29b66eamr20092285e9.4.1741251535085;
        Thu, 06 Mar 2025 00:58:55 -0800 (PST)
Received: from krzk-bin.. ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8b046dsm13184405e9.5.2025.03.06.00.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 00:58:54 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] dt-bindings: memory-controllers: qcom,ebi2: Enforce child props
Date: Thu,  6 Mar 2025 09:58:49 +0100
Message-ID: <20250306085849.32852-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306085849.32852-1-krzysztof.kozlowski@linaro.org>
References: <20250306085849.32852-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Qualcomm EBI2 peripheral properties were moved from the device schema to
separate "peripheral-props" schema for child node, but the device schema
does not reference the new one.

Reference the peripheral-props schema so the child nodes will be
properly validated from the device schema.

Fixes: 06652f348f28 ("dt-bindings: memory-controllers: qcom,ebi2: Split out child node properties")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Fix for Rob's tree.
---
 .../devicetree/bindings/memory-controllers/qcom,ebi2.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/qcom,ebi2.yaml b/Documentation/devicetree/bindings/memory-controllers/qcom,ebi2.yaml
index 3e6da1ba460e..423d7a75134f 100644
--- a/Documentation/devicetree/bindings/memory-controllers/qcom,ebi2.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/qcom,ebi2.yaml
@@ -104,6 +104,7 @@ required:
 patternProperties:
   "^.*@[0-5],[0-9a-f]+$":
     type: object
+    $ref: mc-peripheral-props.yaml#
     additionalProperties: true
 
 additionalProperties: false
-- 
2.43.0



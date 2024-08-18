Return-Path: <linux-kernel+bounces-291168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CE0955E45
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 19:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DE1F1F212CD
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 17:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED0B156968;
	Sun, 18 Aug 2024 17:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eazQ+PWI"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A5113DB99
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 17:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724002243; cv=none; b=MR6iNoTOfoDmknQy/y58FkmYfcBdrkBh4I5fEwuvIZRzhPRBoQRXMM0ooDvC7Mbuj/rNGEFdW5GeemMOJb9w0/pp9qcDGugPsBctbJIlEqdHY9M+uD0R/BpjTXe/LiEtlgsrmj1bpnpabYvNnOvRbvmJngQ+WF08buKa/yjj5ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724002243; c=relaxed/simple;
	bh=eZxyfFWiOMWgxzgfMrHHDe1GsJVaWTRUphozkk0Nczs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mHn0dIc31vP7rjehIay2YvVJaGx/5IxIuFmTYFW4M9doD3DPqzgh/TLxX24FryJeCuLtyT1JxD1XLps2rBuuupRj7uR6GKNDYMrFDI57QEPQ9jgtFDLFpfiYviaEBoBPFJ5ory8n6KgCxIhLuqDj1n/rSE1pqwqkxIxoQjDbuF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eazQ+PWI; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-428ec6c190eso29576635e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 10:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724002240; x=1724607040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hze/nH6p6tvHNE8D/sjNOf2elLJDjNOnQCuybaofysA=;
        b=eazQ+PWIYMnmwBlJrfEcOpfLDe5cNo+ULi8K5PlMLs6dh8bU/XEgSatDeCsih1oExg
         fdD9ThiPlr+Y/x2Z61dAyRAz/pR6UxOv6DC0oygW1Tcunp/F28YH/bqOBCFICde0Cla+
         N5dE1u/L3CeKQv73AaahpNueMcpJ+YQKoySIxOrgvFDXaFkPoYrVLR8zaRYUKE6iMOrG
         IdqAO7tfdE3RQA3W/CFwBCR/poE9jeJeUlT0wCNAeR/bLv0O6bcnmHIBm3h6iGH+l/wm
         t8rfUhE/2sqXxDfLMFVmjfoBMu0MFwuG7X4LdI59oBxXcqfbln/z99Tojf7C3lPwiAWy
         lAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724002240; x=1724607040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hze/nH6p6tvHNE8D/sjNOf2elLJDjNOnQCuybaofysA=;
        b=psGevktIgiBmmWBJztLTq45viYAYEf8D+nQT79e9WF3fE2dk6PnQeL1cm2wxI3YCjB
         tl/zeuyadIFPRZbSrEEn9Dux6fElvZu80fMcT3cuyA824bxo8RAvXQZmq6jbvc37g2pi
         AWCGYcv3oJoNrb/3bv9sQwLwFh1R1xfR+PfPqpLQ1o2SDvWPJ71H2BKkIgzHL9Hn8yOh
         nwkEF8BEJHOXHmb8+W9MIr52Tyk1YuFEFUiBx/1ry3LKEgN9GYCZzubd+Nhv2bhInfWM
         wUAOjm4ynxqhZgQdZa4/Sr6DWfzxJrcNn1PDPHFaXbRzvgd2jHcoYBLaBOif/0oxJLXX
         ARfw==
X-Forwarded-Encrypted: i=1; AJvYcCU2I4mLGOGBrgaftF2SA0jshCN3TuALKlL5/Hz8gzk0Fdt1uhHLIpQQ1U1eGosl3iaIAu4j/ss8b23yRWzR3+QS3FM84K2/pjsMsTZO
X-Gm-Message-State: AOJu0YyvRlk+OXfaX/PuM7o4Bg576r2wQK27qwRYYz4ga01OvtOUJ6bz
	SszTEhIV/elARioF0tsDeWOunpWil+bQyXSsAZTrGQlpqRmYgohE3ZG4MNv79Hw=
X-Google-Smtp-Source: AGHT+IEHHk1AWmAyr7jcxzOjPyrSWQ9wN+5ntefeNwrp3Cysr3LtJPZ7XWcf0YS+yO+S+WhnHLleiA==
X-Received: by 2002:a05:600c:4683:b0:428:1694:bd8c with SMTP id 5b1f17b1804b1-42aa8276727mr29780845e9.37.1724002240500;
        Sun, 18 Aug 2024 10:30:40 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded1813dsm139020545e9.7.2024.08.18.10.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 10:30:40 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ASoC: dt-bindings: samsung,odroid: drop stale clocks
Date: Sun, 18 Aug 2024 19:30:37 +0200
Message-ID: <20240818173037.122152-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clocks property was present only to allow usage of assigned-clocks in
the sound card node, however in upstream DTS the assigned-clocks were
moved in commit 4afb06afd768 ("ARM: dts: exynos: move assigned-clock*
properties to i2s0 node in Odroid XU4") to respective I2S nodes.  Linux
drivers never parsed "clocks" so it can be safely dropped.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/sound/samsung,odroid.yaml | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/samsung,odroid.yaml b/Documentation/devicetree/bindings/sound/samsung,odroid.yaml
index b77284e3e26a..c3dea852cc8d 100644
--- a/Documentation/devicetree/bindings/sound/samsung,odroid.yaml
+++ b/Documentation/devicetree/bindings/sound/samsung,odroid.yaml
@@ -27,11 +27,6 @@ properties:
       - const: samsung,odroid-xu4-audio
         deprecated: true
 
-  assigned-clock-parents: true
-  assigned-clock-rates: true
-  assigned-clocks: true
-  clocks: true
-
   cpu:
     type: object
     additionalProperties: false
-- 
2.43.0



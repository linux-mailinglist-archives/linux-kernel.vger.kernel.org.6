Return-Path: <linux-kernel+bounces-291147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 062BC955DEA
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 19:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CC4E1C2091E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 17:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659B114EC5D;
	Sun, 18 Aug 2024 17:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kC74FAqC"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055B71494D8
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 17:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724002115; cv=none; b=trHOrQ6gPsiBR7ASBKMq5vnvOcAGAj3HGslfP32zMV9m5LJZOFCJOHdy8zDXcPkHHaV39PSMbuJQ/UnvPNxb0Sacq18Fgq8rjgCWZQw5jcpI8DG268ops4TZEU9keE35wPVFjz4RuVSFlX/jaBu0oMtAJutuBd+wzNWvb0W95zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724002115; c=relaxed/simple;
	bh=DSttWqv0bdCkTXjJqadvLEmUQxn6lDGfY+pACtAw5SM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SymiHPcl2dkuPJTDHLMaHdqcDy0IkLIgh30z3oy9wAIPbsDK7Lw4UjZ5CBLzypRFYsRWTmkEsKy/+kFIQV2hFEA426VztkKZ5Wfwi3MTqYZ6hebuYvEU9cq8Z8WqmQBlfUbCV4GC2evBg8OOihA6kuPYTnzOPI4xllU2JRvwG74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kC74FAqC; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-428e1915e18so26291125e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 10:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724002112; x=1724606912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S5pLu2Iv0yKyRrnfssfZZOgkRQEo8dv+goTKpDYttcY=;
        b=kC74FAqCQwR9ZG6FWbo/cywvg4+7lnSnvB7YwSERFw6p2UMwXize89lpVePbmdCMqL
         cFsteHf5uie8AZLLjS3AiOblREPi1Siujz+b5karRYDLAmd/mTmRG7o9kWgtD8psy2Xw
         fCY1EVyCtcMvZgQDjW1H6GbbJqeEWfn6AWZj2JW9KA0Gb/CZGI2cQLYfJtl9R1x7b/qr
         FE/ipAVpR+UnaLdAnFfDql/twsnc8wSVOwDJipmazcMbiY2NpF3jT5xx+TNGWVXFVPqX
         f2rpw7b1o1B2MMQpYl+ZBImnkLmroezfxCQ3ZsqOQ8lWaTQoWElTuXIqu4oMxdJ3lseu
         Zlcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724002112; x=1724606912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S5pLu2Iv0yKyRrnfssfZZOgkRQEo8dv+goTKpDYttcY=;
        b=C1Ftv8s4YfsR5Umu/OcisDIjl15lqFD5qocZlOUNKLdIKZL/PCUYdZzdFVPl7mML+x
         KXb2QtQgK1uKkKQAtnD2zs93VERyI+LmYWNZKROnk46nuf8cw8dQIDfFmjWW5+3kZF+J
         fGA7/bbwWenO1kLWCkucdXXhatoGTzP129YbZfWX5Zw3gNoFr1q80trkPSPu4A/tkFL8
         3mGrPc/LzAmhiibqrt/6Ql9Te6tFSVs6c5dVc5I8SB2F9okQWhTunU2uS2jQvWWRGKM6
         zKkNdssjioiEO1bCWJyis3JFpYfTk4rmH/hD0M18bUvexiK63zOnwL49dab/UkudCoTq
         cEKg==
X-Forwarded-Encrypted: i=1; AJvYcCWXkdvH0mRCO0g8AjHxmDMFHb2TP9QiUm5YUnW9kgpZttU2zfZOQG6d1ZwcezVcek3AoI58oeYj9mTK1JQohQWPPyzSIt9yNA+L5jwA
X-Gm-Message-State: AOJu0Yy727f4Gu8tyAUDttxnAt1nqPZnV2NcOQ0CAEvFF6XWZJygSb6Z
	xErbSs9zchelSOteQCbmVPbx12hccerqLnccc3xNxrT9PGjIp2CZmtz36S5CgZhM+SzlqSanjXz
	m
X-Google-Smtp-Source: AGHT+IEVPKW8NFr4apEXYCDi/aSn78seRkFOK180J1AgxIymjMjMAiL42xXHAHwLI5c8YizLkhZW2A==
X-Received: by 2002:a05:600c:45ca:b0:426:62c6:4341 with SMTP id 5b1f17b1804b1-429ed7c150fmr69488315e9.20.1724002112105;
        Sun, 18 Aug 2024 10:28:32 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed658651sm82979875e9.26.2024.08.18.10.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 10:28:31 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: pwm: allwinner,sun4i-a10-pwm: add top-level constraints
Date: Sun, 18 Aug 2024 19:28:28 +0200
Message-ID: <20240818172828.121728-1-krzysztof.kozlowski@linaro.org>
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
 .../devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
index 66e400f2a3a4..1b192e197b11 100644
--- a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
@@ -46,10 +46,11 @@ properties:
       - description: Module Clock
       - description: Bus Clock
 
-  # Even though it only applies to subschemas under the conditionals,
-  # not listing them here will trigger a warning because of the
-  # additionalsProperties set to false.
-  clock-names: true
+  clock-names:
+    minItems: 1
+    items:
+      - const: mod
+      - const: bus
 
   resets:
     maxItems: 1
-- 
2.43.0



Return-Path: <linux-kernel+bounces-291155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83974955E11
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 19:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 180A7B21372
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 17:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E2C157468;
	Sun, 18 Aug 2024 17:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cu5/pbPB"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89F815687D
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 17:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724002159; cv=none; b=MU4upis8V95DEfs0OIyBPO7QJEloDdq8nCuztHZDAb5Ecr5R56vUiSXNbRJTlZlO+vnHoebAJMiHzqZleuQ5eU6PTtUfUZ9mBK0mppfQqhpMlE/fwIIpHTuuU2B86oEFDQw4pWXd8Wh1krzUMY/jGkrmz27ofyI+Vom0XP9184c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724002159; c=relaxed/simple;
	bh=u3LI4Mk7eTmteZbd26ULN0NFsDdnlkh5zLeBBwZf8GU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KET/64z4Pp4XY4VRmL1D6PXkrreCPurMylbWY6Fg4H2H56PD9NANkcPwIayXMDp1lngDuspAW7/5jD4cwrQhXvpoBwe7fdV/mgrgyDO/SLAhd5ia/PfCYVmZr3m0lJilkXF8b+/kaNHXveCvIE23YSHZ4lGvuJr2NWBzCSbJnUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cu5/pbPB; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3719753d365so1551618f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 10:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724002156; x=1724606956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8es/l2u9z7YHRxm+My9mNPpeISEV38hkj5XsiYsgUE=;
        b=Cu5/pbPB56Y3jYuYGzHZZFEG0lj0CJRvLUAjT5KRhGsLQs8ost3dBuxbf1+MnraAAg
         Ur6KCrmmlpowZIAsL8w19BVI/b6+dhTL6KavtF+F+Y35wRJ8TLQ/1QeWVNohrzX4K/ty
         UPGYc7Fl44DgG8fSFHSnERcRw9STLfMRogyxFRYs+XMu4d2W2b4p5wvPK+7DMuOOq3EO
         Qj4m48MpGGzc+E9ddKiuCzEtRdl5vhftALOu1p6Qn8MQZCxPAvwpUjNQ76BrJcrGYHSh
         RF7CmnN14yTkB0U474N9DUCjsDzdKmvfyCUQ0T1zmH4xvw8CWC4+zB2plKjA8xXiGgMZ
         xSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724002156; x=1724606956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8es/l2u9z7YHRxm+My9mNPpeISEV38hkj5XsiYsgUE=;
        b=DqeZxCQQjH4mhwaTG6SiAi8Bwq3q6q81Q1ZVgfJYLWuMmvZ9FKQc8b6S1ZEgTJtxE/
         vwWdKYnc3jN2TQSLNoAMpqaRud+xbytjIgHP3QHNcjWa9Aco2SMr3GHHLhvJECYXCPnu
         LZLh6+SdEgyLY6tKWKP6zuQ5i9NAjsYFkR11B6y9NGaJEfEjWpkVPI33PZnEgXnkLsUz
         PZs3ZoT/+nQJKyohjEzgC68ZbbzATtyGIM2HqE17DdDW3ZSlshBiBkQW9PAic2mIfY85
         k6Q1H4oOlmH6zXV+kR3xiwRjhg1KbLTcvj8HoU2EICZ7ma5rd+mvWP32ANdP3RexLKsb
         rSow==
X-Forwarded-Encrypted: i=1; AJvYcCXA2Gduoe3nUQAdLhchiZJSi0Bls+YLzrnxbQ9pjtyDzBvMRadN62cyatDzRw8nXoolSlQHFP3/tDGbLWTikoh+dtU/yWbd9/jDuBKz
X-Gm-Message-State: AOJu0YwRmZQ39dsHXVR1No25hGshmRo1pz/A8y6PhTJnH3ahSEWTQ+yI
	vMhk44dCzEq+R3u9IGZayIA3sDV/vU7ip7iFWsJod2URj1eY6Wjw4ke574kTj3k=
X-Google-Smtp-Source: AGHT+IGDihqENsu32+YwhVnlSe0afwAWIr3NedxRFUFDhgEflC/5EBBcl/lZ8aHqbdVFXfdVdizpFQ==
X-Received: by 2002:a5d:4f0f:0:b0:362:8201:fa3 with SMTP id ffacd0b85a97d-3719465e8a6mr7100101f8f.34.1724002156139;
        Sun, 18 Aug 2024 10:29:16 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718985a35fsm8510315f8f.59.2024.08.18.10.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 10:29:15 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	Sergei Shtylyov <sergei.shtylyov@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next 4/4] dt-bindings: net: socionext,uniphier-ave4: add top-level constraints
Date: Sun, 18 Aug 2024 19:29:05 +0200
Message-ID: <20240818172905.121829-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240818172905.121829-1-krzysztof.kozlowski@linaro.org>
References: <20240818172905.121829-1-krzysztof.kozlowski@linaro.org>
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
for clock-names and reset-names.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/net/socionext,uniphier-ave4.yaml  | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/socionext,uniphier-ave4.yaml b/Documentation/devicetree/bindings/net/socionext,uniphier-ave4.yaml
index b0ebcef6801c..4eb63b303cff 100644
--- a/Documentation/devicetree/bindings/net/socionext,uniphier-ave4.yaml
+++ b/Documentation/devicetree/bindings/net/socionext,uniphier-ave4.yaml
@@ -41,13 +41,17 @@ properties:
     minItems: 1
     maxItems: 4
 
-  clock-names: true
+  clock-names:
+    minItems: 1
+    maxItems: 4
 
   resets:
     minItems: 1
     maxItems: 2
 
-  reset-names: true
+  reset-names:
+    minItems: 1
+    maxItems: 2
 
   socionext,syscon-phy-mode:
     $ref: /schemas/types.yaml#/definitions/phandle-array
-- 
2.43.0



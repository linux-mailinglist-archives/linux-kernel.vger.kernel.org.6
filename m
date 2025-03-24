Return-Path: <linux-kernel+bounces-573660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B31C0A6DA53
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F3E316CF5D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D3E25F781;
	Mon, 24 Mar 2025 12:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h0UJEf2i"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2AD25EFBA
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 12:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742820702; cv=none; b=J34X7ZxlPYODtUHuDMpTUZ6nv8H2EjaeWzoHhP7rzvYs6sQytZMcaNAlBi/UAwV8JeeWF71WMWZVQm+zIbUQwA+Ta/tqPUxggVPvwdsRQT2jEeQ6qQXsuTift2Fp2pEoLW6+NgUdq4Eai8HpHvNK0UouG/8zGJ30DDFpc0KDp8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742820702; c=relaxed/simple;
	bh=7kIvTq8/90tuJI0ossbD6JrK6jg28QkHXDUN+Mt1w5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OxpCYjMbe8Wl5eUlbMJprGZwlC7c+2dkPJ461YiqLkHXA/U1DZPjXzKll2INE22bkxjuYZ3msXAgLrwRkLWTLxL4Igm2n4wNKkaFVdGmJdhk+MOnBbQ/lVBkpTsiX802FYA6mSDNF8sbkbjQmoKUORcA1amrejNPqtIwP/4gA6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h0UJEf2i; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43d16a01deaso1635635e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 05:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742820699; x=1743425499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HH2nVWiRSh3C8d+9des+5Ue4QF8h0ddGAB6W0heB+v0=;
        b=h0UJEf2inqoLg6VnD/svxPMEEL/6IX9rXkQ/wTS0rTLrzXlJWWCe4IqgDj/7wMyCMO
         VYHz87KNc6xZ2DzqUfYUOyqDPlwKBOWPqrzFUIIUDohxw74H4t+iwMjeaIdYls/f+CTn
         Tj6sLYhG8zewhMlQC794vUC38IS1+WCVPdwqKE1oMCVcUHu33XNuuYsUFbxr6b7CSHxJ
         DSnCbJHUpG4gEogMEgBR8WE0LsJXWNROADfsihlI38TyAsp6LyOol9GIGUSj/2ldFukp
         BWp+1fClEJHIafOtfI6lcAoKAcnLkp0S8mbxc9poL8h4EL3U4to1X2bdJRS2MijjBh2Y
         xYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742820699; x=1743425499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HH2nVWiRSh3C8d+9des+5Ue4QF8h0ddGAB6W0heB+v0=;
        b=NRdamTrXdAyULKfqgai0SJABWQkUSyucstX7WCl2j2DQyd8uqcRqCp1MCVLhuIMj1g
         uwLillPNxETp3ZgHm7xQGTth6rkzHOk+/BX/sTTjox0CtyxqdudYCdGLH3gng7kOtGZq
         ad4Xqley1uLV0pNz4nE/i/9GTqkvKZpu/D1KRoCG8bmkwPUmGrBk1Eu8Mx6PL9xsyKB1
         EGL4H87uvSJUZkGgP7lY8QTHBGx6AfQiTdjLFWUgiPgWxWYHbdkHB383qo9mkCsG5Atg
         vbwjfk0ukiNteElwPypnaF+215nBMKSd75cODZaqKnbyYQOcAYOrTM4opnUzqvT6omeV
         iMfQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9t6XFytgXGposskyWQPclnYQdAp1B95Luhc8FDkQz7/ibmmWFrlTj84hVQJVtqBYVmgSFqUOkNNiieyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxplL+lqwHpHUsEQhRVnjYJDUrdyWDIpSBPPa3hq01+q+uLmALG
	Hm5cZPLBAFwLuozICYLUIZipkWHJ2iBchk8sv+jvMzPjBVdLL4Y7Xy1QSDglkns=
X-Gm-Gg: ASbGncvG27JbGWTWzLOlMk5SnnLywK+58fYGigjvEVelGoQt1dc6PwK1gykhV4/F4NT
	yP0wWzeUZM4vMOWsh9OhUm4Or4SzAoDRA4zu+MWczv0+DC1Y9Wupfx/KoCiPteBmr0YMIyaR+yN
	s+nymAfXP98cVAq8+vvFhZEAerWGo5j98enj2zKhCpBmWGMDL2pCdKEj9Wn+U3x2UhCoA5reJL6
	5TgJiCvhAPHZqfAnpj2i2NbkzqpWBAUU5gr3hrQA4FYzg6sfshSfZSrY0xWqYhi87pJXlTovngB
	fBRTfWItT7yivGPVG9ZcPzv6MXVJGWahHSXmE7IIa9tZ3hOoOOvzXgFYMg==
X-Google-Smtp-Source: AGHT+IET4L7ay6BiqJ5c/HRaROSkcjTOjOcbxJ1/qWXG9QvpA45PLADqwGvdOQ4N9AD2IEKf1fUd2w==
X-Received: by 2002:a05:600c:3494:b0:43b:c825:6cde with SMTP id 5b1f17b1804b1-43d50a1d20bmr45138235e9.3.1742820699040;
        Mon, 24 Mar 2025 05:51:39 -0700 (PDT)
Received: from krzk-bin.. ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f32fb3sm171222655e9.2.2025.03.24.05.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 05:51:38 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ryan Lee <ryans.lee@maximintegrated.com>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ASoC: dt-bindings: maxim,max98925: Fix include placement in DTS example
Date: Mon, 24 Mar 2025 13:51:31 +0100
Message-ID: <20250324125131.81867-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Coding style and common logic dictates that headers should not be
included in device nodes.  No functional impact.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/sound/maxim,max98925.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/maxim,max98925.yaml b/Documentation/devicetree/bindings/sound/maxim,max98925.yaml
index 32fd86204a7a..121e8d2d44da 100644
--- a/Documentation/devicetree/bindings/sound/maxim,max98925.yaml
+++ b/Documentation/devicetree/bindings/sound/maxim,max98925.yaml
@@ -77,11 +77,11 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
     i2c {
         #address-cells = <1>;
         #size-cells = <0>;
 
-        #include <dt-bindings/gpio/gpio.h>
         audio-codec@3a {
             compatible = "maxim,max98927";
             reg = <0x3a>;
-- 
2.43.0



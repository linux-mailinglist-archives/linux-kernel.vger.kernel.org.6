Return-Path: <linux-kernel+bounces-369490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BB19A1DF6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73EF61C21204
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C0A1D89FD;
	Thu, 17 Oct 2024 09:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u7Hf8xom"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CF01D88AD
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729156497; cv=none; b=HgSPGTmoxwXwz9oIk2OOsK3J5w9baCRzzgH4wEGzkQRGtWtRkM43V3r42loPSNM5JQBCQIGc3WPKkpixZ/VFoTR7OcC1wmpjx4zf81qIqrnKhsErAbTl0+zttx8PUkLcmmR5bMgnsSkZLj8bfBtGLvpYV7Ei7EGr3Cp2evSHLYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729156497; c=relaxed/simple;
	bh=OFUTbt01W57UIzbwt1gpTo3z57X1onq8v0mSZ7fvckY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i9Ml/n7xYsLJgr7zOJSqYd+SKv1cNdMyE0F1WjpC1+pnuFjk8SfcHU8HYdt985bo0+hF5DJuLYYiYzVX5JRALsHx7wKess58F1ZykNf1j/NEZ2sCBSp8lukKM72IkgtwyLzBlRIzlcDJqxcUW/tMsG20qpQTO8XX1hAkY0Y7npc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u7Hf8xom; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d4dbb4a89so81796f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 02:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729156491; x=1729761291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=++RZvUSYm5I0ITBIr1eDkKq7SHCu0gvOfmRf7dj2AKQ=;
        b=u7Hf8xomKotgv0K6Fe8eh3K8uKgYJe6IPo2CeDagYQ7YEjDyr8xgodIbfm0TLWzFAS
         Lv/fpAWDjqWiIMFszWM1LbSw5UuJC5FYIzDH7oBi8A8XM+oXm1rJqs9x1nwJEsaI9gFg
         SDpxmIBPseOtyr0WzxiO1eutKE5ookgrfpm9/weh36PBHo8Ib6DVS4l0SuGxA/3WTav3
         +JC3ScPIgoN+ws94VseMSKXepFB+0QRYK9ZSki/cXtfbIIHmnmJ+VwyHoUJiFvexEAZY
         wYY5apiXZ5t2dKUQSdcvQwmhx1WG0/VuZevbIuZ5ZQEepwxT7BWBTkoiY+DdtBfLP2/h
         yyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729156491; x=1729761291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=++RZvUSYm5I0ITBIr1eDkKq7SHCu0gvOfmRf7dj2AKQ=;
        b=kXTkn5pm6lpedI2ySE5QLw+hk8ZyN8Z6Qqk3BUAHx0syjKKrZaOqXyx2c7rsannP7u
         u4am3TDdnOAPN9hLMzn5bqxzCWqK8LbtoM3k16OpEP33XigOK9LZB7SZbOekMbS92A0Z
         iXXFtbe/d2poflPY90NsxyJ2IwlLmvMFsJzAQeNDcNNqCmiYzf9XSaTKGMUMxlVHJoaw
         kq77ms0BfEN0vwUKaPG/Axxeox/J0lIthiw7G3lpTRStpfyimXRoM+C24c4OGap6QeEE
         OFJ4Tn8fEdlwYF1Lhf/9baN9mA8t4cRkGrwd9605v3E8+ei5whGo7mzBUvzF8jU1v886
         GKmQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5NjMIz3XhmZ54MfMiC8O1iV8smGGXlMUpKpN32SlYOPrxZ9BgNwibDqOOZcZAgOVWRUeCBj4x1wl5y0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YypZbUZsk9vEJBuH+9MSVPcfYO1EOIDsChAQ6+rrAkTQ2FydGdr
	KNW/bWaspR+liWlb+5rVZcc5U2BBBd2XdTwVp4Oy71rRPP+bRcFgWcm8JgWJkGs=
X-Google-Smtp-Source: AGHT+IEE02ekLjm8TbPP6kTm+oXFzkRyX+nHueXutR7x0HjMCzdjaSTpWmIK7+MmtHTpAANlj6Cbrw==
X-Received: by 2002:a5d:47a6:0:b0:37d:4517:acfb with SMTP id ffacd0b85a97d-37d936999e4mr953956f8f.2.1729156491016;
        Thu, 17 Oct 2024 02:14:51 -0700 (PDT)
Received: from krzk-bin.. ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa8778csm6614252f8f.25.2024.10.17.02.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 02:14:50 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Jassi Brar <jassisinghbrar@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: mailbox: qcom,apcs-kpss-global: correct expected clocks for fallbacks
Date: Thu, 17 Oct 2024 11:14:47 +0200
Message-ID: <20241017091447.41450-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 1e9cb7e007dc ("dt-bindings: mailbox: qcom,apcs-kpss-global: use
fallbacks") and commit 34d8775a0edc ("dt-bindings: mailbox:
qcom,apcs-kpss-global: use fallbacks for few variants") added fallbacks
to few existing compatibles.  Neither devices with these existing
compatibles nor devices using fallbacks alone, have clocks, so the
"if:then:" block defining this constrain should be written as
"contains:".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/mailbox/qcom,apcs-kpss-global.yaml     | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
index 982c741e6225..9d2dfd85b207 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
@@ -165,12 +165,13 @@ allOf:
   - if:
       properties:
         compatible:
-          enum:
-            - qcom,msm8953-apcs-kpss-global
-            - qcom,msm8994-apcs-kpss-global
-            - qcom,msm8996-apcs-hmss-global
-            - qcom,qcm2290-apcs-hmss-global
-            - qcom,sdm845-apss-shared
+          contains:
+            enum:
+              - qcom,msm8953-apcs-kpss-global
+              - qcom,msm8994-apcs-kpss-global
+              - qcom,msm8996-apcs-hmss-global
+              - qcom,qcm2290-apcs-hmss-global
+              - qcom,sdm845-apss-shared
     then:
       properties:
         clocks: false
-- 
2.43.0



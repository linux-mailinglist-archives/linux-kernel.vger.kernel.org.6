Return-Path: <linux-kernel+bounces-232253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0A591A5CC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 13:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B656D1F21716
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 11:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399F914F11C;
	Thu, 27 Jun 2024 11:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AuYlUhhS"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B074500C
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 11:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719489363; cv=none; b=CBANh2jWRUay7NF5eznj2BwKBTB0bLhn1/0j3EzQt7AeoJLi/Ije2AjlVLUvHG03FapvB4pvjjLdVRTJL7NiE9TG5YKIlTSznMdKtgPvLV3c0PHTI7DrbfE1EfWaWOI/Ikcq6fpOFllIJVj+lMy1uVLOG1pcyVGSiHBr5vZRofI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719489363; c=relaxed/simple;
	bh=O85SbDxixdkAuJ/rOhbynhMI7K+2tLwJVFvzLIEa4dU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O9wjE84owhoNMwNRZTW8olUd5fx0qitWYCoYU9VCkSIiD8nxeNwp1bHoX+Fy9KgB144QxelNAP7tc/rM4S2dB15PTPsUYSYXf83YgcabsDzfWxngABmGvX+8WD0g5/DB9Vjs4JU8EUq7n9XVfBXvniz44e4Wsn+9okOuYF+Mc04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AuYlUhhS; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3674e1931b7so240739f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 04:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719489360; x=1720094160; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CMZBr+sbQUIlIpJSUfbM5OlpXtb2wUsqZczwBcVbFkk=;
        b=AuYlUhhS4PiX2YfQ7HSy25yBVBMecFWbqBe3gqfbxSAu9iMW1PTG3QCET4q2N7UWRa
         cMqbWQ0X3HI4PHpcTG9grEXbjAhEfxLloJINzRzrn/K5i8i8pwdsxSnNjdBwLK0iafHb
         HUitc02EqQ8tEjkRbOxz1QvOUV1AsP+LrDXFRivgybDuURaxrsOoRt9trkdCiVATiVY6
         02+5evdaneDaJoxZSktsMliw1fGOsWgrEgvk+/e40EOOOcj4/BH0/hVt+/CsQjN5W5Hf
         Ro4wY3s/pQjTAeKLSG2AMlj9VZCrzKfzr6CTiUU55wfcNGVU0hOqY1dCVTxXa7a89kmZ
         nhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719489360; x=1720094160;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMZBr+sbQUIlIpJSUfbM5OlpXtb2wUsqZczwBcVbFkk=;
        b=tqFoE9QFuu25KJVrtz+dQX3kOQ7tC+YZLr1G5RDLSjINSTPSbCZnxCTK4QYsKgMb+b
         QTWA8fHJibgx9oOHVezKDtIAz9YKDcxDGvr3Za2+ajBLqX0ymbA4uifAkOUDX3mfcLFv
         HsulwZ8PwhRSd/14TGkZqJ89H0HFeJLFBXmfB/5/cG5hxCUFO9p3v2BtPh7wXgD69YBG
         FfTr3nggynG3hxQFEe+6PaCkIsTtIIM+V+o/GcYgBJO3R3iXrTXWMWMUAoQ3gAh9tGvv
         5z3ib/BS9SaFDBoQEMzE3WHMysny64UWZ+tQ1cCjISq5UzsnFHPSGAV3bqG/tOTq26BI
         Apmg==
X-Forwarded-Encrypted: i=1; AJvYcCWyaz21wQWTBu91wvXWdbGLtyit7n316eH3wvMAYH4P6fKyNY4X1Utd53QXZJTpvImPN4g8aozIYRhn0nPYLo7MXQIixdOv7gFMhrEl
X-Gm-Message-State: AOJu0Yxp7whMnjGbqmlaZ64nCdpdBsNOw8/JfFQ2ASmaEOO263HJ4Ltf
	t1mtRlgTP2jGIv0Bu4RVu0VlBzd+u5dLp71gu3JaogoxlA3GE+mChdW8V4VmEPM=
X-Google-Smtp-Source: AGHT+IEajDfDHrlmCEHYVoCWsrnXSLEqnz7GdWm9eBlB0wFqTWu4cSRsvyee0ui/6XBlSKjTXD4FpQ==
X-Received: by 2002:a5d:5384:0:b0:367:3fdd:632f with SMTP id ffacd0b85a97d-3673fdd6404mr1795626f8f.67.1719489360162;
        Thu, 27 Jun 2024 04:56:00 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3674369980asm1597552f8f.80.2024.06.27.04.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 04:55:59 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
Date: Thu, 27 Jun 2024 12:55:17 +0100
Subject: [PATCH 1/6] ASoC: dt-bindings: wsa883x: Document port mapping
 property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-port-map-v1-1-bd8987d2b332@linaro.org>
References: <20240626-port-map-v1-0-bd8987d2b332@linaro.org>
In-Reply-To: <20240626-port-map-v1-0-bd8987d2b332@linaro.org>
To: Banajit Goswami <bgoswami@quicinc.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Manikantan R <quic_manrav@quicinc.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1214;
 i=srinivas.kandagatla@linaro.org; h=from:subject:message-id;
 bh=wrRMEFdk/eFRVK+n/GMcDMkDXGS6UAX+Cl/VfV6o65k=;
 b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmfVNNk8LDQuSewymFkeGedy5XR8KOApyhZg6lR
 bMky0gHUa2JATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZn1TTQAKCRB6of1ZxzRV
 N//KB/9mQ5/GXzpPGZa50BDdqSUPYiXgHhNgIyh+W9yQfxvAWyH9Y7JEeNosJUzEUOzSbEIcUs+
 NqU+0SZSlPJ7dyPSZZp97eCtYFjRrAOmXB43HPpBgu0Ntgqum3Al4cLE9oDqRMJM2Hvpx+fAEt4
 3Hwd2HCfPl51bCjiGJffrYkxfwDVSlClbgLPWuzAP/rYgKWfkHhXvpSMJ35wXXHhr/1Mth5nbAh
 bjC32OTACEqJwhXnGgONN2cZoonXj9xvWmfqOz2UMr8xg5lPbg3PyxPwB2ZX68pUOXE/EYJ8NJ6
 446xN9BEvoA55S8Nv917NtXIMehL8d6jcZ/RFI1RACl8CqaM
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp;
 fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6

From: Manikantan R <quic_manrav@quicinc.com>

Document port mapping property for wsa883x. Port mapping is required
to be able map correct master ports for VI feedback.

All the device ports are not mapped in same order as master ports, so
there is a need for having static port mapping for WSA codecs.

Signed-off-by: Manikantan R <quic_manrav@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/sound/qcom,wsa883x.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,wsa883x.yaml b/Documentation/devicetree/bindings/sound/qcom,wsa883x.yaml
index 8e462cdf0018..14d312f9c345 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wsa883x.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,wsa883x.yaml
@@ -32,6 +32,14 @@ properties:
   vdd-supply:
     description: VDD Supply for the Codec
 
+  qcom,port-mapping:
+    description: |
+      Specifies static port mapping between slave and master ports.
+      In the order of slave port index.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 4
+    maxItems: 4
+
   '#thermal-sensor-cells':
     const: 0
 

-- 
2.25.1



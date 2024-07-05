Return-Path: <linux-kernel+bounces-242054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E87D92831E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AC97B25B35
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAB0145B3F;
	Fri,  5 Jul 2024 07:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UNVkzE/j"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0511465A0
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 07:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165756; cv=none; b=lEaJUK8U1+EXwcpy0KSJOVRDhKd1MATebX/GOxSui24jKdK+f3WpS4fiXYhxbvEGvoQiyl9NdQS4g3eOWcrQWARHYXFSAjcvY4p86eqfT4WmWyWS6CFqBFV71ffGN/46no3/w6ZNmEQmGvZTCHtWE+HjQ27P8Y9dqT07cAM13AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165756; c=relaxed/simple;
	bh=GxSXhbfQyJ+StvjIptXu26VU8MlnrccMSDjcQCPLuf0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zsh76nfnLRT6SPB9O7ROEuvvIZPyO+pVsVJWf4HLM6vlCsxJ+l9PKsspcHdQd1Ml6bE7diR/FjHjK0jUJjvFEzVoZwNLkIud3A1soqdnfMRFWIkcZP8t01vCfpSU9Gw0ItSR92LWKVXdLk1rsmVkOaDJYRb+OPWNeClmmLv9KPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UNVkzE/j; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42565670e20so14957455e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 00:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720165753; x=1720770553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmzAVFFw5D08+uA91hfZb9Q9HqDSR2WAdM+Ft2fb7zk=;
        b=UNVkzE/jJ1BlYR+6LAmvO3XPRs5PAS7pbyilzPSxMmbn59k5dedMGY8nAaDIyxHGuB
         Le212IfSeleKe69dO+cha659HPMFEOjU/W8qqmPvzJ7IEfuim99s5tY3tXlZ892TSgl3
         Hy178J2Hb2uOYqdNmYrBhys7uTCq8bSWnyMRo402grTJE2vCR+hPa63ZpNGXxiaeZ4Cl
         DZQHWgVBltF84lDmGpLPzfONVJPeKSSOedFlaRc5jKpXPQHCm/YO0ImLbO2sx9I/zuFI
         cKj/XVt7ApEDKVHzny7XnG9Hd4yos/CTSoLPRPkvtkw/HMQocmxx8jwd5IjGdWEj+CJ9
         74vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720165753; x=1720770553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmzAVFFw5D08+uA91hfZb9Q9HqDSR2WAdM+Ft2fb7zk=;
        b=YlWBYjNuBXrJkHPGrrcVzuSsZE0dWvhgtWeYFHfEIvQj3cL7NbHgP4Nc3sNZY77SSu
         twteq2Nc8R3vwqujGYLlPQrl8kdJWaJf7tZdy2KkAZh/UHxpSC1LGbHn/YOpDCgd4m3x
         MscAIjYjCye0cc74F3zROWum0zcBYz6Jiz7yZ9esoytA3Wjcg0PL/OaIL/Wds6v+pPFg
         yLQHMUANCDFXTyEVH9X8tGqrW32XuGWAQI4GjX+NMVu2PxIepF8YtOJIo5kw8l02XIpm
         Zk5AM4DHAwI1Cyv04/An/EaOVTvq6aPVvmV2+RwWPUbHqs812SkiG1yZ6e3byW4/qY2/
         P7iQ==
X-Gm-Message-State: AOJu0YwleP+Qo82lv9NLDBizo43wDDVilGRAOW6Y7AfgAk/W+yDGneNi
	T8auSZqlZbsz/oYrXo6I4amYAGTYbxrCBxSfEn50j/9urypyuGEMjSB7h1Fu3WU=
X-Google-Smtp-Source: AGHT+IFAT58+8doNA/oVE013DnsB6VbLaRtBLbYPR+iJHMq4ISD/FC3kjCT76dKTj5KPWqWl5xiWmQ==
X-Received: by 2002:a5d:4bc6:0:b0:367:940b:b662 with SMTP id ffacd0b85a97d-3679f7392a4mr3851936f8f.31.1720165753177;
        Fri, 05 Jul 2024 00:49:13 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d8ed0sm20183521f8f.28.2024.07.05.00.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 00:49:12 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 07/15] dt-bindings: nvmem: amlogic,meson-gx-efuse: add optional power-domains
Date: Fri,  5 Jul 2024 08:48:44 +0100
Message-Id: <20240705074852.423202-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240705074852.423202-1-srinivas.kandagatla@linaro.org>
References: <20240705074852.423202-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Neil Armstrong <neil.armstrong@linaro.org>

On newer SoCs, the eFuse hardware can require a power-domain to operate,
add it as optional.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/nvmem/amlogic,meson-gxbb-efuse.yaml    | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/amlogic,meson-gxbb-efuse.yaml b/Documentation/devicetree/bindings/nvmem/amlogic,meson-gxbb-efuse.yaml
index 9801fe6f91b5..99ddc9a4af05 100644
--- a/Documentation/devicetree/bindings/nvmem/amlogic,meson-gxbb-efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/amlogic,meson-gxbb-efuse.yaml
@@ -28,6 +28,9 @@ properties:
     description: phandle to the secure-monitor node
     $ref: /schemas/types.yaml#/definitions/phandle
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - clocks
-- 
2.25.1



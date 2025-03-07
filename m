Return-Path: <linux-kernel+bounces-551715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BC1A56FCF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B218D16581D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FE22417D9;
	Fri,  7 Mar 2025 17:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wkCzf7ZD"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D91E241105
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 17:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741370274; cv=none; b=jGBKmlgxX6dVjvyvwMwjKfqAjEeRMDh5D51Q7BRjOUXuXpzwPo/3MSeFcCMhy5IpR8bRjUMoC2cv7UocaDUsHmWjgwUNaTVL2COGhxKz0vU28jy4Hf048wCagLd6HtzW3llfGlCP3UgoCLMe7IgWvs+UqTg0nDT7IoWQQUywyOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741370274; c=relaxed/simple;
	bh=4g9wUdzBEHF2DXwrsn4sDVm7Nmec/oEeQKsxWFnBuaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KEk7nInA4v/sZKz7qcT5md7NVu9RpgDGocmY3xPn/9+MBGM4ADDx+ZADV8P9ALH9Xaa6MNQi13nUqIrPMzf5TksdjRzPCvZD/2kzKww4shGWseSP4r7HfCixGSsI9olF9IsmRxtJWJcMclXdepGejmNHTIFcJpIJMVRGQ8CHPxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wkCzf7ZD; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e4d50ed90aso2719397a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 09:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741370270; x=1741975070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoVQYZpiH0Di4cmCzPcvMx2OkQBw+j3GHZ8ITdSC16E=;
        b=wkCzf7ZDzCkIXgKLz0WH+deDVs1L8OuPzNJ2DPBhrjVUY+HUXdd4o3I4QWUEuca/4d
         rsNVG5YbRCBGmuoMEKjRKeSQKNRctZUnfOZEY3pUccIroUYKKSUc5vURXC3tdGSR+xyN
         JmzdyNj+YqFbsHAee6Hvc1gY+3EFAEPdzOUDYObknWjd2jwHIxpv0FRXRzbIaEDqXzzw
         uI6aOr55Lw4mVn1QHaXTI6QvoeYmtjIuT0MEcXNjgt/IUgnMiNgVWZx6vcthbnakndcF
         /db3AptA2MKxkqXtuOIRsUZkdfUvRa7O2vx4w26E1x1zLJWt/1JUHbdS9MzRoPrXneTO
         XuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741370270; x=1741975070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zoVQYZpiH0Di4cmCzPcvMx2OkQBw+j3GHZ8ITdSC16E=;
        b=ugBQV+pAV1elHkSO+bcRqubzLPDo19OfwJt0/u5AMzb7aahZd6RSIlDwJCSzmomWJz
         9tZ7zuFYPT5tNLLEWpOO9qDFL/d3GpRMmDejvs/7JnJBsWP7DT/8THmBtqeTgeanDuRE
         xsnjwje/anY3eM1IdTUDQ1eNuK/9tvskFrEpv4tnvASIJsntrtPdLXf7kg2sP1jW8ssl
         uCDAr5Si0s0SEPKmVdYDJ9O6Dr9T/s1SHuKN9VsuMAXTRID/0ZY2aX06kScUIOcjHcvA
         VfNSzabJIcyj9LhY3aMeC0B5KDZB8Gc0mCutJq1EV7KzihWDZXE31XjfiRyvlpUaEJ3f
         Atgw==
X-Gm-Message-State: AOJu0YzyCyiHYUhCrrZ8W0bbqYRAsnvlX2oWNdd75MkHOOEa+UkZ7m+a
	NsKArJ7K57ng4WKL92e58gxQnJa1hJ6kWnyn3oO5YtHkMrO0cm5PSkA2rPvyvp8=
X-Gm-Gg: ASbGncsyLl89PuXGk5foOwGJ3j1wKWdLohvtovn8xOHWU6+X9XDKSo3gGi/kIIgbuOh
	2Q9vzrj/wAQ2vSB5noqrVSUzg1J8KzcoUSc6/n/l2u3vhFh0h/wnDCHjLFm2Cq8uyskWhNqHuge
	uwFj3Baj/e1VTLK7Xh66OoqTXlB2mpij1+z1EbTgTyuP439xuT7PLUmr/yofAAqYt4gIFkSvnR3
	JPZOKT/G2orr0wDbdRRKvD6rYGmzXr6FmZ/zRTnN9VkAxfpaEi/QhCfhz+o3hmRxTD55zoHlpy/
	GStk3/8URtwk+4qiFqaqr5Ws5B8UMQHFJSrWKZl7BI8WXFvM/73Jrn01raOzISiwOOj2mw==
X-Google-Smtp-Source: AGHT+IHxiwkU4mrWNFNcCoNzQMlUXLJ1PZp5/1lSIUWHGPvo+GPaymL2q+jOXRRgTCD/TXFZXqIzJA==
X-Received: by 2002:a05:6402:5109:b0:5e1:dac1:fa22 with SMTP id 4fb4d7f45d1cf-5e5e24bd697mr4679930a12.21.1741370270497;
        Fri, 07 Mar 2025 09:57:50 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c745c5afsm2803622a12.18.2025.03.07.09.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 09:57:49 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 02/14] dt-bindings: nvmem: rockchip,otp: add missing limits for clock-names
Date: Fri,  7 Mar 2025 17:57:12 +0000
Message-Id: <20250307175724.15068-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250307175724.15068-1-srinivas.kandagatla@linaro.org>
References: <20250307175724.15068-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1303; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=UQK0J97pNwCPOKGAeMM7qvUdjF+FdCoH8EtiOEwCJys=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBnyzN8+g2DzChB+wfimV6C2cDoSMG8RnsgqbIoU f2SZtwwcu+JATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZ8szfAAKCRB6of1ZxzRV N1uOB/sHRxKaxCdXWWzCHsUMR6JlxSF0c1ub6XvCGe1BzF6k82lA5JAfMopfOtl+CuHteDMSzkd uyVikT9zEpF5f/Qwsd0Szcczt2M9xFuPeuHBfYKWMmQDscVz7A7sRCorCvdZerp+ysmTeE7xSB0 mc5HKXaP3848pEda8fdy5MQ0gskrBVDLPdVI4q42FjlwmgMqKscBsKbPFbFfHVF4FBRPFBllfpt +cNkCgsyNM8Q8/tNJep70msv7duT9qbnWaw11sJnv9FHDFeTfBgOuPxIiWdjGe/pxvuULNtnHRx p+Sjg43ZtOW81vMPcWkQ0ZmRpE+aF1zBEFscyPP6Z3mdQ/1O
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko@sntech.de>

The clocks property correctly declares minItems and maxItems for its
variants, but clock-names does not. Both properties are always used
together, so should declare the same limits.

Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Tested-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml b/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml
index a44d44b32809..3201ff8f9334 100644
--- a/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml
@@ -62,6 +62,8 @@ allOf:
       properties:
         clocks:
           maxItems: 3
+        clock-names:
+          maxItems: 3
         resets:
           maxItems: 1
         reset-names:
@@ -78,6 +80,8 @@ allOf:
       properties:
         clocks:
           minItems: 4
+        clock-names:
+          minItems: 4
         resets:
           minItems: 3
         reset-names:
-- 
2.25.1



Return-Path: <linux-kernel+bounces-349087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E796398F0A1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 15:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA892282F68
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617F119E969;
	Thu,  3 Oct 2024 13:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rsu+Pokb"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B96019D885
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 13:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727962750; cv=none; b=p/boyTt0TQS9Hvt/CQSnAgRaQcEYQFvoJ+KGF1UWIOL682TeWnCxyXVhpuf7MoKxbfo+EJYKFnJXtuFM3Lxr1Pbq8pXME2pSj5MCJnWqA5wHKbjkTjGIiFXNvdcAb6FjRg0uGRBpoexEC8OF+mjNSEnSQvLOjRnwVGlvBwHAf14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727962750; c=relaxed/simple;
	bh=CK4Syf7elI4wlYU9hJSEoo8vSaCRSZFp8PclYRhI87E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dzcVYRmUKly91AVR7EDeMZFWIOqQJ/DxNGMy/U8nu/Bx+H/yKFC8xUpwpn6hyJb7Z7ZDbKZCuzTA7Wz8WTkteQ5TYBaK4NlDphbs2YX3+KdWJx6gzzWCczmCuNmkiV/m0v+xhPkNdEPOCtLmlezkk/TJzV1C3fE45WTwNyWjjDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rsu+Pokb; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cb1866c8fso1262035e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 06:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727962748; x=1728567548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vhlVBKUdIP9ICp6zlxH3C4G3zUM+gAWbktY0hHBXtCs=;
        b=rsu+Pokb2l4983eG0gaQeFv/A8E8T+gMYO9BfkL/C1dgYnEHIH7aw8xnD6O3hwjEpj
         SAC5U6vO4akqXyo/HXh0QSyuaJ4Tc6uBN5fk0iufxEQCfw1i7ypGv+Mdpj6PY5hiPcih
         2g3s6c+rbQyRpp7P3hw6LqjySxfEFd8u0bfQkAgxSYm15FKRXntq1VkqWGfyoFJvrYum
         OC+T77LCa7hRmcEh+fu8oGj6cYBU72Ka2fjBkFPH+U69cpSfWdWAzKcXaBTBebRkup37
         /6dNxgBUbmLlWFBELXgk38yLsRajyyNzQPZgNcIRTR0jMzNNsZ0nOnSlZ97rLG+w9hp9
         4bFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727962748; x=1728567548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vhlVBKUdIP9ICp6zlxH3C4G3zUM+gAWbktY0hHBXtCs=;
        b=GRPeoCjZWl0V+trx44A/I1/WQlOWTu7CmLAmWz0YWwRxspeDRY+cl5VDichJJwz0P7
         BVBMNb5mN+4gYgIT527cFGhKxW6H86+Smph5iniPkp/B5uiJg4ePPe33LeaouP25jXKS
         d50bnduJTurWBOxU8yane9sLo35o5EpL8zQZaPQQ6Y12fZ7hTmgKGglQvyVW9v6WV9ea
         XjPLkXqXpS3z+iJRHV5IvYcqSFt7Cp9sq38/OyJxy6Q7kiKI1Ni0+hghFZW+gSIjFFPo
         PoK8/pNqJLdvDDl7GaPB53lkl4DDuliU24q3yzOfDzE7NpDXHjyZyqgKmcqaPCVl6n1/
         9uwA==
X-Forwarded-Encrypted: i=1; AJvYcCVWK6QIwenIMLKxCSkATimG8lhNETCAp92PwDVqxBgnL9WCK5FIOOHZum0Na9pS3d626APQp/1k+AkaoU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY7DOitnrsEzA6NSR5vVIxHB/I1j6rffB81niNXnb+QM+TqMWV
	+pKgSzqEile/mGqhGwh5J+VliKmzn4z4jeZUZfpJ4TIiTD9sbCX3w/qwe8ibeP8=
X-Google-Smtp-Source: AGHT+IGAi9GFf0ajjL2VRkR+8z2/+wjuWbQka9q8tmXJJBQqwW2SfzfdMkNW5bz+Pq96QWct/VT+nA==
X-Received: by 2002:a05:600c:35d6:b0:42c:b55f:f4f with SMTP id 5b1f17b1804b1-42f778f336cmr25665035e9.6.1727962747636;
        Thu, 03 Oct 2024 06:39:07 -0700 (PDT)
Received: from krzk-bin.. ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f8025b583sm15906875e9.12.2024.10.03.06.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 06:39:07 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] dt-bindings: display: bridge: tc358768: switch to bus-width
Date: Thu,  3 Oct 2024 15:39:03 +0200
Message-ID: <20241003133904.69244-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"data-lines" property is way too similar to "data-lanes".  It is also
duplicating "bus-width" from video-interfaces.yaml schema.  Deprecate
"data-lines" and use the common property.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/display/bridge/toshiba,tc358768.yaml  | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
index 779d8c57f854..bb5d3b543800 100644
--- a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
@@ -60,6 +60,10 @@ properties:
               data-lines:
                 $ref: /schemas/types.yaml#/definitions/uint32
                 enum: [ 16, 18, 24 ]
+                deprecated: true
+
+              bus-width:
+                enum: [ 16, 18, 24 ]
 
       port@1:
         $ref: /schemas/graph.yaml#/properties/port
-- 
2.43.0



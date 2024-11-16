Return-Path: <linux-kernel+bounces-411737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A689CFF08
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 14:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E60E1B2783C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 13:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA051B21B6;
	Sat, 16 Nov 2024 13:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeA6hRia"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0079F1AE016;
	Sat, 16 Nov 2024 13:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731762637; cv=none; b=QVxDBRnm7o/oiQlWr6yx2jCsJekU0s3wLR4SYVxCeL/R6v1ikSE5iYWIb2qLMVuiNDvKwNKJ72w//ltE8AU1N4eG/46xVJY5lVsbM2sQSbVaA7wcXYUHT2uOgLzGcwSTmWecUPK35VaPP9DzfFwr0bFGzGroitwb9P9ThNi3gBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731762637; c=relaxed/simple;
	bh=i3juckuRtIKvv+OCREtO8dQ0ulXdyIrNq9XlmPYeTIM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kI7HhAJqdLBOwMpcKuWGV+neZHpMjuYIcDLPrA9XO30YVyvvSHwUJeToiNZjkOXz6y3sAtvuNWGN36qfy7l8vC6e9LFlVsFkbr48i6VmawcKC4kOQsUe+eoS72FhF+5ggY8DI2JaFMIpOc/2HfsukekI9y8wXaDGY/E6Ec4yJyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XeA6hRia; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43158124a54so1921835e9.3;
        Sat, 16 Nov 2024 05:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731762632; x=1732367432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zmuq4GZVR0Wz/WKMMk91M10uYYmhXwmkQk4GntRonVk=;
        b=XeA6hRiaNMSoGWN+OV3L4Sm0h4xwtibAmkoC+jqDhQICGJzsPv3/6wi66D5p0brM3+
         6tb9EKlc+DhFNmTrluLKULpnEI1nHAkGAjYltrDv22xGcRvPtLnuc4VH0Hfgae6GkdGP
         PW+Y5cBNuzKTBSjsNwtXsUAaitnUtibFNrftk8vpJur9QLk/jG0ojfhV8u1xKnIa9znx
         dWM8g0YDYlbRo5N6MEzZ0VcIFBukn+jQDJX+bm/R/xu/cMHP582JFLGvAsQvTSkUuQOg
         wlcesZDQRR53ROOVoYCaPUrmL3brE54HdOs2uZxnjDbTQgcfK94xZPKuQO0rMbcghI4I
         Hzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731762632; x=1732367432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zmuq4GZVR0Wz/WKMMk91M10uYYmhXwmkQk4GntRonVk=;
        b=IFrt8Rxtl1LdC3mRcZbtCueIscZ+yuzAAqMvw3ZAJ8HV0VcY2DmwijtbHXETg4GgFz
         x0yRY6XgtIjoE7+PfOTF4WilxUgjjEm8a5Nycndu/M9oUpdQFX3R4+tEhsjOnuE21Bzy
         o+6aMwW2cTiOWJ8GLyLbOfJkoAOtTq0462SaVqqs4P7fZYcnBOvstvB375bP27esxq24
         V+dLiTr85ybbTFJsllQe+nZAeBbiVhBe6r3DSEUyREBg7MTnPn27wJpN8w3LcCxhcS9m
         PVpokOAv+Ss0QFsB74lFOHyhc6/cjwJnPEkP9Z4YTyCe5VeqpfqBY+MZ3Q8QizXPSrub
         UWVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdv8sXTwMiomtj+vZ6Uv/CTi9LlJ5KQ2pO/k7gYIG+oqXwDjdOec7J063JwPX8lo7WJpqEJbnWR1Ut@vger.kernel.org, AJvYcCXK5iVvLIFMkZdg1yXNXY2KMuGPjqeMTN0uv5fVXIIC+I+hIULqwU/UNzLHbsiJDhDzBDH26b+MZ5PSm12x@vger.kernel.org
X-Gm-Message-State: AOJu0YzD9EPg8BWnGzfMKFU830U/VlQejOElPgaf0k0OvkfxPN7cyxaO
	9Q6uPACJ3mgih4RqekS6ecI5KP5DYW5bffT08sBMvqTcVXS/uYhY
X-Google-Smtp-Source: AGHT+IHY8Vp0X4Luu2vkzODPnQ6n9CsLYCSJpezLwzZ1yldmAXljOyhaGlXcvnhV/bTzJp9D4Vo9mQ==
X-Received: by 2002:a05:600c:5250:b0:42c:c0d8:bf34 with SMTP id 5b1f17b1804b1-432df679bfdmr22544655e9.0.1731762632041;
        Sat, 16 Nov 2024 05:10:32 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da28ba80sm92424375e9.29.2024.11.16.05.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 05:10:31 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org
Cc: marex@denx.de,
	s.trumtrar@pengutronix.de,
	l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 04/11] dt-bindings: altera: add Enclustra Mercury SA1
Date: Sat, 16 Nov 2024 13:10:18 +0000
Message-Id: <20241116131025.114542-5-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241116131025.114542-1-l.rubusch@gmail.com>
References: <20241116131025.114542-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the DT binding for the Enclustra Mercury+ SA1 SoM

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/altera.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index 8c7575455..87a22d2a4 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -51,6 +51,16 @@ properties:
           - const: altr,socfpga-cyclone5
           - const: altr,socfpga
 
+      - description: Mercury SA1 boards
+        items:
+          - enum:
+              - enclustra,mercury-sa1-pe1
+              - enclustra,mercury-sa1-pe3
+              - enclustra,mercury-sa1-st1
+          - const: enclustra,mercury-sa1
+          - const: altr,socfpga-cyclone5
+          - const: altr,socfpga
+
       - description: Stratix 10 boards
         items:
           - enum:
-- 
2.39.2



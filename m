Return-Path: <linux-kernel+bounces-187116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2495E8CCD66
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48E1A1C20918
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 07:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EF313D284;
	Thu, 23 May 2024 07:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nfl6VszG"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5C113CF85
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 07:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716450870; cv=none; b=Qtr/B0nDf20pCjBDN5Gj5NsiZ1hFemT91m4B9xaWYk6REbeqcsLUjuvsbdSeW+si32OCHqYhWna5+RDmmdWTGKg70M8QwV8IBzVqqGdlsIzG5Sr1m2czvsX7VRPp/igvK3hrDIQY6AEXttJXDdUNBZ1OOpT6INYUzBDQf/ywyu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716450870; c=relaxed/simple;
	bh=IXICyk/2YP4eDexMcGBpEOku8KMw3RDWVpsaEO4xej4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=salase6/i2D3qQVGJhmsQ8OgIqqAC/ei6QNeFvpXuexGYJrwXUPhlvVo4Lz2vqds+6AeXUlC+WTI1+CYrUwfIqIgY8JW8W+C6cjVr5W8r0v9CSdDP3qzoT5aPeKwU0mW2jRv4s8+yq3w1KzM2hKD7TDP/5bJjHjR9r5Y/cfnS24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nfl6VszG; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-354cd8da8b9so1791986f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 00:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716450865; x=1717055665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dfktdx7avVVxO+VgbPGQcts/32B65YHqwd/3ELI4ILs=;
        b=nfl6VszGSwZVqB6kGkSVxFW4b4wZmTNTR5Phncuf7zqUOkk0rUWADvxYoV/UjnODvj
         iW7AC7sMt64uIApFG11rLRiY1JLJIksqSxtKSRyhkEJNSW3qm+s7QawoRO9HIdO5kPGi
         CJ/5/Rct1Lw4XpREAA3nQ8py/CWEP8e+Y0gwiTaMJ33XQpp684eTpU7wFEt4QjUtpgp+
         Wj/Saabi8dmTd6Y/8e1nVPdJm6+kkkob3FURI5+aGRRmejk0Vef2MC9jbDeViyUKdK1l
         1b6GENCnfl/FR7Z2Gyb70/Qd3vVAqUmBlsybiS6xTcgsovkUD96987bC/iizE1RLXxUX
         snIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716450865; x=1717055665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dfktdx7avVVxO+VgbPGQcts/32B65YHqwd/3ELI4ILs=;
        b=GAUs8E/ZQGt6WPrs2/rQ0TxqurX20yvpadmsIVKOC0QMSnd29osH6Ls/JWkidHAl57
         gPvirpmorzSe1tWIDAzPIzT7bGCdCZhgtt7n+p329srmKhi4wR2GKvSO4F7/d2hMSjzm
         P7wFgp75B4Qhqyjj0XgoqjyWsNeegFsB6wkaWX8Otdy1kHKk25wytP83Y43alHc997/w
         QLhKWaVsHOOIzr7UQUhDEd7u0vnW/BwZy2HymFO7kpvcbb+7F9GNZf1PYbPDyo9I6149
         sAYpYJj3XkFDtOgNX3g23J9z3NLbiCsZyKvb8P2t4EbASTUY9Z3QITjMPaNinvnG+ExQ
         xmLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVgepRM5i0OXuDpuX/vVVMUb5mawR8Ks9x8WrnPJN2oEw26t/EdG73dvdLOLehKhXRYYJFZjFSvs5sBque7q8B8nXaV0e/eoIyUEo4
X-Gm-Message-State: AOJu0Yy65di6cjoFfCs0gw+oYvevsd4GB3yx/bmOm85IKM/T9goKTDpF
	BOvDEiJVVgkB/BKXv40W/Zro5YdZrUufpJmLZMPHaecKZr64joOlhAIE0+8fNCA=
X-Google-Smtp-Source: AGHT+IF/pK55XVk6BU5rXK9slQYy/4lO8VwqixmRJMIscsNGljlUqfko0F+oxxn3ecB3ekIdd2xgtA==
X-Received: by 2002:a5d:564b:0:b0:354:fd72:8791 with SMTP id ffacd0b85a97d-354fd7288b8mr235826f8f.43.1716450865365;
        Thu, 23 May 2024 00:54:25 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baad074sm36501833f8f.70.2024.05.23.00.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 00:54:24 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	=?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	Simon Horman <horms@kernel.org>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 2/7] dt-bindings: can: m_can: Add wakeup pinctrl state
Date: Thu, 23 May 2024 09:53:42 +0200
Message-ID: <20240523075347.1282395-3-msp@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523075347.1282395-1-msp@baylibre.com>
References: <20240523075347.1282395-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pins associated with m_can can be the source of a wakeup in deep sleep
states. To be able to wakeup these pins have to be configured in a
special way. To support this configuration add the default and wakeup
pinctrl states.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 .../devicetree/bindings/net/can/bosch,m_can.yaml | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
index 33f1688ca208..7c6fa7367c37 100644
--- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
+++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
@@ -106,6 +106,22 @@ properties:
         maximum: 32
     minItems: 1
 
+  pinctrl-0:
+    description: Default pinctrl state
+
+  pinctrl-1:
+    description: Wakeup pinctrl state
+
+  pinctrl-names:
+    description:
+      When present should contain at least "default" describing the default pin
+      states. The second state called "wakeup" describes the pins in their
+      wakeup configuration required to exit sleep states.
+    minItems: 1
+    items:
+      - const: default
+      - const: wakeup
+
   power-domains:
     description:
       Power domain provider node and an args specifier containing
-- 
2.43.0



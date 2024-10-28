Return-Path: <linux-kernel+bounces-385493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7359B37E8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91C611F226DE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07EF1DF994;
	Mon, 28 Oct 2024 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GjDbp/tZ"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0FD1DF735
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 17:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137225; cv=none; b=EI0MTZufRnQ0/7JNKV9OPkNtvY44PzNkuEFkg0PacX+VO5tpcdQ7m/MZNpJfrsS7NL3jQWsT7tzwkAQarax/OkHQuFKyhIqOAFQ1j75p4uyzyCTSG+HrjDv07hm4n512P2NulVcJX4xowMlh+K5HCPxDJwVHXsTQqOAYnAZhdLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137225; c=relaxed/simple;
	bh=UPDN5Sq6sr7oOOH4G9BvBLb/9GgPBe4IrDFtGwTay8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MPV2kYemR1WforO/71DhAWz+RxnGYppRsq5JkqGQ5BzYrBKw3S/u4ggWnfwW1C6WTGqVMdeeIdfxxreuOoFhGSMQk11mNJNVWzMGzvJc7r4eTqCwlDyX1C0u1tfqmVLTmpC60JtwLwGyN3XA9kPQlplwtuiiDargTYIt/khlJyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GjDbp/tZ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4315df7b43fso47378785e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730137221; x=1730742021; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=saDUfDEJR0b1bnX4tkk4rHbVAroR4qkyv+y1+fjCTpM=;
        b=GjDbp/tZKjS01p76CB0CxClrVSLuKa3svB5sex6VRIjnUJrmwWr/DoygGa9NaHiIud
         N3b6H86qW6E+oEyNZ8ndpAZXnQalZfT0Vh4XIce9lSxc3Zvut/D2V58wQxguQ7vstjfm
         DrMENPfGJZX8YRtayBHJbWTzvqoadgZ0gBqTK1hWnxoUdQ6xWoI9GWH65apEmpHx38Y6
         3rnibnAEYqLwdHKJO51eMHEXOxm5bVR7ifhYi+0xc6wjHhWFpVeDL7ZmDnu+hGFxmnnB
         tOOhkrr4U49I1RybKV7YnfeOYcFGuumY8Xp8xHRCvQDhq6S+TpNmz+2QTBlScde1rTWv
         wdww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730137221; x=1730742021;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=saDUfDEJR0b1bnX4tkk4rHbVAroR4qkyv+y1+fjCTpM=;
        b=EyPxIuOxAPISiTh1g3Wduw2QU4JtjwudenvKTzRTzo2TC5lYNujESP7/G/YDqAc4d/
         4XkjXHteaa8CVu7hJ52hFuAvRNh39IXBj96GrUtCXVA/d2XnGUuPRq4iWFY1N4UGTODA
         jcx4h52KiknDkUt/qZh/IPN1zjc8KhBkwaHUoeFEwpDk9p79u+1sUeEleqnS9t/YFVju
         a+suZgO0faQzJQRSiwLJG2+SsAc9a7kZQzfh23mssbTQo2aJWQIRIPGhn6LqJyeeftQv
         wSbrnt2wQ94tCe9iYqN6Mblhp8W+uMOHcL0F7TrF+L2h7s8BYx7dH7u+/WzK/5Z+Wjt/
         2c1g==
X-Forwarded-Encrypted: i=1; AJvYcCVZdtNhl0gOzTanZNfnGHtb91hr9T0hMoRqCo+wOagpfcK/qfk5RF+yOyVGIp8NX1Ye69XoHYa1f4A27yQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNiZvM6ISCnpkjwqtkUpI1uOi8fPwWmnrIuf5lCC191CwbaMXb
	oIlN9Dj5MIwUR3SsnQgeWl45qSOUq6F4NWkuFAq8skck0D4pPBsviYcCi4tzTEY=
X-Google-Smtp-Source: AGHT+IEFgqPvKk7zPEVSc8W/hIxxgLdyl05U2omshsXFU5gMdwFKyPVKfHosWtNHQDrxWACBCsN4Kw==
X-Received: by 2002:adf:ea43:0:b0:37d:633a:b361 with SMTP id ffacd0b85a97d-38061206c0cmr7014723f8f.51.1730137221379;
        Mon, 28 Oct 2024 10:40:21 -0700 (PDT)
Received: from localhost ([2001:4091:a245:81f4:340d:1a9d:1fa6:531f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b479ffsm10101137f8f.49.2024.10.28.10.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 10:40:20 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Mon, 28 Oct 2024 18:38:08 +0100
Subject: [PATCH v5 2/9] dt-bindings: can: m_can: Add vio-supply
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-topic-mcan-wakeup-source-v6-12-v5-2-33edc0aba629@baylibre.com>
References: <20241028-topic-mcan-wakeup-source-v6-12-v5-0-33edc0aba629@baylibre.com>
In-Reply-To: <20241028-topic-mcan-wakeup-source-v6-12-v5-0-33edc0aba629@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Simon Horman <horms@kernel.org>, 
 Vincent MAILHOL <mailhol.vincent@wanadoo.fr>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1211; i=msp@baylibre.com;
 h=from:subject:message-id; bh=UPDN5Sq6sr7oOOH4G9BvBLb/9GgPBe4IrDFtGwTay8A=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNLlz4Run/jwReX7GwrBXQwK7SZ2pn9mW29ZJKfoziIyX
 +yHmcGLjlIWBjEOBlkxRZa7Hxa+q5O7viBi3SNHmDmsTCBDGLg4BWAiqVkMf7jENx4SjstJted9
 xanLYlMR9vmuZ992XZeNc/9d45LmPsvI0Nh9nXNu+tu+R2vOqZ7Zc/Hysj/vT72qXLlL2fDqW/4
 3U9gA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

The m_can unit can be integrated in different ways. For AM62 the unit is
integrated in different parts of the system (MCU or Main domain) and can
be powered by different external power sources. For example on am62-lp-sk
mcu_mcan0 and mcu_mcan1 are powered through VDDSHV_CANUART by an
external regulator. To be able to describe these relationships, add a
vio-supply property to this binding.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
index 0c1f9fa7371897d45539ead49c9d290fb4966f30..aac2add319e240f4f561b755f41bf267b807ebcd 100644
--- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
+++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
@@ -140,6 +140,10 @@ properties:
 
   wakeup-source: true
 
+  vio-supply:
+    description:
+      Reference to the main power supply of the unit.
+
 required:
   - compatible
   - reg

-- 
2.45.2



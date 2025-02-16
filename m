Return-Path: <linux-kernel+bounces-516665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F97A37587
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 17:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81B4818920BA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 16:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5639F19CC02;
	Sun, 16 Feb 2025 16:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7s3kAik"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33CA199938;
	Sun, 16 Feb 2025 16:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739722373; cv=none; b=VlApRbK8J6WHAVEe1lxP91ATSROdtJGUx+wZNzFvh7nqFoocyvE5ZzGTRjWng5sKR2tmWG934rj5BMY939C0Nqtwu4HhqWupxoafpC2L//Ob5zPRkUpN1w9cfuiqxVy36L25oD6TRpNYBcQno8AbSesDExw8ZDvmXq9ez0kOBxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739722373; c=relaxed/simple;
	bh=Ly9UtUA8Pd6tt+IYxaDFVVmxNWzlSLQnkpl0OS4b+uY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h69W1EOoSB5wvgjU4NXmHc/SOVzZnjyQye+c/8E2DB5Ifv85W7fNma/V0GNp2NAercj3l3K5ve2MUr3bOa7bAV1O4lk4fERW9fogei6OgK8f492QEjLED5zhNon3gnjOXpz5wsaPWN6qO82zJWUZqAzEhwLzCQlFf+0pqXkRmj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7s3kAik; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5ded6c31344so3843375a12.1;
        Sun, 16 Feb 2025 08:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739722370; x=1740327170; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=amFA1Cyy3VSCClgsw5cvJKtdLCji07TK+OkBeo/AdFY=;
        b=j7s3kAikHMtdLUUNFWiB6QVDmkm9CSilZPTZvgqkuKw1M+sTBmmL4KZgyUZ6FjfdsN
         Br1Kdjzym6rlGodVpXyi5NeLlUCnc7hrK+27u6FBNNgcikBjWYiRO1nASAyXinYBJtN4
         dAn8qi24gY4LDER73KyypqAg7MEhk1zTgZbzivZ3XQsPilllzAwih+vKb0+onXqRytlp
         g78CFaLGF8PDKNhvzPMnDDgq9HT51pIvNoRUl0yASNCzAZNgbsidL1pLRx9K8W3z6RW6
         EiaRGeQmKsWRBQdrr2Mp9VsFCiRWjy+cPSoTqjz9nMvErxTcz7YHFQsrZ2XzPWoWxaJC
         7A+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739722370; x=1740327170;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amFA1Cyy3VSCClgsw5cvJKtdLCji07TK+OkBeo/AdFY=;
        b=kbok5GvD6kHwTjHET2f7a0WxZB/c9+tk9bgU5nI+Pgg30Nzhgc2A4F9jlAr5ZwIZ1V
         tRLAVQkOdFXLWHg9GGUO15Dmiwrq0jDkS/0rIiqofgaiSEw6O9wjf2DoKKNsgy4t/r5t
         QUlXfzEv/ezXkL0H1lFlLNUhtbAQ8ZdOYNXK3p1w30w2LDfRs1egtR65Clp23slpkJoh
         KkuTbqTbnmYTAO87oNA6m3Z4a/xfn6gG8C+CHOJob9Znu0LSG4mzXrvUl6mG+NDlwM2H
         dDlusD7iVdDYEmhg9Nt38DQdrtsuDaOMtCAespDdkENp6uueXKZf0YsJv+jgq6oIDTpF
         IF9g==
X-Forwarded-Encrypted: i=1; AJvYcCUjrKIPegjs4AFLRPnKe4Nx6gskIRDHoGiior4tdfbZEeGzrw1bmj2sPnXi8Nh18tM1//TE1KZwF1DX@vger.kernel.org, AJvYcCVi+jKq3gvNudIiCVS0QXBBePy2rokNLszPmmwhPuqatEnew3YOLam9+I71tDa1zTHZTMdljuzAtXAN@vger.kernel.org, AJvYcCX9DoQJAKZEEqIA/eSdYKJ+2Wj/RtgjHXOzJr/fBdABEX6OX6jmuo05xtmRtCgYlYYonvN6CBHkEzcrWgp/@vger.kernel.org
X-Gm-Message-State: AOJu0YyOMeIZ8qGohHQTu6FEpCxokgDWolH3exWN/XhybQKQdu99THjl
	K5tmPGH/Y5Wi4W4V5DkovEpyXpE2IRYS/4tgcKDw5d+eM1eIHuqm
X-Gm-Gg: ASbGncvLD946MIwJ40FNAmbEOErj/QlwXP/AGNctuxaCcHwjSjvW82alQZgPI1m6Fik
	gu4DsQldQsThcaLBN6SOsUbCT/i5plT+O/MQ/7BWaaF7JgREqltoRqptPNZ+oAlNma1msoIQNrH
	EfWYbZxeDLt8m2qT2G0jg+r53vaFqYfuzvr+GDfIB3cCocsih42SOZ3LFfiyhHufERlournChIt
	5pE89gzrJ1gIwehhjNIlQchZSejC4bT7drxqPTw/bAi3xl5o1rX6ikdQCqZ4+dRGh/PUyLV3W/+
	PYFHB1BbAr0fRywmB9Dy8Tq2WGVexUywyAYqxQ4Fh+Ak2VdP2yX7dlRXUh1hMw==
X-Google-Smtp-Source: AGHT+IFx7rx4cBQ+24qh/JpmVN8N/SzDAqqvLDMgJEQ6n86+XwhDIWMpPS0or7VAcLEkS/oyZckwBA==
X-Received: by 2002:a05:6402:1e8a:b0:5de:5190:cfc7 with SMTP id 4fb4d7f45d1cf-5e03608cb01mr12791107a12.19.1739722369899;
        Sun, 16 Feb 2025 08:12:49 -0800 (PST)
Received: from hex.my.domain (83.8.115.239.ipv4.supernova.orange.pl. [83.8.115.239])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8eea4d65sm148463466b.161.2025.02.16.08.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 08:12:49 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Sun, 16 Feb 2025 17:12:36 +0100
Subject: [PATCH RFC 1/5] dt-bindings: clock: brcm,kona-ccu: Add BCM21664
 bus clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250216-kona-bus-clock-v1-1-e8779d77a6f2@gmail.com>
References: <20250216-kona-bus-clock-v1-0-e8779d77a6f2@gmail.com>
In-Reply-To: <20250216-kona-bus-clock-v1-0-e8779d77a6f2@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Alex Elder <elder@kernel.org>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739722366; l=1827;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=Ly9UtUA8Pd6tt+IYxaDFVVmxNWzlSLQnkpl0OS4b+uY=;
 b=VJgL+tg1a9rW78m4+doyyeQIvRSxZzJhnoBbX8SvTohuATLLEoVOUTjHWsph8gVycWLKmYLgp
 o5XBkxmJn3dCTDvWTcTJCv/2CU6Fg6f2+kJy90wTAvgvZDHDDlTVSLl
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

Add bus clocks for hub_timer, sdio, bsc, uart and usb_otg_ahb to the
allowed clock output names for BCM21664 CCUs.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 .../devicetree/bindings/clock/brcm,kona-ccu.yaml       | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/brcm,kona-ccu.yaml b/Documentation/devicetree/bindings/clock/brcm,kona-ccu.yaml
index e5656950b3bd0ad44ba47f0ada84b558e71df590..dff04e24e92829b890bf7cd336f0e083bdb30fa6 100644
--- a/Documentation/devicetree/bindings/clock/brcm,kona-ccu.yaml
+++ b/Documentation/devicetree/bindings/clock/brcm,kona-ccu.yaml
@@ -40,7 +40,7 @@ properties:
 
   clock-output-names:
     minItems: 1
-    maxItems: 10
+    maxItems: 14
 
 required:
   - compatible
@@ -124,7 +124,9 @@ allOf:
     then:
       properties:
         clock-output-names:
-          const: hub_timer
+          items:
+            - const: hub_timer
+            - const: hub_timer_apb
   - if:
       properties:
         compatible:
@@ -142,6 +144,11 @@ allOf:
             - const: sdio2_sleep
             - const: sdio3_sleep
             - const: sdio4_sleep
+            - const: sdio1_ahb
+            - const: sdio2_ahb
+            - const: sdio3_ahb
+            - const: sdio4_ahb
+            - const: usb_otg_ahb
   - if:
       properties:
         compatible:
@@ -158,6 +165,13 @@ allOf:
             - const: bsc2
             - const: bsc3
             - const: bsc4
+            - const: uartb_apb
+            - const: uartb2_apb
+            - const: uartb3_apb
+            - const: bsc1_apb
+            - const: bsc2_apb
+            - const: bsc3_apb
+            - const: bsc4_apb
 
 additionalProperties: false
 

-- 
2.48.1



Return-Path: <linux-kernel+bounces-385870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 084E59B3CC9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C14A8282D88
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 21:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324761E230E;
	Mon, 28 Oct 2024 21:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjSTerNs"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD911E0E09;
	Mon, 28 Oct 2024 21:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730151227; cv=none; b=AlCET2vum/P9mi3sXoAMZWNg8ImKpSA6TDEAb+Cg24YU3FoSknglhlSNafyLEVUZuWWrLXjOPl/Qo35f7tDaoCzaMhetISxrJwWYnNRFOnIwZk4U+xvd13I5CfuM/3v409+BYcaPx5eD9cvTZxpBk/jkqHFu/QgcXUCqWPmbvI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730151227; c=relaxed/simple;
	bh=JG/ULN2d7dX81AfqT9FVv7XbCkIBN7iVY3LOa+L8ce4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K3aQPBuYSXXzn7h3XjC2ZbUNMgtnBPrg4tBDXzMKq/ETgoXhCTBy5PZpR/B5JEMCmb2RJqYXpzKNZZxBZRn/CmSh1f5slI4Wu5pfRs6N/Alxa7pGU4DMSqzyAQ/KmaARBKSoouBcFKP1Ztuoh/5cwUPfBl2r3izVrQ1BN8CiQk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjSTerNs; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539eb97f26aso4870255e87.2;
        Mon, 28 Oct 2024 14:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730151224; x=1730756024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPRnLRSy0O8eO8/usPbgRGVWwoluAoJVN3wn79JTw9s=;
        b=fjSTerNsqsW6Y70gRo0/q3z8KfWzCU4FDAdgxqVyyvWs+Fxr/TRguAW+JEl5yVyTCy
         ZOv0Q5pLumGO5I1J+URHo3xWY5AMRY8NKS84jWmdCIowzjMmEbprqybVFwQcSDNQz7Kp
         odar+aPWqjVpMQg9UzQ8JydGciymEMbWFo5Cg7u8aMuw8Gu2lV7c151PxM5fMrkIcKJn
         Or+rKwctz4Ux6vsNyQT5eDW+HrZclOP5a2GTIdo/Qontmx3iJP4EBj2QNgvrsp317b4J
         vj+NlmQEOAgNOBuy0a9Sdxz85LoZG/4fSRM+QpmDfo5Rs7G7udNlyZfEWJlW1E5qGpyk
         X87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730151224; x=1730756024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPRnLRSy0O8eO8/usPbgRGVWwoluAoJVN3wn79JTw9s=;
        b=fDa+vPNrGkzW7OivTyyIcxOFbkcOcwyv3E+Zm2v6yK8Yv0+Sh+uQgfBkhrFezoxRpL
         Ck/FcCZnQNTWrgWpSjMZ8Odjn0dsYwb6XzD7D90AtNKCZOtQtA1hM9SvBYZBTSjtaUgW
         IfZb0e7UYho5S1/15I4maYoVlpVdPTPe6gwpK+OfXZ5dgnKdI9/7h5Px5INhcdNXunGn
         /Dxx/iQe2wmOd6AdQah3geMAiObtVbSMnh6Nm7xX7dFqkxvDrMhLpE5BTR9xM93yBgcF
         4pJ9ybCIsoNRGrSB4prOtkl3mHX1jF8iqXVTI0CbJNmlZj0kAHLdtTm2aFDWNElHC6Yv
         9+fw==
X-Forwarded-Encrypted: i=1; AJvYcCUdHiuxj3wgaAQ15dAYZUjqMW/DYZ5WxoEwE6qRXmRBJKnwIhDQdDpKJiCS4sbUCOf6P3/EpDGHH8kVbsUB@vger.kernel.org, AJvYcCV6WSAcqzEptBkwq8rgMYl9MrWXkHb+WCIKo183ABRW/y2EXdJaDYc1sp06QXlHGzo2LrsDAPDzMwN8@vger.kernel.org
X-Gm-Message-State: AOJu0YxPchE+JlCVPurKibCtwV6EOgIQltLzV6DauBdFhjRupUaW364m
	6TKZwlnStMC8omR5PXYLTQHun+INgrdmAiKYMKzlG8VblMPRNU3J
X-Google-Smtp-Source: AGHT+IE2BQsW00x49gT530R1Vo7XSzUMAOGRbVHewvEcO0xDjhqc7o/bJXhiJS7Rw9Fk4OIxjCFtBA==
X-Received: by 2002:a05:6512:10d1:b0:539:ed5e:e224 with SMTP id 2adb3069b0e04-53b348b9923mr4191254e87.7.1730151223612;
        Mon, 28 Oct 2024 14:33:43 -0700 (PDT)
Received: from localhost.localdomain ([91.90.219.38])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1c98b9sm1204625e87.224.2024.10.28.14.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 14:33:43 -0700 (PDT)
From: Dmitry Yashin <dmt.yashin@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dmitry Yashin <dmt.yashin@gmail.com>
Subject: [PATCH 1/3] ASoC: dt-bindings: rockchip,rk3308-codec: add port property
Date: Tue, 29 Oct 2024 02:33:12 +0500
Message-ID: <20241028213314.476776-2-dmt.yashin@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028213314.476776-1-dmt.yashin@gmail.com>
References: <20241028213314.476776-1-dmt.yashin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix DTB warnings when rk3308-codec used with audio-graph-card by
documenting port property:

codec@ff560000: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Dmitry Yashin <dmt.yashin@gmail.com>
---
 .../devicetree/bindings/sound/rockchip,rk3308-codec.yaml      | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip,rk3308-codec.yaml b/Documentation/devicetree/bindings/sound/rockchip,rk3308-codec.yaml
index ecf3d7d968c8..2cf229a076f0 100644
--- a/Documentation/devicetree/bindings/sound/rockchip,rk3308-codec.yaml
+++ b/Documentation/devicetree/bindings/sound/rockchip,rk3308-codec.yaml
@@ -48,6 +48,10 @@ properties:
       - const: mclk_rx
       - const: hclk
 
+  port:
+    $ref: audio-graph-port.yaml#
+    unevaluatedProperties: false
+
   resets:
     maxItems: 1
 
-- 
2.39.5



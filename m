Return-Path: <linux-kernel+bounces-200258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D98B8FADC4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0F781F234AE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C286F1428FA;
	Tue,  4 Jun 2024 08:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyMvAz+I"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C61140391;
	Tue,  4 Jun 2024 08:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717490502; cv=none; b=ec+OxsaJdTI2YrKX7PNDhqS1TEFsHOCtDyyVqF3T265D5mjxgn6/Y+zHYDUB8GLOQnLNYOlbjKPdtgRbmK6w6Nc++ISwkd5/fxDvZvYg6XpbHg2ldgQAqPsQQBLq16CWd8pkvYJYQTvS6V/hODbgH5n2IpFoh9PJS6kQx70g7XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717490502; c=relaxed/simple;
	bh=OukH7axUKSFSKa0GERjqzIGmLSqDV2akze5DusFA7yw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dtj8fytRQielmLQnXxNpOzYYHyueVhOeNr512byA9Q+kM3RuueUBObrLcd4gdnolAEgJJN3+lgkOkWMokE7Sli0XGidJhSDigpojILB6IDVhS5++XVedQUhgICTQmn2XPbSm42bXt8E9fs9XYYAGqnbE4OW/2jgIgIVDA3cyZeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyMvAz+I; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a62ef52e837so79384766b.3;
        Tue, 04 Jun 2024 01:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717490499; x=1718095299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aIbgxo8w7f6oWPnCFgBUedyRxj+AKespS1CLChhNsro=;
        b=DyMvAz+IeZ06VuFSG+A5izDTSErgdHWZpBvj3h53/wc6Ip21nTcrmLI4M98Bt+5tq5
         Rt3XvukHCEucYAHr6D/npdMXKFFhfM3EoaQ576eeyRmMJn5KRDAxDDLRa110Dat9Yl57
         eWYQ88cv/fSRcD+BwaGIHrPrtoVVjAe1Q8DGcjuhRY1DScFbfWZ6VWAfT4eP7y4c3luZ
         ZV5Og2QsAZi18EasIWgh5aFjVT1TKQGOLrOY8O8fYTqq0TQoFWlzDMpS1ExEQwJFUf4q
         13NC/5yauyXF0ql9Yki024HGpCUFJNWN9QYnzDQHMrxHcuMpgV3A0TF6EO4ZTxk6K2Oe
         HqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717490499; x=1718095299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aIbgxo8w7f6oWPnCFgBUedyRxj+AKespS1CLChhNsro=;
        b=RpZGJuFdmrdxDQPuFghV2aLI9r+gFOcHE+B5kybxQR9qw9fHSVE/f7MEMKVDjU9mhx
         K6KCbJPPLXBQfAmoXNJFr5OCRwHn4JnyjzWLmiF2SSwMcHU7wsMaiQBpWWRjRC3pCyaz
         ktWCFiKjWooU0gW3vTJ5pg6CT7i3Xahx4dRv6w+c3wEcPyBIZCE2YJsCkYFk2MdKeg//
         nY0ml4UjuoyGzeg4rnJ4Dyn5wYisw1M/acfRIJ0tzaM11l4eFMS0lI3UEblH7f51aRuU
         qJiNB6y3QKRXZ85/koaVzrnGRMbOall2QHTUzej+DPmspaN4YO5JQZdLlS0hK6PuyN7F
         JJ1A==
X-Forwarded-Encrypted: i=1; AJvYcCUYDWd6Ip22jTEodlmUFYO7Qs/fxMANpo6+/LWFi5g2erMMvlhKOJIROnXjc1MTWZxi9MJKiwTDmk7p5z20H9aOXzve5EjdGNfRIneRfO7COxrjXAwrukuknafCtYiDxxT46n3DXe6wGg==
X-Gm-Message-State: AOJu0YwpFXzzuNMNBwtiNWVfwAcefnwnAYS/OhZOKuY63afZZAhImbwV
	X6PNEM3oI+s+kM8mP330HqDsoLjYUca3voPpM29m8e64GSLCe9LQ
X-Google-Smtp-Source: AGHT+IFc7LrIp3GF7dBgax5xTVe8AqOREA7ZsZQYpQQk2NNJRopNP3qtprZKTr/gzCcH/0pJj712GA==
X-Received: by 2002:a17:907:26ca:b0:a65:7643:3849 with SMTP id a640c23a62f3a-a68224493ffmr936923866b.73.1717490498724;
        Tue, 04 Jun 2024 01:41:38 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a692ad28816sm166550966b.31.2024.06.04.01.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 01:41:38 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 1/2] dt-bindings: arm: amlogic: add GXLX/S905L/p271 reference board
Date: Tue,  4 Jun 2024 08:41:33 +0000
Message-Id: <20240604084134.3315841-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for an Amlogic GXLX based S905L SoC and P271 reference
design board. The S905L is a low-cost design similar to the P281
(S905W) and is similarly derived from P212 (S905X). However S905L
omits support for the VP9 codec and uses Mali 450-MP2 (not MP3).

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index a374b98080fe..77f8dfa86e6a 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -107,6 +107,13 @@ properties:
           - const: amlogic,s905d
           - const: amlogic,meson-gxl
 
+      - description: Boards with the Amlogic Meson GXLX S905L SoC
+        items:
+          - enum:
+              - amlogic,p271
+          - const: amlogic,s905l
+          - const: amlogic,meson-gxlx
+
       - description: Boards with the Amlogic Meson GXM S912 SoC
         items:
           - enum:
-- 
2.34.1



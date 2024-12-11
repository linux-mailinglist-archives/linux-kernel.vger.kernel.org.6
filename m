Return-Path: <linux-kernel+bounces-440760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BB29EC3C5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 04:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E19B22849FA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 03:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138DD21126D;
	Wed, 11 Dec 2024 03:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E5dqKNY5"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCBC1369A8
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 03:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733889249; cv=none; b=apudHMQ0WPdpgtdm17ft50emJwU3/Er8D6Y5Sp7+oeg6AfVdpBnctOlBhbfo9iMzIelMtzVOn21krCE1WmN24bcNtsgCPha8y+nnkG/Qe+8z0MfzICfiGRaatmoGfZDmpfalqtlnAfhODl2Bg5eUi5UuPkh6wvjQ9KLUBv0AlJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733889249; c=relaxed/simple;
	bh=I3XtbIlImj1IOMYUD+gy6ZO5yDL5zDoJrK625xtEw6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TwrhSeqPPZPlro/bEWwgzrgOMYw2F+3T8xwYEg+n3nCMqeBdH2n5IBOhWPIUfXeXA6HcnycKkX5KmDWpFjboArpqojI1uOQvfduQ4zGaPTSm/6jUn8QpBhlMPMbSe0ucVVAL40RupdRmBPZpFvNmouGoe4pbfZHosKdvZi/etjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=E5dqKNY5; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21619108a6bso36371035ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 19:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733889247; x=1734494047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hj85AA7d7cYe2L08PxTXiU5BhO3GZ67bD+np6NHRbRI=;
        b=E5dqKNY5EE0KuHd+RgOe7PVkh2IysOtTdbiZkR0Tml82zI7A3wShmraH/Ey0ssibNI
         RYsHinnNdCOkt2Ypliev/EmZBwbATaDZFckuJQbs5RrtmaOGWoLCNVehxzbCCaw97KWf
         yJV/CgkX1pF54VLndk0BYSTFkI3dV9dZDr8Lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733889247; x=1734494047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hj85AA7d7cYe2L08PxTXiU5BhO3GZ67bD+np6NHRbRI=;
        b=b+LRweBNLaXlNGBJFOXU0pZwGdbmM06nkhC/HIcHtWFfafY4SVLf32ulUeT2mvHvgT
         SJ7uVd+Bd/eJSfd0KBBPSmMn+FV9Kqk8AWUBPZWpkT4588Za9PihAGb8EvTQyrCMiWZz
         AHuPE9uLPJSQz1G2TJI6RuS4TLOv30+Dza6cQiDX5jon1xo1fvH+wwglZOpbpCmDHjeK
         MkqJwQJsVHmCsGQH2ICVz4YijyQMDCvozZFggSnjApfXp6ytNS6L3MZtS5qh8/nwhxRH
         s4rv9mIgXCG9yK4Z7H6HRGaPDTl7h4bMXnA3sB6ZCEudaUHkEtvCM2pz7h7HTXAX4n4N
         zRVw==
X-Forwarded-Encrypted: i=1; AJvYcCXL3gNewMHs+EjJnmX2eWKgsM6QzJWCsg41/lC2kHem9cQA+mDNKIb7jcQj19wksVgB2qlqj72Qm2YhYOg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3PaMACR+cbQA1+Md7+w2+SyxGOHrJB5AKce0IXazWByti+2Hr
	BpiECdHtj/ObW3uhTGiEBgsW78DRZ1jDkk/CybvRpON4SBQNpeVucdJZbR3lhw==
X-Gm-Gg: ASbGncsFYvd+xj6AerZEWpGLb36ewjyeoRbsgOt1eOlRzMW2fn8q8PjaIGqIrzF4wgK
	YPHdGv9eFMQmLazc69/Bm+HhMYjh/DlrgFvP4tcBq/B7w8ZcECNBZm9A3HlhVP0zDBdFk7Vrg5e
	33cvUl+ColkRGBP5lrJWS9j8B5DGZZnURCzEtYUKehFgsT1Yi1eDqPAWnX6tqkneNDjWEj1ynfF
	IzVTp1kr9zTGRUoPFgYecapnfHYSPT66EZ+3ogFFETxqMCWrOk2o40jggMCXh8oad251uTP
X-Google-Smtp-Source: AGHT+IFmL9D+O3T4O8t006Hn2rBO12sN8OA0ya8GF7SZU8FDufxRpciGgm+45zKRIGHZl+ZeYHa8mA==
X-Received: by 2002:a17:902:db04:b0:215:44fe:163e with SMTP id d9443c01a7336-21778397514mr27904715ad.1.1733889247375;
        Tue, 10 Dec 2024 19:54:07 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:4dfb:c0ae:6c93:d01e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f3189asm97532965ad.248.2024.12.10.19.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 19:54:06 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH] ASoC: dt-bindings: realtek,rt5645: Fix CPVDD voltage comment
Date: Wed, 11 Dec 2024 11:54:02 +0800
Message-ID: <20241211035403.4157760-1-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both the ALC5645 and ALC5650 datasheets specify a recommended voltage of
1.8V for CPVDD, not 3.5V.

Fix the comment.

Cc: Matthias Brugger <matthias.bgg@gmail.com>
Fixes: 26aa19174f0d ("ASoC: dt-bindings: rt5645: add suppliers")
Fixes: 83d43ab0a1cb ("ASoC: dt-bindings: realtek,rt5645: Convert to dtschema")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 Documentation/devicetree/bindings/sound/realtek,rt5645.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5645.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5645.yaml
index 13f09f1bc800..0a698798c22b 100644
--- a/Documentation/devicetree/bindings/sound/realtek,rt5645.yaml
+++ b/Documentation/devicetree/bindings/sound/realtek,rt5645.yaml
@@ -51,7 +51,7 @@ properties:
     description: Power supply for AVDD, providing 1.8V.
 
   cpvdd-supply:
-    description: Power supply for CPVDD, providing 3.5V.
+    description: Power supply for CPVDD, providing 1.8V.
 
   hp-detect-gpios:
     description: 
-- 
2.47.0.338.g60cca15819-goog



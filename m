Return-Path: <linux-kernel+bounces-333432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1903497C88C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 13:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE36828805F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 11:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B57A19D8A0;
	Thu, 19 Sep 2024 11:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mo2M6JJ9"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE68F19D09A
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 11:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726744928; cv=none; b=CK1AXLXugbdhbQn6XlvrlryVqOZnufZCFAEaAb+Cs9kuuqMu5ecwJsUdXrzEAPZuPgnTIHlvXfT3QlG+S2M0Hs0X6pxqwiteDy2TkleHnYRKd5Tr/l4vR2MA6WrOIiHS8JMuTBUEuagS2i2100hgPPNylkHrdSSWHKdiRjdZMdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726744928; c=relaxed/simple;
	bh=NodEbH7krDUcfkRufBuX0J5bi9z9rOrv552RXMIuyC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejBQyWlK/aJjhVZNrsaT0ejL09KAj9st2hBrCW08KAo+z2c0snqdqLIPu20nhCeHd2mMUNaSkl9BeuF1mwUmk4+j7Yh/DNcrGXv3fLxN4ZxHs7KccajTTPki3OD7+K0m4BSxuUD5y59g9j3xMcuaTTHcdU56q5D0DvnQf8FzWgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Mo2M6JJ9; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-206f9b872b2so6395635ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 04:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726744926; x=1727349726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwMdY8rdxam8QM2rdLhELR6drCqsB9RkOgkWUwEo4Nc=;
        b=Mo2M6JJ9QFkWM8e9q/aoo4izj4LaTsnojFii9OEQUs50q8tqANX3v4j2KVHhDYKCBK
         AcJwo1LNkZ+NXq9CAHnc2SnVy6jEhlo7XM4kycFsgP0q9dJ1BeAk0muXMrz8wf5HLcS1
         kW5enCHhDUWVd3xPLhIvqYE6GKuGJuB215OB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726744926; x=1727349726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TwMdY8rdxam8QM2rdLhELR6drCqsB9RkOgkWUwEo4Nc=;
        b=tLwRRmV5iRv855PLRPizWGRr+VA1ifihhxmJZfu/mb009biye4wJLYQNLp0CfGncxL
         LY/ON9RUdM9mZzrrFsbOTmx19zw6fmhf3C2esyqBMQqJ0TyeI1gTNsLqOpfYh6E0h1vi
         FEV2HcV832IqRs97zx9iX2iMG5N06gMKg7P74SsPpSes+qud6dcHC5tTs2H0f6d67jXn
         zV8JqdFSDOeCxJ0xaaqCPKl+UVnDw3BBjuSkePbCL2E57U0JeNV9pAefthqJevYBw38/
         SLvv326BXgYzx2fGjHsXeloykuAoVNpiGbnavybJ6Xt32B7Vqg0OW0vnDgKcf+lH3/+S
         nADw==
X-Forwarded-Encrypted: i=1; AJvYcCV4uym406w97LW0XOgTa8QgkmMOpfsQuXgrum0SU+sOAigvV3CTLWmnEDoXz7N7RBwgUx4rY9G+HxH9ezc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ynaXWkwvzrgGy8+HWEnGnq4jjOyX3IrIRFI9QuO2rvmuR+NY
	QBQf+Khyn1s68ssgMKm1uY/Tu5g1piukUGMOfg2byaj4Okz6cf0tCSM5PwelbQ==
X-Google-Smtp-Source: AGHT+IF7NZIzRSvq4SPW/ooEciWdwOfEcj6TQwh8am9csyrkRhBcF6KyEh38R7s9Np38/enguUBOVw==
X-Received: by 2002:a17:902:b416:b0:207:3a45:2be1 with SMTP id d9443c01a7336-2076e4854d2mr294228205ad.51.1726744926008;
        Thu, 19 Sep 2024 04:22:06 -0700 (PDT)
Received: from localhost (117.196.142.34.bc.googleusercontent.com. [34.142.196.117])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-207946dff96sm78417475ad.128.2024.09.19.04.22.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 04:22:05 -0700 (PDT)
From: Rohit Agarwal <rohiagar@chromium.org>
To: chunkuang.hu@kernel.org,
	krzk+dt@kernel.org,
	ck.hu@mediatek.com,
	robh@kernel.org
Cc: linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Rohit Agarwal <rohiagar@chromium.org>
Subject: [PATCH v2 1/2] dt-bindings: display: mediatek: dpi: Add power domain for MT8183
Date: Thu, 19 Sep 2024 11:21:51 +0000
Message-ID: <20240919112152.2829765-2-rohiagar@chromium.org>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
In-Reply-To: <20240919112152.2829765-1-rohiagar@chromium.org>
References: <20240919112152.2829765-1-rohiagar@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add power domain binding to the mediatek DPI controller
for MT8183 that already had the property in DT.

Signed-off-by: Rohit Agarwal <rohiagar@chromium.org>
---
 .../devicetree/bindings/display/mediatek/mediatek,dpi.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
index 3a82aec9021c..1e748ee23fc7 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
@@ -88,6 +88,7 @@ allOf:
               enum:
                 - mediatek,mt6795-dpi
                 - mediatek,mt8173-dpi
+                - mediatek,mt8183-dpi
                 - mediatek,mt8186-dpi
     then:
       properties:
-- 



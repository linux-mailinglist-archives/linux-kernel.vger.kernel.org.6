Return-Path: <linux-kernel+bounces-225719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B68913454
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 16:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B185284CC9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 14:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE7416F859;
	Sat, 22 Jun 2024 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPN7o4Mx"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A358016F292;
	Sat, 22 Jun 2024 14:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719064880; cv=none; b=Sp0M14xxn4NMdZ5+qXmP4+diX1wIxfFLwAj3XH8RTfoZ6UaYhYeEQ6NRrTAUvBcwFhF55wNx0MIy623NzdZI1g2ES/vJTGEddE0MT2py+xV9v9k/FRRsFk7zc8JjuhHYVTwqtYudqPIOwHxZ8SA8QDRrcRC/XCP7CDsbo4v6pig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719064880; c=relaxed/simple;
	bh=lJwt/8xJprkQId/LAKYz6hb4Vb5UyZkvn01mDU5U7W0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UrVQ3gsOvN4xHYIolTkK/VrgrT1+QKhmPNB24G4ZWEMaH4P+Wrb4oB1KmL3+JoQEXTfzG+LKEhBeWQNi8ezHxfzC8BugR/xvcaRm/Ar6V00XxFA8Zh8LdDwC0d1v7mi+IwkGgWgxAo/XDlqH+SEcDlZLdD8XUeb2dXvxHebfWJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LPN7o4Mx; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7241b2fe79so24053466b.1;
        Sat, 22 Jun 2024 07:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719064877; x=1719669677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lzSErGL7EG0GwxTTihW2ZGVx7A57o+5iWBzaLRdIdFs=;
        b=LPN7o4MxEZv9iHsioWoVrg+dN9UnAprlixmMtPEC+p7pWK5qjsz1RDt7eA+bEoIAIW
         /oEh5/OfcXwQ6po5IhV9o88ladR2x+X9Znnp4/VqopxScklV02kAa/JFnLDr0i947LRf
         xFabquue8dCfOqpvt/QJM0JoUoGVdBPhG+N8uAAuQ0GBepISXcSNbrqPBhzWHtAV2H9z
         M7Hj/OZC3GIJfcjHOGoG+6sHrVCZRH65OKAITqbIHbSentVdPyJyVXg7eFunT8OPHZvv
         L/b5YBFkCFOfYPNf18vLplQ84fFR6yDeo0wt7CD9dQsm4Ce92M8/yh/RTalNHU1wE7/S
         44qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719064877; x=1719669677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lzSErGL7EG0GwxTTihW2ZGVx7A57o+5iWBzaLRdIdFs=;
        b=FvS8biKw5Lqgv72aAE9J2uQXr0+/7Gpmr27eDxN1mT8MRfWjkFrpIj/Tkuy7kzK0NH
         /ma6CdaJCaIbU/1qVj7onOX8K7wgQYLnfaaJ1qqOMBy0jyQfZCHleQDA3hWPmQ6zlhOk
         HhBcxe8rstHY1Jm34ioLvGCvA7947eN07eTxIlKzp/3WPl/MT3jVh8hYEUQNYY5sZEHs
         Wjp/sScGg9Nts0CxGPWqIydJnfggVwOyCUqdDJEGUnEvnCFjkpkU+zsCLf8vkYA15Gr2
         OI2LzNmA4FNsuBmPSrBduKNOw7j9I449nKS5+hvpLxBf9c2OOPIp122+NTO0tLzDfx5y
         kXFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5HFp3iJUMVXdV+X9dN8x+Y9R/CRJ3lc2BRD/3DdLleggjQLmZGPmB4TvrbTGNp6aG80YhvEO7RC7yzX0U6/B3NoEbpNUPt0Pfe9fXpc0sd/zE4t5JJEvX5T+MObOrmeegEuwtbUPJaA==
X-Gm-Message-State: AOJu0YwqCYPOHPE8JcpMV4nBWSGptINroSX9FlrJdK89F+3c30ETLxHl
	XkTbXg/oDPpYOVTam7gJJRwZ2HC7mDMTwySMVBw64I/z21N/f0CE
X-Google-Smtp-Source: AGHT+IGSzgQci76PPWu3XEOEhCJsUeaxFcspKllKriEC/thW65d45nZKtOz6piqObtlVIYUCIsxQYw==
X-Received: by 2002:a17:906:d013:b0:a6f:4e1f:e60b with SMTP id a640c23a62f3a-a7242c48e6cmr27180066b.36.1719064876807;
        Sat, 22 Jun 2024 07:01:16 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf549166sm198715166b.132.2024.06.22.07.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 07:01:16 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Christian Hewitt <christianshewitt@gmail.com>,
	Emanuel Strobel <emanuel.strobel@yahoo.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/3] dt-bindings: add dream vendor prefix
Date: Sat, 22 Jun 2024 14:01:10 +0000
Message-Id: <20240622140112.2609534-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a vendor prefix for Dream Property GmbH

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes from v1:
- No changes

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index fbf47f0bacf1..a6cb1eb8e5e0 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -394,6 +394,8 @@ patternProperties:
     description: DPTechnics
   "^dragino,.*":
     description: Dragino Technology Co., Limited
+  "^dream,.*":
+    description: Dream Property GmbH
   "^ds,.*":
     description: DaSheng, Inc.
   "^dserve,.*":
-- 
2.34.1



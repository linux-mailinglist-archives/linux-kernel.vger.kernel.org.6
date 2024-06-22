Return-Path: <linux-kernel+bounces-225716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6A8913446
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 15:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38DF31C218DF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 13:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4139C16F298;
	Sat, 22 Jun 2024 13:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foj2lSfP"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1193914C585;
	Sat, 22 Jun 2024 13:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719064285; cv=none; b=geZtMd9aCP8AYMJCfHqLqU4W1nr1vFrk3RR+eXHUwALGiZe/Igva549aiFNfFLqJu7xIu/vlYCdUdYKGWnE4hRFyWhjvm3JBlbKZ9t7qnMhQME2P9RYa7zCORGhY8jCxEJLqlDCMdcCyR+24o4B0Rs3KoZL/93f1gIp5taO6RzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719064285; c=relaxed/simple;
	bh=mZmY0HpFiRNOOOUC1amY+Upp8c4bt6ypJeRAlU60nwg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jTYX2sgkVI/SAV6vtolJNmkXilJ0R4EzEhMDg3EI/Ep6XQdK9IVumgm0fThdOR6MTkndif0aDhpY3nQuNXh0ba54BpwvZtjtLklZt7/KLCyU/K3mfnsZiACIu/xa6VD3WjUkSfM6YPJu0C9u3wL1yrNU1g54pFaWLPpofWsSSYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=foj2lSfP; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57cb9efd8d1so6475921a12.0;
        Sat, 22 Jun 2024 06:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719064282; x=1719669082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7m/4TgcK/46+XohDU829/0NUNXJCTGCTV5XM9hCUlVI=;
        b=foj2lSfP9U3LRQglQu/D3TRE4Zwu5NLOzIDZLQKYUpLWayEphmtppkBcQXVsLWwkqv
         uz64qh0++CoEeopjdknuPUPzpauJJWlgUk0wbYEbUhdMKQ++08dKSTPQwseOYLrTeO3e
         0KAFZC43gTr1wF1YoXnISEPhcOOnnUoy71AOdKJRYGtBKHVj/Iyb4OL0tWa3BSLKzqC5
         7sKYnqWG84yHPmLsTwgjSbTtPdpz3mzRSY6rOwHIGh9Y7vHpX0kYFomPHlXRu7FeWHaz
         zh/PFD4fsDv2sOy4jg9GwLrEqTpECa0ujiG/GJyX6Oq+nSbbz4Hi4DyonN0MMQk6208U
         xYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719064282; x=1719669082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7m/4TgcK/46+XohDU829/0NUNXJCTGCTV5XM9hCUlVI=;
        b=MuxOfBT5VcWOyONmm6GBsrb8cZc6KCD/ONfy5D6vsKSrk+P42Z7JZbRohriXvfc1W4
         738U6FNvK0ulPE+wa1E/m2kioOSHYQHT+kRHyxDTfsE97oBJp4cZfb+oJfaYlZJg+cvi
         oT7stxgrgPrZ6liko/FZUXthXAzNwWxlYEXesnCXFJSwq16g7+I85oqNoTVe/kmiNsU5
         BCeKnwiN5WMC9w8qjuxcU9bxnBwViGdtgn2KTEL0/x6R191hQOLiu1lyA844qJ82HfgP
         gTGHynlSvdAIh5Dcm4LuQq1aVz9hVG78/5usnCZH7uYj9S1qrjhLASKLfTleqVfiBl3R
         j2VQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIu28bBlBT/M03UW7I2zMqMtn+Cd554RwxN2n6mfs9r3yETS/zPQQgBNO4rryUBYPz7WQzW8PfpGZIoCKPTKyvD9S9xWSHVAneII8JZdFYUB+9FIRIZ81wQrjF3Giv2bO7ihZXPCeyAw==
X-Gm-Message-State: AOJu0YzYqy7wbqB7p3wng9fjEWdzULFqMSnBmaPwUItAUevuLACh05Zt
	ZUm44zenEYYyyl+uZ9iydPdr6S59Sqk2F+zV1Oxi7xqSHPm00ZSM
X-Google-Smtp-Source: AGHT+IGl8/QbmuwmI7VAEScIvWWlg3EjsJaT9RlaUARyv+fkqsaP/e2hjjAPn6yVnGn46bqlGpDVOg==
X-Received: by 2002:a17:907:c30a:b0:a6f:4b45:ff6c with SMTP id a640c23a62f3a-a702760c68dmr109293266b.19.1719064282324;
        Sat, 22 Jun 2024 06:51:22 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf428bc0sm199398866b.8.2024.06.22.06.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 06:51:21 -0700 (PDT)
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
	Sam Nazarko <email@samnazarko.co.uk>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: arm: amlogic: add OSMC Vero 4K
Date: Sat, 22 Jun 2024 13:51:16 +0000
Message-Id: <20240622135117.2608890-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the OSMC Vero 4K Linux-based STB

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes since v1:
- No changes

 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 77f8dfa86e6a..9b84a18cf41f 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -91,6 +91,7 @@ properties:
               - libretech,aml-s905x-cc
               - libretech,aml-s905x-cc-v2
               - nexbox,a95x
+              - osmc,vero4k
           - const: amlogic,s905x
           - const: amlogic,meson-gxl
 
-- 
2.34.1



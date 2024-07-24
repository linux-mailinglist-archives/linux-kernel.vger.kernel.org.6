Return-Path: <linux-kernel+bounces-260714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA6793AD53
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDC0C281695
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 07:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9506E2D047;
	Wed, 24 Jul 2024 07:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEUDXOYQ"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984BA7CF33;
	Wed, 24 Jul 2024 07:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721807052; cv=none; b=OZHW7Yc8I2SeRophFU2QrPfg6cIRs+SivMO28B4BOl9KdwUaokPjBOVlaVKjJ0jfrBKblRPea5NcwU9yd35kf9ABIUDsJi5uCivQnqgNiTSAEV3I9iqmK/BWQYEpTfgb4jioz8y2r6qY5RpBm9HGVjl6C1SlmBdU9+fFyxk3B08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721807052; c=relaxed/simple;
	bh=wZM6LoO4PA/XB4ycTumABemVy7G9m8wLw28advUxNRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KRCN6sj8xlogXPsKNjtCn/4QkV6UsYfOzdYhO9LAnWxZ0wCZqlKb+atlBs0AfaxPx5I/EPLVTqQCGGuJA2IJrL7UM93Ad6dSMPwl3Bt/QorXC6W/J+5RGoc9hBTaH3nCs+wCzBX2uyN3rVeCrUVzNmw92X4f9NEB3vyEDo79pj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEUDXOYQ; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2cb5b783c15so3801243a91.2;
        Wed, 24 Jul 2024 00:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721807051; x=1722411851; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kzCkDzQg10EK8n1YgINi+79HQeehaLLCfYvwgSxxax8=;
        b=NEUDXOYQGBaULAFBsFjYADf8O2wBIx3EbfQX9ymKzBACeC7D2qlkTlAxRd6gos8+kd
         88w9sYu/BUQ1njwxvNGH8a3baWTA+UVze0YA0ra+HHnhezBqKEiseoBlNn/tj2CbCdOE
         7XokmrItmQrEbL1kNIVm+ealZ+K+P7TSlLtsH5cJMuOq2p2F8t/0vh/eyoR3KDHMnl3F
         MykDYcRi4Mg1MLsjnHOigCY9Vo/7TfiB3Zwh6rc5+r26eQZxOdE5Jh8WLi6FzZRnPhhF
         fd6kDmJeGS1fkxJ04yxwQLG5IKCFIElNEVbXcnLatP3NYS/TDFrPzPYgR6Q11EFSKsUr
         fJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721807051; x=1722411851;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kzCkDzQg10EK8n1YgINi+79HQeehaLLCfYvwgSxxax8=;
        b=bBD/qr5YYIr2Y5ElCoBSRt6aRiurDAmOnn6pxaKu3KOaj5E4ozoUG9CFts3EL5OuDG
         h/+MBcobKgbLFxH9xIGx6J/qvOUh/AdSEfJTShXH2lYMwg0M6TLqHmqVu3FXrDIrqCWB
         iSHk16riCXhDFewkZQv7ntHIVfOmdXgdClh4DK1xkf4Z3oEc19HyR0c0BoCm0gOc0/Pu
         1j4pVz+NRU7druQ2hKIt9WgZ6FlfTE8ps0zCfXuLLYzQIy2RW182CRv2UaMjMXe9uq5m
         HUt6ShV/JppXkGR+eUVpOdIFIDhOpPRG8cpOvc2w5GKHTY0KGNjEKmkDOG7KLSzY6DVN
         CIdA==
X-Forwarded-Encrypted: i=1; AJvYcCVpwVQkWeQmvxWEfQp4UEWxqIBj8JTeBoWYC9BYki5RW8QrJ/Ztrvd+0ELARP5baJiaD+scRWGu+6vF/Wy/FsWBY//biNW3lf80QP5a
X-Gm-Message-State: AOJu0YzeibjJaTiZ7t9z18D2wZ1kg9zTuG+r1n6iO9zy5FsnFUtEomar
	LFhN9UC1VY8YMcH0jTJgy+p72w68AAy0X6HHUqEaEomViHQ4nmIn
X-Google-Smtp-Source: AGHT+IH8CIR3C99/0tJLuAiMGkw32cnrVweV/bSOv9E/oT9iydHKNnO+muDZhpdC3V9xHc6tq8MqzQ==
X-Received: by 2002:a17:90a:9e2:b0:2c9:8a29:b189 with SMTP id 98e67ed59e1d1-2cdb51a5fdbmr1438801a91.31.1721807050838;
        Wed, 24 Jul 2024 00:44:10 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb74b9ed5sm901067a91.49.2024.07.24.00.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 00:44:10 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Wed, 24 Jul 2024 15:41:45 +0800
Subject: [PATCH v2 1/2] dt-bindings: arm: aspeed: add Meta Catalina board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240724-potin-catalina-dts-v2-1-ba8d475c4073@gmail.com>
References: <20240724-potin-catalina-dts-v2-0-ba8d475c4073@gmail.com>
In-Reply-To: <20240724-potin-catalina-dts-v2-0-ba8d475c4073@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Potin Lai <potin.lai.pt@gmail.com>, Cosmo Chou <cosmo.chou@quantatw.com>, 
 Potin Lai <potin.lai@quantatw.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721807045; l=879;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=wZM6LoO4PA/XB4ycTumABemVy7G9m8wLw28advUxNRg=;
 b=YXZ0dJsps4dfzJAmURmRwKSr++edNGb55ka5r/MVbc+pQf63V9iEhtwmo/imtpO5LNcL1KdGd
 J2I1akelX6xDJTm3A8hvvTKosFiDf12W2RV7qKRpxzfa7V1u2ZYiY31
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Document the new compatibles used on Meta Catalina.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 95113df178cc..f1bc2bb7b670 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -79,6 +79,7 @@ properties:
               - aspeed,ast2600-evb-a1
               - asus,x4tf-bmc
               - facebook,bletchley-bmc
+              - facebook,catalina-bmc
               - facebook,cloudripper-bmc
               - facebook,elbert-bmc
               - facebook,fuji-bmc

-- 
2.31.1



Return-Path: <linux-kernel+bounces-274945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE830947E97
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762F01F21952
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A4F15B54A;
	Mon,  5 Aug 2024 15:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGdNI8dX"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA3A15B107;
	Mon,  5 Aug 2024 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722872946; cv=none; b=giQ8xjcq26xTep43/Al/djSeUzyqalJMrDQOCISUgKJ+A+xYNS5kCyCg/4yA6VeM5p1boWzW5T4rrhn64aKnu4LNpO5Qcth+AnDP8EgJf0RBLW9bA3Tg1ujPNSnkBf+/SIcS+di3hUgk2Ro4vmooeqQXaUflGkTM5hn/XELhH8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722872946; c=relaxed/simple;
	bh=wZM6LoO4PA/XB4ycTumABemVy7G9m8wLw28advUxNRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=odBjGEbdOWpKSofmGZMMObGftsudvBQMLLm9wLLq2dv4G076JtC04Tn6RioYRwdx5cFSicOUTtrnusRBQhNEthe4xZB0DVDbVSpGpycpq/2UWDRzNpccwDfKGIY/KizeObw/EddsolnCOLKNZ+/KicbQ16WAuFr4JBpk70ebnog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGdNI8dX; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc56fd4de1so40336205ad.0;
        Mon, 05 Aug 2024 08:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722872944; x=1723477744; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kzCkDzQg10EK8n1YgINi+79HQeehaLLCfYvwgSxxax8=;
        b=VGdNI8dXcJMxb9ReQTG75GkZKvEhA3O7yEMauQgId4XndmjWZejjp+o0ALhipBH0Ut
         5Gpl3caluuAIkWc7NiCxPtLYTilMZDpnCqv36szz3+z0DPnn/3+ABmAGIkXavIAlMOdJ
         ATtP4j9KAIu4bOQEaBtSisVy6ITGFj2GpbZc1EmQhv/jGn9jfmz8pGEcP9NwtirTlrsH
         rD7Q+iqpbowGQczHKC5/fScY3oyPzkzG9LuIsVYggjKgHKbgkSrMnEszCP8X8LBzHUiK
         L4++eZ3vQQ0pDc6aZtjgCkEf9Cd0it5BU0hnmLtozKEBWRq0jLdgJS//ySU4MRex64GA
         +s9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722872944; x=1723477744;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kzCkDzQg10EK8n1YgINi+79HQeehaLLCfYvwgSxxax8=;
        b=P61vwsQXUfiBZoL3ABUY1H+WwCCpnZ7sPEvJryDDlcTxEl2iv/nr9otecUmnl6hibW
         4uiTi09srnkxLOdsCDMV/RR1WLpNAwyUUKSZYeaSf0XVzxOZMxd85RK6dQjthPrJSavl
         zGWmNEymc+bRWWP1Om3Mmhe9hVXyPvw90Z7ZM24/pmq24C9JMjAaCLm0sATwbsFYpFgx
         CAxtd4kRVurv8CumDS4kDenSPs3lno8JDHjIRckGy5DXN1/sfy+4UgUYV53MNLM9vg6+
         n57eAaPBnLLguSm/3OLoWJb2fJBVNPvM0DIblrxUWci3Pjp96znHDKRBIlgAPSiWeQWV
         Cd7A==
X-Forwarded-Encrypted: i=1; AJvYcCV2azdDua/liycm7bbYTNc004vG8vZFvxshqQUUwmR0T/5hZ90cuY9iPEG7Bf5MLZ7/CWzvac2hRabMpUqEG56DyyO3UQeHPMzXDYNE
X-Gm-Message-State: AOJu0YyzUYB+EY9capKHOxlFYaWRRbN4F3XXsINtYSqQSykX2qL2ExVu
	qyA5CB9c0amMw1KJOD9eLx3vmb/0R0DoaZh6lYdl5RNny1dJqj1HQAC8ew==
X-Google-Smtp-Source: AGHT+IEbBInNiyR5FNrttMEq3Izoz/xBu86bXwbBWqbgHPTmugXRpKfArkyJZGwciwHb0WrUgehH5w==
X-Received: by 2002:a17:903:32cd:b0:1fc:4aa0:fad2 with SMTP id d9443c01a7336-1ff57b5f1f4mr200027445ad.6.1722872943753;
        Mon, 05 Aug 2024 08:49:03 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5929ad84sm69478215ad.270.2024.08.05.08.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 08:49:03 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Mon, 05 Aug 2024 23:46:27 +0800
Subject: [PATCH v7 1/2] dt-bindings: arm: aspeed: add Meta Catalina board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240805-potin-catalina-dts-v7-1-286bfd2ab93b@gmail.com>
References: <20240805-potin-catalina-dts-v7-0-286bfd2ab93b@gmail.com>
In-Reply-To: <20240805-potin-catalina-dts-v7-0-286bfd2ab93b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722872938; l=879;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=wZM6LoO4PA/XB4ycTumABemVy7G9m8wLw28advUxNRg=;
 b=1jvwXgN09RI/PUSMDxEF1b/e22yrfVHmgXfKIdE8FpYjO++fxRG2ixrBd56+q8BJrBLm4PljI
 kfYOpLy755kALVXkWC6an8ELkWYrHjrFIvMaFjTDyw31O1FFouHBp75
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



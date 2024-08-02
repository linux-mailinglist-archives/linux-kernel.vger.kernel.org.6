Return-Path: <linux-kernel+bounces-272347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0526B945A8C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 11:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B012B1F2457D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 09:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218DA1D365D;
	Fri,  2 Aug 2024 09:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6LKNONW"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129711D363D;
	Fri,  2 Aug 2024 09:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722589853; cv=none; b=TU3hi+lRM6BpNK07zA5QzSH5EQ6vD1NZmpZRPV1ZloxPAYn/9lLhu4ZkA+ZdV/+2kW1xcpQz1fPOoyIsoaZICb08ZVKJZ97Atohi7MlCCo4qz155dQKSUAAO6YS30wpMzIxcyhSloGkOVm6/cAPJeK0F9u8C+fJ0X0DXheskgXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722589853; c=relaxed/simple;
	bh=wZM6LoO4PA/XB4ycTumABemVy7G9m8wLw28advUxNRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TvoEBrjsJ4Khyx289K9onUg/y6ngA73ye+QRLhtd3fbATUsdYy3juZuH457L5M0OK6jFQEnYkw3HiaRECnnpk0LVbBfqxR3UKAZZqjLWJEX2h1VudyyrRz/7RpTTcRXgOQamsBrATSjxdiGAmd0UFsL3vRzrH2ntNxobrkZRulk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6LKNONW; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70d19d768c2so6129973b3a.3;
        Fri, 02 Aug 2024 02:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722589851; x=1723194651; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kzCkDzQg10EK8n1YgINi+79HQeehaLLCfYvwgSxxax8=;
        b=e6LKNONW8Hcy5/ttqJythCqNQiihzVerMSP9UbYuvTudYhtp+C818ZATR6aXe19gf/
         RixeQ9dtCQVIcKdaPtrMx1qzGoAGdY0Q3kiq2bpByTmV0djWGPYPSA7QGjC4S9/xAZY6
         lhgg8mWPqJmovBkCjSwe/M9er4mtTFD3XKMjw/9iLmGaDkOvrV1tD2u8LxcY4wf+vR/q
         uXFjXI61O9ee+8eYU/nDx0lf7DjQPtrSCvD9ZdZKacliv/LYO1OKUAeAkSGgRYyxRqqf
         Fl9FnX/EgfDgdiqX7/VRauPxEhSDWOoW6NqsrqMEKXBfzyRayj6IdY1b30qq0M7YCY9l
         vM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722589851; x=1723194651;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kzCkDzQg10EK8n1YgINi+79HQeehaLLCfYvwgSxxax8=;
        b=OvNIXaM1yRhQNBxEZ0JQxw1k/b+NDVJBvx/bGM2FJUWYK1LPWpJaviKgE3XaFMxfC+
         YQo6nDXUR/WrmaJNUTysBJ/NBAb0AB1VC6pppyh+KgKvm5dTrJ+valZbVFFQQiAWXpmA
         SuOqI57ifciZEKqF6vY7r4Y49pEBrS4qJM2d7RkJmGcNYY2HHU2n9olNic+607s7fMzh
         etipFlSA5Wg/a1Lj4agN++lSY+EM5pmg26lsE0L82K/8t832tbbTxFI0TN9yb6N+NRSE
         hBGae6Y+kwH80uumdRCVddpruaZJPoZ1BgSoym5vSgQufKRMfLu11lrlE4ETHQjYtGCO
         rxXw==
X-Forwarded-Encrypted: i=1; AJvYcCWLzN2tpbdPPUQE76i9ZYH/lk/d7PEZk0gkSuZp2wQBJTmJ7mMB377YVbdBmQ4NxsICDUM2eGZxJGSl5mq7uVsYm2eJjjiD6dgcDaml
X-Gm-Message-State: AOJu0Yx9gbjVElBQ8UyaxeGo+RHJDi3oy9E5PSp0fk9sy/Z5nBhqefNq
	8u/ZWf2NLhzqMI4kIcZMVAGz5X4KVlzq8uMg9wWDRrFrg517g2F5/+nIwg==
X-Google-Smtp-Source: AGHT+IEFrmC7YhTZ2p/did8YcX/HUIj/lWUcw4s2YvO23C207GBu2bgytaE/SHvIcFBVT2LAUaUTHQ==
X-Received: by 2002:a05:6a00:14c8:b0:70e:91ca:32ab with SMTP id d2e1a72fcca58-7106cf8ffa6mr4213333b3a.6.1722589850930;
        Fri, 02 Aug 2024 02:10:50 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec05bf3sm1034145b3a.13.2024.08.02.02.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 02:10:50 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Fri, 02 Aug 2024 17:07:47 +0800
Subject: [PATCH v6 1/2] dt-bindings: arm: aspeed: add Meta Catalina board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-potin-catalina-dts-v6-1-0b8f61b80688@gmail.com>
References: <20240802-potin-catalina-dts-v6-0-0b8f61b80688@gmail.com>
In-Reply-To: <20240802-potin-catalina-dts-v6-0-0b8f61b80688@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722589845; l=879;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=wZM6LoO4PA/XB4ycTumABemVy7G9m8wLw28advUxNRg=;
 b=85T95yZ+AIPCpHbO25SIMKP97TSUcCuT+AHc1DKJHL7+qR+pWCl2q4sTdViovOSvZVwX1Rxsp
 qPT47Nah2KSBWERvs6/j+Vz224agt9SYUsLu8IFqoyGRW71Qh2CprmA
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



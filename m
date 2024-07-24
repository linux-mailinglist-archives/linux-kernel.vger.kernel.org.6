Return-Path: <linux-kernel+bounces-261261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4881F93B4E0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 18:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAC71B2164F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2886D15D5C5;
	Wed, 24 Jul 2024 16:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Viowo6j/"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA8115ECD1;
	Wed, 24 Jul 2024 16:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721838109; cv=none; b=AgZCmu0JO9P6trKP472NjH2z89eZEX7vowRTbvGSP1L8ciqWb8XCFYLIDO63d32KM0HQu91aFRmvHm57Ogn/oCGXmrHi9JUIkVobNn4jwBZAGs2bOiv9w+NlS1uRlcHijqrnKGss/4LIGweLvETMbYv1tpRZhr+MpKWDbijGnCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721838109; c=relaxed/simple;
	bh=wZM6LoO4PA/XB4ycTumABemVy7G9m8wLw28advUxNRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u6VBZa54RMD92E+fj2Tsl6ShO+0tBgsA4TYps8XAH9W50k0pi3528WraxLTy9Kb9RzobAp3YJleLNVoDr7QZks415dhqEfMhfQK01ngNJz+h9hQaWTmDeNbuwoQnoiiw9tJJ70gT1gY5C7YdTRe97d4g9+rTe+vo12WQo/dEKkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Viowo6j/; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fc692abba4so18623195ad.2;
        Wed, 24 Jul 2024 09:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721838107; x=1722442907; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kzCkDzQg10EK8n1YgINi+79HQeehaLLCfYvwgSxxax8=;
        b=Viowo6j/NBrKdojF/9VQxLaClPfBhr5Ke+NOG+SNI/ALozRDcT/mmoRP7mJ3Z+vaVu
         88FIM++CYYDZ9CUA+gkyDER2AHisxVUfL79Pg0UXwEc6+zC6BELPEA5O+u6EmKqvptFt
         DHL0bvqTkIOsLqaKgnJOPELCa+mPlJuIIH12iWykzZXy//F1O1EysH/CAcsKaJNoGElL
         SBNJsMTTdyVmdlW5+BOHiHIG7i8+QhjpAdi+r7uZRh0TWGSb9SpLkuX9reQOUlidpOjb
         v6x6lUdKbphdiQIJSLW65qzX1h216sv+ntz5uEwcxx3QAIHGnU7SCnH8GoQxiW6HEaBX
         kaYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721838107; x=1722442907;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kzCkDzQg10EK8n1YgINi+79HQeehaLLCfYvwgSxxax8=;
        b=ms2aNbQh5qG8rAaRlSuYjbOp4yYZfNjiLSSRMJE4jPVQqjkSpxs3S99vClaRqCoG0c
         XLzE98GARFAkyGsg1VaCde1zhJFYpSXALf2tqoXrWdeEKQixpwXyrKECVXzbEPZcXMto
         RfpXkMvqG4ZXzO4CU29hk1p2Uj95SzmDHo69/nUXgTJ3N8Dta3O9glPyDJhM8B7BbfmA
         N2qm4O/IG01PoWkElqGpWONjxlWU51SctvZoIXXSV19qqGclN8Awr/jUVRVKJD18BaPk
         HleCLrtRxwODsVLo5DMgUVqqmJtq4OtmH8rG7VGgB5hlhQm5fDGuMrpJDWq7AHfADDqg
         zjHA==
X-Forwarded-Encrypted: i=1; AJvYcCUVTAwXMPk/Gx22NgcrQ5XC5wlR2/4p7Fzizmpw+RKTiM+IGPTq6FkGx8eGdB8lk46HDCF6RkCWau46uxkWv/iHMhPPm5jTTya893VD
X-Gm-Message-State: AOJu0Ywq2w4RG6eJ4YhTGfZETAjJqK6Tuy9jRk7dkM0RXAkcguXEUZO6
	40JR0plq6ulm6kGJ2cviQwZFN2QM3NSeoBBAVE/+JY5zO/tcPB48
X-Google-Smtp-Source: AGHT+IFmVIq5MOZhwZyzNj4etEKw4pDAYhrD19DihoWnrKMd9HnKB5MUCa+wcdkSrdKEF8iYenhk7A==
X-Received: by 2002:a17:902:e888:b0:1fb:5c3d:b8ea with SMTP id d9443c01a7336-1fed3535eafmr743755ad.13.1721838107318;
        Wed, 24 Jul 2024 09:21:47 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f31bd9bsm96159635ad.157.2024.07.24.09.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 09:21:46 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 25 Jul 2024 00:19:18 +0800
Subject: [PATCH v3 1/2] dt-bindings: arm: aspeed: add Meta Catalina board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240725-potin-catalina-dts-v3-1-3a5b5d9e6dbc@gmail.com>
References: <20240725-potin-catalina-dts-v3-0-3a5b5d9e6dbc@gmail.com>
In-Reply-To: <20240725-potin-catalina-dts-v3-0-3a5b5d9e6dbc@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721838101; l=879;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=wZM6LoO4PA/XB4ycTumABemVy7G9m8wLw28advUxNRg=;
 b=pzmrDzs5Wf7+kxOibz7dBQF7gqeY9uc8vV6GVQ5gVwU7v28vmMO1husytU5+wmD+6JGq+/z2u
 f6qQObBSCYJDC+FDFDmymIQa/hm1A0ZwkBoAWL7s+bKlP7ddb57Sbv+
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



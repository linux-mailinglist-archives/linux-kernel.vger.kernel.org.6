Return-Path: <linux-kernel+bounces-261260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D19F93B4D9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 18:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA1AA1C21F15
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6426615ECCA;
	Wed, 24 Jul 2024 16:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFb/xYhW"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D2315ECC4;
	Wed, 24 Jul 2024 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721838106; cv=none; b=PUQJeJfVwY5wO7LHcnibcmfbK5aGDep99CHveDRRpGR1MDEvM6Ks6bD8puOUKJ3eXXy2i+/qoX8Fnirz/KNEEuXCk/MMi7We2TQN9ZJjmUaV7/OHa0U/MdaPEmGNGwsoo6dkPbwHppFUmTEnccrzSNVcvdwASBi2rIdBTVya538=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721838106; c=relaxed/simple;
	bh=u+8sQaElmmUTGYE88vHZLs/dmfNY6c2B4ktHc+O+ePA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T0Xone6qaFjVTHwFAoO9Ok4M+T/a2QAY6qVYkG+cgGWVjfYLVkMhv2stfIIeQZOJkgvXXWq/QvJJwWE6ZSP5fjMuKfk4XaR9hFnBwKEYKJpmY8rridbWXDCe9eqCy4K30XiPy2sp9UQujgOpba467EeKC1wNeLobcMT4+eRxp5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFb/xYhW; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fd9e6189d5so11592705ad.3;
        Wed, 24 Jul 2024 09:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721838105; x=1722442905; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jCjlyepMSMynmD+rlgKER3fIjctnf991YR04zeZ0yNQ=;
        b=ZFb/xYhWNkN25SY6FbCmbDlGmwMw2ZypdcVtxpZU8tgT7dlLx+7pgJvqOvTsSxtk9F
         g4DMcaU89Ra/ZfepfpqE32jcXQ059+zaZDkXd3Q33bfcybGMZfDCT25WQd0ibraoXusy
         H4AQES65DeA+/CMK+I9RybFj+h2lUu7f0Kmm6pCaRxibJ+Si2s6LzvJPA/MexBSPhGDM
         rgCJEIe6wDdYXsU8cktiNwnAR3tx6ayHFRgJr5rv2MsHjB/4KQlKAezwCoRVecps2dJ5
         7Y7VKlzwM+ryUxoGwJQnQ0fcG2OZjfTDULJRVoCKqij1mnCVQiQLZ4D8+R7UMgZl7HJZ
         2v+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721838105; x=1722442905;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jCjlyepMSMynmD+rlgKER3fIjctnf991YR04zeZ0yNQ=;
        b=ULNRIlqoyA2lWK34E0BVLZXp+Y+vT+TU/+TkqZIgBtcdTL1WfREqhKpbTnzdysM4BU
         AYCI02fLhGG1eTBhoAZzCXBU+LMLnWxGAL2n0LlGcj3jaEDHjt9DhNRLZN7o9r5HKwzA
         LA0wBgfTZ0epJN2CxtrfhI4iHaQsm2ZEJie6zVXawKd8b2UDYH589cLPq6X2Jo1eM+nG
         E4kgX0uGfVR+ajOBZXqrsI32IzUaI3m38FAyo0vJbjtehlXSOVGnaWg62zGGsuZjay7h
         K6IP0PD7C532wQ2zrd3b7paNzlPj/QMuKmEVrU9BHdfr49wx88ziWBRysPJmZ6CDA0RJ
         frDw==
X-Forwarded-Encrypted: i=1; AJvYcCXEYJ7VksytVzkXDIMjC33Q3PblWmColK5URZLQJIlFZcCrdijZIUspbVYOWxcx7OsT0PsltCOrsNRSEp4yEg9R1UyvWsAyBeAn6hlb
X-Gm-Message-State: AOJu0YzOb4oQIZXTjEg284ANF7c/HseQeVwZX+OIJAe8Y3qtP8yQEoej
	1Yh4aygA/DnEnD1UKLshANnLWjXdqrmHYjg25B83PmVv/NOJhl7m
X-Google-Smtp-Source: AGHT+IEaHyX4rKl7ZB80zmsR5sXUua2/ZJvAuV4RsfEazSnJ/eAErqgeZOPe0vCi037qpxQzPdbjfA==
X-Received: by 2002:a17:902:dace:b0:1fb:5574:7554 with SMTP id d9443c01a7336-1fed38a191amr563385ad.28.1721838104565;
        Wed, 24 Jul 2024 09:21:44 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f31bd9bsm96159635ad.157.2024.07.24.09.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 09:21:44 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH v3 0/2] Add Meta(Facebook) Catalina BMC(AST2600)
Date: Thu, 25 Jul 2024 00:19:17 +0800
Message-Id: <20240725-potin-catalina-dts-v3-0-3a5b5d9e6dbc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIYpoWYC/32NQQ6DIBBFr2Jm3WkUaWi78h6NixFQJ1EwQEwbw
 91LPUCX7+f/9w+INrCN8KwOCHbnyN4VaC8V6JncZJFNYRC1kLUSEjef2KGmRAs7QpMijoYaS61
 4qKGBMtyCHfl9Sl994Zlj8uFzfuzil/7V7QJrHOhupLrp0mq7aSVertqv0Oecv3Y22fK0AAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721838101; l=1010;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=u+8sQaElmmUTGYE88vHZLs/dmfNY6c2B4ktHc+O+ePA=;
 b=sE4zAb8myOf5e2jTC2Cd+B6ZFVvenRADe5LixLy60a3S7vSr9j1xAlWNiu/fkq3Y7MKlPOVLo
 D9esJbmXWoqDKvJepurspIR8QHM+BaCxKAmYYFmQ4RWeZw6Gn1ndbnN
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add Linux device tree entry related to Meta(Facebook) Catalina specific
devices connected to BMC(AST2600) SoC.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
Changes in v3:
- rename tmp75 nodes to temperature-sensor
- rename tmp421 nodes to temperature-sensor
- rename ina230 nodes to power-sensor
- rename io_expanderX nodes to io-expanderX
- Link to v2: https://lore.kernel.org/r/20240724-potin-catalina-dts-v2-0-ba8d475c4073@gmail.com

---
Potin Lai (2):
      dt-bindings: arm: aspeed: add Meta Catalina board
      ARM: dts: aspeed: catalina: add Meta Catalina BMC

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    1 +
 arch/arm/boot/dts/aspeed/Makefile                  |    1 +
 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 1020 ++++++++++++++++++++
 3 files changed, 1022 insertions(+)
---
base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
change-id: 20240724-potin-catalina-dts-fda1ea3297b1

Best regards,
-- 
Potin Lai <potin.lai.pt@gmail.com>



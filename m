Return-Path: <linux-kernel+bounces-263110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1AC93D12E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 12:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0C7D1F22828
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 10:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC0317920C;
	Fri, 26 Jul 2024 10:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwXKyr8i"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4224517966F;
	Fri, 26 Jul 2024 10:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721989753; cv=none; b=pTxPWU6BDrjG6fQklnYCahNfIuJ+dNQdV/PX56A9OEqtAS9w2ZPZdOZN470f5P0bVXSc1Wlsm4fdvDDd3r4Ew8GW3x1QRS+jikDZE0pL1Vm/vnXyZqXedCI9GeDUvqnyZY/X9Ke+jP1E+gFlO+YmGhgZU3WDvCXnIKEVZ+hTzms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721989753; c=relaxed/simple;
	bh=S8ZOFlqmcgPcpi9udVpIP3DnsEMtZDW/eFoHOzRFOjM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WTNhREMfdckNgpg8QFbhNhgNkM6Vh9rhUsC9R2DKW56Ip0F/zV+Aksh9wEn8+NFqADkfZKGNKJkuW45jDFQz8/HBw31kZchmsCYDHGBhSlCpLitljIPTmVikHBUEqccHAr0RKoBNeK3J1ofZQlCTk7PeYVUsIn/7i7EK/W5u4gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwXKyr8i; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3db18102406so546898b6e.1;
        Fri, 26 Jul 2024 03:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721989751; x=1722594551; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=taoLvNSxvJvDSIyoezhhEapktK4CQP/qTkZDErUBC00=;
        b=DwXKyr8i6UGspsT2u48k5y8BmqDgaG0DkRA1WWAoy40kVPKXA6c6JxxT88NczHfpaN
         blta1QHWYlVGYmMrXx/ylLGrsznGJnIH3MUp/apTML+emHQAwsRVBFlXIxExY/pvgbo4
         2wCm03GPTFbu9qSEBQ2W/Rj+A07AxvvvLLCXF0Kv6eNUhupaXXPjpel0cLCwMvstULXk
         TZWLkhIu0A5JwSbkcZpsBj02RQXc4Kz31weO4aJHl+lvCZFW9MHPSFbeqDujaovWYMyJ
         hWowd4h8MOARc+Z2nyFb+yYbmTg5w5rGqO4SM5SVipB4Bl7Y2KwX43AxJwFJnuXNwI91
         4k4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721989751; x=1722594551;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=taoLvNSxvJvDSIyoezhhEapktK4CQP/qTkZDErUBC00=;
        b=Ok7jfawb6XHuAQF5I9qGMtQIiBdVb8X5jVfmbXobPJ5LjBIbh+Q54Nxeag1x1kQbgL
         /hQuNeNHzYPjDqmWJrsOmT2OTW/8S+R/z60TSpnme/pHkxuz0BqsVrpnAlDqKZftu7L8
         JFJ08MQf9XtA+1DGdIWb7PbAz8j1GDlAFGJ41prBiPUKYHhyzWidzPt9jAQwmJrRQ2nq
         4xlp01wMoBg8qmEKun29YFvS3wQwayTibXcbCgge+WI/deoGegsN7CHT/s2Uxk4dLBZo
         O2DMkQHWb8krW9KddVkOX+n2jPlBSIK7eAuXk2TraOt1ksf2dMUxEoBwCCKGIQxZ9TPI
         uSnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFvRZdp3d+73b47JgPyp0kjNvvRzmIuaciL1b81s6JpNIKSN2D22SvzByer32LWLGNvUbZlEuWTVt1CPdxmhWEagkrX2vmllWBz3P4
X-Gm-Message-State: AOJu0Yy4eauZPEJ0jyrRCHuaE98OPtOLpcWUZVusWX+XCglHk60isVzE
	nwSL/bxmYwfw76K3sdJcrcZ+SWUOUs+8RjIXEETMoM7etM4TE2JD
X-Google-Smtp-Source: AGHT+IG+DdKxRpU/fq6Ap6ktwC6YKBP8zhxIdBKlVK/dF6FJRoOcQcCcLikI4ou0llcy9suJ13nImA==
X-Received: by 2002:a05:6808:2003:b0:3d9:244b:b9d3 with SMTP id 5614622812f47-3db140a4921mr5310951b6e.23.1721989751139;
        Fri, 26 Jul 2024 03:29:11 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8116a4sm2406545b3a.130.2024.07.26.03.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 03:29:10 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH v5 0/2] Add Meta(Facebook) Catalina BMC(AST2600)
Date: Fri, 26 Jul 2024 18:26:48 +0800
Message-Id: <20240726-potin-catalina-dts-v5-0-8f02305af527@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOl5o2YC/4XNSw6CMBCA4auQrq3BPni48h7GxdAOMAlQ0hKiI
 dzdwooYo8t/MvPNwgJ6wsCuycI8zhTIDTH0KWGmhaFBTjY2E6lQaS4UH91EAzcwQUcDcDsFXlu
 4IEhR5tWFxcPRY03PHb0/YrcUJudf+49ZbNOf3Cx4yisorMq1iVvy1vRA3dm4nm3cLI+E/krIS
 EjQlbYlZrYyn4T6T6hIAGS1kBoE5sWRWNf1DbDDNHE6AQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721989748; l=1681;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=S8ZOFlqmcgPcpi9udVpIP3DnsEMtZDW/eFoHOzRFOjM=;
 b=7+JQIry5FaNhIM8qrgeiO9DO1/O3ekdaSP3aOVavYM+XGLff1kurGft6IBruHlbOCIcOXRIoE
 NaVkNb81cyHAZQaeb6Q5sv9BvFv2xnbtWP4eGpdn2lzOv0K58TrW6Vg
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add Linux device tree entry related to Meta(Facebook) Catalina specific
devices connected to BMC(AST2600) SoC.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
Changes in v5:
- fix spi1_gpio node name and properties
- remove undefind properties in mac3, i2c7 & i2c11
- Link to v4: https://lore.kernel.org/r/20240725-potin-catalina-dts-v4-0-aa6f235a2e78@gmail.com

Changes in v4:
- change back io_expanderX due to parser error, build passed in v4 version.
- Link to v3: https://lore.kernel.org/r/20240725-potin-catalina-dts-v3-0-3a5b5d9e6dbc@gmail.com

Changes in v3:
- rename tmp75 nodes to temperature-sensor
- rename tmp421 nodes to temperature-sensor
- rename ina230 nodes to power-sensor
- rename io_expanderX nodes to io-expanderX
- Link to v2: https://lore.kernel.org/r/20240724-potin-catalina-dts-v2-0-ba8d475c4073@gmail.com

Changes in v2:
- drop commented code in dts
- rename i2c-mux channel nodes as i2c1muxXchY
- rename gpio expander as io_expanderX
- use "stdout-path" instead of "bootargs"
- Link to v1: https://lore.kernel.org/all/20240722145857.2131100-1-potin.lai.pt@gmail.com/

---
Potin Lai (2):
      dt-bindings: arm: aspeed: add Meta Catalina board
      ARM: dts: aspeed: catalina: add Meta Catalina BMC

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    1 +
 arch/arm/boot/dts/aspeed/Makefile                  |    1 +
 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 1016 ++++++++++++++++++++
 3 files changed, 1018 insertions(+)
---
base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
change-id: 20240724-potin-catalina-dts-fda1ea3297b1

Best regards,
-- 
Potin Lai <potin.lai.pt@gmail.com>



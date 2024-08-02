Return-Path: <linux-kernel+bounces-272346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF678945A87
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 11:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3AB21C23BF1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 09:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826731D3639;
	Fri,  2 Aug 2024 09:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLE9g38/"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613F31EB4B6;
	Fri,  2 Aug 2024 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722589850; cv=none; b=cfCCIac5TAUAjCrnXgNNS0qzVQqprJiVVQFDG50H3FS/tjhYiStOqdtTV5PBytfK8ifVpm5+lrrhRR7/hBsEGo3z+zLkgWEUIP7ZzZa2/qDugQvSOj34LbOGnPirqTn/5qhKBBygP3b8TafJPTe+M/XuiAljmBvECZEV57eHg9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722589850; c=relaxed/simple;
	bh=GA9heUsACbwet20tQDdERhjA0vH0lNx44YL8Ax3i694=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=doYKXnEgyDuc17Ufx3yXvdeOYJFLdnWiGjg1MXYhDPf93Hu9+MNa623ggRODtMpqdM+7JJ6JrsAViZ/ghvJgKh4MPzJAZyjljtTH7csig10WAigVGG95dVW2QavTiabaCHByMsAhxy90wZP+989WE9fXlQAr7CQh7bPXSBhMqlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLE9g38/; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70d316f0060so2054330b3a.1;
        Fri, 02 Aug 2024 02:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722589848; x=1723194648; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GU5qsspMI0fq/9l22SvO0SxLWx7Q8pPDT8Qcq7weLRo=;
        b=dLE9g38/Vgm/dtTLYVV8/r0cSVOv1LYPxzToc9hhoWiEse5T0bPaZTmU7AdKjEQoaT
         imM2U92pxkKqB4IRnCOjzCkCzeOtbUUXCvFaeu1xnw+9S6hJFg8hcO2Qp+swKWzW9zht
         g4aCc1uXdsI5ylOhmTVa4g+DfxWVzbHNRv7R/jlgvlmY25XVyzIUx8vSKQAJif05NnXG
         zkYOxAFjFvkE6LNyrEAizPq2yn6lpXPsreo/BZlxxLH4BHXEOKjEtusy/epV8THDaxyT
         ItJmORperNXPtwGmkEZi0oiVPZ/Kyi21Oc4jbU4IoiVQGiuL1lMEp+mqBPdE0eY284B5
         9SHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722589848; x=1723194648;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GU5qsspMI0fq/9l22SvO0SxLWx7Q8pPDT8Qcq7weLRo=;
        b=aLw1q5kdwnnI3znDyQWUIWqHMyZqyBysMtew6roQ1hf7nL5WIAcYQ5UezaLTEQ3Qt8
         iSMVdw6M83sReRZjmJrvj8YsZ4PD6Ph7qQEnLwKNfIEQ9app4tqwC+MxBEtPXL6aTB5C
         TJw/guCWyvKuISvJiLhmL8J3Swv063GZeXvzJxZh2quJnCYk/CV6d7NOlLWEjVuda//u
         dkkMeUuXabyuaf5bXzo59GH1V+/+fjeOP/eWvfpUvrzjkBg+UOK2fk26PYEIRmRubaMc
         BX79rPxt6r1CcQzkWpG7aUoJ8Ugg9TciILYCvFGFVcEyND9pO9J/wxaDFcARH2Ogfbsy
         QF6A==
X-Forwarded-Encrypted: i=1; AJvYcCUWqdRuvB3+Wyx3xIQc6qqqGH7/xhhG7SrNhKjG9NC6CI6XusP7kM+RGpRLgrk/GDvUKsbunfhZ53gzqmWt2NpgX2dLEGgiCfGwxRfi
X-Gm-Message-State: AOJu0Yww2BxQng+kPJ4gsLa+m+F3DmQUvKGkwXA45ZOKEh74QjZfMear
	F9yWQCsSata8YA6GHgg8Q923zYSskKhjmMf7lwIkmrD2uUxeyO9WlTP5sA==
X-Google-Smtp-Source: AGHT+IHgpTlOZ1GMTXPn5BCGd3CXDVDrNz/iKy8YI9RfVG+sx/tqctbg8JdQSlpADRRRJ+hh/tKHRQ==
X-Received: by 2002:a05:6a20:7f91:b0:1c0:e69f:f23e with SMTP id adf61e73a8af0-1c69a5bfbc3mr4536465637.9.1722589848110;
        Fri, 02 Aug 2024 02:10:48 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec05bf3sm1034145b3a.13.2024.08.02.02.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 02:10:47 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH v6 0/2] Add Meta(Facebook) Catalina BMC(AST2600)
Date: Fri, 02 Aug 2024 17:07:46 +0800
Message-Id: <20240802-potin-catalina-dts-v6-0-0b8f61b80688@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOOhrGYC/4XNzQrCMAzA8VeRnq3UtFk3T76HeMj64QL7kHUMR
 fbuVk9DRI//kPzyECmMHJI4bB5iDDMnHvocxXYjXEP9JUj2uQUoMMqCkddh4l46mqjlnqSfkoy
 e9oE0VLbei3x4HUPk2xs9nXM3nKZhvL9/zPCa/uRmkErWVHpj0eUtfbx0xO3ODZ14cbNeE/iV0
 JnQhDX6KhS+dp+E+U+YTBAVETQSBFt+Ergmiq8EZqKMCrRCigh2TSzL8gTeDP9gfQEAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Potin Lai <potin.lai.pt@gmail.com>, Cosmo Chou <cosmo.chou@quantatw.com>, 
 Potin Lai <potin.lai@quantatw.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722589845; l=2015;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=GA9heUsACbwet20tQDdERhjA0vH0lNx44YL8Ax3i694=;
 b=aqvTebrxPHabbGWV2kNSB0fPx/eHldeuiDNPOT4n6FWLAa6SMpFUDIGxYy5VokvopnG1OJAlI
 JHtJNvBN6P+ASdcu1kl+kFKAJoA02OaN5wSuZs9aDghygs/s02Wzm3V
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add Linux device tree entry related to Meta(Facebook) Catalina specific
devices connected to BMC(AST2600) SoC.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
Changes in v6:
- move i2c-mux@70 node from 33-0070 to 30-0070 due to bus change
- fix wrong gpio-line-names in io_expander6
- remove all max31790 nodes
- remove all raa228004 nodes
- remove ipmb-dev node
- remove unused mdio0 node
- Link to v5: https://lore.kernel.org/r/20240726-potin-catalina-dts-v5-0-8f02305af527@gmail.com

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

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |   1 +
 arch/arm/boot/dts/aspeed/Makefile                  |   1 +
 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 965 +++++++++++++++++++++
 3 files changed, 967 insertions(+)
---
base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
change-id: 20240724-potin-catalina-dts-fda1ea3297b1

Best regards,
-- 
Potin Lai <potin.lai.pt@gmail.com>



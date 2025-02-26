Return-Path: <linux-kernel+bounces-534466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D05DA4674E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF61B18848CE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0C721E082;
	Wed, 26 Feb 2025 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbfTDvgD"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994D2221D80
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740588864; cv=none; b=dxcbRi37YimNlbXMeCZou18pdPhlz2hcM6zACrgdY6L3kCNi2N8kzoZkTr0qTL1ULZtE5gTf4HfNR/Y36xeIu0Q0vZc1bV4qlZuuFRajvq99hRzSVK2xoJxeryo/3lESCOTBErq06/ggit7tg/zulZEV0IM8dlMaeBi7JdIdLxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740588864; c=relaxed/simple;
	bh=vEb7wZbAKp2+E00O1H3FnSBoPcs396kmDnQUTh8XiO8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o9XszNHRwg2LNX5K1GVQPY5f4GJIka8QEt3MySCnf2r2EuFSSRXPvSN8Wi1QCREJcZuIDAICBMaeKQdSqBg4M7uOX19Q7F1Sc8Nohe0Y8ShV6xNpLFTRsmfQJW4k4y/tkDziaFq9owFsnbtbW9gwaDEIpKwitZWFxxPGs55wDm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbfTDvgD; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-390dd3403fdso630426f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740588861; x=1741193661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V7vkfh4ddTTsMmNol3nhPNfYX8H1c5FYy0uhOqg4mVE=;
        b=cbfTDvgDi+loilxMRbmAIqJx11PEFj0luOef0IANXhrdctySmUAXsH/ihVht8Udk5N
         GIETkMKmeW82M0RcXaxf1+KWsdPsAW7Hv/xzYYMQ7uzVjI3h0yNN7nQYs/KTgKQp3gsd
         RmPTSnCU0mTJks28+UOkHIQk5FcboDsN/MoGLgg3rwRaoyC39TUUhP+0tikYoyLSHEIn
         GNDfTmQCLL15Qjg+5MOdidS9On8dVGbHgG3O2b93+G1X9WjcNd3YQ6A6q34iSe9onMeX
         VRlQRNuqfit9hnny2e3PtkhRJy+4lT9nEhZFbheS91ov59Y2GZG9DHq8O+UEayjec0F8
         nvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740588861; x=1741193661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V7vkfh4ddTTsMmNol3nhPNfYX8H1c5FYy0uhOqg4mVE=;
        b=grsaaxB2qCV9Tq4G3r4AQNMI/Gbnj7WqzzVMBlznSSe/g42x14T5lJ7bbrqnMfuxIw
         9f4xygO/eLBOtEbyRGrNl57/e54BY9UyWpj3nhXDsvUNa1bV3sBsOSdM8V/nHujAWkKk
         dNd/K2XXDIj5O9Pmi92j9L7aCSoIzpzzt6jvRksq+I8/Iv0PJXW706S9wO/fnfY3bk2N
         w0iv7C23DEFcYnnB3AO8GnvlaV9uRi+9i2j+AQ59rUasMJxtXdJTlzTZFP/oRczgql6m
         HGs2DQbmQeg5n6rNyzknAcZkAfeha9gyNJZxi9rtqnvZCfstiFp0+/l5XOIX1gzwKd0+
         zM9w==
X-Forwarded-Encrypted: i=1; AJvYcCXaS2dUdwTI7Zu75AitsJLvdKeaJF23l1jkBN+kW2ipL6tg/UbMGPPpxuTQHnf/mw1gAxYpc9RqucegLEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhTu663kRjH2QB3TzGARPue7JM1+3ezZLztQRCTfRJK+lK2xOh
	UuLz1oNmg6Th75//sLNz02xfTJ75atI7EU2ZuUK2fFSzOEzUy6VP
X-Gm-Gg: ASbGncsVfAWBEWZXb+Xh402aaQJAutOttFDOunjPFTjKcJ0M7smxGiJFXAInYSjZyoK
	wMivXJD9od/SA3MfbUVd+5/s3X2aU79OQX5sSJ4oRvRJdrcWINsguos/H9wPPBQ43xPgrK5WVTc
	XhgkqXyDjsf7C0w4cSaIfhnLDPNmx5PPxccD/tSE8i5Xkjlq8fhKKGTLgmWMj4V9OjZRyS9aSXy
	t81NrdzXhwlUWSrz1G9Rrt5jSEPOsGmQaeIlO2m9AuHcYJ+lghkTVUwEdL+0h+EqWyijwpzvdLJ
	bBJE78AoJ9Ps6MqkPpDysgat3k6IjuWB/1HTZYsgLq4deubzELVpMr3ovW9/S3/s
X-Google-Smtp-Source: AGHT+IFkEUgrTUm48/FTrUcUruOOa4wlLyjFj2y//pjXXddwMb+aMzVxF/jrzVCXgJFveDwHMDYHJg==
X-Received: by 2002:a05:6000:2c2:b0:38d:d371:e04d with SMTP id ffacd0b85a97d-390d4f8b6a7mr3152525f8f.34.1740588860292;
        Wed, 26 Feb 2025 08:54:20 -0800 (PST)
Received: from playground.localdomain ([188.25.208.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba587163sm27672515e9.36.2025.02.26.08.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 08:54:19 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Frank Li <Frank.li@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] imx8mp: add support for the IMX AIPSTZ bridge
Date: Wed, 26 Feb 2025 11:53:09 -0500
Message-Id: <20250226165314.34205-1-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

The AIPSTZ bridge offers some security-related configurations which can
be used to restrict master access to certain peripherals on the bridge.

Normally, this could be done from a secure environment such as ATF before
Linux boots but the configuration of AIPSTZ5 is lost each time the power
domain is powered off and then powered on. Because of this, it has to be
configured each time the power domain is turned on and before any master
tries to access the peripherals (e.g: AP, CM7, DSP, on i.MX8MP).

The child-parent relationship between the bridge and its peripherals
should guarantee that the bridge is configured before the AP attempts
to access the IPs.

Other masters should use the 'access-controllers' property to enforce
a dependency between their device and the bridge device (see the DSP,
for example).

At the moment, we only want to apply a default, more relaxed
configuration, which is why the number of access controller cells
is 0.

The initial version of the series can be found at [1]. The new version
should provide better management of the device dependencies.

[1]: https://lore.kernel.org/linux-arm-kernel/20241119130726.2761726-1-daniel.baluta@nxp.com/

---
Changes in v2:
* adress Frank Li's comments
* pick up some A-b/R-b's
* don't use "simple-bus" as the second compatible. As per Krzysztof's
comment, AIPSTZ is not a "simple-bus".
---

Laurentiu Mihalcea (5):
  dt-bindings: bus: add documentation for the IMX AIPSTZ bridge
  dt-bindings: dsp: fsl,dsp: document 'access-controllers' property
  bus: add driver for IMX AIPSTZ bridge
  arm64: dts: imx8mp: convert 'aips5' to 'aipstz5'
  arm64: dts: imx8mp: make 'dsp' node depend on 'aips5'

 .../bindings/bus/fsl,imx8mp-aipstz.yaml       | 86 +++++++++++++++++
 .../devicetree/bindings/dsp/fsl,dsp.yaml      |  3 +
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     |  9 +-
 drivers/bus/Kconfig                           |  6 ++
 drivers/bus/Makefile                          |  1 +
 drivers/bus/imx-aipstz.c                      | 92 +++++++++++++++++++
 6 files changed, 194 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/fsl,imx8mp-aipstz.yaml
 create mode 100644 drivers/bus/imx-aipstz.c

-- 
2.34.1



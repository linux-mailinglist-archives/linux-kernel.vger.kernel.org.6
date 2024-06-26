Return-Path: <linux-kernel+bounces-230769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF44D9181B6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663451F23FFE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0C31850A0;
	Wed, 26 Jun 2024 13:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQrraXKK"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A45C181CE6;
	Wed, 26 Jun 2024 13:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407139; cv=none; b=WLW3R4tkAQdoVuFuSyPylB3uh9gWRcRQsH/0myRsPIKnEZwO7ucK7Ly+Es4LXB0XS5FGBgGKGz80bjsjXEdkqEK1Nb+TiIgwy99w7zPtN9qciUpTZ/0twf9rUty7bwZF2TgXIzXL3jRrWva4Q+VRqGP9MGfhh7eGyQiW1GBEge8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407139; c=relaxed/simple;
	bh=bcEPL6AOSJfjfSd6djUuJxfQgx9624bx9jMxd/Kz67E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Av4CHaey3+9+9U4ou/+AeXvx+3d8B8aBMull/XKLYxXaEWH1ywEaOU0TmE18+SIqht7b43x8eCEsAp1klsROdHAEqJmPDuJqRzy9iCPRZZsK/rZ+VJLQttx7Yh05g89ftDwkRE/F5kAx99DZR3qv3A90K47/wLVMJlhvgdjNATs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQrraXKK; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f47f07acd3so54824775ad.0;
        Wed, 26 Jun 2024 06:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719407138; x=1720011938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SZEw1g07ZLnQvFZWEHxbSy8GeOHnIuAb8MiyryT0YbU=;
        b=jQrraXKKgP10iG8UkljcZ45+DmZICE0ppm9/00+Xzh6aPNnZXtZ0MstQlbv+RTXqBM
         IaEZG17I3DOLm9ZzuMQW+EklN/hG8W3EuliCN+S202TyKeWblJ8RUbKMzToAx/M84YAP
         iuwAWfRxpMu/muOAjZL5M7hd8K0k2BCHCahtADfWsX8fniv8k3NhEJXmfIzmG4xZnpT1
         H5AXrRGOBmYgkngJPpic7ja3napP25JlGl0hTSmF7nEBWxWc/+WZEfTi8oxE5FdsMuhs
         WwQ9FyVDbIsUHSZGyLYqBrHHUZq2FDEbCosRI06qt+49Ivz4joX1yVOOIO6bnoEZYjWl
         Hd5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719407138; x=1720011938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SZEw1g07ZLnQvFZWEHxbSy8GeOHnIuAb8MiyryT0YbU=;
        b=vNoyCOQ30AncznrGDso3I0WDjEBZoy/FjtT6Yn59rejL0M2nPkxUBPWRxcN+C7kbx4
         pfInOBWNeZS4W+HdGv7nP+xqx9MCS0nrHUKwTEk3GH/F3t4oKDVRIrWN1fVQ8ddCp5Mr
         1x4UJN14QZOLS1nD7Al3pV4F/+z1lQ5wK9kHmmfNeUJ0w1luEw5XZxrQ9nCMdvhQZwgL
         z0BxQRnleZoSOjR6VzuhMg3AQuLxfM0fVQLyJJA53onXxxi92tGh7US1EwCMHt5MjzgW
         XBYbU49gNLhKV+I/kXoZjdS8bvxTSjTlKWsY0Cl5fU+PLO12RxUwQRlPAtWplgwwu2tK
         n91A==
X-Forwarded-Encrypted: i=1; AJvYcCX635kbeAWW7YMtwf9hmtQb+e3kWUyf8GHc3UvkD6lXBI2nrSgZzvC68gVamSuJ2/UJ3+Dej9PgQd45oRJk+Ecx+33l5s+KO3lXvJOqSVdUwEelrTVQLWUSKefANXCWePChYMLV+cSiNg==
X-Gm-Message-State: AOJu0YwmUi9i37zdNTbVEk1NHJOFu0oJZn6Uq8Sp9kZUjBXYmplrLz07
	AeW16YuaDL3q1khMdW5rfy9De5Yxtuwiipd6HqHesNU+9QZe+m7xCmIZ2I/7
X-Google-Smtp-Source: AGHT+IEu3J9iziZNrqrOUblp2zL7pUOD6XFZ8442+63lf5VR1h/a0E2Ilv1q41eUPQoLZyYHEBSiBA==
X-Received: by 2002:a17:902:c40c:b0:1f8:66fb:1677 with SMTP id d9443c01a7336-1fa1d3de606mr131873165ad.14.1719407137507;
        Wed, 26 Jun 2024 06:05:37 -0700 (PDT)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb7cf885sm99112395ad.224.2024.06.26.06.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:05:37 -0700 (PDT)
From: Yang Chen <yangchen.openbmc@gmail.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	patrick@stwcx.xyz,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Jerry.Lin@quantatw.com,
	yangchen.openbmc@gmail.com
Subject: [PATCH v1 00/17] Revise Facebook Minerva BMC DTS
Date: Wed, 26 Jun 2024 21:03:15 +0800
Message-Id: <20240626130332.929534-1-yangchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Revise the Linux device tree entry related to Facebook platform Minerva
specific devices connected to the Aspeed AST2600 BMC.

Changelog:
- v1:
  - Modify the properties of spi to match the schema.

Yang Chen (17):
  ARM: dts: aspeed: minerva: change the address of tmp75
  ARM: dts: aspeed: minerva: change aliases for uart
  ARM: dts: aspeed: minerva: add eeprom on i2c bus
  ARM: dts: aspeed: minerva: change RTC reference
  ARM: dts: aspeed: minerva: enable mdio3
  ARM: dts: aspeed: minerva: remove unused bus and device
  ARM: dts: aspeed: minerva: Define the LEDs node name
  ARM: dts: aspeed: minerva: Add adc sensors for fan board
  ARM: dts: aspeed: minerva: add linename of two pins
  ARM: dts: aspeed: minerva: enable ehci0 for USB
  ARM: dts: aspeed: minerva: add tmp75 sensor
  ARM: dts: aspeed: minerva: add power monitor xdp710
  ARM: dts: aspeed: minerva: revise sgpio line name
  ARM: dts: aspeed: minerva: Switch the i2c bus number
  ARM: dts: aspeed: minerva: remove unused power device
  ARM: dts: aspeed: minerva: add ltc4287 device
  ARM: dts: aspeed: minerva: Add spi-gpio

 .../aspeed/aspeed-bmc-facebook-minerva.dts    | 516 +++++++++++++-----
 1 file changed, 373 insertions(+), 143 deletions(-)

-- 
2.34.1



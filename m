Return-Path: <linux-kernel+bounces-228821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 368D9916776
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6D8B1F21658
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA8D154C0B;
	Tue, 25 Jun 2024 12:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="np4xmS11"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3953F9CC;
	Tue, 25 Jun 2024 12:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318041; cv=none; b=B/3CGYpQCIm+Cl04qLdps8ZawpJgZ65sosMsEa5FMRMQeCI4G8VmiJof3QSoT6Ldj5vS40uz84weLi/P9zt46JY59xjbaA8n2Dj77UcaOnnuh+hvXvQQtj0isOKkzVIP3HfFZ7LzNAszBVOZwoDloJlSp3LbNs60bIzI1M63BH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318041; c=relaxed/simple;
	bh=yoslXkuqAIEDgLEjm6hxIT/CJGtS2Ju7b/A2yGSzAEY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FufESTzm7RKp24+Agv1HaNoF4yHTAXJHDQfEmsT1tjrkeWB8P4oYy+A+n+lCiQ0hKzkAPPCcwF55E9PGitn7jFs0kqsBfi+PmhNlGOLgXOnL4EjPWmzPL/arDETw2zx+kUmrcOt1f7RnzObqLm823Z8z9cxLAeA+2r/MlDlBags=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=np4xmS11; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7f38f5584ebso194666839f.3;
        Tue, 25 Jun 2024 05:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719318039; x=1719922839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=56OHLeHM6KGxfr/ZiEEzO7pNMBMtLebkNfQmQtaAVfM=;
        b=np4xmS113J1WcBqWYWmaTWrliRr4RPAIO1Us/Ku55zeGWU9VxCSfaeTeC53QzN6dNF
         RC6bCBxbteNuyO+UEJypbCUf4IIQ3pWVnfT88n2PCPlY4zxOpehD8KygHd+Ebt6JNW2I
         Iwsyqaj3aZc3qVUn5dEk34v03lC8SdPDtXkAyGHjX1+C9PjLZgGg52K35e8+HBu9JgIY
         wOXrHyIk2Q5RgtSkq9z/7Gvr3LHAnZ8h5tqsKsG7IBNHwjuekBvDe3UP5c/szDUO/FVT
         Uyy9H87QbJnkhVwwHpQFsSPrjLYz3cAL9Fzidb00lIdjUrYSfaRXzNrPOJC5XGnTGnXg
         4uoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719318039; x=1719922839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=56OHLeHM6KGxfr/ZiEEzO7pNMBMtLebkNfQmQtaAVfM=;
        b=MODnEDc0gjOHXuwiLWCo3JKqQ470JJ/WqYxDjiAQ+OLwUiXoK4//rRPrEMclAqNUsw
         Kn/7RIArx4Je+ZYgzexdOvQV5na+gfaQX1ibj0HLgCTlyILXkzIq1V1bXBJxlsNw1pet
         w3aV1PquJos7RnisxdzFQWvFE3N11mQHXbgdeeKSI7F2Efrm5twJnYMkhv/ZOgTYrJr1
         YbpHS3Jyh+83H6Vbij+Ia+S3Lj+icQflfAolLw8JKgUR0qCeO9shqNM10tCBlSJyR4V2
         ixBM49zF3ntaTDZD0ItbkOKiZFasy5u9VZd9w7HGbPTjgGK4hHxDeOVtiuqm5HwwUd3h
         6O0w==
X-Forwarded-Encrypted: i=1; AJvYcCWrfm5iK9UJKuDLBPgdAEuxiZDvmtlKCPFPvUVg6bRcv0/Ohewobo/OfRohcbcDTbljGBqC2y0cfC6jCnx4NTxDMgsxw6Eta3mNGYWLf7EMy7nEWQ2v2EW0ckXeW4g0w46ria8YZdTTdQ==
X-Gm-Message-State: AOJu0YwE2Q3MR47vApIrBZcROP+ufZnJX6h3BVYSgNRXYm6S5hdvOzFu
	62bgYBpvyvp2XZM1ZPidjkKG42njoaMd5PtnoaB1P+Lpm3itpDwSUy1jKcT7
X-Google-Smtp-Source: AGHT+IGUQpFqlrYS/f5s9ricWY0f00ekN6AAhWQ5FiP2pjk95LET46rRUpw9FfLv5J/yfG8zjaH5IA==
X-Received: by 2002:a05:6602:6421:b0:7eb:97a0:8226 with SMTP id ca18e2360f4ac-7f3a4e36b74mr1028971639f.13.1719318039091;
        Tue, 25 Jun 2024 05:20:39 -0700 (PDT)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70650e312e4sm7978146b3a.0.2024.06.25.05.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 05:20:38 -0700 (PDT)
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
Subject: [PATCH 00/17] Revise Facebook Minerva BMC DTS
Date: Tue, 25 Jun 2024 20:18:18 +0800
Message-Id: <20240625121835.751013-1-yangchen.openbmc@gmail.com>
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

Yang Chen (17):
  ARM: dts: aspeed: minerva: change the address of tmp75
  ARM: dts: aspeed: minerva: Add spi-gpio
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
  ARM: dts: minerva: add power monitor xdp710
  ARM: dts: aspeed: minerva: revise sgpio line name
  ARM: dts: aspeed: minerva: Switch the i2c bus number
  ARM: dts: aspeed: minerva: remove unused power device
  ARM: dts: aspeed: minerva: add ltc4287 device

 .../aspeed/aspeed-bmc-facebook-minerva.dts    | 516 +++++++++++++-----
 1 file changed, 373 insertions(+), 143 deletions(-)

-- 
2.34.1



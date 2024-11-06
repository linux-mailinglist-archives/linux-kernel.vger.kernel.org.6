Return-Path: <linux-kernel+bounces-398157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD449BE683
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFB2B2829FA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 12:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C431DE3CA;
	Wed,  6 Nov 2024 12:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="d+xT45VX"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCAF1DF248
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 12:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730894492; cv=none; b=g9efWpKnAoUY1ZTdD9WFA0thv0u03zilBJLiJp8AXg6caDYggSUlEct9fhq7aUd4C1LL4kDIOmdT54hwUTCfzWwosmvx+Q5At/8IoPn6X8yadAfjFfc9MwvTv8Hy3BO5uy2HXh0VYWf+JY6AiJ3Z7vlvQHwuMKbU4/6csSjMnFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730894492; c=relaxed/simple;
	bh=PQUaNmhCftixjcjPvmM5IEF5VOVSnPAEw/w/dSs0lYc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TCbWh8NU8CF1hNs+nB2+e8K5GMeUDzj7V7QW9FagU080/ik5yVm4FmkR5Fsqy0j2/5vS6WsRdIB6YE2f+LlFG2gGuBEloiT3B812qqjCWCQBm4QWsAzlsh2ZsC/qIx4sZkH6D5dblLzndRAyeMoxW3mDH2r9lah7QbrmlqKgwhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=d+xT45VX; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9a977d6cc7so483414066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 04:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1730894489; x=1731499289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T4OdoU3Lr3nA667dN5ioAfPSrG7GOf/Q3AS1dKLXo78=;
        b=d+xT45VXfxcxvBdFkWafFk1XXwyV4uB83uiH/5DhKkP2IWtd2cTe7OBUBgpF5VSLif
         qFkyPFWeVxexY08jCCPJ2pSaTo/JvaaBTtrCZ7WJD/c8F9O8vRoRr7TfJwCWG/KM6r0H
         BhVCRV/t7fEqzGgZO31wVRQvHU7ovQE90fPBtRt3U+JjRZig28EZEn6BgZ87yqgxt2kQ
         mGNzgeOQ5ube/FWyB9IPXBWTj/foB9AbGxxmcs9xlxmmjAS5udLe930PSWGMQRIor2PV
         OyYTCl5sM8cNxbVW3NoBcdFSofgjioks8v0EwNPfsUf9QPtHGBJAJkB6BG8v7PA6IvXb
         FgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730894489; x=1731499289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T4OdoU3Lr3nA667dN5ioAfPSrG7GOf/Q3AS1dKLXo78=;
        b=EaXoC9E5mXcEuDoZJZiIXxqWHQuMS/UGJxJLEru1XIPkijSgudhT/M5Fn4Zx116OgR
         JDBNKwPKSKfcvprSxeFOiWq4v+A5Tda1CZkEHcCLvtcbG7Oj6zh4PKLKfblFQsGXAVA3
         o9JDVl1tHZyfaJ2mh3iWRlEW7mZPS5ssLOIWDLonU17TuYor+sGDJXZkp2EuKvdCeb1N
         XSsUTUMmc6AaY27yv9aLO60jqw8grD4iGR0Ft+XA7AVwJwtZwBjd8+hzn1j/XIpbXOMZ
         IuzucgcdQ2qvqdawv2mefJrXOxjUXjeZO02WFXOIZbEJqFn7pw2r8DjZWSY8VznKR2tL
         ItDg==
X-Forwarded-Encrypted: i=1; AJvYcCXHCNi5mPu3YXkp6yMPrYrSBStZq7bsShakvDU6vy3OZQ5Y1yNVn91uJsIYxBZo2NKmoRw6i05rAlK7vv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqfigtr0eTDW8GVUYeh8ySpYD4bvEhR3G3KRe/ccqfwXuUQn0K
	dFZ2o8CDwRD5W51SkKFHG1ClttjcTofcWh+QKadhddBrMgXp7dqb8SqZZjeRGzQ=
X-Google-Smtp-Source: AGHT+IEMBnLm3/r2LARk7JIsFb0z++ZbjgxFeX0AqX0aEeTorNzBh5pVrmLo1R/U4UFfsHZpRWOlUg==
X-Received: by 2002:a05:6402:5215:b0:5ce:e5c9:4491 with SMTP id 4fb4d7f45d1cf-5cee5c9455cmr7256569a12.15.1730894488782;
        Wed, 06 Nov 2024 04:01:28 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cee6afe528sm2697984a12.55.2024.11.06.04.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 04:01:27 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	magnus.damm@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	p.zabel@pengutronix.de,
	lethal@linux-sh.org,
	g.liakhovetski@gmx.de,
	ysato@users.sourceforge.jp,
	ulrich.hecht+renesas@gmail.com
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 0/9] Add support for the rest of Renesas RZ/G3S serial interfaces
Date: Wed,  6 Nov 2024 14:01:09 +0200
Message-Id: <20241106120118.1719888-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

The Renesas RZ/G3S SoC has 6 serial interfaces. One of them is used
as debug console (and it is already enabled in the current code base).
Series adds support for the remaining ones.

Patches:
-    01/09 - adds clock, reset and power domain support for the serial
             interfaces
- 02-03/09 - serial driver fixes patches identified while adding RZ/G3S
             support
-    04/09 - extends suspend to RAM support on the serial driver for
             the RZ/G3S SoC
- 05-09/09 - add device tree support

Merge strategy, if any:
- patch 01/09 can go through Renesas tree
- patches 02-04/09 can go through serial tree
- patches 05-09/09 can go through Renesas tree

Thank you,
Claudiu Beznea


Claudiu Beznea (9):
  clk: renesas: r9a08g045: Add clock, reset and power domain for the
    remaining SCIFs
  serial: sh-sci: Check if TX data was written to device in .tx_empty()
  serial: sh-sci: Clean sci_ports[0] after at earlycon exit
  serial: sh-sci: Update the suspend/resume support
  arm64: dts: renesas: r9a08g045: Add the remaining SCIF interfaces
  arm64: dts: renesas: rzg3s-smarc: Fix the debug serial alias
  arm64: dts: renesas: rzg3s-smarc-switches: Add a header to describe
    different switches
  arm64: dts: renesas: rzg3s-smarc: Enable SCIF3
  arm64: dts: renesas: r9a08g045s33-smarc-pmod: Add overlay for SCIF1

 arch/arm64/boot/dts/renesas/Makefile          |  3 +
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    | 90 ++++++++++++++++++
 .../dts/renesas/r9a08g045s33-smarc-pmod.dtso  | 48 ++++++++++
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     | 25 +----
 .../boot/dts/renesas/rzg3s-smarc-switches.h   | 32 +++++++
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  | 25 ++++-
 drivers/clk/renesas/r9a08g045-cpg.c           | 20 ++++
 drivers/tty/serial/sh-sci.c                   | 92 +++++++++++++++++--
 8 files changed, 301 insertions(+), 34 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g045s33-smarc-pmod.dtso
 create mode 100644 arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h

-- 
2.39.2



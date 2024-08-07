Return-Path: <linux-kernel+bounces-278022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CDF94A98D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69C8A1C20F20
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3CB5914C;
	Wed,  7 Aug 2024 14:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="L5phjNjl"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70935282FB
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 14:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039973; cv=none; b=AQI2ia4y97zqqjsR0418VcWec46MunNXEdTSwn5nLLo0sjCmXS6KPtyNUJryAaqyYLxrCwEhpL43b9ZHJrnu9lqZbrZAYVMMaUSJibHuarS4AJLb9LbeFyCEvNqGvJ1ny1O82wkVrwHE5eUPRygmklazkKBpDVeXLKB92MdaHPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039973; c=relaxed/simple;
	bh=MwwwlILPBrJubGFy6q/y6XZ7ELEBOo3CsDbrxodDZtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o3rCwvZ+hOi/O62JglWiA/dSOq7BxnsJ8JKhoZpmiyZsRc4fOi/xwj5G3HszS4EdK+GgiMSMlG7UiRF8cyWi89GNN7LTW/E8p1E+mSDXkqGMQXvg5fRfgJSTQ+AIH+UX+O3xHPYRBT1GGt0+Q3YLFCyb6J3axH8w+Kr6DOqliUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=L5phjNjl; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52f024f468bso2237501e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 07:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723039968; x=1723644768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rhnBrsrtx8JhjXSaZo5MeZvYsFC+QghJ1OF9fPH+ytE=;
        b=L5phjNjluLI/du9LQX4NRL8zcDidFj1bjJsF67/W7epwNpES3X1/P1oyqBZ8SfcDKB
         sHQBbIUFybOsPsqRsRXtrUH8H6T+TMcOOO8qn6FzMX1s0KrJaiR3hnzyZvQJ6EHR+N9i
         ZEPPL4bU9yG0R4igzB8g5sTciptxLkMzVFGiv2EAIDCoVJe2ldAQbdlIEZKe33HbXQid
         PpkS9J5zrEv8Aq/HwsWjeiUBNTOXxP2rsxXljPoenGO2d0KXiETVVAQBQOoMUSSO5Nd8
         RBzdZ2iUrRuUbZYZJ0d+FBKTiaD8lLNKz239xjhfcyNDqbaC03rEICcaVevCGX0LxwTP
         S63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723039968; x=1723644768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rhnBrsrtx8JhjXSaZo5MeZvYsFC+QghJ1OF9fPH+ytE=;
        b=TH5Zox2KmOpnSq2R9ItByW4qfgpQirG9maE7a1Ta7pWuAvsRn1bYtZWJ2FKVXA5IEQ
         z2k2ycjjf5oN1bMDosKKg2YagrGu6/jwMvok9CLH3H8U5AjJ7pVc2jn29Mqb9FXE6bP8
         UvyELX/et6YMSup1Epvz3wGdI1mj4XOaYCGsOPvGsoIBHj97HXwkYOSNtkWUeV4qLuCR
         T4ukz8Zrt0kKgqPjT28GdH2laKvyU02phE9dYVoyor7eOn3I6SP/IK09jZeziTKtyGGk
         QZkSb21MzEH8Rg2bjXY/Y9b5AWOH9MeybFsfjoBSYXEgc4b2ZnKhgnV2Op6TWR+LV6g/
         /+kw==
X-Forwarded-Encrypted: i=1; AJvYcCVyVehS+gNh9Q0M5/zN3VgYfYJZ9kMGxiH/vB8s0dpkCOIruxyDcg4hcqAt5jduOtxPtCFOiziKMhkDtIqHoOByllw5q7QPtAMyU7r/
X-Gm-Message-State: AOJu0YyBP2RhaorKmLujPSX69gChSLVT8aH4/QTriBwar8IlGNgcij6G
	OFJ3J8+6e2iWKdqjXDGiFILqX1wLGhzRZBoGyz9w7gkX798rM5tMtjkSd5K8n3I=
X-Google-Smtp-Source: AGHT+IEJyt0WGEXWzqRXsX8JTktfdH+4TvqQykj+Gjwr32tHfWEz80uMq7FNr1g7QseHu2DJb76PiQ==
X-Received: by 2002:a05:6512:3d11:b0:52c:d750:bd19 with SMTP id 2adb3069b0e04-530bb39d200mr10835746e87.8.1723039968086;
        Wed, 07 Aug 2024 07:12:48 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83b92cbccsm7057525a12.68.2024.08.07.07.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 07:12:47 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Tony Lindgren <tony@atomide.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Thomas Richard <thomas.richard@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Udit Kumar <u-kumar1@ti.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 0/5] serial: 8250: omap: Add am62 wakeup support
Date: Wed,  7 Aug 2024 16:12:22 +0200
Message-ID: <20240807141227.1093006-1-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

v2
--

In Version 2 I removed the Partial-IO specific patches as these can't be
tested due to power issues in Partial-IO on am62-lp-sk and similar
boards.

I added a patch to add DT 'wakeup-source' support.

Series
------

To support wakeup from several low power modes on am62, don't always
enable device wakeup. Instead only set it to wakeup capable. A
devicetree property 'wakeup-source' can be used to enable wakeup. The
user is also able to control if wakeup is enabled through sysfs.

Base
----
v6.11-rc1

Tests
-----
I tested these patches on am62-lp-sk.

Previous versions
-----------------
v1: https://lore.kernel.org/lkml/20240523075819.1285554-1-msp@baylibre.com/

Changes in v2
-------------
 - Remove Partial-IO patches
 - Replace device_init_wakeup with device_set_wakeup_capable in
   omap8250_remove as well

Best,
Markus

Markus Schneider-Pargmann (5):
  dt-bindings: serial: 8250_omap: Add wakeup-source property
  serial: 8250: omap: Remove unused wakeups_enabled
  serial: 8250: omap: Cleanup on error in request_irq
  serial: 8250: omap: Set wakeup capable, do not enable
  serial: 8250: omap: Parse DT wakeup-source proerty

 .../devicetree/bindings/serial/8250_omap.yaml          |  1 +
 drivers/tty/serial/8250/8250_omap.c                    | 10 ++++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

-- 
2.45.2



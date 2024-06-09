Return-Path: <linux-kernel+bounces-207361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD44F901623
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 15:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B7D1B20F73
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 13:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342473FBB2;
	Sun,  9 Jun 2024 12:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PehTp77C"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32DF2230F;
	Sun,  9 Jun 2024 12:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717937996; cv=none; b=TfMz2aULYKmuRW24xHP8R3NU5S4adJSmUfpOqx47fo64S51y/M8j9oRpxv99xo3S3tmlGxed4FxspFmJJ3TFSCKTUh+YiG2yFf/Y+nk0nLlSyRCBKRGc5fYFcAudoapHO6hYmbIN2JHk0G51ArftOVyEdesVSfQh96NI1QXQbtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717937996; c=relaxed/simple;
	bh=ZBEzRfn+mFCbyufKXc/4c7RplCyGr6rZvxeGQzawPT0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GAD3ZT+xqj+G0ARGEX6Qt3my5UV5DQfjSYkum23gpOpuZcdlAu+saYP6N999rFWKeun9PiVzu7qSQnn1ccB0aGjYxgwhKidtR8ltFNSzHsyi2d/YQpswA77Ew68HZSjfFg49F6L/PhSunkWr9OdLV2moGIlBmRoYbZO8FqsZvgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PehTp77C; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52c8342af5eso685016e87.3;
        Sun, 09 Jun 2024 05:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717937993; x=1718542793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zvgraGsdwP8qNq0CbLRpBxfSdVjyK/qpe06H5/qHpTM=;
        b=PehTp77CFUMUerE7WxPgl2P+14sl8WKYQI8JuBiC5+4MtE42hAxZx2CSpm4nbY5BD5
         gmBgzlTpQ2C602MYeLJGcKIHtqq1jTPTeFtFXwUxMjIn/vOXqp/xPue7qeeCVRa5KHNk
         0zGv8UEzagiHMHOJuJ1EI3W7BwcYB2HxrbPGE8Ft8ZRghxeT9O1mSgN1BU/ADdDFDtLV
         qskdsCEXfU1ETYW2xaazqZHcBLbePm+r0waD/Ku+M2mbpcnUWoQKi9vGzvMiw7nG9TsB
         yr5L4Vw66U/5rle2eDepA2rQb1mbwlpKICZOcNYJOBOrwSBZFWMSWRrE1LmfM9AxhgWl
         kjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717937993; x=1718542793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zvgraGsdwP8qNq0CbLRpBxfSdVjyK/qpe06H5/qHpTM=;
        b=fp+SZyl9Q1FyMRT3vlRpaEjopXXHKBtlPn0N8PTqK/DnmpAFYH5d/TrkwDQeU/z1F3
         1EChkz7qNw2GAP1NXTm/KNlICO3uVVTw9vMGxxv3yWwVn77QQA4qNN6ZxZQji2KqaoWg
         ST78Z8swvtVJ2QAdF3iBwiD6cF2wqI1Kx3g+pOq5AO6EjE4MtFTrjZINXVAsKEv9+s9b
         8PIvkwkwNYmFreSWvZW11oBT4Si3fMkbe8z8q2QH3VRXxnWwxUjrplpWj/OmG18iAn6b
         ua2rxcShc66fm0UiUrC08ddqDNHt/EQaQVPdQG5nV1gB64Ie6J7lFGbR3sSilyGFxgTg
         maxA==
X-Forwarded-Encrypted: i=1; AJvYcCV8bNjDc1emHn/AM2ZvTmOwmO7wPnGAehMigxx9YVyfGvkwCAh1ZXUlI9wB+ZYdh31GlipobBhsSG1oFLh2f1L+0t+bx0KD/iregHVRl6sw6XXvTxTBOXT+TYZ/PIM2bLRH+TJl3wB2uQ==
X-Gm-Message-State: AOJu0Yy8qTumiTJpJXHHbVmVAYm30TuXA8YkfPbtPCOgNBz09BXiSMr9
	zCw017BmuCjkqOdQG8XH8OAmLi39nJmCBkdAbq3yHpMiXM5StjeX
X-Google-Smtp-Source: AGHT+IH0kfJd+mvMseVa+3hYIyeisA8ltLtAHrUOGBmoHFRBwQJplxengofSYzowRy3u69oYOatzLw==
X-Received: by 2002:ac2:4989:0:b0:52c:7fc9:954e with SMTP id 2adb3069b0e04-52c7fc9976fmr1948585e87.41.1717937992741;
        Sun, 09 Jun 2024 05:59:52 -0700 (PDT)
Received: from lmc-playground.localdomain ([188.25.209.252])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f1841fceasm85961266b.70.2024.06.09.05.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 05:59:52 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liu Ying <victor.liu@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: laurentiu.mihalcea@nxp.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Add support for imx8ulp's SIM
Date: Sun,  9 Jun 2024 15:58:58 +0300
Message-Id: <20240609125901.76274-1-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

i.MX8ULP's SIM (System Integration Module) allows
control and configuration of certain components
form the domain it's assigned to. Add DT node
and schema for it. Its child shall also be
included.

---
Changes in v2:
- Reset controller is now also a syscon provider.
- Changed vendor prefix to nxp.
- Link to v1: https://lore.kernel.org/all/20240516204031.171920-1-laurentiumihalcea111@gmail.com/

---
Laurentiu Mihalcea (3):
  dt-bindings: reset: add schema for imx8ulp SIM reset
  reset: add driver for imx8ulp SIM reset controller
  arm64: dts: imx8ulp: add AVD-SIM node

 .../bindings/reset/nxp,imx8ulp-sim-reset.yaml |  68 ++++++++++++
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi    |  13 +++
 drivers/reset/Kconfig                         |   7 ++
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-imx8ulp-sim.c             | 103 ++++++++++++++++++
 include/dt-bindings/reset/imx8ulp-sim-reset.h |  16 +++
 6 files changed, 208 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/nxp,imx8ulp-sim-reset.yaml
 create mode 100644 drivers/reset/reset-imx8ulp-sim.c
 create mode 100644 include/dt-bindings/reset/imx8ulp-sim-reset.h

---
base-commit: fec32ea96dd90bf0af97e001f380d4a240013aa0


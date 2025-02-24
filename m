Return-Path: <linux-kernel+bounces-529687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBC0A429DC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D667164ED1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51C61A9B28;
	Mon, 24 Feb 2025 17:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="YY7SNxMO"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B2A26280C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418320; cv=none; b=fzVgPcZIG2wPZJ16m443y3VbmYDEX3bZ9owlogULYixI5JgX/b4jgj44pfULIs2CrIY2bUl3qlvywYGv9IUe4rK6r2wlc1k/BfrY3upKWreBoRxRONrR4atl7kT4de1pazU9qy4vr+dGXy/ejDvmsDglji4c3ECra0+0UBtrctg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418320; c=relaxed/simple;
	bh=+F8M3PdAsJIpcWkKGTRP+OqlpeWgGNzF0lJdz88t8Xs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fx2IQnxL6ef4umAsDGoJbObiwTV8jcxjfXn6jqM2U8cX4Wt25zzwhnsYXB5ea8Xy0zsXvrsbaNi+TS8vgvefJ4zN60rxYWiMrMT4CXxMJ9R5nZnpnYPXLQdI4NW2Lnt0MMziP8IaWjDM7xA5sTck1+u63PGBgzQWEvyujXwn3MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=YY7SNxMO; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e0573a84fcso6428070a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1740418316; x=1741023116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dsclqQFCsZDMndtlLXiFjksSQ0t4bojzK3MB88KzrgM=;
        b=YY7SNxMOFOwG7qfkeWJv/umMs/3L3+yyW5E7Kp8fWngTrhJjwb+Z+WVEG/4w6IVL5x
         e8Ih5a5BdLOPr3RKfE11O9KSLsF+fZG3xBoqzcQLPAq3pYeictzTJVYxM1sm+1FdFdmu
         pd2ynjSIEygci8QMjgEzAXxKAgQwdEL9jrYlfUxZfSnnOUzaAiRpFUdeUpPjT95c89z6
         bdCzrYti4bHPIep8LDmndK1UQ5AJxNkCysyLmBlQ3nKeHr018XcQrhFO8YVf+77R8IfF
         nXEZYsKUyN9puTvfDVwzt+yH45i7kVP2Rmrnt9pukPrVMCHVgBwK2bTQ4x8j5CH7cPuz
         3HoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740418316; x=1741023116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dsclqQFCsZDMndtlLXiFjksSQ0t4bojzK3MB88KzrgM=;
        b=jKrzfddxm430PqsjZo8NMLM8a/WUOLj+PrZKgn6wJMwOy7OOWfUAi08SA+IU7G8GF7
         nW0y1kdMKHTbEjF4QbuY8v8E8468iBZAg0lc7PpdnHj++sWWzF5nKIzomw3YpilXGQAq
         zOFf2NI06GPXFr6SWdkPU9hm7CAcNw09wIIO7kiUpnTuoDZBwEAUttbk4MS2Xyaldn+o
         MeK+afBCX7rXENARAWtNadBDLYGgWg0By0HaqhcjE/iXpDCjVu5tZwlREneZJv3eWsoD
         YQS7Z1eTuPWp7MKFOUKJ87mVoYDpJtDlQCS3qmGU80vnnuq6gqRnYJ6e0Oxvru4rA8fT
         qtNA==
X-Forwarded-Encrypted: i=1; AJvYcCU/OwMkjmnt6MO1nXPT1rl+ncyzYWm2yPBMoq4ELxn6UxoPbDcg8wNzC/cw6e7RyB14CRTH+5HNChaMZKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr0zgmgiIACodOt47jeMyMHj3eWtaCnKoEJwA5oU/8Vhj/ys/E
	y+0aRW1OV9HKiEsy0Vn3tuXjucpp1HmF+EmY8QrDaV/0SWJj6KZngtN6RRClK4g=
X-Gm-Gg: ASbGncthOg8xEonYSakisiD1UMYWQpMASbcxBpLyM+tTwXEmDxxWpogDawQnyGtMgBp
	HRJsYpSzsP5rGlHyrtin7FPWSMFLavMXtHkkZt7YHxhI2yq9Vph7mfzXZLR1/EQVUcsgCTQzeyT
	2wdrZBgHSCHVKX0KX1BZ+q94RDddqA+HLE5Q8+dAXaL/0XX4kfCnQe7TMoDXyAPWQfsNDWTrWyQ
	7C0TLKr2G5ZTxGKfl39wMtBj3IO/ZvmlP6wq5Y+4bnAIqF4uidQiuZy6aN5qtAAtkRp09wvoslU
	7mi39h1HTIeOLIL3WhWq0CUvfl9PCaVROwxSYc5JMwffwSe+AzfFbN0=
X-Google-Smtp-Source: AGHT+IE5P2Pc2ulD686tbXmldMuv37Ren86tZmw8hKdJojopByUms6FVwARmV7spLnl3u/zaSknl5w==
X-Received: by 2002:a05:6402:388c:b0:5de:c9d0:6742 with SMTP id 4fb4d7f45d1cf-5e0b70df001mr11915007a12.9.1740418316384;
        Mon, 24 Feb 2025 09:31:56 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece270a7fsm18674357a12.58.2025.02.24.09.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 09:31:55 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 0/4] thermal: renesas: Add support for RZ/G3S
Date: Mon, 24 Feb 2025 19:31:40 +0200
Message-ID: <20250224173144.1952801-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

This series adds thermal support for the Renesas RZ/G3S SoC.

Series is organized as follows:
- patches 1-2/4:	add thermal support for RZ/G3S
- patches 3-4/5:	add device tree support

Merge strategy, if any:
- patches 1-2/4 can go through the thermal tree
- patches 3-4/4 can go through the Renesas tree

Thank you,
Claudiu Beznea

Changes in v2:
- dropped the already applied patches
- dropped patch 2/6 from v1 as the devres_open_group()/devres_release_group()
  approach was implemented in this version (similar to what was proposed in
  [1])
- collected tags
- added a passive trip point not bound to any cooling device, as proposed
  in the review process
- decreased the trip points temperature
- convert the temperature to mili degree Celsius before applying the
  computation formula to avoid losing precision
- use int variables (instead of unsigned) for temperature computation

[1] https://lore.kernel.org/all/20250215130849.227812-1-claudiu.beznea.uj@bp.renesas.com/

Claudiu Beznea (4):
  dt-bindings: thermal: r9a08g045-tsu: Document the TSU unit
  thermal: renesas: rzg3s: Add thermal driver for the Renesas RZ/G3S SoC
  arm64: dts: renesas: r9a08g045: Add TSU node
  arm64: defconfig: Enable RZ/G3S thermal

 .../thermal/renesas,r9a08g045-tsu.yaml        |  93 +++++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |  49 ++-
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |   4 -
 arch/arm64/configs/defconfig                  |   1 +
 drivers/thermal/renesas/Kconfig               |   8 +
 drivers/thermal/renesas/Makefile              |   1 +
 drivers/thermal/renesas/rzg3s_thermal.c       | 329 ++++++++++++++++++
 8 files changed, 487 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml
 create mode 100644 drivers/thermal/renesas/rzg3s_thermal.c

-- 
2.43.0



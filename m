Return-Path: <linux-kernel+bounces-573779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B265A6DC3B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F66C16CDEA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6634A25F7B0;
	Mon, 24 Mar 2025 13:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="LdnvjBV+"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE99025E444
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742824632; cv=none; b=oqcpZx7ddqiwtYIx8YeaM+FM6x0ePzvSJ7kn/KPdKG2EL/Tj5vfyGNadh+kDUoJzQMHEAB7ZU4MCE+aPqMID86RYGe4TkPiY4bvVTmE5OdLRpSTPnJzNvRZQJy3MM4Np5uGoLWTFVmp/sRgqZ+TdhaXJV58Qvkl3zIKrMz764hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742824632; c=relaxed/simple;
	bh=MPO6jCCozjhYMoPt4y+gKPOuX7ez+gZqkKwymGwFc0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oiriJOozHSuNXNgalCH+DWQwV4BOYNqRqllc7TZhFtgIrLZswvePAE2NDYDt8Nm+5JBAft00fk/mNEVyyrPGXp3TfgiYOHp0xtVOC36mDRkPlchpIVbmpQna44zUCzXdQqUmF5pHSEBUgmYAIdIJAjnsqP5mdgPxCfq3Rs7nni8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=LdnvjBV+; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so34427185e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 06:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1742824629; x=1743429429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=geHsdT1vrdpFfM6YFLK2c0Yi2DY1fN5x5Y+Dw80cp/o=;
        b=LdnvjBV+8Eaye8ho5RjmMoedW57GovKqz7vx45WSQPkXG0yau3B7sA8P3xg6+X7bUC
         UaR8J6UYHxcgTN3Y2e6mad1yF5zV/upEiMnA1slqtErekQzAL458hzSXEiZmsWEk9oc0
         aXQnpjXcQlLLqSITTRhjEcggyjxxvjK6nfVs/qRt82JxcsSm0HCqo+ugkA1aSALB2d0N
         kHf5YDBXhaAB/DMT8K/haBwA+h3ZSiIsqxSztQzcEUqh9h3NdZaHoukIi+Q/E36pXCXU
         +Gqxg5u/nS/H7IoGddCW8NKiYtrnQ3iTjsm9ruWzP1slCJFUAZdIJBorqECIDK9j8asJ
         +igA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742824629; x=1743429429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=geHsdT1vrdpFfM6YFLK2c0Yi2DY1fN5x5Y+Dw80cp/o=;
        b=Lqlqr1w7j1RIBJ3wIGsYAGTXoOmJe8UXedgXBEQXCX3FsV4oMU3iNaqYtCd19eK12U
         YeY7+ibeJJ6lYupvu7aKlpAB3oRJT+jvCPk6jLZdcqB+2YmU+VWe/Ni44aW9rIaVHsTV
         +rV39YJAFuVZrwS7vdwaSp2wVH8h8+NA+SkNJKkSDvpQnL7R5791ODGs6ULQn59z1IuK
         ZS2VjPP6CWP6Ea89V1cbnVHSCnVum4FhxGrz4mWEb6zNo8Io+INhk/UwNDP615E+suI0
         LU/afifLJy3OkYkEkRk+1cEbMavlcX5RS2qCVLp78h6P6P65W1wH5kpjyoYX1Ia3Bhwh
         uKeg==
X-Forwarded-Encrypted: i=1; AJvYcCU95TYs2lO0RuGKhJ7GdRSFho+iuYPQlmAOFeTpEfAKi9gkvD47zfjTHPjA8i8o5MnDtmvL69l79Ha5a4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtTJ10itTATCetEM3yz3+Rm9qkVfIzb7n0fLsT2wtObwIMC2kQ
	KMGRUKGinuDgIk4mHyLMt1xJaCvwXI2MJR0x2rowJlfe67i9QhllDSJkFXAklfg=
X-Gm-Gg: ASbGncu5c1lyxrmcItA8gGzS3Jv7laWVGWeum/lJ1zkZdIbuR3LRXKvUQ8IK/glX/jK
	uRhhQsJ/O9dVayJtAEc8WCl6lT5/T+zBwkNSeXkEofgw6gPOm793kJI4bzjvVtrKxaNV7Cccq80
	XQOcNxNf8V0KhlEd/pLFYG8nXFZlfVI0xfM7GHhDspu0Y4eBnw20WK/ySoeV2H7E1TPNAwtO0Hh
	7n2fZAsTfrPJJ/a5pKJnoE5CP26lhEWncQcDoFi5MnfWcMsi8OEYFgiOS9Ua+7yEeBsIri4TfBZ
	BcLr4B9508fnNGz+PhQhgvPgAZzEsPdYB4RWcwMqkl446gP+dr9MhMY6v84r8MUnv+165chbMg=
	=
X-Google-Smtp-Source: AGHT+IGkbsgJvhaLoKe9hCL01Phvk9cQWomrPl7igNBxsiltgQYpsqqfKtqy6vBzpm7mTH5vwHyozg==
X-Received: by 2002:a5d:64a8:0:b0:390:ff84:532b with SMTP id ffacd0b85a97d-3997955cc22mr13735349f8f.7.1742824629087;
        Mon, 24 Mar 2025 06:57:09 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fdbcfaasm120146525e9.35.2025.03.24.06.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 06:57:08 -0700 (PDT)
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
Subject: [PATCH v3 0/4] thermal: renesas: Add support for RZ/G3S
Date: Mon, 24 Mar 2025 15:56:57 +0200
Message-ID: <20250324135701.179827-1-claudiu.beznea.uj@bp.renesas.com>
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

Changes in v3:
- drop runtime resume/suspend from the temperature reading function;
  this is not needed as the temperature is read with ADC; this is
  confirmed by the HW team
- use dedicated function to open the devres group in probe; in this
  way the thermal probe code is simpler

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

 .../thermal/renesas,r9a08g045-tsu.yaml        |  93 ++++++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |  49 ++-
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |   4 -
 arch/arm64/configs/defconfig                  |   1 +
 drivers/thermal/renesas/Kconfig               |   8 +
 drivers/thermal/renesas/Makefile              |   1 +
 drivers/thermal/renesas/rzg3s_thermal.c       | 313 ++++++++++++++++++
 8 files changed, 471 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml
 create mode 100644 drivers/thermal/renesas/rzg3s_thermal.c

-- 
2.43.0



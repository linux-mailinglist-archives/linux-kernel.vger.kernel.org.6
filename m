Return-Path: <linux-kernel+bounces-293750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35179958403
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE0EF1F2453C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF1B18CC17;
	Tue, 20 Aug 2024 10:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Qj26RUCc"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8FB18B46B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 10:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724149172; cv=none; b=URNhApE53Qn9BMLXVejzHGJLwGxLFQF/OqHp0Ol4HFyK16lNehmT39Icxl3ltfmw+imSO3tfKidtfj8TWd4FwefGDn6yIM2aZD2rZBbL7Mf1lbJ4MrSKfu5JKJAFK4jL+ufK+oQpk8sdJdQtmw0kr8vf981lAhBhquKyOC+LcHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724149172; c=relaxed/simple;
	bh=m0ES5uUI0jcNmiU0mdZz0DaeqC4N94Y+fd4atESJa/M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tR51irHGggBBAnm6QaHguyVnSg8pKQ1IS54TG3pgIL/muOgopAKT9rIY7d4+seP4+CI9arENXo2bs+8ooBFkm9ne4HetvILJh4MpQ0tVpZnaYiHQ2lKIiKM5RoHw26n2KQKzeRAAPByAUtQYKIjNkwqmfLo3VVQ4l9ouFnEm2QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Qj26RUCc; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7ac469e4c4so914227666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 03:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724149169; x=1724753969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AF9buHKMfICNZa553deCJdUU+D409m0Zr71mu0SOW98=;
        b=Qj26RUCc5pI26niTIRytQrsHBHRSd4v+Z4GQnJrI9eGgoP7hHmuRrxm6dKUzAdHhLC
         F6crEXcVqGC+U8pFASwpyVr0pxEe8MeJjSnCWRZrCk7zsntHFHElecs5ImRuGQgUVtf/
         +tNjZALROj9FpAUBBnjWh4RpJht65LUn3FKSAMH6MeVAJWZLXJr1pa8FRCuqOUUARWQY
         N8QWfoMIPT0cWn8STQ+grjFFmU4bvwlSfeGMYNBznBerb7E9ocdoKiKM6sIgkwrTGYqG
         /d/6JybxRNKjoBkqRDR0xUtYfruUaBmgV2preMqvVwXdfSHVHiss4+j7XWLUdMkt7QKF
         1Dsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724149169; x=1724753969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AF9buHKMfICNZa553deCJdUU+D409m0Zr71mu0SOW98=;
        b=cjXTLdEyELssFm9xXknBMv9mcwSRSoyB3xP+PlA6NP+imBQmgvh7uybZ17B3Kyt1Wj
         zioO4Kn1/moaBruYOPJH+G9hM6+rug3PjlQgMkKEOfATUEOpYwJ3+SrgpsUqq9uxCEpN
         vVkcTKO1Da4atG5/VCip1yJj6Z00oEYU/rJXj1bvw5vmUeLQltNI0DswcPUfCBjsks3F
         FHHRe5/GPYINpv020Me8lg2YLkUNQRJXPVJ+sROtswgRebHruLBavCihCizg/uLgC5gp
         6tS7MQ0PoltErmNr4oXKFKDzrLiVvkBRdBqFfC/KkDKvKZbSxPAQ+FagfYTV33mQezqr
         wj9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXsozDQ+xU/15Z/VJ4JU7I2QzkjdqWCmNxdNOkmy9SPhantwI8XSTs3h1p6Z3xUJOlP2QfhSoIfxoSuce8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK47K0d97KhkOBm0fdcEhuiFRKrJsNLXJWs0xhXItfx/xS9gNL
	9oqTTdwcwDJn3MKQ+LkZbrzH9BZ9ajHnxQjy8t0YjNzPBKGDk6UuzYoZQ+PMlaA=
X-Google-Smtp-Source: AGHT+IFnFqGgKfjCp2/hQkSOAxfk7Dh6OkTPFERMMyzZwbDP4/eO5E7Gziarjv59lRoKwVRqFfSRzg==
X-Received: by 2002:a17:907:6089:b0:a7a:ac5f:bbef with SMTP id a640c23a62f3a-a864411863bmr232507966b.31.1724149168828;
        Tue, 20 Aug 2024 03:19:28 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83839464ebsm734550066b.155.2024.08.20.03.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 03:19:28 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: chris.brandt@renesas.com,
	andi.shyti@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	p.zabel@pengutronix.de,
	wsa+renesas@sang-engineering.com
Cc: linux-renesas-soc@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v5 00/11] i2c: riic: Add support for Renesas RZ/G3S
Date: Tue, 20 Aug 2024 13:19:07 +0300
Message-Id: <20240820101918.2384635-1-claudiu.beznea.uj@bp.renesas.com>
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

Series adds I2C support for the Renesas RZ/G3S SoC.

Series is split as follows:
- patch 01-03/12   - add some cleanups on RIIC driver
- patch 04/12      - enable runtime autosuspend support on the RIIC driver
- patch 05/12      - add suspend to RAM support on the RIIC driver
- patch 06/12      - prepares for the addition of fast mode plus
- patch 07/12      - updates the I2C documentation for the RZ/G3S SoC
- patch 08/12      - add fast mode plus support on the RIIC driver
- patches 09-11/11 - device tree support

Thank you,
Claudiu Beznea

Changes in v5:
- collected tags
- addressed review comments

Changes in v4:
- collected tags
- addressed review comments

Changes in v3:
- dropped patch "clk: renesas: r9a08g045: Add clock, reset and power
  domain support for I2C" as it was already integrated
- addressed review comments

Changes in v2:
- change the i2c clock names to match the documentation
- update commit description for patch "i2c: riic: Use temporary
  variable for struct device"
- addressed review comments
- dropped renesas,riic-no-fast-mode-plus DT property and associated code

Claudiu Beznea (11):
  i2c: riic: Use temporary variable for struct device
  i2c: riic: Call pm_runtime_get_sync() when need to access registers
  i2c: riic: Use pm_runtime_resume_and_get()
  i2c: riic: Enable runtime PM autosuspend support
  i2c: riic: Add suspend/resume support
  i2c: riic: Define individual arrays to describe the register offsets
  dt-bindings: i2c: renesas,riic: Document the R9A08G045 support
  i2c: riic: Add support for fast mode plus
  arm64: dts: renesas: r9a08g045: Add I2C nodes
  arm64: dts: renesas: rzg3s-smarc: Enable i2c0 node
  arm64: dts: renesas: rzg3s-smarc-som: Enable i2c1 node

 .../devicetree/bindings/i2c/renesas,riic.yaml |   4 +
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |  88 +++++++
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |   5 +
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  |   7 +
 drivers/i2c/busses/i2c-riic.c                 | 225 ++++++++++++------
 5 files changed, 261 insertions(+), 68 deletions(-)

-- 
2.39.2



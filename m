Return-Path: <linux-kernel+bounces-542703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0315AA4CCA7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 21:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDB001893324
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A57E235362;
	Mon,  3 Mar 2025 20:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S53b1Hmf"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4A51EDA3E;
	Mon,  3 Mar 2025 20:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741033675; cv=none; b=gGV7DmTijVBcCBJXgDTaqaDikVwCmcH2XuYHWOWzV/OE3zTxOMoziC0RA+pkwx60hlQ7SybNVUDbRKDkuYIe4z4HrBvQlwd3NUu6Zwf5byI5O660twBHJ8H5lUt+6ESy0+M3dSHJM3zJgiO+mb1CKuNnkoGGAYmgoxS61Ai9u6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741033675; c=relaxed/simple;
	bh=gMD9k1Qgdbybv2uBOP8stTocBsHxADMCNCVyb3oQlDk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=okrwKvnHlkoK6m5WDyFjFGT6o9vesj08PBn1pBM4Au3oMKpMuHreSrT/Yih8HSp7FbOpR2u0C55dsAdnOGYk5KYJxh9aVBf68iWSMcEY3kuFaDsirP7OWNrS0bzhHVjye90CC3ASatsRUA6W9mth6kjnRHEqn4C5tR/HzixkkGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S53b1Hmf; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abf4b376f2fso424623366b.3;
        Mon, 03 Mar 2025 12:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741033672; x=1741638472; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5b60CN6bgvsucEwRWCH6wo9YbTIOsAqIH7mkhNo9S0Q=;
        b=S53b1HmfY7/LkXz4xqy/3IHCbp2NDaZ/TwmTi7F1Bf+pkCwkUgLNeGWxXTWJDZqks2
         xNpOEApyTYh38h6pZC7GHNkNM8eizrZk9JR7dUaV49NucXMwauhBk4YR3XyqSGlRypCa
         lTT9FxRzT8KJ38DH2CgoBjUDh0mgbBMp/JM27iKeoa+6IJ/S2I5DF/S27Lq2M3hgqqhM
         g6OzoyRaFN7QS/0bjOfkyVenBNIxL6a09jWFS2COA3LnJv8AT+NTFnx2JNj+jB+LwrRd
         siMW5wO11wBeqy8vo76lUwDL3aMFYrGd3HSuTBcje2sYpTcwhLj8drhrf0D0POyUKCom
         BAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741033672; x=1741638472;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5b60CN6bgvsucEwRWCH6wo9YbTIOsAqIH7mkhNo9S0Q=;
        b=tk+8BmGcjzBCjDvRii1FhTkRy5nIJzZP6DZMr015WCC98CrN+lo76iRCqudIIcM1V8
         hKi850FzyYRzCPjBDYQ5vnKGvUGjqo0AnSsE9rmUm+FOQKVeV0qvV2xrbv233kzn3/GW
         RHMQh+Y/+nfyb/eHfFh3r8MhSI/eX54iRxBAmnrlXYLuLoITRep36OSE3bNHtbKIirLs
         vL/xwBrDD3vUqlukn7UrdyYpmt/9ZvLxj/K8RRdh2exyJlc9G7y0gRfgeYhzSFKBS3Di
         p7IAyvJzMH4iczLqYb5Mr35wvOTquJcaAzlMiWy4VwOA0zegR+tJR3un0DFYggJUOWsK
         MqkA==
X-Forwarded-Encrypted: i=1; AJvYcCVU9ihqk8BAtCR0uq6fvaH81ng8UYxuc0C+SR5OITjSfqcm0bMKwesYHfdZKPWNMe+VfiHk0yDjnUyxGyDW@vger.kernel.org, AJvYcCVUned7Fy3fHntXdXwf8LnPSGchVxfBSAOB6zTvccOwOKSW6kLZaXjJuoeCEgQWvEOhIQxYOLTTxw4J@vger.kernel.org, AJvYcCVpLEpVtULO3fOYft5OX3UU5K0hcUcmel8yISMTmQR+tQ8Mo08tkPR/DES659dFqSE688r1wgeoH0GO@vger.kernel.org
X-Gm-Message-State: AOJu0YwcUbDMbJCpgiq9mtd+fNuJLblGXrBexvN2XVLvVQ9NlhsgEmGm
	LVdeBENQyOdjaHQq9t9oIb5HUX4e6uWj7h2NUOASt9XV6AnBIfsbz86CNw==
X-Gm-Gg: ASbGncvIaoRcXPftY3naV8h0mmA2mv0PBRf+5b3YwjSQW6qDBlhcQyfOieqDlom/Z50
	R8JUAaw9rvHHetHhhjhqi4AnoXyizHdEJ/AtTAC0XHcGnwufLZZklfW5JA+biQTB964Wvk8LBBO
	bBNPdARvEGpTVVICtqNDECd+rzLIa2cuM33gzrfOJKGJ2z2htjg15A4YDguFA1VtDzCdXq2jBky
	oyqy8I4tvUni9CGTKl6xiMSNc/T9szqR4LrNgnANWZ/nodw3TALzygdbA2l1DCjE7sn53AE3X49
	Zftd4SenYkNiciu6vitKl1GlUqg+udgCB36J7USa2sBsqo6f8Fky7Ys0VwQP0fEleJ30nuYnWzY
	DtedNq9DMcaFLZII=
X-Google-Smtp-Source: AGHT+IF77BedJBseCcnU1IQQMJBf/RtmIsVemRMwmoWoDaynloyfr0FemI6jF/O3BZRfQsaxHPJFsA==
X-Received: by 2002:a17:906:478b:b0:abf:5759:7aa9 with SMTP id a640c23a62f3a-abf57597d07mr1137099866b.7.1741033672158;
        Mon, 03 Mar 2025 12:27:52 -0800 (PST)
Received: from hex.my.domain (83.8.122.142.ipv4.supernova.orange.pl. [83.8.122.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf64dd565dsm389222166b.101.2025.03.03.12.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 12:27:51 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH v2 0/7] clk: bcm: kona: Add bus clock support, bus clocks
 for BCM21664/BCM281xx
Date: Mon, 03 Mar 2025 21:27:48 +0100
Message-Id: <20250303-kona-bus-clock-v2-0-a363c6a6b798@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMQQxmcC/13Myw6CMBCF4Vchs3ZMmSAVV76HYVHLABMuJa02G
 sK7W0ncuPxPcr4VAnvhAJdsBc9Rgrg5BR0ysL2ZO0ZpUgMpOinKCQc3G7w/A9rR2QELqjRza7g
 qFKTT4rmV1w7e6tS9hIfz792P+Xf9UeU/FXNUyGetq0ZrU7Z07SYj49G6Cept2z6gCxEnrAAAA
 A==
X-Change-ID: 20250212-kona-bus-clock-4297eefae940
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Alex Elder <elder@kernel.org>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Artur Weber <aweber.kernel@gmail.com>, Alex Elder <elder@riscstar.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741033670; l=2598;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=gMD9k1Qgdbybv2uBOP8stTocBsHxADMCNCVyb3oQlDk=;
 b=iddqj2tp02CUcqIe1ypdcz2ln1fnPo0OdRmkCTcLdVbLQVr65P2WusLP+sB093wH/9T4CLFdN
 xdg0hUi+SkWASH8zxVD1Aqutu4j/CPhtOtOzhK9Vjr2pZqORCH7ge++
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

This patchset does the following:

- Introduce support for bus clocks. These are fairly similar to
  peripheral clocks, but only implement policy, gate and hyst.

- Add matching bus clocks for BCM21664 and BCM281xx peripheral clocks
  and update device tree bindings to match.

The previous (RFC) version of this patchset also introduced a
prerequisite clock mechanism to enable bus clocks before their
corresponding peripheral clocks. It seems that this is unnecessary - 
the way these clocks are initialized leaves them enabled by default.
Thus, the prerequisite mechanism has been dropped from this version.

This is fine for now, and more accurate to hardware (bus clocks are
a prerequisite for the bus, not the peripheral clock). I had an idea
to connect bus clocks to buses using "simple-pm-bus" in DT, but
this is a task for another patchset.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v2:
- Drop prerequisite clock patch
- Move clock/bcm21664.h dt-bindings header change to dt-bindings patch
- Add BCM281xx bus clocks
- Link to v1: https://lore.kernel.org/r/20250216-kona-bus-clock-v1-0-e8779d77a6f2@gmail.com

---
Artur Weber (7):
      dt-bindings: clock: brcm,kona-ccu: Add BCM21664 bus clocks
      dt-bindings: clock: brcm,kona-ccu: Add BCM281xx bus clocks
      clk: bcm: kona: Add support for bus clocks
      clk: bcm21664: Add matching bus clocks for peripheral clocks
      clk: bcm281xx: Add corresponding bus clocks for peripheral clocks
      ARM: dts: bcm2166x-common: Add matching bus clocks for peripheral clocks
      ARM: dts: bcm11351: Add corresponding bus clocks for peripheral clocks

 .../devicetree/bindings/clock/brcm,kona-ccu.yaml   |  37 ++++++-
 arch/arm/boot/dts/broadcom/bcm11351.dtsi           |  33 ++++--
 arch/arm/boot/dts/broadcom/bcm2166x-common.dtsi    |  28 +++--
 drivers/clk/bcm/clk-bcm21664.c                     |  83 ++++++++++++++
 drivers/clk/bcm/clk-bcm281xx.c                     | 121 +++++++++++++++++++++
 drivers/clk/bcm/clk-kona-setup.c                   | 116 ++++++++++++++++++++
 drivers/clk/bcm/clk-kona.c                         |  62 ++++++++++-
 drivers/clk/bcm/clk-kona.h                         |  10 ++
 include/dt-bindings/clock/bcm21664.h               |  19 +++-
 include/dt-bindings/clock/bcm281xx.h               |  25 ++++-
 10 files changed, 505 insertions(+), 29 deletions(-)
---
base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
change-id: 20250212-kona-bus-clock-4297eefae940

Best regards,
-- 
Artur Weber <aweber.kernel@gmail.com>



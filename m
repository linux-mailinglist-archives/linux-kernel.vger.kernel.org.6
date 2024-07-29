Return-Path: <linux-kernel+bounces-265302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5721693EF4B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 10:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D72751F21DF2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4D5139568;
	Mon, 29 Jul 2024 08:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dS3EWcBl"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4820B136664
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 08:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722240077; cv=none; b=roEV2Jejk6Gv43k+USrUm/bZBUzEpjy+qH/fPkH08bM0MYxM7rGgiNDfcc/Y2S79fKWk4Zn59MbQ4iVuHqMILOsu79lPVrRP7ZzAR3rdSt6oDjAqwTJ6k7LX9f5ENgOQrivDxJc6yzga+MbCGh7mJ9wgi0H+LHLe3/RYBl7bF+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722240077; c=relaxed/simple;
	bh=3tXeGXM2RduzxnTIgBYHqy2rVhLERb9KPD1y545fYr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e3JWTrUOzHBoKue12EMHaY6HuKYtXmNU6V5bBtuPEaOg+Lnu20sluUiYL8q2Nb8yWjbqQkAilbHYUfQ/hFin+g7LKIB3JChVCtkTxsQ3T8GHyvn+YH/GzDPNLm6GOxg9IQTQD2aP0EOm2MNTQjQ8sszDZbCl+jHetCPFdchJlFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dS3EWcBl; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso14009855e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 01:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722240073; x=1722844873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jLO+jXA3M7oEf5JfEDBMAtggCBs7km6BzLtZrlx73qM=;
        b=dS3EWcBl/8K7gZ7xlumVHE3YfjluxafcMvRKkO2JlN0vTfT1WcvENLagwhfiQupV4+
         cuWCKxP3bM4uRnFC0+G7jh4RoW0NgQBQO6sd5zSsnFY+52Dtnj6ugM6OTn70Emg6cair
         BP/SSR5hoKHvoZvhgG+AQUr1Vu5A5Vb1ivBh8rFuhIvh2WJt0BzrmKTvzIbcSmlfSdxb
         M5yaq8Jx2qu9YS3/d6CQTh6WZeou1uDR6d0a5N+2Qsr9OjOYJZNVtLdTclgy0KrUrjYq
         YZgUpOkrAJ5p/ifUch+4QY1iiDxrCsrnpOHPaGmbwEb25ZNmCCqKTETeXuBqQSIOmCdR
         E12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722240073; x=1722844873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jLO+jXA3M7oEf5JfEDBMAtggCBs7km6BzLtZrlx73qM=;
        b=idJXsBbX/BlAS5yboUvpBX++Q0TIuZTMN8bbfDdJzTY6xeXTaEJvJW/zvIV5jOIAx/
         3v9p85KhdJW2bu9G7873cOi8/PCvzV6GfShPGg4z+BjVXsJk4i7mB6067hsnOI2bcogy
         f3ZJwhJ72cDq4P4XupxmZpww13gO9UY+NMSmMMbGoE/EoFWOoD/TrLgt5dhFYGLHccD2
         yK8g3cqWwaqjvGfbtz/u0jzVC1ABSOMfgNBxO+Zn7yCXAeTt3u04AUNuiPlO/E7OmfFl
         +g5mnUNaxHDdu8r2tTwTmfUOhTo4SHM8Z+luvyMAXhnCrW6nZwwof0H9V/IB8bDQPdP6
         W8gA==
X-Forwarded-Encrypted: i=1; AJvYcCXn8mmbEvxMp2Ffhj1j3rRRGAdU/org+oAgYfcdyTdW+VmNea7I5MVPDNLwl574IZhLUObmRi3mjXicsH/qqKdqYlVTCRHp5B++MvOA
X-Gm-Message-State: AOJu0YxFoYsR6Z+Lrw7PYz/3AZO4A9McJ2+cQeVgnJy+ViHjV9ooE5HL
	Xm+MMvsTFBFSXoTik9waj+5l7JP9dmYNQ/NaJL208xQr1E4oVz6hxj097ZbibJwKLq5utl7xxld
	h
X-Google-Smtp-Source: AGHT+IGwDbx71v3X0g5AThC0OfXjuZ5crp6ajq9RjiMpyHii0qoF+GSo7T4l/t/6SWct2QxntireeA==
X-Received: by 2002:a05:600c:4f0c:b0:426:629f:154e with SMTP id 5b1f17b1804b1-42811dd10d7mr38054595e9.30.1722240072500;
        Mon, 29 Jul 2024 01:01:12 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42819d9a007sm45452635e9.1.2024.07.29.01.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 01:01:12 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2 0/6] firmware: ti_sci: Partial-IO support
Date: Mon, 29 Jul 2024 10:00:55 +0200
Message-ID: <20240729080101.3859701-1-msp@baylibre.com>
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
In v2 I fixed the comments on the first version of this series and
rebased to v6.11-rc1. See below for a more detailed list.

I also dropped the omap serial series for Partial-IO as it can't be
tested with Partial-IO at the moment. The code was tested with other low
power modes but they will be upstreamed later on.

Series
------
Partial-IO is a poweroff SoC state with a few pingroups active for
wakeup. This state can be entered by sending a TI_SCI PREPARE_SLEEP
message.

The message is sent on poweroff if one of the potential wakeup sources
for this power state are wakeup enabled. A list of potential wakeup
sources for the specific SoC is described in the devicetree. The wakeup
sources can be individually enabled/disabled by the user in the running
system.

The series is based on v6.11-rc1.

Partial-IO
----------
This series is part of a bigger topic to support Partial-IO on am62,
am62a and am62p. Partial-IO is a poweroff state in which some pins are
able to wakeup the SoC. In detail MCU m_can and two serial port pins can
trigger the wakeup.
A documentation can also be found in section 6.2.4 in the TRM:
  https://www.ti.com/lit/pdf/spruiv7

This other series is relevant for the support of Partial-IO:

 - can: m_can: Add am62 wakeup support
   https://lore.kernel.org/lkml/20240729074135.3850634-1-msp@baylibre.com/
   https://gitlab.baylibre.com/msp8/linux/-/tree/topic/mcan-wakeup-source/v6.11?ref_type=heads

Testing
-------
A test branch is available here that includes all patches required to
test Partial-IO:

https://gitlab.baylibre.com/msp8/linux/-/tree/integration/am62-lp-sk-partialio/v6.11?ref_type=heads

After enabling Wake-on-LAN the system can be powered off and will enter
the Partial-IO state in which it can be woken up by activity on the
specific pins:
    ethtool -s can0 wol p
    ethtool -s can1 wol p
    poweroff

I tested these patches on am62-lp-sk.

Best,
Markus

Previous versions:
 v1: https://lore.kernel.org/lkml/20240523080225.1288617-1-msp@baylibre.com/

Changes in v2:
 - Rebase to v6.11-rc1
 - dt-binding:
    - Update commit message
    - Add more verbose description of the new binding for a better
      explanation.
 - ti_sci driver:
    - Combine ti_sci_do_send() into ti_sci_do_xfer and only wait on a
      response if a flag is set.
    - On failure to enter Partial-IO, do emergency_restart()
    - Add comments
    - Fix small things

Markus Schneider-Pargmann (5):
  dt-bindings: ti, sci: Add property for partial-io-wakeup-sources
  firmware: ti_sci: Partial-IO support
  arm64: dts: ti: k3-pinctrl: Add WKUP_EN flag
  arm64: dts: ti: k3-am62: Add partial-io wakeup sources
  arm64: dts: ti: k3-am62a: Add partial-io wakeup sources

Vibhore Vardhan (1):
  arm64: dts: ti: k3-am62p: Add partial-io wakeup sources

 .../bindings/arm/keystone/ti,sci.yaml         |  13 ++
 arch/arm64/boot/dts/ti/k3-am62.dtsi           |   4 +
 arch/arm64/boot/dts/ti/k3-am62a.dtsi          |   4 +
 arch/arm64/boot/dts/ti/k3-am62p.dtsi          |   4 +
 arch/arm64/boot/dts/ti/k3-pinctrl.h           |   3 +
 drivers/firmware/ti_sci.c                     | 160 +++++++++++++++---
 drivers/firmware/ti_sci.h                     |  34 ++++
 7 files changed, 203 insertions(+), 19 deletions(-)

-- 
2.45.2



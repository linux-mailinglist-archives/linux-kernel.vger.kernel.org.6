Return-Path: <linux-kernel+bounces-187138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E93808CCDAB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 259F71C20B46
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B6313CF92;
	Thu, 23 May 2024 08:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HEyrLJLZ"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A007B3C1
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 08:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451355; cv=none; b=GUJRjgDIugcWyQnUzwLJMbGkwNHHA1/fLoO4VglC6m01o6+LkYJCZDvojRUX8jfBtya47TkwzGw7JI1qCzkBt6o9HbcqiUULFZbBAldF+k6HKdXSSKM0lVN5V1tsSTqkJ+rGFfJm/nDPDkbuc7QGojZZd3oJeoAcPPfF21ZV6O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451355; c=relaxed/simple;
	bh=klatJAFWHBc0wuOs/nIGWmTjjd1VxcRv1nD6KbggBgE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VjNNlHTdU7mBxmqEA7h6CDXF6x1zWVXzSD/exbVGnWacaxdY4UFIb7bcmMaD1Vbyt3InhCPSa+d2pU/RcmuoQOLdYnwvXE6z9FgmVQf2+eSAvZ68vu3hzbHIUHCbZQkeoaaGyvrAxIv3Y5/TOFl4EwWrJ8xs3KT2oemkXWzq5m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HEyrLJLZ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-354dfe54738so1202393f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 01:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716451350; x=1717056150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0J2OeoCqQcca8A4XUgC5bySDFCw48o1TNPYwtFh2a2I=;
        b=HEyrLJLZjP56NB03ADK3PtQyNT3UX1lXGTttfs2BiEyLx/lkw+wYy2J785iBy4U7AL
         dr6yWbZ/hG/1xwLD1LnTwjExVHsID4t4nE+4NpJTdyhvi7LygDHfgVh6x9gBABRPjb5p
         3Dy2AbA/B6cJck0P9Lx5yUWe8PdaUVyNrab5/f2UmrRw+yJ2zyzIiWfp35pYoyReOBvD
         CVTr1be4aVGLmZ/YXkulZDm33Q5G4+7aR9dFW7GFnStLO9jWkDlRi0brIbnq0bQVxvwH
         NScQlq3CH4Ep1bJ3KZlQCcqRxUV4mVc6ZRB1IJldYDpeM1lFFmjm87Q8pAfQjm2pxswj
         fUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716451350; x=1717056150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0J2OeoCqQcca8A4XUgC5bySDFCw48o1TNPYwtFh2a2I=;
        b=IDG5H4773+92pu+VdgriilrSb4DEl7M4lR+39bNZSvxuRqy4SImxDpbNIrV5PSjhsZ
         b3MnoVm+9NNO5pJgpAxS8MPpQXtksrY+wORRLEgRtq5kgRN9Vlg7Z5av8JgRDSaxoOGW
         qzzfw5hWzmioPkr1ewI911h8FTvWtA3F00bMrN2JH3949+bNNcSzylWA8Lak+ehRxa1Z
         OGRj2WHEbESf6r1mo0GwacSsplx+XMCbUi9hYxMnk5+4Yivd4aEZQQJ1XgYNEixbb66y
         1qeNajyeaiTEBUivNVwT9s40z6DCFg0Qw/jX2PfpWGtw0zcl0DRcs+GInNsujMPRZAkW
         pezA==
X-Forwarded-Encrypted: i=1; AJvYcCWmqXsuzfE9VWzH3/c9UAA9MH+lkn3UnK/i6nVcHej7ltJLw9VjgmOhv8aAzJjt1yACUEHpcz3ilZRY9lcVbq0KfbpePmXMOPgy/Mzx
X-Gm-Message-State: AOJu0YyNatOkLfQpD062SaWECquwE121jqh6P+FIOnW8Hc5GowsI3CHM
	G/C5cskQLBtLRruPSdlvsXRkMog2NaJSgYNF3Yg5cY57WEH1mY0YpdSkhfmwo8E=
X-Google-Smtp-Source: AGHT+IFs4zKu4mkfSwJ00cEuqunFI4d5En43MpOl7AHLMm7sgx8p/3MO55WY1Bh9L819Lj+C7uR7JQ==
X-Received: by 2002:adf:cd06:0:b0:354:f2b8:c75e with SMTP id ffacd0b85a97d-354f2b8c8b4mr2348864f8f.33.1716451349471;
        Thu, 23 May 2024 01:02:29 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35501abfdddsm93637f8f.110.2024.05.23.01.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 01:02:28 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 0/6] firmware: ti_sci: Partial-IO support
Date: Thu, 23 May 2024 10:02:19 +0200
Message-ID: <20240523080225.1288617-1-msp@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Partial-IO is a poweroff SoC state with a few pingroups active for
wakeup. This state can be entered by sending a TI_SCI PREPARE_SLEEP
message.

The message is sent on poweroff if one of the potential wakeup sources
for this power state are wakeup enabled. A list of potential wakeup
sources for the specific SoC is described in the devicetree. The wakeup
sources can be individually enabled/disabled by the user in the running
system.

The series is based on Andrew Davis accepted patches:
  [PATCH 0/4] Unconditionally register TI-SCI reset handler
  https://lore.kernel.org/lkml/20240326223730.54639-1-afd@ti.com/

This series is part of a bigger topic to support Partial-IO on am62,
am62a and am62p. Partial-IO is a poweroff state in which some pins are
able to wakeup the SoC. In detail MCU m_can and two serial port pins can
trigger the wakeup.

These two other series are relevant for the support of Partial-IO:

 - serial: 8250: omap: Add am62 wakeup support
 - can: m_can: Add am62 wakeup support

A test branch is available here that includes all patches required to test
Partial-IO:

https://gitlab.baylibre.com/msp8/linux/-/tree/integration/am62-lp-sk-partialio/v6.9?ref_type=heads

After enabling Wake-on-LAN the system can be powered off and will enter
the Partial-IO state in which it can be woken up by activity on the
specific pins:
    ethtool -s can0 wol p
    ethtool -s can1 wol p
    poweroff

I tested these patches on am62-lp-sk.

Best,
Markus

Markus Schneider-Pargmann (5):
  dt-bindings: ti, sci: Add property for partial-io-wakeup-sources
  firmware: ti_sci: Partial-IO support
  arm64: dts: ti: k3-pinctrl: Add WKUP_EN flag
  arm64: dts: ti: k3-am62: Add partial-io wakeup sources
  arm64: dts: ti: k3-am62a: Add partial-io wakeup sources

Vibhore Vardhan (1):
  arm64: dts: ti: k3-am62p: Add partial-io wakeup sources

 .../bindings/arm/keystone/ti,sci.yaml         |   6 +
 arch/arm64/boot/dts/ti/k3-am62.dtsi           |   4 +
 arch/arm64/boot/dts/ti/k3-am62a.dtsi          |   4 +
 arch/arm64/boot/dts/ti/k3-am62p.dtsi          |   4 +
 arch/arm64/boot/dts/ti/k3-pinctrl.h           |   3 +
 drivers/firmware/ti_sci.c                     | 135 +++++++++++++++++-
 drivers/firmware/ti_sci.h                     |  31 ++++
 7 files changed, 186 insertions(+), 1 deletion(-)

-- 
2.43.0



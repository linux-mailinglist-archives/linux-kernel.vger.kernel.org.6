Return-Path: <linux-kernel+bounces-565698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BCCA66DA4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EB517A8C3C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7076D1F098E;
	Tue, 18 Mar 2025 08:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3htr9j5"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BB87346F;
	Tue, 18 Mar 2025 08:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742285610; cv=none; b=sM8+l1gzL7yLPpYGcUCtbyR7NErk4Cn/9Ern14ifj28MnF9GL/f3dOHV6fZDvyUVJgx3VokisO29dJ15qr0ULRfrvmggqxfwmuRTvVPxHXrjzJNDJCbwtESWeRlouQNrhG4ooAyPZwjJ+YcAGjfDLI7Zite2PXMeAfdTN0Ahv5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742285610; c=relaxed/simple;
	bh=aajoegoit8PL4vVvM3SGOqwnfEpfNH1he8t+kymMm8A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fGnaEyEujx/QIRCDW/Wq+ZxbimgHUEGqbiTrAvzRMhMbx3faB3RGApbGoGkc/Us5rPhLtsyG5x8dxsy/RR3FcEmSmdMtNQk0+eWUh+SAX2Y4Kc5KC2a9MNe7qbLUv9xwdJstXMfLa9hgnABrLoFO5nOPCmCivD02UdXaIRdCyJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3htr9j5; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e4d50ed90aso6606256a12.0;
        Tue, 18 Mar 2025 01:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742285607; x=1742890407; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gayR76VJdCCYdfu9Kfs488CPWw+nzLOWNMyxlt1pA/M=;
        b=j3htr9j5mkLKeaJy94LGLU4vfQBsjf9B/LARf4BKL7OzUcVS85aQFKCpRQsHTl7uO+
         52W3rj3UpEamJNa9NUZyNOhKeAXvXvWwA0XCsPhNfLmQkArqubCuqAttnaeiR/BfsDlK
         QNGU0ZTuL8KWVbXxrGjEyZecTEUmZQUFxGYg/uO0zUBoGxFtynD9x38f97JtQXCF3XCc
         O5RUcfEUYo5mjmWa0Ba1ZZIk2Am3jJjP1SxZEeZDBQypad8kLoBDtPgxRtdYVkSR9f0F
         8vZp3eClorGCVYs9cxghbxxbK2AmoQvIgHkS+yHYPwD5onHWZ+ov6PhjWPDGMhC1EXmt
         q7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742285607; x=1742890407;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gayR76VJdCCYdfu9Kfs488CPWw+nzLOWNMyxlt1pA/M=;
        b=LbgXvEN2gU5h99Y/17Yc9w++HhM3nmu8kPi3NvwRnvpSEtG8m3umnAXuf6KE8wusOL
         EPTrL94M0dF1BKcBF2PWDeFg83dfvFAzH5Ab5yb9x5RjEV+b2NqSFYrCN67o8gTHM4W4
         qAoQlfEkK3RT9qRexT90QD+0qXvCO7PcOlWSZ1rqFUneKDDKo2PYUBRMwBXkhdsctd6y
         FRsVQw1SxuChcjg59XYq4M9Leow1Zo90vBDPQzhJrjVSOHDzEtqmR7iQsMQ7piUN+QTN
         VQv1GJJEOdBOHcsO88eF8CnfAbayv+2oV1sr4Qh3uZjFdkxs91vuiWhnzglY2WWAQeEo
         JbfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMXHBfg1ueVFuuAGaNcvAbgiUC8P8BdneYG/lJz3pf3JbN5cfbRaWNGEIEvuVGvhLHMiQ5VItFYupv@vger.kernel.org, AJvYcCUtbgud0ny3YqAE/88hocdgredmZahPgZKIQK0JSSqREK6/GROcmCv7WtnkPWv8Fzjabvmv0iRUty7mFeK6@vger.kernel.org, AJvYcCWqO904mjRCI+tKd3ZhLI1BxHgXh0w8sdb0WEU0iKIfN8NL27WZsbp+dIq0LjEwmM6QXF6Ad1ahKzI9@vger.kernel.org
X-Gm-Message-State: AOJu0YxtVfVN35P4oR8CByhbgqTT0exxNdfenGNe0RSC+S7yk/kEB8Gk
	cOfNMbz1hCMzfATAVHHyeOY+ZLGOOy1Z+iiuQ8gEgK14TwSA5AkD
X-Gm-Gg: ASbGncuYmUcmlpEm47nmco7Jguee8KX9GkkTrjg8vk98fBzGhLMRTh5/0AzyOqgUQBf
	uCUZYzr0VERC1IOzK+fn1ZWhlzhfyS61i5QHoYzLhfqvIfIgbfI7wcWgApR+NWq2ulcKdlTg3Oo
	9QLbs5S2/8MOKIrJhNzuEj6nVaawYcMxqEBkXTEyV/xH/YSCMzDZK58XJMhvxNhKpNF2Un3gJp4
	DDFTntlvGY2RnauEhb97P3vSlNrMaEC23dzlqM/dXt021nrH7VlvyC/VAgjQOEj4FLx8J5S11ZS
	8w9gnpmtoCViAb8PHGL1/y8HHi35lc3GMLrc++AHnfFDPoprJGojYK769WXdVpqqEU++dOAhrwO
	4k2F3wag5cXoTv8vWLw==
X-Google-Smtp-Source: AGHT+IGZNghdIvvfNPad1dUTIavAgEQMmUsZrXC1R2Y6151Bxj6MjHyzUkSaTvSZ/hjN6czF+5cnEQ==
X-Received: by 2002:a05:6402:2793:b0:5e6:1996:7902 with SMTP id 4fb4d7f45d1cf-5e8a0c0d26fmr15798502a12.32.1742285606660;
        Tue, 18 Mar 2025 01:13:26 -0700 (PDT)
Received: from hex.my.domain (83.11.178.210.ipv4.supernova.orange.pl. [83.11.178.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816ad392csm7176097a12.53.2025.03.18.01.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 01:13:26 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH v4 0/8] clk: bcm: kona: Add bus clock support, bus clocks
 for BCM21664/BCM281xx
Date: Tue, 18 Mar 2025 09:13:22 +0100
Message-Id: <20250318-kona-bus-clock-v4-0-f54416e8328f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACMr2WcC/2XM3w6CIByG4VtxHEdDUNCOuo/WAeAPZf6hQbma8
 95Dt5bTw+/bnndCAbyFgC7JhDyMNlg3xJGdEqQbOdSAbRU3ooTmhKYUt26QWL0C1p3TLc5oKQC
 MhDIjKKKHB2Pfa/B2j7ux4en8Z+2P6fL+UnyfGlNMMBRClJUQkht6rXtpu7N2PVpSI/1zRtiB0
 8gl40xzyZUoiz1nW14cOIu84kblymimuNjyeZ6/JU1YsyoBAAA=
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
 Artur Weber <aweber.kernel@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Alex Elder <elder@riscstar.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742285605; l=3249;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=aajoegoit8PL4vVvM3SGOqwnfEpfNH1he8t+kymMm8A=;
 b=upZRPO1r+L6LqBEs74Pm7IrNBBTJBYge/Z7AyE0kSR80o4KN7ZIggNjhlpbgRwRhjTMDtVinV
 nS30AAJ2vtVA3oQ6MYnvO983FlZhq4ZTMZUigTyWu7sr7tkXjBNxs2S
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
Changes in v4:
- Rename moved CLOCK_COUNT defines to CLK_COUNT to avoid redefinition
- Squash BCM21664/BCM281xx bus clock DT bindings commits together
- Link to v3: https://lore.kernel.org/r/20250308-kona-bus-clock-v3-0-d6fb5bfc3b67@gmail.com

Changes in v3:
- Fix DT schema example in BCM281xx bus clock bindings
- Move CLOCK_COUNT defines from dt-bindings header to the driver
- Fix BCM21664 UARTBx_APB IDs being out of order compared to clock
  driver
- Link to v2: https://lore.kernel.org/r/20250303-kona-bus-clock-v2-0-a363c6a6b798@gmail.com

Changes in v2:
- Drop prerequisite clock patch
- Move clock/bcm21664.h dt-bindings header change to dt-bindings patch
- Add BCM281xx bus clocks
- Link to v1: https://lore.kernel.org/r/20250216-kona-bus-clock-v1-0-e8779d77a6f2@gmail.com

---
Artur Weber (8):
      clk: bcm: kona: Move CLOCK_COUNT defines into the driver
      dt-bindings: clock: brcm,kona-ccu: Drop CLOCK_COUNT defines from DT headers
      dt-bindings: clock: brcm,kona-ccu: Add BCM21664 and BCM281xx bus clocks
      clk: bcm: kona: Add support for bus clocks
      clk: bcm21664: Add corresponding bus clocks for peripheral clocks
      clk: bcm281xx: Add corresponding bus clocks for peripheral clocks
      ARM: dts: bcm2166x-common: Add matching bus clocks for peripheral clocks
      ARM: dts: bcm11351: Add corresponding bus clocks for peripheral clocks

 .../devicetree/bindings/clock/brcm,kona-ccu.yaml   |  49 ++++++-
 arch/arm/boot/dts/broadcom/bcm11351.dtsi           |  33 +++--
 arch/arm/boot/dts/broadcom/bcm2166x-common.dtsi    |  28 ++--
 drivers/clk/bcm/clk-bcm21664.c                     |  99 ++++++++++++++-
 drivers/clk/bcm/clk-bcm281xx.c                     | 141 ++++++++++++++++++++-
 drivers/clk/bcm/clk-kona-setup.c                   | 116 +++++++++++++++++
 drivers/clk/bcm/clk-kona.c                         |  62 ++++++++-
 drivers/clk/bcm/clk-kona.h                         |  12 +-
 include/dt-bindings/clock/bcm21664.h               |  17 ++-
 include/dt-bindings/clock/bcm281xx.h               |  24 +++-
 10 files changed, 538 insertions(+), 43 deletions(-)
---
base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
change-id: 20250212-kona-bus-clock-4297eefae940

Best regards,
-- 
Artur Weber <aweber.kernel@gmail.com>



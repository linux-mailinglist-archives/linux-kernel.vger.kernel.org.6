Return-Path: <linux-kernel+bounces-552354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B478A578F3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 08:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B13FB18973A7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 07:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4C419CC0A;
	Sat,  8 Mar 2025 07:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtCDDGYu"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86FD8462;
	Sat,  8 Mar 2025 07:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741420247; cv=none; b=kON34yULHp/aUhej2D8MRivwGhV48+j6cawrEix8Ln6/SM+ZXuq5yhUKEKy0OGntSPC+AFWXpdfOize8QiWa5QNd+d6CwYkNdkANdLWx3QeNyg6N8ZBxNOu/U9QdZpHK1X3RT2PDEOa1T4JGNZwqRhul2/wX6ZDz3qo8WxRT2pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741420247; c=relaxed/simple;
	bh=1zP1a5dMyb4DAaMCOQd4d2onxFIE66DEJCP0uRZ4hy8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VCkdJw7ahF5ZciDvY+aAdgYg1mjINeLTq/bqf6JpYosOrytKVjYIOK6hidj6Dv6yEQOWMbdfttSEUmOiu2zrpOrufTPwx7QmSrzLujSDNKpB05hwEPYB2AuIaKwE821TuX9lQ5KrbKnQah4fdYtTwFDAwkMSmy3wI6OluKVQ3CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtCDDGYu; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac0b6e8d96cso365042466b.0;
        Fri, 07 Mar 2025 23:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741420244; x=1742025044; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Gm63QmkgaeWQbiVP834QkzwimUfZ5vt/9bD8i+JVic=;
        b=NtCDDGYuMlwRX8OrkV/mL+TNmciTAjcx1oRaKJd1C4UnUkvBLbTO8NTuxH10Nf+VMu
         0WrWv2G+o7tfhsIvvbnBXIhvkve6iM0ABX8Gmidq8U/bIh7sSa2HuFAqQvKy8aFulOe5
         aNvv+IHM+4EwnNX+WsEydmSQziOe/NhxhxtOzBpSOeGe9hT6dV9SlQ1/J3oH+EcWO19E
         7oWF60iMRoF1vj7dLthk5ITsNxo5+/l18KYtoXvZJ8x5JB+NqSaS2OQbq1aSEYA468+K
         c9ElFi3zrJmVD/Bc6lPDP9oZcFZN25PV+54EJ0dCB5HPoORYbfvotUTSTkTu4LPVrzN5
         UWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741420244; x=1742025044;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Gm63QmkgaeWQbiVP834QkzwimUfZ5vt/9bD8i+JVic=;
        b=plz6PS+RKqoXcJ4jLDu9BJNmrJXiX3J2S+eEDfFG/EqI8aS/50ednya7Ho5VSMCuNJ
         sXCiFFQsb7Jd/LozsVagGFuBM697HEgyJ4BE7oCnTIzGK/Q7RUHnFIm1CDDL7bqvJM9t
         0sKi3x9ltBY9Q7OjKp0OdYuwE1ieVeGPIHZtFYpFFR9NbCIQSxHiQQl4f2gkWMgyJNEv
         guQWmwRAh250JbE8+rT2k1Qs8NgGMHjDkjqKGtkfD1zCVzwJONxM9H6RNNuMwATdz48v
         HTtbQDCii1EowFr8X+xOtxZtzi/FNbCHgao2y2iMvgwbpZ0glIJ/rzTQhbbCEEDNrdgD
         o9wA==
X-Forwarded-Encrypted: i=1; AJvYcCU0ULEFH+JbYG3fthBchqPm0OVhrJgrRkHTpfBdVQK2iIR02B35skLmD2JbvFuSZftNf1+KNeHp6bT/MvpJ@vger.kernel.org, AJvYcCUU58194N3OyHy6GcDV+Sti9KowfM7ubqiWREyItR82HA0vhNvD+CduIEV0OWG9hLaXkrhAUFrPeXBi@vger.kernel.org, AJvYcCWntTjNqmTg2yrTik1nvUw04H1QnWgOEO6WVlFLD++jYpAN9Qu2AHp9xqHCQocxyhKwuSGmQbRKBKS1@vger.kernel.org
X-Gm-Message-State: AOJu0YzLpSCXoHAK/QiAlrlA2uSvFSfXZMbJB47tvLVIBFAQvWXBMKwF
	ps9xs5LBiQHZJaTZQs56lYmxOvh91vUlCFqjvLTWYaxPaFkCZu3e
X-Gm-Gg: ASbGncsjG315Kp0yiXF7eQILulYJlSe4QXjNqYQrxycCwb3WXG9Ejm2N05b++esxuEc
	Vn64Dvsa9BTovpFO78I6MuszHtnYqlE4/2iaTXnB9OwD4OVoCddO80t/Tw1l5utc4hMU845PalG
	FWLd5WPuAgURMto1o0BZcIRJAoW3+RtfC0wyB/8Yi96tmYoZ6MzPWQqFL0SoE+n21cIuZhhUMeo
	YWQI25FEEBUkEPRz/8H0WTyDwXaACSrCQCZ2L3ZASc7wFbX7jPP9OOSqXfzqUEFrQ7eeWVpLQEp
	A8/ymMCuIyiUJIoDSTMteTTKpxXZYMienwgvor1t83vlkX3IjdDsT2s/7d8L37DFMyZTPpxWQYx
	egTkF1crP+ajDrdx80Q==
X-Google-Smtp-Source: AGHT+IFwuEnguVcsU4XeJmM0ayQyaOroGWPWft/RM6QnhSkJYKlbzfHJDVDEv/kkNTyLVPE1H5JmRw==
X-Received: by 2002:a17:906:c516:b0:ac2:806e:bb5b with SMTP id a640c23a62f3a-ac2806ebd72mr5592066b.21.1741420243698;
        Fri, 07 Mar 2025 23:50:43 -0800 (PST)
Received: from hex.my.domain (83.11.221.132.ipv4.supernova.orange.pl. [83.11.221.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac25d376342sm213104766b.106.2025.03.07.23.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 23:50:42 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH v3 0/9] clk: bcm: kona: Add bus clock support, bus clocks
 for BCM21664/BCM281xx
Date: Sat, 08 Mar 2025 08:50:38 +0100
Message-Id: <20250308-kona-bus-clock-v3-0-d6fb5bfc3b67@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM72y2cC/2XMSw7CIBSF4a00jMXQS4XiyH0YB5TetqQPDCjRN
 N27tInR6PCc5P9mEtBbDOSYzcRjtMG6KQ2+y4jp9NQitXXaBBgcGORAezdpWt0DNYMzPS1AScR
 GoyoYSdHVY2MfG3i+pN3ZcHP+ufkxX983JX6pmFNGsZRS1VJq0cCpHbUd9saNZKUifHLO+F8OK
 ddccCO0qKQqv/NlWV6COFB/6wAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741420241; l=3052;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=1zP1a5dMyb4DAaMCOQd4d2onxFIE66DEJCP0uRZ4hy8=;
 b=MMr5YVGCded9/KOyn3VFmrWwZFK9ceIaAv68U0OQxxeSWhaE3wqIQdZKwX4cMWYjsikK1sXol
 zbEh9T5xExvA9ISLwQM3PJPnxd4f4xxd51K/DCJSV1MGRhMqE4sDN4F
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
Artur Weber (9):
      clk: bcm: kona: Move CLOCK_COUNT defines into the driver
      dt-bindings: clock: brcm,kona-ccu: Drop CLOCK_COUNT defines from DT headers
      dt-bindings: clock: brcm,kona-ccu: Add BCM21664 bus clocks
      dt-bindings: clock: brcm,kona-ccu: Add BCM281xx bus clocks
      clk: bcm: kona: Add support for bus clocks
      clk: bcm21664: Add matching bus clocks for peripheral clocks
      clk: bcm281xx: Add corresponding bus clocks for peripheral clocks
      ARM: dts: bcm2166x-common: Add matching bus clocks for peripheral clocks
      ARM: dts: bcm11351: Add corresponding bus clocks for peripheral clocks

 .../devicetree/bindings/clock/brcm,kona-ccu.yaml   |  49 +++++++-
 arch/arm/boot/dts/broadcom/bcm11351.dtsi           |  33 ++++--
 arch/arm/boot/dts/broadcom/bcm2166x-common.dtsi    |  28 +++--
 drivers/clk/bcm/clk-bcm21664.c                     |  91 ++++++++++++++
 drivers/clk/bcm/clk-bcm281xx.c                     | 131 +++++++++++++++++++++
 drivers/clk/bcm/clk-kona-setup.c                   | 116 ++++++++++++++++++
 drivers/clk/bcm/clk-kona.c                         |  62 +++++++++-
 drivers/clk/bcm/clk-kona.h                         |  10 ++
 include/dt-bindings/clock/bcm21664.h               |  17 ++-
 include/dt-bindings/clock/bcm281xx.h               |  24 +++-
 10 files changed, 528 insertions(+), 33 deletions(-)
---
base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
change-id: 20250212-kona-bus-clock-4297eefae940

Best regards,
-- 
Artur Weber <aweber.kernel@gmail.com>



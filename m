Return-Path: <linux-kernel+bounces-332727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA8097BDE5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 16:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3F3B1C20E5A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 14:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B6D1097B;
	Wed, 18 Sep 2024 14:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MTn0OUmP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8DAF9EC
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 14:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726669171; cv=none; b=Lef3FgWjAbuPDWxi8G3pDnlMiDpiNtB3fdxYgHk5wOtzNY1gTUzfl+z717+b3Yzoj5cUODJ+JN2/z/VonY+Pq9kX8y1ej/kVGQslDKIViVlNNroiMi4qDg+EQn/az/Gf7QNNnVzfXw/2/DB/RLGL/yy/o7Ek1hk4ieD+rzoYJ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726669171; c=relaxed/simple;
	bh=4+Q0NLR6KUFUVYrH9tj6s9IYZIukp5T/3aT23fSprsY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=fj1uz6fjauOqq7bMFmdc9+sg/nTY+kxLFkUWsGp1iAT17Y9RMOUX2//3Mw4Z8fF7JLAunV7dres/DsoF9D2LhyKeb3fgGllRUZJ30l5AzZFyCSPfgunZLKF6C2F0pAxh7eySrsC6TmRmrrRRSePyLwLiz0D3UL6wTPbE7oU1aSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MTn0OUmP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726669167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5EkK+onpyCPkCVDPxb5B3x1MBina0Kg33y1ydZDSRzQ=;
	b=MTn0OUmPG2VNjkiyTAN4VoWX+tyfgTlgYKWwzxsyx0sxaJYOKtHtSoAy+hBbMhOAiMcz1a
	D85oLlFUHugQgWzgQPcH2tyYjMcneevE0cBKwK5Y6o9Vadyf6ThH6JXDKmCryim9v4zhhy
	20DBbx83F8Kvd8lUqFQnDXrfH3mqYFg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-ZwdPU-poOe2FrAN_3eFGmw-1; Wed, 18 Sep 2024 10:19:25 -0400
X-MC-Unique: ZwdPU-poOe2FrAN_3eFGmw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a8a8e19833cso582915966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 07:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726669165; x=1727273965;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5EkK+onpyCPkCVDPxb5B3x1MBina0Kg33y1ydZDSRzQ=;
        b=cFHPZ18eL5Zwi0VTKvos1ndmVGkMf8vuczopLNFDh8gPweWjoguMMQ1w/4TO+fTJzD
         y4d4zRudWgYRJLvBt+Qx+1ALWIM2Go/T7luolH7qtgH97pM5EyNJ1rQh0kLGZ71mITE+
         Cccb9BeOYqVR6TX0aFlcbPfFnf7LuMBgiYm7flWNRlrH+AhpceImLBJKlrDtfJYM2q1j
         JDZlp2LDrNSCGJ9hiFlIZaUaHiLe1KIz4wVcr6wLuyNCtRwEI6DsLo+jUzAXcWAqpQav
         RCwU4NtbA+Th8wOkJ6JL4tD9jY0dAVqW+v5z9APAvBscJ72fdCkA9Ju7s6D+KBGSKeW/
         eDSw==
X-Forwarded-Encrypted: i=1; AJvYcCVcIxvne0HUWRh4FCltcLmy5ZjcTWawgWZJRXew5d8cy1jrxE7mBZxkFWfs3yHUVk9FZSwHJe2QqCXvZTI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5e6FUtux0/ZjBscreXKVYMyxHG7p+cBe8sK+ShpVd+Px2Tho1
	yT7iDu59VlolQngs7K4tSRbMK9dIRINrA+8g7xZOedK119agaXauAvUUFlU9e1n3ITHuGlEU8/k
	Tf5mL+Y4fns5x+ZrM2Dgfgd4opGYh5VSjIiR9P+FoW6iouUzXjm0WZO1Ziw/2Og==
X-Received: by 2002:a17:906:fe47:b0:a8a:9195:922d with SMTP id a640c23a62f3a-a90290f9c99mr2353849466b.0.1726669164338;
        Wed, 18 Sep 2024 07:19:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4kSdlebpcWpPb1pmDGU7SPq7pLLXcMzQAjwWMbdbIwNm/tt6IeQwPs/0HqbE5FNLm1GrIhg==
X-Received: by 2002:a17:906:fe47:b0:a8a:9195:922d with SMTP id a640c23a62f3a-a90290f9c99mr2353845266b.0.1726669163601;
        Wed, 18 Sep 2024 07:19:23 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612b3a04sm596255966b.125.2024.09.18.07.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 07:19:23 -0700 (PDT)
Message-ID: <dede57b5-3ef2-4451-a496-537f3c05a1d6@redhat.com>
Date: Wed, 18 Sep 2024 16:19:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 6.12-1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Shevchenko <andy@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here is the main PDx86 PR for 6.12.

Highlights:
 -  asus-wmi: Add support for vivobook fan profiles
 -  dell-laptop: Add knobs to change battery charge settings
 -  lg-laptop: Add operation region support
 -  intel-uncore-freq: Add support for efficiency latency control
 -  intel/ifs: Add SBAF test support
 -  intel/pmc: Ignore all LTRs during suspend
 -  platform/surface: Support for arm64 based Surface devices
 -  wmi: Pass event data directly to legacy notify handlers
 -  x86/platform/geode: switch GPIO buttons and LEDs to software properties
 -  bunch of small cleanups, fixes, hw-id additions, etc.

Regards,

Hans


The following changes since commit a54da9df75cd1b4b5028f6c60f9a211532680585:

  hwmon: (hp-wmi-sensors) Check if WMI event data exists (2024-09-02 07:23:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.12-1

for you to fetch changes up to 837acb691c844d0525f4ac86f2a2ce55a9706908:

  MAINTAINERS: adjust file entry in INTEL MID PLATFORM (2024-09-17 12:41:34 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v6.12-1

Highlights:
 -  asus-wmi: Add support for vivobook fan profiles
 -  dell-laptop: Add knobs to change battery charge settings
 -  lg-laptop: Add operation region support
 -  intel-uncore-freq: Add support for efficiency latency control
 -  intel/ifs: Add SBAF test support
 -  intel/pmc: Ignore all LTRs during suspend
 -  platform/surface: Support for arm64 based Surface devices
 -  wmi: Pass event data directly to legacy notify handlers
 -  x86/platform/geode: switch GPIO buttons and LEDs to software properties
 -  bunch of small cleanups, fixes, hw-id additions, etc.

The following is an automated git shortlog grouped by driver:

Documentation:
 -  admin-guide: pm: Add efficiency vs. latency tradeoff to uncore documentation

ISST:
 -  Simplify isst_misc_reg() and isst_misc_unreg()

MAINTAINERS:
 -  adjust file entry in INTEL MID PLATFORM
 -  Add Intel MID section

Merge tag 'hwmon-for-v6.11-rc7' into review-hans:
 - Merge tag 'hwmon-for-v6.11-rc7' into review-hans

Merge tag 'platform-drivers-x86-v6.11-3' into review-hans:
 - Merge tag 'platform-drivers-x86-v6.11-3' into review-hans

acer-wmi:
 -  Use backlight power constants

asus-laptop:
 -  Use backlight power constants

asus-nb-wmi:
 -  Use backlight power constants

asus-wmi:
 -  don't fail if platform_profile already registered
 -  add debug print in more key places
 -  Use backlight power constants
 -  add support for vivobook fan profiles

dell-laptop:
 -  remove duplicate code w/ battery function
 -  Add knobs to change battery charge settings

dt-bindings:
 -  platform: Add Surface System Aggregator Module
 -  serial: Allow embedded-controller as child node

eeepc-laptop:
 -  Use backlight power constants

eeepc-wmi:
 -  Use backlight power constants

fujitsu-laptop:
 -  Use backlight power constants

hid-asus:
 -  use hid for brightness control on keyboard

ideapad-laptop:
 -  Make the scope_guard() clear of its scope
 -  move ACPI helpers from header to source file
 -  Use backlight power constants

int3472:
 -  Use str_high_low()
 -  Use GPIO_LOOKUP() macro
 -  make common part a separate module

intel-hid:
 -  Use string_choices API instead of ternary operator

intel/pmc:
 -  Ignore all LTRs during suspend
 -  Remove unused param idx from pmc_for_each_mode()

intel_scu_ipc:
 -  Move intel_scu_ipc.h out of arch/x86/include/asm

intel_scu_wdt:
 -  Move intel_scu_wdt.h to x86 subfolder

lenovo-ymc:
 -  Ignore the 0x0 state

lg-laptop:
 -  Add operation region support

oaktrail:
 -  Use backlight power constants

panasonic-laptop:
 -  Add support for programmable buttons

platform/mellanox:
 -  mlxbf-pmc: fix lockdep warning

platform/olpc:
 -  Remove redundant null pointer checks in olpc_ec_setup_debugfs()

platform/surface:
 -  Add OF support

platform/x86/amd:
 -  pmf: Add quirk for TUF Gaming A14

platform/x86/amd/pmf:
 -  Update SMU metrics table for 1AH family series
 -  Relocate CPU ID macros to the PMF header
 -  Add support for notifying Smart PC Solution updates

platform/x86/intel-uncore-freq:
 -  Add efficiency latency control to sysfs interface
 -  Add support for efficiency latency control
 -  Do not present separate package-die domain

platform/x86/intel/ifs:
 -  Fix SBAF title underline length
 -  Add SBAF test support
 -  Add SBAF test image loading support
 -  Refactor MSR usage in IFS test code

platform/x86/intel/pmc:
 -  Show live substate requirements

platform/x86/intel/pmt:
 -  Use PMT callbacks

platform/x86/intel/vsec:
 -  Add PMT read callbacks

platform/x86/intel/vsec.h:
 -  Move to include/linux

samsung-laptop:
 -  Use backlight power constants

serial-multi-instantiate:
 -  Don't require both I2C and SPI

thinkpad_acpi:
 -  Fix uninitialized symbol 's' warning
 -  Add Thinkpad Edge E531 fan support

touchscreen_dmi:
 -  add nanote-next quirk

trace:
 -  platform/x86/intel/ifs: Add SBAF trace support

wmi:
 -  Call both legacy and WMI driver notify handlers
 -  Merge get_event_data() with wmi_get_notify_data()
 -  Remove wmi_get_event_data()
 -  Pass event data directly to legacy notify handlers

x86-android-tablets:
 -  Adjust Xiaomi Pad 2 bottom bezel touch buttons LED
 -  Fix spelling in the comments

x86/platform/geode:
 -  switch GPIO buttons and LEDs to software properties

----------------------------------------------------------------
Andres Salomon (2):
      platform/x86:dell-laptop: Add knobs to change battery charge settings
      platform/x86:dell-laptop: remove duplicate code w/ battery function

Andy Shevchenko (7):
      platform/x86: intel-hid: Use string_choices API instead of ternary operator
      platform/x86: int3472: Use GPIO_LOOKUP() macro
      platform/x86: int3472: Use str_high_low()
      platform/x86: ideapad-laptop: Make the scope_guard() clear of its scope
      platform/x86: x86-android-tablets: Fix spelling in the comments
      MAINTAINERS: Add Intel MID section
      platform/x86: intel_scu_wdt: Move intel_scu_wdt.h to x86 subfolder

Armin Wolf (5):
      platform/x86: lg-laptop: Add operation region support
      platform/x86: wmi: Pass event data directly to legacy notify handlers
      platform/x86: wmi: Remove wmi_get_event_data()
      platform/x86: wmi: Merge get_event_data() with wmi_get_notify_data()
      platform/x86: wmi: Call both legacy and WMI driver notify handlers

Arnd Bergmann (1):
      platform/x86: int3472: make common part a separate module

Ckath (1):
      platform/x86: touchscreen_dmi: add nanote-next quirk

David E. Box (3):
      platform/x86/intel/vsec.h: Move to include/linux
      platform/x86/intel/vsec: Add PMT read callbacks
      platform/x86/intel/pmt: Use PMT callbacks

Dmitry Torokhov (1):
      x86/platform/geode: switch GPIO buttons and LEDs to software properties

Gergo Koteles (2):
      platform/x86: ideapad-laptop: move ACPI helpers from header to source file
      platform/x86: lenovo-ymc: Ignore the 0x0 state

Hans de Goede (3):
      Merge tag 'platform-drivers-x86-v6.11-3' into review-hans
      Merge tag 'hwmon-for-v6.11-rc7' into review-hans
      platform/x86: x86-android-tablets: Adjust Xiaomi Pad 2 bottom bezel touch buttons LED

Ilpo Järvinen (1):
      platform/x86: intel/pmc: Remove unused param idx from pmc_for_each_mode()

James Harmison (1):
      platform/x86: panasonic-laptop: Add support for programmable buttons

Jithu Joseph (3):
      platform/x86/intel/ifs: Add SBAF test image loading support
      platform/x86/intel/ifs: Add SBAF test support
      trace: platform/x86/intel/ifs: Add SBAF trace support

Kane Chen (1):
      platform/x86/intel/pmc: Show live substate requirements

Konrad Dybcio (3):
      dt-bindings: serial: Allow embedded-controller as child node
      dt-bindings: platform: Add Surface System Aggregator Module
      platform/surface: Add OF support

Kuppuswamy Sathyanarayanan (2):
      platform/x86/intel/ifs: Refactor MSR usage in IFS test code
      platform/x86/intel/ifs: Fix SBAF title underline length

Li Zetao (1):
      platform/olpc: Remove redundant null pointer checks in olpc_ec_setup_debugfs()

Luiz Capitulino (1):
      platform/mellanox: mlxbf-pmc: fix lockdep warning

Lukas Bulwahn (1):
      MAINTAINERS: adjust file entry in INTEL MID PLATFORM

Luke D. Jones (3):
      hid-asus: use hid for brightness control on keyboard
      platform/x86: asus-wmi: add debug print in more key places
      platform/x86: asus-wmi: don't fail if platform_profile already registered

Matthias Fetzer (2):
      platform/x86: thinkpad_acpi: Add Thinkpad Edge E531 fan support
      platform/x86: thinkpad_acpi: Fix uninitialized symbol 's' warning

Mika Westerberg (1):
      platform/x86: intel_scu_ipc: Move intel_scu_ipc.h out of arch/x86/include/asm

Mohamed Ghanmi (1):
      platform/x86: asus-wmi: add support for vivobook fan profiles

Richard Fitzgerald (1):
      platform/x86: serial-multi-instantiate: Don't require both I2C and SPI

Shyam Sundar S K (3):
      platform/x86/amd/pmf: Add support for notifying Smart PC Solution updates
      platform/x86/amd/pmf: Relocate CPU ID macros to the PMF header
      platform/x86/amd/pmf: Update SMU metrics table for 1AH family series

Srinivas Pandruvada (2):
      platform/x86: ISST: Simplify isst_misc_reg() and isst_misc_unreg()
      platform/x86/intel-uncore-freq: Do not present separate package-die domain

Tero Kristo (3):
      Documentation: admin-guide: pm: Add efficiency vs. latency tradeoff to uncore documentation
      platform/x86/intel-uncore-freq: Add support for efficiency latency control
      platform/x86/intel-uncore-freq: Add efficiency latency control to sysfs interface

Thomas Zimmermann (10):
      platform/x86: acer-wmi: Use backlight power constants
      platform/x86: asus-laptop: Use backlight power constants
      platform/x86: asus-nb-wmi: Use backlight power constants
      platform/x86: asus-wmi: Use backlight power constants
      platform/x86: eeepc-laptop: Use backlight power constants
      platform/x86: eeepc-wmi: Use backlight power constants
      platform/x86: fujitsu-laptop: Use backlight power constants
      platform/x86: ideapad-laptop: Use backlight power constants
      platform/x86: oaktrail: Use backlight power constants
      platform/x86: samsung-laptop: Use backlight power constants

Xi Pardee (1):
      platform/x86: intel/pmc: Ignore all LTRs during suspend

aln8 (1):
      platform/x86/amd: pmf: Add quirk for TUF Gaming A14

 .../pm/intel_uncore_frequency_scaling.rst          |  59 +++
 .../bindings/platform/microsoft,surface-sam.yaml   |  47 +++
 .../devicetree/bindings/serial/serial.yaml         |   2 +-
 MAINTAINERS                                        |  23 +-
 arch/x86/Kconfig                                   |   6 +
 arch/x86/include/asm/intel_telemetry.h             |   2 +-
 arch/x86/include/asm/msr-index.h                   |   2 +
 arch/x86/platform/geode/Makefile                   |   1 +
 arch/x86/platform/geode/alix.c                     |  82 +---
 arch/x86/platform/geode/geode-common.c             | 178 +++++++++
 arch/x86/platform/geode/geode-common.h             |  21 ++
 arch/x86/platform/geode/geos.c                     |  80 +---
 arch/x86/platform/geode/net5501.c                  |  69 +---
 arch/x86/platform/intel-mid/intel-mid.c            |   3 +-
 drivers/hid/hid-asus.c                             |   7 +
 drivers/hwmon/hp-wmi-sensors.c                     |  22 +-
 drivers/mfd/intel_pmc_bxt.c                        |   3 +-
 drivers/mfd/intel_soc_pmic_bxtwc.c                 |   3 +-
 drivers/mfd/intel_soc_pmic_mrfld.c                 |   3 +-
 drivers/platform/mellanox/mlxbf-pmc.c              |   5 +
 drivers/platform/olpc/olpc-ec.c                    |   3 -
 drivers/platform/surface/aggregator/bus.c          |   2 +
 drivers/platform/surface/aggregator/controller.c   |  67 +++-
 drivers/platform/surface/aggregator/core.c         |  82 +++-
 .../platform/surface/surface_aggregator_registry.c |  45 ++-
 drivers/platform/x86/Kconfig                       |   3 +-
 drivers/platform/x86/acer-wmi.c                    |  19 +-
 drivers/platform/x86/amd/pmf/acpi.c                |  31 ++
 drivers/platform/x86/amd/pmf/core.c                |  20 +-
 drivers/platform/x86/amd/pmf/pmf-quirks.c          |   8 +
 drivers/platform/x86/amd/pmf/pmf.h                 |  73 ++++
 drivers/platform/x86/amd/pmf/spc.c                 |  51 ++-
 drivers/platform/x86/amd/pmf/tee-if.c              |  40 ++
 drivers/platform/x86/asus-laptop.c                 |   3 +-
 drivers/platform/x86/asus-nb-wmi.c                 |   4 +-
 drivers/platform/x86/asus-wmi.c                    | 224 ++++++-----
 drivers/platform/x86/dell/Kconfig                  |   1 +
 drivers/platform/x86/dell/dell-laptop.c            | 419 +++++++++++++++++----
 drivers/platform/x86/dell/dell-smbios.h            |   7 +
 drivers/platform/x86/dell/dell-wmi-aio.c           |  13 +-
 drivers/platform/x86/eeepc-laptop.c                |   3 +-
 drivers/platform/x86/eeepc-wmi.c                   |   4 +-
 drivers/platform/x86/fujitsu-laptop.c              |   9 +-
 drivers/platform/x86/hp/hp-wmi.c                   |  16 +-
 drivers/platform/x86/huawei-wmi.c                  |  14 +-
 drivers/platform/x86/ideapad-laptop.c              | 191 ++++++++--
 drivers/platform/x86/ideapad-laptop.h              | 139 -------
 drivers/platform/x86/intel/hid.c                   |   7 +-
 drivers/platform/x86/intel/ifs/core.c              |  33 ++
 drivers/platform/x86/intel/ifs/ifs.h               |  92 ++++-
 drivers/platform/x86/intel/ifs/load.c              |  40 +-
 drivers/platform/x86/intel/ifs/runtest.c           | 233 ++++++++++++
 drivers/platform/x86/intel/int3472/Makefile        |   9 +-
 drivers/platform/x86/intel/int3472/common.c        |   7 +
 drivers/platform/x86/intel/int3472/discrete.c      |   9 +-
 drivers/platform/x86/intel/oaktrail.c              |   3 +-
 drivers/platform/x86/intel/pmc/core.c              |  83 +++-
 drivers/platform/x86/intel/pmc/core.h              |  12 +-
 drivers/platform/x86/intel/pmc/core_ssram.c        |   6 +-
 drivers/platform/x86/intel/pmt/class.c             |  28 +-
 drivers/platform/x86/intel/pmt/class.h             |  10 +-
 drivers/platform/x86/intel/pmt/crashlog.c          |   2 +-
 drivers/platform/x86/intel/pmt/telemetry.c         |  12 +-
 drivers/platform/x86/intel/sdsi.c                  |   3 +-
 .../x86/intel/speed_select_if/isst_if_common.c     |  40 +-
 drivers/platform/x86/intel/tpmi.c                  |   3 +-
 .../uncore-frequency/uncore-frequency-common.c     |  42 ++-
 .../uncore-frequency/uncore-frequency-common.h     |  17 +-
 .../intel/uncore-frequency/uncore-frequency-tpmi.c | 165 +++++++-
 drivers/platform/x86/intel/vsec.c                  |   8 +-
 drivers/platform/x86/intel_scu_ipc.c               |   2 +-
 drivers/platform/x86/intel_scu_ipcutil.c           |   2 +-
 drivers/platform/x86/intel_scu_pcidrv.c            |   2 +-
 drivers/platform/x86/intel_scu_pltdrv.c            |   2 +-
 drivers/platform/x86/intel_scu_wdt.c               |   3 +-
 drivers/platform/x86/lenovo-ymc.c                  |   2 +
 drivers/platform/x86/lg-laptop.c                   | 149 +++++++-
 drivers/platform/x86/msi-wmi.c                     |  20 +-
 drivers/platform/x86/panasonic-laptop.c            |  16 +-
 drivers/platform/x86/samsung-laptop.c              |   5 +-
 drivers/platform/x86/serial-multi-instantiate.c    |  32 +-
 drivers/platform/x86/thinkpad_acpi.c               | 145 ++++++-
 drivers/platform/x86/toshiba-wmi.c                 |  15 +-
 drivers/platform/x86/touchscreen_dmi.c             |  26 ++
 drivers/platform/x86/wmi.c                         | 143 ++-----
 drivers/platform/x86/x86-android-tablets/Kconfig   |   2 +-
 drivers/platform/x86/x86-android-tablets/asus.c    |   8 +-
 drivers/platform/x86/x86-android-tablets/core.c    |  20 +-
 drivers/platform/x86/x86-android-tablets/dmi.c     |  16 +-
 drivers/platform/x86/x86-android-tablets/lenovo.c  |  22 +-
 drivers/platform/x86/x86-android-tablets/other.c   |  40 +-
 .../x86/x86-android-tablets/shared-psy-info.c      |   4 +-
 .../x86/x86-android-tablets/x86-android-tablets.h  |   2 +-
 drivers/usb/typec/mux/intel_pmc_mux.c              |   3 +-
 drivers/watchdog/intel-mid_wdt.c                   |   5 +-
 include/linux/acpi.h                               |   3 +-
 .../x86/intel/vsec.h => include/linux/intel_vsec.h |  47 ++-
 include/linux/platform_data/x86/asus-wmi.h         |  37 ++
 .../linux/platform_data/{ => x86}/intel-mid_wdt.h  |   6 +-
 .../linux/platform_data/x86}/intel_scu_ipc.h       |   4 +-
 include/trace/events/intel_ifs.h                   |  27 ++
 101 files changed, 2723 insertions(+), 1060 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/platform/microsoft,surface-sam.yaml
 create mode 100644 arch/x86/platform/geode/geode-common.c
 create mode 100644 arch/x86/platform/geode/geode-common.h
 rename drivers/platform/x86/intel/vsec.h => include/linux/intel_vsec.h (62%)
 rename include/linux/platform_data/{ => x86}/intel-mid_wdt.h (74%)
 rename {arch/x86/include/asm => include/linux/platform_data/x86}/intel_scu_ipc.h (96%)



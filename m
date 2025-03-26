Return-Path: <linux-kernel+bounces-577079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A193A71815
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 652253A483F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAAE1EFF98;
	Wed, 26 Mar 2025 14:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kz+MlTam"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93933187876;
	Wed, 26 Mar 2025 14:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742998024; cv=none; b=Y8fUavvNfwsK172uRx6eD2d0u0nmzktcrh7zBmoPuA6DRMJsA0yIiBhWSyCznYRuWUsdAZmQ6FOc0fgAisBzZfbv9kbt6jPVPeWG6Fso0IZ/QieE2AuVVTP1KgftTn+GppumssQJqlIHAjkFzf5B5SShEC/D5xomzvtDks9qUXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742998024; c=relaxed/simple;
	bh=5Dy3e01ZqWRkJMYkOCiJkNVEqowWn6MqPCFMtDszpRM=;
	h=From:To:Cc:Date:Subject:Message-ID:MIME-Version:Content-Type; b=lqNI0wgSHQuUEZd/UkM2YMeM7bVDZR2f0ruWiY0/v2pbcewjahcZhZo9F4cGuzbfQq/qfctlPAEEJ6f4atIGPlVjmcrWC0bmYzxie5z1ipCBcji11HR4vBu7QExNTfA6AHsDoDSqCeGIN+Hj0vdOJEABQnyGUVgJkOpopK2gRiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kz+MlTam; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742998023; x=1774534023;
  h=from:to:cc:date:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=5Dy3e01ZqWRkJMYkOCiJkNVEqowWn6MqPCFMtDszpRM=;
  b=kz+MlTam9r19v0pIwK7FICU15EIrAu8GwogSn4lIzoniVNWyZDnR7z0U
   lrEUG0FzI/de3fYODRovDgdJDBAuWUZKJMGvyE3N1zFyIjjA0p0/+1vYk
   I5jjn9eXnLfQ8oAsOqLin3C35F6W0e66gQ6vHonuYxQc5RGyJ/jzSUJ0+
   MDFF1pl/hH03/lohJRXeY9P6ExfB6DC2Ki3es/jonkvwanLp2zlGh31DP
   /8gikKJHNnH5ZTx8ApoDmbTU0h/goimg1opOGyWG0G2qvmKj5OMOcvFbw
   fX1OoJ12cXF6bXVzBLV471c5Lfl1iztZRKHVnDw4di3bFzQXPva2Mv6E3
   A==;
X-CSE-ConnectionGUID: bC/oIXPpTlq07NY0M0Dqig==
X-CSE-MsgGUID: WCc/qecERdWwYdiYtrZUFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="47941977"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="47941977"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 07:07:03 -0700
X-CSE-ConnectionGUID: TjCskTLVSPiwjcMkj8E2jA==
X-CSE-MsgGUID: CqxseajRTX+OG7KY6BQp6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="129903829"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.5])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 07:06:59 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Date: Wed, 26 Mar 2025 15:59:34 +0200
Subject: [GIT PULL] platform-drivers-x86 for v6.15-1
Message-ID: <pdx86-pr-20250326155934-163925309@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here is the main PDx86 PR for v6.15.

Highlights:

 - alienware-wmi: Refactor and split WMAX/legacy drivers

 - dell-ddv:

    - Correct +0.1 offset in temperature

    - Use the power supply extension mechanism for battery temperatures

 - intel/pmc:

    - Refactor init to mostly use a common init function

    - Add support for Arrow Lake U/H

    - Add support for Panther Lake

 - intel/sst:

    - Improve multi die handling

    - Prefix header search path with sysroot (fixes cross-compiling)

 - lenovo-wmi-hotkey-utilities: Support for mic & audio mute LEDs

 - samsung-galaxybook: Add driver for Samsung Galaxy Book series

 - wmi:

    - Rework WCxx/WExx ACPI method handling

    - Enable data block collection when the data block is set

 - platform/arm:

    - Add Huawei Matebook E Go EC driver

 - platform/mellanox:

    - Relocate to drivers/platform/mellanox/

    - mlxbf-bootctl: RTC battery status sysfs support

 - Miscellaneous cleanups / refactoring / improvements

Regards, i.


The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.15-1

for you to fetch changes up to 2c30357e755b087217c7643fda2b8aea6d6deda4:

  platform/x86: x86-android-tablets: Add select POWER_SUPPLY to Kconfig (2025-03-24 15:51:15 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v6.15-1

Highlights:

 - alienware-wmi: Refactor and split WMAX/legacy drivers

 - dell-ddv:

    - Correct +0.1 offset in temperature

    - Use the power supply extension mechanism for battery temperatures

 - intel/pmc:

    - Refactor init to mostly use a common init function

    - Add support for Arrow Lake U/H

    - Add support for Panther Lake

 - intel/sst:

    - Improve multi die handling

    - Prefix header search path with sysroot (fixes cross-compiling)

 - lenovo-wmi-hotkey-utilities: Support for mic & audio mute LEDs

 - samsung-galaxybook: Add driver for Samsung Galaxy Book series

 - wmi:

    - Rework WCxx/WExx ACPI method handling

    - Enable data block collection when the data block is set

 - platform/arm:

    - Add Huawei Matebook E Go EC driver

 - platform/mellanox:

    - Relocate to drivers/platform/mellanox/

    - mlxbf-bootctl: RTC battery status sysfs support

 - Miscellaneous cleanups / refactoring / improvements

The following is an automated shortlog grouped by driver:

alienware-wmi:
 -  Add a state container for LED control feature
 -  Add a state container for thermal control methods
 -  Add alienware-wmi.h
 -  Add WMI Drivers
 -  Refactor hdmi, amplifier, deepslp methods
 -  Refactor LED control methods
 -  Refactor thermal control methods
 -  Rename alienware-wmi.c
 -  Split DMI table
 -  Split the alienware-wmi driver
 -  Update alienware-wmi config entries
 -  Update header and module information

amd/pmc:
 -  fix leak in probe()
 -  Move macros and structures to the PMC header file
 -  Notify user when platform does not support s0ix transition
 -  Remove unnecessary line breaks
 -  Use managed APIs for mutex

amd/pmf:
 -  convert timeouts to secs_to_jiffies()

amd:
 -  Use *-y instead of *-objs in Makefiles

arm64:
 -  add Huawei Matebook E Go EC driver

arm64: dts: qcom: gaokun3:
 -  Add Embedded Controller node

compal-laptop:
 -  Do not include <linux/fb.h>

dell-ddv:
 -  Fix temperature calculation
 -  Use devm_battery_hook_register
 -  Use the power supply extension mechanism

dell: dell-wmi-sysman:
 -  Use *-y instead of *-objs in Makefile

dell:
 -  Modify Makefile alignment
 -  Use *-y instead of *-objs in Makefile

dell-uart-backlight:
 -  Make dell_uart_bl_serdev_driver static

dt-bindings: platform:
 -  Add Huawei Matebook E Go EC

hp-bioscfg:
 -  Replace deprecated strncpy() with strscpy()
 -  Use wmi_instance_count()

hp:
 -  Use *-y instead of *-objs in Makefile

hwmon:
 -  (hp-wmi-sensors) Use the WMI bus API when accessing sensors

ideapad-laptop:
 -  use dev_groups to register attribute groups

int3472:
 -  Call "func" "con_id" instead

intel/pmc:
 -  Add Arrow Lake U/H support to intel_pmc_core driver
 -  Add Panther Lake support to intel_pmc_core
 -  Create generic_core_init() for all platforms
 -  Make tgl_core_generic_init() static
 -  Move arch specific action to init function
 -  Remove duplicate enum
 -  Remove simple init functions
 -  Remove unnecessary declarations in header
 -  Remove unneeded extern keyword in header

intel:
 -  Use *-y instead of *-objs in Makefile

irqdomain: platform/x86:
 -  Switch to irq_domain_create_linear()

lenovo-wmi-hotkey-utilities.c:
 -  Support for mic and audio mute LEDs

lenovo-yoga-tab2-pro-1380-fastcharger:
 -  Make symbol static

MAINTAINERS:
 -  Add documentation reference for Mellanox platform
 -  Update ALIENWARE WMI DRIVER entry

mellanox:
 -  Relocate mlx-platform driver

mlxbf-bootctl:
 -  Support sysfs entries for RTC battery status

mlx-platform:
 -  Change register name
 -  Cosmetic changes

samsung-galaxybook:
 -  Add samsung-galaxybook driver
 -  Fix block_recording not supported logic

sonypi:
 -  Use str_on_off() helper in sonypi_display_info()

think-lmi:
 -  Use ACPI object when extracting strings
 -  Use WMI bus API when accessing BIOS settings

thinkpad_acpi:
 -  check the return value of devm_mutex_init()
 -  convert timeouts to secs_to_jiffies()
 -  Do not include <linux/fb.h>
 -  Move HWMON initialization to tpacpi_hwmon_pdriver's probe
 -  Move subdriver initialization to tpacpi_pdriver's probe.

tools/power/x86/intel-speed-select:
 -  Die ID for IO dies
 -  Fix the condition to check multi die system
 -  Prefix header search path with sysroot
 -  Prevent increasing MAX_DIE_PER_PACKAGE
 -  v1.22 release

wmi:
 -  Call WCxx methods when setting data blocks
 -  Rework WCxx/WExx ACPI method handling
 -  Update documentation regarding the GUID-based API
 -  Use devres to disable the WMI device

x86-android-tablets:
 -  Add select POWER_SUPPLY to Kconfig

Merges:
 -  Merge branch 'fixes' into for-next
 -  Merge branch 'intel-sst' of https://github.com/spandruvada/linux-kernel into review-ilpo-next

----------------------------------------------------------------
Armin Wolf (11):
      hwmon: (hp-wmi-sensors) Use the WMI bus API when accessing sensors
      platform/x86: think-lmi: Use ACPI object when extracting strings
      platform/x86: think-lmi: Use WMI bus API when accessing BIOS settings
      platform/x86: hp-bioscfg: Use wmi_instance_count()
      platform/x86: wmi: Use devres to disable the WMI device
      platform/x86: wmi: Rework WCxx/WExx ACPI method handling
      platform/x86: wmi: Call WCxx methods when setting data blocks
      platform/x86: wmi: Update documentation regarding the GUID-based API
      platform/x86: dell-ddv: Fix temperature calculation
      platform/x86: dell-ddv: Use devm_battery_hook_register
      platform/x86: dell-ddv: Use the power supply extension mechanism

Bartosz Golaszewski (1):
      platform/x86: thinkpad_acpi: check the return value of devm_mutex_init()

Dan Carpenter (1):
      platform/x86/amd/pmc: fix leak in probe()

Dmitry Kandybka (1):
      platform/x86/intel: pmc: fix ltr decode in pmc_core_ltr_show()

Easwar Hariharan (2):
      platform/x86: thinkpad_acpi: convert timeouts to secs_to_jiffies()
      platform/x86/amd/pmf: convert timeouts to secs_to_jiffies()

Fedor Pchelkin (1):
      platform/x86: ideapad-laptop: pass a correct pointer to the driver data

Hans de Goede (1):
      platform/x86: x86-android-tablets: Add select POWER_SUPPLY to Kconfig

Ilpo Järvinen (4):
      Merge branch 'fixes' into for-next
      platform/x86: lenovo-yoga-tab2-pro-1380-fastcharger: Make symbol static
      platform/x86: dell-uart-backlight: Make dell_uart_bl_serdev_driver static
      Merge branch 'intel-sst' of https://github.com/spandruvada/linux-kernel into review-ilpo-next

Jackie Dong (1):
      platform/x86:lenovo-wmi-hotkey-utilities.c: Support for mic and audio mute LEDs

Jiri Slaby (SUSE) (1):
      irqdomain: platform/x86: Switch to irq_domain_create_linear()

Jithu Joseph (1):
      platform/x86/intel/ifs: Update documentation with image download path

Joshua Grisham (2):
      platform/x86: samsung-galaxybook: Add samsung-galaxybook driver
      platform/x86: samsung-galaxybook: Fix block_recording not supported logic

Khem Raj (1):
      tools/power/x86/intel-speed-select: Prefix header search path with sysroot

Kurt Borja (21):
      platform/x86: alienware-wmi: Add a state container for LED control feature
      platform/x86: alienware-wmi: Add WMI Drivers
      platform/x86: alienware-wmi: Add a state container for thermal control methods
      platform/x86: alienware-wmi: Refactor LED control methods
      platform/x86: alienware-wmi: Refactor hdmi, amplifier, deepslp methods
      platform/x86: alienware-wmi: Refactor thermal control methods
      platform/x86: alienware-wmi: Split DMI table
      MAINTAINERS: Update ALIENWARE WMI DRIVER entry
      platform/x86: Rename alienware-wmi.c
      platform/x86: Add alienware-wmi.h
      platform/x86: Split the alienware-wmi driver
      platform/x86: dell: Modify Makefile alignment
      platform/x86: Update alienware-wmi config entries
      platform/x86: alienware-wmi: Update header and module information
      platform/x86: dell: Use *-y instead of *-objs in Makefile
      platform/x86: thinkpad_acpi: Move subdriver initialization to tpacpi_pdriver's probe.
      platform/x86: thinkpad_acpi: Move HWMON initialization to tpacpi_hwmon_pdriver's probe
      platform/x86: dell: dell-wmi-sysman: Use *-y instead of *-objs in Makefile
      platform/x86: amd: Use *-y instead of *-objs in Makefiles
      platform/x86: hp: Use *-y instead of *-objs in Makefile
      platform/x86: intel: Use *-y instead of *-objs in Makefile

Mark Pearson (2):
      platform/x86: thinkpad_acpi: Support for V9 DYTC platform profiles
      platform/x86: thinkpad_acpi: Fix registration of tpacpi platform driver

Ovidiu Panait (1):
      platform/x86: ideapad-laptop: use dev_groups to register attribute groups

Pengyu Luo (3):
      dt-bindings: platform: Add Huawei Matebook E Go EC
      platform: arm64: add Huawei Matebook E Go EC driver
      arm64: dts: qcom: gaokun3: Add Embedded Controller node

Sakari Ailus (3):
      platform/x86: int3472: Use correct type for "polarity", call it gpio_flags
      platform/x86: int3472: Call "reset" GPIO "enable" for INT347E
      platform/x86: int3472: Call "func" "con_id" instead

Shyam Sundar S K (4):
      platform/x86/amd/pmc: Notify user when platform does not support s0ix transition
      platform/x86/amd/pmc: Move macros and structures to the PMC header file
      platform/x86/amd/pmc: Remove unnecessary line breaks
      platform/x86/amd/pmc: Use managed APIs for mutex

Srinivas Pandruvada (4):
      tools/power/x86/intel-speed-select: Prevent increasing MAX_DIE_PER_PACKAGE
      tools/power/x86/intel-speed-select: Fix the condition to check multi die system
      tools/power/x86/intel-speed-select: Die ID for IO dies
      tools/power/x86/intel-speed-select: v1.22 release

Sybil Isabel Dorsett (1):
      platform/x86: thinkpad_acpi: Fix invalid fan speed on ThinkPad X120e

Thomas Zimmermann (2):
      platform/x86: compal-laptop: Do not include <linux/fb.h>
      platform/x86: thinkpad-acpi: Do not include <linux/fb.h>

Thorsten Blum (2):
      sonypi: Use str_on_off() helper in sonypi_display_info()
      platform/x86: hp-bioscfg: Replace deprecated strncpy() with strscpy()

Vadim Pasternak (4):
      mellanox: Relocate mlx-platform driver
      platform: mellanox: mlx-platform: Cosmetic changes
      platform: mellanox: mlx-platform: Change register name
      MAINTAINERS: Add documentation reference for Mellanox platform

Xi Pardee (9):
      platform/x86:intel/pmc: Make tgl_core_generic_init() static
      platform/x86/intel/pmc: Remove duplicate enum
      platform/x86:intel/pmc: Create generic_core_init() for all platforms
      platform/x86/intel/pmc: Remove simple init functions
      platform/x86/intel/pmc: Add Arrow Lake U/H support to intel_pmc_core driver
      platform/x86:intel/pmc: Move arch specific action to init function
      platform/x86/intel/pmc: Add Panther Lake support to intel_pmc_core
      platform/x86/intel/pmc: Remove unnecessary declarations in header
      platform/x86/intel/pmc: Remove unneeded extern keyword in header

Xiangrong Li (1):
      mlxbf-bootctl: Support sysfs entries for RTC battery status

 .../ABI/testing/sysfs-platform-mellanox-bootctl    |   10 +
 Documentation/admin-guide/laptops/index.rst        |    1 +
 .../admin-guide/laptops/samsung-galaxybook.rst     |  174 +++
 .../bindings/platform/huawei,gaokun-ec.yaml        |  124 ++
 Documentation/wmi/acpi-interface.rst               |    3 +
 Documentation/wmi/driver-development-guide.rst     |    4 +
 MAINTAINERS                                        |   31 +-
 .../boot/dts/qcom/sc8280xp-huawei-gaokun3.dts      |  163 +++
 drivers/char/sonypi.c                              |   11 +-
 drivers/hwmon/hp-wmi-sensors.c                     |    4 +-
 drivers/platform/arm64/Kconfig                     |   21 +
 drivers/platform/arm64/Makefile                    |    1 +
 drivers/platform/arm64/huawei-gaokun-ec.c          |  825 ++++++++++++
 drivers/platform/mellanox/Kconfig                  |   13 +
 drivers/platform/mellanox/Makefile                 |    1 +
 drivers/platform/{x86 => mellanox}/mlx-platform.c  |   17 +-
 drivers/platform/mellanox/mlxbf-bootctl.c          |   20 +
 drivers/platform/mellanox/mlxbf-bootctl.h          |    5 +
 drivers/platform/x86/Kconfig                       |   41 +-
 drivers/platform/x86/Makefile                      |    7 +-
 drivers/platform/x86/amd/Makefile                  |    2 +-
 drivers/platform/x86/amd/hsmp/Makefile             |    6 +-
 drivers/platform/x86/amd/pmc/Makefile              |    6 +-
 drivers/platform/x86/amd/pmc/pmc.c                 |  113 +-
 drivers/platform/x86/amd/pmc/pmc.h                 |   82 ++
 drivers/platform/x86/amd/pmf/Makefile              |    8 +-
 drivers/platform/x86/amd/pmf/acpi.c                |    2 +-
 drivers/platform/x86/asus-tf103c-dock.c            |    2 +-
 drivers/platform/x86/compal-laptop.c               |    1 -
 drivers/platform/x86/dell/Kconfig                  |   30 +-
 drivers/platform/x86/dell/Makefile                 |   45 +-
 drivers/platform/x86/dell/alienware-wmi-base.c     |  491 +++++++
 drivers/platform/x86/dell/alienware-wmi-legacy.c   |   95 ++
 drivers/platform/x86/dell/alienware-wmi-wmax.c     |  768 +++++++++++
 drivers/platform/x86/dell/alienware-wmi.c          | 1249 -----------------
 drivers/platform/x86/dell/alienware-wmi.h          |  117 ++
 drivers/platform/x86/dell/dell-uart-backlight.c    |    2 +-
 drivers/platform/x86/dell/dell-wmi-ddv.c           |   84 +-
 drivers/platform/x86/dell/dell-wmi-sysman/Makefile |    2 +-
 drivers/platform/x86/hp/hp-bioscfg/Makefile        |    2 +-
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c       |   15 +-
 drivers/platform/x86/ideapad-laptop.c              |   25 +-
 drivers/platform/x86/intel/ifs/Makefile            |    2 +-
 drivers/platform/x86/intel/ifs/ifs.h               |    9 +-
 drivers/platform/x86/intel/int3472/discrete.c      |  105 +-
 drivers/platform/x86/intel/pmc/Makefile            |    2 +-
 drivers/platform/x86/intel/pmc/adl.c               |   56 +-
 drivers/platform/x86/intel/pmc/arl.c               |  137 +-
 drivers/platform/x86/intel/pmc/cnp.c               |   29 +-
 drivers/platform/x86/intel/pmc/core.c              |  119 +-
 drivers/platform/x86/intel/pmc/core.h              |  199 +--
 drivers/platform/x86/intel/pmc/icl.c               |   24 +-
 drivers/platform/x86/intel/pmc/lnl.c               |   67 +-
 drivers/platform/x86/intel/pmc/mtl.c               |  109 +-
 drivers/platform/x86/intel/pmc/ptl.c               |  550 ++++++++
 drivers/platform/x86/intel/pmc/spt.c               |   45 +-
 drivers/platform/x86/intel/pmc/tgl.c               |   59 +-
 drivers/platform/x86/lenovo-wmi-hotkey-utilities.c |  212 +++
 .../x86/lenovo-yoga-tab2-pro-1380-fastcharger.c    |    2 +-
 drivers/platform/x86/samsung-galaxybook.c          | 1425 ++++++++++++++++++++
 drivers/platform/x86/think-lmi.c                   |   51 +-
 drivers/platform/x86/think-lmi.h                   |    2 +
 drivers/platform/x86/thinkpad_acpi.c               |  242 ++--
 drivers/platform/x86/wmi.c                         |  143 +-
 drivers/platform/x86/x86-android-tablets/Kconfig   |    1 +
 include/linux/platform_data/huawei-gaokun-ec.h     |   79 ++
 tools/power/x86/intel-speed-select/Makefile        |    2 +-
 tools/power/x86/intel-speed-select/isst-config.c   |   22 +-
 tools/power/x86/intel-speed-select/isst-display.c  |   11 +-
 69 files changed, 6100 insertions(+), 2227 deletions(-)
 create mode 100644 Documentation/admin-guide/laptops/samsung-galaxybook.rst
 create mode 100644 Documentation/devicetree/bindings/platform/huawei,gaokun-ec.yaml
 create mode 100644 drivers/platform/arm64/huawei-gaokun-ec.c
 rename drivers/platform/{x86 => mellanox}/mlx-platform.c (99%)
 create mode 100644 drivers/platform/x86/dell/alienware-wmi-base.c
 create mode 100644 drivers/platform/x86/dell/alienware-wmi-legacy.c
 create mode 100644 drivers/platform/x86/dell/alienware-wmi-wmax.c
 delete mode 100644 drivers/platform/x86/dell/alienware-wmi.c
 create mode 100644 drivers/platform/x86/dell/alienware-wmi.h
 create mode 100644 drivers/platform/x86/intel/pmc/ptl.c
 create mode 100644 drivers/platform/x86/lenovo-wmi-hotkey-utilities.c
 create mode 100644 drivers/platform/x86/samsung-galaxybook.c
 create mode 100644 include/linux/platform_data/huawei-gaokun-ec.h


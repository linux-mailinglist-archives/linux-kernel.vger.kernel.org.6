Return-Path: <linux-kernel+bounces-253613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5E59323C5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 12:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EA041C21B8F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 10:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2771991D4;
	Tue, 16 Jul 2024 10:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fQKqmLI3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885E21991BE;
	Tue, 16 Jul 2024 10:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721125189; cv=none; b=TDmeOrBvlfN570SQrAYkGmbOctqwo62qvgetrc8UPIG3kK/t3JZevXUHxQYhxMbj5BV2rwirUbwy0sj8FyZBvKIvNfNbpzQU+d7VcgaRBhGzaYbtRNhaBe5qVmgb+geRP0Eh/2HkUVeg8bPKgG8Q4MqPxfX1vlIovR++beA1a3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721125189; c=relaxed/simple;
	bh=2eQkafaCbvnXFaeRjQV/lH+u7D9zellmWU75uCnWzOo=;
	h=From:To:Cc:Date:Subject:Message-ID:MIME-Version:Content-Type; b=qDTsEBfxxxM1Y1Bodd3mX+2g2OTd8msLMNuxblRmiMnaaGpUpxzNtGb2cf2+BGwZgep5nisFJinHQ9ijrO1t1KPv11xSiNJ9PDKJ0U0mbqsvCtyBjLNiMUDJYjRy4ItlyW29XjVww+3YsHjQtW2OjMMk0Vu2/oLZcIQvPdKg3G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fQKqmLI3; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721125188; x=1752661188;
  h=from:to:cc:date:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=2eQkafaCbvnXFaeRjQV/lH+u7D9zellmWU75uCnWzOo=;
  b=fQKqmLI3swR/s2vaEpWgSu1xMRMjxPLidFwlYfCiIwU2k82aOsB9HoAt
   FsGh4ujaaZSQ19+WL5ClUWRGe/GkYYz0bkiqWtzzOhzwlvq3XGU4ZugLr
   jyqUva+w0sV7DAZ/nHl8yb3f64ciwK5OFITbmFtPMeEnYjOWfBnTnXsLl
   WkhNq7QF52oRU4LsjjTcqO3+OAljj4/dsArLgRs9pPcffD+VkneNjeJOS
   yuj/EjNuTHiAmqWkh4jcqrgWtq6RczARqR2IaBgb/XOSGyEhyeB30Yyqe
   nWysLdZTuSJL/WJjcYC2q+k7buuaBsFf2CpOVoXRLZNnTyRepUCB9N79W
   A==;
X-CSE-ConnectionGUID: 5IVB24SUT8KHhy0F1jT5Aw==
X-CSE-MsgGUID: 9eWzJva2Rh+lC9G5GNjt/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="41078565"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="41078565"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 03:19:47 -0700
X-CSE-ConnectionGUID: L7pvEwS7TD6uD6lgzgIYIQ==
X-CSE-MsgGUID: ngaqdashTX6jZEB5lG5mPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="49886652"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.133])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 03:19:44 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Date: Tue, 16 Jul 2024 13:14:10 +0300
Subject: [GIT PULL] platform-drivers-x86 for v6.11-1
Message-ID: <pdx86-pr-20240716131410-2360330733@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here is the main PDx86 PR for v6.11.

Highlights:
 - amd/pmf:		Report system state changes using existing input
			events
 - asus-wmi:		Zenbook 2023 camera LED disable support and fix
			TUF laptop keyboard RGB LED sysfs interface
 - dell-pc:		Fan modes / platform profile support
 - hp-wmi:		Fix platform profile switching on Omen/Victus
			laptops
 - intel/ISST:		Use only TPMI interface when TPMI and legacy
			interfaces are available
 - intel/pmc:		LTR restore support to pair with LTR ignore
 - intel/tpmi:		Performance Limit Reasons (PLR) and APIC <-> Punit
			CPU numbering mapping support
 - WMI:			driver override support and docs improvements
 - lenovo-yoga-c630:	Support for EC (platform/arm64)
 - platform/arm64:	Fix build with COMPILE_TEST (broke after addition
			of C630)
 - tools:		Intel Speed Select Turbo Ratio Limit fix
 - Miscellaneous cleanups / refactoring / improvements

Regards, i.


The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.11-1

for you to fetch changes up to d8b17a364ec48239fccb65efe74bb485e79e6743:

  platform/x86: asus-wmi: fix TUF laptop RGB variant (2024-07-16 12:49:09 +0300)

----------------------------------------------------------------
platform-drivers-x86 for v6.11-1

Highlights:
 - amd/pmf:		Report system state changes using existing input
			events
 - asus-wmi:		Zenbook 2023 camera LED disable support and fix
			TUF laptop keyboard RGB LED sysfs interface
 - dell-pc:		Fan modes / platform profile support
 - hp-wmi:		Fix platform profile switching on Omen/Victus
			laptops
 - intel/ISST:		Use only TPMI interface when TPMI and legacy
			interfaces are available
 - intel/pmc:		LTR restore support to pair with LTR ignore
 - intel/tpmi:		Performance Limit Reasons (PLR) and APIC <-> Punit
			CPU numbering mapping support
 - WMI:			driver override support and docs improvements
 - lenovo-yoga-c630:	Support for EC (platform/arm64)
 - platform/arm64:	Fix build with COMPILE_TEST (broke after addition
			of C630)
 - tools:		Intel Speed Select Turbo Ratio Limit fix
 - Miscellaneous cleanups / refactoring / improvements

The following is an automated shortlog grouped by driver:

amd/pmf:
 -  Remove update system state document
 -  Use existing input event codes to update system states
 -  Use memdup_user()

arm64:
 -  add Lenovo Yoga C630 WOS EC driver
 -  build drivers even on non-ARM64 platforms
 -  EC_ACER_ASPIRE1 should depend on ARCH_QCOM
 -  EC_LENOVO_YOGA_C630 should depend on ARCH_QCOM

arm64: lenovo-yoga-c630:
 -  select AUXILIARY_BUS

asus-tf103c-dock:
 -  Use 2-argument strscpy()

asus-wmi:
 -  fix TUF laptop RGB variant
 -  support the disable camera LED on F10 of Zenbook 2023

dell-pc:
 -  avoid double free and invalid unregistration
 -  Implement platform_profile

dell-smbios:
 -  Add helper for checking supported class
 -  Move request functions for reuse

Docs/admin-guide:
 -  Remove pmf leftover reference from the index

doc: TPMI:
 -  Add entry for Performance Limit Reasons

dt-bindings: platform:
 -  Add Lenovo Yoga C630 EC

hp: hp-bioscfg:
 -  Use 2-argument strscpy()

hp-wmi:
 -  Fix implementation of the platform_profile_omen_get function
 -  Fix platform profile option switch bug on Omen and Victus laptops

ideapad-laptop:
 -  use cleanup.h

intel: chtwc_int33fe:
 -  Use 2-argument strscpy()

intel/ifs:
 -  Switch to new Intel CPU model defines

intel_ips:
 -  Switch to new Intel CPU model defines

intel/pmc:
 -  Add support to show ltr_ignore value
 -  Add support to undo ltr_ignore
 -  Convert index variables to be unsigned
 -  Move pmc assignment closer to first usage
 -  Remove unneeded min_t check
 -  Simplify mutex usage with cleanup helpers
 -  Switch to new Intel CPU model defines
 -  Use DEFINE_SHOW_STORE_ATTRIBUTE macro
 -  Use the Elvis operator
 -  Use the return value of pmc_core_send_msg

intel_scu_wdt:
 -  Switch to new Intel CPU model defines

intel_speed_select_if:
 -  Switch to new Intel CPU model defines

intel_telemetry:
 -  Switch to new Intel CPU model defines

intel/tpmi:
 -  Add API to get debugfs root
 -  Add new auxiliary driver for performance limits
 -  Add support for performance limit reasons

intel:
 -  TPMI domain id and CPU mapping

intel/tpmi/plr:
 -  Add support for the plr mailbox
 -  Fix output in plr_print_bits()

intel_turbo_max_3:
 -  Switch to new Intel CPU model defines

intel-uncore-freq:
 -  Get rid of magic min_max argument
 -  Get rid of magic values
 -  Get rid of uncore_read_freq driver API
 -  Re-arrange bit masks
 -  Rename the sysfs helper macro names
 -  Switch to new Intel CPU model defines
 -  Use generic helpers for current frequency
 -  Use uncore_index with read_control_freq

ISST:
 -  Add model specific loading for common module
 -  Avoid some SkyLake server models
 -  Use only TPMI interface when present

p2sb:
 -  Switch to new Intel CPU model defines

serial-multi-instantiate:
 -  Use 2-argument strscpy()

think-lmi:
 -  Use 2-argument strscpy()

thinkpad_acpi:
 -  Use 2-argument strscpy()

tools/power/x86/intel-speed-select:
 -  Set TRL MSR in 100 MHz units
 -  v1.20 release

wmi:
 -  Add bus ABI documentation
 -  Add driver_override support

x86/platform/atom:
 -  Switch to new Intel CPU model defines

Merges:
 -  Merge branch 'pdx86/platform-drivers-x86-lenovo-c630' into review-ilpo
 -  Merge branch 'pdx86/platform-drivers-x86-lenovo-c630' into review-ilpo
 -  Merge branch 'pdx86/platform-drivers-x86-lenovo-c630' into review-ilpo
 -  Merge remote-tracking branch 'intel-speed-select/intel-sst' into review-ilpo

----------------------------------------------------------------
Alexis Belmonte (2):
      platform/x86: hp-wmi: Fix platform profile option switch bug on Omen and Victus laptops
      platform/x86: hp-wmi: Fix implementation of the platform_profile_omen_get function

Andy Shevchenko (6):
      platform/x86: asus-tf103c-dock: Use 2-argument strscpy()
      platform/x86: hp: hp-bioscfg: Use 2-argument strscpy()
      platform/x86: intel: chtwc_int33fe: Use 2-argument strscpy()
      platform/x86: serial-multi-instantiate: Use 2-argument strscpy()
      platform/x86: think-lmi: Use 2-argument strscpy()
      platform/x86: thinkpad_acpi: Use 2-argument strscpy()

Armin Wolf (2):
      platform/x86: wmi: Add driver_override support
      platform/x86: wmi: Add bus ABI documentation

Bjorn Andersson (1):
      dt-bindings: platform: Add Lenovo Yoga C630 EC

Dan Carpenter (1):
      platform/x86/intel/tpmi/plr: Fix output in plr_print_bits()

Devin Bayer (1):
      platform/x86: asus-wmi: support the disable camera LED on F10 of Zenbook 2023

Dmitry Baryshkov (3):
      platform: arm64: add Lenovo Yoga C630 WOS EC driver
      platform/arm64: build drivers even on non-ARM64 platforms
      platform: arm64: lenovo-yoga-c630: select AUXILIARY_BUS

Geert Uytterhoeven (2):
      platform: arm64: EC_ACER_ASPIRE1 should depend on ARCH_QCOM
      platform: arm64: EC_LENOVO_YOGA_C630 should depend on ARCH_QCOM

Gergo Koteles (1):
      platform/x86: ideapad-laptop: use cleanup.h

Ilpo Järvinen (5):
      Merge branch 'pdx86/platform-drivers-x86-lenovo-c630' into review-ilpo
      Merge branch 'pdx86/platform-drivers-x86-lenovo-c630' into review-ilpo
      Merge branch 'pdx86/platform-drivers-x86-lenovo-c630' into review-ilpo
      Merge remote-tracking branch 'intel-speed-select/intel-sst' into review-ilpo
      Docs/admin-guide: Remove pmf leftover reference from the index

Luke D. Jones (1):
      platform/x86: asus-wmi: fix TUF laptop RGB variant

Lyndon Sanche (3):
      platform/x86: dell-smbios: Add helper for checking supported class
      platform/x86: dell-smbios: Move request functions for reuse
      platform/x86: dell-pc: Implement platform_profile

Shyam Sundar S K (2):
      platform/x86/amd/pmf: Use existing input event codes to update system states
      platform/x86/amd/pmf: Remove update system state document

Srinivas Pandruvada (6):
      platform/x86: ISST: Add model specific loading for common module
      platform/x86: ISST: Avoid some SkyLake server models
      platform/x86: ISST: Use only TPMI interface when present
      platform/x86/intel: TPMI domain id and CPU mapping
      tools/power/x86/intel-speed-select: Set TRL MSR in 100 MHz units
      tools/power/x86/intel-speed-select: v1.20 release

Tero Kristo (12):
      platform/x86/intel/tpmi: Add support for performance limit reasons
      platform/x86/intel/tpmi: Add API to get debugfs root
      platform/x86/intel/tpmi: Add new auxiliary driver for performance limits
      platform/x86/intel/tpmi/plr: Add support for the plr mailbox
      doc: TPMI: Add entry for Performance Limit Reasons
      platform/x86/intel-uncore-freq: Re-arrange bit masks
      platform/x86/intel-uncore-freq: Get rid of magic values
      platform/x86/intel-uncore-freq: Get rid of magic min_max argument
      platform/x86/intel-uncore-freq: Use uncore_index with read_control_freq
      platform/x86/intel-uncore-freq: Get rid of uncore_read_freq driver API
      platform/x86/intel-uncore-freq: Rename the sysfs helper macro names
      platform/x86/intel-uncore-freq: Use generic helpers for current frequency

Thomas Weißschuh (1):
      platform/x86: dell-pc: avoid double free and invalid unregistration

Thorsten Blum (1):
      platform/x86/amd/pmf: Use memdup_user()

Tony Luck (10):
      platform/x86/intel/pmc: Switch to new Intel CPU model defines
      platform/x86: intel_telemetry: Switch to new Intel CPU model defines
      x86/platform/atom: Switch to new Intel CPU model defines
      platform/x86: p2sb: Switch to new Intel CPU model defines
      platform/x86: intel_turbo_max_3: Switch to new Intel CPU model defines
      platform/x86: intel_ips: Switch to new Intel CPU model defines
      platform/x86: intel-uncore-freq: Switch to new Intel CPU model defines
      platform/x86: intel_speed_select_if: Switch to new Intel CPU model defines
      platform/x86: intel_scu_wdt: Switch to new Intel CPU model defines
      platform/x86/intel/ifs: Switch to new Intel CPU model defines

Xi Pardee (9):
      platform/x86:intel/pmc: Use the return value of pmc_core_send_msg
      platform/x86:intel/pmc: Simplify mutex usage with cleanup helpers
      platform/x86:intel/pmc: Convert index variables to be unsigned
      platform/x86:intel/pmc: Move pmc assignment closer to first usage
      platform/x86:intel/pmc: Add support to show ltr_ignore value
      platform/x86:intel/pmc: Remove unneeded min_t check
      platform/x86:intel/pmc: Use DEFINE_SHOW_STORE_ATTRIBUTE macro
      platform/x86:intel/pmc: Use the Elvis operator
      platform/x86:intel/pmc: Add support to undo ltr_ignore

 Documentation/ABI/testing/debugfs-tpmi             |   9 +
 Documentation/ABI/testing/sysfs-bus-wmi            |  81 +++++
 Documentation/admin-guide/index.rst                |   1 -
 Documentation/admin-guide/pmf.rst                  |  24 --
 .../bindings/platform/lenovo,yoga-c630-ec.yaml     |  83 +++++
 MAINTAINERS                                        |   7 +
 arch/x86/platform/atom/punit_atom_debug.c          |  11 +-
 drivers/platform/Makefile                          |   2 +-
 drivers/platform/arm64/Kconfig                     |  17 +
 drivers/platform/arm64/Makefile                    |   1 +
 drivers/platform/arm64/lenovo-yoga-c630.c          | 291 +++++++++++++++++
 drivers/platform/x86/amd/pmf/pmf.h                 |   2 +
 drivers/platform/x86/amd/pmf/tee-if.c              |  73 +++--
 drivers/platform/x86/asus-tf103c-dock.c            |  10 +-
 drivers/platform/x86/asus-wmi.c                    |  41 ++-
 drivers/platform/x86/dell/Kconfig                  |  13 +
 drivers/platform/x86/dell/Makefile                 |   1 +
 drivers/platform/x86/dell/dell-laptop.c            |  23 --
 drivers/platform/x86/dell/dell-pc.c                | 309 ++++++++++++++++++
 drivers/platform/x86/dell/dell-smbios-base.c       |  35 ++
 drivers/platform/x86/dell/dell-smbios.h            |   7 +
 drivers/platform/x86/hp/Kconfig                    |   1 +
 .../platform/x86/hp/hp-bioscfg/enum-attributes.c   |  18 +-
 .../platform/x86/hp/hp-bioscfg/int-attributes.c    |   7 +-
 .../x86/hp/hp-bioscfg/order-list-attributes.c      |  18 +-
 .../x86/hp/hp-bioscfg/passwdobj-attributes.c       |  19 +-
 .../platform/x86/hp/hp-bioscfg/spmobj-attributes.c |   3 +-
 .../platform/x86/hp/hp-bioscfg/string-attributes.c |  12 +-
 drivers/platform/x86/hp/hp-wmi.c                   | 188 ++++++++++-
 drivers/platform/x86/ideapad-laptop.c              |  71 ++---
 drivers/platform/x86/intel/Kconfig                 |  11 +
 drivers/platform/x86/intel/Makefile                |   4 +
 drivers/platform/x86/intel/chtwc_int33fe.c         |   6 +-
 drivers/platform/x86/intel/ifs/core.c              |  15 +-
 drivers/platform/x86/intel/intel_plr_tpmi.c        | 354 +++++++++++++++++++++
 drivers/platform/x86/intel/pmc/core.c              | 262 +++++++--------
 drivers/platform/x86/intel/pmc/pltdrv.c            |  16 +-
 .../x86/intel/speed_select_if/isst_if_common.c     |  75 +++--
 .../x86/intel/speed_select_if/isst_if_common.h     |   3 +
 .../x86/intel/speed_select_if/isst_if_mbox_msr.c   |   4 +-
 drivers/platform/x86/intel/telemetry/debugfs.c     |   4 +-
 drivers/platform/x86/intel/telemetry/pltdrv.c      |   4 +-
 drivers/platform/x86/intel/tpmi.c                  |  11 +
 drivers/platform/x86/intel/tpmi_power_domains.c    | 235 ++++++++++++++
 drivers/platform/x86/intel/tpmi_power_domains.h    |  18 ++
 drivers/platform/x86/intel/turbo_max_3.c           |   4 +-
 .../uncore-frequency/uncore-frequency-common.c     |  83 ++---
 .../uncore-frequency/uncore-frequency-common.h     |  13 +-
 .../intel/uncore-frequency/uncore-frequency-tpmi.c | 101 ++++--
 .../x86/intel/uncore-frequency/uncore-frequency.c  | 108 ++++---
 drivers/platform/x86/intel_ips.c                   |   3 +-
 drivers/platform/x86/intel_scu_wdt.c               |   2 +-
 drivers/platform/x86/p2sb.c                        |   2 +-
 drivers/platform/x86/serial-multi-instantiate.c    |   4 +-
 drivers/platform/x86/think-lmi.c                   |   4 +-
 drivers/platform/x86/thinkpad_acpi.c               |   6 +-
 drivers/platform/x86/wmi.c                         |  33 ++
 include/linux/intel_tpmi.h                         |   2 +
 include/linux/platform_data/lenovo-yoga-c630.h     |  44 +++
 include/linux/platform_data/x86/asus-wmi.h         |   4 +
 include/linux/wmi.h                                |   4 +
 tools/power/x86/intel-speed-select/isst-config.c   |   2 +-
 tools/power/x86/intel-speed-select/isst-core.c     |   6 +
 63 files changed, 2301 insertions(+), 524 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-wmi
 delete mode 100644 Documentation/admin-guide/pmf.rst
 create mode 100644 Documentation/devicetree/bindings/platform/lenovo,yoga-c630-ec.yaml
 create mode 100644 drivers/platform/arm64/lenovo-yoga-c630.c
 create mode 100644 drivers/platform/x86/dell/dell-pc.c
 create mode 100644 drivers/platform/x86/intel/intel_plr_tpmi.c
 create mode 100644 drivers/platform/x86/intel/tpmi_power_domains.c
 create mode 100644 drivers/platform/x86/intel/tpmi_power_domains.h
 create mode 100644 include/linux/platform_data/lenovo-yoga-c630.h


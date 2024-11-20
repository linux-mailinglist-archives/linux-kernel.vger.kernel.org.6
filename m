Return-Path: <linux-kernel+bounces-415669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5854A9D39AF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8446B2551B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2F61A071C;
	Wed, 20 Nov 2024 11:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IiKAU+Ra"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BC21A0AF2;
	Wed, 20 Nov 2024 11:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732102936; cv=none; b=eRiX88wLu9SNePHTGNBme7mWEkpZ6majKDgH+bynSFVy+kzv0b8Wq2yzxUxAMV8k5/6VYvfHW2dOMF1bAlb3x/rXb5kUQiXg4RonFE/UAuYYO3v2Vpgf30XkVHVFDJUGJqKv6ZIwNJmOZQEBoy7hii4e1lqaiW08F+PFW2oGUGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732102936; c=relaxed/simple;
	bh=SIfBdxwYLAtQwaiMLRuuaCrPOl63jg2If8LtS7GpokM=;
	h=From:To:Cc:Date:Subject:Message-ID:MIME-Version:Content-Type; b=TuWM9+2Qt2HQpQy00pBsPyEcySIcSFZXsXNGOASQh/rW3mJV8ymCxcNJJxH8CUV+ELkf1d82K3VSa70pQPhh5OqzXl6C351i7IMKbJ7IoAD3+zy87oYPC3DSMtm/lB/VXLivTLLeEfk79tXDYbmmNYuMgX+wzjgqU6gJKnkeC+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IiKAU+Ra; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732102934; x=1763638934;
  h=from:to:cc:date:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=SIfBdxwYLAtQwaiMLRuuaCrPOl63jg2If8LtS7GpokM=;
  b=IiKAU+RaPp8BdRTWH8HSA9WJasDPIR0KlZk09fNz41bHusWt7mW+yBF2
   eXn9fMXyIaBdlfMF2qt6yBEJl8jWsx5AOdRCu8aYe+/KrJvtzCma4/luj
   X9tAeDu6YprE4vQ85xQvmhweKrAUkuJaC+puBM9KiX4XLy344mVx6C4lu
   n+OE1RXwq273QzBXhv76B9QApwKo5sNY0Gfz74fApFM9hyVv105Tn0xH+
   3PDiupCHyX5dzdkafaYp/vHg6Eer6ht6d1syopf+ATm49+M1hdSmxHplb
   0oeuUv51d4zv+Zn+y9tqFfcfMp0wm+q98fF3Ggj0H8sYZI4p4MjSuPKDK
   Q==;
X-CSE-ConnectionGUID: ggqNJJZ0RnOP+62Y1umGRA==
X-CSE-MsgGUID: cbnVFtZfRGW0AL3aFWui7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="31525422"
X-IronPort-AV: E=Sophos;i="6.12,169,1728975600"; 
   d="scan'208";a="31525422"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 03:42:13 -0800
X-CSE-ConnectionGUID: nZVm2iJPTkmkVHWkqV/amQ==
X-CSE-MsgGUID: YD+mjzfDQQyqYJYdPaYLwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,169,1728975600"; 
   d="scan'208";a="89841484"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.15])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 03:42:11 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Date: Wed, 20 Nov 2024 13:30:55 +0200
Subject: [GIT PULL] platform-drivers-x86 for v6.13-1
Message-ID: <pdx86-pr-20241120133055-375032487@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here is the main PDx86 PR for v6.13.

Note there's an expected conflict in this merge window for amd/hsmp.
Given what's merged so far into your tree, it might not trigger yet but
when merging the other change from driver-core.

Highlights:
 - alienware-wmi:	WMAX thermal interface support
 - amd/hsmp:		Split ACPI and platform device based drivers
 - amd/x3d_vcache:	X3D frequency/cache mode switching support
 - asus-wmi:		Thermal policy fixes
 - intel/pmt:		Disable C1 auto-demotion in suspend to allow
			entering the deepest C-states
 - intel-hid:		Fix volume buttons on Thinkpad X12 Detachable
			Tablet Gen 1
 - intel_scu_ipc:	Replace "workaround" with 32-bit IO
 - panasonic-laptop:	Correct *_show() function error handling
 - p2sb:		Gemini Lake P2SB devfn correction
 - think-lmi:		Admin/System certificate authentication support
 - wmi:			Disable WMI devices for shutdown, refactoring
			continues
 - x86-android-tablets:	Vexia EDU ATLA 10 tablet support
 - platform/surface:	Surface Pro 9 5G (Arm/QCOM) support
 - Miscellaneous cleanups / refactoring / improvements

Expected conflicts:
 - hsmp driver split into two vs constifying bin_attribute [1]

[1] https://lore.kernel.org/all/20241107212645.41252436@canb.auug.org.au/

Regards, i.


The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.13-1

for you to fetch changes up to c6a2b4fcec5f2d80b0183fae1117f06127584c28:

  platform/x86: p2sb: Cache correct PCI bar for P2SB on Gemini Lake (2024-11-18 13:53:03 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v6.13-1

Highlights:
 - alienware-wmi:	WMAX thermal interface support
 - amd/hsmp:		Split ACPI and platform device based drivers
 - amd/x3d_vcache:	X3D frequency/cache mode switching support
 - asus-wmi:		Thermal policy fixes
 - intel/pmt:		Disable C1 auto-demotion in suspend to allow
			entering the deepest C-states
 - intel-hid:		Fix volume buttons on Thinkpad X12 Detachable
			Tablet Gen 1
 - intel_scu_ipc:	Replace "workaround" with 32-bit IO
 - panasonic-laptop:	Correct *_show() function error handling
 - p2sb:		Gemini Lake P2SB devfn correction
 - think-lmi:		Admin/System certificate authentication support
 - wmi:			Disable WMI devices for shutdown, refactoring
			continues
 - x86-android-tablets:	Vexia EDU ATLA 10 tablet support
 - platform/surface:	Surface Pro 9 5G (Arm/QCOM) support
 - Miscellaneous cleanups / refactoring / improvements

Expected conflicts:
 - hsmp driver split into two vs constifying bin_attribute [1]

[1] https://lore.kernel.org/all/20241107212645.41252436@canb.auug.org.au/

The following is an automated shortlog grouped by driver:

alienware-wmi:
 -  added force module parameters
 -  added platform profile support
 -  Adds support to Alienware x17 R2
 -  alienware_wmax_command() is now input size agnostic
 -  create_thermal_profile() no longer brute-forces IDs
 -  extends the list of supported models
 -  fixed indentation and clean up
 -  Fix spelling mistake "requieres" -> "requires"
 -  order alienware_quirks[] alphabetically
 -  WMAX interface documentation

amd: amd_3d_vcache:
 -  Add AMD 3D V-Cache optimizer driver
 -  Add sysfs ABI documentation

amd/hsmp:
 -  Add new error code and error logs
 -  Change generic plat_dev name to hsmp_pdev
 -  Change the error type
 -  Convert amd_hsmp_rdwr() to a function pointer
 -  Create hsmp/ directory
 -  Create separate ACPI, plat and common drivers
 -  Create wrapper function init_acpi()
 -  Make hsmp_pdev static instead of global
 -  mark hsmp_msg_desc_table[] as maybe_unused
 -  Move ACPI code to acpi.c
 -  Move platform device specific code to plat.c
 -  Move structure and macros to header file
 -  Use dev_groups in the driver structure
 -  Use name space while exporting module symbols

amd/pmf:
 -  Switch to platform_get_resource() and devm_ioremap_resource()
 -  Use dev_err_probe() to simplify error handling

asus-laptop:
 -  prefer strscpy() over strcpy()

asus-wmi:
 -  Fix inconsistent use of thermal policies
 -  Use platform_profile_cycle()

classmate-laptop:
 -  Replace snprintf in show functions with sysfs_emit

compal-laptop:
 -  use sysfs_emit() instead of sprintf()

dell-dcdbase:
 -  Replace snprintf in show functions with sysfs_emit

Documentation: alienware-wmi:
 -  Describe THERMAL_INFORMATION operation 0x02

eeepc-laptop:
 -  use sysfs_emit() instead of sprintf()

hp: hp-bioscfg:
 -  remove redundant if statement

intel:
 -  Add 'intel' prefix to the modules automatically

intel-hid:
 -  fix volume buttons on Thinkpad X12 Detachable Tablet Gen 1

intel/pmc:
 -  Disable C1 auto-demotion during suspend
 -  Refactor platform resume functions to use cnl_resume()

intel/pmt:
 -  allow user offset for PMT callbacks
 -  Correct the typo 'ACCCESS_LOCAL'

intel_scu_ipc:
 -  Convert to check for errors first
 -  Don't use "proxy" headers
 -  Replace workaround by 32-bit IO
 -  Save a copy of the entire struct intel_scu_ipc_data
 -  Simplify code with cleanup helpers
 -  Unify the flow in pwr_reg_rdwr()

intel/vsec:
 -  Remove a useless mutex

MAINTAINERS:
 -  adjust file entry in INTEL TPMI DRIVER
 -  Change AMD PMF driver status to "Supported"
 -  Update ISHTP ECLITE maintainer entry

p2sb:
 -  Cache correct PCI bar for P2SB on Gemini Lake

panasonic-laptop:
 -  Return errno correctly in show callback

surface: aggregator_registry:
 -  Add Surface Pro 9 5G

Switch back to struct platform_driver::
 - remove()

think-lmi:
 -  Add certificate as mechanism
 -  Allow empty admin password
 -  improve check if BIOS account security enabled
 -  Multi-certificate support

wmi:
 -  Implement proper shutdown handling
 -  Introduce to_wmi_driver()
 -  Remove wmi_block_list
 -  Replace dev_to_wdev() with to_wmi_device()

x86: acer-wmi:
 -  remove unused macros

x86-android-tablets:
 -  Add get_i2c_adap_by_handle() helper
 -  Add support for getting i2c_adapter by PCI parent devname()
 -  Add support for Vexia EDU ATLA 10 tablet

----------------------------------------------------------------
Abdul Rahim (1):
      asus-laptop: prefer strscpy() over strcpy()

Andy Shevchenko (7):
      platform/x86: intel_scu_ipc: Don't use "proxy" headers
      platform/x86: intel_scu_ipc: Unify the flow in pwr_reg_rdwr()
      platform/x86: intel_scu_ipc: Replace workaround by 32-bit IO
      platform/x86: intel_scu_ipc: Simplify code with cleanup helpers
      platform/x86: intel_scu_ipc: Convert to check for errors first
      platform/x86: intel_scu_ipc: Save a copy of the entire struct intel_scu_ipc_data
      platform/x86: intel: Add 'intel' prefix to the modules automatically

Armin Wolf (6):
      platform/x86: wmi: Implement proper shutdown handling
      platform/x86: wmi: Remove wmi_block_list
      platform/x86: wmi: Replace dev_to_wdev() with to_wmi_device()
      platform/x86: wmi: Introduce to_wmi_driver()
      platform/x86: asus-wmi: Fix inconsistent use of thermal policies
      platform/x86: asus-wmi: Use platform_profile_cycle()

Arnd Bergmann (1):
      platform/x86/amd/hsmp: mark hsmp_msg_desc_table[] as maybe_unused

Ba Jing (1):
      x86: acer-wmi: remove unused macros

Basavaraj Natikar (2):
      platform/x86/amd: amd_3d_vcache: Add AMD 3D V-Cache optimizer driver
      platform/x86/amd: amd_3d_vcache: Add sysfs ABI documentation

Christophe JAILLET (1):
      platform/x86/intel/vsec: Remove a useless mutex

Cole Stowell (1):
      intel-hid: fix volume buttons on Thinkpad X12 Detachable Tablet Gen 1

Colin Ian King (2):
      alienware-wmi: Fix spelling mistake "requieres" -> "requires"
      platform/x86: hp: hp-bioscfg: remove redundant if statement

David E. Box (2):
      platform/x86/intel/pmc: Refactor platform resume functions to use cnl_resume()
      platform/x86/intel/pmc: Disable C1 auto-demotion during suspend

Hans de Goede (4):
      platform/x86: x86-android-tablets: Add get_i2c_adap_by_handle() helper
      platform/x86: x86-android-tablets: Add support for getting i2c_adapter by PCI parent devname()
      platform/x86: x86-android-tablets: Add support for Vexia EDU ATLA 10 tablet
      platform/x86: p2sb: Cache correct PCI bar for P2SB on Gemini Lake

Hongling Zeng (2):
      platform/x86: classmate-laptop: Replace snprintf in show functions with sysfs_emit
      platform/x86: dell-dcdbase: Replace snprintf in show functions with sysfs_emit

Jérôme de Bretagne (1):
      platform/surface: aggregator_registry: Add Surface Pro 9 5G

Kurt Borja (10):
      alienware-wmi: fixed indentation and clean up
      alienware-wmi: alienware_wmax_command() is now input size agnostic
      alienware-wmi: added platform profile support
      alienware-wmi: added force module parameters
      alienware-wmi: WMAX interface documentation
      alienware-wmi: order alienware_quirks[] alphabetically
      alienware-wmi: extends the list of supported models
      alienware-wmi: Adds support to Alienware x17 R2
      alienware-wmi: create_thermal_profile() no longer brute-forces IDs
      Documentation: alienware-wmi: Describe THERMAL_INFORMATION operation 0x02

Lukas Bulwahn (1):
      MAINTAINERS: adjust file entry in INTEL TPMI DRIVER

Mark Pearson (4):
      platform/x86: think-lmi: improve check if BIOS account security enabled
      platform/x86: think-lmi: Add certificate as mechanism
      platform/x86: think-lmi: Allow empty admin password
      platform/x86: think-lmi: Multi-certificate support

Michael J. Ruhl (1):
      platform/x86/intel/pmt: allow user offset for PMT callbacks

Shyam Sundar S K (3):
      platform/x86/amd/pmf: Use dev_err_probe() to simplify error handling
      MAINTAINERS: Change AMD PMF driver status to "Supported"
      platform/x86/amd/pmf: Switch to platform_get_resource() and devm_ioremap_resource()

Srinivas Pandruvada (1):
      MAINTAINERS: Update ISHTP ECLITE maintainer entry

Suma Hegde (13):
      platform/x86/amd/hsmp: Create hsmp/ directory
      platform/x86/amd/hsmp: Create wrapper function init_acpi()
      platform/x86/amd/hsmp: Convert amd_hsmp_rdwr() to a function pointer
      platform/x86/amd/hsmp: Move structure and macros to header file
      platform/x86/amd/hsmp: Move platform device specific code to plat.c
      platform/x86/amd/hsmp: Move ACPI code to acpi.c
      platform/x86/amd/hsmp: Change generic plat_dev name to hsmp_pdev
      platform/x86/amd/hsmp: Create separate ACPI, plat and common drivers
      platform/x86/amd/hsmp: Use name space while exporting module symbols
      platform/x86/amd/hsmp: Use dev_groups in the driver structure
      platform/x86/amd/hsmp: Make hsmp_pdev static instead of global
      platform/x86/amd/hsmp: Add new error code and error logs
      platform/x86/amd/hsmp: Change the error type

Uwe Kleine-König (1):
      platform/x86: Switch back to struct platform_driver::remove()

WangYuli (1):
      platform/x86/intel/pmt: Correct the typo 'ACCCESS_LOCAL'

Yao Zi (1):
      platform/x86: panasonic-laptop: Return errno correctly in show callback

chen zhang (2):
      platform/x86: eeepc-laptop: use sysfs_emit() instead of sprintf()
      platform/x86: compal-laptop: use sysfs_emit() instead of sprintf()

 .../sysfs-bus-platform-drivers-amd_x3d_vcache      |  12 +
 .../ABI/testing/sysfs-class-firmware-attributes    |   3 +-
 Documentation/arch/x86/amd_hsmp.rst                |  67 +-
 Documentation/wmi/devices/alienware-wmi.rst        | 397 +++++++++
 Documentation/wmi/driver-development-guide.rst     |   7 +-
 MAINTAINERS                                        |  17 +-
 arch/x86/include/uapi/asm/amd_hsmp.h               |   3 +-
 .../platform/surface/surface_aggregator_registry.c |  19 +-
 drivers/platform/x86/acer-wmi.c                    |   7 +-
 drivers/platform/x86/adv_swbutton.c                |   2 +-
 drivers/platform/x86/amd/Kconfig                   |  18 +-
 drivers/platform/x86/amd/Makefile                  |   5 +-
 drivers/platform/x86/amd/hsmp.c                    | 988 ---------------------
 drivers/platform/x86/amd/hsmp/Kconfig              |  47 +
 drivers/platform/x86/amd/hsmp/Makefile             |  12 +
 drivers/platform/x86/amd/hsmp/acpi.c               | 378 ++++++++
 drivers/platform/x86/amd/hsmp/hsmp.c               | 408 +++++++++
 drivers/platform/x86/amd/hsmp/hsmp.h               |  66 ++
 drivers/platform/x86/amd/hsmp/plat.c               | 338 +++++++
 drivers/platform/x86/amd/pmc/pmc.c                 |   2 +-
 drivers/platform/x86/amd/pmf/Kconfig               |   1 +
 drivers/platform/x86/amd/pmf/acpi.c                |  46 +-
 drivers/platform/x86/amd/pmf/core.c                |  10 +-
 drivers/platform/x86/amd/pmf/pmf.h                 |   6 +-
 drivers/platform/x86/amd/pmf/tee-if.c              |   8 +-
 drivers/platform/x86/amd/x3d_vcache.c              | 176 ++++
 drivers/platform/x86/amilo-rfkill.c                |   6 +-
 drivers/platform/x86/asus-laptop.c                 |   4 +-
 drivers/platform/x86/asus-wmi.c                    |  90 +-
 drivers/platform/x86/barco-p50-gpio.c              |   2 +-
 drivers/platform/x86/classmate-laptop.c            |   7 +-
 drivers/platform/x86/compal-laptop.c               |  61 +-
 drivers/platform/x86/dell/Kconfig                  |   1 +
 drivers/platform/x86/dell/alienware-wmi.c          | 577 ++++++++++--
 drivers/platform/x86/dell/dcdbas.c                 |  13 +-
 drivers/platform/x86/dell/dell-smo8800.c           |   2 +-
 drivers/platform/x86/dell/dell-uart-backlight.c    |   2 +-
 drivers/platform/x86/eeepc-laptop.c                |   9 +-
 .../x86/hp/hp-bioscfg/passwdobj-attributes.c       |  11 +-
 drivers/platform/x86/hp/hp-wmi.c                   |   2 +-
 drivers/platform/x86/hp/hp_accel.c                 |   2 +-
 drivers/platform/x86/hp/tc1100-wmi.c               |   2 +-
 drivers/platform/x86/huawei-wmi.c                  |   2 +-
 drivers/platform/x86/ideapad-laptop.c              |   2 +-
 drivers/platform/x86/intel/Makefile                |  68 +-
 drivers/platform/x86/intel/bxtwc_tmu.c             |   2 +-
 drivers/platform/x86/intel/bytcrc_pwrsrc.c         |   2 +-
 drivers/platform/x86/intel/chtdc_ti_pwrbtn.c       |   2 +-
 drivers/platform/x86/intel/chtwc_int33fe.c         |   2 +-
 drivers/platform/x86/intel/hid.c                   |   9 +-
 drivers/platform/x86/intel/int0002_vgpio.c         |   4 +-
 drivers/platform/x86/intel/int1092/intel_sar.c     |   2 +-
 drivers/platform/x86/intel/int3472/discrete.c      |   2 +-
 drivers/platform/x86/intel/mrfld_pwrbtn.c          |   2 +-
 .../x86/intel/{intel_plr_tpmi.c => plr_tpmi.c}     |   0
 drivers/platform/x86/intel/pmc/arl.c               |   3 +-
 drivers/platform/x86/intel/pmc/cnp.c               |  53 ++
 drivers/platform/x86/intel/pmc/core.c              |   2 +-
 drivers/platform/x86/intel/pmc/lnl.c               |   3 +-
 drivers/platform/x86/intel/pmc/mtl.c               |   3 +-
 drivers/platform/x86/intel/pmt/class.c             |  10 +-
 drivers/platform/x86/intel/pmt/class.h             |   2 +-
 drivers/platform/x86/intel/pmt/telemetry.c         |   2 +-
 drivers/platform/x86/intel/telemetry/pltdrv.c      |   2 +-
 drivers/platform/x86/intel/vbtn.c                  |   2 +-
 drivers/platform/x86/intel/vsec.c                  |   6 -
 drivers/platform/x86/intel/{tpmi.c => vsec_tpmi.c} |   2 +-
 drivers/platform/x86/intel_scu_ipc.c               | 140 ++-
 .../x86/lenovo-yoga-tab2-pro-1380-fastcharger.c    |   2 +-
 drivers/platform/x86/lenovo-yogabook.c             |   2 +-
 drivers/platform/x86/mlx-platform.c                |   2 +-
 drivers/platform/x86/p2sb.c                        |   1 +
 drivers/platform/x86/panasonic-laptop.c            |  10 +-
 drivers/platform/x86/samsung-q10.c                 |   2 +-
 drivers/platform/x86/sel3350-platform.c            |   2 +-
 drivers/platform/x86/serial-multi-instantiate.c    |   2 +-
 .../x86/siemens/simatic-ipc-batt-apollolake.c      |   2 +-
 .../x86/siemens/simatic-ipc-batt-elkhartlake.c     |   2 +-
 .../platform/x86/siemens/simatic-ipc-batt-f7188x.c |   2 +-
 drivers/platform/x86/siemens/simatic-ipc-batt.c    |   2 +-
 drivers/platform/x86/think-lmi.c                   | 149 +++-
 drivers/platform/x86/think-lmi.h                   |   6 +-
 drivers/platform/x86/wmi.c                         |  98 +-
 drivers/platform/x86/x86-android-tablets/Kconfig   |   4 +-
 drivers/platform/x86/x86-android-tablets/core.c    |  60 +-
 drivers/platform/x86/x86-android-tablets/dmi.c     |  10 +
 drivers/platform/x86/x86-android-tablets/other.c   | 163 ++++
 .../x86/x86-android-tablets/x86-android-tablets.h  |   2 +
 drivers/platform/x86/xo1-rfkill.c                  |   2 +-
 include/linux/intel_vsec.h                         |   3 +-
 include/linux/platform_data/x86/intel_scu_ipc.h    |   4 +
 include/linux/wmi.h                                |  12 +-
 92 files changed, 3192 insertions(+), 1515 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-platform-drivers-amd_x3d_vcache
 create mode 100644 Documentation/wmi/devices/alienware-wmi.rst
 delete mode 100644 drivers/platform/x86/amd/hsmp.c
 create mode 100644 drivers/platform/x86/amd/hsmp/Kconfig
 create mode 100644 drivers/platform/x86/amd/hsmp/Makefile
 create mode 100644 drivers/platform/x86/amd/hsmp/acpi.c
 create mode 100644 drivers/platform/x86/amd/hsmp/hsmp.c
 create mode 100644 drivers/platform/x86/amd/hsmp/hsmp.h
 create mode 100644 drivers/platform/x86/amd/hsmp/plat.c
 create mode 100644 drivers/platform/x86/amd/x3d_vcache.c
 rename drivers/platform/x86/intel/{intel_plr_tpmi.c => plr_tpmi.c} (100%)
 rename drivers/platform/x86/intel/{tpmi.c => vsec_tpmi.c} (99%)


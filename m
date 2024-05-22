Return-Path: <linux-kernel+bounces-186390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EFA8CC38C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E76142848CD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149E421342;
	Wed, 22 May 2024 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NBH8XJN0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADEE20DC4
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 14:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716389465; cv=none; b=qbBp0GFcyXfGXgwsa12Ab/FCgjrON/AJdR9jTwi58ws8yVThYK988Fq4HPzcsk/QIAaX5rkDjBUmZtUcwRgtiJF0UBQFvBpWL3p5Odp/eEhc3NP88V5YKS5SeFSqQnKDARDpo5FrHNISb7KgCqwwm9HEw96mV50ZvQhfpZddPPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716389465; c=relaxed/simple;
	bh=CyUsF2GAcGsDiIiqTHkp6kXt+eKEwDnbDEmyd3Sc4KE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=W313CbJqhCwrZzew05X1geKxdCVNrRFxqE4bDmqtEGBEEKK0IJAqnx9q/7uZ2QG6lCpdvp/Wi9IhD/IaABMX7c52c13AlK7cPKdpLHWiisGpxSkLLAz/75bIYxjReLjDYR9y1D3I2N9pCfOqvogCqbISiGLe48h/DABdxlRgHx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NBH8XJN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A941C2BBFC;
	Wed, 22 May 2024 14:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716389464;
	bh=CyUsF2GAcGsDiIiqTHkp6kXt+eKEwDnbDEmyd3Sc4KE=;
	h=Date:From:To:Cc:Subject:From;
	b=NBH8XJN0YdX5ACMJfqIqtuL53hbrMnNkUdjkIL/I+x39fF867Wz18yjvDdVdcpJ8S
	 sLg+vzrwgGX14g0SVgD5EnCLNRb1W2DDOdDnyKagh0gmNDDA1tBkRKzkXcC8vjXTlj
	 lT+jGtRCsRsbd6wx8dyC9HVUr1XHsN+REkBbn5vE=
Date: Wed, 22 May 2024 16:51:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core changes for 6.10-rc1
Message-ID: <Zk4GVrHOXfnw5kl_@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit ed30a4a51bb196781c8058073ea720133a65596f:

  Linux 6.9-rc5 (2024-04-21 12:35:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.10-rc1

for you to fetch changes up to 880a746fa3ea5916a012fa320fdfbcd3f331bea3:

  device property: Fix a typo in the description of device_get_child_node_count() (2024-05-05 08:34:06 +0200)

----------------------------------------------------------------
Driver core changes for 6.10-rc1

Here is the small set of driver core and kernfs changes for 6.10-rc1.

Nothing major here at all, just a small set of changes for some driver
core apis, and minor fixups.  Included in here are:
  - sysfs_bin_attr_simple_read() helper added and used
  - device_show_string() helper added and used
All usages of these were acked by the various maintainers.  Also in here
are:
  - kernfs minor cleanup
  - removed unused functions
  - typo fix in documentation
  - pay attention to sysfs_create_link() failures in module.c finally.

All of these have been in linux-next for a very long time with no
reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Arnd Bergmann (1):
      module: don't ignore sysfs_create_link() failures

Bjorn Helgaas (1):
      driver core: Remove unused platform_notify, platform_notify_remove

Christophe JAILLET (1):
      device property: Fix a typo in the description of device_get_child_node_count()

Greg Kroah-Hartman (1):
      Merge 6.9-rc5 into driver-core-next

Li zeming (1):
      kernfs: mount: Remove unnecessary ‘NULL’ values from knparent

Lukas Wunner (8):
      sysfs: Add sysfs_bin_attr_simple_read() helper
      treewide: Use sysfs_bin_attr_simple_read() helper
      driver core: Add device_show_string() helper for sysfs attributes
      hwmon: Use device_show_string() helper for sysfs attributes
      IB/qib: Use device_show_string() helper for sysfs attributes
      perf: Use device_show_string() helper for sysfs attributes
      platform/x86: Use device_show_string() helper for sysfs attributes
      scsi: Use device_show_string() helper for sysfs attributes

 arch/powerpc/perf/hv-24x7.c                        | 10 ----
 arch/powerpc/platforms/powernv/opal.c              | 10 +---
 arch/x86/events/intel/core.c                       | 13 ++---
 drivers/acpi/bgrt.c                                |  9 +---
 drivers/base/base.h                                |  9 ++--
 drivers/base/bus.c                                 |  9 +++-
 drivers/base/core.c                                | 17 +++---
 drivers/base/module.c                              | 42 +++++++++++----
 drivers/base/property.c                            |  2 +-
 drivers/firmware/dmi_scan.c                        | 12 +----
 drivers/firmware/efi/rci2-table.c                  | 10 +---
 drivers/gpu/drm/i915/gvt/firmware.c                | 26 +++------
 drivers/hwmon/i5k_amb.c                            | 15 ++----
 drivers/hwmon/ibmpex.c                             | 14 ++---
 drivers/infiniband/hw/qib/qib.h                    |  1 -
 drivers/infiniband/hw/qib/qib_driver.c             |  6 ---
 drivers/infiniband/hw/qib/qib_sysfs.c              | 10 +---
 drivers/perf/alibaba_uncore_drw_pmu.c              | 12 +----
 drivers/perf/arm-cci.c                             | 12 +----
 drivers/perf/arm-ccn.c                             | 11 +---
 drivers/perf/arm_cspmu/arm_cspmu.c                 | 10 ----
 drivers/perf/arm_cspmu/arm_cspmu.h                 |  7 +--
 drivers/perf/arm_dsu_pmu.c                         | 11 +---
 drivers/perf/cxl_pmu.c                             | 13 +----
 drivers/perf/hisilicon/hisi_pcie_pmu.c             | 13 +----
 drivers/perf/hisilicon/hisi_uncore_pmu.c           | 14 -----
 drivers/perf/hisilicon/hisi_uncore_pmu.h           |  4 +-
 drivers/perf/hisilicon/hns3_pmu.c                  | 12 +----
 drivers/perf/qcom_l3_pmu.c                         | 11 +---
 drivers/perf/xgene_pmu.c                           | 11 +---
 drivers/platform/x86/asus-wmi.c                    | 62 ++++++----------------
 drivers/platform/x86/thinkpad_acpi.c               | 10 +---
 drivers/platform/x86/toshiba_acpi.c                |  9 +---
 drivers/scsi/bfa/bfad_attr.c                       | 28 +++-------
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c           | 11 +---
 drivers/scsi/mvsas/mv_init.c                       | 10 +---
 drivers/scsi/qla2xxx/qla_attr.c                    | 11 +---
 drivers/scsi/smartpqi/smartpqi_init.c              | 11 ++--
 .../intel/int340x_thermal/int3400_thermal.c        |  9 +---
 fs/kernfs/mount.c                                  |  2 +-
 fs/sysfs/file.c                                    | 27 ++++++++++
 include/linux/device.h                             | 26 +++++----
 include/linux/sysfs.h                              | 15 ++++++
 init/initramfs.c                                   | 10 +---
 kernel/module/sysfs.c                              | 13 +----
 45 files changed, 188 insertions(+), 422 deletions(-)


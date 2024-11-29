Return-Path: <linux-kernel+bounces-425225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 832DF9DBF12
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 05:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 156D7164ADE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 04:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E17155CBD;
	Fri, 29 Nov 2024 04:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y7+AZP0p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69613155757
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 04:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732854981; cv=none; b=fn2yzq758itohyY+crHk/z9+j/AW6Szz+fR/nNCAE+lIrDNqHoVehQVFVY/ngZSQlH5X0EyrQVJKpC/la5nWBdsd9jv+B4/3fWc+VsaPVPqN0xbFjWFa8LWR/v8TQjiV0yfjKL9WI5abuMRCyu4wm9rA0JfPtVPeQxz4NVFJfP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732854981; c=relaxed/simple;
	bh=ftvjNW/qqlsXSWpCGDd6GK1tITHG7aa6palFLNYveak=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=risi+G9yeXde/pcUsjcZYy0j1mDIZW0R3KNMWEc5yevQXwzjYISFSXOQyeIXPeX6d9/DZbTwPtEZnsi181pZjQP4Qq7/C+UW27GfB6nIwUfP64d9G1K4sdkrWs1mfLRAoQx26AIzIu/5di986Z8zUkNgAAKZ/tFYgKMoIbPmPyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y7+AZP0p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7EBC4CECF;
	Fri, 29 Nov 2024 04:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732854980;
	bh=ftvjNW/qqlsXSWpCGDd6GK1tITHG7aa6palFLNYveak=;
	h=Date:From:To:Cc:Subject:From;
	b=y7+AZP0p/OWgQBFY7kx25jkFtbsRRKSvcV63hK7E6+ak/rvmUjh7q2t+8o7jfCWVk
	 b4JUss7KQbco0Q+nSxx8SZKVg+UPmIR4wGSwnAiwW7YWwGnzsZRkuTaLphQsgPaSju
	 uH0PSK5rjdMjcfxFH432o72mm9lc+8MLXmmMNT0w=
Date: Fri, 29 Nov 2024 05:36:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core changes for 6.13-rc1
Message-ID: <Z0lEwR55Gv4K0GpR@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 59b723cd2adbac2a34fc8e12c74ae26ae45bf230:

  Linux 6.12-rc6 (2024-11-03 14:05:52 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.13-rc1

for you to fetch changes up to acfeb6defcb9310b1ff44db1e633798ba766337d:

  Fix a potential abuse of seq_printf() format string in drivers (2024-11-22 15:31:35 +0100)

----------------------------------------------------------------
Driver core changes for 6.13-rc1

Here is a small set of driver core changes for 6.13-rc1.

Nothing major for this merge cycle, except for the 2 simple merge
conflicts are here just to make life interesting.

Included in here are:
  - sysfs core changes and preparations for more sysfs api cleanups that
    can come through all driver trees after -rc1 is out
  - fw_devlink fixes based on many reports and debugging sessions
  - list_for_each_reverse() removal, no one was using it!
  - last-minute seq_printf() format string bug found and fixed in many
    drivers all at once.
  - minor bugfixes and changes full details in the shortlog

As mentioned above, there is 2 merge conflicts with your tree, one is
where the file is removed (easy enough to resolve), the second is a
build time error, that has been found in linux-next and the fix can be
seen here:
	https://lore.kernel.org/r/20241107212645.41252436@canb.auug.org.au

Other than that, the changes here have been in linux-next with no other
reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Amit Vadhavana (1):
      drivers: core: fw_devlink: Fix excess parameter description in docstring

Bartosz Golaszewski (1):
      driver core: constify devlink class

David Wang (1):
      Fix a potential abuse of seq_printf() format string in drivers

Dr. David Alan Gilbert (1):
      drivers/base: Remove unused auxiliary_find_device

Gaosheng Cui (1):
      firmware_loader: Fix possible resource leak in fw_log_firmware_info()

Geert Uytterhoeven (1):
      driver core: auxiliary bus: Spelling s/pecific/specific/

Greg Kroah-Hartman (1):
      Merge 6.12-rc6 into driver-core-next

Julia Lawall (1):
      firmware_loader: Reorganize kerneldoc parameter names

Keita Morisaki (1):
      devres: Fix page faults when tracing devres from unloaded modules

Nathan Chancellor (1):
      cdx: Fix cdx_mmap_resource() after constifying attr in ->mmap()

Nikolay Borisov (1):
      cacheinfo: Don't opencode per_cpu_cacheinfo()

Rob Herring (Arm) (1):
      cacheinfo: Use of_property_present() for non-boolean properties

Saravana Kannan (4):
      driver core: fw_devlink: Stop trying to optimize cycle detection logic
      drm: display: Set fwnode for aux bus devices
      phy: tegra: xusb: Set fwnode for xusb port devices
      drivers: core: fw_devlink: Make the error message a bit more useful

Thomas Weiﬂschuh (15):
      sysfs: explicitly pass size to sysfs_add_bin_file_mode_ns()
      sysfs: introduce callback attribute_group::bin_size
      PCI/sysfs: Calculate bin_attribute size through bin_size()
      nvmem: core: calculate bin_attribute size through bin_size()
      sysfs: treewide: constify attribute callback of bin_is_visible()
      sysfs: treewide: constify attribute callback of bin_attribute::mmap()
      sysfs: treewide: constify attribute callback of bin_attribute::llseek()
      sysfs: implement all BIN_ATTR_* macros in terms of __BIN_ATTR()
      sysfs: bin_attribute: add const read/write callback variants
      driver core: Constify attribute arguments of binary attributes
      sysfs: attribute_group: allow registration of const bin_attribute
      driver core: Constify bin_attribute definitions
      perf: arm-ni: Remove spurious NULL in attribute_group definition
      s390/con3215: Remove spurious NULL in attribute_group definition
      cpu: Remove spurious NULL in attribute_group definition

Zijun Hu (5):
      list: Remove duplicated and unused macro list_for_each_reverse
      lib: devres: Simplify API devm_iounmap() implementation
      lib: devres: Simplify API devm_ioport_unmap() implementation
      driver core: Put device attribute @wakeup_last_time_ms and its show() together
      driver core: class: Correct WARN() message in APIs class_(for_each|find)_device()

 Documentation/driver-api/auxiliary_bus.rst  |  1 -
 arch/alpha/kernel/pci-sysfs.c               |  6 +-
 drivers/base/auxiliary.c                    | 31 +--------
 drivers/base/cacheinfo.c                    | 15 ++---
 drivers/base/class.c                        |  4 +-
 drivers/base/core.c                         | 63 ++++++++----------
 drivers/base/firmware_loader/main.c         |  7 +-
 drivers/base/node.c                         | 12 ++--
 drivers/base/power/sysfs.c                  | 17 ++---
 drivers/base/topology.c                     | 40 ++++++------
 drivers/base/trace.h                        |  6 +-
 drivers/cdx/cdx.c                           |  2 +-
 drivers/cxl/port.c                          |  2 +-
 drivers/gpio/gpio-aspeed-sgpio.c            |  2 +-
 drivers/gpio/gpio-aspeed.c                  |  2 +-
 drivers/gpio/gpio-ep93xx.c                  |  2 +-
 drivers/gpio/gpio-hlwd.c                    |  2 +-
 drivers/gpio/gpio-mlxbf2.c                  |  2 +-
 drivers/gpio/gpio-omap.c                    |  2 +-
 drivers/gpio/gpio-pca953x.c                 |  2 +-
 drivers/gpio/gpio-pl061.c                   |  2 +-
 drivers/gpio/gpio-tegra.c                   |  2 +-
 drivers/gpio/gpio-tegra186.c                |  2 +-
 drivers/gpio/gpio-tqmx86.c                  |  2 +-
 drivers/gpio/gpio-visconti.c                |  2 +-
 drivers/gpio/gpio-xgs-iproc.c               |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c     |  2 +-
 drivers/gpu/drm/display/drm_dp_aux_bus.c    |  2 +-
 drivers/infiniband/hw/qib/qib_sysfs.c       |  2 +-
 drivers/irqchip/irq-gic.c                   |  2 +-
 drivers/irqchip/irq-mvebu-pic.c             |  2 +-
 drivers/irqchip/irq-versatile-fpga.c        |  2 +-
 drivers/misc/ocxl/sysfs.c                   |  2 +-
 drivers/mtd/spi-nor/sysfs.c                 |  2 +-
 drivers/nvmem/core.c                        | 16 ++++-
 drivers/pci/p2pdma.c                        |  2 +-
 drivers/pci/pci-sysfs.c                     | 42 ++++++------
 drivers/pci/vpd.c                           |  2 +-
 drivers/perf/arm-ni.c                       |  1 -
 drivers/phy/tegra/xusb.c                    |  2 +-
 drivers/pinctrl/bcm/pinctrl-iproc-gpio.c    |  2 +-
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c |  2 +-
 drivers/pinctrl/pinctrl-mcp23s08.c          |  2 +-
 drivers/pinctrl/pinctrl-stmfx.c             |  2 +-
 drivers/pinctrl/pinctrl-sx150x.c            |  2 +-
 drivers/pinctrl/renesas/pinctrl-rzg2l.c     |  2 +-
 drivers/platform/x86/amd/hsmp.c             |  2 +-
 drivers/platform/x86/intel/pmt/class.c      |  2 +-
 drivers/platform/x86/intel/sdsi.c           |  2 +-
 drivers/s390/char/con3215.c                 |  1 -
 drivers/scsi/scsi_sysfs.c                   |  2 +-
 drivers/uio/uio_hv_generic.c                |  2 +-
 drivers/usb/core/sysfs.c                    |  2 +-
 fs/sysfs/file.c                             | 30 ++++++---
 fs/sysfs/group.c                            |  5 +-
 fs/sysfs/sysfs.h                            |  2 +-
 include/linux/auxiliary_bus.h               |  4 --
 include/linux/list.h                        |  8 ---
 include/linux/sysfs.h                       | 99 +++++++++++++++++------------
 kernel/cpu.c                                |  3 -
 lib/devres.c                                |  6 +-
 61 files changed, 242 insertions(+), 253 deletions(-)


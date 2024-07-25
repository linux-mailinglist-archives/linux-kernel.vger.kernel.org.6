Return-Path: <linux-kernel+bounces-261870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 218FB93BD2C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBBB7284DF6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 07:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B677416F8EF;
	Thu, 25 Jul 2024 07:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b7LWHd8h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA283DBB7
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 07:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721892995; cv=none; b=HqMzQSkr3VCsKNHOq2/0EHxFymos6h/H16ZD+bIpqKhU/pvwX8XG1QywKZ4qdRfB+Z6JifddytBqQyF/zwhDuuMavXpIXgEvKPOnD7HnxUKW4UElj32sZ1ZK6IdOngb1XGKPeYNphuRGvwUW6cfJx9zPIFLYfRMY0lo0a4BOLeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721892995; c=relaxed/simple;
	bh=MX8jQyQsqp7hg+EuZaB6Hnj2pG8H5yUsaxm8R3JfyYk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WedEpVCRLjSz8pkFMt21s8SnW48Mw9YcnbKOk3oW8e8iGVvzHyQOEf3M9sDTWBI8i8oVjsrZqHGWAJhfSR92Ggs+Szb0W9DxBlIRgwBlnhFi+gwFip6t1tP+mzfKHEzyuD1HFqpiiVZsjFSBnokvnnT6jSk407U1KKK8TvFcXGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b7LWHd8h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C23C116B1;
	Thu, 25 Jul 2024 07:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721892995;
	bh=MX8jQyQsqp7hg+EuZaB6Hnj2pG8H5yUsaxm8R3JfyYk=;
	h=Date:From:To:Cc:Subject:From;
	b=b7LWHd8haSw7mZ+zx0bkDfl/UQ8GJ1OnTYGHV2ical/ZMHkpF0idXsNnf7KbDq+zn
	 p3iL6b/Sz7RflsrOwBJXHGLVpNf49hlFAvrPjiR1+mn1iwRoqr7KWXE5RFeOxWyxf8
	 nsMnJYYup2YkDwCXZFXlONSWx3ZfUjDsrNaxFThQ=
Date: Thu, 25 Jul 2024 09:36:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core changes for 6.11-rc1
Message-ID: <ZqIAf1uDky0nvwiC@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

***************
This merge request is coming late in the -rc1 cycle on purpose.  I
wanted to make sure that the merge issues and other problems were all
resoved due to some core api changes (platform and bus structures)
happening in this tree.

You will have merge conflicts with your tree when you pull from here in
the following two files:
	drivers/fsi/fsi-occ.c
	drivers/reset/reset-meson-audio-arb.c
the resolution for them should be "obvious", and has been in linux-next
for a while now.

You will also get build errors for the following two platform drivers:
	drivers/net/ethernet/renesas/rtsn.c
	drivers/gpu/drm/stm/lvds.c
due to these new files coming in during the merge window and them not
being in my branch.  They too have fixups that have been in linux-next
for a while.

I have all of the above problems resolved in the following branch:
   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git driver-core-6.11-rc1-merge-resolution
if you want to compare things, OR you can just pull from that point as
well, I can make a signed tag for you there if that makes it simpler.

Sorry for the conflicts,

greg k-h
***************


The following changes since commit 6ba59ff4227927d3a8530fc2973b80e94b54d58f:

  Linux 6.10-rc4 (2024-06-16 13:40:16 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.11-rc1

for you to fetch changes up to b57d5ffc3ab507d0e19fc8b90b19c76af43fb790:

  ARM: sa1100: make match function take a const pointer (2024-07-19 13:47:20 +0200)

----------------------------------------------------------------
Driver core changes for 6.11-rc1

Here is the big set of driver core changes for 6.11-rc1.

Lots of stuff in here, with not a huge diffstat, but apis are evolving
which required lots of files to be touched.  Highlights of the changes
in here are:
  - platform remove callback api final fixups (Uwe took many releases to
    get here, finally!)
  - Rust bindings for basic firmware apis and initial driver-core
    interactions.  It's not all that useful for a "write a whole driver
    in rust" type of thing, but the firmware bindings do help out the
    phy rust drivers, and the driver core bindings give a solid base on
    which others can start their work.  There is still a long way to go
    here before we have a multitude of rust drivers being added, but
    it's a great first step.
  - driver core const api changes.  This reached across all bus types,
    and there are some fix-ups for some not-common bus types that
    linux-next and 0-day testing shook out.  This work is being done to
    help make the rust bindings more safe, as well as the C code, moving
    toward the end-goal of allowing us to put driver structures into
    read-only memory.  We aren't there yet, but are getting closer.
  - minor devres cleanups and fixes found by code inspection
  - arch_topology minor changes
  - other minor driver core cleanups

All of these have been in linux-next for a very long time with no
reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (2):
      driver core: device.h: Group of_node handling declarations and definitions
      driver core: platform: Switch to use kmemdup_array()

Danilo Krummrich (9):
      rust: add abstraction for struct device
      rust: add firmware abstractions
      firmware: rust: improve safety comments
      MAINTAINERS: add Rust FW abstractions to FIRMWARE LOADER
      MAINTAINERS: add Danilo as FIRMWARE LOADER maintainer
      device: rust: improve safety comments
      MAINTAINERS: add Rust device abstractions to DRIVER CORE
      firmware_loader: annotate doctests as `no_run`
      firmware_loader: fix soundness issue in `request_internal`

Geert Uytterhoeven (1):
      dio: Have dio_bus_match() callback take a const *

Greg Kroah-Hartman (16):
      Merge tag 'platform-remove-void-step-b' of https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux into driver-core-next
      nvdimm: make nd_class constant
      auxbus: make to_auxiliary_drv accept and return a constant pointer
      driver core: platform: fix ups for constant struct device_driver
      driver core: driver: mark driver_add/remove_groups constant
      driver core: make device_release_driver_internal() take a const *
      driver core: make driver_detach() take a const *
      driver core: mark async_driver as a const *
      Merge tag 'v6.10-rc4' into driver-core-next
      driver core: make [device_]driver_attach take a const *
      driver core: have match() callback in struct bus_type take a const *
      driver core: make driver_[create|remove]_file take a const *
      driver core: make driver_find_device() take a const *
      driver core: module: make module_[add|remove]_driver take a const *
      zorro: make match function take a const pointer
      ARM: sa1100: make match function take a const pointer

Ivan Orlov (1):
      dca: make dca_class a static const structure

Jeff Johnson (1):
      samples/kobject: add missing MODULE_DESCRIPTION() macros

Petr Tesarik (1):
      sysfs/cpu: Make crash_hotplug attribute world-readable

Ricardo B. Marliere (1):
      parport: make parport_bus_type const

Uwe Kleine-König (19):
      reset: meson-audio-arb: Convert to platform remove callback returning void
      reset: rzg2l-usbphy-ctrl: Convert to platform remove callback returning void
      reset: ti-sci: Convert to platform remove callback returning void
      Merge branch 'reset/next' of git://git.pengutronix.de/pza/linux
      fsi: master-aspeed: Convert to platform remove callback returning void
      fsi: master-ast-cf: Convert to platform remove callback returning void
      fsi: master-gpio: Convert to platform remove callback returning void
      fsi: occ: Convert to platform remove callback returning void
      pps: clients: gpio: Convert to platform remove callback returning void
      gpu: host1x: mipi: Benefit from devm_clk_get_prepared()
      drm/imagination: Convert to platform remove callback returning void
      drm/mediatek: Convert to platform remove callback returning void
      gpu: host1x: Convert to platform remove callback returning void
      gpu: ipu-v3: Convert to platform remove callback returning void
      nvdimm/e820: Convert to platform remove callback returning void
      nvdimm/of_pmem: Convert to platform remove callback returning void
      samples: qmi: Convert to platform remove callback returning void
      platform: Make platform_driver::remove() return void
      driver core: Make dev_err_probe() silent for -ENOMEM

Vincenzo Mezzela (2):
      drivers: arch_topology: Refactor do-while loops
      drivers: arch_topology: use __free attribute instead of of_node_put()

Zijun Hu (5):
      kobject_uevent: Fix OOB access within zap_modalias_env()
      devres: Fix devm_krealloc() wasting memory
      devres: Fix memory leakage caused by driver API devm_free_percpu()
      devres: Initialize an uninitialized struct member
      devres: Correct code style for functions that return a pointer type

 MAINTAINERS                                        |   3 +
 arch/arm/common/locomo.c                           |   4 +-
 arch/arm/common/sa1111.c                           |   4 +-
 arch/arm/include/asm/hardware/locomo.h             |   2 +-
 arch/arm/include/asm/hardware/sa1111.h             |   2 +-
 arch/parisc/include/asm/parisc-device.h            |   2 +-
 arch/parisc/kernel/drivers.c                       |   4 +-
 arch/powerpc/include/asm/ps3.h                     |   6 +-
 arch/powerpc/include/asm/vio.h                     |   6 +-
 arch/powerpc/platforms/ps3/system-bus.c            |   4 +-
 arch/powerpc/platforms/pseries/ibmebus.c           |   2 +-
 arch/powerpc/platforms/pseries/vio.c               |   6 +-
 arch/s390/include/asm/ccwdev.h                     |   2 +-
 arch/sparc/include/asm/vio.h                       |   6 +-
 arch/sparc/kernel/vio.c                            |   4 +-
 drivers/acpi/bus.c                                 |   4 +-
 drivers/amba/bus.c                                 |   6 +-
 drivers/base/arch_topology.c                       | 143 ++++++++++-----------
 drivers/base/auxiliary.c                           |  10 +-
 drivers/base/base.h                                |  16 +--
 drivers/base/core.c                                |  17 ++-
 drivers/base/cpu.c                                 |   4 +-
 drivers/base/dd.c                                  |  30 +++--
 drivers/base/devres.c                              |  34 +++--
 drivers/base/driver.c                              |  10 +-
 drivers/base/firmware_loader/Kconfig               |   7 +
 drivers/base/isa.c                                 |   2 +-
 drivers/base/module.c                              |   6 +-
 drivers/base/platform.c                            |  26 ++--
 drivers/bcma/main.c                                |   6 +-
 drivers/bus/fsl-mc/fsl-mc-bus.c                    |   4 +-
 drivers/bus/mhi/ep/main.c                          |   4 +-
 drivers/bus/mhi/host/init.c                        |   4 +-
 drivers/bus/mips_cdmm.c                            |   6 +-
 drivers/bus/moxtet.c                               |   4 +-
 drivers/bus/sunxi-rsb.c                            |   2 +-
 drivers/cdx/cdx.c                                  |   4 +-
 drivers/cxl/core/port.c                            |   2 +-
 drivers/cxl/cxl.h                                  |   5 +-
 drivers/dax/bus.c                                  |  17 +--
 drivers/dca/dca-sysfs.c                            |  20 +--
 drivers/dio/dio-driver.c                           |   4 +-
 drivers/dma/idxd/bus.c                             |   6 +-
 drivers/dma/idxd/compat.c                          |   1 -
 drivers/eisa/eisa-bus.c                            |   4 +-
 drivers/firewire/core-device.c                     |   6 +-
 drivers/firmware/arm_ffa/bus.c                     |   2 +-
 drivers/firmware/arm_scmi/bus.c                    |   6 +-
 drivers/firmware/google/coreboot_table.c           |   6 +-
 drivers/fpga/dfl.c                                 |   4 +-
 drivers/fsi/fsi-core.c                             |   4 +-
 drivers/fsi/fsi-master-aspeed.c                    |   6 +-
 drivers/fsi/fsi-master-ast-cf.c                    |   6 +-
 drivers/fsi/fsi-master-gpio.c                      |   6 +-
 drivers/fsi/fsi-occ.c                              |   6 +-
 drivers/gpio/gpiolib.c                             |   2 +-
 drivers/gpu/drm/display/drm_dp_aux_bus.c           |   2 +-
 drivers/gpu/drm/drm_mipi_dsi.c                     |   2 +-
 drivers/gpu/drm/imagination/pvr_drv.c              |   7 +-
 drivers/gpu/drm/mediatek/mtk_padding.c             |   5 +-
 drivers/gpu/host1x/bus.c                           |   2 +-
 drivers/gpu/host1x/dev.c                           |   6 +-
 drivers/gpu/host1x/mipi.c                          |  17 +--
 drivers/gpu/ipu-v3/ipu-common.c                    |   6 +-
 drivers/gpu/ipu-v3/ipu-pre.c                       |   5 +-
 drivers/gpu/ipu-v3/ipu-prg.c                       |   6 +-
 drivers/greybus/core.c                             |   4 +-
 drivers/hid/hid-core.c                             |   2 +-
 drivers/hid/intel-ish-hid/ishtp/bus.c              |   2 +-
 drivers/hsi/hsi_core.c                             |   2 +-
 drivers/hv/vmbus_drv.c                             |   8 +-
 drivers/hwtracing/intel_th/core.c                  |   4 +-
 drivers/hwtracing/intel_th/intel_th.h              |   2 +-
 drivers/i2c/i2c-core-base.c                        |   4 +-
 drivers/i3c/master.c                               |   4 +-
 drivers/input/gameport/gameport.c                  |   4 +-
 drivers/input/rmi4/rmi_bus.c                       |   6 +-
 drivers/input/rmi4/rmi_bus.h                       |   2 +-
 drivers/input/rmi4/rmi_driver.c                    |   2 +-
 drivers/input/rmi4/rmi_driver.h                    |   2 +-
 drivers/input/serio/serio.c                        |   4 +-
 drivers/ipack/ipack.c                              |   6 +-
 drivers/macintosh/macio_asic.c                     |   2 +-
 drivers/mcb/mcb-core.c                             |   4 +-
 drivers/media/pci/bt8xx/bttv-gpio.c                |   4 +-
 drivers/media/pci/bt8xx/bttv.h                     |   2 +-
 drivers/media/pci/intel/ipu6/ipu6-bus.h            |   2 +-
 drivers/memstick/core/memstick.c                   |   7 +-
 drivers/mfd/mcp-core.c                             |   2 +-
 drivers/misc/mei/bus.c                             |   4 +-
 drivers/misc/tifm_core.c                           |   6 +-
 drivers/mmc/core/sdio_bus.c                        |  10 +-
 drivers/most/core.c                                |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c      |   4 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c           |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/dev.c      |   4 +-
 drivers/net/phy/mdio_bus.c                         |   4 +-
 drivers/net/phy/mdio_device.c                      |   4 +-
 drivers/net/phy/phy_device.c                       |   4 +-
 drivers/ntb/ntb_transport.c                        |   2 +-
 drivers/nvdimm/bus.c                               |  25 ++--
 drivers/nvdimm/e820.c                              |   5 +-
 drivers/nvdimm/of_pmem.c                           |   6 +-
 drivers/nvmem/layouts.c                            |   4 +-
 drivers/parport/share.c                            |   2 +-
 drivers/pci/endpoint/pci-epf-core.c                |   4 +-
 drivers/pci/pci-driver.c                           |   8 +-
 drivers/pcmcia/ds.c                                |   2 +-
 drivers/peci/core.c                                |   4 +-
 drivers/peci/internal.h                            |   5 +-
 drivers/platform/surface/aggregator/bus.c          |   4 +-
 drivers/platform/x86/wmi.c                         |   9 +-
 drivers/pnp/driver.c                               |   6 +-
 drivers/pps/clients/pps-gpio.c                     |   5 +-
 drivers/rapidio/rio-driver.c                       |   4 +-
 drivers/reset/reset-meson-audio-arb.c              |   6 +-
 drivers/reset/reset-rzg2l-usbphy-ctrl.c            |   6 +-
 drivers/reset/reset-ti-sci.c                       |   6 +-
 drivers/rpmsg/rpmsg_core.c                         |   4 +-
 drivers/rpmsg/rpmsg_internal.h                     |   2 +-
 drivers/s390/cio/css.c                             |   4 +-
 drivers/s390/cio/css.h                             |   2 +-
 drivers/s390/cio/device.c                          |   4 +-
 drivers/s390/crypto/ap_bus.c                       |   4 +-
 drivers/s390/crypto/ap_bus.h                       |   2 +-
 drivers/scsi/fcoe/fcoe_sysfs.c                     |   2 +-
 drivers/scsi/scsi_sysfs.c                          |   6 +-
 drivers/scsi/scsi_transport_iscsi.c                |   2 +-
 drivers/sh/maple/maple.c                           |   4 +-
 drivers/siox/siox-core.c                           |   2 +-
 drivers/slimbus/core.c                             |   4 +-
 drivers/soc/qcom/apr.c                             |   4 +-
 drivers/soundwire/bus_type.c                       |   6 +-
 drivers/spi/spi.c                                  |   2 +-
 drivers/spmi/spmi.c                                |   2 +-
 drivers/ssb/main.c                                 |   4 +-
 drivers/staging/fieldbus/anybuss/anybuss-client.h  |   6 +-
 drivers/staging/fieldbus/anybuss/host.c            |   4 +-
 drivers/staging/greybus/gbphy.c                    |   2 +-
 .../vc04_services/interface/vchiq_arm/vchiq_bus.c  |   2 +-
 drivers/staging/vme_user/vme.c                     |   2 +-
 drivers/tc/tc-driver.c                             |   6 +-
 drivers/tee/tee_core.c                             |   2 +-
 drivers/thunderbolt/domain.c                       |   8 +-
 drivers/tty/serdev/core.c                          |   2 +-
 drivers/tty/serial/serial_base_bus.c               |   2 +-
 drivers/usb/common/ulpi.c                          |   2 +-
 drivers/usb/core/driver.c                          |   2 +-
 drivers/usb/gadget/udc/core.c                      |   2 +-
 drivers/usb/serial/bus.c                           |   2 +-
 drivers/usb/typec/bus.c                            |   2 +-
 drivers/vdpa/vdpa.c                                |   2 +-
 drivers/vfio/mdev/mdev_driver.c                    |   2 +-
 drivers/virtio/virtio.c                            |   2 +-
 drivers/xen/xenbus/xenbus.h                        |   2 +-
 drivers/xen/xenbus/xenbus_probe.c                  |   4 +-
 drivers/zorro/zorro-driver.c                       |   4 +-
 include/acpi/acpi_bus.h                            |   2 +-
 include/linux/arm_ffa.h                            |   2 +-
 include/linux/auxiliary_bus.h                      |   2 +-
 include/linux/cdx/cdx_bus.h                        |   2 +-
 include/linux/device.h                             |  21 +--
 include/linux/device/bus.h                         |   2 +-
 include/linux/device/driver.h                      |  18 +--
 include/linux/dfl.h                                |   2 +-
 include/linux/dio.h                                |   2 +-
 include/linux/eisa.h                               |   2 +-
 include/linux/fsi.h                                |   2 +-
 include/linux/fsl/mc.h                             |   2 +-
 include/linux/gameport.h                           |   2 +-
 include/linux/greybus.h                            |   2 +-
 include/linux/hyperv.h                             |   6 +-
 include/linux/i2c.h                                |   2 +-
 include/linux/i3c/device.h                         |   5 +-
 include/linux/maple.h                              |   2 +-
 include/linux/mcb.h                                |   5 +-
 include/linux/mdio.h                               |  19 +--
 include/linux/mhi.h                                |   2 +-
 include/linux/mhi_ep.h                             |   2 +-
 include/linux/moxtet.h                             |   9 +-
 include/linux/nd.h                                 |   6 +-
 include/linux/pci-epf.h                            |   3 +-
 include/linux/pci.h                                |   6 +-
 include/linux/phy.h                                |   2 +-
 include/linux/platform_device.h                    |  15 +--
 include/linux/pnp.h                                |   2 +-
 include/linux/rio.h                                |   2 +-
 include/linux/scmi_protocol.h                      |   2 +-
 include/linux/serio.h                              |   2 +-
 include/linux/slimbus.h                            |   2 +-
 include/linux/soc/qcom/apr.h                       |   2 +-
 include/linux/soundwire/sdw_type.h                 |   2 +-
 include/linux/spi/spi.h                            |   6 +-
 include/linux/ssb/ssb.h                            |   2 +-
 include/linux/tc.h                                 |   2 +-
 include/linux/tee_drv.h                            |   2 +-
 include/linux/virtio.h                             |   5 +-
 include/linux/zorro.h                              |   2 +-
 include/scsi/scsi_transport_iscsi.h                |   2 +-
 include/sound/ac97/codec.h                         |   5 +-
 include/xen/xenbus.h                               |   5 +-
 lib/kobject_uevent.c                               |  17 ++-
 net/iucv/iucv.c                                    |   2 +-
 rust/bindings/bindings_helper.h                    |   1 +
 rust/helpers.c                                     |   1 +
 rust/kernel/device.rs                              | 105 +++++++++++++++
 rust/kernel/firmware.rs                            | 117 +++++++++++++++++
 rust/kernel/lib.rs                                 |   3 +
 samples/kobject/kobject-example.c                  |   1 +
 samples/kobject/kset-example.c                     |   1 +
 samples/qmi/qmi_sample_client.c                    |   6 +-
 sound/ac97/bus.c                                   |   4 +-
 sound/core/seq_device.c                            |   4 +-
 sound/hda/hda_bus_type.c                           |   2 +-
 sound/soc/sof/sof-client.c                         |   4 +-
 215 files changed, 777 insertions(+), 620 deletions(-)
 create mode 100644 rust/kernel/device.rs
 create mode 100644 rust/kernel/firmware.rs


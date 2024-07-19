Return-Path: <linux-kernel+bounces-257273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9F19377BA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 14:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F0DB1F21EA1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 12:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FC013777F;
	Fri, 19 Jul 2024 12:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g4CA5s72"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B3C12D1FF;
	Fri, 19 Jul 2024 12:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721391955; cv=none; b=RtD3tZcRVcIVDotLnJrzMzXkVzfSE7j3PiMqcBWfRKIFVi/gbuO8JEuKg9btaNUe5S7SSFFkikXuiycrKOtuo1QeYBaikdAZrkhklqxHFQANUxzWBWrTP0ppl06UkaJhUpDOn+6BmU6dE7dy4zYjA4N+fyK6oiR5GD9AWQnldP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721391955; c=relaxed/simple;
	bh=EzJpooKtCCyr0PxD6+yDo7TGIvKCI3+qSFnd4+whwKY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iEXNHCKcWIaXg15N6VARa+bihHfS13BI1nAXdjC0C0fNpfNotQ9LQ3Iquhkm2fwS2U66IcXi7AF1EWtydnimQxeJ2VQ9BHJJ55ZRAXCPM8INJZ05FqzoXa8bCCmo4QAir7uDILDIph/tLMiNRu3Qn0W5433epuXqWYzmKjnHFe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g4CA5s72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA21C4AF0A;
	Fri, 19 Jul 2024 12:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721391954;
	bh=EzJpooKtCCyr0PxD6+yDo7TGIvKCI3+qSFnd4+whwKY=;
	h=Date:From:To:Cc:Subject:From;
	b=g4CA5s72dnGsuM1rkWmoDIMEmecsqPrR454QGvIbLGkzHxkFmcFelaxQr8Zekn9B5
	 n0K5nzAb1sB4T8WDnIBBtxIvdyoIzhA9pFOi4aYnf2vuBGgO8ZP7aYHivyZmjN3e69
	 Vsh5EGD3AjLlI+CfXxAKYLsBPg92pHQ0RaxsDtyM=
Date: Fri, 19 Jul 2024 14:25:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [GIT PULL] USB/Thunderbolt driver updates for 6.11-rc1
Message-ID: <ZppbUEfumxaxy2JV@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 22a40d14b572deb80c0648557f4bd502d7e83826:

  Linux 6.10-rc6 (2024-06-30 14:40:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.11-rc1

for you to fetch changes up to b727493011123db329e2901e3abf81a8d146b6fe:

  kselftest: devices: Add test to detect device error logs (2024-07-12 10:59:06 +0200)

----------------------------------------------------------------
USB/Thunderbolt updates for 6.11-rc1

Here is the big set of USB and Thunderbolt changes for 6.11-rc1.
Nothing earth-shattering in here, just constant forward progress in
adding support for new hardware and better debugging functionalities for
thunderbolt devices and the subsystem.  Included in here are:
  - thunderbolt debugging update and driver additions
  - xhci driver updates
  - typec driver updates
  - kselftest device driver changes (acked by the relevant maintainers,
    depended on other changes in this tree.)
  - cdns3 driver updates
  - gadget driver updates
  - MODULE_DESCRIPTION() additions
  - dwc3 driver updates and fixes

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aapo Vienamo (1):
      thunderbolt: debugfs: Use FIELD_GET()

Abhishek Pandit-Subedi (2):
      usb: typec: ucsi: Fix null pointer dereference in trace
      usb: typec: Update sysfs when setting ops

Anand Moon (2):
      dt-bindings: usb: Add the binding example for the Genesys Logic GL3523 hub
      arm64: dts: amlogic: Used onboard usb hub reset on odroid n2

Bastien Curutchet (4):
      phy: ti: phy-da8xx-usb: Add runtime PM support
      Revert "usb: musb: da8xx: Set phy in OTG mode by default"
      usb: musb: da8xx: Remove try_idle implementation from host-only mode
      usb: musb: da8xx: Implement BABBLE recovery

Bjorn Andersson (2):
      dt-bindings: platform: Add Lenovo Yoga C630 EC
      dt-bindings: usb: qcom,dwc3: Add SC8180X compatibles

Conor Dooley (2):
      dt-bindings: musb: mpfs: add ULPI external vbus support
      usb: musb: mpfs: detect UPLI external vbus control requirement from DT

Daehwan Jung (3):
      usb: dwc3: Support quirk for writing high-low order
      xhci: Add a quirk for writing ERST in high-low order
      usb: host: xhci-plat: Add support for XHCI_WRITE_64_HI_LO

Diogo Ivo (3):
      usb: typec: ucsi: Add new notification bits
      usb: typec: ucsi: Add new capability bits
      usb: typec: ucsi: Enable UCSI v2.0 notifications

Dmitry Baryshkov (10):
      platform: arm64: add Lenovo Yoga C630 WOS EC driver
      platform/arm64: build drivers even on non-ARM64 platforms
      usb: typec: ucsi: add Lenovo Yoga C630 glue driver
      usb: typec: ucsi: move ucsi_acknowledge() from ucsi_read_error()
      usb: typec: ucsi: simplify command sending API
      usb: typec: ucsi: split read operation
      usb: typec: ucsi: rework command execution functions
      usb: typec: ucsi: inline ucsi_read_message_in
      usb: typec: ucsi: extract common code for command handling
      usb: typec: ucsi: reorder operations in ucsi_run_command()

Dr. David Alan Gilbert (1):
      usb: host: oxu210hp: remove unused struct 'ehci_dbg_port'

Fabio Estevam (2):
      usb: chipidea: ci_hdrc_imx: Switch to RUNTIME/SYSTEM_SLEEP_PM_OPS()
      usb: chipidea: ci_hdrc_tegra: Switch to RUNTIME_PM_OPS()

Francesco Dolcini (2):
      dt-bindings: usb: gpio-sbu-mux: Make 'enable-gpios' optional
      usb: typec: mux: gpio-sbu: Make enable gpio optional

Frank Li (2):
      dt-bindings: usb: cdns,usb3: use common usb-drd yaml
      dt-bindings: usb: Convert fsl-usb to yaml

Greg Kroah-Hartman (4):
      Merge tag 'v6.10-rc4' into usb-next
      Merge tag 'thunderbolt-for-v6.11-rc1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-next
      Merge tag 'platform-drivers-x86-ib-lenovo-c630-v6.11-2' of https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86 into usb-next
      Merge 6.10-rc6 into usb-next

Hauke Mehrtens (1):
      usb: dwc2: add support for other Lantiq SoCs

Hector Martin (1):
      xhci: Remove dead code in xhci_move_dequeue_past_td()

Heikki Krogerus (2):
      usb: typec: ucsi: Changing the driver data type to void
      usb: typec: ucsi: psy: Add support for the charge type property

Jameson Thies (3):
      usb: typec: ucsi: Delay alternate mode discovery
      usb: typec: ucsi: Always set number of alternate modes
      usb: typec: ucsi: Only set number of plug altmodes after registration

Javier Carrasco (3):
      usb: typec: tipd: drop second firmware name read
      usb: typec: tipd: add error log to provide firmware name and size
      usb: typec: tipd: use min() to set tps6598x firmware packet size

Jeff Johnson (6):
      usb: gadget: add missing MODULE_DESCRIPTION() macros
      usb: misc: add missing MODULE_DESCRIPTION() macros
      usb: host: add missing MODULE_DESCRIPTION() macros
      usb: phy: add missing MODULE_DESCRIPTION() macros
      usb: common: add missing MODULE_DESCRIPTION() macros
      usb: add missing MODULE_DESCRIPTION() macros

John Keeping (1):
      usb: gadget: f_uac2: fix non-newline-terminated function name

Kees Cook (1):
      usb: gadget: Use u16 types for 16-bit fields

Kerem Karabay (2):
      USB: core: add 'shutdown' callback to usb_driver
      USB: uas: Implement the new shutdown callback

Ma Ke (1):
      usb: gadget: aspeed_udc: validate endpoint index for ast udc

Marco Felsch (1):
      usb: typec: tcpci: add support to set connector orientation

Mark Pearson (1):
      usb: typec: ucsi: don't retrieve PDOs if not supported

Mathias Nyman (4):
      xhci: show usb device name in xhci urb tracing
      xhci: Set correct transferred length for cancelled isoc transfers
      xhci: rework xhci internal endpoint halt state detection.
      xhci: sort out TRB Endpoint ID bitfield macros

Matthias Kaehlcke (1):
      usb: misc: onboard_usb_dev: Add match function

Mika Westerberg (7):
      thunderbolt: Mention Thunderbolt/USB4 debugging tools in Kconfig
      thunderbolt: Move usb4_port_margining_caps() declaration into correct place
      thunderbolt: Make usb4_port_sb_read/write() available outside of usb4.c
      thunderbolt: Add sideband register access to debugfs
      thunderbolt: Split out margining from USB4 port
      thunderbolt: Make margining functions accept target and retimer index
      thunderbolt: Add receiver lane margining support for retimers

Neil Armstrong (5):
      usb: typec-mux: ptn36502: unregister typec switch on probe error and remove
      usb: typec-mux: nb7vpq904m: unregister typec switch on probe error and remove
      usb: typec-mux: ptn36502: broadcast typec state to next mux
      usb: typec-mux: nb7vpq904m: broadcast typec state to next mux
      dt-bindings: usb: dwc2: switch to unevaluatedProperties

Niklas Neronin (14):
      usb: xhci: remove 'num_trbs' from struct 'xhci_td'
      usb: xhci: remove unused 'xhci' argument
      usb: xhci: remove unused argument from xhci_handle_cmd_config_ep()
      usb: xhci: remove unused argument from handle_port_status()
      usb: xhci: move link chain bit quirk checks into one helper function.
      usb: xhci: move all segment re-numbering to xhci_link_rings()
      usb: xhci: move untargeted transfer event handling to a separate function
      usb: xhci: improve error message for targetless transfer event
      usb: xhci: remove obsolete sanity check debug messages
      usb: xhci: ensure skipped isoc TDs are returned when isoc ring is stopped
      usb: xhci: remove false xhci_giveback_urb_in_irq() header comment
      usb: xhci: remove infinite loop prevention
      usb: xhci: move process TD code out of the while loop
      usb: xhci: add 'goto' for halted endpoint check in handle_tx_event()

Norihiko Hama (1):
      usb-storage: Optimize scan delay more precisely

Nícolas F. R. A. Prado (5):
      kselftest: devices: Allow specifying boards directory through parameter
      kselftest: devices: Add of-fullname-regex property
      kselftest: devices: Move discoverable devices test to subdirectory
      kselftest: Move ksft helper module to common directory
      kselftest: devices: Add test to detect device error logs

Parth Pancholi (1):
      dt-bindings: usb: gpio-sbu-mux: Add an entry for TMUXHS4212

Peng Hongchi (1):
      usb: dwc2: gadget: Don't write invalid mapped sg entries into dma_desc with iommu enabled

Pooja Katiyar (2):
      usb: typec: ucsi: UCSI2.0 Get Error Status data structure changes
      usb: typec: ucsi: UCSI2.0 Get Error Status changes

R Sundar (1):
      usb: typec: nb7vpq904m: Remove unneeded indentation

Radhey Shyam Pandey (1):
      usb: dwc3: enable CCI support for AMD-xilinx DWC3 controller

Reka Norman (1):
      xhci: Apply XHCI_RESET_TO_DEFAULT quirk to TGL

Roger Quadros (2):
      usb: cdns3: Add quirk flag to enable suspend residency
      usb: cdns3-ti: Add workaround for Errata i2409

Sebastian Reichel (2):
      usb: typec: tcpm: avoid resets for missing source capability messages
      usb: typec: tcpm: print error on hard reset

Shantanu Goel (1):
      usb: uas: set host status byte on data completion error

Simon Holesch (1):
      usbip: Don't submit special requests twice

Takashi Iwai (1):
      usb: gadget: midi2: Fix incorrect default MIDI2 protocol setup

Thinh Nguyen (1):
      usb: dwc3: core: Check all ports when set phy suspend

Uday M Bhat (1):
      xhci: dbc: Allow users to modify DbC poll interval via sysfs

Uwe Kleine-König (2):
      usb: misc: Drop explicit initialization of struct i2c_device_id::driver_data to 0
      usb: typec: Drop explicit initialization of struct i2c_device_id::driver_data to 0

Wolfram Sang (1):
      usb: typec: tcpm: use 'time_left' variable with wait_for_completion_timeout()

 .../ABI/testing/sysfs-bus-pci-drivers-xhci_hcd     |  10 +
 Documentation/admin-guide/kernel-parameters.txt    |   3 +
 .../bindings/platform/lenovo,yoga-c630-ec.yaml     |  83 +++
 .../devicetree/bindings/usb/cdns,usb3.yaml         |  15 +-
 Documentation/devicetree/bindings/usb/dwc2.yaml    |   2 +-
 .../devicetree/bindings/usb/fsl,usb2.yaml          |  95 +++
 Documentation/devicetree/bindings/usb/fsl-usb.txt  |  81 ---
 .../devicetree/bindings/usb/genesys,gl850g.yaml    |  60 +-
 .../devicetree/bindings/usb/gpio-sbu-mux.yaml      |   8 +-
 .../bindings/usb/microchip,mpfs-musb.yaml          |   7 +
 .../devicetree/bindings/usb/qcom,dwc3.yaml         |  29 +
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dtsi     |  36 +-
 drivers/phy/ti/phy-da8xx-usb.c                     |  49 ++
 drivers/platform/Makefile                          |   2 +-
 drivers/platform/arm64/Kconfig                     |  14 +
 drivers/platform/arm64/Makefile                    |   1 +
 drivers/platform/arm64/lenovo-yoga-c630.c          | 291 +++++++++
 drivers/thunderbolt/Kconfig                        |  17 +-
 drivers/thunderbolt/debugfs.c                      | 648 +++++++++++++++------
 drivers/thunderbolt/retimer.c                      |  53 +-
 drivers/thunderbolt/sb_regs.h                      |  18 +-
 drivers/thunderbolt/tb.h                           |  45 +-
 drivers/thunderbolt/usb4.c                         | 187 +++---
 drivers/usb/cdns3/cdns3-ti.c                       |  15 +-
 drivers/usb/cdns3/core.h                           |   1 +
 drivers/usb/cdns3/drd.c                            |  10 +-
 drivers/usb/cdns3/drd.h                            |   3 +
 drivers/usb/chipidea/ci_hdrc_imx.c                 |  19 +-
 drivers/usb/chipidea/ci_hdrc_msm.c                 |   1 +
 drivers/usb/chipidea/ci_hdrc_tegra.c               |   9 +-
 drivers/usb/class/usbtmc.c                         |   1 +
 drivers/usb/common/common.c                        |   1 +
 drivers/usb/common/usb-otg-fsm.c                   |   1 +
 drivers/usb/core/driver.c                          |  14 +
 drivers/usb/core/usb.c                             |   1 +
 drivers/usb/dwc2/gadget.c                          |   4 +-
 drivers/usb/dwc2/params.c                          |  30 +-
 drivers/usb/dwc3/core.c                            |  66 ++-
 drivers/usb/dwc3/core.h                            |   8 +
 drivers/usb/dwc3/dwc3-xilinx.c                     |  29 +
 drivers/usb/dwc3/host.c                            |   4 +-
 drivers/usb/gadget/composite.c                     |   1 +
 drivers/usb/gadget/function/f_acm.c                |   1 +
 drivers/usb/gadget/function/f_ecm.c                |   1 +
 drivers/usb/gadget/function/f_eem.c                |   1 +
 drivers/usb/gadget/function/f_fs.c                 |   1 +
 drivers/usb/gadget/function/f_hid.c                |   1 +
 drivers/usb/gadget/function/f_loopback.c           |   1 +
 drivers/usb/gadget/function/f_mass_storage.c       |   1 +
 drivers/usb/gadget/function/f_midi.c               |   1 +
 drivers/usb/gadget/function/f_midi2.c              |  20 +-
 drivers/usb/gadget/function/f_ncm.c                |   1 +
 drivers/usb/gadget/function/f_obex.c               |   1 +
 drivers/usb/gadget/function/f_phonet.c             |   1 +
 drivers/usb/gadget/function/f_printer.c            |   1 +
 drivers/usb/gadget/function/f_rndis.c              |   1 +
 drivers/usb/gadget/function/f_serial.c             |   1 +
 drivers/usb/gadget/function/f_sourcesink.c         |   1 +
 drivers/usb/gadget/function/f_subset.c             |   1 +
 drivers/usb/gadget/function/f_tcm.c                |   1 +
 drivers/usb/gadget/function/f_uac1.c               |   1 +
 drivers/usb/gadget/function/f_uac1_legacy.c        |   1 +
 drivers/usb/gadget/function/f_uac2.c               |   6 +-
 drivers/usb/gadget/function/f_uvc.c                |   1 +
 drivers/usb/gadget/function/storage_common.c       |   1 +
 drivers/usb/gadget/function/u_ether.c              |   1 +
 drivers/usb/gadget/function/u_serial.c             |   1 +
 drivers/usb/gadget/legacy/dbgp.c                   |   1 +
 drivers/usb/gadget/legacy/gmidi.c                  |   1 +
 drivers/usb/gadget/legacy/zero.c                   |   1 +
 drivers/usb/gadget/udc/aspeed_udc.c                |   2 +
 drivers/usb/host/ohci-exynos.c                     |   1 +
 drivers/usb/host/oxu210hp-hcd.c                    |  25 -
 drivers/usb/host/xhci-dbgcap.c                     |  38 ++
 drivers/usb/host/xhci-dbgcap.h                     |   2 +-
 drivers/usb/host/xhci-mem.c                        |  40 +-
 drivers/usb/host/xhci-pci-renesas.c                |   1 +
 drivers/usb/host/xhci-pci.c                        |   4 +-
 drivers/usb/host/xhci-plat.c                       |   3 +
 drivers/usb/host/xhci-ring.c                       | 306 ++++------
 drivers/usb/host/xhci-trace.h                      |   5 +-
 drivers/usb/host/xhci.h                            |  45 +-
 drivers/usb/misc/ezusb.c                           |   1 +
 drivers/usb/misc/isight_firmware.c                 |   1 +
 drivers/usb/misc/onboard_usb_dev.c                 |  11 +-
 drivers/usb/misc/usb251xb.c                        |  18 +-
 drivers/usb/misc/usb3503.c                         |   2 +-
 drivers/usb/misc/usb4604.c                         |   2 +-
 drivers/usb/misc/yurex.c                           |   1 +
 drivers/usb/mon/mon_main.c                         |   1 +
 drivers/usb/musb/da8xx.c                           |  20 +-
 drivers/usb/musb/mpfs.c                            |   2 +
 drivers/usb/phy/phy-am335x-control.c               |   1 +
 drivers/usb/phy/phy-am335x.c                       |   1 +
 drivers/usb/storage/uas.c                          |   7 +-
 drivers/usb/storage/usb.c                          | 101 +++-
 drivers/usb/typec/altmodes/displayport.c           |   2 +-
 drivers/usb/typec/anx7411.c                        |   2 +-
 drivers/usb/typec/class.c                          |  18 +-
 drivers/usb/typec/mux/gpio-sbu-mux.c               |   6 +-
 drivers/usb/typec/mux/nb7vpq904m.c                 |  95 +--
 drivers/usb/typec/mux/ptn36502.c                   |  33 +-
 drivers/usb/typec/tcpm/fusb302.c                   |   4 +-
 drivers/usb/typec/tcpm/tcpci.c                     |  46 +-
 drivers/usb/typec/tcpm/tcpci_maxim_core.c          |   2 +-
 drivers/usb/typec/tcpm/tcpm.c                      |  37 +-
 drivers/usb/typec/tipd/core.c                      |  33 +-
 drivers/usb/typec/ucsi/Kconfig                     |   9 +
 drivers/usb/typec/ucsi/Makefile                    |   1 +
 drivers/usb/typec/ucsi/displayport.c               |   2 +-
 drivers/usb/typec/ucsi/psy.c                       |  32 +
 drivers/usb/typec/ucsi/ucsi.c                      | 290 +++++----
 drivers/usb/typec/ucsi/ucsi.h                      |  72 ++-
 drivers/usb/typec/ucsi/ucsi_acpi.c                 | 145 +++--
 drivers/usb/typec/ucsi/ucsi_ccg.c                  | 105 ++--
 drivers/usb/typec/ucsi/ucsi_glink.c                |  74 +--
 drivers/usb/typec/ucsi/ucsi_stm32g0.c              |  83 +--
 drivers/usb/typec/ucsi/ucsi_yoga_c630.c            | 164 ++++++
 drivers/usb/usbip/stub_rx.c                        |  77 ++-
 include/linux/platform_data/lenovo-yoga-c630.h     |  44 ++
 include/linux/usb.h                                |   3 +
 include/linux/usb/gadget.h                         |  10 +-
 include/linux/usb/tcpci.h                          |   8 +
 include/linux/usb/typec.h                          |   3 +
 tools/testing/selftests/Makefile                   |   4 +-
 tools/testing/selftests/devices/Makefile           |   4 -
 .../testing/selftests/devices/error_logs/Makefile  |   3 +
 .../devices/error_logs/test_device_error_logs.py   |  85 +++
 tools/testing/selftests/devices/probe/Makefile     |   4 +
 .../{ => probe}/boards/Dell Inc.,XPS 13 9300.yaml  |   0
 .../{ => probe}/boards/google,spherion.yaml        |   4 +
 .../{ => probe}/test_discoverable_devices.py       |  44 +-
 .../selftests/{devices => kselftest}/ksft.py       |   0
 133 files changed, 3001 insertions(+), 1212 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/platform/lenovo,yoga-c630-ec.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/fsl,usb2.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/fsl-usb.txt
 create mode 100644 drivers/platform/arm64/lenovo-yoga-c630.c
 create mode 100644 drivers/usb/typec/ucsi/ucsi_yoga_c630.c
 create mode 100644 include/linux/platform_data/lenovo-yoga-c630.h
 delete mode 100644 tools/testing/selftests/devices/Makefile
 create mode 100644 tools/testing/selftests/devices/error_logs/Makefile
 create mode 100755 tools/testing/selftests/devices/error_logs/test_device_error_logs.py
 create mode 100644 tools/testing/selftests/devices/probe/Makefile
 rename tools/testing/selftests/devices/{ => probe}/boards/Dell Inc.,XPS 13 9300.yaml (100%)
 rename tools/testing/selftests/devices/{ => probe}/boards/google,spherion.yaml (86%)
 rename tools/testing/selftests/devices/{ => probe}/test_discoverable_devices.py (86%)
 rename tools/testing/selftests/{devices => kselftest}/ksft.py (100%)


Return-Path: <linux-kernel+bounces-340305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3C5987165
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27AF81F21767
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D401AD3ED;
	Thu, 26 Sep 2024 10:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DV4otXm8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4591AC8AB;
	Thu, 26 Sep 2024 10:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727346149; cv=none; b=BBelIYlwl8qLIZ1FY9rzQFK8mMAhRcljRRLuht3dtTZ3m2XGA3ipyw18IwYCXwExJDBC3crhooLPgnsEZLL+x53YKi2AxFal9MUk8bWY1SxCdGdJhng+nMM0WGegF6eIPWeof2AIsBAoxFK3GsEeXqdNOasvWcTvXD0fR5cV07w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727346149; c=relaxed/simple;
	bh=9lPRy78ngkI6rIEdGBpAKrtZX9s/X+vy1jkwfo4VtzA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=r1wt5jCr/VDCrK04XWqxbaZDF1Fto3spObEha3SfVzaC1SD0V+6AlbhlsIi6zArCvJ0MzYNHH1VdEK+VbTylpUSJMTYY6XfAOrw97SBo6O6oIjmKxih8dJx0c7rf1rubvxYgclJOKmqpGXvW4kutaNgFk2z3jwa3s4h9H1l88+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DV4otXm8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4219C4CEC5;
	Thu, 26 Sep 2024 10:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727346148;
	bh=9lPRy78ngkI6rIEdGBpAKrtZX9s/X+vy1jkwfo4VtzA=;
	h=Date:From:To:Cc:Subject:From;
	b=DV4otXm8e/uUpmlnmQGx3Myv4Su6HCSsFddhujUSinY49zL6a/rBEmKoUVxjC0igL
	 A3baMJ2lXWNyqdfEfHilj0F8DngfnfKhdlyZAFA7SlTJKn9ccOHbNA51ru7qDhB1O7
	 mca0AUa397U2qyhJfzJ9KYqSwiAVP0ROgIXruoGE=
Date: Thu, 26 Sep 2024 12:22:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [GIT PULL] USB/Thunderbolt driver changes for 6.12-rc1
Message-ID: <ZvU13hRnFM4PbH73@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit da3ea35007d0af457a0afc87e84fddaebc4e0b63:

  Linux 6.11-rc7 (2024-09-08 14:50:28 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.12-rc1

for you to fetch changes up to 68d4209158f43a558c5553ea95ab0c8975eab18c:

  sub: cdns3: Use predefined PCI vendor ID constant (2024-09-13 15:39:06 +0200)

----------------------------------------------------------------
USB/Thunderbolt update for 6.12-rc1

Here is the large set of USB and Thunderbolt changes for 6.12-rc1.

Nothing "major" in here, except for a new 9p network gadget that has
been worked on for a long time (all of the needed acks are here.)  Other
than that, it's the usual set of:
  - Thunderbolt / USB4 driver updates and additions for new hardware
  - dwc3 driver updates and new features added
  - xhci driver updates
  - typec driver updates
  - USB gadget updates and api additions to make some gadgets more
    configurable by userspace
  - dwc2 driver updates
  - usb phy driver updates
  - usbip feature additions
  - other minor USB driver updates

All of these have been in linux-next for a long time with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aapo Vienamo (1):
      thunderbolt: Add missing usb4_port_sb_read() to usb4_port_sw_margin()

Abhishek Tamboli (3):
      usb: gadget: u_audio: Use C99 syntax for array initializers
      usb: gadget: uvc: Fix ERR_PTR dereference in uvc_v4l2.c
      usb: storage: ene_ub6250: Fix right shift warnings

Akash Kumar (1):
      usb: gadget: Increase max configuration interface to 32

Amit Sunil Dhamne (1):
      usb: roles: add lockdep class key to struct usb_role_switch

Andreas Kühn (2):
      usb: chipidea: npcm: Fix coding style with missing space
      usb: chipidea: npcm: Fix coding style with clarification of data type

Andrey Konovalov (1):
      usb: gadget: dummy_hcd: execute hrtimer callback in softirq context

André Draszik (16):
      usb: typec: tcpci: fix a comment typo
      usb: typec: tcpm/tcpci_maxim: clarify a comment
      usb: typec: tcpci: use GENMASK() for TCPC_CC_STATUS_CC[12]
      usb: typec: tcpci: use GENMASK() for TCPC_ROLE_CTRL_CC[12]
      usb: typec: tcpci: use GENMASK() for TCPC_ROLE_CTRL_RP_VAL
      usb: typec: tcpci: use GENMASK() for TCPC_MSG_HDR_INFO_REV
      usb: typec: tcpci: use GENMASK() for TCPC_TRANSMIT register fields
      usb: typec: tcpm/tcpci_maxim: sort TCPC_ALERT_MASK values by bit
      usb: typec: tcpm/tcpci_maxim: simplify clearing of TCPC_ALERT_RX_BUF_OVF
      usb: typec: tcpm/tcpci_maxim: drop STATUS_CHECK()
      usb: typec: tcpm/tcpci_maxim: use GENMASK() for TCPC_VENDOR_CC_CTRL2 register
      usb: typec: tcpm/tcpci_maxim: use GENMASK() for TCPC_VENDOR_CC_CTRL3 register
      usb: typec: tcpm/tcpci_maxim: use GENMASK() for TCPC_VENDOR_ADC_CTRL1 register
      usb: typec: tcpm/tcpci_maxim: convert to dev_err_probe()
      usb: typec: tcpm/tcpci_maxim: use device managed TCPCI port deregistration
      usb: typec: tcpm/tcpci_maxim: fix non-contaminant CC handling

Andy Shevchenko (3):
      usb: common: Switch to device_property_match_property_string()
      sub: cdns2: Use predefined PCI vendor ID constant
      sub: cdns3: Use predefined PCI vendor ID constant

Arnd Bergmann (1):
      net/9p/usbg: fix CONFIG_USB_GADGET dependency

Bagas Sanjaya (1):
      tools: usb: p9_fwd: wrap USBG shell command examples in literal code blocks

Bart Van Assche (3):
      locking/mutex: Define mutex_init() once
      locking/mutex: Introduce mutex_init_with_key()
      usb: roles: Improve the fix for a false positive recursive locking complaint

Ben Hutchings (1):
      xhci-pci: Make xhci-pci-renesas a proper modular driver

Chen Ni (2):
      usb: typec: ucsi: glink: Remove unnecessary semicolon
      usb: cdns2: Convert comma to semicolon

Chris Wulff (4):
      usb: gadget: f_uac1: Expose all string descriptors through configfs.
      usb: gadget: f_uac2: Expose all string descriptors through configfs.
      usb: gadget: f_uac1: Change volume name and remove alt names
      USB: gadget: f_hid: Add GET_REPORT via userspace IOCTL

Christian A. Ehrhardt (1):
      usb: typec: ucsi: Fix busy loop on ASUS VivoBooks

Christophe JAILLET (3):
      usb: gadget: configfs: Make check_user_usb_string() static
      usb: gadget: configfs: Constify struct config_item_type
      usb-storage: Constify struct usb_device_id and us_unusual_dev

Colin Ian King (2):
      usb: gadget: udc-xilinx: Remove trailing space after \n newline
      usb: r8a66597-hcd: make read-only const arrays static

Dan Carpenter (1):
      usb: dwc3: rtk: Clean up error code in __get_dwc3_maximum_speed()

David Sands (1):
      usb: gadget: f_fs: add capability for dfu functional descriptor

Edward Adam Davis (1):
      USB: usbtmc: prevent kernel-usb-infoleak

Emanuele Ghidoli (1):
      usb: typec: tcpci: support edge irq

Fabio Estevam (1):
      usb: dwc3: imx8mp: Switch to RUNTIME/SYSTEM_SLEEP_PM_OPS()

Frank Li (3):
      dt-bindings: usb: add layerscape super speed usb support
      usb: host: xhci-plat: Parse xhci-missing_cas_quirk and apply quirk
      usb: dwc3: imx8mp: add 2 software managed quirk properties for host mode

Greg Kroah-Hartman (7):
      Merge 6.11-rc3 into usb-next
      Merge 6.11-rc4 into usb-next
      Merge 6.11-rc6 into usb-next
      Merge 6.11-rc7 into usb-next
      Merge tag 'thunderbolt-for-v6.12-rc1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-next
      Merge tag 'usb-serial-6.12-rc1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-next
      Merge tag 'usb-serial-6.12-rc1-2' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-next

Heikki Krogerus (6):
      usb: typec: ucsi: Remove unused fields from struct ucsi_connector_status
      usb: typec: ucsi: Don't truncate the reads
      usb: typec: ucsi: Only assign the identity structure if the PPM supports it
      usb: typec: ucsi: Common function for the GET_PD_MESSAGE command
      usb: typec: ucsi: Call CANCEL from single location
      usb: typec: ucsi: Remove useless error check from ucsi_read_error()

Hongbo Li (1):
      usb: f_mass_storage: Make use of the helper macro kthread_run()

Jinjie Ruan (2):
      usb: ehci-exynos: Simplify with scoped for each OF child loop
      usb: ohci-exynos: Simplify with scoped for each OF child loop

Johan Hovold (1):
      USB: serial: kobil_sct: restore initial terminal settings

Junhao Xie (1):
      USB: serial: pl2303: add device id for Macrosilicon MS3020

Konrad Dybcio (1):
      dt-bindings: usb: qcom,dwc3: Document X1E80100 MP controller

Krzysztof Kozlowski (15):
      USB: ohci-ppc-of: Drop ohci-littledian compatible
      usb: misc: eud: switch to fallback compatible for device matching
      USB: serial: set driver owner when registering drivers
      USB: serial: drop driver owner initialization
      usb: dwc3: st: use scoped device node handling to simplify error paths
      usb: dwc3: st: simplify with dev_err_probe
      usb: dwc3: st: simplify pdev->dev usage
      usb: dwc3: imx8mp: simplify with devm_clk_get_enabled
      usb: dwc3: imx8mp: simplify with dev_err_probe
      usb: dwc3: imx8mp: use scoped device node handling to simplify error paths
      usb: dwc3: qcom: use scoped device node handling to simplify error paths
      usb: dwc3: qcom: simplify with devm_platform_ioremap_resource
      usb: dwc3: rtk: use scoped device node handling to simplify error paths
      usb: dwc3: rtk: return directly and simplify with devm_platform_ioremap_resource
      usb: dwc3: xilinx: simplify with dev_err_probe

Li Jun (1):
      usb: dwc3: imx8mp: disable SS_CON and U3 wakeup for system sleep

Liao Chen (5):
      usb: bdc: fix module autoloading
      usb: phy: phy-gpio-vbus-usb: fix module autoloading
      usb: misc: brcmstb-usb-pinmap: fix module autoloading
      usb: typec: fix module autoloading
      usb: ehci-brcm: fix module autoloading

Lin Ruifeng (1):
      usb: musb: mediatek: Simplify code with dev_err_probe()

Masanori Ogino (1):
      Documentation: msm-hsusb.txt: remove

Mathias Nyman (8):
      xhci: Add USB4 tunnel detection for USB3 devices on Intel hosts
      usb: Add tunnel_mode parameter to usb device structure
      usb: acpi: add device link between tunneled USB3 device and USB4 Host Interface
      thunderbolt: Don't create device link from USB4 Host Interface to USB3 xHC host
      xhci: dbc: Fix STALL transfer event handling
      xhci: dbc: add dbgtty request to end of list once it completes
      xhci: Set quirky xHC PCI hosts to D3 _after_ stopping and freeing them.
      xhci: support setting interrupt moderation IMOD for secondary interrupters

Michael Grzeschik (3):
      usb: gadget: function: move u_f.h to include/linux/usb/func_utils.h
      net/9p/usbg: Add new usb gadget function transport
      tools: usb: p9_fwd: add usb gadget packet forwarder script

Michael Walle (2):
      usb: gadget: u_serial: add .get_icount() support
      usb: gadget: f_acm: make bInterfaceProtocol configurable

Niklas Neronin (7):
      usb: xhci: remove excessive isoc frame debug message spam
      usb: xhci: remove excessive Bulk short packet debug message
      usb: xhci: remove unused variables from struct 'xhci_hcd'
      usb: xhci: make 'sbrn' a local variable
      usb: xhci: add comments explaining specific interrupt behaviour
      usb: xhci: remove 'retval' from xhci_pci_resume()
      usb: xhci: adjust empty TD list handling in handle_tx_event()

Oliver Neukum (4):
      USB: class: CDC-ACM: fix race between get_serial and set_serial
      USB: appledisplay: close race between probe and completion handler
      USB: misc: cypress_cy7c63: check for short transfer
      USB: misc: yurex: fix race between read and write

Pawel Laszczak (2):
      usb: cdnsp: Fix incorrect usb_request status
      usb: xhci: fix loss of data on Cadence xHC

R Kannappan (1):
      thunderbolt: Improve software receiver lane margining

Radhey Shyam Pandey (2):
      usb: misc: onboard_dev: extend platform data to add power on delay field
      usb: misc: onboard_usb_dev: add Microchip usb5744 SMBus programming support

Rene Sapiens (2):
      thunderbolt: Consolidate margining parameters into a structure
      thunderbolt: Add optional voltage offset range for receiver lane margining

Rob Herring (Arm) (2):
      usb: chipidea: Use of_property_present()
      usb: dwc3: Use of_property_read_variable_u32_array() to read "power"

Shawn Shao (1):
      usb: dwc2: Adjust the timing of USB Driver Interrupt Registration in the Crashkernel Scenario

Stefan Wahren (3):
      usb: dwc2: debugfs: Print parameter no_clock_gating
      usb: dwc2: Add comment about BCM2848 ACPI ID
      usb: dwc2: Skip clock gating on Broadcom SoCs

Théo Lebrun (1):
      dt-bindings: usb: ti,j721e-usb: fix compatible list

Tomas Marek (1):
      usb: dwc2: drd: fix clock gating on USB role switch

Valentina Fernandez (1):
      usb: musb: poll ID pin status in dual-role mode in mpfs glue layer

Varadarajan Narayanan (2):
      dt-bindings: usb: qcom,dwc3: Update ipq5332 interrupt info
      dt-bindings: usb: qcom,dwc3: Update ipq5332 clock details

Venkat Jayaraman (1):
      usb: typec: ucsi: Add DATA_RESET option of Connector Reset command

Wadim Egorov (1):
      usb: typec: tipd: Free IRQ only if it was requested before

WangYuli (1):
      usb: xHCI: add XHCI_RESET_ON_RESUME quirk for Phytium xHCI host

Xu Yang (6):
      usb: phy: mxs: enable regulator phy-3p0 to improve signal qualilty
      usb: phy: mxs: keep USBPHY2's clk always on
      usb: phy: mxs: add wakeup enable for imx7ulp
      usb: phy: mxs: enable weak 1p1 regulator for imx6ul during suspend
      usb: chipidea: udc: enable suspend interrupt after usb reset
      dt-bindings: phy: mxs-usb-phy: add nxp,sim property

Yue Haibing (1):
      xhci: Remove unused function declarations

Yuesong Li (1):
      usb: gadget: lpc32xx_udc: Remove NULL check of list_entry()

Zhang Zekun (2):
      usb: common: Use helper function for_each_node_with_property()
      usb: ohci-nxp: Use helper function devm_clk_get_enabled()

Łukasz Bartosik (1):
      usbip: Add USB_SPEED_SUPER_PLUS as valid arg

 Documentation/ABI/testing/configfs-usb-gadget-acm  |   7 +
 Documentation/ABI/testing/configfs-usb-gadget-uac1 |   8 +
 Documentation/ABI/testing/configfs-usb-gadget-uac2 |  11 +
 .../devicetree/bindings/phy/fsl,mxs-usbphy.yaml    |  17 +
 .../devicetree/bindings/usb/fsl,ls1028a.yaml       |  52 ++
 .../devicetree/bindings/usb/msm-hsusb.txt          | 110 ---
 .../devicetree/bindings/usb/qcom,dwc3.yaml         |  20 +-
 .../devicetree/bindings/usb/ti,j721e-usb.yaml      |   3 +-
 Documentation/filesystems/9p.rst                   |  58 +-
 Documentation/usb/functionfs-desc.rst              |  39 +
 Documentation/usb/functionfs.rst                   |   2 +
 Documentation/usb/gadget-testing.rst               |  19 +
 Documentation/usb/index.rst                        |   1 +
 drivers/thunderbolt/acpi.c                         |  40 +-
 drivers/thunderbolt/debugfs.c                      | 382 +++++++-
 drivers/thunderbolt/sb_regs.h                      |  18 +-
 drivers/thunderbolt/tb.h                           |  42 +-
 drivers/thunderbolt/usb4.c                         |  62 +-
 drivers/usb/cdns3/cdns3-pci-wrap.c                 |   5 +-
 drivers/usb/cdns3/cdnsp-pci.c                      |  29 +-
 drivers/usb/cdns3/cdnsp-ring.c                     |   6 +-
 drivers/usb/cdns3/host.c                           |   4 +-
 drivers/usb/chipidea/ci_hdrc_imx.c                 |   2 +-
 drivers/usb/chipidea/ci_hdrc_npcm.c                |   4 +-
 drivers/usb/chipidea/udc.c                         |   8 +-
 drivers/usb/class/cdc-acm.c                        |   2 +
 drivers/usb/class/usbtmc.c                         |   2 +-
 drivers/usb/common/common.c                        |  22 +-
 drivers/usb/core/usb-acpi.c                        |  53 ++
 drivers/usb/dwc2/debugfs.c                         |   1 +
 drivers/usb/dwc2/drd.c                             |   9 +
 drivers/usb/dwc2/params.c                          |   2 +
 drivers/usb/dwc2/platform.c                        |  26 +-
 drivers/usb/dwc3/dwc3-imx8mp.c                     | 113 ++-
 drivers/usb/dwc3/dwc3-octeon.c                     |  19 +-
 drivers/usb/dwc3/dwc3-qcom.c                       |  16 +-
 drivers/usb/dwc3/dwc3-rtk.c                        |  52 +-
 drivers/usb/dwc3/dwc3-st.c                         |  38 +-
 drivers/usb/dwc3/dwc3-xilinx.c                     |   7 +-
 drivers/usb/gadget/configfs.c                      |  12 +-
 drivers/usb/gadget/function/f_acm.c                |  52 +-
 drivers/usb/gadget/function/f_fs.c                 |  14 +-
 drivers/usb/gadget/function/f_hid.c                | 275 +++++-
 drivers/usb/gadget/function/f_loopback.c           |   2 +-
 drivers/usb/gadget/function/f_mass_storage.c       |   3 +-
 drivers/usb/gadget/function/f_midi.c               |   2 +-
 drivers/usb/gadget/function/f_midi2.c              |   2 +-
 drivers/usb/gadget/function/f_sourcesink.c         |   2 +-
 drivers/usb/gadget/function/f_uac1.c               |  63 +-
 drivers/usb/gadget/function/f_uac2.c               |  80 +-
 drivers/usb/gadget/function/u_audio.c              |  10 +-
 drivers/usb/gadget/function/u_serial.c             |  22 +
 drivers/usb/gadget/function/u_serial.h             |   4 +
 drivers/usb/gadget/function/u_uac1.h               |  12 +-
 drivers/usb/gadget/function/u_uac2.h               |  15 +-
 drivers/usb/gadget/function/uvc_v4l2.c             |  12 +-
 drivers/usb/gadget/u_f.c                           |   2 +-
 drivers/usb/gadget/udc/bdc/bdc_core.c              |   1 +
 drivers/usb/gadget/udc/cdns2/cdns2-gadget.c        |   4 +-
 drivers/usb/gadget/udc/cdns2/cdns2-pci.c           |   7 +-
 drivers/usb/gadget/udc/dummy_hcd.c                 |  14 +-
 drivers/usb/gadget/udc/lpc32xx_udc.c               |  67 +-
 drivers/usb/gadget/udc/udc-xilinx.c                |   2 +-
 drivers/usb/host/Kconfig                           |   2 +-
 drivers/usb/host/ehci-brcm.c                       |   1 +
 drivers/usb/host/ehci-exynos.c                     |   9 +-
 drivers/usb/host/ohci-exynos.c                     |   9 +-
 drivers/usb/host/ohci-nxp.c                        |  18 +-
 drivers/usb/host/ohci-ppc-of.c                     |   4 -
 drivers/usb/host/r8a66597-hcd.c                    |   6 +-
 drivers/usb/host/xhci-dbgcap.c                     | 133 +--
 drivers/usb/host/xhci-dbgcap.h                     |   2 +-
 drivers/usb/host/xhci-dbgtty.c                     |   2 +-
 drivers/usb/host/xhci-ext-caps.h                   |   5 +
 drivers/usb/host/xhci-hub.c                        |  36 +
 drivers/usb/host/xhci-mem.c                        |   8 +-
 drivers/usb/host/xhci-pci-renesas.c                |  48 +-
 drivers/usb/host/xhci-pci.c                        |  98 ++-
 drivers/usb/host/xhci-pci.h                        |  19 +-
 drivers/usb/host/xhci-plat.c                       |   6 +
 drivers/usb/host/xhci-ring.c                       |  72 +-
 drivers/usb/host/xhci.c                            |  18 +-
 drivers/usb/host/xhci.h                            |  20 +-
 drivers/usb/misc/appledisplay.c                    |  15 +-
 drivers/usb/misc/brcmstb-usb-pinmap.c              |   1 +
 drivers/usb/misc/cypress_cy7c63.c                  |   4 +
 drivers/usb/misc/onboard_usb_dev.c                 |  78 ++
 drivers/usb/misc/onboard_usb_dev.h                 |   2 +
 drivers/usb/misc/qcom_eud.c                        |   2 +-
 drivers/usb/misc/yurex.c                           |  10 +-
 drivers/usb/musb/mediatek.c                        |  27 +-
 drivers/usb/musb/mpfs.c                            | 160 +++-
 drivers/usb/phy/phy-gpio-vbus-usb.c                |   1 +
 drivers/usb/phy/phy-mxs-usb.c                      | 132 ++-
 drivers/usb/roles/class.c                          |   7 +-
 drivers/usb/serial/aircable.c                      |   1 -
 drivers/usb/serial/ark3116.c                       |   1 -
 drivers/usb/serial/belkin_sa.c                     |   1 -
 drivers/usb/serial/ch341.c                         |   1 -
 drivers/usb/serial/cp210x.c                        |   1 -
 drivers/usb/serial/cyberjack.c                     |   1 -
 drivers/usb/serial/cypress_m8.c                    |   3 -
 drivers/usb/serial/digi_acceleport.c               |   2 -
 drivers/usb/serial/empeg.c                         |   1 -
 drivers/usb/serial/f81232.c                        |   2 -
 drivers/usb/serial/f81534.c                        |   1 -
 drivers/usb/serial/ftdi_sio.c                      |   1 -
 drivers/usb/serial/garmin_gps.c                    |   1 -
 drivers/usb/serial/generic.c                       |   1 -
 drivers/usb/serial/io_edgeport.c                   |   4 -
 drivers/usb/serial/io_ti.c                         |   2 -
 drivers/usb/serial/ipaq.c                          |   1 -
 drivers/usb/serial/ipw.c                           |   1 -
 drivers/usb/serial/ir-usb.c                        |   1 -
 drivers/usb/serial/iuu_phoenix.c                   |   1 -
 drivers/usb/serial/keyspan.c                       |   4 -
 drivers/usb/serial/keyspan_pda.c                   |   2 -
 drivers/usb/serial/kl5kusb105.c                    |   1 -
 drivers/usb/serial/kobil_sct.c                     |   4 +-
 drivers/usb/serial/mct_u232.c                      |   1 -
 drivers/usb/serial/metro-usb.c                     |   1 -
 drivers/usb/serial/mos7720.c                       |   1 -
 drivers/usb/serial/mos7840.c                       |   1 -
 drivers/usb/serial/mxuport.c                       |   1 -
 drivers/usb/serial/navman.c                        |   1 -
 drivers/usb/serial/omninet.c                       |   1 -
 drivers/usb/serial/opticon.c                       |   1 -
 drivers/usb/serial/option.c                        |   1 -
 drivers/usb/serial/oti6858.c                       |   1 -
 drivers/usb/serial/pl2303.c                        |   2 +-
 drivers/usb/serial/pl2303.h                        |   4 +
 drivers/usb/serial/qcaux.c                         |   1 -
 drivers/usb/serial/qcserial.c                      |   1 -
 drivers/usb/serial/quatech2.c                      |   1 -
 drivers/usb/serial/safe_serial.c                   |   1 -
 drivers/usb/serial/sierra.c                        |   1 -
 drivers/usb/serial/spcp8x5.c                       |   1 -
 drivers/usb/serial/ssu100.c                        |   1 -
 drivers/usb/serial/symbolserial.c                  |   1 -
 drivers/usb/serial/ti_usb_3410_5052.c              |   2 -
 drivers/usb/serial/upd78f0730.c                    |   1 -
 drivers/usb/serial/usb-serial-simple.c             |   1 -
 drivers/usb/serial/usb-serial.c                    |  12 +-
 drivers/usb/serial/usb_debug.c                     |   2 -
 drivers/usb/serial/visor.c                         |   3 -
 drivers/usb/serial/whiteheat.c                     |   2 -
 drivers/usb/serial/wishbone-serial.c               |   1 -
 drivers/usb/serial/xr_serial.c                     |   1 -
 drivers/usb/serial/xsens_mt.c                      |   1 -
 drivers/usb/storage/alauda.c                       |   4 +-
 drivers/usb/storage/cypress_atacb.c                |   4 +-
 drivers/usb/storage/datafab.c                      |   4 +-
 drivers/usb/storage/ene_ub6250.c                   |   6 +-
 drivers/usb/storage/freecom.c                      |   4 +-
 drivers/usb/storage/isd200.c                       |   4 +-
 drivers/usb/storage/jumpshot.c                     |   4 +-
 drivers/usb/storage/karma.c                        |   4 +-
 drivers/usb/storage/onetouch.c                     |   4 +-
 drivers/usb/storage/sddr09.c                       |   4 +-
 drivers/usb/storage/sddr55.c                       |   4 +-
 drivers/usb/storage/shuttle_usbat.c                |   4 +-
 drivers/usb/storage/uas.c                          |   2 +-
 drivers/usb/typec/anx7411.c                        |   6 +-
 drivers/usb/typec/tcpm/maxim_contaminant.c         |  53 +-
 drivers/usb/typec/tcpm/tcpci.c                     | 134 +--
 drivers/usb/typec/tcpm/tcpci_maxim.h               |  34 +-
 drivers/usb/typec/tcpm/tcpci_maxim_core.c          |  82 +-
 drivers/usb/typec/tcpm/tcpci_rt1711h.c             |  27 +-
 drivers/usb/typec/tipd/core.c                      |   3 +-
 drivers/usb/typec/ucsi/ucsi.c                      | 160 ++--
 drivers/usb/typec/ucsi/ucsi.h                      |  46 +-
 drivers/usb/typec/ucsi/ucsi_glink.c                |   2 +-
 drivers/usb/usbip/vhci_hcd.c                       |  36 +-
 drivers/usb/usbip/vhci_sysfs.c                     |   3 +-
 include/linux/mutex.h                              |  19 +-
 include/linux/usb.h                                |   8 +
 include/linux/usb/composite.h                      |   2 +-
 .../gadget/u_f.h => include/linux/usb/func_utils.h |   8 +-
 include/linux/usb/gadget_configfs.h                |   7 +-
 include/linux/usb/serial.h                         |   7 +-
 include/linux/usb/tcpci.h                          |  31 +-
 include/uapi/linux/usb/ch9.h                       |   8 +-
 include/uapi/linux/usb/functionfs.h                |  97 ++-
 include/uapi/linux/usb/g_hid.h                     |  40 +
 include/uapi/linux/usb/gadgetfs.h                  |   2 +-
 net/9p/Kconfig                                     |   6 +
 net/9p/Makefile                                    |   4 +
 net/9p/trans_usbg.c                                | 956 +++++++++++++++++++++
 tools/usb/p9_fwd.py                                | 243 ++++++
 189 files changed, 3861 insertions(+), 1249 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/fsl,ls1028a.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/msm-hsusb.txt
 create mode 100644 Documentation/usb/functionfs-desc.rst
 rename drivers/usb/gadget/u_f.h => include/linux/usb/func_utils.h (96%)
 create mode 100644 include/uapi/linux/usb/g_hid.h
 create mode 100644 net/9p/trans_usbg.c
 create mode 100755 tools/usb/p9_fwd.py


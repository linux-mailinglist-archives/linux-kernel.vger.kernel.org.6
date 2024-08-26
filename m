Return-Path: <linux-kernel+bounces-301848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E46FE95F66D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C9EC281ED8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F666194A40;
	Mon, 26 Aug 2024 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nEy0hWiD"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554F67E1;
	Mon, 26 Aug 2024 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724689461; cv=none; b=qWZ3EYalqrU2Mk0H6V9WpmC3Pv1/ocr6emizxvBEAq4l7xpg8QeR8rMVHCUsOtTG9ZxwHFUgX1DXR6frm1WpyA6ZRDIVyoZjIZxDS7fGyoD/8spoqkBVh+iiffscWm5XnNDc2VplqY038NO3JlUMHBlYlzYqfHX6dK8QHiuHy58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724689461; c=relaxed/simple;
	bh=MI1DHld11evWnJl0j41h7b1BUDgwHggz6IrVMlfsTss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RneXfKjejJrU6SfhKVYaEKqFOppGGgtyk4eZoQ/9/7OzVWjsbZZLAFGyu++Pe/bAAwzbqhngjHo5s0Wy0iga1FUy1z3wIjqOoKFaN+WF32Y5zfzbl9+j6SW1nGEauoI109wy1eRsSJTpd97YDjMbi+eqta0fhEJdnrhsFCazzVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nEy0hWiD; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9F58C1C0005;
	Mon, 26 Aug 2024 16:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724689457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nfc8PLjiZI1yal1Zw5qdC6sch+dLjIkryaHmHrDltCA=;
	b=nEy0hWiDyTDOmOnC6zc72H3MKP7Lj8caRgEwNYdc3FmeDqzZElJfnJ83VF4LPDKpV7i89E
	FYiKRx/JGLK6wfR19y5XtPi6fTApGf+VdyeWavu2j58HTuZCt+r+SDuAGeQVu9roNMzy1z
	22btLWzjpR9slRzA0nKHxxiaF3EygKDv9bStS18oIgHadqnrjs7KOSsihzruu4nMDvFZT8
	gIxLAbz60Ur84nrfrLPVCLxKrh+Vcb+FteuwjCiO/xWVyvxuSZH3JrEr6T/HRDifHBzQXp
	/WH00eIJGLVffurp7PPTm7OcpED2V5Fj2jIa1PscrnWgI++yFcme+humBZ74yA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	John Ogness <john.ogness@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 0/2] hexdump: Allow skipping identical lines
Date: Mon, 26 Aug 2024 18:24:14 +0200
Message-ID: <20240826162416.74501-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

Hello!

While working on NAND issues, I used print_hex_dump() a lot to compare
data. But I am mostly working on embedded systems where the kernel
messages go through a serial console. Sometimes network support is an
option, sometimes not. Anyway, I often print buffers both in kernel
space and user space to compare them, and they may be full of 0's or
1's, which means lines are repeated a lot in the output and this is slow
*and* hard to compare.

I initially hacked into lib/hexdump.c for my own purpose and just
discarded all the other users, but it felt like this might be a useful
feature for others and decided to make it a public patch.

* First patch changes the "ascii" parameter into a "flags" variable now
  accepting the value: DUMP_FLAG_ASCII.
* Second patch adds a new flag to skip the identical lines, because this
  must be an opt-in parameter, I guess.

The patch series has successfully gone through a round of
kernel-test-robot.

The Cc-list, as provided by get_maintainers.pl, was returning 330
e-mail addresses which felt to much, so I ran the script only on the
second patch (the printk/includes/debug/Doc changes). It gave this
Cc-list which sounds more reasonable. Hopefully this is a smart move,
otherwise let me know what you think would be better.

Cheers,
Miquèl

Miquel Raynal (2):
  hexdump: Convert the ascii boolean into a flag variable
  hexdump: Allow skipping identical lines

 Documentation/core-api/printk-formats.rst     |   4 +-
 arch/um/include/shared/user.h                 |   6 +-
 arch/x86/kernel/mpparse.c                     |   2 +-
 arch/x86/kvm/svm/sev.c                        |   3 +-
 arch/xtensa/kernel/traps.c                    |   4 +-
 crypto/ansi_cprng.c                           |   2 +-
 crypto/testmgr.c                              |   2 +-
 drivers/acpi/nfit/core.c                      |   6 +-
 drivers/ata/libata-core.c                     |   3 +-
 drivers/ata/pata_parport/bpck.c               |   2 +-
 drivers/block/floppy.c                        |   4 +-
 drivers/cdx/controller/mcdi.c                 |  10 +-
 .../crypto/allwinner/sun8i-ce/sun8i-ce-core.c |   6 +-
 drivers/crypto/axis/artpec6_crypto.c          |   5 +-
 drivers/crypto/bcm/util.c                     |   2 +-
 drivers/crypto/bcm/util.h                     |   4 +-
 drivers/crypto/caam/blob_gen.c                |   6 +-
 drivers/crypto/caam/caamalg.c                 |  33 +++---
 drivers/crypto/caam/caamalg_desc.c            |  32 +++---
 drivers/crypto/caam/caamalg_qi.c              |  21 ++--
 drivers/crypto/caam/caamalg_qi2.c             |  63 ++++++-----
 drivers/crypto/caam/caamhash.c                |  67 +++++------
 drivers/crypto/caam/caampkc.c                 |   2 +-
 drivers/crypto/caam/caamprng.c                |   4 +-
 drivers/crypto/caam/caamrng.c                 |   4 +-
 drivers/crypto/caam/error.c                   |   3 +-
 drivers/crypto/caam/key_gen.c                 |   7 +-
 drivers/crypto/caam/sg_sw_sec4.h              |   3 +-
 drivers/crypto/ccp/platform-access.c          |   4 +-
 drivers/crypto/ccp/psp-dev.c                  |   4 +-
 drivers/crypto/ccp/sev-dev.c                  |   4 +-
 drivers/crypto/ccree/cc_driver.c              |   2 +-
 .../intel/qat/qat_common/adf_mstate_mgr.c     |   4 +-
 .../marvell/octeontx/otx_cptvf_reqmgr.c       |   8 +-
 .../marvell/octeontx2/otx2_cptvf_reqmgr.c     |   8 +-
 drivers/crypto/sa2ul.c                        |   2 +-
 drivers/firmware/efi/apple-properties.c       |  11 +-
 drivers/firmware/efi/cper-arm.c               |   2 +-
 drivers/firmware/efi/cper.c                   |   5 +-
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c    |   4 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 +-
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c    |   3 +-
 drivers/gpu/drm/display/drm_dp_mst_topology.c |   4 +-
 drivers/gpu/drm/drm_edid.c                    |   2 +-
 .../drm/i915/display/intel_crtc_state_dump.c  |   2 +-
 drivers/gpu/drm/i915/display/intel_display.c  |   4 +-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/r535.c    |   6 +-
 drivers/gpu/drm/omapdrm/dss/hdmi4_core.c      |   2 +-
 drivers/gpu/drm/omapdrm/dss/hdmi5_core.c      |   2 +-
 drivers/hv/channel_mgmt.c                     |   4 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c    |   2 +-
 drivers/infiniband/hw/irdma/cm.c              |   6 +-
 drivers/infiniband/hw/irdma/ctrl.c            | 104 +++++++++---------
 drivers/infiniband/hw/irdma/puda.c            |  20 ++--
 drivers/infiniband/hw/irdma/uda.c             |   6 +-
 drivers/infiniband/hw/mlx5/cq.c               |   2 +-
 drivers/infiniband/ulp/srp/ib_srp.c           |   2 +-
 drivers/input/touchscreen/melfas_mip4.c       |   6 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  |  12 +-
 drivers/macintosh/via-cuda.c                  |   2 +-
 drivers/macintosh/windfarm_smu_sat.c          |   4 +-
 drivers/mailbox/imx-mailbox.c                 |   4 +-
 drivers/media/common/tveeprom.c               |   2 +-
 drivers/media/dvb-core/dvb_net.c              |   3 +-
 drivers/media/firewire/firedtv-avc.c          |   4 +-
 drivers/media/pci/saa7164/saa7164-api.c       |   8 +-
 drivers/media/pci/saa7164/saa7164-core.c      |   4 +-
 .../media/platform/nxp/imx-jpeg/mxc-jpeg.c    |   2 +-
 drivers/media/platform/qcom/venus/hfi_venus.c |   2 +-
 drivers/media/platform/ti/cal/cal.c           |   4 +-
 drivers/media/usb/em28xx/em28xx-i2c.c         |   2 +-
 drivers/mfd/rave-sp.c                         |   4 +-
 drivers/misc/genwqe/genwqe_driver.h           |   2 +-
 drivers/mtd/tests/mtd_nandecctest.c           |   8 +-
 drivers/mtd/ubi/debug.c                       |   7 +-
 drivers/mtd/ubi/debug.h                       |   2 +-
 drivers/mtd/ubi/io.c                          |   7 +-
 drivers/net/arcnet/arcnet.c                   |   4 +-
 drivers/net/can/usb/etas_es58x/es58x_core.c   |   4 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c  |   2 +-
 drivers/net/can/usb/ucan.c                    |   2 +-
 drivers/net/ethernet/aeroflex/greth.c         |   7 +-
 drivers/net/ethernet/altera/altera_tse_main.c |   3 +-
 drivers/net/ethernet/amd/a2065.c              |   2 +-
 drivers/net/ethernet/amd/ariadne.c            |   2 +-
 drivers/net/ethernet/amd/pds_core/adminq.c    |   4 +-
 drivers/net/ethernet/cadence/macb_main.c      |   6 +-
 .../net/ethernet/cavium/thunder/nicvf_main.c  |   2 +-
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    |   2 +-
 drivers/net/ethernet/intel/e1000e/netdev.c    |   6 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c |   2 +-
 .../net/ethernet/intel/i40e/i40e_debugfs.c    |  12 +-
 drivers/net/ethernet/intel/iavf/iavf_common.c |   2 +-
 drivers/net/ethernet/intel/ice/ice_osdep.h    |   4 +-
 drivers/net/ethernet/intel/igb/igb_main.c     |   5 +-
 drivers/net/ethernet/intel/igc/igc_dump.c     |   4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   5 +-
 drivers/net/ethernet/mellanox/mlx4/en_tx.c    |   5 +-
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |   3 +-
 .../net/ethernet/mellanox/mlx5/core/lib/aso.c |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/wq.c  |   3 +-
 .../net/ethernet/mellanox/mlxfw/mlxfw_mfa2.c  |   3 +-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    |   2 +-
 drivers/net/ethernet/microchip/enc28j60.c     |   2 +-
 .../net/ethernet/pensando/ionic/ionic_main.c  |   7 +-
 .../ethernet/pensando/ionic/ionic_rx_filter.c |   3 +-
 drivers/net/ethernet/qlogic/qed/qed_ll2.c     |   2 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_io.c    |   2 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_main.c  |   2 +-
 drivers/net/ethernet/realtek/8139too.c        |   2 +-
 drivers/net/ethernet/smsc/smc9194.c           |   2 +-
 drivers/net/ethernet/vertexcom/mse102x.c      |   2 +-
 drivers/net/fddi/skfp/skfddi.c                |   3 +-
 drivers/net/phy/sfp.c                         |   6 +-
 drivers/net/tun.c                             |   3 +-
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h    |   2 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c   |   3 +-
 drivers/net/wireless/ath/wil6210/ethtool.c    |   2 +-
 drivers/net/wireless/ath/wil6210/fw_inc.c     |   3 +-
 drivers/net/wireless/ath/wil6210/txrx_edma.c  |   4 +-
 drivers/net/wireless/ath/wil6210/wil6210.h    |   9 +-
 drivers/net/wireless/ath/wil6210/wmi.c        |   2 +-
 drivers/net/wireless/broadcom/b43/main.c      |   2 +-
 drivers/net/wireless/intel/iwlegacy/common.h  |   6 +-
 .../net/wireless/intel/iwlwifi/iwl-debug.h    |   6 +-
 drivers/net/wireless/marvell/mwifiex/main.h   |   2 +-
 drivers/net/wireless/realtek/rtl8xxxu/core.c  |   4 +-
 drivers/net/wireless/realtek/rtw88/rtw8723x.c |   2 +-
 drivers/net/wireless/silabs/wfx/bh.c          |   2 +-
 drivers/net/wireless/silabs/wfx/hif_rx.c      |   4 +-
 drivers/net/wireless/ti/wl1251/wl1251.h       |   2 +-
 drivers/net/wireless/ti/wlcore/debug.h        |   2 +-
 drivers/net/wireless/ti/wlcore/sdio.c         |   4 +-
 drivers/nfc/mei_phy.c                         |   4 +-
 drivers/nfc/pn533/i2c.c                       |   2 +-
 drivers/nfc/pn533/pn533.c                     |   2 +-
 drivers/nfc/pn533/uart.c                      |   2 +-
 drivers/nfc/pn533/usb.c                       |   6 +-
 drivers/nfc/pn544/i2c.c                       |   2 +-
 drivers/nfc/pn544/pn544.c                     |   4 +-
 drivers/nfc/port100.c                         |   4 +-
 drivers/nfc/st21nfca/core.c                   |   2 +-
 drivers/nfc/st21nfca/i2c.c                    |   2 +-
 drivers/nfc/trf7970a.c                        |   4 +-
 drivers/pci/probe.c                           |   2 +-
 .../surface/aggregator/ssh_packet_layer.c     |   4 +-
 drivers/platform/x86/amd/pmf/tee-if.c         |   2 +-
 drivers/ras/amd/fmpm.c                        |   3 +-
 drivers/rpmsg/rpmsg_ns.c                      |   2 +-
 drivers/rpmsg/virtio_rpmsg_bus.c              |   4 +-
 drivers/s390/crypto/ap_queue.c                |   4 +-
 drivers/s390/crypto/zcrypt_api.c              |   8 +-
 drivers/s390/net/qeth_core_main.c             |   8 +-
 drivers/scsi/esas2r/esas2r_log.c              |   2 +-
 drivers/scsi/qedf/qedf_fip.c                  |   4 +-
 drivers/scsi/qedf/qedf_io.c                   |   2 +-
 drivers/scsi/qedf/qedf_main.c                 |   4 +-
 drivers/scsi/qla2xxx/qla_dbg.c                |   2 +-
 drivers/soc/ti/k3-ringacc.c                   |   2 +-
 drivers/spi/spi-pl022.c                       |   4 +-
 drivers/staging/nvec/nvec.c                   |   4 +-
 drivers/staging/nvec/nvec_ps2.c               |   2 +-
 .../vc04_services/vchiq-mmal/mmal-vchiq.c     |   4 +-
 drivers/tty/n_gsm.c                           |   4 +-
 drivers/ufs/core/ufshcd.c                     |   2 +-
 drivers/usb/class/usbtmc.c                    |  14 ++-
 drivers/usb/core/devio.c                      |   6 +-
 drivers/usb/gadget/function/f_ncm.c           |   2 +-
 drivers/usb/gadget/udc/gr_udc.c               |   2 +-
 drivers/usb/usbip/usbip_common.c              |   2 +-
 .../video/fbdev/omap2/omapfb/dss/hdmi4_core.c |   2 +-
 .../video/fbdev/omap2/omapfb/dss/hdmi5_core.c |   2 +-
 drivers/watchdog/wdrtas.c                     |   2 +-
 fs/ceph/mdsmap.c                              |   2 +-
 fs/ecryptfs/debug.c                           |   2 +-
 fs/ext4/super.c                               |   2 +-
 fs/jfs/xattr.c                                |   2 +-
 fs/seq_file.c                                 |   2 +-
 fs/smb/client/cifs_debug.c                    |   2 +-
 fs/smb/client/misc.c                          |   2 +-
 fs/ubifs/debug.c                              |   2 +-
 fs/ubifs/scan.c                               |   3 +-
 fs/xfs/xfs_message.c                          |   3 +-
 include/linux/dma/ti-cppi5.h                  |   2 +-
 include/linux/dynamic_debug.h                 |   8 +-
 include/linux/filter.h                        |   2 +-
 include/linux/mlx5/cq.h                       |   2 +-
 include/linux/printk.h                        |  23 ++--
 include/net/6lowpan.h                         |   4 +-
 lib/hexdump.c                                 |  29 ++++-
 lib/test_bitmap.c                             |   4 +-
 mm/debug.c                                    |   4 +-
 mm/dmapool.c                                  |   2 +-
 mm/kmemleak.c                                 |   2 +-
 mm/page_poison.c                              |   2 +-
 mm/slub.c                                     |   3 +-
 net/atm/br2684.c                              |   3 +-
 net/atm/lec.c                                 |   6 +-
 net/ceph/crypto.c                             |   6 +-
 net/ceph/messenger.c                          |   9 +-
 net/ceph/osdmap.c                             |   4 +-
 net/core/skbuff.c                             |   8 +-
 net/ipv4/route.c                              |   2 +-
 net/nfc/digital_core.c                        |   4 +-
 net/nfc/llcp_core.c                           |   5 +-
 samples/rpmsg/rpmsg_client_sample.c           |   2 +-
 security/integrity/ima/ima_kexec.c            |   2 +-
 sound/soc/codecs/hdac_hdmi.c                  |   2 +-
 sound/soc/intel/atom/sst/sst_ipc.c            |   2 +-
 sound/soc/intel/catpt/loader.c                |  14 +--
 sound/soc/intel/skylake/skl-messages.c        |   2 +-
 sound/soc/intel/skylake/skl-sst-ipc.c         |   2 +-
 sound/soc/sof/ipc3.c                          |   2 +-
 sound/soc/sof/ipc4.c                          |   2 +-
 sound/usb/bcd2000/bcd2000.c                   |   2 +-
 sound/usb/quirks.c                            |   4 +-
 sound/usb/validate.c                          |   6 +-
 .../crypto/chacha20-s390/test-cipher.c        |  23 ++--
 tools/testing/nvdimm/test/nfit.c              |   2 +-
 219 files changed, 655 insertions(+), 532 deletions(-)

-- 
2.43.0



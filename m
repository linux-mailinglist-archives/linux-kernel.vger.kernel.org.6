Return-Path: <linux-kernel+bounces-301850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 209B695F678
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A9391C2204B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF886197A97;
	Mon, 26 Aug 2024 16:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Crzd+/4B"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AA419412F;
	Mon, 26 Aug 2024 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724689469; cv=none; b=UckN1MI0C688wiH0RX+SfZHHE3PG8+584OdfvruOADCJ27mFtbqnIzSwHLyABRMy/5mZgxSo04K1Z7fGRdrjz6+XwjwrNdeLZPWwH+caMFWL1XRc9STTR5ungkdDWmVhVIh7UvuGVVXO/oBSETlk/le94ccBnq9yrPEMu171Ah8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724689469; c=relaxed/simple;
	bh=rlftHGxH28nEaJCTrfriKY7Rax88fwqYTw7CMyLYa3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZjMbsZjhpGAYheZnFG+elcXnVqz1G6u6Jh70QeSP1xJjDyQCk0oJ4DCHhBoBlkT1/PCNSXh9PIw90oTA1SmuC8awnndufpEZ8EoHQHcDRsmGx1U0oJdZ/Crbvm2O0GY3XOp/XpmUm1KJ9F60ypPpXFe0FblAsqb2nTZxIHOga0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Crzd+/4B; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EBF7C1C0009;
	Mon, 26 Aug 2024 16:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724689458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RbCOkRZTmOCrn2gLdz0jcb9a3kwX8HuoqtbxZL6LiDk=;
	b=Crzd+/4BLd3vRutJ1whiECm34MxvhZGQ3gnlM/6wNKIvLajbOBBT9wSLbL0RR+CAdqAfKP
	1wuEU0DxiTu02MDzQrcKXkSBmsXppPe90+meSLNwp4kfDi8en4K0Q1ZD/JDmEugnJNQvmo
	gQQGQZNfIgaLtfwO2aMNq7phCOEy7L5ycKSCGGOZIXzKVpqNrJJ8ezwuA0qGT0w5O36bTP
	yz7qWKq5p7AZjEWWCIAgsv0QPZLIalmtAEfYI/HcJTAoTOT0ZSiBu55w1eOEQSDobxA296
	F9kMzJauRj96u+Snn0x0t6yznIoQoDeIG5ng0t9fqRZOGgxSZO50nGfIalOy4w==
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
Subject: [PATCH 1/2] hexdump: Convert the ascii boolean into a flag variable
Date: Mon, 26 Aug 2024 18:24:15 +0200
Message-ID: <20240826162416.74501-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240826162416.74501-1-miquel.raynal@bootlin.com>
References: <20240826162416.74501-1-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

The print_hex_dump() prototype is already quite long and there are
already several hundred in-tree users. One argument is a boolean for
enabling the ascii output. This is one way to format the buffer. We
could think of other ways, which in this case might need other booleans
to be enabled. In order to avoid messing several times with the
prototype (and all the callers), let's switch to a 'flags'
variable which can be easily extended.

There is no behavioral change intended.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
I tried to play with Coccinelle for the first time in order to address
the 600+ occurences of print_hex_dump, print_hex_dump_debug and
dynamic_hex_dump. I believe I managed to handle most of the cases
(compared using git grep) except several places enclosed inside
comments, '#if 0' and macros. I did not find an actual reason why the
kernel configuration would have an impact but apparently it did. I
didn't find advanced (and readable) resources on the Internet to fix
that, so here is the script. Nevertheless, it's a great and powerful
tool.

@@
expression E;
@@

(
print_hex_dump
|
print_hex_dump_debug
|
dynamic_hex_dump
)
 (E,...,
(
- true
+ DUMP_FLAG_ASCII
|
- 1
+ DUMP_FLAG_ASCII
|
- false
+ 0
)
 );
---
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
 include/linux/printk.h                        |  22 ++--
 include/net/6lowpan.h                         |   4 +-
 lib/hexdump.c                                 |  10 +-
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
 218 files changed, 633 insertions(+), 530 deletions(-)

diff --git a/arch/um/include/shared/user.h b/arch/um/include/shared/user.h
index bbab79c0c074..aa9acd40b11b 100644
--- a/arch/um/include/shared/user.h
+++ b/arch/um/include/shared/user.h
@@ -44,7 +44,8 @@ extern int _printk(const char *fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
 extern void print_hex_dump(const char *level, const char *prefix_str,
 			   int prefix_type, int rowsize, int groupsize,
-			   const void *buf, size_t len, _Bool ascii);
+			   const void *buf, size_t len,
+			   unsigned int flags);
 #else
 static inline int printk(const char *fmt, ...)
 {
@@ -52,7 +53,8 @@ static inline int printk(const char *fmt, ...)
 }
 static inline void print_hex_dump(const char *level, const char *prefix_str,
 				  int prefix_type, int rowsize, int groupsize,
-				  const void *buf, size_t len, _Bool ascii)
+				  const void *buf, size_t len,
+				  unsigned int flags)
 {
 }
 #endif
diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index e89171b0347a..cbf6369f8ef8 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -183,7 +183,7 @@ static void __init smp_dump_mptable(struct mpc_table *mpc, unsigned char *mpt)
 	pr_err("Your mptable is wrong, contact your HW vendor!\n");
 	pr_cont("type %x\n", *mpt);
 	print_hex_dump(KERN_ERR, "  ", DUMP_PREFIX_ADDRESS, 16,
-			1, mpc, mpc->length, 1);
+			1, mpc, mpc->length, DUMP_FLAG_ASCII);
 }
 
 static int __init smp_read_mpc(struct mpc_table *mpc, unsigned early)
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index a16c873b3232..e3f1bc48d83b 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -891,7 +891,8 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
 	}
 
 	pr_debug("Virtual Machine Save Area (VMSA):\n");
-	print_hex_dump_debug("", DUMP_PREFIX_NONE, 16, 1, save, sizeof(*save), false);
+	print_hex_dump_debug("", DUMP_PREFIX_NONE, 16, 1, save, sizeof(*save),
+			     0);
 
 	return 0;
 }
diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 38092d21acf8..b4a2632e2a8e 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -184,7 +184,7 @@ static inline void dump_user_code(struct pt_regs *regs)
 
 	if (copy_from_user(buf, (void __user *)(regs->pc & -16), sizeof(buf)) == 0) {
 		print_hex_dump(KERN_INFO, " ", DUMP_PREFIX_NONE,
-			       32, 1, buf, sizeof(buf), false);
+			       32, 1, buf, sizeof(buf), 0);
 
 	}
 }
@@ -596,7 +596,7 @@ static int show_stack_fragment_cb(struct stackframe *frame, void *data)
 		__memcpy(line, sf->sp + sf->off, line_len);
 		print_hex_dump(sf->loglvl, arrow ? "> " : "  ", DUMP_PREFIX_NONE,
 			       STACK_DUMP_LINE_SIZE, STACK_DUMP_ENTRY_SIZE,
-			       line, line_len, false);
+			       line, line_len, 0);
 		sf->off += STACK_DUMP_LINE_SIZE;
 		if (arrow)
 			return 0;
diff --git a/crypto/ansi_cprng.c b/crypto/ansi_cprng.c
index 3f512efaba3a..7a4098766ffd 100644
--- a/crypto/ansi_cprng.c
+++ b/crypto/ansi_cprng.c
@@ -56,7 +56,7 @@ static void hexdump(char *note, unsigned char *buf, unsigned int len)
 		printk(KERN_CRIT "%s", note);
 		print_hex_dump(KERN_CONT, "", DUMP_PREFIX_OFFSET,
 				16, 1,
-				buf, len, false);
+				buf, len, 0);
 	}
 }
 
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index f02cb075bd68..3354ff445b98 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -159,7 +159,7 @@ static void hexdump(unsigned char *buf, unsigned int len)
 {
 	print_hex_dump(KERN_CONT, "", DUMP_PREFIX_OFFSET,
 			16, 1,
-			buf, len, false);
+			buf, len, 0);
 }
 
 static int __testmgr_alloc_buf(char *buf[XBUFSIZE], int order)
diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 5429ec9ef06f..fa1fb380cb57 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -532,7 +532,8 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 	if (payload_dumpable(nvdimm, func))
 		print_hex_dump_debug("nvdimm in  ", DUMP_PREFIX_OFFSET, 4, 4,
 				in_buf.buffer.pointer,
-				min_t(u32, 256, in_buf.buffer.length), true);
+				min_t(u32, 256, in_buf.buffer.length),
+				DUMP_FLAG_ASCII);
 
 	/* call the BIOS, prefer the named methods over _DSM if available */
 	if (nvdimm && cmd == ND_CMD_GET_CONFIG_SIZE
@@ -575,7 +576,8 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 			cmd_name, out_obj->buffer.length);
 	print_hex_dump_debug(cmd_name, DUMP_PREFIX_OFFSET, 4, 4,
 			out_obj->buffer.pointer,
-			min_t(u32, 128, out_obj->buffer.length), true);
+			min_t(u32, 128, out_obj->buffer.length),
+			DUMP_FLAG_ASCII);
 
 	if (call_pkg) {
 		call_pkg->nd_fw_size = out_obj->buffer.length;
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c7752dc80028..40084f6a35a9 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1840,7 +1840,8 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 			    "class=%d may_fallback=%d tried_spinup=%d\n",
 			    class, may_fallback, tried_spinup);
 		print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET,
-			       16, 2, id, ATA_ID_WORDS * sizeof(*id), true);
+			       16, 2, id, ATA_ID_WORDS * sizeof(*id),
+			       DUMP_FLAG_ASCII);
 	}
 
 	/* Falling back doesn't make sense if ID data was read
diff --git a/drivers/ata/pata_parport/bpck.c b/drivers/ata/pata_parport/bpck.c
index bba1eda65f36..1f59fa739a20 100644
--- a/drivers/ata/pata_parport/bpck.c
+++ b/drivers/ata/pata_parport/bpck.c
@@ -368,7 +368,7 @@ static int bpck_test_proto(struct pi_adapter *pi)
 	dev_dbg(&pi->dev, "bpck: 0x%x unit %d mode %d: ",
 		pi->port, pi->unit, pi->mode);
 	print_hex_dump_debug("bpck: ", DUMP_PREFIX_NONE, TEST_LEN, 1, buf,
-			     TEST_LEN, false);
+			     TEST_LEN, 0);
 
 	e = 0;
 	for (i = 0; i < TEST_LEN; i++) {
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 3affb538b989..d65ce8e27c02 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -1073,7 +1073,7 @@ static void setup_DMA(void)
 	if (raw_cmd->length == 0) {
 		print_hex_dump(KERN_INFO, "zero dma transfer size: ",
 			       DUMP_PREFIX_NONE, 16, 1,
-			       raw_cmd->fullcmd, raw_cmd->cmd_count, false);
+			       raw_cmd->fullcmd, raw_cmd->cmd_count, 0);
 		cont->done(0);
 		fdc_state[current_fdc].reset = 1;
 		return;
@@ -1847,7 +1847,7 @@ static void show_floppy(int fdc)
 	pr_info("last result at %lu\n", resultjiffies);
 	pr_info("last redo_fd_request at %lu\n", lastredo);
 	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE, 16, 1,
-		       reply_buffer, resultsize, true);
+		       reply_buffer, resultsize, DUMP_FLAG_ASCII);
 
 	pr_info("status=%x\n", fdc_inb(fdc, FD_STATUS));
 	pr_info("fdc_busy=%lu\n", fdc_busy);
diff --git a/drivers/cdx/controller/mcdi.c b/drivers/cdx/controller/mcdi.c
index 1eedc5eeb315..ed6ba1a01329 100644
--- a/drivers/cdx/controller/mcdi.c
+++ b/drivers/cdx/controller/mcdi.c
@@ -261,8 +261,10 @@ static void cdx_mcdi_send_request(struct cdx_mcdi *cdx,
 	hdr[0].cdx_u32 |= (__force __le32)(cdx_mcdi_payload_csum(hdr, hdr_len, inbuf, inlen) <<
 			 MCDI_HEADER_XFLAGS_LBN);
 
-	print_hex_dump_debug("MCDI REQ HEADER: ", DUMP_PREFIX_NONE, 32, 4, hdr, hdr_len, false);
-	print_hex_dump_debug("MCDI REQ PAYLOAD: ", DUMP_PREFIX_NONE, 32, 4, inbuf, inlen, false);
+	print_hex_dump_debug("MCDI REQ HEADER: ", DUMP_PREFIX_NONE, 32, 4, hdr, hdr_len,
+			     0);
+	print_hex_dump_debug("MCDI REQ PAYLOAD: ", DUMP_PREFIX_NONE, 32, 4, inbuf, inlen,
+			     0);
 
 	cdx->mcdi_ops->mcdi_request(cdx, hdr, hdr_len, inbuf, inlen);
 
@@ -651,9 +653,9 @@ static bool cdx_mcdi_complete_cmd(struct cdx_mcdi_iface *mcdi,
 	}
 
 	print_hex_dump_debug("MCDI RESP HEADER: ", DUMP_PREFIX_NONE, 32, 4,
-			     outbuf, resp_hdr_len, false);
+			     outbuf, resp_hdr_len, 0);
 	print_hex_dump_debug("MCDI RESP PAYLOAD: ", DUMP_PREFIX_NONE, 32, 4,
-			     outbuf + (resp_hdr_len / 4), resp_data_len, false);
+			     outbuf + (resp_hdr_len / 4), resp_data_len, 0);
 
 	if (error && resp_data_len == 0) {
 		/* MC rebooted during command */
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
index e55e58e164db..3d482260a85d 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
@@ -228,7 +228,7 @@ int sun8i_ce_run_task(struct sun8i_ce_dev *ce, int flow, const char *name)
 			dev_err(ce->dev, "CE ERROR: %x for flow %x\n", v, flow);
 			err = -EFAULT;
 			print_hex_dump(KERN_INFO, "TASK: ", DUMP_PREFIX_NONE, 16, 4,
-				       cet, sizeof(struct ce_task), false);
+				       cet, sizeof(struct ce_task), 0);
 		}
 		if (v & CE_ERR_ALGO_NOTSUP)
 			dev_err(ce->dev, "CE ERROR: algorithm not supported\n");
@@ -247,7 +247,7 @@ int sun8i_ce_run_task(struct sun8i_ce_dev *ce, int flow, const char *name)
 			dev_err(ce->dev, "CE ERROR: %x for flow %x\n", v, flow);
 			err = -EFAULT;
 			print_hex_dump(KERN_INFO, "TASK: ", DUMP_PREFIX_NONE, 16, 4,
-				       cet, sizeof(struct ce_task), false);
+				       cet, sizeof(struct ce_task), 0);
 		}
 		if (v & CE_ERR_ALGO_NOTSUP)
 			dev_err(ce->dev, "CE ERROR: algorithm not supported\n");
@@ -263,7 +263,7 @@ int sun8i_ce_run_task(struct sun8i_ce_dev *ce, int flow, const char *name)
 			dev_err(ce->dev, "CE ERROR: %x for flow %x\n", v, flow);
 			err = -EFAULT;
 			print_hex_dump(KERN_INFO, "TASK: ", DUMP_PREFIX_NONE, 16, 4,
-				       cet, sizeof(struct ce_task), false);
+				       cet, sizeof(struct ce_task), 0);
 		}
 		if (v & CE_ERR_ALGO_NOTSUP)
 			dev_err(ce->dev, "CE ERROR: algorithm not supported\n");
diff --git a/drivers/crypto/axis/artpec6_crypto.c b/drivers/crypto/axis/artpec6_crypto.c
index 75440ea6206e..46c054818dca 100644
--- a/drivers/crypto/axis/artpec6_crypto.c
+++ b/drivers/crypto/axis/artpec6_crypto.c
@@ -2206,10 +2206,11 @@ static void artpec6_crypto_complete_aead(struct crypto_async_request *req)
 				  authsize)) {
 			pr_debug("***EBADMSG:\n");
 			print_hex_dump_debug("ref:", DUMP_PREFIX_ADDRESS, 32, 1,
-					     input_tag, authsize, true);
+					     input_tag, authsize,
+					     DUMP_FLAG_ASCII);
 			print_hex_dump_debug("out:", DUMP_PREFIX_ADDRESS, 32, 1,
 					     req_ctx->decryption_tag,
-					     authsize, true);
+					     authsize, DUMP_FLAG_ASCII);
 
 			result = -EBADMSG;
 		}
diff --git a/drivers/crypto/bcm/util.c b/drivers/crypto/bcm/util.c
index d5d9cabea55a..54cd8ca7112a 100644
--- a/drivers/crypto/bcm/util.c
+++ b/drivers/crypto/bcm/util.c
@@ -283,7 +283,7 @@ void __dump_sg(struct scatterlist *sg, unsigned int skip, unsigned int len)
 			sg_copy_part_to_buf(sg, dbuf, count, idx);
 			num_out += count;
 			print_hex_dump(KERN_ALERT, "  sg: ", DUMP_PREFIX_NONE,
-				       4, 1, dbuf, count, false);
+				       4, 1, dbuf, count, 0);
 			idx += 16;
 		}
 	}
diff --git a/drivers/crypto/bcm/util.h b/drivers/crypto/bcm/util.h
index 61c256384816..06b96e792b01 100644
--- a/drivers/crypto/bcm/util.h
+++ b/drivers/crypto/bcm/util.h
@@ -28,7 +28,7 @@ extern int debug_logging_sleep;
 	do {	                                 \
 		if (flow_debug_logging) {	           \
 			print_hex_dump(KERN_ALERT, msg, DUMP_PREFIX_NONE,  \
-					16, 1, var, var_len, false); \
+				       16, 1, var, var_len, 0); \
 				if (debug_logging_sleep)	       \
 					msleep(debug_logging_sleep);   \
 		}                                    \
@@ -46,7 +46,7 @@ extern int debug_logging_sleep;
 	do {                                   \
 		if (packet_debug_logging) {          \
 			print_hex_dump(KERN_ALERT, msg, DUMP_PREFIX_NONE,  \
-					16, 1, var, var_len, false); \
+				       16, 1, var, var_len, 0); \
 			if (debug_logging_sleep)           \
 				msleep(debug_logging_sleep);     \
 		}                                    \
diff --git a/drivers/crypto/caam/blob_gen.c b/drivers/crypto/caam/blob_gen.c
index 87781c1534ee..e0c06f3f244a 100644
--- a/drivers/crypto/caam/blob_gen.c
+++ b/drivers/crypto/caam/blob_gen.c
@@ -126,10 +126,10 @@ int caam_process_blob(struct caam_blob_priv *priv,
 
 	print_hex_dump_debug("data@"__stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 1, info->input,
-			     info->input_len, false);
+			     info->input_len, 0);
 	print_hex_dump_debug("jobdesc@"__stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 1, desc,
-			     desc_bytes(desc), false);
+			     desc_bytes(desc), 0);
 
 	testres.err = 0;
 	init_completion(&testres.completion);
@@ -140,7 +140,7 @@ int caam_process_blob(struct caam_blob_priv *priv,
 		ret = testres.err;
 		print_hex_dump_debug("output@"__stringify(__LINE__)": ",
 				     DUMP_PREFIX_ADDRESS, 16, 1, info->output,
-				     output_len, false);
+				     output_len, 0);
 	}
 
 	if (ret == 0)
diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
index 066f08a3a040..1831a080a0b1 100644
--- a/drivers/crypto/caam/caamalg.c
+++ b/drivers/crypto/caam/caamalg.c
@@ -598,7 +598,8 @@ static int aead_setkey(struct crypto_aead *aead,
 	       keys.authkeylen + keys.enckeylen, keys.enckeylen,
 	       keys.authkeylen);
 	print_hex_dump_debug("key in @"__stringify(__LINE__)": ",
-			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
+			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen,
+			     DUMP_FLAG_ASCII);
 
 	/*
 	 * If DKP is supported, use it in the shared descriptor to generate
@@ -635,7 +636,8 @@ static int aead_setkey(struct crypto_aead *aead,
 
 	print_hex_dump_debug("ctx.key@"__stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, ctx->key,
-			     ctx->adata.keylen_pad + keys.enckeylen, 1);
+			     ctx->adata.keylen_pad + keys.enckeylen,
+			     DUMP_FLAG_ASCII);
 
 skip_split_key:
 	ctx->cdata.keylen = keys.enckeylen;
@@ -675,7 +677,8 @@ static int gcm_setkey(struct crypto_aead *aead,
 		return err;
 
 	print_hex_dump_debug("key in @"__stringify(__LINE__)": ",
-			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
+			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen,
+			     DUMP_FLAG_ASCII);
 
 	memcpy(ctx->key, key, keylen);
 	dma_sync_single_for_device(jrdev, ctx->key_dma, keylen, ctx->dir);
@@ -696,7 +699,8 @@ static int rfc4106_setkey(struct crypto_aead *aead,
 		return err;
 
 	print_hex_dump_debug("key in @"__stringify(__LINE__)": ",
-			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
+			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen,
+			     DUMP_FLAG_ASCII);
 
 	memcpy(ctx->key, key, keylen);
 
@@ -722,7 +726,8 @@ static int rfc4543_setkey(struct crypto_aead *aead,
 		return err;
 
 	print_hex_dump_debug("key in @"__stringify(__LINE__)": ",
-			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
+			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen,
+			     DUMP_FLAG_ASCII);
 
 	memcpy(ctx->key, key, keylen);
 
@@ -749,7 +754,8 @@ static int skcipher_setkey(struct crypto_skcipher *skcipher, const u8 *key,
 	const bool is_rfc3686 = alg->caam.rfc3686;
 
 	print_hex_dump_debug("key in @"__stringify(__LINE__)": ",
-			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
+			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen,
+			     DUMP_FLAG_ASCII);
 
 	ctx->cdata.keylen = keylen;
 	ctx->cdata.key_virt = key;
@@ -1046,7 +1052,7 @@ static void skcipher_crypt_done(struct device *jrdev, u32 *desc, u32 err,
 
 		print_hex_dump_debug("dstiv  @" __stringify(__LINE__)": ",
 				     DUMP_PREFIX_ADDRESS, 16, 4, req->iv,
-				     ivsize, 1);
+				     ivsize, DUMP_FLAG_ASCII);
 	}
 
 	caam_dump_sg("dst    @" __stringify(__LINE__)": ",
@@ -1261,7 +1267,8 @@ static void init_skcipher_job(struct skcipher_request *req,
 	int len, sec4_sg_index = 0;
 
 	print_hex_dump_debug("presciv@"__stringify(__LINE__)": ",
-			     DUMP_PREFIX_ADDRESS, 16, 4, req->iv, ivsize, 1);
+			     DUMP_PREFIX_ADDRESS, 16, 4, req->iv, ivsize,
+			     DUMP_FLAG_ASCII);
 	dev_dbg(jrdev, "asked=%d, cryptlen%d\n",
 	       (int)edesc->src_nents > 1 ? 100 : req->cryptlen, req->cryptlen);
 
@@ -1488,7 +1495,7 @@ static inline int chachapoly_crypt(struct aead_request *req, bool encrypt)
 	init_chachapoly_job(req, edesc, all_contig, encrypt);
 	print_hex_dump_debug("chachapoly jobdesc@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
-			     1);
+			     DUMP_FLAG_ASCII);
 
 	return aead_enqueue_req(jrdev, req);
 }
@@ -1522,7 +1529,7 @@ static inline int aead_crypt(struct aead_request *req, bool encrypt)
 
 	print_hex_dump_debug("aead jobdesc@"__stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, edesc->hw_desc,
-			     desc_bytes(edesc->hw_desc), 1);
+			     desc_bytes(edesc->hw_desc), DUMP_FLAG_ASCII);
 
 	return aead_enqueue_req(jrdev, req);
 }
@@ -1581,7 +1588,7 @@ static inline int gcm_crypt(struct aead_request *req, bool encrypt)
 
 	print_hex_dump_debug("aead jobdesc@"__stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, edesc->hw_desc,
-			     desc_bytes(edesc->hw_desc), 1);
+			     desc_bytes(edesc->hw_desc), DUMP_FLAG_ASCII);
 
 	return aead_enqueue_req(jrdev, req);
 }
@@ -1769,7 +1776,7 @@ static struct skcipher_edesc *skcipher_edesc_alloc(struct skcipher_request *req,
 
 	print_hex_dump_debug("skcipher sec4_sg@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, edesc->sec4_sg,
-			     sec4_sg_bytes, 1);
+			     sec4_sg_bytes, DUMP_FLAG_ASCII);
 
 	return edesc;
 }
@@ -1852,7 +1859,7 @@ static inline int skcipher_crypt(struct skcipher_request *req, bool encrypt)
 
 	print_hex_dump_debug("skcipher jobdesc@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, edesc->hw_desc,
-			     desc_bytes(edesc->hw_desc), 1);
+			     desc_bytes(edesc->hw_desc), DUMP_FLAG_ASCII);
 
 	desc = edesc->hw_desc;
 	/*
diff --git a/drivers/crypto/caam/caamalg_desc.c b/drivers/crypto/caam/caamalg_desc.c
index 7571e1ac913b..d0a3f3843375 100644
--- a/drivers/crypto/caam/caamalg_desc.c
+++ b/drivers/crypto/caam/caamalg_desc.c
@@ -116,7 +116,7 @@ void cnstr_shdsc_aead_null_encap(u32 * const desc, struct alginfo *adata,
 
 	print_hex_dump_debug("aead null enc shdesc@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
-			     1);
+			     DUMP_FLAG_ASCII);
 }
 EXPORT_SYMBOL(cnstr_shdsc_aead_null_encap);
 
@@ -203,7 +203,7 @@ void cnstr_shdsc_aead_null_decap(u32 * const desc, struct alginfo *adata,
 
 	print_hex_dump_debug("aead null dec shdesc@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
-			     1);
+			     DUMP_FLAG_ASCII);
 }
 EXPORT_SYMBOL(cnstr_shdsc_aead_null_decap);
 
@@ -355,7 +355,7 @@ void cnstr_shdsc_aead_encap(u32 * const desc, struct alginfo *cdata,
 
 	print_hex_dump_debug("aead enc shdesc@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
-			     1);
+			     DUMP_FLAG_ASCII);
 }
 EXPORT_SYMBOL(cnstr_shdsc_aead_encap);
 
@@ -472,7 +472,7 @@ void cnstr_shdsc_aead_decap(u32 * const desc, struct alginfo *cdata,
 
 	print_hex_dump_debug("aead dec shdesc@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
-			     1);
+			     DUMP_FLAG_ASCII);
 }
 EXPORT_SYMBOL(cnstr_shdsc_aead_decap);
 
@@ -618,7 +618,7 @@ void cnstr_shdsc_aead_givencap(u32 * const desc, struct alginfo *cdata,
 
 	print_hex_dump_debug("aead givenc shdesc@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
-			     1);
+			     DUMP_FLAG_ASCII);
 }
 EXPORT_SYMBOL(cnstr_shdsc_aead_givencap);
 
@@ -745,7 +745,7 @@ void cnstr_shdsc_gcm_encap(u32 * const desc, struct alginfo *cdata,
 
 	print_hex_dump_debug("gcm enc shdesc@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
-			     1);
+			     DUMP_FLAG_ASCII);
 }
 EXPORT_SYMBOL(cnstr_shdsc_gcm_encap);
 
@@ -840,7 +840,7 @@ void cnstr_shdsc_gcm_decap(u32 * const desc, struct alginfo *cdata,
 
 	print_hex_dump_debug("gcm dec shdesc@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
-			     1);
+			     DUMP_FLAG_ASCII);
 }
 EXPORT_SYMBOL(cnstr_shdsc_gcm_decap);
 
@@ -951,7 +951,7 @@ void cnstr_shdsc_rfc4106_encap(u32 * const desc, struct alginfo *cdata,
 
 	print_hex_dump_debug("rfc4106 enc shdesc@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
-			     1);
+			     DUMP_FLAG_ASCII);
 }
 EXPORT_SYMBOL(cnstr_shdsc_rfc4106_encap);
 
@@ -1046,7 +1046,7 @@ void cnstr_shdsc_rfc4106_decap(u32 * const desc, struct alginfo *cdata,
 
 	print_hex_dump_debug("rfc4106 dec shdesc@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
-			     1);
+			     DUMP_FLAG_ASCII);
 }
 EXPORT_SYMBOL(cnstr_shdsc_rfc4106_decap);
 
@@ -1129,7 +1129,7 @@ void cnstr_shdsc_rfc4543_encap(u32 * const desc, struct alginfo *cdata,
 
 	print_hex_dump_debug("rfc4543 enc shdesc@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
-			     1);
+			     DUMP_FLAG_ASCII);
 }
 EXPORT_SYMBOL(cnstr_shdsc_rfc4543_encap);
 
@@ -1217,7 +1217,7 @@ void cnstr_shdsc_rfc4543_decap(u32 * const desc, struct alginfo *cdata,
 
 	print_hex_dump_debug("rfc4543 dec shdesc@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
-			     1);
+			     DUMP_FLAG_ASCII);
 }
 EXPORT_SYMBOL(cnstr_shdsc_rfc4543_decap);
 
@@ -1350,7 +1350,7 @@ void cnstr_shdsc_chachapoly(u32 * const desc, struct alginfo *cdata,
 
 	print_hex_dump_debug("chachapoly shdesc@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
-			     1);
+			     DUMP_FLAG_ASCII);
 }
 EXPORT_SYMBOL(cnstr_shdsc_chachapoly);
 
@@ -1436,7 +1436,7 @@ void cnstr_shdsc_skcipher_encap(u32 * const desc, struct alginfo *cdata,
 
 	print_hex_dump_debug("skcipher enc shdesc@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
-			     1);
+			     DUMP_FLAG_ASCII);
 }
 EXPORT_SYMBOL(cnstr_shdsc_skcipher_encap);
 
@@ -1513,7 +1513,7 @@ void cnstr_shdsc_skcipher_decap(u32 * const desc, struct alginfo *cdata,
 
 	print_hex_dump_debug("skcipher dec shdesc@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
-			     1);
+			     DUMP_FLAG_ASCII);
 }
 EXPORT_SYMBOL(cnstr_shdsc_skcipher_decap);
 
@@ -1575,7 +1575,7 @@ void cnstr_shdsc_xts_skcipher_encap(u32 * const desc, struct alginfo *cdata)
 
 	print_hex_dump_debug("xts skcipher enc shdesc@" __stringify(__LINE__)
 			     ": ", DUMP_PREFIX_ADDRESS, 16, 4,
-			     desc, desc_bytes(desc), 1);
+			     desc, desc_bytes(desc), DUMP_FLAG_ASCII);
 }
 EXPORT_SYMBOL(cnstr_shdsc_xts_skcipher_encap);
 
@@ -1635,7 +1635,7 @@ void cnstr_shdsc_xts_skcipher_decap(u32 * const desc, struct alginfo *cdata)
 
 	print_hex_dump_debug("xts skcipher dec shdesc@" __stringify(__LINE__)
 			     ": ", DUMP_PREFIX_ADDRESS, 16, 4, desc,
-			     desc_bytes(desc), 1);
+			     desc_bytes(desc), DUMP_FLAG_ASCII);
 }
 EXPORT_SYMBOL(cnstr_shdsc_xts_skcipher_decap);
 
diff --git a/drivers/crypto/caam/caamalg_qi.c b/drivers/crypto/caam/caamalg_qi.c
index 743ce50c14f2..58c167ffb94d 100644
--- a/drivers/crypto/caam/caamalg_qi.c
+++ b/drivers/crypto/caam/caamalg_qi.c
@@ -213,7 +213,8 @@ static int aead_setkey(struct crypto_aead *aead, const u8 *key,
 		keys.authkeylen + keys.enckeylen, keys.enckeylen,
 		keys.authkeylen);
 	print_hex_dump_debug("key in @" __stringify(__LINE__)": ",
-			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
+			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen,
+			     DUMP_FLAG_ASCII);
 
 	/*
 	 * If DKP is supported, use it in the shared descriptor to generate
@@ -250,7 +251,8 @@ static int aead_setkey(struct crypto_aead *aead, const u8 *key,
 
 	print_hex_dump_debug("ctx.key@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, ctx->key,
-			     ctx->adata.keylen_pad + keys.enckeylen, 1);
+			     ctx->adata.keylen_pad + keys.enckeylen,
+			     DUMP_FLAG_ASCII);
 
 skip_split_key:
 	ctx->cdata.keylen = keys.enckeylen;
@@ -372,7 +374,8 @@ static int gcm_setkey(struct crypto_aead *aead,
 		return ret;
 
 	print_hex_dump_debug("key in @" __stringify(__LINE__)": ",
-			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
+			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen,
+			     DUMP_FLAG_ASCII);
 
 	memcpy(ctx->key, key, keylen);
 	dma_sync_single_for_device(jrdev->parent, ctx->key_dma, keylen,
@@ -476,7 +479,8 @@ static int rfc4106_setkey(struct crypto_aead *aead,
 		return ret;
 
 	print_hex_dump_debug("key in @" __stringify(__LINE__)": ",
-			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
+			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen,
+			     DUMP_FLAG_ASCII);
 
 	memcpy(ctx->key, key, keylen);
 	/*
@@ -582,7 +586,8 @@ static int rfc4543_setkey(struct crypto_aead *aead,
 		return ret;
 
 	print_hex_dump_debug("key in @" __stringify(__LINE__)": ",
-			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
+			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen,
+			     DUMP_FLAG_ASCII);
 
 	memcpy(ctx->key, key, keylen);
 	/*
@@ -632,7 +637,8 @@ static int skcipher_setkey(struct crypto_skcipher *skcipher, const u8 *key,
 	int ret = 0;
 
 	print_hex_dump_debug("key in @" __stringify(__LINE__)": ",
-			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
+			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen,
+			     DUMP_FLAG_ASCII);
 
 	ctx->cdata.keylen = keylen;
 	ctx->cdata.key_virt = key;
@@ -1232,7 +1238,8 @@ static void skcipher_done(struct caam_drv_req *drv_req, u32 status)
 
 	print_hex_dump_debug("dstiv  @" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, req->iv,
-			     edesc->src_nents > 1 ? 100 : ivsize, 1);
+			     edesc->src_nents > 1 ? 100 : ivsize,
+			     DUMP_FLAG_ASCII);
 	caam_dump_sg("dst    @" __stringify(__LINE__)": ",
 		     DUMP_PREFIX_ADDRESS, 16, 4, req->dst,
 		     edesc->dst_nents > 1 ? 100 : req->cryptlen, 1);
diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index 207dc422785a..d39ce8343f21 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -300,7 +300,8 @@ static int aead_setkey(struct crypto_aead *aead, const u8 *key,
 		keys.authkeylen + keys.enckeylen, keys.enckeylen,
 		keys.authkeylen);
 	print_hex_dump_debug("key in @" __stringify(__LINE__)": ",
-			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
+			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen,
+			     DUMP_FLAG_ASCII);
 
 	ctx->adata.keylen = keys.authkeylen;
 	ctx->adata.keylen_pad = split_key_len(ctx->adata.algtype &
@@ -315,7 +316,8 @@ static int aead_setkey(struct crypto_aead *aead, const u8 *key,
 				   keys.enckeylen, ctx->dir);
 	print_hex_dump_debug("ctx.key@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, ctx->key,
-			     ctx->adata.keylen_pad + keys.enckeylen, 1);
+			     ctx->adata.keylen_pad + keys.enckeylen,
+			     DUMP_FLAG_ASCII);
 
 	ctx->cdata.keylen = keys.enckeylen;
 
@@ -731,7 +733,8 @@ static int gcm_setkey(struct crypto_aead *aead,
 	if (ret)
 		return ret;
 	print_hex_dump_debug("key in @" __stringify(__LINE__)": ",
-			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
+			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen,
+			     DUMP_FLAG_ASCII);
 
 	memcpy(ctx->key, key, keylen);
 	dma_sync_single_for_device(dev, ctx->key_dma, keylen, ctx->dir);
@@ -827,7 +830,8 @@ static int rfc4106_setkey(struct crypto_aead *aead,
 		return ret;
 
 	print_hex_dump_debug("key in @" __stringify(__LINE__)": ",
-			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
+			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen,
+			     DUMP_FLAG_ASCII);
 
 	memcpy(ctx->key, key, keylen);
 	/*
@@ -926,7 +930,8 @@ static int rfc4543_setkey(struct crypto_aead *aead,
 		return ret;
 
 	print_hex_dump_debug("key in @" __stringify(__LINE__)": ",
-			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
+			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen,
+			     DUMP_FLAG_ASCII);
 
 	memcpy(ctx->key, key, keylen);
 	/*
@@ -954,7 +959,8 @@ static int skcipher_setkey(struct crypto_skcipher *skcipher, const u8 *key,
 	const bool is_rfc3686 = alg->caam.rfc3686;
 
 	print_hex_dump_debug("key in @" __stringify(__LINE__)": ",
-			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
+			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen,
+			     DUMP_FLAG_ASCII);
 
 	ctx->cdata.keylen = keylen;
 	ctx->cdata.key_virt = key;
@@ -1407,7 +1413,8 @@ static void skcipher_encrypt_done(void *cbk_ctx, u32 status)
 
 	print_hex_dump_debug("dstiv  @" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, req->iv,
-			     edesc->src_nents > 1 ? 100 : ivsize, 1);
+			     edesc->src_nents > 1 ? 100 : ivsize,
+			     DUMP_FLAG_ASCII);
 	caam_dump_sg("dst    @" __stringify(__LINE__)": ",
 		     DUMP_PREFIX_ADDRESS, 16, 4, req->dst,
 		     edesc->dst_nents > 1 ? 100 : req->cryptlen, 1);
@@ -1445,7 +1452,8 @@ static void skcipher_decrypt_done(void *cbk_ctx, u32 status)
 
 	print_hex_dump_debug("dstiv  @" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, req->iv,
-			     edesc->src_nents > 1 ? 100 : ivsize, 1);
+			     edesc->src_nents > 1 ? 100 : ivsize,
+			     DUMP_FLAG_ASCII);
 	caam_dump_sg("dst    @" __stringify(__LINE__)": ",
 		     DUMP_PREFIX_ADDRESS, 16, 4, req->dst,
 		     edesc->dst_nents > 1 ? 100 : req->cryptlen, 1);
@@ -3153,7 +3161,7 @@ static int ahash_set_sh_desc(struct crypto_ahash *ahash)
 				   desc_bytes(desc), DMA_BIDIRECTIONAL);
 	print_hex_dump_debug("ahash update shdesc@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
-			     1);
+			     DUMP_FLAG_ASCII);
 
 	/* ahash_update_first shared descriptor */
 	flc = &ctx->flc[UPDATE_FIRST];
@@ -3165,7 +3173,7 @@ static int ahash_set_sh_desc(struct crypto_ahash *ahash)
 				   desc_bytes(desc), DMA_BIDIRECTIONAL);
 	print_hex_dump_debug("ahash update first shdesc@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
-			     1);
+			     DUMP_FLAG_ASCII);
 
 	/* ahash_final shared descriptor */
 	flc = &ctx->flc[FINALIZE];
@@ -3177,7 +3185,7 @@ static int ahash_set_sh_desc(struct crypto_ahash *ahash)
 				   desc_bytes(desc), DMA_BIDIRECTIONAL);
 	print_hex_dump_debug("ahash final shdesc@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
-			     1);
+			     DUMP_FLAG_ASCII);
 
 	/* ahash_digest shared descriptor */
 	flc = &ctx->flc[DIGEST];
@@ -3189,7 +3197,7 @@ static int ahash_set_sh_desc(struct crypto_ahash *ahash)
 				   desc_bytes(desc), DMA_BIDIRECTIONAL);
 	print_hex_dump_debug("ahash digest shdesc@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
-			     1);
+			     DUMP_FLAG_ASCII);
 
 	return 0;
 }
@@ -3269,10 +3277,11 @@ static int hash_digest_key(struct caam_hash_ctx *ctx, u32 *keylen, u8 *key,
 	dpaa2_fl_set_len(out_fle, digestsize);
 
 	print_hex_dump_debug("key_in@" __stringify(__LINE__)": ",
-			     DUMP_PREFIX_ADDRESS, 16, 4, key, *keylen, 1);
+			     DUMP_PREFIX_ADDRESS, 16, 4, key, *keylen,
+			     DUMP_FLAG_ASCII);
 	print_hex_dump_debug("shdesc@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
-			     1);
+			     DUMP_FLAG_ASCII);
 
 	result.err = 0;
 	init_completion(&result.completion);
@@ -3290,7 +3299,7 @@ static int hash_digest_key(struct caam_hash_ctx *ctx, u32 *keylen, u8 *key,
 		ret = result.err;
 		print_hex_dump_debug("digested key@" __stringify(__LINE__)": ",
 				     DUMP_PREFIX_ADDRESS, 16, 4, key,
-				     digestsize, 1);
+				     digestsize, DUMP_FLAG_ASCII);
 	}
 
 	dma_unmap_single(ctx->dev, flc_dma, sizeof(flc->flc) + desc_bytes(desc),
@@ -3418,7 +3427,7 @@ static void ahash_done(void *cbk_ctx, u32 status)
 
 	print_hex_dump_debug("ctx@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, state->caam_ctx,
-			     ctx->ctx_len, 1);
+			     ctx->ctx_len, DUMP_FLAG_ASCII);
 
 	ahash_request_complete(req, ecode);
 }
@@ -3448,15 +3457,16 @@ static void ahash_done_bi(void *cbk_ctx, u32 status)
 
 	print_hex_dump_debug("buf@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, state->buf,
-			     state->buflen, 1);
+			     state->buflen, DUMP_FLAG_ASCII);
 
 	print_hex_dump_debug("ctx@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, state->caam_ctx,
-			     ctx->ctx_len, 1);
+			     ctx->ctx_len, DUMP_FLAG_ASCII);
 	if (req->result)
 		print_hex_dump_debug("result@" __stringify(__LINE__)": ",
 				     DUMP_PREFIX_ADDRESS, 16, 4, req->result,
-				     crypto_ahash_digestsize(ahash), 1);
+				     crypto_ahash_digestsize(ahash),
+				     DUMP_FLAG_ASCII);
 
 	ahash_request_complete(req, ecode);
 }
@@ -3483,7 +3493,7 @@ static void ahash_done_ctx_src(void *cbk_ctx, u32 status)
 
 	print_hex_dump_debug("ctx@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, state->caam_ctx,
-			     ctx->ctx_len, 1);
+			     ctx->ctx_len, DUMP_FLAG_ASCII);
 
 	ahash_request_complete(req, ecode);
 }
@@ -3513,15 +3523,16 @@ static void ahash_done_ctx_dst(void *cbk_ctx, u32 status)
 
 	print_hex_dump_debug("buf@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, state->buf,
-			     state->buflen, 1);
+			     state->buflen, DUMP_FLAG_ASCII);
 
 	print_hex_dump_debug("ctx@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, state->caam_ctx,
-			     ctx->ctx_len, 1);
+			     ctx->ctx_len, DUMP_FLAG_ASCII);
 	if (req->result)
 		print_hex_dump_debug("result@" __stringify(__LINE__)": ",
 				     DUMP_PREFIX_ADDRESS, 16, 4, req->result,
-				     crypto_ahash_digestsize(ahash), 1);
+				     crypto_ahash_digestsize(ahash),
+				     DUMP_FLAG_ASCII);
 
 	ahash_request_complete(req, ecode);
 }
@@ -3635,7 +3646,7 @@ static int ahash_update_ctx(struct ahash_request *req)
 
 		print_hex_dump_debug("buf@" __stringify(__LINE__)": ",
 				     DUMP_PREFIX_ADDRESS, 16, 4, buf,
-				     *buflen, 1);
+				     *buflen, DUMP_FLAG_ASCII);
 	}
 
 	return ret;
@@ -4089,7 +4100,7 @@ static int ahash_update_no_ctx(struct ahash_request *req)
 
 		print_hex_dump_debug("buf@" __stringify(__LINE__)": ",
 				     DUMP_PREFIX_ADDRESS, 16, 4, buf,
-				     *buflen, 1);
+				     *buflen, DUMP_FLAG_ASCII);
 	}
 
 	return ret;
@@ -4314,7 +4325,7 @@ static int ahash_update_first(struct ahash_request *req)
 
 		print_hex_dump_debug("buf@" __stringify(__LINE__)": ",
 				     DUMP_PREFIX_ADDRESS, 16, 4, buf,
-				     *buflen, 1);
+				     *buflen, DUMP_FLAG_ASCII);
 	}
 
 	return ret;
diff --git a/drivers/crypto/caam/caamhash.c b/drivers/crypto/caam/caamhash.c
index fdd724228c2f..fcab9d550629 100644
--- a/drivers/crypto/caam/caamhash.c
+++ b/drivers/crypto/caam/caamhash.c
@@ -221,7 +221,7 @@ static int ahash_set_sh_desc(struct crypto_ahash *ahash)
 
 	print_hex_dump_debug("ahash update shdesc@"__stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
-			     1);
+			     DUMP_FLAG_ASCII);
 
 	/* ahash_update_first shared descriptor */
 	desc = ctx->sh_desc_update_first;
@@ -231,7 +231,7 @@ static int ahash_set_sh_desc(struct crypto_ahash *ahash)
 				   desc_bytes(desc), ctx->dir);
 	print_hex_dump_debug("ahash update first shdesc@"__stringify(__LINE__)
 			     ": ", DUMP_PREFIX_ADDRESS, 16, 4, desc,
-			     desc_bytes(desc), 1);
+			     desc_bytes(desc), DUMP_FLAG_ASCII);
 
 	/* ahash_final shared descriptor */
 	desc = ctx->sh_desc_fin;
@@ -242,7 +242,7 @@ static int ahash_set_sh_desc(struct crypto_ahash *ahash)
 
 	print_hex_dump_debug("ahash final shdesc@"__stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc,
-			     desc_bytes(desc), 1);
+			     desc_bytes(desc), DUMP_FLAG_ASCII);
 
 	/* ahash_digest shared descriptor */
 	desc = ctx->sh_desc_digest;
@@ -253,7 +253,7 @@ static int ahash_set_sh_desc(struct crypto_ahash *ahash)
 
 	print_hex_dump_debug("ahash digest shdesc@"__stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc,
-			     desc_bytes(desc), 1);
+			     desc_bytes(desc), DUMP_FLAG_ASCII);
 
 	return 0;
 }
@@ -273,7 +273,7 @@ static int axcbc_set_sh_desc(struct crypto_ahash *ahash)
 				   desc_bytes(desc), ctx->dir);
 	print_hex_dump_debug("axcbc update shdesc@" __stringify(__LINE__)" : ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
-			     1);
+			     DUMP_FLAG_ASCII);
 
 	/* shared descriptor for ahash_{final,finup} */
 	desc = ctx->sh_desc_fin;
@@ -283,7 +283,7 @@ static int axcbc_set_sh_desc(struct crypto_ahash *ahash)
 				   desc_bytes(desc), ctx->dir);
 	print_hex_dump_debug("axcbc finup shdesc@" __stringify(__LINE__)" : ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
-			     1);
+			     DUMP_FLAG_ASCII);
 
 	/* key is immediate data for INIT and INITFINAL states */
 	ctx->adata.key_virt = ctx->key;
@@ -296,7 +296,7 @@ static int axcbc_set_sh_desc(struct crypto_ahash *ahash)
 				   desc_bytes(desc), ctx->dir);
 	print_hex_dump_debug("axcbc update first shdesc@" __stringify(__LINE__)
 			     " : ", DUMP_PREFIX_ADDRESS, 16, 4, desc,
-			     desc_bytes(desc), 1);
+			     desc_bytes(desc), DUMP_FLAG_ASCII);
 
 	/* shared descriptor for ahash_digest */
 	desc = ctx->sh_desc_digest;
@@ -306,7 +306,7 @@ static int axcbc_set_sh_desc(struct crypto_ahash *ahash)
 				   desc_bytes(desc), ctx->dir);
 	print_hex_dump_debug("axcbc digest shdesc@" __stringify(__LINE__)" : ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
-			     1);
+			     DUMP_FLAG_ASCII);
 	return 0;
 }
 
@@ -325,7 +325,7 @@ static int acmac_set_sh_desc(struct crypto_ahash *ahash)
 				   desc_bytes(desc), ctx->dir);
 	print_hex_dump_debug("acmac update shdesc@" __stringify(__LINE__)" : ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc,
-			     desc_bytes(desc), 1);
+			     desc_bytes(desc), DUMP_FLAG_ASCII);
 
 	/* shared descriptor for ahash_{final,finup} */
 	desc = ctx->sh_desc_fin;
@@ -335,7 +335,7 @@ static int acmac_set_sh_desc(struct crypto_ahash *ahash)
 				   desc_bytes(desc), ctx->dir);
 	print_hex_dump_debug("acmac finup shdesc@" __stringify(__LINE__)" : ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc,
-			     desc_bytes(desc), 1);
+			     desc_bytes(desc), DUMP_FLAG_ASCII);
 
 	/* shared descriptor for first invocation of ahash_update */
 	desc = ctx->sh_desc_update_first;
@@ -345,7 +345,7 @@ static int acmac_set_sh_desc(struct crypto_ahash *ahash)
 				   desc_bytes(desc), ctx->dir);
 	print_hex_dump_debug("acmac update first shdesc@" __stringify(__LINE__)
 			     " : ", DUMP_PREFIX_ADDRESS, 16, 4, desc,
-			     desc_bytes(desc), 1);
+			     desc_bytes(desc), DUMP_FLAG_ASCII);
 
 	/* shared descriptor for ahash_digest */
 	desc = ctx->sh_desc_digest;
@@ -355,7 +355,7 @@ static int acmac_set_sh_desc(struct crypto_ahash *ahash)
 				   desc_bytes(desc), ctx->dir);
 	print_hex_dump_debug("acmac digest shdesc@" __stringify(__LINE__)" : ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc,
-			     desc_bytes(desc), 1);
+			     desc_bytes(desc), DUMP_FLAG_ASCII);
 
 	return 0;
 }
@@ -394,10 +394,11 @@ static int hash_digest_key(struct caam_hash_ctx *ctx, u32 *keylen, u8 *key,
 			 LDST_SRCDST_BYTE_CONTEXT);
 
 	print_hex_dump_debug("key_in@"__stringify(__LINE__)": ",
-			     DUMP_PREFIX_ADDRESS, 16, 4, key, *keylen, 1);
+			     DUMP_PREFIX_ADDRESS, 16, 4, key, *keylen,
+			     DUMP_FLAG_ASCII);
 	print_hex_dump_debug("jobdesc@"__stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
-			     1);
+			     DUMP_FLAG_ASCII);
 
 	result.err = 0;
 	init_completion(&result.completion);
@@ -410,7 +411,7 @@ static int hash_digest_key(struct caam_hash_ctx *ctx, u32 *keylen, u8 *key,
 
 		print_hex_dump_debug("digested key@"__stringify(__LINE__)": ",
 				     DUMP_PREFIX_ADDRESS, 16, 4, key,
-				     digestsize, 1);
+				     digestsize, DUMP_FLAG_ASCII);
 	}
 	dma_unmap_single(jrdev, key_dma, *keylen, DMA_BIDIRECTIONAL);
 
@@ -505,7 +506,8 @@ static int axcbc_setkey(struct crypto_ahash *ahash, const u8 *key,
 	ctx->adata.keylen = keylen;
 
 	print_hex_dump_debug("axcbc ctx.key@" __stringify(__LINE__)" : ",
-			     DUMP_PREFIX_ADDRESS, 16, 4, ctx->key, keylen, 1);
+			     DUMP_PREFIX_ADDRESS, 16, 4, ctx->key, keylen,
+			     DUMP_FLAG_ASCII);
 
 	return axcbc_set_sh_desc(ahash);
 }
@@ -525,7 +527,8 @@ static int acmac_setkey(struct crypto_ahash *ahash, const u8 *key,
 	ctx->adata.keylen = keylen;
 
 	print_hex_dump_debug("acmac ctx.key@" __stringify(__LINE__)" : ",
-			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen, 1);
+			     DUMP_PREFIX_ADDRESS, 16, 4, key, keylen,
+			     DUMP_FLAG_ASCII);
 
 	return acmac_set_sh_desc(ahash);
 }
@@ -608,7 +611,7 @@ static inline void ahash_done_cpy(struct device *jrdev, u32 *desc, u32 err,
 
 	print_hex_dump_debug("ctx@"__stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, state->caam_ctx,
-			     ctx->ctx_len, 1);
+			     ctx->ctx_len, DUMP_FLAG_ASCII);
 
 	/*
 	 * If no backlog flag, the completion of the request is done
@@ -662,15 +665,15 @@ static inline void ahash_done_switch(struct device *jrdev, u32 *desc, u32 err,
 
 	print_hex_dump_debug("buf@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, state->buf,
-			     state->buflen, 1);
+			     state->buflen, DUMP_FLAG_ASCII);
 
 	print_hex_dump_debug("ctx@"__stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, state->caam_ctx,
-			     ctx->ctx_len, 1);
+			     ctx->ctx_len, DUMP_FLAG_ASCII);
 	if (req->result)
 		print_hex_dump_debug("result@"__stringify(__LINE__)": ",
 				     DUMP_PREFIX_ADDRESS, 16, 4, req->result,
-				     digestsize, 1);
+				     digestsize, DUMP_FLAG_ASCII);
 
 	/*
 	 * If no backlog flag, the completion of the request is done
@@ -920,7 +923,7 @@ static int ahash_update_ctx(struct ahash_request *req)
 
 		print_hex_dump_debug("jobdesc@"__stringify(__LINE__)": ",
 				     DUMP_PREFIX_ADDRESS, 16, 4, desc,
-				     desc_bytes(desc), 1);
+				     desc_bytes(desc), DUMP_FLAG_ASCII);
 
 		ret = ahash_enqueue_req(jrdev, ahash_done_bi, req,
 					ctx->ctx_len, DMA_BIDIRECTIONAL);
@@ -931,7 +934,7 @@ static int ahash_update_ctx(struct ahash_request *req)
 
 		print_hex_dump_debug("buf@" __stringify(__LINE__)": ",
 				     DUMP_PREFIX_ADDRESS, 16, 4, buf,
-				     *buflen, 1);
+				     *buflen, DUMP_FLAG_ASCII);
 	}
 
 	return ret;
@@ -992,7 +995,7 @@ static int ahash_final_ctx(struct ahash_request *req)
 
 	print_hex_dump_debug("jobdesc@"__stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
-			     1);
+			     DUMP_FLAG_ASCII);
 
 	return ahash_enqueue_req(jrdev, ahash_done_ctx_src, req,
 				 digestsize, DMA_BIDIRECTIONAL);
@@ -1066,7 +1069,7 @@ static int ahash_finup_ctx(struct ahash_request *req)
 
 	print_hex_dump_debug("jobdesc@"__stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
-			     1);
+			     DUMP_FLAG_ASCII);
 
 	return ahash_enqueue_req(jrdev, ahash_done_ctx_src, req,
 				 digestsize, DMA_BIDIRECTIONAL);
@@ -1136,7 +1139,7 @@ static int ahash_digest(struct ahash_request *req)
 
 	print_hex_dump_debug("jobdesc@"__stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
-			     1);
+			     DUMP_FLAG_ASCII);
 
 	return ahash_enqueue_req(jrdev, ahash_done, req, digestsize,
 				 DMA_FROM_DEVICE);
@@ -1181,7 +1184,7 @@ static int ahash_final_no_ctx(struct ahash_request *req)
 
 	print_hex_dump_debug("jobdesc@"__stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
-			     1);
+			     DUMP_FLAG_ASCII);
 
 	return ahash_enqueue_req(jrdev, ahash_done, req,
 				 digestsize, DMA_FROM_DEVICE);
@@ -1286,7 +1289,7 @@ static int ahash_update_no_ctx(struct ahash_request *req)
 
 		print_hex_dump_debug("jobdesc@"__stringify(__LINE__)": ",
 				     DUMP_PREFIX_ADDRESS, 16, 4, desc,
-				     desc_bytes(desc), 1);
+				     desc_bytes(desc), DUMP_FLAG_ASCII);
 
 		ret = ahash_enqueue_req(jrdev, ahash_done_ctx_dst, req,
 					ctx->ctx_len, DMA_TO_DEVICE);
@@ -1302,7 +1305,7 @@ static int ahash_update_no_ctx(struct ahash_request *req)
 
 		print_hex_dump_debug("buf@" __stringify(__LINE__)": ",
 				     DUMP_PREFIX_ADDRESS, 16, 4, buf,
-				     *buflen, 1);
+				     *buflen, DUMP_FLAG_ASCII);
 	}
 
 	return ret;
@@ -1377,7 +1380,7 @@ static int ahash_finup_no_ctx(struct ahash_request *req)
 
 	print_hex_dump_debug("jobdesc@"__stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
-			     1);
+			     DUMP_FLAG_ASCII);
 
 	return ahash_enqueue_req(jrdev, ahash_done, req,
 				 digestsize, DMA_FROM_DEVICE);
@@ -1466,7 +1469,7 @@ static int ahash_update_first(struct ahash_request *req)
 
 		print_hex_dump_debug("jobdesc@"__stringify(__LINE__)": ",
 				     DUMP_PREFIX_ADDRESS, 16, 4, desc,
-				     desc_bytes(desc), 1);
+				     desc_bytes(desc), DUMP_FLAG_ASCII);
 
 		ret = ahash_enqueue_req(jrdev, ahash_done_ctx_dst, req,
 					ctx->ctx_len, DMA_TO_DEVICE);
@@ -1485,7 +1488,7 @@ static int ahash_update_first(struct ahash_request *req)
 
 		print_hex_dump_debug("buf@" __stringify(__LINE__)": ",
 				     DUMP_PREFIX_ADDRESS, 16, 4, buf,
-				     *buflen, 1);
+				     *buflen, DUMP_FLAG_ASCII);
 	}
 
 	return ret;
diff --git a/drivers/crypto/caam/caampkc.c b/drivers/crypto/caam/caampkc.c
index 887a5f2fb927..25c69e4aadeb 100644
--- a/drivers/crypto/caam/caampkc.c
+++ b/drivers/crypto/caam/caampkc.c
@@ -358,7 +358,7 @@ static struct rsa_edesc *rsa_edesc_alloc(struct akcipher_request *req,
 
 	print_hex_dump_debug("caampkc sec4_sg@" __stringify(__LINE__) ": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, edesc->sec4_sg,
-			     edesc->sec4_sg_bytes, 1);
+			     edesc->sec4_sg_bytes, DUMP_FLAG_ASCII);
 
 	return edesc;
 
diff --git a/drivers/crypto/caam/caamprng.c b/drivers/crypto/caam/caamprng.c
index 6e4c1191cb28..7042cac62531 100644
--- a/drivers/crypto/caam/caamprng.c
+++ b/drivers/crypto/caam/caamprng.c
@@ -53,7 +53,7 @@ static u32 *caam_init_reseed_desc(u32 *desc)
 			OP_ALG_AS_FINALIZE);
 
 	print_hex_dump_debug("prng reseed desc@: ", DUMP_PREFIX_ADDRESS,
-			     16, 4, desc, desc_bytes(desc), 1);
+			     16, 4, desc, desc_bytes(desc), DUMP_FLAG_ASCII);
 
 	return desc;
 }
@@ -68,7 +68,7 @@ static u32 *caam_init_prng_desc(u32 *desc, dma_addr_t dst_dma, u32 len)
 			  len, FIFOST_TYPE_RNGSTORE);
 
 	print_hex_dump_debug("prng job desc@: ", DUMP_PREFIX_ADDRESS,
-			     16, 4, desc, desc_bytes(desc), 1);
+			     16, 4, desc, desc_bytes(desc), DUMP_FLAG_ASCII);
 
 	return desc;
 }
diff --git a/drivers/crypto/caam/caamrng.c b/drivers/crypto/caam/caamrng.c
index b3d14a7f4dd1..6efd4048a012 100644
--- a/drivers/crypto/caam/caamrng.c
+++ b/drivers/crypto/caam/caamrng.c
@@ -76,7 +76,7 @@ static u32 *caam_init_desc(u32 *desc, dma_addr_t dst_dma)
 			  CAAM_RNG_MAX_FIFO_STORE_SIZE, FIFOST_TYPE_RNGSTORE);
 
 	print_hex_dump_debug("rng job desc@: ", DUMP_PREFIX_ADDRESS,
-			     16, 4, desc, desc_bytes(desc), 1);
+			     16, 4, desc, desc_bytes(desc), DUMP_FLAG_ASCII);
 
 	return desc;
 }
@@ -194,7 +194,7 @@ static inline void test_len(struct hwrng *rng, size_t len, bool wait)
 
 		print_hex_dump_debug("random bytes@: ",
 			DUMP_PREFIX_ADDRESS, 16, 4,
-			buf, read_len, 1);
+			buf, read_len, DUMP_FLAG_ASCII);
 
 		len = len - read_len;
 	}
diff --git a/drivers/crypto/caam/error.c b/drivers/crypto/caam/error.c
index 72db90176b1a..5e74ae701717 100644
--- a/drivers/crypto/caam/error.c
+++ b/drivers/crypto/caam/error.c
@@ -36,7 +36,8 @@ void caam_dump_sg(const char *prefix_str, int prefix_type,
 		buf = it_page + it->offset;
 		len = min_t(size_t, tlen, it->length);
 		print_hex_dump_debug(prefix_str, prefix_type, rowsize,
-				     groupsize, buf, len, ascii);
+				     groupsize, buf, len,
+				     ascii ? DUMP_FLAG_ASCII : 0);
 		tlen -= len;
 
 		kunmap_atomic(it_page);
diff --git a/drivers/crypto/caam/key_gen.c b/drivers/crypto/caam/key_gen.c
index 88cc4fe2a585..b7c8a90a9f51 100644
--- a/drivers/crypto/caam/key_gen.c
+++ b/drivers/crypto/caam/key_gen.c
@@ -59,7 +59,8 @@ int gen_split_key(struct device *jrdev, u8 *key_out,
 	dev_dbg(jrdev, "split keylen %d split keylen padded %d\n",
 		adata->keylen, adata->keylen_pad);
 	print_hex_dump_debug("ctx.key@" __stringify(__LINE__)": ",
-			     DUMP_PREFIX_ADDRESS, 16, 4, key_in, keylen, 1);
+			     DUMP_PREFIX_ADDRESS, 16, 4, key_in, keylen,
+			     DUMP_FLAG_ASCII);
 
 	if (local_max > max_keylen)
 		return -EINVAL;
@@ -102,7 +103,7 @@ int gen_split_key(struct device *jrdev, u8 *key_out,
 
 	print_hex_dump_debug("jobdesc@"__stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, desc, desc_bytes(desc),
-			     1);
+			     DUMP_FLAG_ASCII);
 
 	result.err = 0;
 	init_completion(&result.completion);
@@ -115,7 +116,7 @@ int gen_split_key(struct device *jrdev, u8 *key_out,
 
 		print_hex_dump_debug("ctx.key@"__stringify(__LINE__)": ",
 				     DUMP_PREFIX_ADDRESS, 16, 4, key_out,
-				     adata->keylen_pad, 1);
+				     adata->keylen_pad, DUMP_FLAG_ASCII);
 	}
 
 	dma_unmap_single(jrdev, dma_addr, local_max, DMA_BIDIRECTIONAL);
diff --git a/drivers/crypto/caam/sg_sw_sec4.h b/drivers/crypto/caam/sg_sw_sec4.h
index 07e1ee99273b..31670aa0b889 100644
--- a/drivers/crypto/caam/sg_sw_sec4.h
+++ b/drivers/crypto/caam/sg_sw_sec4.h
@@ -37,7 +37,8 @@ static inline void dma_to_sec4_sg_one(struct sec4_sg_entry *sec4_sg_ptr,
 	}
 
 	print_hex_dump_debug("sec4_sg_ptr@: ", DUMP_PREFIX_ADDRESS, 16, 4,
-			     sec4_sg_ptr, sizeof(struct sec4_sg_entry), 1);
+			     sec4_sg_ptr, sizeof(struct sec4_sg_entry),
+			     DUMP_FLAG_ASCII);
 }
 
 /*
diff --git a/drivers/crypto/ccp/platform-access.c b/drivers/crypto/ccp/platform-access.c
index 1b8ed3389733..085f8771dd8c 100644
--- a/drivers/crypto/ccp/platform-access.c
+++ b/drivers/crypto/ccp/platform-access.c
@@ -100,7 +100,7 @@ int psp_send_platform_access_msg(enum psp_platform_access_msg msg,
 	iowrite32(upper_32_bits(req_addr), hi);
 
 	print_hex_dump_debug("->psp ", DUMP_PREFIX_OFFSET, 16, 2, req,
-			     req->header.payload_size, false);
+			     req->header.payload_size, 0);
 
 	/* Write command register to trigger processing */
 	cmd_reg = FIELD_PREP(PSP_CMDRESP_CMD, msg);
@@ -134,7 +134,7 @@ int psp_send_platform_access_msg(enum psp_platform_access_msg msg,
 	}
 
 	print_hex_dump_debug("<-psp ", DUMP_PREFIX_OFFSET, 16, 2, req,
-			     req->header.payload_size, false);
+			     req->header.payload_size, 0);
 
 	ret = 0;
 
diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
index 1c5a7189631e..f8349ce8e048 100644
--- a/drivers/crypto/ccp/psp-dev.c
+++ b/drivers/crypto/ccp/psp-dev.c
@@ -86,7 +86,7 @@ int psp_extended_mailbox_cmd(struct psp_device *psp, unsigned int timeout_msecs,
 	int ret;
 
 	print_hex_dump_debug("->psp ", DUMP_PREFIX_OFFSET, 16, 2, req,
-			     req->header.payload_size, false);
+			     req->header.payload_size, 0);
 
 	ret = psp_mailbox_command(psp, PSP_CMD_TEE_EXTENDED_CMD, (void *)req,
 				  timeout_msecs, &reg);
@@ -98,7 +98,7 @@ int psp_extended_mailbox_cmd(struct psp_device *psp, unsigned int timeout_msecs,
 	}
 
 	print_hex_dump_debug("<-psp ", DUMP_PREFIX_OFFSET, 16, 2, req,
-			     req->header.payload_size, false);
+			     req->header.payload_size, 0);
 
 	return 0;
 }
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 9810edbb272d..0b9fd1295679 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -903,7 +903,7 @@ static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
 		cmd, phys_msb, phys_lsb, psp_timeout);
 
 	print_hex_dump_debug("(in):  ", DUMP_PREFIX_OFFSET, 16, 2, data,
-			     buf_len, false);
+			     buf_len, 0);
 
 	iowrite32(phys_lsb, sev->io_regs + sev->vdata->cmdbuff_addr_lo_reg);
 	iowrite32(phys_msb, sev->io_regs + sev->vdata->cmdbuff_addr_hi_reg);
@@ -980,7 +980,7 @@ static int __sev_do_cmd_locked(int cmd, void *data, int *psp_ret)
 	}
 
 	print_hex_dump_debug("(out): ", DUMP_PREFIX_OFFSET, 16, 2, data,
-			     buf_len, false);
+			     buf_len, 0);
 
 	return ret;
 }
diff --git a/drivers/crypto/ccree/cc_driver.c b/drivers/crypto/ccree/cc_driver.c
index 9177b54bb0f5..4edd4e777891 100644
--- a/drivers/crypto/ccree/cc_driver.c
+++ b/drivers/crypto/ccree/cc_driver.c
@@ -175,7 +175,7 @@ void __dump_byte_array(const char *name, const u8 *buf, size_t len)
 	snprintf(prefix, sizeof(prefix), "%s[%zu]: ", name, len);
 
 	print_hex_dump(KERN_DEBUG, prefix, DUMP_PREFIX_ADDRESS, 16, 1, buf,
-		       len, false);
+		       len, 0);
 }
 
 static irqreturn_t cc_isr(int irq, void *dev_id)
diff --git a/drivers/crypto/intel/qat/qat_common/adf_mstate_mgr.c b/drivers/crypto/intel/qat/qat_common/adf_mstate_mgr.c
index 41cc763a74aa..f9fb260a63bb 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_mstate_mgr.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_mstate_mgr.c
@@ -122,9 +122,9 @@ static void adf_mstate_dump_sect(struct adf_mstate_sect_h *sect,
 {
 	pr_debug("QAT: LM - %s QAT state section %s\n", prefix, sect->id);
 	print_hex_dump_debug("h-", DUMP_PREFIX_OFFSET, 16, 2, sect,
-			     sizeof(*sect), true);
+			     sizeof(*sect), DUMP_FLAG_ASCII);
 	print_hex_dump_debug("s-", DUMP_PREFIX_OFFSET, 16, 2, sect->state,
-			     sect->size, true);
+			     sect->size, DUMP_FLAG_ASCII);
 }
 
 static inline void __adf_mstate_sect_update(struct adf_mstate_mgr *mgr,
diff --git a/drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c b/drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c
index c80baf1ad90b..630a746d8c37 100644
--- a/drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c
+++ b/drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c
@@ -40,7 +40,7 @@ void otx_cpt_dump_sg_list(struct pci_dev *pdev, struct otx_cpt_req_info *req)
 		pr_debug("Buffer hexdump (%d bytes)\n",
 			 req->in[i].size);
 		print_hex_dump_debug("", DUMP_PREFIX_NONE, 16, 1,
-				     req->in[i].vptr, req->in[i].size, false);
+				     req->in[i].vptr, req->in[i].size, 0);
 	}
 
 	pr_debug("Scatter list size %d\n", req->outcnt);
@@ -50,7 +50,7 @@ void otx_cpt_dump_sg_list(struct pci_dev *pdev, struct otx_cpt_req_info *req)
 			 (void *) req->out[i].dma_addr);
 		pr_debug("Buffer hexdump (%d bytes)\n", req->out[i].size);
 		print_hex_dump_debug("", DUMP_PREFIX_NONE, 16, 1,
-				     req->out[i].vptr, req->out[i].size, false);
+				     req->out[i].vptr, req->out[i].size, 0);
 	}
 }
 
@@ -377,10 +377,10 @@ static int process_request(struct pci_dev *pdev, struct otx_cpt_req_info *req,
 	/* Print debug info if enabled */
 	otx_cpt_dump_sg_list(pdev, req);
 	pr_debug("Cpt_inst_s hexdump (%d bytes)\n", OTX_CPT_INST_SIZE);
-	print_hex_dump_debug("", 0, 16, 1, &cptinst, OTX_CPT_INST_SIZE, false);
+	print_hex_dump_debug("", 0, 16, 1, &cptinst, OTX_CPT_INST_SIZE, 0);
 	pr_debug("Dptr hexdump (%d bytes)\n", cpt_req->dlen);
 	print_hex_dump_debug("", 0, 16, 1, info->in_buffer,
-			     cpt_req->dlen, false);
+			     cpt_req->dlen, 0);
 
 	/* Send CPT command */
 	cpt_send_cmd(&cptinst, cptvf);
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptvf_reqmgr.c b/drivers/crypto/marvell/octeontx2/otx2_cptvf_reqmgr.c
index 5387c68f3c9d..f5555ac38f01 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptvf_reqmgr.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptvf_reqmgr.c
@@ -29,7 +29,7 @@ static void otx2_cpt_dump_sg_list(struct pci_dev *pdev,
 		pr_debug("Buffer hexdump (%d bytes)\n",
 			 req->in[i].size);
 		print_hex_dump_debug("", DUMP_PREFIX_NONE, 16, 1,
-				     req->in[i].vptr, req->in[i].size, false);
+				     req->in[i].vptr, req->in[i].size, 0);
 	}
 	pr_debug("Scatter list size %d\n", req->out_cnt);
 	for (i = 0; i < req->out_cnt; i++) {
@@ -38,7 +38,7 @@ static void otx2_cpt_dump_sg_list(struct pci_dev *pdev,
 			 req->out[i].dma_addr);
 		pr_debug("Buffer hexdump (%d bytes)\n", req->out[i].size);
 		print_hex_dump_debug("", DUMP_PREFIX_NONE, 16, 1,
-				     req->out[i].vptr, req->out[i].size, false);
+				     req->out[i].vptr, req->out[i].size, 0);
 	}
 }
 
@@ -168,10 +168,10 @@ static int process_request(struct pci_dev *pdev, struct otx2_cpt_req_info *req,
 	/* Print debug info if enabled */
 	otx2_cpt_dump_sg_list(pdev, req);
 	pr_debug("Cpt_inst_s hexdump (%d bytes)\n", OTX2_CPT_INST_SIZE);
-	print_hex_dump_debug("", 0, 16, 1, &cptinst, OTX2_CPT_INST_SIZE, false);
+	print_hex_dump_debug("", 0, 16, 1, &cptinst, OTX2_CPT_INST_SIZE, 0);
 	pr_debug("Dptr hexdump (%d bytes)\n", cpt_req->dlen);
 	print_hex_dump_debug("", 0, 16, 1, info->in_buffer,
-			     cpt_req->dlen, false);
+			     cpt_req->dlen, 0);
 
 	/* Send CPT command */
 	lf->lfs->ops->send_cmd(&cptinst, 1, lf);
diff --git a/drivers/crypto/sa2ul.c b/drivers/crypto/sa2ul.c
index 461eca40e878..fd0f6fe9d76c 100644
--- a/drivers/crypto/sa2ul.c
+++ b/drivers/crypto/sa2ul.c
@@ -708,7 +708,7 @@ static void sa_dump_sc(u8 *buf, dma_addr_t dma_addr)
 #ifdef DEBUG
 	dev_info(sa_k3_dev, "Security context dump:: 0x%pad\n", &dma_addr);
 	print_hex_dump(KERN_CONT, "", DUMP_PREFIX_OFFSET,
-		       16, 1, buf, SA_CTX_MAX_SZ, false);
+		       16, 1, buf, SA_CTX_MAX_SZ, 0);
 #endif
 }
 
diff --git a/drivers/firmware/efi/apple-properties.c b/drivers/firmware/efi/apple-properties.c
index ea84108035eb..e600f6243822 100644
--- a/drivers/firmware/efi/apple-properties.c
+++ b/drivers/firmware/efi/apple-properties.c
@@ -98,7 +98,7 @@ static void __init unmarshal_key_value_pairs(struct dev_header *dev_header,
 		if (dump_properties) {
 			dev_info(dev, "property: %s\n", key);
 			print_hex_dump(KERN_INFO, pr_fmt(), DUMP_PREFIX_OFFSET,
-				16, 1, entry_data, entry_len, true);
+				16, 1, entry_data, entry_len, DUMP_FLAG_ASCII);
 		}
 
 		ptr += key_len + val_len;
@@ -108,7 +108,7 @@ static void __init unmarshal_key_value_pairs(struct dev_header *dev_header,
 		dev_err(dev, "got %d device properties, expected %u\n", i,
 			dev_header->prop_count);
 		print_hex_dump(KERN_ERR, pr_fmt(), DUMP_PREFIX_OFFSET,
-			16, 1, dev_header, dev_header->len, true);
+			16, 1, dev_header, dev_header->len, DUMP_FLAG_ASCII);
 		return;
 	}
 
@@ -141,7 +141,8 @@ static int __init unmarshal_devices(struct properties_header *properties)
 			pr_err("device path parse error %ld at %#zx:\n",
 			       PTR_ERR(dev), (void *)ptr - (void *)dev_header);
 			print_hex_dump(KERN_ERR, pr_fmt(), DUMP_PREFIX_OFFSET,
-			       16, 1, dev_header, dev_header->len, true);
+			       16, 1, dev_header, dev_header->len,
+			       DUMP_FLAG_ASCII);
 			dev = NULL;
 			goto skip_device;
 		}
@@ -211,12 +212,12 @@ static int __init map_properties(void)
 		if (properties->version != 1) {
 			pr_err("unsupported version:\n");
 			print_hex_dump(KERN_ERR, pr_fmt(), DUMP_PREFIX_OFFSET,
-			       16, 1, properties, data_len, true);
+			       16, 1, properties, data_len, DUMP_FLAG_ASCII);
 			ret = -ENOTSUPP;
 		} else if (properties->len != data_len) {
 			pr_err("length mismatch, expected %u\n", data_len);
 			print_hex_dump(KERN_ERR, pr_fmt(), DUMP_PREFIX_OFFSET,
-			       16, 1, properties, data_len, true);
+			       16, 1, properties, data_len, DUMP_FLAG_ASCII);
 			ret = -EINVAL;
 		} else
 			ret = unmarshal_devices(properties);
diff --git a/drivers/firmware/efi/cper-arm.c b/drivers/firmware/efi/cper-arm.c
index fa9c1c3bf168..b29de3659c8e 100644
--- a/drivers/firmware/efi/cper-arm.c
+++ b/drivers/firmware/efi/cper-arm.c
@@ -336,6 +336,6 @@ void cper_print_proc_arm(const char *pfx,
 		printk("%sVendor specific error info has %u bytes:\n", pfx,
 		       len);
 		print_hex_dump(newpfx, "", DUMP_PREFIX_OFFSET, 16, 4, ctx_info,
-				len, true);
+				len, DUMP_FLAG_ASCII);
 	}
 }
diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 7d2cdd9e2227..1f46b3ef1a8f 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -499,7 +499,8 @@ static void cper_print_fw_err(const char *pfx,
 	buf += offset;
 	length -= offset;
 
-	print_hex_dump(pfx, "", DUMP_PREFIX_OFFSET, 16, 4, buf, length, true);
+	print_hex_dump(pfx, "", DUMP_PREFIX_OFFSET, 16, 4, buf, length,
+		       DUMP_FLAG_ASCII);
 }
 
 static void cper_print_tstamp(const char *pfx,
@@ -633,7 +634,7 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
 		printk("%ssection length: %#x\n", newpfx,
 		       gdata->error_data_length);
 		print_hex_dump(newpfx, "", DUMP_PREFIX_OFFSET, 16, 4, err,
-			       gdata->error_data_length, true);
+			       gdata->error_data_length, DUMP_FLAG_ASCII);
 	}
 
 	return;
diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
index dd2d66090d23..45f5b6b6d979 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
@@ -281,7 +281,7 @@ static uint32_t smu_v11_0_i2c_transmit(struct i2c_adapter *control,
 
 	if (drm_debug_enabled(DRM_UT_DRIVER)) {
 		print_hex_dump(KERN_INFO, "data: ", DUMP_PREFIX_NONE,
-			       16, 1, data, numbytes, false);
+			       16, 1, data, numbytes, 0);
 	}
 
 	/* Set the I2C slave address */
@@ -432,7 +432,7 @@ static uint32_t smu_v11_0_i2c_receive(struct i2c_adapter *control,
 
 	if (drm_debug_enabled(DRM_UT_DRIVER)) {
 		print_hex_dump(KERN_INFO, "data: ", DUMP_PREFIX_NONE,
-			       16, 1, data, bytes_received, false);
+			       16, 1, data, bytes_received, 0);
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7e7929f24ae4..488941f05e01 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7339,7 +7339,7 @@ static int fill_hdr_info_packet(const struct drm_connector_state *state,
 	out->valid = true;
 
 	print_hex_dump(KERN_DEBUG, "HDR SB:", DUMP_PREFIX_NONE, 16, 1, out->sb,
-		       sizeof(out->sb), false);
+		       sizeof(out->sb), 0);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index 4e802b54a1cb..f5ab425e57f3 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -790,7 +790,8 @@ static int lt9611uxc_firmware_update(struct lt9611uxc *lt9611uxc)
 
 	if (!memcmp(readbuf, fw->data, fw->size)) {
 		dev_err(lt9611uxc->dev, "Firmware update failed\n");
-		print_hex_dump(KERN_ERR, "fw: ", DUMP_PREFIX_OFFSET, 16, 1, readbuf, fw->size, false);
+		print_hex_dump(KERN_ERR, "fw: ", DUMP_PREFIX_OFFSET, 16, 1, readbuf, fw->size,
+			       0);
 		ret = -EINVAL;
 	} else {
 		dev_info(lt9611uxc->dev, "Firmware updates successfully\n");
diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index fc2ceae61db2..62602950afef 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -786,7 +786,7 @@ static bool drm_dp_sideband_append_payload(struct drm_dp_sideband_msg_rx *msg,
 		if (crc4 != msg->chunk[msg->curchunk_len - 1])
 			print_hex_dump(KERN_DEBUG, "wrong crc",
 				       DUMP_PREFIX_NONE, 16, 1,
-				       msg->chunk,  msg->curchunk_len, false);
+				       msg->chunk,  msg->curchunk_len, 0);
 		/* copy chunk into bigger msg */
 		memcpy(&msg->msg[msg->curlen], msg->chunk, msg->curchunk_len - 1);
 		msg->curlen += msg->curchunk_len - 1;
@@ -3854,7 +3854,7 @@ drm_dp_get_one_sb_msg(struct drm_dp_mst_topology_mgr *mgr, bool up,
 	ret = drm_dp_decode_sideband_msg_hdr(mgr, &hdr, replyblock, len, &hdrlen);
 	if (ret == false) {
 		print_hex_dump(KERN_DEBUG, "failed hdr", DUMP_PREFIX_NONE, 16,
-			       1, replyblock, len, false);
+			       1, replyblock, len, 0);
 		drm_dbg_kms(mgr->dev, "ERROR: failed header\n");
 		return false;
 	}
diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index f68a41eeb1fa..f518ff31d2a4 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -1963,7 +1963,7 @@ static void edid_block_dump(const char *level, const void *block, int block_num)
 		sprintf(prefix, "\t[%02x] GOOD ", block_num);
 
 	print_hex_dump(level, prefix, DUMP_PREFIX_NONE, 16, 1,
-		       block, EDID_LENGTH, false);
+		       block, EDID_LENGTH, 0);
 }
 
 /**
diff --git a/drivers/gpu/drm/i915/display/intel_crtc_state_dump.c b/drivers/gpu/drm/i915/display/intel_crtc_state_dump.c
index 6df526e189b5..b0c15e1578c7 100644
--- a/drivers/gpu/drm/i915/display/intel_crtc_state_dump.c
+++ b/drivers/gpu/drm/i915/display/intel_crtc_state_dump.c
@@ -56,7 +56,7 @@ intel_dump_buffer(const char *prefix, const u8 *buf, size_t len)
 		return;
 
 	print_hex_dump(KERN_DEBUG, prefix, DUMP_PREFIX_NONE,
-		       16, 0, buf, len, false);
+		       16, 0, buf, len, 0);
 }
 
 #define OUTPUT_TYPE(x) [INTEL_OUTPUT_ ## x] = #x
diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index c2c388212e2e..eab0eec5d656 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -4995,9 +4995,9 @@ pipe_config_buffer_mismatch(struct drm_printer *p, bool fastset,
 	len = memcmp_diff_len(a, b, len);
 
 	print_hex_dump(loglevel, "expected: ", DUMP_PREFIX_NONE,
-		       16, 0, a, len, false);
+		       16, 0, a, len, 0);
 	print_hex_dump(loglevel, "found: ", DUMP_PREFIX_NONE,
-		       16, 0, b, len, false);
+		       16, 0, b, len, 0);
 }
 
 static void
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
index cf58f9da9139..7aa8446896aa 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
@@ -264,7 +264,8 @@ r535_gsp_msg_dump(struct nvkm_gsp *gsp, struct nvfw_gsp_rpc *msg, int lvl)
 			      msg->function, msg->length, msg->length - sizeof(*msg),
 			      msg->rpc_result, msg->rpc_result_private);
 		print_hex_dump(KERN_INFO, "msg: ", DUMP_PREFIX_OFFSET, 16, 1,
-			       msg->data, msg->length - sizeof(*msg), true);
+			       msg->data, msg->length - sizeof(*msg),
+			       DUMP_FLAG_ASCII);
 	}
 }
 
@@ -378,7 +379,8 @@ r535_gsp_rpc_send(struct nvkm_gsp *gsp, void *argv, bool wait, u32 repc)
 		nvkm_trace(&gsp->subdev, "rpc fn:%d len:0x%x/0x%zx\n", rpc->function,
 			   rpc->length, rpc->length - sizeof(*rpc));
 		print_hex_dump(KERN_INFO, "rpc: ", DUMP_PREFIX_OFFSET, 16, 1,
-			       rpc->data, rpc->length - sizeof(*rpc), true);
+			       rpc->data, rpc->length - sizeof(*rpc),
+			       DUMP_FLAG_ASCII);
 	}
 
 	ret = r535_gsp_cmdq_push(gsp, rpc);
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi4_core.c b/drivers/gpu/drm/omapdrm/dss/hdmi4_core.c
index 8720bf4f18fe..38e9c95f7a1a 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi4_core.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi4_core.c
@@ -227,7 +227,7 @@ static void hdmi_core_write_avi_infoframe(struct hdmi_core_data *core,
 	hdmi_avi_infoframe_pack(frame, data, sizeof(data));
 
 	print_hex_dump_debug("AVI: ", DUMP_PREFIX_NONE, 16, 1, data,
-		HDMI_INFOFRAME_SIZE(AVI), false);
+		HDMI_INFOFRAME_SIZE(AVI), 0);
 
 	for (i = 0; i < sizeof(data); ++i) {
 		hdmi_write_reg(av_base, HDMI_CORE_AV_AVI_BASE + i * 4,
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi5_core.c b/drivers/gpu/drm/omapdrm/dss/hdmi5_core.c
index 21564c38234f..ca2ca63a8097 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi5_core.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi5_core.c
@@ -376,7 +376,7 @@ static void hdmi_core_write_avi_infoframe(struct hdmi_core_data *core,
 	hdmi_avi_infoframe_pack(frame, data, sizeof(data));
 
 	print_hex_dump_debug("AVI: ", DUMP_PREFIX_NONE, 16, 1, data,
-		HDMI_INFOFRAME_SIZE(AVI), false);
+		HDMI_INFOFRAME_SIZE(AVI), 0);
 
 	ptr = data + HDMI_INFOFRAME_HEADER_SIZE;
 
diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 3c6011a48dab..c3bbb3d19292 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -1098,10 +1098,10 @@ static void vmbus_onoffer(struct vmbus_channel_message_header *hdr)
 			print_hex_dump_debug("Old vmbus offer: ",
 					     DUMP_PREFIX_OFFSET, 16, 4,
 					     &oldchannel->offermsg, offer_sz,
-					     false);
+					     0);
 			print_hex_dump_debug("New vmbus offer: ",
 					     DUMP_PREFIX_OFFSET, 16, 4,
-					     offer, offer_sz, false);
+					     offer, offer_sz, 0);
 
 			/* Fix up the old channel. */
 			vmbus_setup_channel_state(oldchannel, offer);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 621b057fb9da..79e0ef53144d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -3745,7 +3745,7 @@ static void get_cqe_status(struct hns_roce_dev *hr_dev, struct hns_roce_qp *qp,
 	ibdev_err_ratelimited(&hr_dev->ib_dev, "error cqe status 0x%x:\n",
 			      cqe_status);
 	print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_NONE, 16, 4, cqe,
-		       cq->cqe_size, false);
+		       cq->cqe_size, 0);
 	wc->vendor_err = hr_reg_read(cqe, CQE_SUB_STATUS);
 
 	/*
diff --git a/drivers/infiniband/hw/irdma/cm.c b/drivers/infiniband/hw/irdma/cm.c
index 36bb7e5ce638..94fa372cbf5a 100644
--- a/drivers/infiniband/hw/irdma/cm.c
+++ b/drivers/infiniband/hw/irdma/cm.c
@@ -394,7 +394,7 @@ static struct irdma_puda_buf *irdma_form_ah_cm_frame(struct irdma_cm_node *cm_no
 	refcount_set(&sqbuf->refcount, 1);
 
 	print_hex_dump_debug("ILQ: TRANSMIT ILQ BUFFER", DUMP_PREFIX_OFFSET,
-			     16, 8, sqbuf->mem.va, sqbuf->totallen, false);
+			     16, 8, sqbuf->mem.va, sqbuf->totallen, 0);
 
 	return sqbuf;
 }
@@ -582,7 +582,7 @@ static struct irdma_puda_buf *irdma_form_uda_cm_frame(struct irdma_cm_node *cm_n
 	refcount_set(&sqbuf->refcount, 1);
 
 	print_hex_dump_debug("ILQ: TRANSMIT ILQ BUFFER", DUMP_PREFIX_OFFSET,
-			     16, 8, sqbuf->mem.va, sqbuf->totallen, false);
+			     16, 8, sqbuf->mem.va, sqbuf->totallen, 0);
 	return sqbuf;
 }
 
@@ -3150,7 +3150,7 @@ void irdma_receive_ilq(struct irdma_sc_vsi *vsi, struct irdma_puda_buf *rbuf)
 	/* if vlan, then maclen = 18 else 14 */
 	iph = (struct iphdr *)rbuf->iph;
 	print_hex_dump_debug("ILQ: RECEIVE ILQ BUFFER", DUMP_PREFIX_OFFSET,
-			     16, 8, rbuf->mem.va, rbuf->totallen, false);
+			     16, 8, rbuf->mem.va, rbuf->totallen, 0);
 	if (iwdev->rf->sc_dev.hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_2) {
 		if (rbuf->vlan_valid) {
 			vtag = rbuf->vlan_id;
diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index 6aed6169c07d..d205e4af559d 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -202,7 +202,7 @@ static int irdma_sc_add_arp_cache_entry(struct irdma_sc_cqp *cqp,
 	set_64bit_val(wqe, 24, hdr);
 
 	print_hex_dump_debug("WQE: ARP_CACHE_ENTRY WQE", DUMP_PREFIX_OFFSET,
-			     16, 8, wqe, IRDMA_CQP_WQE_SIZE * 8, false);
+			     16, 8, wqe, IRDMA_CQP_WQE_SIZE * 8, 0);
 	if (post_sq)
 		irdma_sc_cqp_post_sq(cqp);
 
@@ -235,7 +235,7 @@ static int irdma_sc_del_arp_cache_entry(struct irdma_sc_cqp *cqp, u64 scratch,
 
 	print_hex_dump_debug("WQE: ARP_CACHE_DEL_ENTRY WQE",
 			     DUMP_PREFIX_OFFSET, 16, 8, wqe,
-			     IRDMA_CQP_WQE_SIZE * 8, false);
+			     IRDMA_CQP_WQE_SIZE * 8, 0);
 	if (post_sq)
 		irdma_sc_cqp_post_sq(cqp);
 
@@ -270,7 +270,7 @@ static int irdma_sc_manage_apbvt_entry(struct irdma_sc_cqp *cqp,
 	set_64bit_val(wqe, 24, hdr);
 
 	print_hex_dump_debug("WQE: MANAGE_APBVT WQE", DUMP_PREFIX_OFFSET, 16,
-			     8, wqe, IRDMA_CQP_WQE_SIZE * 8, false);
+			     8, wqe, IRDMA_CQP_WQE_SIZE * 8, 0);
 	if (post_sq)
 		irdma_sc_cqp_post_sq(cqp);
 
@@ -360,7 +360,7 @@ irdma_sc_manage_qhash_table_entry(struct irdma_sc_cqp *cqp,
 	set_64bit_val(wqe, 24, temp);
 
 	print_hex_dump_debug("WQE: MANAGE_QHASH WQE", DUMP_PREFIX_OFFSET, 16,
-			     8, wqe, IRDMA_CQP_WQE_SIZE * 8, false);
+			     8, wqe, IRDMA_CQP_WQE_SIZE * 8, 0);
 	if (post_sq)
 		irdma_sc_cqp_post_sq(cqp);
 
@@ -482,7 +482,7 @@ int irdma_sc_qp_create(struct irdma_sc_qp *qp, struct irdma_create_qp_info *info
 	set_64bit_val(wqe, 24, hdr);
 
 	print_hex_dump_debug("WQE: QP_CREATE WQE", DUMP_PREFIX_OFFSET, 16, 8,
-			     wqe, IRDMA_CQP_WQE_SIZE * 8, false);
+			     wqe, IRDMA_CQP_WQE_SIZE * 8, 0);
 	if (post_sq)
 		irdma_sc_cqp_post_sq(cqp);
 
@@ -551,7 +551,7 @@ int irdma_sc_qp_modify(struct irdma_sc_qp *qp, struct irdma_modify_qp_info *info
 	set_64bit_val(wqe, 24, hdr);
 
 	print_hex_dump_debug("WQE: QP_MODIFY WQE", DUMP_PREFIX_OFFSET, 16, 8,
-			     wqe, IRDMA_CQP_WQE_SIZE * 8, false);
+			     wqe, IRDMA_CQP_WQE_SIZE * 8, 0);
 	if (post_sq)
 		irdma_sc_cqp_post_sq(cqp);
 
@@ -592,7 +592,7 @@ int irdma_sc_qp_destroy(struct irdma_sc_qp *qp, u64 scratch,
 	set_64bit_val(wqe, 24, hdr);
 
 	print_hex_dump_debug("WQE: QP_DESTROY WQE", DUMP_PREFIX_OFFSET, 16, 8,
-			     wqe, IRDMA_CQP_WQE_SIZE * 8, false);
+			     wqe, IRDMA_CQP_WQE_SIZE * 8, 0);
 	if (post_sq)
 		irdma_sc_cqp_post_sq(cqp);
 
@@ -750,7 +750,7 @@ void irdma_sc_qp_setctx_roce(struct irdma_sc_qp *qp, __le64 *qp_ctx,
 		      FIELD_PREP(IRDMAQPC_REMENDPOINTIDX, info->rem_endpoint_idx));
 
 	print_hex_dump_debug("WQE: QP_HOST CTX WQE", DUMP_PREFIX_OFFSET, 16,
-			     8, qp_ctx, IRDMA_QP_CTX_SIZE, false);
+			     8, qp_ctx, IRDMA_QP_CTX_SIZE, 0);
 }
 
 /* irdma_sc_alloc_local_mac_entry - allocate a mac entry
@@ -778,7 +778,7 @@ static int irdma_sc_alloc_local_mac_entry(struct irdma_sc_cqp *cqp, u64 scratch,
 
 	print_hex_dump_debug("WQE: ALLOCATE_LOCAL_MAC WQE",
 			     DUMP_PREFIX_OFFSET, 16, 8, wqe,
-			     IRDMA_CQP_WQE_SIZE * 8, false);
+			     IRDMA_CQP_WQE_SIZE * 8, 0);
 
 	if (post_sq)
 		irdma_sc_cqp_post_sq(cqp);
@@ -815,7 +815,7 @@ static int irdma_sc_add_local_mac_entry(struct irdma_sc_cqp *cqp,
 	set_64bit_val(wqe, 24, header);
 
 	print_hex_dump_debug("WQE: ADD_LOCAL_MAC WQE", DUMP_PREFIX_OFFSET, 16,
-			     8, wqe, IRDMA_CQP_WQE_SIZE * 8, false);
+			     8, wqe, IRDMA_CQP_WQE_SIZE * 8, 0);
 
 	if (post_sq)
 		irdma_sc_cqp_post_sq(cqp);
@@ -853,7 +853,7 @@ static int irdma_sc_del_local_mac_entry(struct irdma_sc_cqp *cqp, u64 scratch,
 
 	print_hex_dump_debug("WQE: DEL_LOCAL_MAC_IPADDR WQE",
 			     DUMP_PREFIX_OFFSET, 16, 8, wqe,
-			     IRDMA_CQP_WQE_SIZE * 8, false);
+			     IRDMA_CQP_WQE_SIZE * 8, 0);
 
 	if (post_sq)
 		irdma_sc_cqp_post_sq(cqp);
@@ -1042,7 +1042,7 @@ void irdma_sc_qp_setctx(struct irdma_sc_qp *qp, __le64 *qp_ctx,
 	set_64bit_val(qp_ctx, 128, qw16);
 
 	print_hex_dump_debug("WQE: QP_HOST CTX", DUMP_PREFIX_OFFSET, 16, 8,
-			     qp_ctx, IRDMA_QP_CTX_SIZE, false);
+			     qp_ctx, IRDMA_QP_CTX_SIZE, 0);
 }
 
 /**
@@ -1102,7 +1102,7 @@ static int irdma_sc_alloc_stag(struct irdma_sc_dev *dev,
 	set_64bit_val(wqe, 24, hdr);
 
 	print_hex_dump_debug("WQE: ALLOC_STAG WQE", DUMP_PREFIX_OFFSET, 16, 8,
-			     wqe, IRDMA_CQP_WQE_SIZE * 8, false);
+			     wqe, IRDMA_CQP_WQE_SIZE * 8, 0);
 	if (post_sq)
 		irdma_sc_cqp_post_sq(cqp);
 
@@ -1193,7 +1193,7 @@ static int irdma_sc_mr_reg_non_shared(struct irdma_sc_dev *dev,
 	set_64bit_val(wqe, 24, hdr);
 
 	print_hex_dump_debug("WQE: MR_REG_NS WQE", DUMP_PREFIX_OFFSET, 16, 8,
-			     wqe, IRDMA_CQP_WQE_SIZE * 8, false);
+			     wqe, IRDMA_CQP_WQE_SIZE * 8, 0);
 	if (post_sq)
 		irdma_sc_cqp_post_sq(cqp);
 
@@ -1233,7 +1233,7 @@ static int irdma_sc_dealloc_stag(struct irdma_sc_dev *dev,
 	set_64bit_val(wqe, 24, hdr);
 
 	print_hex_dump_debug("WQE: DEALLOC_STAG WQE", DUMP_PREFIX_OFFSET, 16,
-			     8, wqe, IRDMA_CQP_WQE_SIZE * 8, false);
+			     8, wqe, IRDMA_CQP_WQE_SIZE * 8, 0);
 	if (post_sq)
 		irdma_sc_cqp_post_sq(cqp);
 
@@ -1275,7 +1275,7 @@ static int irdma_sc_mw_alloc(struct irdma_sc_dev *dev,
 	set_64bit_val(wqe, 24, hdr);
 
 	print_hex_dump_debug("WQE: MW_ALLOC WQE", DUMP_PREFIX_OFFSET, 16, 8,
-			     wqe, IRDMA_CQP_WQE_SIZE * 8, false);
+			     wqe, IRDMA_CQP_WQE_SIZE * 8, 0);
 	if (post_sq)
 		irdma_sc_cqp_post_sq(cqp);
 
@@ -1349,7 +1349,7 @@ int irdma_sc_mr_fast_register(struct irdma_sc_qp *qp,
 	set_64bit_val(wqe, 24, hdr);
 
 	print_hex_dump_debug("WQE: FAST_REG WQE", DUMP_PREFIX_OFFSET, 16, 8,
-			     wqe, IRDMA_QP_WQE_MIN_SIZE, false);
+			     wqe, IRDMA_QP_WQE_MIN_SIZE, 0);
 
 	if (post_sq)
 		irdma_uk_qp_post_wr(&qp->qp_uk);
@@ -1378,7 +1378,7 @@ static void irdma_sc_gen_rts_ae(struct irdma_sc_qp *qp)
 
 	set_64bit_val(wqe, 24, hdr);
 	print_hex_dump_debug("QP: NOP W/LOCAL FENCE WQE", DUMP_PREFIX_OFFSET,
-			     16, 8, wqe, IRDMA_QP_WQE_MIN_SIZE, false);
+			     16, 8, wqe, IRDMA_QP_WQE_MIN_SIZE, 0);
 
 	wqe = qp_uk->sq_base[2].elem;
 	hdr = FIELD_PREP(IRDMAQPSQ_OPCODE, IRDMAQP_OP_GEN_RTS_AE) |
@@ -1387,7 +1387,7 @@ static void irdma_sc_gen_rts_ae(struct irdma_sc_qp *qp)
 
 	set_64bit_val(wqe, 24, hdr);
 	print_hex_dump_debug("QP: CONN EST WQE", DUMP_PREFIX_OFFSET, 16, 8,
-			     wqe, IRDMA_QP_WQE_MIN_SIZE, false);
+			     wqe, IRDMA_QP_WQE_MIN_SIZE, 0);
 }
 
 /**
@@ -1429,7 +1429,7 @@ void irdma_sc_send_lsmm(struct irdma_sc_qp *qp, void *lsmm_buf, u32 size,
 	set_64bit_val(wqe, 24, hdr);
 
 	print_hex_dump_debug("WQE: SEND_LSMM WQE", DUMP_PREFIX_OFFSET, 16, 8,
-			     wqe, IRDMA_QP_WQE_MIN_SIZE, false);
+			     wqe, IRDMA_QP_WQE_MIN_SIZE, 0);
 
 	if (qp->dev->hw_attrs.uk_attrs.feature_flags & IRDMA_FEATURE_RTS_AE)
 		irdma_sc_gen_rts_ae(qp);
@@ -1479,7 +1479,7 @@ void irdma_sc_send_rtt(struct irdma_sc_qp *qp, bool read)
 	set_64bit_val(wqe, 24, hdr);
 
 	print_hex_dump_debug("WQE: RTR WQE", DUMP_PREFIX_OFFSET, 16, 8, wqe,
-			     IRDMA_QP_WQE_MIN_SIZE, false);
+			     IRDMA_QP_WQE_MIN_SIZE, 0);
 
 	if (qp->dev->hw_attrs.uk_attrs.feature_flags & IRDMA_FEATURE_RTS_AE)
 		irdma_sc_gen_rts_ae(qp);
@@ -2074,7 +2074,7 @@ static int irdma_sc_gather_stats(struct irdma_sc_cqp *cqp,
 	set_64bit_val(wqe, 24, temp);
 
 	print_hex_dump_debug("STATS: GATHER_STATS WQE", DUMP_PREFIX_OFFSET,
-			     16, 8, wqe, IRDMA_CQP_WQE_SIZE * 8, false);
+			     16, 8, wqe, IRDMA_CQP_WQE_SIZE * 8, 0);
 
 	irdma_sc_cqp_post_sq(cqp);
 	ibdev_dbg(to_ibdev(cqp->dev),
@@ -2116,7 +2116,7 @@ static int irdma_sc_manage_stats_inst(struct irdma_sc_cqp *cqp,
 	set_64bit_val(wqe, 24, temp);
 
 	print_hex_dump_debug("WQE: MANAGE_STATS WQE", DUMP_PREFIX_OFFSET, 16,
-			     8, wqe, IRDMA_CQP_WQE_SIZE * 8, false);
+			     8, wqe, IRDMA_CQP_WQE_SIZE * 8, 0);
 
 	irdma_sc_cqp_post_sq(cqp);
 	return 0;
@@ -2157,7 +2157,7 @@ static int irdma_sc_set_up_map(struct irdma_sc_cqp *cqp,
 	set_64bit_val(wqe, 24, temp);
 
 	print_hex_dump_debug("WQE: UPMAP WQE", DUMP_PREFIX_OFFSET, 16, 8, wqe,
-			     IRDMA_CQP_WQE_SIZE * 8, false);
+			     IRDMA_CQP_WQE_SIZE * 8, 0);
 	irdma_sc_cqp_post_sq(cqp);
 
 	return 0;
@@ -2199,7 +2199,7 @@ static int irdma_sc_manage_ws_node(struct irdma_sc_cqp *cqp,
 	set_64bit_val(wqe, 24, temp);
 
 	print_hex_dump_debug("WQE: MANAGE_WS WQE", DUMP_PREFIX_OFFSET, 16, 8,
-			     wqe, IRDMA_CQP_WQE_SIZE * 8, false);
+			     wqe, IRDMA_CQP_WQE_SIZE * 8, 0);
 	irdma_sc_cqp_post_sq(cqp);
 
 	return 0;
@@ -2272,7 +2272,7 @@ int irdma_sc_qp_flush_wqes(struct irdma_sc_qp *qp,
 	set_64bit_val(wqe, 24, hdr);
 
 	print_hex_dump_debug("WQE: QP_FLUSH WQE", DUMP_PREFIX_OFFSET, 16, 8,
-			     wqe, IRDMA_CQP_WQE_SIZE * 8, false);
+			     wqe, IRDMA_CQP_WQE_SIZE * 8, 0);
 	if (post_sq)
 		irdma_sc_cqp_post_sq(cqp);
 
@@ -2313,7 +2313,7 @@ static int irdma_sc_gen_ae(struct irdma_sc_qp *qp,
 	set_64bit_val(wqe, 24, hdr);
 
 	print_hex_dump_debug("WQE: GEN_AE WQE", DUMP_PREFIX_OFFSET, 16, 8,
-			     wqe, IRDMA_CQP_WQE_SIZE * 8, false);
+			     wqe, IRDMA_CQP_WQE_SIZE * 8, 0);
 	if (post_sq)
 		irdma_sc_cqp_post_sq(cqp);
 
@@ -2352,7 +2352,7 @@ static int irdma_sc_qp_upload_context(struct irdma_sc_dev *dev,
 	set_64bit_val(wqe, 24, hdr);
 
 	print_hex_dump_debug("WQE: QP_UPLOAD_CTX WQE", DUMP_PREFIX_OFFSET, 16,
-			     8, wqe, IRDMA_CQP_WQE_SIZE * 8, false);
+			     8, wqe, IRDMA_CQP_WQE_SIZE * 8, 0);
 	if (post_sq)
 		irdma_sc_cqp_post_sq(cqp);
 
@@ -2392,7 +2392,7 @@ static int irdma_sc_manage_push_page(struct irdma_sc_cqp *cqp,
 	set_64bit_val(wqe, 24, hdr);
 
 	print_hex_dump_debug("WQE: MANAGE_PUSH_PAGES WQE", DUMP_PREFIX_OFFSET,
-			     16, 8, wqe, IRDMA_CQP_WQE_SIZE * 8, false);
+			     16, 8, wqe, IRDMA_CQP_WQE_SIZE * 8, 0);
 	if (post_sq)
 		irdma_sc_cqp_post_sq(cqp);
 
@@ -2423,7 +2423,7 @@ static int irdma_sc_suspend_qp(struct irdma_sc_cqp *cqp, struct irdma_sc_qp *qp,
 	set_64bit_val(wqe, 24, hdr);
 
 	print_hex_dump_debug("WQE: SUSPEND_QP WQE", DUMP_PREFIX_OFFSET, 16, 8,
-			     wqe, IRDMA_CQP_WQE_SIZE * 8, false);
+			     wqe, IRDMA_CQP_WQE_SIZE * 8, 0);
 	irdma_sc_cqp_post_sq(cqp);
 
 	return 0;
@@ -2456,7 +2456,7 @@ static int irdma_sc_resume_qp(struct irdma_sc_cqp *cqp, struct irdma_sc_qp *qp,
 	set_64bit_val(wqe, 24, hdr);
 
 	print_hex_dump_debug("WQE: RESUME_QP WQE", DUMP_PREFIX_OFFSET, 16, 8,
-			     wqe, IRDMA_CQP_WQE_SIZE * 8, false);
+			     wqe, IRDMA_CQP_WQE_SIZE * 8, 0);
 	irdma_sc_cqp_post_sq(cqp);
 
 	return 0;
@@ -2573,7 +2573,7 @@ static int irdma_sc_cq_create(struct irdma_sc_cq *cq, u64 scratch,
 	set_64bit_val(wqe, 24, hdr);
 
 	print_hex_dump_debug("WQE: CQ_CREATE WQE", DUMP_PREFIX_OFFSET, 16, 8,
-			     wqe, IRDMA_CQP_WQE_SIZE * 8, false);
+			     wqe, IRDMA_CQP_WQE_SIZE * 8, 0);
 	if (post_sq)
 		irdma_sc_cqp_post_sq(cqp);
 
@@ -2624,7 +2624,7 @@ int irdma_sc_cq_destroy(struct irdma_sc_cq *cq, u64 scratch, bool post_sq)
 	set_64bit_val(wqe, 24, hdr);
 
 	print_hex_dump_debug("WQE: CQ_DESTROY WQE", DUMP_PREFIX_OFFSET, 16, 8,
-			     wqe, IRDMA_CQP_WQE_SIZE * 8, false);
+			     wqe, IRDMA_CQP_WQE_SIZE * 8, 0);
 	if (post_sq)
 		irdma_sc_cqp_post_sq(cqp);
 
@@ -2698,7 +2698,7 @@ static int irdma_sc_cq_modify(struct irdma_sc_cq *cq,
 	set_64bit_val(wqe, 24, hdr);
 
 	print_hex_dump_debug("WQE: CQ_MODIFY WQE", DUMP_PREFIX_OFFSET, 16, 8,
-			     wqe, IRDMA_CQP_WQE_SIZE * 8, false);
+			     wqe, IRDMA_CQP_WQE_SIZE * 8, 0);
 	if (post_sq)
 		irdma_sc_cqp_post_sq(cqp);
 
@@ -3203,7 +3203,7 @@ int irdma_sc_cqp_create(struct irdma_sc_cqp *cqp, u16 *maj_err, u16 *min_err)
 	}
 	set_64bit_val(cqp->host_ctx, 56, temp);
 	print_hex_dump_debug("WQE: CQP_HOST_CTX WQE", DUMP_PREFIX_OFFSET, 16,
-			     8, cqp->host_ctx, IRDMA_CQP_CTX_SIZE * 8, false);
+			     8, cqp->host_ctx, IRDMA_CQP_CTX_SIZE * 8, 0);
 	p1 = cqp->host_ctx_pa >> 32;
 	p2 = (u32)cqp->host_ctx_pa;
 
@@ -3483,7 +3483,7 @@ static int irdma_sc_manage_hmc_pm_func_table(struct irdma_sc_cqp *cqp,
 
 	print_hex_dump_debug("WQE: MANAGE_HMC_PM_FUNC_TABLE WQE",
 			     DUMP_PREFIX_OFFSET, 16, 8, wqe,
-			     IRDMA_CQP_WQE_SIZE * 8, false);
+			     IRDMA_CQP_WQE_SIZE * 8, 0);
 	if (post_sq)
 		irdma_sc_cqp_post_sq(cqp);
 
@@ -3536,7 +3536,7 @@ static int irdma_sc_commit_fpm_val(struct irdma_sc_cqp *cqp, u64 scratch,
 	set_64bit_val(wqe, 24, hdr);
 
 	print_hex_dump_debug("WQE: COMMIT_FPM_VAL WQE", DUMP_PREFIX_OFFSET,
-			     16, 8, wqe, IRDMA_CQP_WQE_SIZE * 8, false);
+			     16, 8, wqe, IRDMA_CQP_WQE_SIZE * 8, 0);
 	irdma_get_cqp_reg_info(cqp, &val, &tail, &error);
 
 	if (post_sq) {
@@ -3595,7 +3595,7 @@ static int irdma_sc_query_fpm_val(struct irdma_sc_cqp *cqp, u64 scratch,
 	set_64bit_val(wqe, 24, hdr);
 
 	print_hex_dump_debug("WQE: QUERY_FPM WQE", DUMP_PREFIX_OFFSET, 16, 8,
-			     wqe, IRDMA_CQP_WQE_SIZE * 8, false);
+			     wqe, IRDMA_CQP_WQE_SIZE * 8, 0);
 	irdma_get_cqp_reg_info(cqp, &val, &tail, &error);
 
 	if (post_sq) {
@@ -3693,7 +3693,7 @@ static int irdma_sc_ceq_create(struct irdma_sc_ceq *ceq, u64 scratch,
 	set_64bit_val(wqe, 24, hdr);
 
 	print_hex_dump_debug("WQE: CEQ_CREATE WQE", DUMP_PREFIX_OFFSET, 16, 8,
-			     wqe, IRDMA_CQP_WQE_SIZE * 8, false);
+			     wqe, IRDMA_CQP_WQE_SIZE * 8, 0);
 	if (post_sq)
 		irdma_sc_cqp_post_sq(cqp);
 
@@ -3785,7 +3785,7 @@ int irdma_sc_ceq_destroy(struct irdma_sc_ceq *ceq, u64 scratch, bool post_sq)
 	set_64bit_val(wqe, 24, hdr);
 
 	print_hex_dump_debug("WQE: CEQ_DESTROY WQE", DUMP_PREFIX_OFFSET, 16,
-			     8, wqe, IRDMA_CQP_WQE_SIZE * 8, false);
+			     8, wqe, IRDMA_CQP_WQE_SIZE * 8, 0);
 	if (post_sq)
 		irdma_sc_cqp_post_sq(cqp);
 
@@ -3952,7 +3952,7 @@ static int irdma_sc_aeq_create(struct irdma_sc_aeq *aeq, u64 scratch,
 	set_64bit_val(wqe, 24, hdr);
 
 	print_hex_dump_debug("WQE: AEQ_CREATE WQE", DUMP_PREFIX_OFFSET, 16, 8,
-			     wqe, IRDMA_CQP_WQE_SIZE * 8, false);
+			     wqe, IRDMA_CQP_WQE_SIZE * 8, 0);
 	if (post_sq)
 		irdma_sc_cqp_post_sq(cqp);
 
@@ -3991,7 +3991,7 @@ static int irdma_sc_aeq_destroy(struct irdma_sc_aeq *aeq, u64 scratch,
 	set_64bit_val(wqe, 24, hdr);
 
 	print_hex_dump_debug("WQE: AEQ_DESTROY WQE", DUMP_PREFIX_OFFSET, 16,
-			     8, wqe, IRDMA_CQP_WQE_SIZE * 8, false);
+			     8, wqe, IRDMA_CQP_WQE_SIZE * 8, 0);
 	if (post_sq)
 		irdma_sc_cqp_post_sq(cqp);
 	return 0;
@@ -4023,7 +4023,7 @@ int irdma_sc_get_next_aeqe(struct irdma_sc_aeq *aeq,
 	get_64bit_val(aeqe, 0, &compl_ctx);
 
 	print_hex_dump_debug("WQE: AEQ_ENTRY WQE", DUMP_PREFIX_OFFSET, 16, 8,
-			     aeqe, 16, false);
+			     aeqe, 16, 0);
 
 	ae_src = (u8)FIELD_GET(IRDMA_AEQE_AESRC, temp);
 	info->wqe_idx = (u16)FIELD_GET(IRDMA_AEQE_WQDESCIDX, temp);
@@ -4286,7 +4286,7 @@ int irdma_sc_ccq_destroy(struct irdma_sc_cq *ccq, u64 scratch, bool post_sq)
 	set_64bit_val(wqe, 24, hdr);
 
 	print_hex_dump_debug("WQE: CCQ_DESTROY WQE", DUMP_PREFIX_OFFSET, 16,
-			     8, wqe, IRDMA_CQP_WQE_SIZE * 8, false);
+			     8, wqe, IRDMA_CQP_WQE_SIZE * 8, 0);
 	irdma_get_cqp_reg_info(cqp, &val, &tail, &error);
 
 	if (post_sq) {
@@ -4331,7 +4331,7 @@ int irdma_sc_init_iw_hmc(struct irdma_sc_dev *dev, u8 hmc_fn_id)
 
 	print_hex_dump_debug("HMC: QUERY FPM BUFFER", DUMP_PREFIX_OFFSET, 16,
 			     8, query_fpm_mem.va, IRDMA_QUERY_FPM_BUF_SIZE,
-			     false);
+			     0);
 	return ret_code;
 }
 
@@ -4390,7 +4390,7 @@ static int irdma_sc_cfg_iw_fpm(struct irdma_sc_dev *dev, u8 hmc_fn_id)
 	wait_type = (u8)IRDMA_CQP_WAIT_POLL_REGS;
 	print_hex_dump_debug("HMC: COMMIT FPM BUFFER", DUMP_PREFIX_OFFSET, 16,
 			     8, commit_fpm_mem.va, IRDMA_COMMIT_FPM_BUF_SIZE,
-			     false);
+			     0);
 	ret_code = irdma_sc_commit_fpm_val(dev->cqp, 0, hmc_info->hmc_fn_id,
 					   &commit_fpm_mem, true, wait_type);
 	if (!ret_code)
@@ -4399,7 +4399,7 @@ static int irdma_sc_cfg_iw_fpm(struct irdma_sc_dev *dev, u8 hmc_fn_id)
 					      &hmc_info->sd_table.sd_cnt);
 	print_hex_dump_debug("HMC: COMMIT FPM BUFFER", DUMP_PREFIX_OFFSET, 16,
 			     8, commit_fpm_mem.va, IRDMA_COMMIT_FPM_BUF_SIZE,
-			     false);
+			     0);
 
 	return ret_code;
 }
@@ -4475,10 +4475,10 @@ static int cqp_sds_wqe_fill(struct irdma_sc_cqp *cqp,
 		print_hex_dump_debug("WQE: UPDATE_PE_SDS WQE Buffer",
 				     DUMP_PREFIX_OFFSET, 16, 8,
 				     (char *)sdbuf->va + offset,
-				     mem_entries << 4, false);
+				     mem_entries << 4, 0);
 
 	print_hex_dump_debug("WQE: UPDATE_PE_SDS WQE", DUMP_PREFIX_OFFSET, 16,
-			     8, wqe, IRDMA_CQP_WQE_SIZE * 8, false);
+			     8, wqe, IRDMA_CQP_WQE_SIZE * 8, 0);
 
 	return 0;
 }
@@ -4557,7 +4557,7 @@ int irdma_sc_static_hmc_pages_allocated(struct irdma_sc_cqp *cqp, u64 scratch,
 
 	print_hex_dump_debug("WQE: SHMC_PAGES_ALLOCATED WQE",
 			     DUMP_PREFIX_OFFSET, 16, 8, wqe,
-			     IRDMA_CQP_WQE_SIZE * 8, false);
+			     IRDMA_CQP_WQE_SIZE * 8, 0);
 	irdma_get_cqp_reg_info(cqp, &val, &tail, &error);
 
 	if (post_sq) {
@@ -4653,7 +4653,7 @@ static int irdma_sc_query_rdma_features(struct irdma_sc_cqp *cqp,
 	set_64bit_val(wqe, 24, temp);
 
 	print_hex_dump_debug("WQE: QUERY RDMA FEATURES", DUMP_PREFIX_OFFSET,
-			     16, 8, wqe, IRDMA_CQP_WQE_SIZE * 8, false);
+			     16, 8, wqe, IRDMA_CQP_WQE_SIZE * 8, 0);
 	irdma_sc_cqp_post_sq(cqp);
 
 	return 0;
@@ -4717,7 +4717,7 @@ int irdma_get_rdma_features(struct irdma_sc_dev *dev)
 	}
 
 	print_hex_dump_debug("WQE: QUERY RDMA FEATURES", DUMP_PREFIX_OFFSET,
-			     16, 8, feat_buf.va, feat_cnt * 8, false);
+			     16, 8, feat_buf.va, feat_cnt * 8, 0);
 
 	for (byte_idx = 0, feat_idx = 0; feat_idx < min(feat_cnt, (u16)IRDMA_MAX_FEATURES);
 	     feat_idx++, byte_idx += 8) {
diff --git a/drivers/infiniband/hw/irdma/puda.c b/drivers/infiniband/hw/irdma/puda.c
index 7e3f9bca2c23..070de5415965 100644
--- a/drivers/infiniband/hw/irdma/puda.c
+++ b/drivers/infiniband/hw/irdma/puda.c
@@ -257,10 +257,10 @@ static int irdma_puda_poll_info(struct irdma_sc_cq *cq,
 	}
 
 	print_hex_dump_debug("PUDA: PUDA CQE", DUMP_PREFIX_OFFSET, 16, 8, cqe,
-			     32, false);
+			     32, 0);
 	if (ext_valid)
 		print_hex_dump_debug("PUDA: PUDA EXT-CQE", DUMP_PREFIX_OFFSET,
-				     16, 8, ext_cqe, 32, false);
+				     16, 8, ext_cqe, 32, 0);
 
 	error = (bool)FIELD_GET(IRDMA_CQ_ERROR, qword3);
 	if (error) {
@@ -488,7 +488,7 @@ int irdma_puda_send(struct irdma_sc_qp *qp, struct irdma_puda_send_info *info)
 	set_64bit_val(wqe, 24, hdr[1]);
 
 	print_hex_dump_debug("PUDA: PUDA SEND WQE", DUMP_PREFIX_OFFSET, 16, 8,
-			     wqe, 32, false);
+			     wqe, 32, 0);
 	irdma_uk_qp_post_wr(&qp->qp_uk);
 	return 0;
 }
@@ -594,7 +594,7 @@ static void irdma_puda_qp_setctx(struct irdma_puda_rsrc *rsrc)
 		      FIELD_PREP(IRDMAQPC_QSHANDLE, qp->qs_handle));
 
 	print_hex_dump_debug("PUDA: PUDA QP CONTEXT", DUMP_PREFIX_OFFSET, 16,
-			     8, qp_ctx, IRDMA_QP_CTX_SIZE, false);
+			     8, qp_ctx, IRDMA_QP_CTX_SIZE, 0);
 }
 
 /**
@@ -629,7 +629,7 @@ static int irdma_puda_qp_wqe(struct irdma_sc_dev *dev, struct irdma_sc_qp *qp)
 	set_64bit_val(wqe, 24, hdr);
 
 	print_hex_dump_debug("PUDA: PUDA QP CREATE", DUMP_PREFIX_OFFSET, 16,
-			     8, wqe, 40, false);
+			     8, wqe, 40, 0);
 	irdma_sc_cqp_post_sq(cqp);
 	status = irdma_sc_poll_for_cqp_op_done(dev->cqp, IRDMA_CQP_OP_CREATE_QP,
 					       &compl_info);
@@ -754,7 +754,7 @@ static int irdma_puda_cq_wqe(struct irdma_sc_dev *dev, struct irdma_sc_cq *cq)
 	set_64bit_val(wqe, 24, hdr);
 
 	print_hex_dump_debug("PUDA: PUDA CREATE CQ", DUMP_PREFIX_OFFSET, 16,
-			     8, wqe, IRDMA_CQP_WQE_SIZE * 8, false);
+			     8, wqe, IRDMA_CQP_WQE_SIZE * 8, 0);
 	irdma_sc_cqp_post_sq(dev->cqp);
 	status = irdma_sc_poll_for_cqp_op_done(dev->cqp, IRDMA_CQP_OP_CREATE_CQ,
 					       &compl_info);
@@ -1405,7 +1405,7 @@ static int irdma_ieq_handle_partial(struct irdma_puda_rsrc *ieq,
 	}
 
 	print_hex_dump_debug("IEQ: IEQ TX BUFFER", DUMP_PREFIX_OFFSET, 16, 8,
-			     txbuf->mem.va, txbuf->totallen, false);
+			     txbuf->mem.va, txbuf->totallen, 0);
 	if (ieq->dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_2)
 		txbuf->ah_id = pfpdu->ah->ah_info.ah_idx;
 	txbuf->do_lpb = true;
@@ -1504,7 +1504,7 @@ static int irdma_ieq_process_buf(struct irdma_puda_rsrc *ieq,
 		irdma_ieq_update_tcpip_info(txbuf, len, buf->seqnum);
 		print_hex_dump_debug("IEQ: IEQ TX BUFFER", DUMP_PREFIX_OFFSET,
 				     16, 8, txbuf->mem.va, txbuf->totallen,
-				     false);
+				     0);
 		txbuf->do_lpb = true;
 		irdma_puda_send_buf(ieq, txbuf);
 
@@ -1603,7 +1603,7 @@ static void irdma_ieq_handle_exception(struct irdma_puda_rsrc *ieq,
 	u8 hw_rev = qp->dev->hw_attrs.uk_attrs.hw_rev;
 
 	print_hex_dump_debug("IEQ: IEQ RX BUFFER", DUMP_PREFIX_OFFSET, 16, 8,
-			     buf->mem.va, buf->totallen, false);
+			     buf->mem.va, buf->totallen, 0);
 
 	spin_lock_irqsave(&pfpdu->lock, flags);
 	pfpdu->total_ieq_bufs++;
@@ -1620,7 +1620,7 @@ static void irdma_ieq_handle_exception(struct irdma_puda_rsrc *ieq,
 
 	if (!pfpdu->mode) {
 		print_hex_dump_debug("IEQ: Q2 BUFFER", DUMP_PREFIX_OFFSET, 16,
-				     8, (u64 *)qp->q2_buf, 128, false);
+				     8, (u64 *)qp->q2_buf, 128, 0);
 		/* First_Partial_Sequence_Number check */
 		pfpdu->rcv_nxt = fps;
 		pfpdu->fps = fps;
diff --git a/drivers/infiniband/hw/irdma/uda.c b/drivers/infiniband/hw/irdma/uda.c
index 84051266d948..66bb75f619f3 100644
--- a/drivers/infiniband/hw/irdma/uda.c
+++ b/drivers/infiniband/hw/irdma/uda.c
@@ -74,7 +74,7 @@ int irdma_sc_access_ah(struct irdma_sc_cqp *cqp, struct irdma_ah_info *info,
 		FIELD_PREP(IRDMA_UDA_CQPSQ_MAV_INSERTVLANTAG, info->insert_vlan_tag));
 
 	print_hex_dump_debug("WQE: MANAGE_AH WQE", DUMP_PREFIX_OFFSET, 16, 8,
-			     wqe, IRDMA_CQP_WQE_SIZE * 8, false);
+			     wqe, IRDMA_CQP_WQE_SIZE * 8, 0);
 	irdma_sc_cqp_post_sq(cqp);
 
 	return 0;
@@ -161,10 +161,10 @@ int irdma_access_mcast_grp(struct irdma_sc_cqp *cqp,
 		      FIELD_PREP(IRDMA_UDA_CQPSQ_MG_IPV4VALID, info->ipv4_valid));
 
 	print_hex_dump_debug("WQE: MANAGE_MCG WQE", DUMP_PREFIX_OFFSET, 16, 8,
-			     wqe, IRDMA_CQP_WQE_SIZE * 8, false);
+			     wqe, IRDMA_CQP_WQE_SIZE * 8, 0);
 	print_hex_dump_debug("WQE: MCG_HOST CTX WQE", DUMP_PREFIX_OFFSET, 16,
 			     8, info->dma_mem_mc.va,
-			     IRDMA_MAX_MGS_PER_CTX * 8, false);
+			     IRDMA_MAX_MGS_PER_CTX * 8, 0);
 	irdma_sc_cqp_post_sq(cqp);
 
 	return 0;
diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index 4c54dc578069..52df66816a8d 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -276,7 +276,7 @@ static void dump_cqe(struct mlx5_ib_dev *dev, struct mlx5_err_cqe *cqe,
 	mlx5_ib_log(level, dev, "WC error: %d, Message: %s\n", wc->status,
 		    ib_wc_status_msg(wc->status));
 	print_hex_dump(level, "cqe_dump: ", DUMP_PREFIX_OFFSET, 16, 1,
-		       cqe, sizeof(*cqe), false);
+		       cqe, sizeof(*cqe), 0);
 }
 
 static void mlx5_handle_error_cqe(struct mlx5_ib_dev *dev,
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 2916e77f589b..b99352963f1b 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -2079,7 +2079,7 @@ static void srp_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 		shost_printk(KERN_ERR, target->scsi_host,
 			     PFX "recv completion, opcode 0x%02x\n", opcode);
 		print_hex_dump(KERN_ERR, "", DUMP_PREFIX_OFFSET, 8, 1,
-			       iu->buf, wc->byte_len, true);
+			       iu->buf, wc->byte_len, DUMP_FLAG_ASCII);
 	}
 
 	switch (opcode) {
diff --git a/drivers/input/touchscreen/melfas_mip4.c b/drivers/input/touchscreen/melfas_mip4.c
index b99a0e3c4084..749d1afb65e7 100644
--- a/drivers/input/touchscreen/melfas_mip4.c
+++ b/drivers/input/touchscreen/melfas_mip4.c
@@ -1058,11 +1058,11 @@ static int mip4_bl_verify_page(struct mip4_ts *ts, int offset,
 				       MIP4_DEVICE_NAME " F/W File: ",
 				       DUMP_PREFIX_OFFSET, 16, 1,
 				       data + offset, MIP4_BL_PACKET_SIZE,
-				       false);
+				       0);
 			print_hex_dump(KERN_DEBUG,
 				       MIP4_DEVICE_NAME " F/W Chip: ",
 				       DUMP_PREFIX_OFFSET, 16, 1,
-				       read_buf, MIP4_BL_PAGE_SIZE, false);
+				       read_buf, MIP4_BL_PAGE_SIZE, 0);
 #endif
 			error = -EINVAL;
 			break;
@@ -1171,7 +1171,7 @@ static int mip4_parse_firmware(struct mip4_ts *ts, const struct firmware *fw,
 
 #if MIP4_FW_UPDATE_DEBUG
 	print_hex_dump(KERN_ERR, MIP4_DEVICE_NAME " Bin Info: ",
-		       DUMP_PREFIX_OFFSET, 16, 1, *fw_info, tail_size, false);
+		       DUMP_PREFIX_OFFSET, 16, 1, *fw_info, tail_size, 0);
 #endif
 
 	tail_size = get_unaligned_le16(&fw_info->tail_size);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
index cceb737a7001..68055b622e8f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
@@ -61,7 +61,7 @@ arm_smmu_test_writer_record_syncs(struct arm_smmu_entry_writer *writer)
 	print_hex_dump_debug("    ", DUMP_PREFIX_NONE, 16, 8,
 			     test_writer->entry,
 			     NUM_ENTRY_QWORDS * sizeof(*test_writer->entry),
-			     false);
+			     0);
 
 	test_writer->num_syncs += 1;
 	if (!test_writer->entry[0]) {
@@ -95,7 +95,7 @@ arm_smmu_v3_test_debug_print_used_bits(struct arm_smmu_entry_writer *writer,
 	arm_smmu_get_ste_used(ste, used_bits);
 	pr_debug("STE used bits: ");
 	print_hex_dump_debug("    ", DUMP_PREFIX_NONE, 16, 8, used_bits,
-			     sizeof(used_bits), false);
+			     sizeof(used_bits), 0);
 }
 
 static const struct arm_smmu_entry_writer_ops test_ste_ops = {
@@ -129,11 +129,11 @@ static void arm_smmu_v3_test_ste_expect_transition(
 
 	pr_debug("STE initial value: ");
 	print_hex_dump_debug("    ", DUMP_PREFIX_NONE, 16, 8, cur_copy.data,
-			     sizeof(cur_copy), false);
+			     sizeof(cur_copy), 0);
 	arm_smmu_v3_test_debug_print_used_bits(&test_writer.writer, cur->data);
 	pr_debug("STE target value: ");
 	print_hex_dump_debug("    ", DUMP_PREFIX_NONE, 16, 8, target->data,
-			     sizeof(cur_copy), false);
+			     sizeof(cur_copy), 0);
 	arm_smmu_v3_test_debug_print_used_bits(&test_writer.writer,
 					       target->data);
 
@@ -403,11 +403,11 @@ static void arm_smmu_v3_test_cd_expect_transition(
 
 	pr_debug("CD initial value: ");
 	print_hex_dump_debug("    ", DUMP_PREFIX_NONE, 16, 8, cur_copy.data,
-			     sizeof(cur_copy), false);
+			     sizeof(cur_copy), 0);
 	arm_smmu_v3_test_debug_print_used_bits(&test_writer.writer, cur->data);
 	pr_debug("CD target value: ");
 	print_hex_dump_debug("    ", DUMP_PREFIX_NONE, 16, 8, target->data,
-			     sizeof(cur_copy), false);
+			     sizeof(cur_copy), 0);
 	arm_smmu_v3_test_debug_print_used_bits(&test_writer.writer,
 					       target->data);
 
diff --git a/drivers/macintosh/via-cuda.c b/drivers/macintosh/via-cuda.c
index f8dd1e831530..63bfa08f6f77 100644
--- a/drivers/macintosh/via-cuda.c
+++ b/drivers/macintosh/via-cuda.c
@@ -762,7 +762,7 @@ cuda_input(unsigned char *buf, int nb)
 
     default:
 	print_hex_dump(KERN_INFO, "cuda_input: ", DUMP_PREFIX_NONE, 32, 1,
-	               buf, nb, false);
+		       buf, nb, 0);
     }
 }
 
diff --git a/drivers/macintosh/windfarm_smu_sat.c b/drivers/macintosh/windfarm_smu_sat.c
index ff8805ecf2e5..e293b8987ef9 100644
--- a/drivers/macintosh/windfarm_smu_sat.c
+++ b/drivers/macintosh/windfarm_smu_sat.c
@@ -100,7 +100,7 @@ struct smu_sdbp_header *smu_sat_get_sdb_partition(unsigned int sat_id, int id,
 
 	printk(KERN_DEBUG "sat %d partition %x:", sat_id, id);
 	print_hex_dump(KERN_DEBUG, "  ", DUMP_PREFIX_OFFSET,
-		       16, 1, buf, len, false);
+		       16, 1, buf, len, 0);
 	if (size)
 		*size = len;
 	return (struct smu_sdbp_header *) buf;
@@ -126,7 +126,7 @@ static int wf_sat_read_cache(struct wf_sat *sat)
 		int i;
 		printk(KERN_DEBUG "wf_sat_get: data is");
 		print_hex_dump(KERN_DEBUG, "  ", DUMP_PREFIX_OFFSET,
-			       16, 1, sat->cache, 16, false);
+			       16, 1, sat->cache, 16, 0);
 	}
 #endif
 	return 0;
diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index d17efb1dd0cb..107a56764f34 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -400,7 +400,7 @@ static int imx_mu_seco_tx(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp,
 		}
 
 		print_hex_dump_debug("from client ", DUMP_PREFIX_OFFSET, 4, 4,
-				     data, byte_size, false);
+				     data, byte_size, 0);
 
 		/* Send first word */
 		dev_dbg(priv->dev, "Sending header\n");
@@ -478,7 +478,7 @@ static int imx_mu_seco_rxdb(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp
 		     priv->dcfg->xSR[IMX_MU_GSR]);
 
 	print_hex_dump_debug("to client ", DUMP_PREFIX_OFFSET, 4, 4,
-			     &msg, byte_size, false);
+			     &msg, byte_size, 0);
 
 	/* send data to client */
 	dev_dbg(priv->dev, "Sending message to client\n");
diff --git a/drivers/media/common/tveeprom.c b/drivers/media/common/tveeprom.c
index b5b9d6de6d9e..f90ee1664dd8 100644
--- a/drivers/media/common/tveeprom.c
+++ b/drivers/media/common/tveeprom.c
@@ -753,7 +753,7 @@ int tveeprom_read(struct i2c_client *c, unsigned char *eedata, int len)
 	}
 
 	print_hex_dump_debug("full 256-byte eeprom dump:", DUMP_PREFIX_NONE,
-			     16, 1, eedata, len, true);
+			     16, 1, eedata, len, DUMP_FLAG_ASCII);
 	return 0;
 }
 EXPORT_SYMBOL(tveeprom_read);
diff --git a/drivers/media/dvb-core/dvb_net.c b/drivers/media/dvb-core/dvb_net.c
index 8bb8dd34c223..3fbc15b78e31 100644
--- a/drivers/media/dvb-core/dvb_net.c
+++ b/drivers/media/dvb-core/dvb_net.c
@@ -78,7 +78,8 @@ static unsigned char *ule_where = ule_hist, ule_dump;
 
 static void hexdump(const unsigned char *buf, unsigned short len)
 {
-	print_hex_dump_debug("", DUMP_PREFIX_OFFSET, 16, 1, buf, len, true);
+	print_hex_dump_debug("", DUMP_PREFIX_OFFSET, 16, 1, buf, len,
+			     DUMP_FLAG_ASCII);
 }
 #endif
 
diff --git a/drivers/media/firewire/firedtv-avc.c b/drivers/media/firewire/firedtv-avc.c
index a36c28412170..7ef7e103447a 100644
--- a/drivers/media/firewire/firedtv-avc.c
+++ b/drivers/media/firewire/firedtv-avc.c
@@ -216,7 +216,7 @@ static void debug_fcp(const u8 *data, int length)
 		       debug_fcp_ctype(data[0]), op);
 		if (avc_debug & AVC_DEBUG_FCP_PAYLOADS)
 			print_hex_dump(KERN_INFO, prefix, DUMP_PREFIX_NONE,
-				       16, 1, data, length, false);
+				       16, 1, data, length, 0);
 	}
 }
 
@@ -224,7 +224,7 @@ static void debug_pmt(char *msg, int length)
 {
 	printk(KERN_INFO "APP PMT -> l=%d\n", length);
 	print_hex_dump(KERN_INFO, "APP PMT -> ", DUMP_PREFIX_NONE,
-		       16, 1, msg, length, false);
+		       16, 1, msg, length, 0);
 }
 
 static int avc_write(struct firedtv *fdtv)
diff --git a/drivers/media/pci/saa7164/saa7164-api.c b/drivers/media/pci/saa7164/saa7164-api.c
index 965d285a9240..e40859d46812 100644
--- a/drivers/media/pci/saa7164/saa7164-api.c
+++ b/drivers/media/pci/saa7164/saa7164-api.c
@@ -1339,7 +1339,7 @@ int saa7164_api_enum_subdevs(struct saa7164_dev *dev)
 
 	if (saa_debug & DBGLVL_API)
 		print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET, 16, 1, buf,
-			       buflen & ~15, false);
+			       buflen & ~15, 0);
 
 	saa7164_api_dump_subdevs(dev, buf, buflen);
 
@@ -1392,7 +1392,7 @@ int saa7164_api_i2c_read(struct saa7164_i2c *bus, u8 addr, u32 reglen, u8 *reg,
 
 	if (saa_debug & DBGLVL_I2C)
 		print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET, 16, 1, buf,
-			       32, false);
+			       32, 0);
 
 	ret = saa7164_cmd_send(bus->dev, unitid, GET_CUR,
 		EXU_REGISTER_ACCESS_CONTROL, len, &buf);
@@ -1401,7 +1401,7 @@ int saa7164_api_i2c_read(struct saa7164_i2c *bus, u8 addr, u32 reglen, u8 *reg,
 	else {
 		if (saa_debug & DBGLVL_I2C)
 			print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET, 16, 1,
-				       buf, sizeof(buf), false);
+				       buf, sizeof(buf), 0);
 		memcpy(data, (buf + 2 * sizeof(u32) + reglen), datalen);
 	}
 
@@ -1464,7 +1464,7 @@ int saa7164_api_i2c_write(struct saa7164_i2c *bus, u8 addr, u32 datalen,
 
 	if (saa_debug & DBGLVL_I2C)
 		print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET, 16, 1,
-			       buf, sizeof(buf), false);
+			       buf, sizeof(buf), 0);
 
 	ret = saa7164_cmd_send(bus->dev, unitid, SET_CUR,
 		EXU_REGISTER_ACCESS_CONTROL, len, &buf);
diff --git a/drivers/media/pci/saa7164/saa7164-core.c b/drivers/media/pci/saa7164/saa7164-core.c
index a8a004f28ca0..59aafe7006b3 100644
--- a/drivers/media/pci/saa7164/saa7164-core.c
+++ b/drivers/media/pci/saa7164/saa7164-core.c
@@ -93,7 +93,7 @@ static void saa7164_pack_verifier(struct saa7164_buffer *buf)
 			printk(KERN_ERR "No pack at 0x%x\n", i);
 #if 0
 			print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET, 16, 1,
-				       p + 1, 32, false);
+				       p + 1, 32, 0);
 #endif
 		}
 	}
@@ -285,7 +285,7 @@ static void saa7164_work_enchandler_helper(struct saa7164_port *port, int bufnr)
 							__func__, buf);
 #if 0
 			print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET, 16, 1,
-				       p + buf->actual_size - 32, 64, false);
+				       p + buf->actual_size - 32, 64, 0);
 #endif
 				}
 			}
diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index 1d8913813037..2e3b1ea948f9 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -608,7 +608,7 @@ static void print_mxc_buf(struct mxc_jpeg_dev *jpeg, struct vb2_buffer *buf,
 			 "plane %d (vaddr=%p dma_addr=%x payload=%ld):",
 			  plane_no, vaddr, dma_addr, payload);
 		print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_OFFSET, 32, 1,
-			       vaddr, len, false);
+			       vaddr, len, 0);
 	}
 }
 
diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index f9437b6412b9..6ec7a0804689 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -156,7 +156,7 @@ static void venus_dump_packet(struct venus_hfi_device *hdev, const void *packet)
 		return;
 
 	print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_OFFSET, 16, 1, packet,
-		       pkt_size, true);
+		       pkt_size, DUMP_FLAG_ASCII);
 }
 
 static int venus_write_queue(struct venus_hfi_device *hdev,
diff --git a/drivers/media/platform/ti/cal/cal.c b/drivers/media/platform/ti/cal/cal.c
index 528909ae4bd6..9f823d7f7a14 100644
--- a/drivers/media/platform/ti/cal/cal.c
+++ b/drivers/media/platform/ti/cal/cal.c
@@ -247,7 +247,7 @@ void cal_quickdump_regs(struct cal_dev *cal)
 	cal_info(cal, "CAL Registers @ 0x%pa:\n", &cal->res->start);
 	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET, 16, 4,
 		       (__force const void *)cal->base,
-		       resource_size(cal->res), false);
+		       resource_size(cal->res), 0);
 
 	for (i = 0; i < cal->data->num_csi2_phy; ++i) {
 		struct cal_camerarx *phy = cal->phy[i];
@@ -257,7 +257,7 @@ void cal_quickdump_regs(struct cal_dev *cal)
 		print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET, 16, 4,
 			       (__force const void *)phy->base,
 			       resource_size(phy->res),
-			       false);
+			       0);
 	}
 }
 
diff --git a/drivers/media/usb/em28xx/em28xx-i2c.c b/drivers/media/usb/em28xx/em28xx-i2c.c
index a7eb11f7fb34..e0468113efda 100644
--- a/drivers/media/usb/em28xx/em28xx-i2c.c
+++ b/drivers/media/usb/em28xx/em28xx-i2c.c
@@ -711,7 +711,7 @@ static int em28xx_i2c_eeprom(struct em28xx *dev, unsigned int bus,
 	if (i2c_debug) {
 		/* Display eeprom content */
 		print_hex_dump(KERN_DEBUG, "em28xx eeprom ", DUMP_PREFIX_OFFSET,
-			       16, 1, data, len, true);
+			       16, 1, data, len, DUMP_FLAG_ASCII);
 
 		if (dev->eeprom_addrwidth_16bit)
 			dev_info(&dev->intf->dev,
diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
index ef326d6d566e..f7723520e68d 100644
--- a/drivers/mfd/rave-sp.c
+++ b/drivers/mfd/rave-sp.c
@@ -303,7 +303,7 @@ static int rave_sp_write(struct rave_sp *sp, const u8 *data, u8 data_size)
 	length = dest - frame;
 
 	print_hex_dump_debug("rave-sp tx: ", DUMP_PREFIX_NONE,
-			     16, 1, frame, length, false);
+			     16, 1, frame, length, 0);
 
 	return serdev_device_write(sp->serdev, frame, length, HZ);
 }
@@ -450,7 +450,7 @@ static void rave_sp_receive_frame(struct rave_sp *sp,
 	}
 
 	print_hex_dump_debug("rave-sp rx: ", DUMP_PREFIX_NONE,
-			     16, 1, data, length, false);
+			     16, 1, data, length, 0);
 
 	if (unlikely(length <= checksum_length)) {
 		dev_warn(dev, "Dropping short frame\n");
diff --git a/drivers/misc/genwqe/genwqe_driver.h b/drivers/misc/genwqe/genwqe_driver.h
index 8c333481b3ba..c3fee55770b8 100644
--- a/drivers/misc/genwqe/genwqe_driver.h
+++ b/drivers/misc/genwqe/genwqe_driver.h
@@ -63,7 +63,7 @@ static inline void genwqe_hexdump(struct pci_dev *pci_dev,
 		  GENWQE_DEVNAME, pci_name(pci_dev));
 
 	print_hex_dump_debug(prefix, DUMP_PREFIX_OFFSET, 16, 1, buff,
-			     size, true);
+			     size, DUMP_FLAG_ASCII);
 }
 
 #endif	/* __GENWQE_DRIVER_H__ */
diff --git a/drivers/mtd/tests/mtd_nandecctest.c b/drivers/mtd/tests/mtd_nandecctest.c
index 824cc1c03b6a..273b49abcf28 100644
--- a/drivers/mtd/tests/mtd_nandecctest.c
+++ b/drivers/mtd/tests/mtd_nandecctest.c
@@ -235,15 +235,15 @@ static void dump_data_ecc(void *error_data, void *error_ecc, void *correct_data,
 {
 	pr_info("hexdump of error data:\n");
 	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET, 16, 4,
-			error_data, size, false);
+			error_data, size, 0);
 	print_hex_dump(KERN_INFO, "hexdump of error ecc: ",
-			DUMP_PREFIX_NONE, 16, 1, error_ecc, 3, false);
+			DUMP_PREFIX_NONE, 16, 1, error_ecc, 3, 0);
 
 	pr_info("hexdump of correct data:\n");
 	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET, 16, 4,
-			correct_data, size, false);
+			correct_data, size, 0);
 	print_hex_dump(KERN_INFO, "hexdump of correct ecc: ",
-			DUMP_PREFIX_NONE, 16, 1, correct_ecc, 3, false);
+			DUMP_PREFIX_NONE, 16, 1, correct_ecc, 3, 0);
 }
 
 static int nand_ecc_test_run(const size_t size)
diff --git a/drivers/mtd/ubi/debug.c b/drivers/mtd/ubi/debug.c
index 9ec3b8b6a0aa..d23c4a1f28a7 100644
--- a/drivers/mtd/ubi/debug.c
+++ b/drivers/mtd/ubi/debug.c
@@ -68,7 +68,8 @@ void ubi_dump_flash(struct ubi_device *ubi, int pnum, int offset, int len)
 
 	ubi_msg(ubi, "dumping %d bytes of data from PEB %d, offset %d",
 		len, pnum, offset);
-	print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_OFFSET, 32, 1, buf, len, 1);
+	print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_OFFSET, 32, 1, buf, len,
+		       DUMP_FLAG_ASCII);
 out:
 	vfree(buf);
 	return;
@@ -90,7 +91,7 @@ void ubi_dump_ec_hdr(const struct ubi_ec_hdr *ec_hdr)
 	pr_err("\thdr_crc        %#08x\n", be32_to_cpu(ec_hdr->hdr_crc));
 	pr_err("erase counter header hexdump:\n");
 	print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_OFFSET, 32, 1,
-		       ec_hdr, UBI_EC_HDR_SIZE, 1);
+		       ec_hdr, UBI_EC_HDR_SIZE, DUMP_FLAG_ASCII);
 }
 
 /**
@@ -115,7 +116,7 @@ void ubi_dump_vid_hdr(const struct ubi_vid_hdr *vid_hdr)
 	pr_err("\thdr_crc   %08x\n", be32_to_cpu(vid_hdr->hdr_crc));
 	pr_err("Volume identifier header hexdump:\n");
 	print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_OFFSET, 32, 1,
-		       vid_hdr, UBI_VID_HDR_SIZE, 1);
+		       vid_hdr, UBI_VID_HDR_SIZE, DUMP_FLAG_ASCII);
 }
 
 /**
diff --git a/drivers/mtd/ubi/debug.h b/drivers/mtd/ubi/debug.h
index b2fd97548808..670ee98677e1 100644
--- a/drivers/mtd/ubi/debug.h
+++ b/drivers/mtd/ubi/debug.h
@@ -23,7 +23,7 @@ void ubi_dump_vid_hdr(const struct ubi_vid_hdr *vid_hdr);
 } while (0)
 
 #define ubi_dbg_print_hex_dump(l, ps, pt, r, g, b, len, a)                   \
-		print_hex_dump(l, ps, pt, r, g, b, len, a)
+		print_hex_dump(l, ps, pt, r, g, b, len, a ? DUMP_FLAG_ASCII : 0)
 
 #define ubi_dbg_msg(type, fmt, ...) \
 	pr_debug("UBI DBG " type " (pid %d): " fmt "\n", current->pid,       \
diff --git a/drivers/mtd/ubi/io.c b/drivers/mtd/ubi/io.c
index a4999bce435f..04e46b68f527 100644
--- a/drivers/mtd/ubi/io.c
+++ b/drivers/mtd/ubi/io.c
@@ -1400,11 +1400,11 @@ static int self_check_write(struct ubi_device *ubi, const void *buf, int pnum,
 		ubi_msg(ubi, "hex dump of the original buffer from %d to %d",
 			i, i + dump_len);
 		print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_OFFSET, 32, 1,
-			       buf + i, dump_len, 1);
+			       buf + i, dump_len, DUMP_FLAG_ASCII);
 		ubi_msg(ubi, "hex dump of the read buffer from %d to %d",
 			i, i + dump_len);
 		print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_OFFSET, 32, 1,
-			       buf1 + i, dump_len, 1);
+			       buf1 + i, dump_len, DUMP_FLAG_ASCII);
 		dump_stack();
 		err = -EINVAL;
 		goto out_free;
@@ -1465,7 +1465,8 @@ int ubi_self_check_all_ff(struct ubi_device *ubi, int pnum, int offset, int len)
 fail:
 	ubi_err(ubi, "self-check failed for PEB %d", pnum);
 	ubi_msg(ubi, "hex dump of the %d-%d region", offset, offset + len);
-	print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_OFFSET, 32, 1, buf, len, 1);
+	print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_OFFSET, 32, 1, buf, len,
+		       DUMP_FLAG_ASCII);
 	err = -EINVAL;
 error:
 	dump_stack();
diff --git a/drivers/net/arcnet/arcnet.c b/drivers/net/arcnet/arcnet.c
index 530c15d6a5eb..d5a3608ad3e2 100644
--- a/drivers/net/arcnet/arcnet.c
+++ b/drivers/net/arcnet/arcnet.c
@@ -153,7 +153,7 @@ void arcnet_dump_skb(struct net_device *dev,
 	/* dump the packet */
 	snprintf(hdr, sizeof(hdr), "%6s:%s skb->data:", dev->name, desc);
 	print_hex_dump(KERN_DEBUG, hdr, DUMP_PREFIX_OFFSET,
-		       16, 1, skb->data, skb->len, true);
+		       16, 1, skb->data, skb->len, DUMP_FLAG_ASCII);
 }
 EXPORT_SYMBOL(arcnet_dump_skb);
 #endif
@@ -185,7 +185,7 @@ static void arcnet_dump_packet(struct net_device *dev, int bufnum,
 	/* dump the packet */
 	snprintf(hdr, sizeof(hdr), "%6s:%s packet dump:", dev->name, desc);
 	print_hex_dump(KERN_DEBUG, hdr, DUMP_PREFIX_OFFSET,
-		       16, 1, buf, length, true);
+		       16, 1, buf, length, DUMP_FLAG_ASCII);
 }
 
 #else
diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index 5e3a72b7c469..a749ed3710f2 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -59,11 +59,11 @@ MODULE_DEVICE_TABLE(usb, es58x_id_table);
 #define es58x_print_hex_dump(buf, len)					\
 	print_hex_dump(KERN_DEBUG,					\
 		       KBUILD_MODNAME " " __stringify(buf) ": ",	\
-		       DUMP_PREFIX_NONE, 16, 1, buf, len, false)
+		       DUMP_PREFIX_NONE, 16, 1, buf, len, 0)
 
 #define es58x_print_hex_dump_debug(buf, len)				 \
 	print_hex_dump_debug(KBUILD_MODNAME " " __stringify(buf) ": ",\
-			     DUMP_PREFIX_NONE, 16, 1, buf, len, false)
+			     DUMP_PREFIX_NONE, 16, 1, buf, len, 0)
 
 /* The last two bytes of an ES58X command is a CRC16. The first two
  * bytes (the start of frame) are skipped and the CRC calculation
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 3d68fef46ded..f51c1d44a9ff 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -84,7 +84,7 @@ void pcan_dump_mem(const char *prompt, const void *p, int l)
 	pr_info("%s dumping %s (%d bytes):\n",
 		PCAN_USB_DRIVER_NAME, prompt ? prompt : "memory", l);
 	print_hex_dump(KERN_INFO, PCAN_USB_DRIVER_NAME " ", DUMP_PREFIX_NONE,
-		       DUMP_WIDTH, 1, p, l, false);
+		       DUMP_WIDTH, 1, p, l, 0);
 }
 
 /*
diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index 39a63b7313a4..538570685e0c 100644
--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -758,7 +758,7 @@ static void ucan_read_bulk_callback(struct urb *urb)
 				       1,
 				       urb->transfer_buffer,
 				       urb->actual_length,
-				       true);
+				       DUMP_FLAG_ASCII);
 
 			goto resubmit;
 		}
diff --git a/drivers/net/ethernet/aeroflex/greth.c b/drivers/net/ethernet/aeroflex/greth.c
index 27af7746d645..67101dfa5081 100644
--- a/drivers/net/ethernet/aeroflex/greth.c
+++ b/drivers/net/ethernet/aeroflex/greth.c
@@ -90,7 +90,7 @@ static void greth_set_multicast_list(struct net_device *dev);
 static void greth_print_rx_packet(void *addr, int len)
 {
 	print_hex_dump(KERN_DEBUG, "RX: ", DUMP_PREFIX_OFFSET, 16, 1,
-			addr, len, true);
+			addr, len, DUMP_FLAG_ASCII);
 }
 
 static void greth_print_tx_packet(struct sk_buff *skb)
@@ -104,13 +104,14 @@ static void greth_print_tx_packet(struct sk_buff *skb)
 		length = skb_headlen(skb);
 
 	print_hex_dump(KERN_DEBUG, "TX: ", DUMP_PREFIX_OFFSET, 16, 1,
-			skb->data, length, true);
+			skb->data, length, DUMP_FLAG_ASCII);
 
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 
 		print_hex_dump(KERN_DEBUG, "TX: ", DUMP_PREFIX_OFFSET, 16, 1,
 			       skb_frag_address(&skb_shinfo(skb)->frags[i]),
-			       skb_frag_size(&skb_shinfo(skb)->frags[i]), true);
+			       skb_frag_size(&skb_shinfo(skb)->frags[i]),
+			       DUMP_FLAG_ASCII);
 	}
 }
 
diff --git a/drivers/net/ethernet/altera/altera_tse_main.c b/drivers/net/ethernet/altera/altera_tse_main.c
index 3c112c18ae6a..067853b1aef2 100644
--- a/drivers/net/ethernet/altera/altera_tse_main.c
+++ b/drivers/net/ethernet/altera/altera_tse_main.c
@@ -403,7 +403,8 @@ static int tse_rx(struct altera_tse_private *priv, int limit)
 			netdev_info(priv->dev, "frame received %d bytes\n",
 				    pktlength);
 			print_hex_dump(KERN_ERR, "data: ", DUMP_PREFIX_OFFSET,
-				       16, 1, skb->data, pktlength, true);
+				       16, 1, skb->data, pktlength,
+				       DUMP_FLAG_ASCII);
 		}
 
 		tse_rx_vlan(priv->dev, skb);
diff --git a/drivers/net/ethernet/amd/a2065.c b/drivers/net/ethernet/amd/a2065.c
index 1ca26a8c40eb..ca522fe7cff7 100644
--- a/drivers/net/ethernet/amd/a2065.c
+++ b/drivers/net/ethernet/amd/a2065.c
@@ -549,7 +549,7 @@ static netdev_tx_t lance_start_xmit(struct sk_buff *skb,
 
 	/* dump the packet */
 	print_hex_dump_debug("skb->data: ", DUMP_PREFIX_NONE, 16, 1, skb->data,
-			     64, true);
+			     64, DUMP_FLAG_ASCII);
 
 	entry = lp->tx_new & lp->tx_ring_mod_mask;
 	ib->btx_ring[entry].length = (-skblen) | 0xf000;
diff --git a/drivers/net/ethernet/amd/ariadne.c b/drivers/net/ethernet/amd/ariadne.c
index fa201da567ed..0654f8b35274 100644
--- a/drivers/net/ethernet/amd/ariadne.c
+++ b/drivers/net/ethernet/amd/ariadne.c
@@ -585,7 +585,7 @@ static netdev_tx_t ariadne_start_xmit(struct sk_buff *skb,
 #ifdef DEBUG
 	print_hex_dump(KERN_DEBUG, "tx_buff: ", DUMP_PREFIX_OFFSET, 16, 1,
 		       (void *)priv->tx_buff[entry],
-		       skb->len > 64 ? 64 : skb->len, true);
+		       skb->len > 64 ? 64 : skb->len, DUMP_FLAG_ASCII);
 #endif
 
 	priv->tx_ring[entry]->TMD1 = (priv->tx_ring[entry]->TMD1 & 0xff00)
diff --git a/drivers/net/ethernet/amd/pds_core/adminq.c b/drivers/net/ethernet/amd/pds_core/adminq.c
index c83a0a80d533..0307724bf82f 100644
--- a/drivers/net/ethernet/amd/pds_core/adminq.c
+++ b/drivers/net/ethernet/amd/pds_core/adminq.c
@@ -213,7 +213,7 @@ static int __pdsc_adminq_post(struct pdsc *pdsc,
 		q->head_idx, q->tail_idx);
 	dev_dbg(pdsc->dev, "post admin queue command:\n");
 	dynamic_hex_dump("cmd ", DUMP_PREFIX_OFFSET, 16, 1,
-			 cmd, sizeof(*cmd), true);
+			 cmd, sizeof(*cmd), DUMP_FLAG_ASCII);
 
 	q->head_idx = (q->head_idx + 1) & (q->num_descs - 1);
 
@@ -298,7 +298,7 @@ int pdsc_adminq_post(struct pdsc *pdsc,
 
 	dev_dbg(pdsc->dev, "read admin queue completion idx %d:\n", index);
 	dynamic_hex_dump("comp ", DUMP_PREFIX_OFFSET, 16, 1,
-			 comp, sizeof(*comp), true);
+			 comp, sizeof(*comp), DUMP_FLAG_ASCII);
 
 	if (remaining && comp->status)
 		err = pdsc_err_to_errno(comp->status);
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 11665be3a22c..c09fca4e7b37 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1463,9 +1463,9 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		netdev_vdbg(bp->dev, "received skb of length %u, csum: %08x\n",
 			    skb->len, skb->csum);
 		print_hex_dump(KERN_DEBUG, " mac: ", DUMP_PREFIX_ADDRESS, 16, 1,
-			       skb_mac_header(skb), 16, true);
+			       skb_mac_header(skb), 16, DUMP_FLAG_ASCII);
 		print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_ADDRESS, 16, 1,
-			       skb->data, 32, true);
+			       skb->data, 32, DUMP_FLAG_ASCII);
 #endif
 
 		napi_gro_receive(napi, skb);
@@ -2353,7 +2353,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		    queue_index, skb->len, skb->head, skb->data,
 		    skb_tail_pointer(skb), skb_end_pointer(skb));
 	print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_OFFSET, 16, 1,
-		       skb->data, 16, true);
+		       skb->data, 16, DUMP_FLAG_ASCII);
 #endif
 
 	/* Count how many TX buffer descriptors are needed to send this
diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index aebb9fef3f6e..55bc4c4019f1 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -809,7 +809,7 @@ static void nicvf_rcv_pkt_handler(struct net_device *netdev,
 	if (netif_msg_pktdata(nic)) {
 		netdev_info(nic->netdev, "skb 0x%p, len=%d\n", skb, skb->len);
 		print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET, 16, 1,
-			       skb->data, skb->len, true);
+			       skb->data, skb->len, DUMP_FLAG_ASCII);
 	}
 
 	/* If error packet, drop it here */
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index b1e988347347..4dfcf087f46c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -200,7 +200,7 @@ static void hns3_lb_check_skb_data(struct hns3_enet_ring *ring,
 		tqp_vector->rx_group.total_packets++;
 	else
 		print_hex_dump(KERN_ERR, "selftest:", DUMP_PREFIX_OFFSET, 16, 1,
-			       skb->data, len, true);
+			       skb->data, len, DUMP_FLAG_ASCII);
 
 	dev_kfree_skb_any(skb);
 }
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 360ee26557f7..7ccc62e768e2 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -183,7 +183,7 @@ static void e1000e_dump_ps_pages(struct e1000_adapter *adapter,
 			pr_info("packet dump for ps_page %d:\n", i);
 			print_hex_dump(KERN_INFO, "", DUMP_PREFIX_ADDRESS,
 				       16, 1, page_address(ps_page->page),
-				       PAGE_SIZE, true);
+				       PAGE_SIZE, DUMP_FLAG_ASCII);
 		}
 	}
 }
@@ -312,7 +312,7 @@ static void e1000e_dump(struct e1000_adapter *adapter)
 		if (netif_msg_pktdata(adapter) && buffer_info->skb)
 			print_hex_dump(KERN_INFO, "", DUMP_PREFIX_ADDRESS,
 				       16, 1, buffer_info->skb->data,
-				       buffer_info->skb->len, true);
+				       buffer_info->skb->len, DUMP_FLAG_ASCII);
 	}
 
 	/* Print Rx Ring Summary */
@@ -459,7 +459,7 @@ static void e1000e_dump(struct e1000_adapter *adapter)
 						       1,
 						       buffer_info->skb->data,
 						       adapter->rx_buffer_len,
-						       true);
+						       DUMP_FLAG_ASCII);
 			}
 		}
 	}
diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index e8031f1a9b4f..3ff4c27f3fbc 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -184,7 +184,7 @@ void i40e_debug_aq(struct i40e_hw *hw, enum i40e_debug_mask mask, void *desc,
 			 hw->bus.func);
 
 		print_hex_dump(KERN_INFO, prefix, DUMP_PREFIX_OFFSET,
-			       16, 1, buf, len, false);
+			       16, 1, buf, len, 0);
 	}
 }
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index abf624d770e6..087a0dd15d33 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -1166,7 +1166,7 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 				 rlen, next_table, next_index);
 			print_hex_dump(KERN_INFO, "AQ buffer WB: ",
 				       DUMP_PREFIX_OFFSET, 16, 1,
-				       buff, rlen, true);
+				       buff, rlen, DUMP_FLAG_ASCII);
 			kfree(buff);
 			buff = NULL;
 		} else {
@@ -1373,7 +1373,7 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 			 desc->params.internal.param3);
 		print_hex_dump(KERN_INFO, "AQ buffer WB: ",
 			       DUMP_PREFIX_OFFSET, 16, 1,
-			       buff, buffer_len, true);
+			       buff, buffer_len, DUMP_FLAG_ASCII);
 		kfree(buff);
 		buff = NULL;
 		kfree(desc);
@@ -1459,7 +1459,8 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 			dev_info(&pf->pdev->dev, "LLDP MIB (local)\n");
 			print_hex_dump(KERN_INFO, "LLDP MIB (local): ",
 				       DUMP_PREFIX_OFFSET, 16, 1,
-				       buff, I40E_LLDPDU_SIZE, true);
+				       buff, I40E_LLDPDU_SIZE,
+				       DUMP_FLAG_ASCII);
 			kfree(buff);
 			buff = NULL;
 		} else if (strncmp(&cmd_buf[5], "get remote", 10) == 0) {
@@ -1487,7 +1488,8 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 			dev_info(&pf->pdev->dev, "LLDP MIB (remote)\n");
 			print_hex_dump(KERN_INFO, "LLDP MIB (remote): ",
 				       DUMP_PREFIX_OFFSET, 16, 1,
-				       buff, I40E_LLDPDU_SIZE, true);
+				       buff, I40E_LLDPDU_SIZE,
+				       DUMP_FLAG_ASCII);
 			kfree(buff);
 			buff = NULL;
 		} else if (strncmp(&cmd_buf[5], "event on", 8) == 0) {
@@ -1571,7 +1573,7 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 			if (bytes)
 				print_hex_dump(KERN_INFO, "NVM Dump: ",
 					DUMP_PREFIX_OFFSET, 16, 2,
-					buff, bytes, true);
+					buff, bytes, DUMP_FLAG_ASCII);
 		}
 		kfree(buff);
 		buff = NULL;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_common.c b/drivers/net/ethernet/intel/iavf/iavf_common.c
index aa751ce3425b..d2d5a82fe7df 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_common.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_common.c
@@ -267,7 +267,7 @@ void iavf_debug_aq(struct iavf_hw *hw, enum iavf_debug_mask mask, void *desc,
 				 hw->bus.func);
 
 			print_hex_dump(KERN_INFO, prefix, DUMP_PREFIX_OFFSET,
-				       16, 1, buf, len, false);
+				       16, 1, buf, len, 0);
 		}
 	}
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_osdep.h b/drivers/net/ethernet/intel/ice/ice_osdep.h
index a2562f04267f..282d5b534c8b 100644
--- a/drivers/net/ethernet/intel/ice/ice_osdep.h
+++ b/drivers/net/ethernet/intel/ice/ice_osdep.h
@@ -42,7 +42,7 @@ struct device *ice_hw_to_dev(struct ice_hw *hw);
 #define ice_debug_array(hw, type, rowsize, groupsize, buf, len) \
 	print_hex_dump_debug(KBUILD_MODNAME " ",		\
 			     DUMP_PREFIX_OFFSET, rowsize,	\
-			     groupsize, buf, len, false)
+			     groupsize, buf, len, 0)
 #else
 #define ice_debug(hw, type, fmt, args...)			\
 do {								\
@@ -57,7 +57,7 @@ do {								\
 		print_hex_dump_debug(KBUILD_MODNAME,		\
 				     DUMP_PREFIX_OFFSET,	\
 				     rowsize, groupsize, buf,	\
-				     len, false);		\
+				     len, 0);			\
 } while (0)
 #else
 #define ice_debug_array(hw, type, rowsize, groupsize, buf, len) \
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 11be39f435f3..28e2986d604b 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -423,7 +423,7 @@ static void igb_dump(struct igb_adapter *adapter)
 					DUMP_PREFIX_ADDRESS,
 					16, 1, buffer_info->skb->data,
 					dma_unmap_len(buffer_info, len),
-					true);
+					DUMP_FLAG_ASCII);
 		}
 	}
 
@@ -509,7 +509,8 @@ static void igb_dump(struct igb_adapter *adapter)
 					  16, 1,
 					  page_address(buffer_info->page) +
 						      buffer_info->page_offset,
-					  igb_rx_bufsz(rx_ring), true);
+					  igb_rx_bufsz(rx_ring),
+					  DUMP_FLAG_ASCII);
 				}
 			}
 		}
diff --git a/drivers/net/ethernet/intel/igc/igc_dump.c b/drivers/net/ethernet/intel/igc/igc_dump.c
index c09c95cc5f70..f858c2d113f4 100644
--- a/drivers/net/ethernet/intel/igc/igc_dump.c
+++ b/drivers/net/ethernet/intel/igc/igc_dump.c
@@ -202,7 +202,7 @@ void igc_rings_dump(struct igc_adapter *adapter)
 					       DUMP_PREFIX_ADDRESS,
 					       16, 1, buffer_info->skb->data,
 					       dma_unmap_len(buffer_info, len),
-					       true);
+					       DUMP_FLAG_ASCII);
 		}
 	}
 
@@ -292,7 +292,7 @@ void igc_rings_dump(struct igc_adapter *adapter)
 						       (buffer_info->page) +
 						       buffer_info->page_offset,
 						       igc_rx_bufsz(rx_ring),
-						       true);
+						       DUMP_FLAG_ASCII);
 				}
 			}
 		}
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 8057cef61f39..a2956ebbaf5e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -703,7 +703,7 @@ static void ixgbe_dump(struct ixgbe_adapter *adapter)
 						DUMP_PREFIX_ADDRESS, 16, 1,
 						tx_buffer->skb->data,
 						dma_unmap_len(tx_buffer, len),
-						true);
+						DUMP_FLAG_ASCII);
 			}
 		}
 	}
@@ -819,7 +819,8 @@ static void ixgbe_dump(struct ixgbe_adapter *adapter)
 					   DUMP_PREFIX_ADDRESS, 16, 1,
 					   page_address(rx_buffer_info->page) +
 						    rx_buffer_info->page_offset,
-					   ixgbe_rx_bufsz(rx_ring), true);
+					   ixgbe_rx_bufsz(rx_ring),
+					   DUMP_FLAG_ASCII);
 				}
 			}
 		}
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_tx.c b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
index 1ddb11cb25f9..9692ab98765b 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
@@ -409,7 +409,7 @@ static void mlx4_en_handle_err_cqe(struct mlx4_en_priv *priv, struct mlx4_err_cq
 	en_err(priv, "CQE error - cqn 0x%x, ci 0x%x, vendor syndrome: 0x%x syndrome: 0x%x\n",
 	       ring->sp_cqn, cqe_index, err_cqe->vendor_err_syndrome, err_cqe->syndrome);
 	print_hex_dump(KERN_WARNING, "", DUMP_PREFIX_OFFSET, 16, 1, err_cqe, sizeof(*err_cqe),
-		       false);
+		       0);
 
 	wqe_index = be16_to_cpu(err_cqe->wqe_index) & ring->size_mask;
 	tx_info = &ring->tx_info[wqe_index];
@@ -417,7 +417,8 @@ static void mlx4_en_handle_err_cqe(struct mlx4_en_priv *priv, struct mlx4_err_cq
 	en_err(priv, "Related WQE - qpn 0x%x, wqe index 0x%x, wqe size 0x%x\n", ring->qpn,
 	       wqe_index, desc_size);
 	tx_desc = ring->buf + (wqe_index << LOG_TXBB_SIZE);
-	print_hex_dump(KERN_WARNING, "", DUMP_PREFIX_OFFSET, 16, 1, tx_desc, desc_size, false);
+	print_hex_dump(KERN_WARNING, "", DUMP_PREFIX_OFFSET, 16, 1, tx_desc, desc_size,
+		       0);
 
 	if (test_and_set_bit(MLX4_EN_STATE_FLAG_RESTARTING, &priv->state))
 		return;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 30673292e15f..c443e716a0f6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -3326,7 +3326,8 @@ static int verify_offload_pedit_fields(struct mlx5e_priv *priv,
 			NL_SET_ERR_MSG_MOD(extack, "attempt to offload an unsupported field");
 			netdev_warn(priv->netdev, "attempt to offload an unsupported field (cmd %d)\n", cmd);
 			print_hex_dump(KERN_WARNING, "mask: ", DUMP_PREFIX_ADDRESS,
-				       16, 1, cmd_masks, sizeof(zero_masks), true);
+				       16, 1, cmd_masks, sizeof(zero_masks),
+				       DUMP_FLAG_ASCII);
 			return -EOPNOTSUPP;
 		}
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c
index 58bd749b5e4d..b9ac8e83400e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c
@@ -415,7 +415,7 @@ int mlx5_aso_poll_cq(struct mlx5_aso *aso, bool with_data)
 			      err_cqe->syndrome);
 		print_hex_dump(KERN_WARNING, "", DUMP_PREFIX_OFFSET,
 			       16, 1, err_cqe,
-			       sizeof(*err_cqe), false);
+			       sizeof(*err_cqe), 0);
 	}
 
 	mlx5_cqwq_update_db_record(&cq->wq);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/wq.c b/drivers/net/ethernet/mellanox/mlx5/core/wq.c
index 3091dd014650..933243d6da36 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/wq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/wq.c
@@ -86,7 +86,8 @@ void mlx5_wq_cyc_wqe_dump(struct mlx5_wq_cyc *wq, u16 ix, u8 nstrides)
 
 	pr_info("WQE DUMP: WQ size %d WQ cur size %d, WQE index 0x%x, len: %zu\n",
 		mlx5_wq_cyc_get_size(wq), wq->cur_sz, ix, len);
-	print_hex_dump(KERN_WARNING, "", DUMP_PREFIX_OFFSET, 16, 1, wqe, len, false);
+	print_hex_dump(KERN_WARNING, "", DUMP_PREFIX_OFFSET, 16, 1, wqe, len,
+		       0);
 }
 
 void mlx5_wq_cyc_reset(struct mlx5_wq_cyc *wq)
diff --git a/drivers/net/ethernet/mellanox/mlxfw/mlxfw_mfa2.c b/drivers/net/ethernet/mellanox/mlxfw/mlxfw_mfa2.c
index e6f677e42007..c5ae29d6d381 100644
--- a/drivers/net/ethernet/mellanox/mlxfw/mlxfw_mfa2.c
+++ b/drivers/net/ethernet/mellanox/mlxfw/mlxfw_mfa2.c
@@ -147,7 +147,8 @@ mlxfw_mfa2_file_dev_validate(const struct mlxfw_mfa2_file *mfa2_file,
 	}
 
 	print_hex_dump_debug("  -- Device PSID ", DUMP_PREFIX_NONE, 16, 16,
-			     psid->psid, be16_to_cpu(tlv->len), true);
+			     psid->psid, be16_to_cpu(tlv->len),
+			     DUMP_FLAG_ASCII);
 
 	/* Validate the device has COMPONENT_PTR */
 	err = mlxfw_mfa2_tlv_multi_child_count(mfa2_file, multi,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 0c6e1b4c119b..8be42312c76d 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -704,7 +704,7 @@ static void fbnic_mbx_process_rx_msgs(struct fbnic_dev *fbd)
 				 err);
 			print_hex_dump(KERN_WARNING, "fbnic:",
 				       DUMP_PREFIX_OFFSET, 16, 2,
-				       msg, length, true);
+				       msg, length, DUMP_FLAG_ASCII);
 		}
 
 		dev_dbg(fbd->dev, "Parsed msg type %d\n", msg->hdr.type);
diff --git a/drivers/net/ethernet/microchip/enc28j60.c b/drivers/net/ethernet/microchip/enc28j60.c
index d6c9491537e4..79fe8e3e958a 100644
--- a/drivers/net/ethernet/microchip/enc28j60.c
+++ b/drivers/net/ethernet/microchip/enc28j60.c
@@ -891,7 +891,7 @@ static void dump_packet(const char *msg, int len, const char *data)
 {
 	printk(KERN_DEBUG DRV_NAME ": %s - packet len:%d\n", msg, len);
 	print_hex_dump(KERN_DEBUG, "pk data: ", DUMP_PREFIX_OFFSET, 16, 1,
-			data, len, true);
+			data, len, DUMP_FLAG_ASCII);
 }
 
 /*
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
index 0f817c3f92d8..a58ab5519cf1 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
@@ -271,7 +271,7 @@ bool ionic_notifyq_service(struct ionic_cq *cq)
 
 	dev_dbg(lif->ionic->dev, "notifyq event:\n");
 	dynamic_hex_dump("event ", DUMP_PREFIX_OFFSET, 16, 1,
-			 comp, sizeof(*comp), true);
+			 comp, sizeof(*comp), DUMP_FLAG_ASCII);
 
 	switch (le16_to_cpu(comp->event.ecode)) {
 	case IONIC_EVENT_LINK_CHANGE:
@@ -327,7 +327,8 @@ bool ionic_adminq_service(struct ionic_cq *cq)
 
 			dev_dbg(q->dev, "comp admin queue command:\n");
 			dynamic_hex_dump("comp ", DUMP_PREFIX_OFFSET, 16, 1,
-					 &ctx->comp, sizeof(ctx->comp), true);
+					 &ctx->comp, sizeof(ctx->comp),
+					 DUMP_FLAG_ASCII);
 			complete_all(&ctx->work);
 			desc_info->ctx = NULL;
 		}
@@ -398,7 +399,7 @@ int ionic_adminq_post(struct ionic_lif *lif, struct ionic_admin_ctx *ctx)
 
 	dev_dbg(&lif->netdev->dev, "post admin queue command:\n");
 	dynamic_hex_dump("cmd ", DUMP_PREFIX_OFFSET, 16, 1,
-			 &ctx->cmd, sizeof(ctx->cmd), true);
+			 &ctx->cmd, sizeof(ctx->cmd), DUMP_FLAG_ASCII);
 
 	ionic_q_post(q, true);
 
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.c b/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.c
index 1ee2f285cb42..4128580a410b 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.c
@@ -41,7 +41,8 @@ void ionic_rx_filter_replay(struct ionic_lif *lif)
 			memcpy(ac, &f->cmd, sizeof(f->cmd));
 			dev_dbg(&lif->netdev->dev, "replay filter command:\n");
 			dynamic_hex_dump("cmd ", DUMP_PREFIX_OFFSET, 16, 1,
-					 &ctx.cmd, sizeof(ctx.cmd), true);
+					 &ctx.cmd, sizeof(ctx.cmd),
+					 DUMP_FLAG_ASCII);
 
 			err = ionic_adminq_post_wait(lif, &ctx);
 			if (err) {
diff --git a/drivers/net/ethernet/qlogic/qed/qed_ll2.c b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
index ab5ef254a748..a911ad9c31a7 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_ll2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
@@ -185,7 +185,7 @@ static void qed_ll2b_complete_rx_packet(void *cxt,
 	if ((cdev->dp_module & NETIF_MSG_PKTDATA) && buffer->data) {
 		print_hex_dump(KERN_INFO, "",
 			       DUMP_PREFIX_OFFSET, 16, 1,
-			       buffer->data, data->length.packet_length, false);
+			       buffer->data, data->length.packet_length, 0);
 	}
 
 	/* Determine if data is valid */
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
index b9dc0071c5de..9999620f0f92 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
@@ -1484,7 +1484,7 @@ static void dump_skb(struct sk_buff *skb, struct qlcnic_adapter *adapter)
 			  dev_name(&adapter->pdev->dev), __func__);
 
 		print_hex_dump_debug(prefix, DUMP_PREFIX_NONE, 16, 1,
-				     skb->data, skb->len, true);
+				     skb->data, skb->len, DUMP_FLAG_ASCII);
 	}
 }
 
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
index 90df4a0909fa..285ebb0073d2 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
@@ -2945,7 +2945,7 @@ static inline void dump_tx_ring_desc(struct qlcnic_host_tx_ring *tx_ring)
 		pr_info("TX Desc: %d\n", i);
 		print_hex_dump(KERN_INFO, "TX: ", DUMP_PREFIX_OFFSET, 16, 1,
 			       &tx_ring->desc_head[i],
-			       sizeof(struct cmd_desc_type0), true);
+			       sizeof(struct cmd_desc_type0), DUMP_FLAG_ASCII);
 	}
 }
 
diff --git a/drivers/net/ethernet/realtek/8139too.c b/drivers/net/ethernet/realtek/8139too.c
index 9ce0e8a64ba8..9d793bca1138 100644
--- a/drivers/net/ethernet/realtek/8139too.c
+++ b/drivers/net/ethernet/realtek/8139too.c
@@ -1979,7 +1979,7 @@ static int rtl8139_rx(struct net_device *dev, struct rtl8139_private *tp,
 #if RTL8139_DEBUG > 2
 		print_hex_dump(KERN_DEBUG, "Frame contents: ",
 			       DUMP_PREFIX_OFFSET, 16, 1,
-			       &rx_ring[ring_offset], 70, true);
+			       &rx_ring[ring_offset], 70, DUMP_FLAG_ASCII);
 #endif
 
 		/* Packet copy from FIFO still in progress.
diff --git a/drivers/net/ethernet/smsc/smc9194.c b/drivers/net/ethernet/smsc/smc9194.c
index e2e7b1c68563..b4fdcd98d02d 100644
--- a/drivers/net/ethernet/smsc/smc9194.c
+++ b/drivers/net/ethernet/smsc/smc9194.c
@@ -1033,7 +1033,7 @@ static void print_packet( byte * buf, int length )
 {
 #if 0
 	print_hex_dump_debug(DRV_NAME, DUMP_PREFIX_OFFSET, 16, 1,
-			     buf, length, true);
+			     buf, length, DUMP_FLAG_ASCII);
 #endif
 }
 #endif
diff --git a/drivers/net/ethernet/vertexcom/mse102x.c b/drivers/net/ethernet/vertexcom/mse102x.c
index edd8b59680e5..d759da1dafa3 100644
--- a/drivers/net/ethernet/vertexcom/mse102x.c
+++ b/drivers/net/ethernet/vertexcom/mse102x.c
@@ -298,7 +298,7 @@ static void mse102x_dump_packet(const char *msg, int len, const char *data)
 {
 	printk(KERN_DEBUG ": %s - packet len:%d\n", msg, len);
 	print_hex_dump(KERN_DEBUG, "pk data: ", DUMP_PREFIX_OFFSET, 16, 1,
-		       data, len, true);
+		       data, len, DUMP_FLAG_ASCII);
 }
 
 static void mse102x_rx_pkt_spi(struct mse102x_net *mse)
diff --git a/drivers/net/fddi/skfp/skfddi.c b/drivers/net/fddi/skfp/skfddi.c
index a273362c9e70..1ad2f7d0ff94 100644
--- a/drivers/net/fddi/skfp/skfddi.c
+++ b/drivers/net/fddi/skfp/skfddi.c
@@ -1529,7 +1529,8 @@ void mac_drv_tx_complete(struct s_smc *smc, volatile struct s_smt_fp_txd *txd)
 void dump_data(unsigned char *Data, int length)
 {
 	printk(KERN_INFO "---Packet start---\n");
-	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE, 16, 1, Data, min_t(size_t, length, 64), false);
+	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE, 16, 1, Data, min_t(size_t, length, 64),
+		       0);
 	printk(KERN_INFO "------------------\n");
 }				// dump_data
 #else
diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index a5684ef5884b..9abf3cc3c963 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -2270,7 +2270,8 @@ static int sfp_sm_mod_probe(struct sfp *sfp, bool report)
 				"EEPROM base structure checksum failure: 0x%02x != 0x%02x\n",
 				check, id.base.cc_base);
 			print_hex_dump(KERN_ERR, "sfp EE: ", DUMP_PREFIX_OFFSET,
-				       16, 1, &id, sizeof(id), true);
+				       16, 1, &id, sizeof(id),
+				       DUMP_FLAG_ASCII);
 			return -EINVAL;
 		}
 	}
@@ -2299,7 +2300,8 @@ static int sfp_sm_mod_probe(struct sfp *sfp, bool report)
 				"EEPROM extended structure checksum failure: 0x%02x != 0x%02x\n",
 				check, id.ext.cc_ext);
 			print_hex_dump(KERN_ERR, "sfp EE: ", DUMP_PREFIX_OFFSET,
-				       16, 1, &id, sizeof(id), true);
+				       16, 1, &id, sizeof(id),
+				       DUMP_FLAG_ASCII);
 			memset(&id.ext, 0, sizeof(id.ext));
 		}
 	}
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 1d06c560c5e6..83f8eb529870 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2137,7 +2137,8 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 				print_hex_dump(KERN_ERR, "tun: ",
 					       DUMP_PREFIX_NONE,
 					       16, 1, skb->head,
-					       min((int)tun16_to_cpu(tun, gso.hdr_len), 64), true);
+					       min((int)tun16_to_cpu(tun, gso.hdr_len), 64),
+					       DUMP_FLAG_ASCII);
 			}
 			WARN_ON_ONCE(1);
 			return -EINVAL;
diff --git a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
index bccc27de848d..e77adabb096f 100644
--- a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
+++ b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
@@ -74,7 +74,7 @@ enum wcn36xx_debug_mask {
 	if (wcn36xx_dbg_mask & mask)					\
 		print_hex_dump(KERN_DEBUG, pr_fmt(prefix_str),	\
 			       DUMP_PREFIX_OFFSET, 32, 1,	\
-			       buf, len, false);		\
+			       buf, len, 0);			\
 } while (0)
 
 enum wcn36xx_ampdu_state {
diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index e8f1d30a8d73..6ffb97779f40 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -1112,7 +1112,8 @@ static void wil_print_connect_params(struct wil6210_priv *wil,
 		wil_info(wil, "  BSSID: %pM\n", sme->bssid);
 	if (sme->ssid)
 		print_hex_dump(KERN_INFO, "  SSID: ", DUMP_PREFIX_OFFSET,
-			       16, 1, sme->ssid, sme->ssid_len, true);
+			       16, 1, sme->ssid, sme->ssid_len,
+			       DUMP_FLAG_ASCII);
 	if (sme->prev_bssid)
 		wil_info(wil, "  Previous BSSID=%pM\n", sme->prev_bssid);
 	wil_info(wil, "  Auth Type: %s\n",
diff --git a/drivers/net/wireless/ath/wil6210/ethtool.c b/drivers/net/wireless/ath/wil6210/ethtool.c
index 29a9f17c2df0..58d0680f5397 100644
--- a/drivers/net/wireless/ath/wil6210/ethtool.c
+++ b/drivers/net/wireless/ath/wil6210/ethtool.c
@@ -95,7 +95,7 @@ wil_ethtoolops_set_coalesce(struct net_device *ndev,
 out_bad:
 	wil_dbg_misc(wil, "Unsupported coalescing params. Raw command:\n");
 	print_hex_dump_debug("DBG[MISC] coal ", DUMP_PREFIX_OFFSET, 16, 4,
-			     cp, sizeof(*cp), false);
+			     cp, sizeof(*cp), 0);
 	mutex_unlock(&wil->mutex);
 	return -EINVAL;
 }
diff --git a/drivers/net/wireless/ath/wil6210/fw_inc.c b/drivers/net/wireless/ath/wil6210/fw_inc.c
index c3c0b289dcf3..36b0a8467717 100644
--- a/drivers/net/wireless/ath/wil6210/fw_inc.c
+++ b/drivers/net/wireless/ath/wil6210/fw_inc.c
@@ -14,7 +14,8 @@
 			groupsize, buf, len, ascii)			\
 			print_hex_dump_debug("DBG[ FW ]" prefix_str,	\
 					     prefix_type, rowsize,	\
-					     groupsize, buf, len, ascii)
+					     groupsize, buf, len,	\
+					     ascii ? DUMP_FLAG_ASCII : 0)
 
 static bool wil_fw_addr_check(struct wil6210_priv *wil,
 			      void __iomem **ioaddr, __le32 val,
diff --git a/drivers/net/wireless/ath/wil6210/txrx_edma.c b/drivers/net/wireless/ath/wil6210/txrx_edma.c
index 1ba1f21ebea2..a0e5a9c5ad6d 100644
--- a/drivers/net/wireless/ath/wil6210/txrx_edma.c
+++ b/drivers/net/wireless/ath/wil6210/txrx_edma.c
@@ -904,7 +904,7 @@ static struct sk_buff *wil_sring_reap_rx_edma(struct wil6210_priv *wil,
 		print_hex_dump(KERN_ERR, "RxS ", DUMP_PREFIX_OFFSET, 16, 1,
 			       msg, wil->use_compressed_rx_status ?
 			       sizeof(struct wil_rx_status_compressed) :
-			       sizeof(struct wil_rx_status_extended), false);
+			       sizeof(struct wil_rx_status_extended), 0);
 
 		wil_rx_status_reset_buff_id(sring);
 		wil_sring_advance_swhead(sring);
@@ -969,7 +969,7 @@ static struct sk_buff *wil_sring_reap_rx_edma(struct wil6210_priv *wil,
 		print_hex_dump(KERN_ERR, "RxS ", DUMP_PREFIX_OFFSET, 16, 1,
 			       msg, wil->use_compressed_rx_status ?
 			       sizeof(struct wil_rx_status_compressed) :
-			       sizeof(struct wil_rx_status_extended), false);
+			       sizeof(struct wil_rx_status_extended), 0);
 
 		stats->rx_large_frame++;
 		rxdata->skipping = true;
diff --git a/drivers/net/wireless/ath/wil6210/wil6210.h b/drivers/net/wireless/ath/wil6210/wil6210.h
index 9bd1286d2857..edb257a1e653 100644
--- a/drivers/net/wireless/ath/wil6210/wil6210.h
+++ b/drivers/net/wireless/ath/wil6210/wil6210.h
@@ -1162,19 +1162,22 @@ void wil_get_board_file(struct wil6210_priv *wil, char *buf, size_t len);
 			  groupsize, buf, len, ascii)		\
 			  print_hex_dump_debug("DBG[TXRX]" prefix_str,\
 					 prefix_type, rowsize,	\
-					 groupsize, buf, len, ascii)
+					 groupsize, buf, len,	\
+					 ascii ? DUMP_FLAG_ASCII : 0)
 
 #define wil_hex_dump_wmi(prefix_str, prefix_type, rowsize,	\
 			 groupsize, buf, len, ascii)		\
 			 print_hex_dump_debug("DBG[ WMI]" prefix_str,\
 					prefix_type, rowsize,	\
-					groupsize, buf, len, ascii)
+					groupsize, buf, len,	\
+					ascii ? DUMP_FLAG_ASCII : 0)
 
 #define wil_hex_dump_misc(prefix_str, prefix_type, rowsize,	\
 			  groupsize, buf, len, ascii)		\
 			  print_hex_dump_debug("DBG[MISC]" prefix_str,\
 					prefix_type, rowsize,	\
-					groupsize, buf, len, ascii)
+					groupsize, buf, len,	\
+					ascii ? DUMP_FLAG_ASCII : 0)
 #else /* defined(CONFIG_DYNAMIC_DEBUG) */
 static inline
 void wil_hex_dump_txrx(const char *prefix_str, int prefix_type, int rowsize,
diff --git a/drivers/net/wireless/ath/wil6210/wmi.c b/drivers/net/wireless/ath/wil6210/wmi.c
index 8ff69dc72fb9..0c4936301c7d 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.c
+++ b/drivers/net/wireless/ath/wil6210/wmi.c
@@ -3376,7 +3376,7 @@ static void wmi_event_handle(struct wil6210_priv *wil,
 	} else {
 		wil_err(wil, "Unknown event type\n");
 		print_hex_dump(KERN_ERR, "evt?? ", DUMP_PREFIX_OFFSET, 16, 1,
-			       hdr, sizeof(*hdr) + len, true);
+			       hdr, sizeof(*hdr) + len, DUMP_FLAG_ASCII);
 	}
 }
 
diff --git a/drivers/net/wireless/broadcom/b43/main.c b/drivers/net/wireless/broadcom/b43/main.c
index 8e56dcf9309d..c4df614f75cb 100644
--- a/drivers/net/wireless/broadcom/b43/main.c
+++ b/drivers/net/wireless/broadcom/b43/main.c
@@ -1918,7 +1918,7 @@ static void handle_irq_ucode_debug(struct b43_wldev *dev)
 		}
 		b43info(dev->wl, "Shared memory dump:\n");
 		print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET,
-			       16, 2, buf, 4096, 1);
+			       16, 2, buf, 4096, DUMP_FLAG_ASCII);
 		kfree(buf);
 		break;
 	case B43_DEBUGIRQ_DUMP_REGS:
diff --git a/drivers/net/wireless/intel/iwlegacy/common.h b/drivers/net/wireless/intel/iwlegacy/common.h
index 69687fcf963f..22f53cab9809 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.h
+++ b/drivers/net/wireless/intel/iwlegacy/common.h
@@ -2919,7 +2919,8 @@ il_get_debug_level(struct il_priv *il)
 #define il_print_hex_error(il, p, len)					\
 do {									\
 	print_hex_dump(KERN_ERR, "iwl data: ",				\
-		       DUMP_PREFIX_OFFSET, 16, 1, p, len, 1);		\
+		       DUMP_PREFIX_OFFSET, 16, 1, p, len,		\
+		       DUMP_FLAG_ASCII);				\
 } while (0)
 
 #ifdef CONFIG_IWLEGACY_DEBUG
@@ -2934,7 +2935,8 @@ do {									\
 do {									\
 	if (il_get_debug_level(il) & level)				\
 		print_hex_dump(KERN_DEBUG, "iwl data: ",		\
-			       DUMP_PREFIX_OFFSET, 16, 1, p, len, 1);	\
+			       DUMP_PREFIX_OFFSET, 16, 1, p, len,	\
+			       DUMP_FLAG_ASCII);					\
 } while (0)
 
 #else
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-debug.h b/drivers/net/wireless/intel/iwlwifi/iwl-debug.h
index 1b9f16a31b54..00a4cf9773b7 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-debug.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-debug.h
@@ -82,7 +82,8 @@ __iwl_dbg(struct device *dev,
 #define iwl_print_hex_error(m, p, len)					\
 do {									\
 	print_hex_dump(KERN_ERR, "iwl data: ",				\
-		       DUMP_PREFIX_OFFSET, 16, 1, p, len, 1);		\
+		       DUMP_PREFIX_OFFSET, 16, 1, p, len,		\
+		       DUMP_FLAG_ASCII);				\
 } while (0)
 
 #define __IWL_DEBUG_DEV(dev, level, limit, fmt, args...)		\
@@ -102,7 +103,8 @@ do {									\
 do {                                            			\
 	if (iwl_have_debug_level(level))				\
 		print_hex_dump(KERN_DEBUG, "iwl data: ",		\
-			       DUMP_PREFIX_OFFSET, 16, 1, p, len, 1);	\
+			       DUMP_PREFIX_OFFSET, 16, 1, p, len,	\
+			       DUMP_FLAG_ASCII);			\
 } while (0)
 #else
 #define iwl_print_hex_dump(m, level, p, len)
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index c5164ae41b54..e849166b244b 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -202,7 +202,7 @@ do {								\
 	if ((adapter)->debug_mask & MWIFIEX_DBG_##dbg_mask)	\
 		print_hex_dump(KERN_DEBUG, str,			\
 			       DUMP_PREFIX_OFFSET, 16, 1,	\
-			       buf, len, false);		\
+			       buf, len, 0);			\
 } while (0)
 
 /** Min BGSCAN interval 15 second */
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index 043fa364e701..99203b2f2827 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -1897,7 +1897,7 @@ static void rtl8xxxu_dump_efuse(struct rtl8xxxu_priv *priv)
 		 priv->chip_name, EFUSE_MAP_LEN);
 
 	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET, 16, 1,
-		       priv->efuse_wifi.raw, EFUSE_MAP_LEN, true);
+		       priv->efuse_wifi.raw, EFUSE_MAP_LEN, DUMP_FLAG_ASCII);
 }
 
 void rtl8xxxu_reset_8051(struct rtl8xxxu_priv *priv)
@@ -6228,7 +6228,7 @@ static void rtl8723bu_handle_c2h(struct rtl8xxxu_priv *priv,
 		dev_info(dev, "Unhandled C2H event %02x seq %02x\n",
 			 c2h->id, c2h->seq);
 		print_hex_dump(KERN_INFO, "C2H content: ", DUMP_PREFIX_NONE,
-			       16, 1, c2h->raw.payload, len, false);
+			       16, 1, c2h->raw.payload, len, 0);
 		break;
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723x.c b/drivers/net/wireless/realtek/rtw88/rtw8723x.c
index 0d0b6c2cb9aa..11aaa430ff9f 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723x.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723x.c
@@ -181,7 +181,7 @@ static void efuse_debug_dump(struct rtw_dev *rtwdev,
 
 	rtw_dbg(rtwdev, RTW_DBG_EFUSE, "EFUSE raw logical map:\n");
 	print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_OFFSET, 16, 1,
-		       (u8 *)map, sizeof(struct rtw8723x_efuse), false);
+		       (u8 *)map, sizeof(struct rtw8723x_efuse), 0);
 	rtw_dbg(rtwdev, RTW_DBG_EFUSE, "Parsed rtw8723x EFUSE data:\n");
 	DBG_EFUSE_VAL(rtwdev, map, rtl_id);
 	DBG_EFUSE_VAL(rtwdev, map, afe);
diff --git a/drivers/net/wireless/silabs/wfx/bh.c b/drivers/net/wireless/silabs/wfx/bh.c
index 21dfdcf9cc27..3bf68dd8c960 100644
--- a/drivers/net/wireless/silabs/wfx/bh.c
+++ b/drivers/net/wireless/silabs/wfx/bh.c
@@ -93,7 +93,7 @@ static int rx_helper(struct wfx_dev *wdev, size_t read_len, int *is_cnf)
 		dev_err(wdev->dev, "inconsistent message length: %zu != %zu\n",
 			computed_len, read_len);
 		print_hex_dump(KERN_INFO, "hif: ", DUMP_PREFIX_OFFSET, 16, 1,
-			       hif, read_len, true);
+			       hif, read_len, DUMP_FLAG_ASCII);
 		goto err;
 	}
 
diff --git a/drivers/net/wireless/silabs/wfx/hif_rx.c b/drivers/net/wireless/silabs/wfx/hif_rx.c
index 64ca8acb8e4f..d06de5fcac87 100644
--- a/drivers/net/wireless/silabs/wfx/hif_rx.c
+++ b/drivers/net/wireless/silabs/wfx/hif_rx.c
@@ -313,7 +313,7 @@ static int wfx_hif_error_indication(struct wfx_dev *wdev,
 	else
 		dev_err(wdev->dev, "asynchronous error: unknown: %08x\n", type);
 	print_hex_dump(KERN_INFO, "hif: ", DUMP_PREFIX_OFFSET,
-		       16, 1, hif, le16_to_cpu(hif->len), false);
+		       16, 1, hif, le16_to_cpu(hif->len), 0);
 	wdev->chip_frozen = true;
 
 	return 0;
@@ -330,7 +330,7 @@ static int wfx_hif_exception_indication(struct wfx_dev *wdev,
 	else
 		dev_err(wdev->dev, "firmware exception\n");
 	print_hex_dump(KERN_INFO, "hif: ", DUMP_PREFIX_OFFSET,
-		       16, 1, hif, le16_to_cpu(hif->len), false);
+		       16, 1, hif, le16_to_cpu(hif->len), 0);
 	wdev->chip_frozen = true;
 
 	return -1;
diff --git a/drivers/net/wireless/ti/wl1251/wl1251.h b/drivers/net/wireless/ti/wl1251/wl1251.h
index 83adbc3c25dc..9ae40c151ea5 100644
--- a/drivers/net/wireless/ti/wl1251/wl1251.h
+++ b/drivers/net/wireless/ti/wl1251/wl1251.h
@@ -75,7 +75,7 @@ enum {
 				       DUMP_PREFIX_OFFSET, 16, 1,	\
 				       buf,				\
 				       min_t(size_t, len, DEBUG_DUMP_LIMIT), \
-				       true);				\
+				       DUMP_FLAG_ASCII);		\
 	} while (0)
 
 #define WL1251_DEFAULT_RX_CONFIG (CFG_UNI_FILTER_EN |	\
diff --git a/drivers/net/wireless/ti/wlcore/debug.h b/drivers/net/wireless/ti/wlcore/debug.h
index 2ffa6d67225a..13464409b71c 100644
--- a/drivers/net/wireless/ti/wlcore/debug.h
+++ b/drivers/net/wireless/ti/wlcore/debug.h
@@ -92,7 +92,7 @@ extern u32 wl12xx_debug_level;
 					DUMP_PREFIX_OFFSET, 16, 1,	      \
 					buf,				      \
 					min_t(size_t, len, DEBUG_DUMP_LIMIT), \
-					true);				      \
+					DUMP_FLAG_ASCII);		      \
 	} while (0)
 
 #endif /* __DEBUG_H__ */
diff --git a/drivers/net/wireless/ti/wlcore/sdio.c b/drivers/net/wireless/ti/wlcore/sdio.c
index 92fb5b8dcdae..a3cacb258ab0 100644
--- a/drivers/net/wireless/ti/wlcore/sdio.c
+++ b/drivers/net/wireless/ti/wlcore/sdio.c
@@ -81,7 +81,7 @@ static int __must_check wl12xx_sdio_raw_read(struct device *child, int addr,
 		printk(KERN_DEBUG "wlcore_sdio: READ from 0x%04x\n", addr);
 		print_hex_dump(KERN_DEBUG, "wlcore_sdio: READ ",
 			       DUMP_PREFIX_OFFSET, 16, 1,
-			       buf, len, false);
+			       buf, len, 0);
 	}
 
 	return ret;
@@ -100,7 +100,7 @@ static int __must_check wl12xx_sdio_raw_write(struct device *child, int addr,
 		printk(KERN_DEBUG "wlcore_sdio: WRITE to 0x%04x\n", addr);
 		print_hex_dump(KERN_DEBUG, "wlcore_sdio: WRITE ",
 				DUMP_PREFIX_OFFSET, 16, 1,
-				buf, len, false);
+				buf, len, 0);
 	}
 
 	if (unlikely(addr == HW_ACCESS_ELP_CTRL_REG)) {
diff --git a/drivers/nfc/mei_phy.c b/drivers/nfc/mei_phy.c
index f9cca885beec..c28ab7481808 100644
--- a/drivers/nfc/mei_phy.c
+++ b/drivers/nfc/mei_phy.c
@@ -71,14 +71,14 @@ struct mei_nfc_connect_resp {
 do {								\
 	pr_debug("%s:\n", info);				\
 	print_hex_dump_debug("mei in : ", DUMP_PREFIX_OFFSET,	\
-			16, 1, (skb)->data, (skb)->len, false);	\
+			16, 1, (skb)->data, (skb)->len, 0);	\
 } while (0)
 
 #define MEI_DUMP_SKB_OUT(info, skb)				\
 do {								\
 	pr_debug("%s:\n", info);				\
 	print_hex_dump_debug("mei out: ", DUMP_PREFIX_OFFSET,	\
-			16, 1, (skb)->data, (skb)->len, false);	\
+			16, 1, (skb)->data, (skb)->len, 0);	\
 } while (0)
 
 #define MEI_DUMP_NFC_HDR(info, _hdr)                                \
diff --git a/drivers/nfc/pn533/i2c.c b/drivers/nfc/pn533/i2c.c
index 132c050a365d..73dc30f97afb 100644
--- a/drivers/nfc/pn533/i2c.c
+++ b/drivers/nfc/pn533/i2c.c
@@ -60,7 +60,7 @@ static int pn533_i2c_send_frame(struct pn533 *dev,
 	phy->aborted = false;
 
 	print_hex_dump_debug("PN533_i2c TX: ", DUMP_PREFIX_NONE, 16, 1,
-			     out->data, out->len, false);
+			     out->data, out->len, 0);
 
 	rc = i2c_master_send(client, out->data, out->len);
 
diff --git a/drivers/nfc/pn533/pn533.c b/drivers/nfc/pn533/pn533.c
index b19c39dcfbd9..ea63247fb6c5 100644
--- a/drivers/nfc/pn533/pn533.c
+++ b/drivers/nfc/pn533/pn533.c
@@ -2186,7 +2186,7 @@ void pn533_recv_frame(struct pn533 *dev, struct sk_buff *skb, int status)
 	}
 
 	print_hex_dump_debug("PN533 RX: ", DUMP_PREFIX_NONE, 16, 1, skb->data,
-			     dev->ops->rx_frame_size(skb->data), false);
+			     dev->ops->rx_frame_size(skb->data), 0);
 
 	if (!dev->ops->rx_is_frame_valid(skb->data, dev)) {
 		nfc_err(dev->dev, "Received an invalid frame\n");
diff --git a/drivers/nfc/pn533/uart.c b/drivers/nfc/pn533/uart.c
index cfbbe0713317..a81dd65a049e 100644
--- a/drivers/nfc/pn533/uart.c
+++ b/drivers/nfc/pn533/uart.c
@@ -53,7 +53,7 @@ static int pn532_uart_send_frame(struct pn533 *dev,
 	int err;
 
 	print_hex_dump_debug("PN532_uart TX: ", DUMP_PREFIX_NONE, 16, 1,
-			     out->data, out->len, false);
+			     out->data, out->len, 0);
 
 	pn532->cur_out_buf = out;
 	if (pn532->send_wakeup) {
diff --git a/drivers/nfc/pn533/usb.c b/drivers/nfc/pn533/usb.c
index a187f0e0b0f7..90082924b100 100644
--- a/drivers/nfc/pn533/usb.c
+++ b/drivers/nfc/pn533/usb.c
@@ -173,7 +173,7 @@ static int pn533_usb_send_frame(struct pn533 *dev,
 	phy->out_urb->transfer_buffer_length = out->len;
 
 	print_hex_dump_debug("PN533 TX: ", DUMP_PREFIX_NONE, 16, 1,
-			     out->data, out->len, false);
+			     out->data, out->len, 0);
 
 	arg.phy = phy;
 	init_completion(&arg.done);
@@ -371,7 +371,7 @@ static void pn533_acr122_poweron_rdr_resp(struct urb *urb)
 
 	print_hex_dump_debug("ACR122 RX: ", DUMP_PREFIX_NONE, 16, 1,
 		       urb->transfer_buffer, urb->transfer_buffer_length,
-		       false);
+		       0);
 
 	arg->rc = urb->status;
 	complete(&arg->done);
@@ -399,7 +399,7 @@ static int pn533_acr122_poweron_rdr(struct pn533_usb_phy *phy)
 	phy->in_urb->context = &arg;
 
 	print_hex_dump_debug("ACR122 TX: ", DUMP_PREFIX_NONE, 16, 1,
-		       cmd, sizeof(cmd), false);
+		       cmd, sizeof(cmd), 0);
 
 	rc = usb_bulk_msg(phy->udev, phy->out_urb->pipe, buffer, sizeof(cmd),
 			  &transferred, 5000);
diff --git a/drivers/nfc/pn544/i2c.c b/drivers/nfc/pn544/i2c.c
index 9fe664960b38..01d83ec8a08d 100644
--- a/drivers/nfc/pn544/i2c.c
+++ b/drivers/nfc/pn544/i2c.c
@@ -338,7 +338,7 @@ static int check_crc(u8 *buf, int buflen)
 		       crc, buf[len - 1], buf[len - 2]);
 		pr_info("%s: BAD CRC\n", __func__);
 		print_hex_dump(KERN_DEBUG, "crc: ", DUMP_PREFIX_NONE,
-			       16, 2, buf, buflen, false);
+			       16, 2, buf, buflen, 0);
 		return -EPERM;
 	}
 	return 0;
diff --git a/drivers/nfc/pn544/pn544.c b/drivers/nfc/pn544/pn544.c
index 32a61a185142..3b888cbb3b6d 100644
--- a/drivers/nfc/pn544/pn544.c
+++ b/drivers/nfc/pn544/pn544.c
@@ -315,7 +315,7 @@ static int pn544_hci_ready(struct nfc_hci_dev *hdev)
 
 	print_hex_dump(KERN_DEBUG, "FULL VERSION SOFTWARE INFO: ",
 		       DUMP_PREFIX_NONE, 16, 1,
-		       skb->data, FULL_VERSION_LEN, false);
+		       skb->data, FULL_VERSION_LEN, 0);
 
 	kfree_skb(skb);
 
@@ -457,7 +457,7 @@ static int pn544_hci_dep_link_up(struct nfc_hci_dev *hdev,
 		goto exit;
 	}
 	print_hex_dump(KERN_DEBUG, "remote gb: ", DUMP_PREFIX_OFFSET,
-			16, 1, rgb_skb->data, rgb_skb->len, true);
+			16, 1, rgb_skb->data, rgb_skb->len, DUMP_FLAG_ASCII);
 
 	r = nfc_set_remote_general_bytes(hdev->ndev, rgb_skb->data,
 						rgb_skb->len);
diff --git a/drivers/nfc/port100.c b/drivers/nfc/port100.c
index 00d8ea6dcb5d..a488b405fcc9 100644
--- a/drivers/nfc/port100.c
+++ b/drivers/nfc/port100.c
@@ -643,7 +643,7 @@ static void port100_recv_response(struct urb *urb)
 	}
 
 	print_hex_dump_debug("PORT100 RX: ", DUMP_PREFIX_NONE, 16, 1, in_frame,
-			     port100_rx_frame_size(in_frame), false);
+			     port100_rx_frame_size(in_frame), 0);
 
 	if (!port100_rx_frame_is_cmd_response(dev, in_frame)) {
 		nfc_err(&dev->interface->dev,
@@ -778,7 +778,7 @@ static int port100_send_frame_async(struct port100 *dev,
 	dev->in_urb->transfer_buffer_length = in_len;
 
 	print_hex_dump_debug("PORT100 TX: ", DUMP_PREFIX_NONE, 16, 1,
-			     out->data, out->len, false);
+			     out->data, out->len, 0);
 
 	rc = usb_submit_urb(dev->out_urb, GFP_KERNEL);
 	if (rc)
diff --git a/drivers/nfc/st21nfca/core.c b/drivers/nfc/st21nfca/core.c
index 161caf2675cf..07f6d58b123c 100644
--- a/drivers/nfc/st21nfca/core.c
+++ b/drivers/nfc/st21nfca/core.c
@@ -297,7 +297,7 @@ static int st21nfca_hci_ready(struct nfc_hci_dev *hdev)
 
 	print_hex_dump(KERN_DEBUG, "FULL VERSION SOFTWARE INFO: ",
 		       DUMP_PREFIX_NONE, 16, 1,
-		       skb->data, FULL_VERSION_LEN, false);
+		       skb->data, FULL_VERSION_LEN, 0);
 
 	kfree_skb(skb);
 
diff --git a/drivers/nfc/st21nfca/i2c.c b/drivers/nfc/st21nfca/i2c.c
index 02c3d11a19c4..4eb037da3259 100644
--- a/drivers/nfc/st21nfca/i2c.c
+++ b/drivers/nfc/st21nfca/i2c.c
@@ -274,7 +274,7 @@ static int check_crc(u8 *buf, int buflen)
 
 		pr_info(DRIVER_DESC ": %s : BAD CRC\n", __func__);
 		print_hex_dump(KERN_DEBUG, "crc: ", DUMP_PREFIX_NONE,
-			       16, 2, buf, buflen, false);
+			       16, 2, buf, buflen, 0);
 		return -EPERM;
 	}
 	return 0;
diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
index 9e1a34e23af2..f69a4158b385 100644
--- a/drivers/nfc/trf7970a.c
+++ b/drivers/nfc/trf7970a.c
@@ -611,7 +611,7 @@ static void trf7970a_send_upstream(struct trf7970a *trf)
 	if (trf->rx_skb && !IS_ERR(trf->rx_skb) && !trf->aborting)
 		print_hex_dump_debug("trf7970a rx data: ", DUMP_PREFIX_NONE,
 				     16, 1, trf->rx_skb->data, trf->rx_skb->len,
-				     false);
+				     0);
 
 	trf->state = TRF7970A_ST_IDLE;
 
@@ -653,7 +653,7 @@ static int trf7970a_transmit(struct trf7970a *trf, struct sk_buff *skb,
 	int ret;
 
 	print_hex_dump_debug("trf7970a tx data: ", DUMP_PREFIX_NONE,
-			     16, 1, skb->data, len, false);
+			     16, 1, skb->data, len, 0);
 
 	spi_message_init(&m);
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b14b9876c030..21cbb987ab6e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1843,7 +1843,7 @@ static void early_dump_pci_device(struct pci_dev *pdev)
 		pci_read_config_dword(pdev, i, &value[i / 4]);
 
 	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET, 16, 1,
-		       value, 256, false);
+		       value, 256, 0);
 }
 
 static const char *pci_type_str(struct pci_dev *dev)
diff --git a/drivers/platform/surface/aggregator/ssh_packet_layer.c b/drivers/platform/surface/aggregator/ssh_packet_layer.c
index d726b1a86319..23988a269bd3 100644
--- a/drivers/platform/surface/aggregator/ssh_packet_layer.c
+++ b/drivers/platform/surface/aggregator/ssh_packet_layer.c
@@ -1066,7 +1066,7 @@ static int ssh_ptl_tx_packet(struct ssh_ptl *ptl, struct ssh_packet *packet)
 
 	ptl_dbg(ptl, "tx: sending data (length: %zu)\n", packet->data.len);
 	print_hex_dump_debug("tx: ", DUMP_PREFIX_OFFSET, 16, 1,
-			     packet->data.ptr, packet->data.len, false);
+			     packet->data.ptr, packet->data.len, 0);
 
 	do {
 		ssize_t status, len;
@@ -1812,7 +1812,7 @@ static int ssh_ptl_rx_threadfn(void *data)
 		ptl_dbg(ptl, "rx: received data (size: %zu)\n", n);
 		print_hex_dump_debug("rx: ", DUMP_PREFIX_OFFSET, 16, 1,
 				     ptl->rx.buf.ptr + ptl->rx.buf.len - n,
-				     n, false);
+				     n, 0);
 
 		/* Parse until we need more bytes or buffer is empty. */
 		while (offs < ptl->rx.buf.len) {
diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/amd/pmf/tee-if.c
index e246367aacee..1bcf5371406c 100644
--- a/drivers/platform/x86/amd/pmf/tee-if.c
+++ b/drivers/platform/x86/amd/pmf/tee-if.c
@@ -293,7 +293,7 @@ static int amd_pmf_start_policy_engine(struct amd_pmf_dev *dev)
 static void amd_pmf_hex_dump_pb(struct amd_pmf_dev *dev)
 {
 	print_hex_dump_debug("(pb):  ", DUMP_PREFIX_OFFSET, 16, 1, dev->policy_buf,
-			     dev->policy_sz, false);
+			     dev->policy_sz, 0);
 }
 
 static ssize_t amd_pmf_get_pb_data(struct file *filp, const char __user *buf,
diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
index 90de737fbc90..183cf30c9ef8 100644
--- a/drivers/ras/amd/fmpm.c
+++ b/drivers/ras/amd/fmpm.c
@@ -616,7 +616,8 @@ static bool fmp_is_valid(struct fru_rec *rec)
 	checksum = do_fmp_checksum(fmp, len) + fmp->checksum;
 	if (checksum) {
 		pr_debug("fmp checksum failed: sum = 0x%x\n", checksum);
-		print_hex_dump_debug("fmp record: ", DUMP_PREFIX_NONE, 16, 1, fmp, len, false);
+		print_hex_dump_debug("fmp record: ", DUMP_PREFIX_NONE, 16, 1, fmp, len,
+				     0);
 		return false;
 	}
 
diff --git a/drivers/rpmsg/rpmsg_ns.c b/drivers/rpmsg/rpmsg_ns.c
index bde8c8d433e0..c3d70b93f6ce 100644
--- a/drivers/rpmsg/rpmsg_ns.c
+++ b/drivers/rpmsg/rpmsg_ns.c
@@ -39,7 +39,7 @@ static int rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
 
 #if defined(CONFIG_DYNAMIC_DEBUG)
 	dynamic_hex_dump("NS announcement: ", DUMP_PREFIX_NONE, 16, 1,
-			 data, len, true);
+			 data, len, DUMP_FLAG_ASCII);
 #endif
 
 	if (len != sizeof(*msg)) {
diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 89d7a3b8c48b..340308969718 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -622,7 +622,7 @@ static int rpmsg_send_offchannel_raw(struct rpmsg_device *rpdev,
 		src, dst, len, msg->flags, msg->reserved);
 #if defined(CONFIG_DYNAMIC_DEBUG)
 	dynamic_hex_dump("rpmsg_virtio TX: ", DUMP_PREFIX_NONE, 16, 1,
-			 msg, sizeof(*msg) + len, true);
+			 msg, sizeof(*msg) + len, DUMP_FLAG_ASCII);
 #endif
 
 	rpmsg_sg_init(&sg, msg, sizeof(*msg) + len);
@@ -722,7 +722,7 @@ static int rpmsg_recv_single(struct virtproc_info *vrp, struct device *dev,
 		__rpmsg32_to_cpu(little_endian, msg->reserved));
 #if defined(CONFIG_DYNAMIC_DEBUG)
 	dynamic_hex_dump("rpmsg_virtio RX: ", DUMP_PREFIX_NONE, 16, 1,
-			 msg, sizeof(*msg) + msg_len, true);
+			 msg, sizeof(*msg) + msg_len, DUMP_FLAG_ASCII);
 #endif
 
 	/*
diff --git a/drivers/s390/crypto/ap_queue.c b/drivers/s390/crypto/ap_queue.c
index 1f647ffd6f4d..8d71bec3cb69 100644
--- a/drivers/s390/crypto/ap_queue.c
+++ b/drivers/s390/crypto/ap_queue.c
@@ -137,7 +137,7 @@ static struct ap_queue_status ap_sm_recv(struct ap_queue *aq)
 	switch (status.response_code) {
 	case AP_RESPONSE_NORMAL:
 		print_hex_dump_debug("aprpl: ", DUMP_PREFIX_ADDRESS, 16, 1,
-				     aq->reply->msg, aq->reply->len, false);
+				     aq->reply->msg, aq->reply->len, 0);
 		aq->queue_count = max_t(int, 0, aq->queue_count - 1);
 		if (!status.queue_empty && !aq->queue_count)
 			aq->queue_count++;
@@ -249,7 +249,7 @@ static enum ap_sm_wait ap_sm_write(struct ap_queue *aq)
 	/* Start the next request on the queue. */
 	ap_msg = list_entry(aq->requestq.next, struct ap_message, list);
 	print_hex_dump_debug("apreq: ", DUMP_PREFIX_ADDRESS, 16, 1,
-			     ap_msg->msg, ap_msg->len, false);
+			     ap_msg->msg, ap_msg->len, 0);
 	status = __ap_send(qid, ap_msg->psmid,
 			   ap_msg->msg, ap_msg->len,
 			   ap_msg->flags & AP_MSG_FLAG_SPECIAL);
diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index 74036886ca87..db2958098d71 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -864,7 +864,7 @@ static long _zcrypt_send_cprb(bool userspace, struct ap_perms *perms,
 	if (rc)
 		goto out;
 	print_hex_dump_debug("ccareq: ", DUMP_PREFIX_ADDRESS, 16, 1,
-			     ap_msg.msg, ap_msg.len, false);
+			     ap_msg.msg, ap_msg.len, 0);
 
 	tdom = *domain;
 	if (perms != &ap_perms && tdom < AP_DOMAINS) {
@@ -954,7 +954,7 @@ static long _zcrypt_send_cprb(bool userspace, struct ap_perms *perms,
 	rc = pref_zq->ops->send_cprb(userspace, pref_zq, xcrb, &ap_msg);
 	if (!rc) {
 		print_hex_dump_debug("ccarpl: ", DUMP_PREFIX_ADDRESS, 16, 1,
-				     ap_msg.msg, ap_msg.len, false);
+				     ap_msg.msg, ap_msg.len, 0);
 	}
 
 	spin_lock(&zcrypt_list_lock);
@@ -1069,7 +1069,7 @@ static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
 	if (rc)
 		goto out_free;
 	print_hex_dump_debug("ep11req: ", DUMP_PREFIX_ADDRESS, 16, 1,
-			     ap_msg.msg, ap_msg.len, false);
+			     ap_msg.msg, ap_msg.len, 0);
 
 	if (perms != &ap_perms && domain < AUTOSEL_DOM) {
 		if (ap_msg.flags & AP_MSG_FLAG_ADMIN) {
@@ -1156,7 +1156,7 @@ static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
 	rc = pref_zq->ops->send_ep11_cprb(userspace, pref_zq, xcrb, &ap_msg);
 	if (!rc) {
 		print_hex_dump_debug("ep11rpl: ", DUMP_PREFIX_ADDRESS, 16, 1,
-				     ap_msg.msg, ap_msg.len, false);
+				     ap_msg.msg, ap_msg.len, 0);
 	}
 
 	spin_lock(&zcrypt_list_lock);
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index a3adaec5504e..a79e4ea39db3 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1125,7 +1125,7 @@ static int qeth_get_problem(struct qeth_card *card, struct ccw_device *cdev,
 		QETH_DBF_MESSAGE(2, "check on channel %x with dstat=%#x, cstat=%#x\n",
 				 CCW_DEVID(cdev), dstat, cstat);
 		print_hex_dump(KERN_WARNING, "qeth: irb ", DUMP_PREFIX_OFFSET,
-				16, 1, irb, 64, 1);
+				16, 1, irb, 64, DUMP_FLAG_ASCII);
 		return -EIO;
 	}
 
@@ -1276,9 +1276,11 @@ static void qeth_irq(struct ccw_device *cdev, unsigned long intparm,
 					 CCW_DEVID(channel->ccwdev), cstat,
 					 dstat);
 			print_hex_dump(KERN_WARNING, "qeth: irb ",
-				DUMP_PREFIX_OFFSET, 16, 1, irb, 32, 1);
+				DUMP_PREFIX_OFFSET, 16, 1, irb, 32,
+				DUMP_FLAG_ASCII);
 			print_hex_dump(KERN_WARNING, "qeth: sense data ",
-				DUMP_PREFIX_OFFSET, 16, 1, irb->ecw, 32, 1);
+				DUMP_PREFIX_OFFSET, 16, 1, irb->ecw, 32,
+				DUMP_FLAG_ASCII);
 		}
 
 		rc = qeth_get_problem(card, cdev, irb);
diff --git a/drivers/scsi/esas2r/esas2r_log.c b/drivers/scsi/esas2r/esas2r_log.c
index d6c87a0bae09..68982f53c30d 100644
--- a/drivers/scsi/esas2r/esas2r_log.c
+++ b/drivers/scsi/esas2r/esas2r_log.c
@@ -245,7 +245,7 @@ int esas2r_log_hexdump(const long level,
 	if (level <= event_log_level) {
 		print_hex_dump(translate_esas2r_event_level_to_kernel(level),
 			       "", DUMP_PREFIX_OFFSET, 16, 1, buf,
-			       len, true);
+			       len, DUMP_FLAG_ASCII);
 	}
 
 	return 1;
diff --git a/drivers/scsi/qedf/qedf_fip.c b/drivers/scsi/qedf/qedf_fip.c
index ad6a56ce72a8..e67c18da68d4 100644
--- a/drivers/scsi/qedf/qedf_fip.c
+++ b/drivers/scsi/qedf/qedf_fip.c
@@ -152,7 +152,7 @@ void qedf_fip_send(struct fcoe_ctlr *fip, struct sk_buff *skb)
 	    vlan_tci);
 	if (qedf_dump_frames)
 		print_hex_dump(KERN_WARNING, "fip ", DUMP_PREFIX_OFFSET, 16, 1,
-		    skb->data, skb->len, false);
+		    skb->data, skb->len, 0);
 
 	rc = qed_ops->ll2->start_xmit(qedf->cdev, skb, 0);
 	if (rc) {
@@ -194,7 +194,7 @@ void qedf_fip_recv(struct qedf_ctx *qedf, struct sk_buff *skb)
 		  sub, vlan);
 	if (qedf_dump_frames)
 		print_hex_dump(KERN_WARNING, "fip ", DUMP_PREFIX_OFFSET, 16, 1,
-		    skb->data, skb->len, false);
+		    skb->data, skb->len, 0);
 
 	if (!ether_addr_equal(eth_hdr->h_dest, qedf->mac) &&
 	    !ether_addr_equal(eth_hdr->h_dest, fcoe_all_enode) &&
diff --git a/drivers/scsi/qedf/qedf_io.c b/drivers/scsi/qedf/qedf_io.c
index 054a51713d55..6ad807554c9a 100644
--- a/drivers/scsi/qedf/qedf_io.c
+++ b/drivers/scsi/qedf/qedf_io.c
@@ -2526,7 +2526,7 @@ void qedf_process_unsol_compl(struct qedf_ctx *qedf, uint16_t que_idx,
 		QEDF_INFO(&(qedf->dbg_ctx), QEDF_LOG_UNSOL,
 		    "BDQ frame is at addr=%p.\n", bdq_addr);
 		print_hex_dump(KERN_WARNING, "bdq ", DUMP_PREFIX_OFFSET, 16, 1,
-		    (void *)bdq_addr, pktlen, false);
+		    (void *)bdq_addr, pktlen, 0);
 	}
 
 	/* Allocate frame */
diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
index 4813087e58a1..bc11935122dd 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -1240,7 +1240,7 @@ static int qedf_xmit(struct fc_lport *lport, struct fc_frame *fp)
 	    vlan_tci);
 	if (qedf_dump_frames)
 		print_hex_dump(KERN_WARNING, "fcoe: ", DUMP_PREFIX_OFFSET, 16,
-		    1, skb->data, skb->len, false);
+		    1, skb->data, skb->len, 0);
 	rc = qed_ops->ll2->start_xmit(qedf->cdev, skb, 0);
 	if (rc) {
 		QEDF_ERR(&qedf->dbg_ctx, "start_xmit failed rc = %d.\n", rc);
@@ -2612,7 +2612,7 @@ static void qedf_recv_frame(struct qedf_ctx *qedf,
 	    fh->fh_type);
 	if (qedf_dump_frames)
 		print_hex_dump(KERN_WARNING, "fcoe: ", DUMP_PREFIX_OFFSET, 16,
-		    1, skb->data, skb->len, false);
+		    1, skb->data, skb->len, 0);
 	fc_exch_recv(lport, fp);
 }
 
diff --git a/drivers/scsi/qla2xxx/qla_dbg.c b/drivers/scsi/qla2xxx/qla_dbg.c
index 691ef827a5ab..36e902309ef5 100644
--- a/drivers/scsi/qla2xxx/qla_dbg.c
+++ b/drivers/scsi/qla2xxx/qla_dbg.c
@@ -2701,7 +2701,7 @@ ql_dump_buffer(uint level, scsi_qla_host_t *vha, uint id, const void *buf,
 	for (cnt = 0; cnt < size; cnt += 16) {
 		ql_dbg(level, vha, id, "%04x: ", cnt);
 		print_hex_dump(KERN_CONT, "", DUMP_PREFIX_NONE, 16, 1,
-			       buf + cnt, min(16U, size - cnt), false);
+			       buf + cnt, min(16U, size - cnt), 0);
 	}
 }
 
diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
index fd4251d75935..6ad3d5d6512d 100644
--- a/drivers/soc/ti/k3-ringacc.c
+++ b/drivers/soc/ti/k3-ringacc.c
@@ -326,7 +326,7 @@ static void k3_ringacc_ring_dump(struct k3_ring *ring)
 
 	if (ring->ring_mem_virt)
 		print_hex_dump_debug("dump ring_mem_virt ", DUMP_PREFIX_NONE,
-				     16, 1, ring->ring_mem_virt, 16 * 8, false);
+				     16, 1, ring->ring_mem_virt, 16 * 8, 0);
 }
 
 struct k3_ring *k3_ringacc_request_ring(struct k3_ringacc *ringacc,
diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index de63cf0557ce..8ae820ac1a8d 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -721,7 +721,7 @@ static void dma_callback(void *data)
 				       1,
 				       sg_virt(sg),
 				       sg_dma_len(sg),
-				       1);
+				       DUMP_FLAG_ASCII);
 		}
 		for_each_sg(pl022->sgt_tx.sgl, sg, pl022->sgt_tx.nents, i) {
 			dev_dbg(&pl022->adev->dev, "SPI TX SG ENTRY: %d", i);
@@ -731,7 +731,7 @@ static void dma_callback(void *data)
 				       1,
 				       sg_virt(sg),
 				       sg_dma_len(sg),
-				       1);
+				       DUMP_FLAG_ASCII);
 		}
 	}
 #endif
diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
index d09211589d1c..f53e7aca4542 100644
--- a/drivers/staging/nvec/nvec.c
+++ b/drivers/staging/nvec/nvec.c
@@ -144,7 +144,7 @@ static int nvec_status_notifier(struct notifier_block *nb,
 
 	dev_warn(nvec->dev, "unhandled msg type %ld\n", event_type);
 	print_hex_dump(KERN_WARNING, "payload: ", DUMP_PREFIX_NONE, 16, 1,
-		       msg, msg[1] + 2, true);
+		       msg, msg[1] + 2, DUMP_FLAG_ASCII);
 
 	return NOTIFY_OK;
 }
@@ -425,7 +425,7 @@ static int parse_msg(struct nvec_chip *nvec, struct nvec_msg *msg)
 	if ((msg->data[0] >> 7) == 1 && (msg->data[0] & 0x0f) == 5)
 		print_hex_dump(KERN_WARNING, "ec system event ",
 			       DUMP_PREFIX_NONE, 16, 1, msg->data,
-			       msg->data[1] + 2, true);
+			       msg->data[1] + 2, DUMP_FLAG_ASCII);
 
 	atomic_notifier_call_chain(&nvec->notifier_list, msg->data[0] & 0x8f,
 				   msg->data);
diff --git a/drivers/staging/nvec/nvec_ps2.c b/drivers/staging/nvec/nvec_ps2.c
index f34016c4a26b..58d76f9ea21a 100644
--- a/drivers/staging/nvec/nvec_ps2.c
+++ b/drivers/staging/nvec/nvec_ps2.c
@@ -26,7 +26,7 @@
 #ifdef NVEC_PS2_DEBUG
 #define NVEC_PHD(str, buf, len) \
 	print_hex_dump(KERN_DEBUG, str, DUMP_PREFIX_NONE, \
-			16, 1, buf, len, false)
+			16, 1, buf, len, 0)
 #else
 #define NVEC_PHD(str, buf, len) do { } while (0)
 #endif
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 67489c334f7b..2bf022f30cc2 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -96,11 +96,11 @@ static const char *const port_action_type_names[] = {
 			 (MSG)->h.type, (MSG_LEN));			\
 		print_hex_dump(KERN_DEBUG, "<<h: ", DUMP_PREFIX_OFFSET,	\
 			       16, 4, (MSG),				\
-			       sizeof(struct mmal_msg_header), 1);	\
+			       sizeof(struct mmal_msg_header), DUMP_FLAG_ASCII);	\
 		print_hex_dump(KERN_DEBUG, "<<p: ", DUMP_PREFIX_OFFSET,	\
 			       16, 4,					\
 			       ((u8 *)(MSG)) + sizeof(struct mmal_msg_header),\
-			       (MSG_LEN) - sizeof(struct mmal_msg_header), 1); \
+			       (MSG_LEN) - sizeof(struct mmal_msg_header), DUMP_FLAG_ASCII); \
 	} while (0)
 #else
 #define DBG_DUMP_MSG(MSG, MSG_LEN, TITLE)				\
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 5d37a0984916..c0e5714816f8 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -569,7 +569,7 @@ static void gsm_hex_dump_bytes(const char *fname, const u8 *data,
 
 	if (!fname) {
 		print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE, 16, 1, data, len,
-			       true);
+			       DUMP_FLAG_ASCII);
 		return;
 	}
 
@@ -577,7 +577,7 @@ static void gsm_hex_dump_bytes(const char *fname, const u8 *data,
 	if (!prefix)
 		return;
 	print_hex_dump(KERN_INFO, prefix, DUMP_PREFIX_OFFSET, 16, 1, data, len,
-		       true);
+		       DUMP_FLAG_ASCII);
 	kfree(prefix);
 }
 
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index dc757ba47522..2ffe257ec1be 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -130,7 +130,7 @@ MODULE_PARM_DESC(use_mcq_mode, "Control MCQ mode for controllers starting from U
 	size_t __len = (len);                                            \
 	print_hex_dump(KERN_ERR, prefix_str,                             \
 		       __len > 4 ? DUMP_PREFIX_OFFSET : DUMP_PREFIX_NONE,\
-		       16, 4, buf, __len, false);                        \
+		       16, 4, buf, __len, 0);                        \
 } while (0)
 
 int ufshcd_dump_regs(struct ufs_hba *hba, size_t offset, size_t len,
diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index 6bd9fe565385..333ec297ebbe 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -329,7 +329,7 @@ static int usbtmc_ioctl_abort_bulk_in_tag(struct usbtmc_device_data *data,
 			  &actual, 300);
 
 	print_hex_dump_debug("usbtmc ", DUMP_PREFIX_NONE, 16, 1,
-			     buffer, actual, true);
+			     buffer, actual, DUMP_FLAG_ASCII);
 
 	n++;
 
@@ -985,7 +985,8 @@ static ssize_t usbtmc_generic_read(struct usbtmc_file_data *file_data,
 			this_part = remaining;
 
 		print_hex_dump_debug("usbtmc ", DUMP_PREFIX_NONE, 16, 1,
-			urb->transfer_buffer, urb->actual_length, true);
+			urb->transfer_buffer, urb->actual_length,
+			DUMP_FLAG_ASCII);
 
 		if (copy_to_user(user_buffer + done,
 				 urb->transfer_buffer, this_part)) {
@@ -1193,7 +1194,7 @@ static ssize_t usbtmc_generic_write(struct usbtmc_file_data *file_data,
 		}
 
 		print_hex_dump_debug("usbtmc ", DUMP_PREFIX_NONE,
-			16, 1, buffer, this_part, true);
+			16, 1, buffer, this_part, DUMP_FLAG_ASCII);
 
 		/* fill bulk with 32 bit alignment to meet USBTMC specification
 		 * (size + 3 & ~3) rounds up and simplifies user code
@@ -1467,7 +1468,7 @@ static ssize_t usbtmc_read(struct file *filp, char __user *buf,
 	}
 
 	print_hex_dump_debug("usbtmc ", DUMP_PREFIX_NONE,
-			     16, 1, buffer, actual, true);
+			     16, 1, buffer, actual, DUMP_FLAG_ASCII);
 
 	remaining = n_characters;
 
@@ -1595,7 +1596,7 @@ static ssize_t usbtmc_write(struct file *filp, const char __user *buf,
 		(unsigned int)transfersize, (unsigned int)aligned);
 
 	print_hex_dump_debug("usbtmc ", DUMP_PREFIX_NONE,
-			     16, 1, buffer, aligned, true);
+			     16, 1, buffer, aligned, DUMP_FLAG_ASCII);
 
 	usb_fill_bulk_urb(urb, data->usb_dev,
 		usb_sndbulkpipe(data->usb_dev, data->bulk_out),
@@ -1718,7 +1719,8 @@ static int usbtmc_ioctl_clear(struct usbtmc_device_data *data)
 					  &actual, USB_CTRL_GET_TIMEOUT);
 
 			print_hex_dump_debug("usbtmc ", DUMP_PREFIX_NONE,
-					     16, 1, buffer, actual, true);
+					     16, 1, buffer, actual,
+					     DUMP_FLAG_ASCII);
 
 			n++;
 
diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 3beb6a862e80..96daf6f01061 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -524,7 +524,7 @@ static void snoop_urb(struct usb_device *udev,
 	data_len = min(data_len, usbfs_snoop_max);
 	if (data && data_len > 0) {
 		print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_NONE, 32, 1,
-			data, data_len, 1);
+			data, data_len, DUMP_FLAG_ASCII);
 	}
 }
 
@@ -538,14 +538,14 @@ static void snoop_urb_data(struct urb *urb, unsigned len)
 
 	if (urb->num_sgs == 0) {
 		print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_NONE, 32, 1,
-			urb->transfer_buffer, len, 1);
+			urb->transfer_buffer, len, DUMP_FLAG_ASCII);
 		return;
 	}
 
 	for (i = 0; i < urb->num_sgs && len; i++) {
 		size = (len > USB_SG_SIZE) ? USB_SG_SIZE : len;
 		print_hex_dump(KERN_DEBUG, "data: ", DUMP_PREFIX_NONE, 32, 1,
-			sg_virt(&urb->sg[i]), size, 1);
+			sg_virt(&urb->sg[i]), size, DUMP_FLAG_ASCII);
 		len -= size;
 	}
 }
diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index 8e761249d672..ed63b8691fa4 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -1193,7 +1193,7 @@ static int ncm_unwrap_ntb(struct gether *port,
 		INFO(port->func.config->cdev, "Wrong NTH SIGN, skblen %d\n",
 			skb->len);
 		print_hex_dump(KERN_INFO, "HEAD:", DUMP_PREFIX_ADDRESS, 32, 1,
-			       skb->data, 32, false);
+			       skb->data, 32, 0);
 
 		goto err;
 	}
diff --git a/drivers/usb/gadget/udc/gr_udc.c b/drivers/usb/gadget/udc/gr_udc.c
index fb901be5dac1..2ca89547dbac 100644
--- a/drivers/usb/gadget/udc/gr_udc.c
+++ b/drivers/usb/gadget/udc/gr_udc.c
@@ -97,7 +97,7 @@ static void gr_dbgprint_request(const char *str, struct gr_ep *ep,
 	dev_dbg(ep->dev->dev, "%s: 0x%p, %d bytes data%s:\n", str, req, buflen,
 		(buflen > plen ? " (truncated)" : ""));
 	print_hex_dump_debug("   ", DUMP_PREFIX_NONE,
-			     rowlen, 4, req->req.buf, plen, false);
+			     rowlen, 4, req->req.buf, plen, 0);
 }
 
 static void gr_dbgprint_devreq(struct gr_udc *dev, u8 type, u8 request,
diff --git a/drivers/usb/usbip/usbip_common.c b/drivers/usb/usbip/usbip_common.c
index a2b2da1255dd..e0639b410ccc 100644
--- a/drivers/usb/usbip/usbip_common.c
+++ b/drivers/usb/usbip/usbip_common.c
@@ -52,7 +52,7 @@ DEVICE_ATTR_RW(usbip_debug);
 static void usbip_dump_buffer(char *buff, int bufflen)
 {
 	print_hex_dump(KERN_DEBUG, "usbip-core", DUMP_PREFIX_OFFSET, 16, 4,
-		       buff, bufflen, false);
+		       buff, bufflen, 0);
 }
 
 static void usbip_dump_pipe(unsigned int p)
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c
index e6363a420933..c375fd145d68 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c
@@ -269,7 +269,7 @@ static void hdmi_core_write_avi_infoframe(struct hdmi_core_data *core,
 	hdmi_avi_infoframe_pack(frame, data, sizeof(data));
 
 	print_hex_dump_debug("AVI: ", DUMP_PREFIX_NONE, 16, 1, data,
-		HDMI_INFOFRAME_SIZE(AVI), false);
+		HDMI_INFOFRAME_SIZE(AVI), 0);
 
 	for (i = 0; i < sizeof(data); ++i) {
 		hdmi_write_reg(av_base, HDMI_CORE_AV_AVI_BASE + i * 4,
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c
index b33f62c5cb22..e89cf35f6578 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c
@@ -418,7 +418,7 @@ static void hdmi_core_write_avi_infoframe(struct hdmi_core_data *core,
 	hdmi_avi_infoframe_pack(frame, data, sizeof(data));
 
 	print_hex_dump_debug("AVI: ", DUMP_PREFIX_NONE, 16, 1, data,
-		HDMI_INFOFRAME_SIZE(AVI), false);
+		HDMI_INFOFRAME_SIZE(AVI), 0);
 
 	ptr = data + HDMI_INFOFRAME_HEADER_SIZE;
 
diff --git a/drivers/watchdog/wdrtas.c b/drivers/watchdog/wdrtas.c
index c00627825de8..1c10ebcc37a9 100644
--- a/drivers/watchdog/wdrtas.c
+++ b/drivers/watchdog/wdrtas.c
@@ -167,7 +167,7 @@ static void wdrtas_timer_keepalive(void)
 		if (result == 0)
 			print_hex_dump(KERN_INFO, "dumping event, data: ",
 				DUMP_PREFIX_OFFSET, 16, 1,
-				wdrtas_logbuffer, WDRTAS_LOGBUFFER_LEN, false);
+				wdrtas_logbuffer, WDRTAS_LOGBUFFER_LEN, 0);
 	} while (result == 0);
 }
 
diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
index 8109aba66e02..60f102df4785 100644
--- a/fs/ceph/mdsmap.c
+++ b/fs/ceph/mdsmap.c
@@ -399,7 +399,7 @@ struct ceph_mdsmap *ceph_mdsmap_decode(struct ceph_mds_client *mdsc, void **p,
 	pr_err_client(cl, "corrupt mdsmap\n");
 	print_hex_dump(KERN_DEBUG, "mdsmap: ",
 		       DUMP_PREFIX_OFFSET, 16, 1,
-		       start, end - start, true);
+		       start, end - start, DUMP_FLAG_ASCII);
 out_err:
 	ceph_mdsmap_destroy(m);
 	return ERR_PTR(err);
diff --git a/fs/ecryptfs/debug.c b/fs/ecryptfs/debug.c
index cf6d0e8e25a1..821d70a2e09d 100644
--- a/fs/ecryptfs/debug.c
+++ b/fs/ecryptfs/debug.c
@@ -87,5 +87,5 @@ void ecryptfs_dump_hex(char *data, int bytes)
 		return;
 
 	print_hex_dump(KERN_DEBUG, "ecryptfs: ", DUMP_PREFIX_OFFSET, 16, 1,
-		       data, bytes, false);
+		       data, bytes, 0);
 }
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index e72145c4ae5a..72552324538d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1456,7 +1456,7 @@ static void ext4_destroy_inode(struct inode *inode)
 			 inode->i_ino, EXT4_I(inode));
 		print_hex_dump(KERN_INFO, "", DUMP_PREFIX_ADDRESS, 16, 4,
 				EXT4_I(inode), sizeof(struct ext4_inode_info),
-				true);
+				DUMP_FLAG_ASCII);
 		dump_stack();
 	}
 
diff --git a/fs/jfs/xattr.c b/fs/jfs/xattr.c
index 2999ed5d83f5..327e93ffb551 100644
--- a/fs/jfs/xattr.c
+++ b/fs/jfs/xattr.c
@@ -561,7 +561,7 @@ static int ea_get(struct inode *inode, struct ea_buffer *ea_buf, int min_size)
 
 		printk(KERN_ERR "ea_get: invalid extended attribute\n");
 		print_hex_dump(KERN_ERR, "", DUMP_PREFIX_ADDRESS, 16, 1,
-				     ea_buf->xattr, size, 1);
+				     ea_buf->xattr, size, DUMP_FLAG_ASCII);
 		ea_release(inode, ea_buf);
 		rc = -EIO;
 		goto clean_up;
diff --git a/fs/seq_file.c b/fs/seq_file.c
index e676c8b0cf5d..88dc02d02caa 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -885,7 +885,7 @@ void seq_hex_dump(struct seq_file *m, const char *prefix_str, int prefix_type,
 
 		size = seq_get_buf(m, &buffer);
 		ret = hex_dump_to_buffer(ptr + i, linelen, rowsize, groupsize,
-					 buffer, size, ascii);
+					 buffer, size, ascii ? DUMP_FLAG_ASCII : 0);
 		seq_commit(m, ret < size ? ret : -1);
 
 		seq_putc(m, '\n');
diff --git a/fs/smb/client/cifs_debug.c b/fs/smb/client/cifs_debug.c
index c71ae5c04306..f1950da1829f 100644
--- a/fs/smb/client/cifs_debug.c
+++ b/fs/smb/client/cifs_debug.c
@@ -32,7 +32,7 @@ cifs_dump_mem(char *label, void *data, int length)
 {
 	pr_debug("%s: dump of %d bytes of data at 0x%p\n", label, length, data);
 	print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_OFFSET, 16, 4,
-		       data, length, true);
+		       data, length, DUMP_FLAG_ASCII);
 }
 
 void cifs_dump_detail(void *buf, struct TCP_Server_Info *server)
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index 07c468ddb88a..7553f1259005 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -534,7 +534,7 @@ dump_smb(void *buf, int smb_buf_length)
 		return;
 
 	print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_NONE, 8, 2, buf,
-		       smb_buf_length, true);
+		       smb_buf_length, DUMP_FLAG_ASCII);
 }
 
 void
diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
index d91cec93d968..dfaabea8eba7 100644
--- a/fs/ubifs/debug.c
+++ b/fs/ubifs/debug.c
@@ -302,7 +302,7 @@ void ubifs_dump_node(const struct ubifs_info *c, const void *node, int node_len)
 	if (le32_to_cpu(ch->magic) != UBIFS_NODE_MAGIC) {
 		pr_err("Not a node, first %zu bytes:", UBIFS_CH_SZ);
 		print_hex_dump(KERN_ERR, "", DUMP_PREFIX_OFFSET, 32, 1,
-			       (void *)node, UBIFS_CH_SZ, 1);
+			       (void *)node, UBIFS_CH_SZ, DUMP_FLAG_ASCII);
 		return;
 	}
 
diff --git a/fs/ubifs/scan.c b/fs/ubifs/scan.c
index 84a9157dcc32..9369f98b6961 100644
--- a/fs/ubifs/scan.c
+++ b/fs/ubifs/scan.c
@@ -232,7 +232,8 @@ void ubifs_scanned_corruption(const struct ubifs_info *c, int lnum, int offs,
 	if (len > 8192)
 		len = 8192;
 	ubifs_err(c, "first %d bytes from LEB %d:%d", len, lnum, offs);
-	print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_OFFSET, 32, 4, buf, len, 1);
+	print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_OFFSET, 32, 4, buf, len,
+		       DUMP_FLAG_ASCII);
 }
 
 /**
diff --git a/fs/xfs/xfs_message.c b/fs/xfs/xfs_message.c
index 8f495cc23903..497286c3b7ca 100644
--- a/fs/xfs/xfs_message.c
+++ b/fs/xfs/xfs_message.c
@@ -107,7 +107,8 @@ assfail(
 void
 xfs_hex_dump(const void *p, int length)
 {
-	print_hex_dump(KERN_ALERT, "", DUMP_PREFIX_OFFSET, 16, 1, p, length, 1);
+	print_hex_dump(KERN_ALERT, "", DUMP_PREFIX_OFFSET, 16, 1, p, length,
+		       DUMP_FLAG_ASCII);
 }
 
 void
diff --git a/include/linux/dma/ti-cppi5.h b/include/linux/dma/ti-cppi5.h
index c53c0f6e3b1a..d1080f066924 100644
--- a/include/linux/dma/ti-cppi5.h
+++ b/include/linux/dma/ti-cppi5.h
@@ -171,7 +171,7 @@ struct cppi5_monolithic_desc_t {
 static inline void cppi5_desc_dump(void *desc, u32 size)
 {
 	print_hex_dump(KERN_ERR, "dump udmap_desc: ", DUMP_PREFIX_NONE,
-		       32, 4, desc, size, false);
+		       32, 4, desc, size, 0);
 }
 
 #define CPPI5_TDCM_MARKER			(0x1)
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index ff44ec346162..c44bab3afa63 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -282,11 +282,11 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 			   dev, fmt, ##__VA_ARGS__)
 
 #define dynamic_hex_dump(prefix_str, prefix_type, rowsize,		\
-			 groupsize, buf, len, ascii)			\
+			 groupsize, buf, len, flags)			\
 	_dynamic_func_call_no_desc(__builtin_constant_p(prefix_str) ? prefix_str : "hexdump", \
 				   print_hex_dump,			\
 				   KERN_DEBUG, prefix_str, prefix_type,	\
-				   rowsize, groupsize, buf, len, ascii)
+				   rowsize, groupsize, buf, len, flags)
 
 /* for test only, generally expect drm.debug style macro wrappers */
 #define __pr_debug_cls(cls, fmt, ...) do {			\
@@ -309,10 +309,10 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 #define dynamic_dev_dbg(dev, fmt, ...)					\
 	dev_no_printk(KERN_DEBUG, dev, fmt, ##__VA_ARGS__)
 #define dynamic_hex_dump(prefix_str, prefix_type, rowsize,		\
-			 groupsize, buf, len, ascii)			\
+			 groupsize, buf, len, flags)			\
 	do { if (0)							\
 		print_hex_dump(KERN_DEBUG, prefix_str, prefix_type,	\
-				rowsize, groupsize, buf, len, ascii);	\
+				rowsize, groupsize, buf, len, flags);	\
 	} while (0)
 
 #endif /* CONFIG_DYNAMIC_DEBUG || (CONFIG_DYNAMIC_DEBUG_CORE && DYNAMIC_DEBUG_MODULE) */
diff --git a/include/linux/filter.h b/include/linux/filter.h
index b6672ff61407..d6504e735516 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1257,7 +1257,7 @@ static inline void bpf_jit_dump(unsigned int flen, unsigned int proglen,
 
 	if (image)
 		print_hex_dump(KERN_ERR, "JIT code: ", DUMP_PREFIX_OFFSET,
-			       16, 1, image, proglen, false);
+			       16, 1, image, proglen, 0);
 }
 
 static inline bool bpf_jit_is_ebpf(void)
diff --git a/include/linux/mlx5/cq.h b/include/linux/mlx5/cq.h
index 991526039ccb..304333e0a2e9 100644
--- a/include/linux/mlx5/cq.h
+++ b/include/linux/mlx5/cq.h
@@ -200,7 +200,7 @@ static inline void mlx5_dump_err_cqe(struct mlx5_core_dev *dev,
 				     struct mlx5_err_cqe *err_cqe)
 {
 	print_hex_dump(KERN_WARNING, "", DUMP_PREFIX_OFFSET, 16, 1, err_cqe,
-		       sizeof(*err_cqe), false);
+		       sizeof(*err_cqe), 0);
 }
 int mlx5_debug_cq_add(struct mlx5_core_dev *dev, struct mlx5_core_cq *cq);
 void mlx5_debug_cq_remove(struct mlx5_core_dev *dev, struct mlx5_core_cq *cq);
diff --git a/include/linux/printk.h b/include/linux/printk.h
index b937cefcb31c..5981f29c79c4 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -716,17 +716,24 @@ enum {
 	DUMP_PREFIX_ADDRESS,
 	DUMP_PREFIX_OFFSET
 };
+
+enum {
+	DUMP_FLAG_ASCII,
+};
+
 extern int hex_dump_to_buffer(const void *buf, size_t len, int rowsize,
 			      int groupsize, char *linebuf, size_t linebuflen,
 			      bool ascii);
 #ifdef CONFIG_PRINTK
 extern void print_hex_dump(const char *level, const char *prefix_str,
 			   int prefix_type, int rowsize, int groupsize,
-			   const void *buf, size_t len, bool ascii);
+			   const void *buf, size_t len,
+			   unsigned int flags);
 #else
 static inline void print_hex_dump(const char *level, const char *prefix_str,
 				  int prefix_type, int rowsize, int groupsize,
-				  const void *buf, size_t len, bool ascii)
+				  const void *buf, size_t len,
+				  unsigned int flags)
 {
 }
 static inline void print_hex_dump_bytes(const char *prefix_str, int prefix_type,
@@ -739,18 +746,19 @@ static inline void print_hex_dump_bytes(const char *prefix_str, int prefix_type,
 #if defined(CONFIG_DYNAMIC_DEBUG) || \
 	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
 #define print_hex_dump_debug(prefix_str, prefix_type, rowsize,	\
-			     groupsize, buf, len, ascii)	\
+			     groupsize, buf, len, flags)	\
 	dynamic_hex_dump(prefix_str, prefix_type, rowsize,	\
-			 groupsize, buf, len, ascii)
+			 groupsize, buf, len, flags)
 #elif defined(DEBUG)
 #define print_hex_dump_debug(prefix_str, prefix_type, rowsize,		\
-			     groupsize, buf, len, ascii)		\
+			     groupsize, buf, len, flags)		\
 	print_hex_dump(KERN_DEBUG, prefix_str, prefix_type, rowsize,	\
-		       groupsize, buf, len, ascii)
+		       groupsize, buf, len, flags)
 #else
 static inline void print_hex_dump_debug(const char *prefix_str, int prefix_type,
 					int rowsize, int groupsize,
-					const void *buf, size_t len, bool ascii)
+					const void *buf, size_t len,
+					unsigned int flags)
 {
 }
 #endif
diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index c80539be1542..427cb3f800a3 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -221,7 +221,7 @@ static inline void raw_dump_inline(const char *caller, char *msg,
 	if (msg)
 		pr_debug("%s():%s: ", caller, msg);
 
-	print_hex_dump_debug("", DUMP_PREFIX_NONE, 16, 1, buf, len, false);
+	print_hex_dump_debug("", DUMP_PREFIX_NONE, 16, 1, buf, len, 0);
 }
 
 /* print data in a table format:
@@ -236,7 +236,7 @@ static inline void raw_dump_table(const char *caller, char *msg,
 	if (msg)
 		pr_debug("%s():%s:\n", caller, msg);
 
-	print_hex_dump_debug("\t", DUMP_PREFIX_OFFSET, 16, 1, buf, len, false);
+	print_hex_dump_debug("\t", DUMP_PREFIX_OFFSET, 16, 1, buf, len, 0);
 }
 #else
 static inline void raw_dump_table(const char *caller, char *msg,
diff --git a/lib/hexdump.c b/lib/hexdump.c
index 06833d404398..f485b66aebbb 100644
--- a/lib/hexdump.c
+++ b/lib/hexdump.c
@@ -238,7 +238,8 @@ EXPORT_SYMBOL(hex_dump_to_buffer);
  * @groupsize: number of bytes to print at a time (1, 2, 4, 8; default = 1)
  * @buf: data blob to dump
  * @len: number of bytes in the @buf
- * @ascii: include ASCII after the hex output
+ * @flags: controls the output, typically %DUMP_FLAG_ASCII will print the ascii
+ * equivalent after the hex output.
  *
  * Given a buffer of u8 data, print_hex_dump() prints a hex + ASCII dump
  * to the kernel log at the specified kernel log level, with an optional
@@ -251,7 +252,7 @@ EXPORT_SYMBOL(hex_dump_to_buffer);
  *
  * E.g.:
  *   print_hex_dump(KERN_DEBUG, "raw data: ", DUMP_PREFIX_ADDRESS,
- *		    16, 1, frame->data, frame->len, true);
+ *		    16, 1, frame->data, frame->len, DUMP_FLAG_ASCII);
  *
  * Example output using %DUMP_PREFIX_OFFSET and 1-byte mode:
  * 0009ab42: 40 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f  @ABCDEFGHIJKLMNO
@@ -260,7 +261,7 @@ EXPORT_SYMBOL(hex_dump_to_buffer);
  */
 void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
 		    int rowsize, int groupsize,
-		    const void *buf, size_t len, bool ascii)
+		    const void *buf, size_t len, unsigned int flags)
 {
 	const u8 *ptr = buf;
 	int i, linelen, remaining = len;
@@ -274,7 +275,8 @@ void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
 		remaining -= rowsize;
 
 		hex_dump_to_buffer(ptr + i, linelen, rowsize, groupsize,
-				   linebuf, sizeof(linebuf), ascii);
+				   linebuf, sizeof(linebuf),
+				   flags & DUMP_FLAG_ASCII);
 
 		switch (prefix_type) {
 		case DUMP_PREFIX_ADDRESS:
diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 65a75d58ed9e..8414c1a1b2ae 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -119,9 +119,9 @@ __check_eq_u32_array(const char *srcfile, unsigned int line,
 	if (memcmp(exp_arr, arr, len*sizeof(*arr))) {
 		pr_warn("[%s:%u] array contents differ\n", srcfile, line);
 		print_hex_dump(KERN_WARNING, "  exp:  ", DUMP_PREFIX_OFFSET,
-			       32, 4, exp_arr, exp_len*sizeof(*exp_arr), false);
+			       32, 4, exp_arr, exp_len*sizeof(*exp_arr), 0);
 		print_hex_dump(KERN_WARNING, "  got:  ", DUMP_PREFIX_OFFSET,
-			       32, 4, arr, len*sizeof(*arr), false);
+			       32, 4, arr, len*sizeof(*arr), 0);
 		return false;
 	}
 
diff --git a/mm/debug.c b/mm/debug.c
index 69e524c3e601..689e995ce55b 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -96,11 +96,11 @@ static void __dump_folio(struct folio *folio, struct page *page,
 
 	print_hex_dump(KERN_WARNING, "raw: ", DUMP_PREFIX_NONE, 32,
 			sizeof(unsigned long), page,
-			sizeof(struct page), false);
+			sizeof(struct page), 0);
 	if (folio_test_large(folio))
 		print_hex_dump(KERN_WARNING, "head: ", DUMP_PREFIX_NONE, 32,
 			sizeof(unsigned long), folio,
-			2 * sizeof(struct page), false);
+			2 * sizeof(struct page), 0);
 }
 
 static void __dump_page(const struct page *page)
diff --git a/mm/dmapool.c b/mm/dmapool.c
index f0bfc6c490f4..d4d62d3f47a3 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -109,7 +109,7 @@ static void pool_check_block(struct dma_pool *pool, struct dma_block *block,
 		 * POOL_POISON_FREED
 		 */
 		print_hex_dump(KERN_ERR, "", DUMP_PREFIX_OFFSET, 16, 1,
-				data, pool->size, 1);
+				data, pool->size, DUMP_FLAG_ASCII);
 		break;
 	}
 
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 764b08100570..dc7eeebc87a7 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -279,7 +279,7 @@ static void warn_or_seq_hex_dump(struct seq_file *seq, int prefix_type,
 			     buf, len, ascii);
 	else
 		print_hex_dump(KERN_WARNING, pr_fmt(HEX_PREFIX), prefix_type,
-			       rowsize, groupsize, buf, len, ascii);
+			       rowsize, groupsize, buf, len, DUMP_FLAG_ASCII);
 }
 
 /*
diff --git a/mm/page_poison.c b/mm/page_poison.c
index 3e9037363cf9..7910c3209123 100644
--- a/mm/page_poison.c
+++ b/mm/page_poison.c
@@ -68,7 +68,7 @@ static void check_poison_mem(struct page *page, unsigned char *mem, size_t bytes
 		pr_err("pagealloc: memory corruption\n");
 
 	print_hex_dump(KERN_ERR, "", DUMP_PREFIX_ADDRESS, 16, 1, start,
-			end - start + 1, 1);
+			end - start + 1, DUMP_FLAG_ASCII);
 	dump_stack();
 	dump_page(page, "pagealloc: corrupted page details");
 }
diff --git a/mm/slub.c b/mm/slub.c
index 3520acaf9afa..ae4f45ec0013 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -883,7 +883,8 @@ static void print_section(char *level, char *text, u8 *addr,
 {
 	metadata_access_enable();
 	print_hex_dump(level, text, DUMP_PREFIX_ADDRESS,
-			16, 1, kasan_reset_tag((void *)addr), length, 1);
+			16, 1, kasan_reset_tag((void *)addr), length,
+			DUMP_FLAG_ASCII);
 	metadata_access_disable();
 }
 
diff --git a/net/atm/br2684.c b/net/atm/br2684.c
index f666f2f98ba5..32818d05f4a2 100644
--- a/net/atm/br2684.c
+++ b/net/atm/br2684.c
@@ -35,7 +35,8 @@ static void skb_debug(const struct sk_buff *skb)
 #ifdef SKB_DEBUG
 #define NUM2PRINT 50
 	print_hex_dump(KERN_DEBUG, "br2684: skb: ", DUMP_OFFSET,
-		       16, 1, skb->data, min(NUM2PRINT, skb->len), true);
+		       16, 1, skb->data, min(NUM2PRINT, skb->len),
+		       DUMP_FLAG_ASCII);
 #endif
 }
 
diff --git a/net/atm/lec.c b/net/atm/lec.c
index ffef658862db..cf0e37d1cf5e 100644
--- a/net/atm/lec.c
+++ b/net/atm/lec.c
@@ -256,7 +256,8 @@ static netdev_tx_t lec_start_xmit(struct sk_buff *skb,
 	printk(KERN_DEBUG "%s: send datalen:%ld lecid:%4.4x\n",
 	       dev->name, skb->len, priv->lecid);
 	print_hex_dump(KERN_DEBUG, "", DUMP_OFFSET, 16, 1,
-		       skb->data, min(skb->len, MAX_DUMP_SKB), true);
+		       skb->data, min(skb->len, MAX_DUMP_SKB),
+		       DUMP_FLAG_ASCII);
 #endif /* DUMP_PACKETS >= 1 */
 
 	/* Minimum ethernet-frame size */
@@ -601,7 +602,8 @@ static void lec_push(struct atm_vcc *vcc, struct sk_buff *skb)
 	printk(KERN_DEBUG "%s: rcv datalen:%ld lecid:%4.4x\n",
 	       dev->name, skb->len, priv->lecid);
 	print_hex_dump(KERN_DEBUG, "", DUMP_OFFSET, 16, 1,
-		       skb->data, min(MAX_SKB_DUMP, skb->len), true);
+		       skb->data, min(MAX_SKB_DUMP, skb->len),
+		       DUMP_FLAG_ASCII);
 #endif /* DUMP_PACKETS > 0 */
 	if (memcmp(skb->data, lec_ctrl_magic, 4) == 0) {
 				/* Control frame, to daemon */
diff --git a/net/ceph/crypto.c b/net/ceph/crypto.c
index 051d22c0e4ad..7961ccaa7a72 100644
--- a/net/ceph/crypto.c
+++ b/net/ceph/crypto.c
@@ -241,9 +241,9 @@ static int ceph_aes_crypt(const struct ceph_crypto_key *key, bool encrypt,
 
 	/*
 	print_hex_dump(KERN_ERR, "key: ", DUMP_PREFIX_NONE, 16, 1,
-		       key->key, key->len, 1);
+		       key->key, key->len, DUMP_FLAG_ASCII);
 	print_hex_dump(KERN_ERR, " in: ", DUMP_PREFIX_NONE, 16, 1,
-		       buf, crypt_len, 1);
+		       buf, crypt_len, DUMP_FLAG_ASCII);
 	*/
 	if (encrypt)
 		ret = crypto_skcipher_encrypt(req);
@@ -257,7 +257,7 @@ static int ceph_aes_crypt(const struct ceph_crypto_key *key, bool encrypt,
 	}
 	/*
 	print_hex_dump(KERN_ERR, "out: ", DUMP_PREFIX_NONE, 16, 1,
-		       buf, crypt_len, 1);
+		       buf, crypt_len, DUMP_FLAG_ASCII);
 	*/
 
 	if (encrypt) {
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 3c8b78d9c4d1..a897aa0f070a 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2202,17 +2202,18 @@ void ceph_msg_dump(struct ceph_msg *msg)
 		 msg->front_alloc_len, msg->data_length);
 	print_hex_dump(KERN_DEBUG, "header: ",
 		       DUMP_PREFIX_OFFSET, 16, 1,
-		       &msg->hdr, sizeof(msg->hdr), true);
+		       &msg->hdr, sizeof(msg->hdr), DUMP_FLAG_ASCII);
 	print_hex_dump(KERN_DEBUG, " front: ",
 		       DUMP_PREFIX_OFFSET, 16, 1,
-		       msg->front.iov_base, msg->front.iov_len, true);
+		       msg->front.iov_base, msg->front.iov_len,
+		       DUMP_FLAG_ASCII);
 	if (msg->middle)
 		print_hex_dump(KERN_DEBUG, "middle: ",
 			       DUMP_PREFIX_OFFSET, 16, 1,
 			       msg->middle->vec.iov_base,
-			       msg->middle->vec.iov_len, true);
+			       msg->middle->vec.iov_len, DUMP_FLAG_ASCII);
 	print_hex_dump(KERN_DEBUG, "footer: ",
 		       DUMP_PREFIX_OFFSET, 16, 1,
-		       &msg->footer, sizeof(msg->footer), true);
+		       &msg->footer, sizeof(msg->footer), DUMP_FLAG_ASCII);
 }
 EXPORT_SYMBOL(ceph_msg_dump);
diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 295098873861..f32f5d0b4671 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -1807,7 +1807,7 @@ static int osdmap_decode(void **p, void *end, bool msgr2,
 	       err, epoch, (int)(*p - start), *p, start, end);
 	print_hex_dump(KERN_DEBUG, "osdmap: ",
 		       DUMP_PREFIX_OFFSET, 16, 1,
-		       start, end - start, true);
+		       start, end - start, DUMP_FLAG_ASCII);
 	return err;
 }
 
@@ -2111,7 +2111,7 @@ struct ceph_osdmap *osdmap_apply_incremental(void **p, void *end, bool msgr2,
 	       err, epoch, (int)(*p - start), *p, start, end);
 	print_hex_dump(KERN_DEBUG, "osdmap: ",
 		       DUMP_PREFIX_OFFSET, 16, 1,
-		       start, end - start, true);
+		       start, end - start, DUMP_FLAG_ASCII);
 	return ERR_PTR(err);
 }
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 83f8cd8aa2d1..73cd490960d2 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1351,17 +1351,17 @@ void skb_dump(const char *level, const struct sk_buff *skb, bool full_pkt)
 
 	if (full_pkt && headroom)
 		print_hex_dump(level, "skb headroom: ", DUMP_PREFIX_OFFSET,
-			       16, 1, skb->head, headroom, false);
+			       16, 1, skb->head, headroom, 0);
 
 	seg_len = min_t(int, skb_headlen(skb), len);
 	if (seg_len)
 		print_hex_dump(level, "skb linear:   ", DUMP_PREFIX_OFFSET,
-			       16, 1, skb->data, seg_len, false);
+			       16, 1, skb->data, seg_len, 0);
 	len -= seg_len;
 
 	if (full_pkt && tailroom)
 		print_hex_dump(level, "skb tailroom: ", DUMP_PREFIX_OFFSET,
-			       16, 1, skb_tail_pointer(skb), tailroom, false);
+			       16, 1, skb_tail_pointer(skb), tailroom, 0);
 
 	for (i = 0; len && i < skb_shinfo(skb)->nr_frags; i++) {
 		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
@@ -1376,7 +1376,7 @@ void skb_dump(const char *level, const struct sk_buff *skb, bool full_pkt)
 			vaddr = kmap_atomic(p);
 			print_hex_dump(level, "skb frag:     ",
 				       DUMP_PREFIX_OFFSET,
-				       16, 1, vaddr + p_off, seg_len, false);
+				       16, 1, vaddr + p_off, seg_len, 0);
 			kunmap_atomic(vaddr);
 			len -= seg_len;
 			if (!len)
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 13c0f1d455f3..e06d91191e2f 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1757,7 +1757,7 @@ static void ip_handle_martian_source(struct net_device *dev,
 			print_hex_dump(KERN_WARNING, "ll header: ",
 				       DUMP_PREFIX_OFFSET, 16, 1,
 				       skb_mac_header(skb),
-				       dev->hard_header_len, false);
+				       dev->hard_header_len, 0);
 		}
 	}
 #endif
diff --git a/net/nfc/digital_core.c b/net/nfc/digital_core.c
index dae378f1d52b..fcdb34f0bd97 100644
--- a/net/nfc/digital_core.c
+++ b/net/nfc/digital_core.c
@@ -129,7 +129,7 @@ static void digital_wq_cmd_complete(struct work_struct *work)
 
 	if (!IS_ERR(cmd->resp))
 		print_hex_dump_debug("DIGITAL RX: ", DUMP_PREFIX_NONE, 16, 1,
-				     cmd->resp->data, cmd->resp->len, false);
+				     cmd->resp->data, cmd->resp->len, 0);
 
 	cmd->cmd_cb(ddev, cmd->cb_context, cmd->resp);
 
@@ -173,7 +173,7 @@ static void digital_wq_cmd(struct work_struct *work)
 
 	if (cmd->req)
 		print_hex_dump_debug("DIGITAL TX: ", DUMP_PREFIX_NONE, 16, 1,
-				     cmd->req->data, cmd->req->len, false);
+				     cmd->req->data, cmd->req->len, 0);
 
 	switch (cmd->type) {
 	case DIGITAL_CMD_IN_SEND:
diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 18be13fb9b75..a5cb1ac5e4c6 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -780,7 +780,8 @@ static void nfc_llcp_tx_work(struct work_struct *work)
 
 			pr_debug("Sending pending skb\n");
 			print_hex_dump_debug("LLCP Tx: ", DUMP_PREFIX_OFFSET,
-					     16, 1, skb->data, skb->len, true);
+					     16, 1, skb->data, skb->len,
+					     DUMP_FLAG_ASCII);
 
 			if (ptype == LLCP_PDU_I)
 				copy_skb = skb_copy(skb, GFP_ATOMIC);
@@ -1459,7 +1460,7 @@ static void nfc_llcp_rx_skb(struct nfc_llcp_local *local, struct sk_buff *skb)
 
 	if (ptype != LLCP_PDU_SYMM)
 		print_hex_dump_debug("LLCP Rx: ", DUMP_PREFIX_OFFSET, 16, 1,
-				     skb->data, skb->len, true);
+				     skb->data, skb->len, DUMP_FLAG_ASCII);
 
 	switch (ptype) {
 	case LLCP_PDU_SYMM:
diff --git a/samples/rpmsg/rpmsg_client_sample.c b/samples/rpmsg/rpmsg_client_sample.c
index ae5081662283..deb8ba51409f 100644
--- a/samples/rpmsg/rpmsg_client_sample.c
+++ b/samples/rpmsg/rpmsg_client_sample.c
@@ -32,7 +32,7 @@ static int rpmsg_sample_cb(struct rpmsg_device *rpdev, void *data, int len,
 		 ++idata->rx_count, src);
 
 	print_hex_dump_debug(__func__, DUMP_PREFIX_NONE, 16, 1, data, len,
-			     true);
+			     DUMP_FLAG_ASCII);
 
 	/* samples should not live forever */
 	if (idata->rx_count >= count) {
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 52e00332defe..1b3ffe2361cf 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -64,7 +64,7 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 
 	print_hex_dump_debug("ima dump: ", DUMP_PREFIX_NONE, 16, 1,
 			     file.buf, file.count < 100 ? file.count : 100,
-			     true);
+			     DUMP_FLAG_ASCII);
 
 	*buffer_size = file.count;
 	*buffer = file.buf;
diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index e1a7f0b0c0f3..764dc169dcbc 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1324,7 +1324,7 @@ static void hdac_hdmi_present_sense(struct hdac_hdmi_pin *pin,
 		}
 
 		print_hex_dump_debug("ELD: ", DUMP_PREFIX_OFFSET, 16, 1,
-			  port->eld.eld_buffer, port->eld.eld_size, false);
+			  port->eld.eld_buffer, port->eld.eld_size, 0);
 
 	}
 	mutex_unlock(&hdmi->pin_mutex);
diff --git a/sound/soc/intel/atom/sst/sst_ipc.c b/sound/soc/intel/atom/sst/sst_ipc.c
index 0630e58b9d6b..9726b6cc146a 100644
--- a/sound/soc/intel/atom/sst/sst_ipc.c
+++ b/sound/soc/intel/atom/sst/sst_ipc.c
@@ -293,7 +293,7 @@ static void process_fw_async_msg(struct intel_sst_drv *sst_drv_ctx,
 		dev_err(sst_drv_ctx->dev, "FW sent async error msg:\n");
 		for (i = 0; i < (data_size/4); i++)
 			print_hex_dump(KERN_DEBUG, NULL, DUMP_PREFIX_NONE,
-					16, 4, data_offset, data_size, false);
+					16, 4, data_offset, data_size, 0);
 		break;
 
 	case IPC_IA_FW_INIT_CMPLT_MRFLD:
diff --git a/sound/soc/intel/catpt/loader.c b/sound/soc/intel/catpt/loader.c
index 696d84314eeb..393a0f4e01b6 100644
--- a/sound/soc/intel/catpt/loader.c
+++ b/sound/soc/intel/catpt/loader.c
@@ -243,7 +243,7 @@ static int catpt_restore_fwimage(struct catpt_dev *cdev,
 	int i;
 
 	print_hex_dump_debug(__func__, DUMP_PREFIX_OFFSET, 8, 4,
-			     blk, sizeof(*blk), false);
+			     blk, sizeof(*blk), 0);
 
 	r1.start = cdev->dram.start + blk->ram_offset;
 	r1.end = r1.start + blk->size - 1;
@@ -295,7 +295,7 @@ static int catpt_load_block(struct catpt_dev *cdev,
 	int ret;
 
 	print_hex_dump_debug(__func__, DUMP_PREFIX_OFFSET, 8, 4,
-			     blk, sizeof(*blk), false);
+			     blk, sizeof(*blk), 0);
 
 	switch (blk->ram_type) {
 	case CATPT_RAM_TYPE_IRAM:
@@ -333,7 +333,7 @@ static int catpt_restore_basefw(struct catpt_dev *cdev,
 	int ret, i;
 
 	print_hex_dump_debug(__func__, DUMP_PREFIX_OFFSET, 8, 4,
-			     basefw, sizeof(*basefw), false);
+			     basefw, sizeof(*basefw), 0);
 
 	/* restore basefw image */
 	for (i = 0; i < basefw->blocks; i++) {
@@ -376,7 +376,7 @@ static int catpt_restore_module(struct catpt_dev *cdev,
 	int i;
 
 	print_hex_dump_debug(__func__, DUMP_PREFIX_OFFSET, 8, 4,
-			     mod, sizeof(*mod), false);
+			     mod, sizeof(*mod), 0);
 
 	for (i = 0; i < mod->blocks; i++) {
 		struct catpt_fw_block_hdr *blk;
@@ -418,7 +418,7 @@ static int catpt_load_module(struct catpt_dev *cdev,
 	int i;
 
 	print_hex_dump_debug(__func__, DUMP_PREFIX_OFFSET, 8, 4,
-			     mod, sizeof(*mod), false);
+			     mod, sizeof(*mod), 0);
 
 	type = &cdev->modules[mod->module_id];
 
@@ -464,7 +464,7 @@ static int catpt_restore_firmware(struct catpt_dev *cdev,
 	int i;
 
 	print_hex_dump_debug(__func__, DUMP_PREFIX_OFFSET, 8, 4,
-			     fw, sizeof(*fw), false);
+			     fw, sizeof(*fw), 0);
 
 	for (i = 0; i < fw->modules; i++) {
 		struct catpt_fw_mod_hdr *mod;
@@ -510,7 +510,7 @@ static int catpt_load_firmware(struct catpt_dev *cdev,
 	int i;
 
 	print_hex_dump_debug(__func__, DUMP_PREFIX_OFFSET, 8, 4,
-			     fw, sizeof(*fw), false);
+			     fw, sizeof(*fw), 0);
 
 	for (i = 0; i < fw->modules; i++) {
 		struct catpt_fw_mod_hdr *mod;
diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index fc2eb04da172..e420205e2885 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -923,7 +923,7 @@ static int skl_set_module_format(struct skl_dev *skl,
 			module_config->m_type, module_config->id.module_id,
 			param_size);
 	print_hex_dump_debug("Module params:", DUMP_PREFIX_OFFSET, 8, 4,
-			*param_data, param_size, false);
+			*param_data, param_size, 0);
 	return 0;
 }
 
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index fd9624ad5f72..1bdefb70d442 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.c
+++ b/sound/soc/intel/skylake/skl-sst-ipc.c
@@ -796,7 +796,7 @@ int skl_ipc_init_instance(struct sst_generic_ipc *ipc,
 	u16 param_block_size = msg->param_data_size / sizeof(u32);
 
 	print_hex_dump_debug("Param data:", DUMP_PREFIX_NONE,
-		16, 4, buffer, param_block_size, false);
+		16, 4, buffer, param_block_size, 0);
 
 	header.primary = IPC_MSG_TARGET(IPC_MOD_MSG);
 	header.primary |= IPC_MSG_DIR(IPC_MSG_REQUEST);
diff --git a/sound/soc/sof/ipc3.c b/sound/soc/sof/ipc3.c
index 83c22d4a4830..a2ceebbbad7d 100644
--- a/sound/soc/sof/ipc3.c
+++ b/sound/soc/sof/ipc3.c
@@ -228,7 +228,7 @@ static void sof_ipc3_dump_payload(struct snd_sof_dev *sdev,
 {
 	printk(KERN_DEBUG "Size of payload following the header: %zu\n", size);
 	print_hex_dump_debug("Message payload: ", DUMP_PREFIX_OFFSET,
-			     16, 4, ipc_data, size, false);
+			     16, 4, ipc_data, size, 0);
 }
 
 static int sof_ipc3_get_reply(struct snd_sof_dev *sdev)
diff --git a/sound/soc/sof/ipc4.c b/sound/soc/sof/ipc4.c
index 4386cbae16d4..2b6025c1e102 100644
--- a/sound/soc/sof/ipc4.c
+++ b/sound/soc/sof/ipc4.c
@@ -260,7 +260,7 @@ static void sof_ipc4_dump_payload(struct snd_sof_dev *sdev,
 				  void *ipc_data, size_t size)
 {
 	print_hex_dump_debug("Message payload: ", DUMP_PREFIX_OFFSET,
-			     16, 4, ipc_data, size, false);
+			     16, 4, ipc_data, size, 0);
 }
 
 static int sof_ipc4_get_reply(struct snd_sof_dev *sdev)
diff --git a/sound/usb/bcd2000/bcd2000.c b/sound/usb/bcd2000/bcd2000.c
index 392b4d8e9e76..e1ba777fb692 100644
--- a/sound/usb/bcd2000/bcd2000.c
+++ b/sound/usb/bcd2000/bcd2000.c
@@ -69,7 +69,7 @@ static void bcd2000_dump_buffer(const char *prefix, const char *buf, int len)
 {
 	print_hex_dump(KERN_DEBUG, prefix,
 			DUMP_PREFIX_NONE, 16, 1,
-			buf, len, false);
+			buf, len, 0);
 }
 #else
 static void bcd2000_dump_buffer(const char *prefix, const char *buf, int len) {}
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index ea063a14cdd8..6b99602e1ed0 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1295,7 +1295,7 @@ static int snd_usb_motu_microbookii_communicate(struct usb_device *dev, u8 *buf,
 		return err;
 
 	print_hex_dump(KERN_DEBUG, "MicroBookII snd: ", DUMP_PREFIX_NONE, 16, 1,
-		       buf, actual_length, false);
+		       buf, actual_length, 0);
 
 	memset(buf, 0, buf_size);
 
@@ -1307,7 +1307,7 @@ static int snd_usb_motu_microbookii_communicate(struct usb_device *dev, u8 *buf,
 		return err;
 
 	print_hex_dump(KERN_DEBUG, "MicroBookII rcv: ", DUMP_PREFIX_NONE, 16, 1,
-		       buf, actual_length, false);
+		       buf, actual_length, 0);
 
 	*length = actual_length;
 	return 0;
diff --git a/sound/usb/validate.c b/sound/usb/validate.c
index 6fe206f6e911..2270038d334d 100644
--- a/sound/usb/validate.c
+++ b/sound/usb/validate.c
@@ -328,7 +328,8 @@ bool snd_usb_validate_audio_desc(void *p, int protocol)
 	valid = validate_desc(p, protocol, audio_validators);
 	if (!valid && snd_usb_skip_validation) {
 		print_hex_dump(KERN_ERR, "USB-audio: buggy audio desc: ",
-			       DUMP_PREFIX_NONE, 16, 1, c, c[0], true);
+			       DUMP_PREFIX_NONE, 16, 1, c, c[0],
+			       DUMP_FLAG_ASCII);
 		valid = true;
 	}
 	return valid;
@@ -342,7 +343,8 @@ bool snd_usb_validate_midi_desc(void *p)
 	valid = validate_desc(p, UAC_VERSION_1, midi_validators);
 	if (!valid && snd_usb_skip_validation) {
 		print_hex_dump(KERN_ERR, "USB-audio: buggy midi desc: ",
-			       DUMP_PREFIX_NONE, 16, 1, c, c[0], true);
+			       DUMP_PREFIX_NONE, 16, 1, c, c[0],
+			       DUMP_FLAG_ASCII);
 		valid = true;
 	}
 	return valid;
diff --git a/tools/testing/crypto/chacha20-s390/test-cipher.c b/tools/testing/crypto/chacha20-s390/test-cipher.c
index 8141d45df51a..947379f27cbc 100644
--- a/tools/testing/crypto/chacha20-s390/test-cipher.c
+++ b/tools/testing/crypto/chacha20-s390/test-cipher.c
@@ -59,10 +59,10 @@ static int test_lib_chacha(u8 *revert, u8 *cipher, u8 *plain)
 
 	if (debug) {
 		print_hex_dump(KERN_INFO, "key: ", DUMP_PREFIX_OFFSET,
-			       16, 1, key, 32, 1);
+			       16, 1, key, 32, DUMP_FLAG_ASCII);
 
 		print_hex_dump(KERN_INFO, "iv:  ", DUMP_PREFIX_OFFSET,
-			       16, 1, iv, 16, 1);
+			       16, 1, iv, 16, DUMP_FLAG_ASCII);
 	}
 
 	/* Encrypt */
@@ -76,7 +76,8 @@ static int test_lib_chacha(u8 *revert, u8 *cipher, u8 *plain)
 	if (debug)
 		print_hex_dump(KERN_INFO, "encr:", DUMP_PREFIX_OFFSET,
 			       16, 1, cipher,
-			       (data_size > 64 ? 64 : data_size), 1);
+			       (data_size > 64 ? 64 : data_size),
+			       DUMP_FLAG_ASCII);
 
 	pr_info("lib encryption took: %lld nsec", end - start);
 
@@ -90,7 +91,8 @@ static int test_lib_chacha(u8 *revert, u8 *cipher, u8 *plain)
 	if (debug)
 		print_hex_dump(KERN_INFO, "decr:", DUMP_PREFIX_OFFSET,
 			       16, 1, revert,
-			       (data_size > 64 ? 64 : data_size), 1);
+			       (data_size > 64 ? 64 : data_size),
+			       DUMP_FLAG_ASCII);
 
 	pr_info("lib decryption took: %lld nsec", end - start);
 
@@ -160,10 +162,10 @@ static int test_skcipher(char *name, u8 *revert, u8 *cipher, u8 *plain)
 
 	if (debug) {
 		print_hex_dump(KERN_INFO, "key: ", DUMP_PREFIX_OFFSET,
-			       16, 1, key, 32, 1);
+			       16, 1, key, 32, DUMP_FLAG_ASCII);
 
 		print_hex_dump(KERN_INFO, "iv:  ", DUMP_PREFIX_OFFSET,
-			       16, 1, iv, 16, 1);
+			       16, 1, iv, 16, DUMP_FLAG_ASCII);
 	}
 
 	sk.tfm = skcipher;
@@ -189,7 +191,8 @@ static int test_skcipher(char *name, u8 *revert, u8 *cipher, u8 *plain)
 	if (debug)
 		print_hex_dump(KERN_INFO, "encr:", DUMP_PREFIX_OFFSET,
 			       16, 1, cipher,
-			       (data_size > 64 ? 64 : data_size), 1);
+			       (data_size > 64 ? 64 : data_size),
+			       DUMP_FLAG_ASCII);
 
 	/* Prepare for decryption */
 	memset(iv, 'I', sizeof(iv));
@@ -213,7 +216,8 @@ static int test_skcipher(char *name, u8 *revert, u8 *cipher, u8 *plain)
 	if (debug)
 		print_hex_dump(KERN_INFO, "decr:", DUMP_PREFIX_OFFSET,
 			       16, 1, revert,
-			       (data_size > 64 ? 64 : data_size), 1);
+			       (data_size > 64 ? 64 : data_size),
+			       DUMP_FLAG_ASCII);
 
 	/* Dump some internal skcipher data */
 	if (debug)
@@ -276,7 +280,8 @@ static int __init chacha_s390_test_init(void)
 	if (debug)
 		print_hex_dump(KERN_INFO, "src: ", DUMP_PREFIX_OFFSET,
 			       16, 1, plain,
-			       (data_size > 64 ? 64 : data_size), 1);
+			       (data_size > 64 ? 64 : data_size),
+			       DUMP_FLAG_ASCII);
 
 	/* Use chacha20 generic */
 	ret = test_skcipher("chacha20-generic", revert, cipher_generic, plain);
diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index cfd4378e2129..ac9cf568742a 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -1342,7 +1342,7 @@ static void nfit_ctl_dbg(struct acpi_nfit_desc *acpi_desc,
 			nvdimm ? nvdimm_name(nvdimm) : "bus", family, cmd, func,
 			len);
 	print_hex_dump_debug("nvdimm in  ", DUMP_PREFIX_OFFSET, 16, 4,
-			buf, min(len, 256u), true);
+			buf, min(len, 256u), DUMP_FLAG_ASCII);
 }
 
 static int nfit_test_ctl(struct nvdimm_bus_descriptor *nd_desc,
-- 
2.43.0



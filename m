Return-Path: <linux-kernel+bounces-559845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8491BA5FA8A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0437E18960EB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AD6269892;
	Thu, 13 Mar 2025 15:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="pnx5E0wD"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B71E26980F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881479; cv=none; b=sjC7klp2dqM3+NELjQn2LqseuJnDZFzE3xiHW4tB9gZaisEr281rQZm8DKoEJP5/lMTzIWC7B2lxFbwlCcmJZEddpTSBrDXJUPq2ltoveFIglrLIj+rbvnrrXNDQH454yzgV4TT/6pG0roh/uA58Ueb1j8+upohELwjzuHdrauw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881479; c=relaxed/simple;
	bh=27sKw0efqZuQoUhwrXoAbtRhUPra3/OlzL/H//gfjzk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=u0n8gWWxgcoiSl5Y15pLP3KZEMbGvpZW6Oy/ny2yaRetuw5qQreB5/KlCHyAgQ0TfcLtRh5hrFv8Dn1d3IAClqs82zDVaD5wJyitc7ckNRE3AXxahs3D2PhiZPlTCVpm5dH75ifIpNJUN9cftvIEe93cVxZK0ET60A9FhToyWrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=pnx5E0wD; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1741881466;
	bh=27sKw0efqZuQoUhwrXoAbtRhUPra3/OlzL/H//gfjzk=;
	h=From:Subject:Date:To:Cc:From;
	b=pnx5E0wDyFwd8U7GfIbxA9e9CqBUKJ9UblQ0gaIqEcqcRyDm/+C7D2hT+mkMdAIBJ
	 eWRTn3ohdFuvdw7aoMavJ47Gsc7kgiyFN8WYf9A4i79nyWkVdnTWAYLhGpB8vSKUmt
	 pd71HLKzfx3VZTYMHk1YqZU++5WKhZf6FZREMmoc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 0/6] sysfs: finalize the constification of 'struct
 bin_attribute'
Date: Thu, 13 Mar 2025 16:57:44 +0100
Message-Id: <20250313-sysfs-const-bin_attr-final-v2-0-96284e1e88ce@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHgA02cC/33Nyw7CIBCF4VdpWDsG8EZd+R6mMQiDTGKoYbDaN
 H13sYlbl/9ZfGcSjJmQxbGZRMaBmPpUQ68a4aJNNwTytYWWeie1OgCPHBhcn7jAldLFlpIhULJ
 38C1uvXTBWOVFBR4ZA70X/NzVjsSlz+PyNajv+mPbf+ygQILURhtv9jZs3OmFxMwuPuM6YRHdP
 M8flxYFsMkAAAA=
X-Change-ID: 20250217-sysfs-const-bin_attr-final-d9e4d0cf8a1d
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741881465; l=9218;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=27sKw0efqZuQoUhwrXoAbtRhUPra3/OlzL/H//gfjzk=;
 b=mQFT8yyD/rmRD87bbMKF7gDAtqwN9GIm7Hn31RGQ6TuRwDtR200thgE3FC6HcGKbOL/4wU4Qo
 eIcfgfrl/aIBkbwDWvzw8a/dbCxZ4CiKB7tl180De1T5Vw2E3s724Aj
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

All users have been migrated to the new const types.
Change the types of the normal fields, switch all users over and then
get rid of the transition machinery.

The treewide changes have been done with sed/grep.
Based on top of driver-core-next.

I'm only sending this to the sysfs maintainers. The treewide changes are
purely mechanical.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Rebase onto current driver-core-next.
- Remove prerequisites list from cover letter.
- Link to v1: https://lore.kernel.org/r/20250219-sysfs-const-bin_attr-final-v1-0-02828d86af3c@weissschuh.net

---
Thomas Weißschuh (6):
      sysfs: constify bin_attribute argument of bin_attribute::read/write()
      sysfs: constify attribute_group::bin_attrs
      sysfs: treewide: switch back to bin_attribute::read()/write()
      sysfs: treewide: switch back to attribute_group::bin_attrs
      sysfs: remove bin_attribute::read_new/write_new()
      sysfs: remove attribute_group::bin_attrs_new

 arch/powerpc/kernel/secvar-sysfs.c                 |  2 +-
 arch/powerpc/perf/hv-24x7.c                        |  2 +-
 arch/powerpc/platforms/powernv/opal-core.c         |  4 +--
 arch/powerpc/platforms/powernv/opal-dump.c         |  2 +-
 arch/powerpc/platforms/powernv/opal-elog.c         |  2 +-
 arch/powerpc/platforms/powernv/opal-flash.c        |  2 +-
 arch/powerpc/platforms/powernv/opal-msglog.c       |  2 +-
 arch/powerpc/platforms/powernv/opal.c              |  2 +-
 arch/powerpc/platforms/powernv/ultravisor.c        |  2 +-
 arch/s390/kernel/cpacf.c                           |  2 +-
 arch/s390/kernel/ipl.c                             | 18 +++++------
 arch/s390/pci/pci_sysfs.c                          |  2 +-
 arch/x86/kernel/ksysfs.c                           |  8 ++---
 drivers/accel/habanalabs/common/sysfs.c            |  4 +--
 drivers/acpi/bgrt.c                                |  2 +-
 drivers/acpi/sysfs.c                               |  4 +--
 drivers/base/devcoredump.c                         |  2 +-
 drivers/base/firmware_loader/sysfs.c               |  6 ++--
 drivers/base/node.c                                |  2 +-
 drivers/base/topology.c                            |  2 +-
 drivers/cxl/port.c                                 |  2 +-
 drivers/firmware/efi/mokvar-table.c                |  2 +-
 drivers/firmware/google/cbmem.c                    |  2 +-
 drivers/firmware/google/gsmi.c                     |  2 +-
 drivers/firmware/google/memconsole.c               |  2 +-
 drivers/firmware/google/vpd.c                      |  4 +--
 drivers/firmware/qemu_fw_cfg.c                     |  2 +-
 drivers/fsi/fsi-core.c                             |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  6 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c |  4 +--
 drivers/gpu/drm/drm_sysfs.c                        |  4 +--
 drivers/gpu/drm/i915/i915_gpu_error.c              |  4 +--
 drivers/gpu/drm/i915/i915_sysfs.c                  |  8 ++---
 drivers/gpu/drm/lima/lima_drv.c                    |  4 +--
 drivers/hid/hid-core.c                             |  2 +-
 drivers/hid/hid-roccat-arvo.c                      |  2 +-
 drivers/hid/hid-roccat-common.h                    |  8 ++---
 drivers/hid/hid-roccat-isku.c                      | 10 +++---
 drivers/hid/hid-roccat-kone.c                      |  6 ++--
 drivers/hid/hid-roccat-koneplus.c                  | 14 ++++-----
 drivers/hid/hid-roccat-konepure.c                  |  2 +-
 drivers/hid/hid-roccat-kovaplus.c                  | 12 ++++----
 drivers/hid/hid-roccat-lua.c                       |  4 +--
 drivers/hid/hid-roccat-pyra.c                      | 14 ++++-----
 drivers/hid/hid-roccat-ryos.c                      |  2 +-
 drivers/hid/hid-roccat-savu.c                      |  2 +-
 drivers/i2c/i2c-slave-eeprom.c                     |  4 +--
 drivers/iio/imu/bno055/bno055.c                    |  2 +-
 drivers/infiniband/hw/hfi1/sysfs.c                 |  2 +-
 drivers/infiniband/hw/qib/qib_sysfs.c              |  2 +-
 drivers/input/touchscreen/goodix_berlin_core.c     |  2 +-
 drivers/leds/led-class.c                           |  2 +-
 drivers/media/pci/solo6x10/solo6x10-core.c         |  2 +-
 drivers/misc/c2port/core.c                         |  2 +-
 drivers/misc/cxl/sysfs.c                           |  4 +--
 drivers/misc/ds1682.c                              |  4 +--
 drivers/misc/eeprom/max6875.c                      |  2 +-
 drivers/misc/ocxl/sysfs.c                          |  2 +-
 drivers/misc/pch_phub.c                            |  4 +--
 drivers/misc/sram.c                                |  4 +--
 drivers/mtd/spi-nor/sysfs.c                        |  2 +-
 .../net/ethernet/qlogic/netxen/netxen_nic_main.c   | 10 +++---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sysfs.c  | 34 ++++++++++----------
 drivers/net/phy/spi_ks8995.c                       |  4 +--
 drivers/net/wireless/ti/wlcore/sysfs.c             |  2 +-
 drivers/nvmem/core.c                               | 14 ++++-----
 drivers/of/kobj.c                                  |  2 +-
 drivers/pci/hotplug/acpiphp_ibm.c                  |  2 +-
 drivers/pci/p2pdma.c                               |  2 +-
 drivers/pci/pci-sysfs.c                            | 12 ++++----
 drivers/pci/vpd.c                                  |  2 +-
 drivers/pcmcia/cistpl.c                            |  4 +--
 drivers/platform/chrome/cros_ec_vbc.c              |  2 +-
 drivers/platform/mellanox/mlxbf-bootctl.c          |  2 +-
 drivers/platform/x86/amd/hsmp/acpi.c               |  4 +--
 drivers/platform/x86/amd/hsmp/plat.c               |  4 +--
 drivers/platform/x86/dell/dcdbas.c                 |  2 +-
 drivers/platform/x86/dell/dell_rbu.c               |  2 +-
 drivers/platform/x86/intel/pmt/class.c             |  2 +-
 drivers/platform/x86/intel/sdsi.c                  |  2 +-
 drivers/platform/x86/wmi-bmof.c                    |  2 +-
 drivers/power/supply/ds2760_battery.c              |  2 +-
 drivers/power/supply/ds2780_battery.c              | 10 +++---
 drivers/power/supply/ds2781_battery.c              | 10 +++---
 drivers/power/supply/olpc_battery.c                |  4 +--
 drivers/ptp/ptp_ocp.c                              |  2 +-
 drivers/rapidio/rio-sysfs.c                        |  6 ++--
 drivers/s390/char/sclp_config.c                    |  2 +-
 drivers/s390/char/sclp_sd.c                        |  2 +-
 drivers/s390/cio/chp.c                             |  2 +-
 drivers/s390/crypto/pkey_sysfs.c                   |  8 ++---
 drivers/scsi/3w-sas.c                              |  4 +--
 drivers/scsi/arcmsr/arcmsr_attr.c                  |  6 ++--
 drivers/scsi/esas2r/esas2r_main.c                  |  6 ++--
 drivers/scsi/ibmvscsi/ibmvfc.c                     |  2 +-
 drivers/scsi/ipr.c                                 | 10 +++---
 drivers/scsi/lpfc/lpfc_attr.c                      |  8 ++---
 drivers/scsi/qedf/qedf_attr.c                      |  4 +--
 drivers/scsi/qla2xxx/qla_attr.c                    | 28 ++++++++---------
 drivers/scsi/qla4xxx/ql4_attr.c                    |  4 +--
 drivers/scsi/scsi_sysfs.c                          |  6 ++--
 drivers/usb/core/sysfs.c                           |  2 +-
 drivers/usb/usbip/vudc_sysfs.c                     |  2 +-
 drivers/video/fbdev/aty/radeon_base.c              |  4 +--
 drivers/video/fbdev/udlfb.c                        |  4 +--
 drivers/w1/slaves/w1_ds2406.c                      |  4 +--
 drivers/w1/slaves/w1_ds2408.c                      |  2 +-
 drivers/w1/slaves/w1_ds2413.c                      |  2 +-
 drivers/w1/slaves/w1_ds2430.c                      |  2 +-
 drivers/w1/slaves/w1_ds2431.c                      |  2 +-
 drivers/w1/slaves/w1_ds2433.c                      | 12 ++++----
 drivers/w1/slaves/w1_ds2438.c                      |  2 +-
 drivers/w1/slaves/w1_ds2780.c                      |  2 +-
 drivers/w1/slaves/w1_ds2781.c                      |  2 +-
 drivers/w1/slaves/w1_ds2805.c                      |  4 +--
 drivers/w1/slaves/w1_ds28e04.c                     |  2 +-
 drivers/w1/w1.c                                    |  2 +-
 drivers/zorro/zorro-sysfs.c                        |  4 +--
 fs/sysfs/file.c                                    | 22 +++----------
 fs/sysfs/group.c                                   |  6 ++--
 include/linux/sysfs.h                              | 36 ++++------------------
 kernel/bpf/btf.c                                   |  2 +-
 kernel/bpf/sysfs_btf.c                             |  2 +-
 kernel/module/sysfs.c                              | 14 ++++-----
 mm/page_idle.c                                     |  2 +-
 net/bridge/br_sysfs_br.c                           |  2 +-
 127 files changed, 291 insertions(+), 327 deletions(-)
---
base-commit: 993a47bd7b998156ffebc999617474c920dc9208
change-id: 20250217-sysfs-const-bin_attr-final-d9e4d0cf8a1d

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>



Return-Path: <linux-kernel+bounces-556914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E600A5D092
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88EE63AF2CE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49555263F2B;
	Tue, 11 Mar 2025 20:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="nfDgFF1p"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DE425E801
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 20:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741724036; cv=none; b=onSE8mnFoVYUs9iPyOxVAoxNfFzCz2lO902TVMMI1pw8xAl626mSIJyfrYTIni7c3s7vbZX1dH8iwFWdfl7WlkgEQ55sowv7gQ4GvRWLhD1mJ96ec5DjVulrmnLp6Coc4yHPl/Z1qcdZlmVT3qGJJSVoy5JigMHtyPVqELN/AnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741724036; c=relaxed/simple;
	bh=EUqZg0vXflXxmaGeKOix8SIF25ehEGtBKBzHTLPJF4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXmZAaBE7uRLIz9WiCn81Xi57ROBUx2w5i8OLUe8GCtbJFPQOTG6VkWL7RKASzm+rh0unqG5KM4MpWGXqrWzSF5hJmIO6J4E5+ZqjgEji18b4RlXyhZl0nfBbqum/a12DFpksDlo4IX4EEp61+/C2CGh6blVqRdNCX+gYODWXIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=nfDgFF1p; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1741724022;
	bh=EUqZg0vXflXxmaGeKOix8SIF25ehEGtBKBzHTLPJF4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nfDgFF1pZZ7fwMd48tWuXhELuYkTBFbmh/MWFCgcLWHj0VxX/+7TYtxvOtzRLHQ23
	 5sW8WTx1Z7o4EyYUcGjnaN1CAgU0YUILlv7dZZzfhrMfb0GxSzanB32LrQTjAv0fZ7
	 3L4eXNXQcrk/HsdNQltgd9cANc+Bdmgm31XgJBGQ=
Date: Tue, 11 Mar 2025 21:13:39 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] sysfs: finalize the constification of 'struct
 bin_attribute'
Message-ID: <997b8f61-80f6-40e7-bc1f-3ee6294a06d5@t-8ch.de>
References: <20250219-sysfs-const-bin_attr-final-v1-0-02828d86af3c@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250219-sysfs-const-bin_attr-final-v1-0-02828d86af3c@weissschuh.net>

Hi Greg,

On 2025-02-19 22:34:49+0100, Thomas Weißschuh wrote:
> All users have been migrated to the new const types.
> Change the types of the normal fields, switch all users over and then
> get rid of the transition machinery.
> 
> This depends on the following patches which are not mainline yet:
> 
> https://lore.kernel.org/r/20250114-sysfs-const-bin_attr-cxl-v1-1-5afa23fe2a52@weissschuh.net
> https://lore.kernel.org/r/20250125-sysfs-const-bin_attr-dmi-v2-0-ece1895936f4@weissschuh.net
> https://lore.kernel.org/r/20241216-sysfs-const-bin_attr-drm-v1-0-210f2b36b9bf@weissschuh.net
> https://lore.kernel.org/r/20241215-sysfs-const-bin_attr-fsi-v1-1-b717f76a0146@weissschuh.net
> https://lore.kernel.org/r/20241216-sysfs-const-bin_attr-habanalabs-v1-1-b35463197efb@weissschuh.net
> https://lore.kernel.org/r/20241222-sysfs-const-bin_attr-input-v1-1-1229dbe5ae71@weissschuh.net
> https://lore.kernel.org/r/20241215-sysfs-const-bin_attr-mokvar-v1-1-d5a3d1fff8d1@weissschuh.net
> https://lore.kernel.org/r/20241215-sysfs-const-bin_attr-pcmcia-v1-1-ebb82e47d834@weissschuh.net
> https://lore.kernel.org/r/20241216-sysfs-const-bin_attr-powerpc-v1-0-bbed8906f476@weissschuh.net
> https://lore.kernel.org/r/20250114-sysfs-const-bin_attr-qemu_fw_cfg-v1-1-76f525a3ee72@weissschuh.net
> https://lore.kernel.org/r/20241216-sysfs-const-bin_attr-rapidio-v1-1-0f47f4719683@weissschuh.net
> https://lore.kernel.org/r/20241122-sysfs-const-bin_attr-rci2-v1-1-3db1ec9aa203@weissschuh.net

All those prerequisites have been in your driver-core tree for some time.
Do you want to merge the finalization series also for 6.15?
If so, should I resend it for your convenience?

> The treewide changes have been done with sed/grep.
> This series and prerequisites have passed 0day on top of
> 2408a807bfc3 ("Merge tag 'vfs-6.14-rc4.fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs").
> 
> I'm only sending this to the sysfs maintainers. The treewide changes are
> purely mechanical.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> Thomas Weißschuh (6):
>       sysfs: constify bin_attribute argument of bin_attribute::read/write()
>       sysfs: constify attribute_group::bin_attrs
>       sysfs: treewide: switch back to bin_attribute::read()/write()
>       sysfs: treewide: switch back to attribute_group::bin_attrs
>       sysfs: remove bin_attribute::read_new/write_new()
>       sysfs: remove attribute_group::bin_attrs_new
> 
>  arch/powerpc/kernel/secvar-sysfs.c                 |  2 +-
>  arch/powerpc/perf/hv-24x7.c                        |  2 +-
>  arch/powerpc/platforms/powernv/opal-core.c         |  4 +--
>  arch/powerpc/platforms/powernv/opal-dump.c         |  2 +-
>  arch/powerpc/platforms/powernv/opal-elog.c         |  2 +-
>  arch/powerpc/platforms/powernv/opal-flash.c        |  2 +-
>  arch/powerpc/platforms/powernv/opal-msglog.c       |  2 +-
>  arch/powerpc/platforms/powernv/opal.c              |  2 +-
>  arch/powerpc/platforms/powernv/ultravisor.c        |  2 +-
>  arch/s390/kernel/cpacf.c                           |  2 +-
>  arch/s390/kernel/ipl.c                             | 18 +++++------
>  arch/s390/pci/pci_sysfs.c                          |  2 +-
>  arch/x86/kernel/ksysfs.c                           |  8 ++---
>  drivers/accel/habanalabs/common/sysfs.c            |  4 +--
>  drivers/acpi/bgrt.c                                |  2 +-
>  drivers/acpi/sysfs.c                               |  4 +--
>  drivers/base/devcoredump.c                         |  2 +-
>  drivers/base/firmware_loader/sysfs.c               |  6 ++--
>  drivers/base/node.c                                |  2 +-
>  drivers/base/topology.c                            |  2 +-
>  drivers/cxl/port.c                                 |  2 +-
>  drivers/firmware/efi/mokvar-table.c                |  2 +-
>  drivers/firmware/google/cbmem.c                    |  2 +-
>  drivers/firmware/google/gsmi.c                     |  2 +-
>  drivers/firmware/google/memconsole.c               |  2 +-
>  drivers/firmware/google/vpd.c                      |  4 +--
>  drivers/firmware/qemu_fw_cfg.c                     |  2 +-
>  drivers/fsi/fsi-core.c                             |  4 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  6 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |  2 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c |  4 +--
>  drivers/gpu/drm/drm_sysfs.c                        |  4 +--
>  drivers/gpu/drm/i915/i915_gpu_error.c              |  4 +--
>  drivers/gpu/drm/i915/i915_sysfs.c                  |  8 ++---
>  drivers/gpu/drm/lima/lima_drv.c                    |  4 +--
>  drivers/hid/hid-core.c                             |  2 +-
>  drivers/hid/hid-roccat-arvo.c                      |  2 +-
>  drivers/hid/hid-roccat-common.h                    |  8 ++---
>  drivers/hid/hid-roccat-isku.c                      | 10 +++---
>  drivers/hid/hid-roccat-kone.c                      |  6 ++--
>  drivers/hid/hid-roccat-koneplus.c                  | 14 ++++-----
>  drivers/hid/hid-roccat-konepure.c                  |  2 +-
>  drivers/hid/hid-roccat-kovaplus.c                  | 12 ++++----
>  drivers/hid/hid-roccat-lua.c                       |  4 +--
>  drivers/hid/hid-roccat-pyra.c                      | 14 ++++-----
>  drivers/hid/hid-roccat-ryos.c                      |  2 +-
>  drivers/hid/hid-roccat-savu.c                      |  2 +-
>  drivers/i2c/i2c-slave-eeprom.c                     |  4 +--
>  drivers/iio/imu/bno055/bno055.c                    |  2 +-
>  drivers/infiniband/hw/hfi1/sysfs.c                 |  2 +-
>  drivers/infiniband/hw/qib/qib_sysfs.c              |  2 +-
>  drivers/input/touchscreen/goodix_berlin_core.c     |  2 +-
>  drivers/leds/led-class.c                           |  2 +-
>  drivers/media/pci/solo6x10/solo6x10-core.c         |  2 +-
>  drivers/misc/c2port/core.c                         |  2 +-
>  drivers/misc/cxl/sysfs.c                           |  4 +--
>  drivers/misc/ds1682.c                              |  4 +--
>  drivers/misc/eeprom/max6875.c                      |  2 +-
>  drivers/misc/ocxl/sysfs.c                          |  2 +-
>  drivers/misc/pch_phub.c                            |  4 +--
>  drivers/misc/sram.c                                |  4 +--
>  drivers/mtd/spi-nor/sysfs.c                        |  2 +-
>  .../net/ethernet/qlogic/netxen/netxen_nic_main.c   | 10 +++---
>  drivers/net/ethernet/qlogic/qlcnic/qlcnic_sysfs.c  | 34 ++++++++++----------
>  drivers/net/phy/spi_ks8995.c                       |  4 +--
>  drivers/net/wireless/ti/wlcore/sysfs.c             |  2 +-
>  drivers/nvmem/core.c                               | 14 ++++-----
>  drivers/of/kobj.c                                  |  2 +-
>  drivers/pci/hotplug/acpiphp_ibm.c                  |  2 +-
>  drivers/pci/p2pdma.c                               |  2 +-
>  drivers/pci/pci-sysfs.c                            | 12 ++++----
>  drivers/pci/vpd.c                                  |  2 +-
>  drivers/pcmcia/cistpl.c                            |  4 +--
>  drivers/platform/chrome/cros_ec_vbc.c              |  2 +-
>  drivers/platform/mellanox/mlxbf-bootctl.c          |  2 +-
>  drivers/platform/x86/amd/hsmp/acpi.c               |  4 +--
>  drivers/platform/x86/amd/hsmp/plat.c               |  4 +--
>  drivers/platform/x86/dell/dcdbas.c                 |  2 +-
>  drivers/platform/x86/dell/dell_rbu.c               |  2 +-
>  drivers/platform/x86/intel/pmt/class.c             |  2 +-
>  drivers/platform/x86/intel/sdsi.c                  |  2 +-
>  drivers/platform/x86/wmi-bmof.c                    |  2 +-
>  drivers/power/supply/ds2760_battery.c              |  2 +-
>  drivers/power/supply/ds2780_battery.c              | 10 +++---
>  drivers/power/supply/ds2781_battery.c              | 10 +++---
>  drivers/power/supply/olpc_battery.c                |  4 +--
>  drivers/ptp/ptp_ocp.c                              |  2 +-
>  drivers/rapidio/rio-sysfs.c                        |  6 ++--
>  drivers/s390/char/sclp_config.c                    |  2 +-
>  drivers/s390/char/sclp_sd.c                        |  2 +-
>  drivers/s390/cio/chp.c                             |  2 +-
>  drivers/s390/crypto/pkey_sysfs.c                   |  8 ++---
>  drivers/scsi/3w-sas.c                              |  4 +--
>  drivers/scsi/arcmsr/arcmsr_attr.c                  |  6 ++--
>  drivers/scsi/esas2r/esas2r_main.c                  |  6 ++--
>  drivers/scsi/ibmvscsi/ibmvfc.c                     |  2 +-
>  drivers/scsi/ipr.c                                 | 10 +++---
>  drivers/scsi/lpfc/lpfc_attr.c                      |  8 ++---
>  drivers/scsi/qedf/qedf_attr.c                      |  4 +--
>  drivers/scsi/qla2xxx/qla_attr.c                    | 28 ++++++++---------
>  drivers/scsi/qla4xxx/ql4_attr.c                    |  4 +--
>  drivers/scsi/scsi_sysfs.c                          |  6 ++--
>  drivers/usb/core/sysfs.c                           |  2 +-
>  drivers/usb/usbip/vudc_sysfs.c                     |  2 +-
>  drivers/video/fbdev/aty/radeon_base.c              |  4 +--
>  drivers/video/fbdev/udlfb.c                        |  4 +--
>  drivers/w1/slaves/w1_ds2406.c                      |  4 +--
>  drivers/w1/slaves/w1_ds2408.c                      |  2 +-
>  drivers/w1/slaves/w1_ds2413.c                      |  2 +-
>  drivers/w1/slaves/w1_ds2430.c                      |  2 +-
>  drivers/w1/slaves/w1_ds2431.c                      |  2 +-
>  drivers/w1/slaves/w1_ds2433.c                      | 12 ++++----
>  drivers/w1/slaves/w1_ds2438.c                      |  2 +-
>  drivers/w1/slaves/w1_ds2780.c                      |  2 +-
>  drivers/w1/slaves/w1_ds2781.c                      |  2 +-
>  drivers/w1/slaves/w1_ds2805.c                      |  4 +--
>  drivers/w1/slaves/w1_ds28e04.c                     |  2 +-
>  drivers/w1/w1.c                                    |  2 +-
>  drivers/zorro/zorro-sysfs.c                        |  4 +--
>  fs/sysfs/file.c                                    | 22 +++----------
>  fs/sysfs/group.c                                   |  6 ++--
>  include/linux/sysfs.h                              | 36 ++++------------------
>  kernel/bpf/btf.c                                   |  2 +-
>  kernel/bpf/sysfs_btf.c                             |  2 +-
>  kernel/module/sysfs.c                              | 14 ++++-----
>  mm/page_idle.c                                     |  2 +-
>  net/bridge/br_sysfs_br.c                           |  2 +-
>  127 files changed, 291 insertions(+), 327 deletions(-)
> ---
> base-commit: 16fbcf2511cee77492408f12b31eb8557c24bee8
> change-id: 20250217-sysfs-const-bin_attr-final-d9e4d0cf8a1d
> 
> Best regards,
> -- 
> Thomas Weißschuh <linux@weissschuh.net>
> 


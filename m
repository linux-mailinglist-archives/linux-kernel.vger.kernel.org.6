Return-Path: <linux-kernel+bounces-370819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D50E9A3274
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 04:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0B0E1F21300
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 02:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F641143C69;
	Fri, 18 Oct 2024 02:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JDAQw/By"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E453745948;
	Fri, 18 Oct 2024 02:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729217575; cv=none; b=i9d62tZTBjHNbXfw3er298QfTjT0PiJ/Jj2B0hg0WbwdQCYU2xhnR7thM745aenRKy8h35QxgAawuNVd0qdN+iQELiQ8VavoTKaDMV2LwAvdo6ZUaCmeYroXfiJcF0fuIURxX6Y7kIX83W8WSn/zdVe8v/sMUyXbZ4wn6TEoNLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729217575; c=relaxed/simple;
	bh=JPFYlkYf/+hv9T0QH45UzVvwMbV/FuI9A65XHC/BGPc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k/won9RMg5aPfe/x21M/7nQ1TqBb9fb5RooRo4yCPVMa8x5SQwtnNJiKEt/YV1PWkIEzPIVdGJQvL2JOel40tstxRQtYpGkOLYm2ezgVZg2mMg7o6d7I2yXVkquQHrs//k1QEL3qnpcE4c7/KDsFJE0J7ZmSTVWBEVjSzcLgyPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JDAQw/By; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729217574; x=1760753574;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=JPFYlkYf/+hv9T0QH45UzVvwMbV/FuI9A65XHC/BGPc=;
  b=JDAQw/ByqcR199yiQd3A7NaYDOvpsJgpwHLXHIuH9o2ERD/Rx/MSDGmR
   2raskT6nLDTfTxSwIJh036/v3nUf3hKT2nKAcolVH74kwdc9qv1Zf64To
   U/CNw8kRUfIz7guCs3ZfH+cMXrHDyo2jqeZoLUugz4vvXxusftW2B+mwX
   GqGkLRbxs5LJF/WNRKlW8GJc80hVaQrDZRytwKCryaWFbOKsZ7gAnC/44
   LuEwFi+MYYadaCLYB4+Ue7FM7tTqM0IOfmxRwEAhOh1mXkcOub0HMyA8a
   tuRpyILjkptTQ7+Sr/iEWIQX9uyw763kmeyUfztzaEIeo57wuWERGIzNp
   Q==;
X-CSE-ConnectionGUID: ker01savTS2Mm4gUCyzKSQ==
X-CSE-MsgGUID: i1Kelw3NSUiVh9JEMwcTQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="54148802"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="54148802"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 19:12:48 -0700
X-CSE-ConnectionGUID: vVMc0NGFTWm+LoQxI+3FmQ==
X-CSE-MsgGUID: ME9C8FnkQcuLtMCGrRTShA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="78877830"
Received: from mesiment-mobl2.amr.corp.intel.com ([10.125.109.71])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 19:12:48 -0700
Message-ID: <1cc0337e3b825d9f068b155ef7cfdb7756870cbb.camel@linux.intel.com>
Subject: Re: [PATCH] platform/x86/intel/pmc: Fix pmc_core_iounmap to call
 iounmap for valid addresses
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: Vamsi Krishna Brahmajosyula <vamsikrishna.brahmajosyula@gmail.com>, 
 irenic.rajneesh@gmail.com, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
Cc: skhan@linuxfoundation.org, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 17 Oct 2024 19:12:47 -0700
In-Reply-To: <20241017041027.12785-1-vamsikrishna.brahmajosyula@gmail.com>
References: <20241017041027.12785-1-vamsikrishna.brahmajosyula@gmail.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Vamsi,

On Thu, 2024-10-17 at 09:40 +0530, Vamsi Krishna Brahmajosyula wrote:
> 50c6dbdfd introduced a WARN when adrress ranges of iounmap are
> invalid. On Thinkpad P1 Gen 7 (Meteor Lake-P) this caused the
> following warning to appear.
>=20
> WARNING: CPU: 7 PID: 713 at arch/x86/mm/ioremap.c:461 iounmap+0x58/0x1f0
> Modules linked in: rfkill(+) snd_timer(+) fjes(+) snd soundcore
> intel_pmc_core(+)
> int3403_thermal(+) int340x_thermal_zone intel_vsec pmt_telemetry acpi_pad
> pmt_class
> acpi_tad int3400_thermal acpi_thermal_rel joydev loop nfnetlink zram xe
> drm_suballoc_helper
> nouveau i915 mxm_wmi drm_ttm_helper gpu_sched drm_gpuvm drm_exec drm_budd=
y
> i2c_algo_bit
> crct10dif_pclmul crc32_pclmul ttm crc32c_intel polyval_clmulni rtsx_pci_s=
dmmc
> ucsi_acpi
> polyval_generic mmc_core hid_multitouch drm_display_helper ghash_clmulni_=
intel
> typec_ucsi
> nvme sha512_ssse3 video sha256_ssse3 nvme_core intel_vpu sha1_ssse3 rtsx_=
pci
> cec typec
> nvme_auth i2c_hid_acpi i2c_hid wmi pinctrl_meteorlake serio_raw ip6_table=
s
> ip_tables fuse
> CPU: 7 UID: 0 PID: 713 Comm: (udev-worker) Not tainted 6.12.0-rc2iounmap+=
 #42
> Hardware name: LENOVO 21KWCTO1WW/21KWCTO1WW, BIOS N48ET19W (1.06 ) 07/18/=
2024
> RIP: 0010:iounmap+0x58/0x1f0
> Code: 85 6a 01 00 00 48 8b 05 e6 e2 28 04 48 39 c5 72 19 eb 26 cc cc cc 4=
8 ba
> 00 00 00 00 00 00 32 00 48 8d 44 02 ff 48 39 c5 72 23 <0f> 0b 48 83 c4 08=
 5b
> 5d 41 5c c3 cc cc cc cc 48 ba 00 00 00 00 00
> RSP: 0018:ffff888131eff038 EFLAGS: 00010207
> RAX: ffffc90000000000 RBX: 0000000000000000 RCX: ffff888e33b80000
> RDX: dffffc0000000000 RSI: ffff888e33bc29c0 RDI: 0000000000000000
> RBP: 0000000000000000 R08: ffff8881598a8000 R09: ffff888e2ccedc10
> R10: 0000000000000003 R11: ffffffffb3367634 R12: 00000000fe000000
> R13: ffff888101d0da28 R14: ffffffffc2e437e0 R15: ffff888110b03b28
> FS:=C2=A0 00007f3c1d4b3980(0000) GS:ffff888e33b80000(0000) knlGS:00000000=
00000000
> CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005651cfc93578 CR3: 0000000124e4c002 CR4: 0000000000f70ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
> <TASK>
> ? __warn.cold+0xb6/0x176
> ? iounmap+0x58/0x1f0
> ? report_bug+0x1f4/0x2b0
> ? handle_bug+0x58/0x90
> ? exc_invalid_op+0x17/0x40
> ? asm_exc_invalid_op+0x1a/0x20
> ? iounmap+0x58/0x1f0
> pmc_core_ssram_get_pmc+0x477/0x6c0 [intel_pmc_core]
> ? __pfx_pmc_core_ssram_get_pmc+0x10/0x10 [intel_pmc_core]
> ? __pfx_do_pci_enable_device+0x10/0x10
> ? pci_wait_for_pending+0x60/0x110
> ? pci_enable_device_flags+0x1e3/0x2e0
> ? __pfx_mtl_core_init+0x10/0x10 [intel_pmc_core]
> pmc_core_ssram_init+0x7f/0x110 [intel_pmc_core]
> mtl_core_init+0xda/0x130 [intel_pmc_core]
> ? __mutex_init+0xb9/0x130
> pmc_core_probe+0x27e/0x10b0 [intel_pmc_core]
> ? _raw_spin_lock_irqsave+0x96/0xf0
> ? __pfx_pmc_core_probe+0x10/0x10 [intel_pmc_core]
> ? __pfx_mutex_unlock+0x10/0x10
> ? __pfx_mutex_lock+0x10/0x10
> ? device_pm_check_callbacks+0x82/0x370
> ? acpi_dev_pm_attach+0x234/0x2b0
> platform_probe+0x9f/0x150
> really_probe+0x1e0/0x8a0
> __driver_probe_device+0x18c/0x370
> ? __pfx___driver_attach+0x10/0x10
> driver_probe_device+0x4a/0x120
> __driver_attach+0x190/0x4a0
> ? __pfx___driver_attach+0x10/0x10
> bus_for_each_dev+0x103/0x180
> ? __pfx_bus_for_each_dev+0x10/0x10
> ? klist_add_tail+0x136/0x270
> bus_add_driver+0x2fc/0x540
> driver_register+0x1a5/0x360
> ? __pfx_pmc_core_driver_init+0x10/0x10 [intel_pmc_core]
> do_one_initcall+0xa4/0x380
> ? __pfx_do_one_initcall+0x10/0x10
> ? kasan_unpoison+0x44/0x70
> do_init_module+0x296/0x800
> load_module+0x5090/0x6ce0
> ? __pfx_load_module+0x10/0x10
> ? ima_post_read_file+0x193/0x200
> ? __pfx_ima_post_read_file+0x10/0x10
> ? rw_verify_area+0x152/0x4c0
> ? kernel_read_file+0x257/0x750
> ? __pfx_kernel_read_file+0x10/0x10
> ? __pfx_filemap_get_read_batch+0x10/0x10
> ? init_module_from_file+0xd1/0x130
> init_module_from_file+0xd1/0x130
> ? __pfx_init_module_from_file+0x10/0x10
> ? __pfx__raw_spin_lock+0x10/0x10
> ? __pfx_cred_has_capability.isra.0+0x10/0x10
> idempotent_init_module+0x236/0x770
> ? __pfx_idempotent_init_module+0x10/0x10
> ? fdget+0x58/0x3f0
> ? security_capable+0x7d/0x110
> __x64_sys_finit_module+0xbe/0x130
> do_syscall_64+0x82/0x160
> ? __pfx_filemap_read+0x10/0x10
> ? __pfx___fsnotify_parent+0x10/0x10
> ? vfs_read+0x3a6/0xa30
> ? vfs_read+0x3a6/0xa30
> ? __seccomp_filter+0x175/0xc60
> ? __pfx___seccomp_filter+0x10/0x10
> ? fdget_pos+0x1ce/0x500
> ? syscall_exit_to_user_mode_prepare+0x149/0x170
> ? syscall_exit_to_user_mode+0x10/0x210
> ? do_syscall_64+0x8e/0x160
> ? switch_fpu_return+0xe3/0x1f0
> ? syscall_exit_to_user_mode+0x1d5/0x210
> ? do_syscall_64+0x8e/0x160
> ? exc_page_fault+0x76/0xf0
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x7f3c1d6d155d
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f=
7 48
> 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff=
 73
> 01 c3 48 8b 0d 83 58 0f 00 f7 d8 64 89 01 48
> RSP: 002b:00007ffe6309db38 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> RAX: ffffffffffffffda RBX: 0000557c212550a0 RCX: 00007f3c1d6d155d
> RDX: 0000000000000000 RSI: 00007f3c1cd943bd RDI: 0000000000000025
> RBP: 00007ffe6309dbf0 R08: 00007f3c1d7c7b20 R09: 00007ffe6309db80
> R10: 0000557c21255270 R11: 0000000000000246 R12: 00007f3c1cd943bd
> R13: 0000000000020000 R14: 0000557c21255c80 R15: 0000557c21255240
> </TASK>
> ---[ end trace 0000000000000000 ]---
>=20
> pmc_core_iounmap calls iounmap unconditionally causing the above
> warning to appear during boot.
>=20
> Fix it by checking for a valid address before calling iounmap.
>=20
> Also the function pmc_core_ssram_get_pmc,
> 	ioremap(ssram_base, SSRAM_HDR_SIZE)
> returns NULL on the same meteor lake machine even though the
> ssram_base is valid, return -ENOMEM in such cases.
>=20
> Fixes: a01486dc4bb1 ("platform/x86/intel/pmc: Cleanup SSRAM discovery")
> Signed-off-by: Vamsi Krishna Brahmajosyula
> <vamsikrishna.brahmajosyula@gmail.com>
> ---
> =C2=A0drivers/platform/x86/intel/pmc/core_ssram.c | 4 +++-
> =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/x86/intel/pmc/core_ssram.c
> b/drivers/platform/x86/intel/pmc/core_ssram.c
> index c259c96b7dfd..8504154b649f 100644
> --- a/drivers/platform/x86/intel/pmc/core_ssram.c
> +++ b/drivers/platform/x86/intel/pmc/core_ssram.c
> @@ -29,7 +29,7 @@
> =C2=A0#define LPM_REG_COUNT		28
> =C2=A0#define LPM_MODE_OFFSET		1
> =C2=A0
> -DEFINE_FREE(pmc_core_iounmap, void __iomem *, iounmap(_T));
> +DEFINE_FREE(pmc_core_iounmap, void __iomem *, if (_T) iounmap(_T))
> =C2=A0
> =C2=A0static u32 pmc_core_find_guid(struct pmc_info *list, const struct p=
mc_reg_map
> *map)
> =C2=A0{
> @@ -262,6 +262,8 @@ pmc_core_ssram_get_pmc(struct pmc_dev *pmcdev, int
> pmc_idx, u32 offset)
> =C2=A0
> =C2=A0	ssram_base =3D ssram_pcidev->resource[0].start;
> =C2=A0	tmp_ssram =3D ioremap(ssram_base, SSRAM_HDR_SIZE);
> +	if (!tmp_ssram)
> +		return -ENOMEM;

While this is good to check, I don't think this is where the NULL came from=
. It
should be coming from the line,

        ssram =3D no_free_ptr(tmp_ssram);

This is from the if/else block that chooses an ssram value. In the above li=
ne,
we save the temporary value and do the no_free_ptr() so that we don't end u=
p
calling iounmap() twice on the same address. However, this does set tmp_ssr=
am to
NULL so we do need to check for that in the iounmap() handler. Thanks.

Reviewed-by: David E. Box <david.e.box@linux.intel.com>

> =C2=A0
> =C2=A0	if (pmc_idx !=3D PMC_IDX_MAIN) {
> =C2=A0		/*
>=20
> base-commit: 2f87d0916ce0d2925cedbc9e8f5d6291ba2ac7b2



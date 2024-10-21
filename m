Return-Path: <linux-kernel+bounces-374567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 312969A6C19
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A45251F2282F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E55A1F9416;
	Mon, 21 Oct 2024 14:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cjjJYK1W"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3481D1F4D
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 14:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729520967; cv=none; b=RvCCz8kNSm2d1cUs3eGVHjgs9FO6Fpr+V3q//sUCtcFFJMYpmz8QLpgugRQ2tQUhk9xhN3sSlfmqN9N6Gl3fSQ3cvmKrHgKRwBtaT/SgY1J0Sre7bD5hrYbQhZuGi1ao5mPJjq0vapw1jvHpUBx26R6t2oKipWHbteYnw+JPTXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729520967; c=relaxed/simple;
	bh=GA7QAgyEJLf3Hc0OaLNrJbjqqWhBG1F8HQXswSa3baQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cHgtLAGtECL0E1MHJG6Q9g/n3+cuVt4XVnYFbO/IDyjfltI4BpWSdLHj5SQYS7I0ww+WooU8FQ/d9qtUyJVUrZ+NEebahO4fWSYEGT5yGf/BmQSAYeGBEGEU9/W5rQCuUSmSAVQ9pLjTKG10/1rnuJFlOUJBQ/ML2b9QgNqKfLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cjjJYK1W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729520964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VapBOBa85yh15XenK9DbBsdsuyjEprD0F60+i1INC8c=;
	b=cjjJYK1Wkkv6DmI+4VTQWdC13ZZfdBr0PSx14fLwrbhdfryQ0dzn4hP04hrmyx5OPUKGbA
	HBD9+4H8KfTy08sfxp1G+DStz/AIWDidJBjUIw0gmbrYRgbBV3VWCHSZOz8He8TR/VDEAf
	kviJIwLaNoWyB0lF8ycQPkY/r4zUqlw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-TFPMmqOHNT2X0_EXvujQgQ-1; Mon, 21 Oct 2024 10:29:23 -0400
X-MC-Unique: TFPMmqOHNT2X0_EXvujQgQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a9a0ac0e554so569289566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 07:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729520962; x=1730125762;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VapBOBa85yh15XenK9DbBsdsuyjEprD0F60+i1INC8c=;
        b=WfNHW9l15zua/FqXZknEjZXOuXnJA0rUjBgcDIyJnqDIO1IYemYjbjmOrnQT4Vfuvz
         g1LYEUUurfqP+oJo1fJw9z76xg3uOCVIl2FiYGJIkFvRG4jmsAmHj0Jm2C/7IWFHOgqL
         QXl3EcF9NoUVWA6Q87UYxjjxlU8Jg2pIvWuCUjz3ZnJJV0Pu5jX0FGpDs/3IWm24Lb0C
         HOZ/y3mzmQziD5IKrqJrmW+jLMxnDsyxxf4oKy3NKuxM72RUT/2HaMslOE4tHtTgQUv1
         yWqaHUWuXiUrmVcfr6Cj5viZlMFd2o+y2AbRXEDfJ5/Mvd77IBQRzpor4kQ2kfQeCAwZ
         W46Q==
X-Forwarded-Encrypted: i=1; AJvYcCUt8t7f/Y2L8Hm3a5pAdspNP5HOdcbcA2f3TeeuXTdG3IWHciWtZYWPOHz2j4aj7AX2Tux69OYbvHk9c+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfoaalFA99Ptk4yczy5gcJ8SHI9/nbtX1WrLKMfqRA+7FSHcRT
	E+eGzprs+OKyS0tUiAzMcf2oFyDnb6cPXDVmsRodO/vQlvKiyV3ALO8lfFdqlE71C+BelWBNnRX
	aUXYMGzPhUrpVOOqFmSdW397ciRa3oiNoLpIFERs977aQf+nQvP4e0w/DX7c2yQ==
X-Received: by 2002:a17:906:258b:b0:a9a:662f:ff4a with SMTP id a640c23a62f3a-a9a662fffc0mr1203997566b.0.1729520961742;
        Mon, 21 Oct 2024 07:29:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCOP15FDgve9KhLKYHvT/rHV2iADKOD34MgoX7bEFTxVk+PCTNxMTDxqkyYnbWaOKu+QJgDg==
X-Received: by 2002:a17:906:258b:b0:a9a:662f:ff4a with SMTP id a640c23a62f3a-a9a662fffc0mr1203995066b.0.1729520961338;
        Mon, 21 Oct 2024 07:29:21 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91370647sm208982766b.98.2024.10.21.07.29.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 07:29:20 -0700 (PDT)
Message-ID: <6e079de9-dca3-4f14-ba33-3a68327c91f0@redhat.com>
Date: Mon, 21 Oct 2024 16:29:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] platform/x86/intel/pmc: Fix pmc_core_iounmap to call
 iounmap for valid addresses
To: Vamsi Krishna Brahmajosyula <vamsikrishna.brahmajosyula@gmail.com>,
 irenic.rajneesh@gmail.com, ilpo.jarvinen@linux.intel.com,
 david.e.box@linux.intel.com
Cc: skhan@linuxfoundation.org, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241018104958.14195-1-vamsikrishna.brahmajosyula@gmail.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241018104958.14195-1-vamsikrishna.brahmajosyula@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 18-Oct-24 12:49 PM, Vamsi Krishna Brahmajosyula wrote:
> 50c6dbdfd introduced a WARN when adrress ranges of iounmap are
> invalid. On Thinkpad P1 Gen 7 (Meteor Lake-P) this caused the
> following warning to appear.
> 
> WARNING: CPU: 7 PID: 713 at arch/x86/mm/ioremap.c:461 iounmap+0x58/0x1f0
> Modules linked in: rfkill(+) snd_timer(+) fjes(+) snd soundcore intel_pmc_core(+)
> int3403_thermal(+) int340x_thermal_zone intel_vsec pmt_telemetry acpi_pad pmt_class
> acpi_tad int3400_thermal acpi_thermal_rel joydev loop nfnetlink zram xe drm_suballoc_helper
> nouveau i915 mxm_wmi drm_ttm_helper gpu_sched drm_gpuvm drm_exec drm_buddy i2c_algo_bit
> crct10dif_pclmul crc32_pclmul ttm crc32c_intel polyval_clmulni rtsx_pci_sdmmc ucsi_acpi
> polyval_generic mmc_core hid_multitouch drm_display_helper ghash_clmulni_intel typec_ucsi
> nvme sha512_ssse3 video sha256_ssse3 nvme_core intel_vpu sha1_ssse3 rtsx_pci cec typec
> nvme_auth i2c_hid_acpi i2c_hid wmi pinctrl_meteorlake serio_raw ip6_tables ip_tables fuse
> CPU: 7 UID: 0 PID: 713 Comm: (udev-worker) Not tainted 6.12.0-rc2iounmap+ #42
> Hardware name: LENOVO 21KWCTO1WW/21KWCTO1WW, BIOS N48ET19W (1.06 ) 07/18/2024
> RIP: 0010:iounmap+0x58/0x1f0
> Code: 85 6a 01 00 00 48 8b 05 e6 e2 28 04 48 39 c5 72 19 eb 26 cc cc cc 48 ba 00 00 00 00 00 00 32 00 48 8d 44 02 ff 48 39 c5 72 23 <0f> 0b 48 83 c4 08 5b 5d 41 5c c3 cc cc cc cc 48 ba 00 00 00 00 00
> RSP: 0018:ffff888131eff038 EFLAGS: 00010207
> RAX: ffffc90000000000 RBX: 0000000000000000 RCX: ffff888e33b80000
> RDX: dffffc0000000000 RSI: ffff888e33bc29c0 RDI: 0000000000000000
> RBP: 0000000000000000 R08: ffff8881598a8000 R09: ffff888e2ccedc10
> R10: 0000000000000003 R11: ffffffffb3367634 R12: 00000000fe000000
> R13: ffff888101d0da28 R14: ffffffffc2e437e0 R15: ffff888110b03b28
> FS:  00007f3c1d4b3980(0000) GS:ffff888e33b80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
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
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 83 58 0f 00 f7 d8 64 89 01 48
> RSP: 002b:00007ffe6309db38 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> RAX: ffffffffffffffda RBX: 0000557c212550a0 RCX: 00007f3c1d6d155d
> RDX: 0000000000000000 RSI: 00007f3c1cd943bd RDI: 0000000000000025
> RBP: 00007ffe6309dbf0 R08: 00007f3c1d7c7b20 R09: 00007ffe6309db80
> R10: 0000557c21255270 R11: 0000000000000246 R12: 00007f3c1cd943bd
> R13: 0000000000020000 R14: 0000557c21255c80 R15: 0000557c21255240
> </TASK>
> 
> no_free_ptr(tmp_ssram) sets tmp_ssram NULL while assigning ssram.
> pmc_core_iounmap calls iounmap unconditionally causing the above
> warning to appear during boot.
> 
> Fix it by checking for a valid address before calling iounmap.
> 
> Also in the function pmc_core_ssram_get_pmc return -ENOMEM when
> ioremap fails similar to other instances in the file.
> 
> Fixes: a01486dc4bb1 ("platform/x86/intel/pmc: Cleanup SSRAM discovery")
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: David E. Box <david.e.box@linux.intel.com>
> Signed-off-by: Vamsi Krishna Brahmajosyula <vamsikrishna.brahmajosyula@gmail.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans




> ---
> v3: Added Reviewed-by received in v1
> v2: Updated commit message based on review comments (David E. Box)
> ---
>  drivers/platform/x86/intel/pmc/core_ssram.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/core_ssram.c b/drivers/platform/x86/intel/pmc/core_ssram.c
> index c259c96b7dfd..8504154b649f 100644
> --- a/drivers/platform/x86/intel/pmc/core_ssram.c
> +++ b/drivers/platform/x86/intel/pmc/core_ssram.c
> @@ -29,7 +29,7 @@
>  #define LPM_REG_COUNT		28
>  #define LPM_MODE_OFFSET		1
> 
> -DEFINE_FREE(pmc_core_iounmap, void __iomem *, iounmap(_T));
> +DEFINE_FREE(pmc_core_iounmap, void __iomem *, if (_T) iounmap(_T))
> 
>  static u32 pmc_core_find_guid(struct pmc_info *list, const struct pmc_reg_map *map)
>  {
> @@ -262,6 +262,8 @@ pmc_core_ssram_get_pmc(struct pmc_dev *pmcdev, int pmc_idx, u32 offset)
> 
>  	ssram_base = ssram_pcidev->resource[0].start;
>  	tmp_ssram = ioremap(ssram_base, SSRAM_HDR_SIZE);
> +	if (!tmp_ssram)
> +		return -ENOMEM;
> 
>  	if (pmc_idx != PMC_IDX_MAIN) {
>  		/*
> 
> base-commit: 4d939780b70592e0f4bc6c397e52e518f8fb7916
> --
> 2.47.0
> 



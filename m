Return-Path: <linux-kernel+bounces-433347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD899E5749
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 14:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11A4116D3D4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F35A218E9F;
	Thu,  5 Dec 2024 13:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdiJo0dm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0931DED77
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 13:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733405508; cv=none; b=Qaw1AahiNUIkDemkWrJykoz1BXnNmNHCdTl4vCTIL5T9z134beaMyeMs7ppvYfC8g6l/jAj47xIu7vNHuQ9udjPc/9odb4dwNwZVPCNdjHeKYJRL95zfw0VbpVmWxMoX6sZqUVU9+Tp68nM4QMmbsE+vU0kmofnb3Zvh68ZeO7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733405508; c=relaxed/simple;
	bh=Op/DB6ysmIo5E1AItBOhOb/hOmUr1Ei/U42PewlnsN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvTHso3W7LH6Ot1s7fnj93VJqXrNrPSADgxPa05fUeKw+lEq/meDNKKFqq0zp0DFr8blLsMltjjo9aZZWPgDdvIBO0gHFRYqYEEfO8c0u939ju6ihvNMvnkS1tefDvEt2PfIa0suxxtEJXSMnqpgGqPnGz1jPIwz7uRR9r12qds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdiJo0dm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A1DC4CED1;
	Thu,  5 Dec 2024 13:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733405507;
	bh=Op/DB6ysmIo5E1AItBOhOb/hOmUr1Ei/U42PewlnsN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NdiJo0dm8ReA27KqBJdkMYoMHkb6W4T80bcyXZuujvVr7Vd/WMTRsP+fTPcKc8paC
	 1/cmDYX8LVyij7pa9kav+grajswBOSUQEscbD4MGRI4qMPHi+2MuSPojxcwdVsPG1Z
	 5pzN4GyrKpDwT6CQLl9MGUl1Nx1sD3X91ls9Q/Cygu6w6NqbuNQkzTCePcHR5zo9qp
	 2E8e+5xh7T5NZC1SVYMCqOOydAreaTxKGukZVu7Wp4EDIz49SvOjWvDXjmCm6Xg3J9
	 pQJqjcfTzBT0IVUdiFys4GFb0WeQjP4gX/E/k1igBckZMwNDQEC5ZNy4tFlnygrVAX
	 aWAWf/HVDTpKA==
Date: Thu, 5 Dec 2024 14:31:42 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Ning Sun <ning.sun@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	tboot-devel@lists.sourceforge.net
Subject: Re: [PATCH 3/4] x86/boot: split parsing of boot_params into a helper
 function
Message-ID: <Z1GrPjyFQvhHYIIm@gmail.com>
References: <20241203112525.591496-1-rppt@kernel.org>
 <20241203112525.591496-4-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203112525.591496-4-rppt@kernel.org>


* Mike Rapoport <rppt@kernel.org> wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Makes setup_arch a bit easier to comprehend.
> 
> No functional changes.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/x86/kernel/setup.c | 72 +++++++++++++++++++++++------------------
>  1 file changed, 41 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index d299fe5bda25..d4bb9a2e8f15 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -426,6 +426,42 @@ static void __init parse_setup_data(void)
>  	}
>  }
>  
> +static void __init parse_boot_params(void)
> +{
> +	ROOT_DEV = old_decode_dev(boot_params.hdr.root_dev);
> +	screen_info = boot_params.screen_info;
> +	edid_info = boot_params.edid_info;
> +#ifdef CONFIG_X86_32
> +	apm_info.bios = boot_params.apm_bios_info;
> +	ist_info = boot_params.ist_info;
> +#endif
> +	saved_video_mode = boot_params.hdr.vid_mode;
> +	bootloader_type = boot_params.hdr.type_of_loader;
> +	if ((bootloader_type >> 4) == 0xe) {
> +		bootloader_type &= 0xf;
> +		bootloader_type |= (boot_params.hdr.ext_loader_type+0x10) << 4;
> +	}
> +	bootloader_version  = bootloader_type & 0xf;
> +	bootloader_version |= boot_params.hdr.ext_loader_ver << 4;
> +
> +#ifdef CONFIG_BLK_DEV_RAM
> +	rd_image_start = boot_params.hdr.ram_size & RAMDISK_IMAGE_START_MASK;
> +#endif
> +#ifdef CONFIG_EFI
> +	if (!strncmp((char *)&boot_params.efi_info.efi_loader_signature,
> +		     EFI32_LOADER_SIGNATURE, 4)) {
> +		set_bit(EFI_BOOT, &efi.flags);
> +	} else if (!strncmp((char *)&boot_params.efi_info.efi_loader_signature,
> +		     EFI64_LOADER_SIGNATURE, 4)) {
> +		set_bit(EFI_BOOT, &efi.flags);
> +		set_bit(EFI_64BIT, &efi.flags);
> +	}
> +#endif
> +
> +	if (!boot_params.hdr.root_flags)
> +		root_mountflags &= ~MS_RDONLY;
> +}
> +
>  static void __init memblock_x86_reserve_range_setup_data(void)
>  {
>  	struct setup_indirect *indirect;
> @@ -803,35 +839,11 @@ void __init setup_arch(char **cmdline_p)
>  
>  	setup_olpc_ofw_pgd();
>  
> -	ROOT_DEV = old_decode_dev(boot_params.hdr.root_dev);
> -	screen_info = boot_params.screen_info;
> -	edid_info = boot_params.edid_info;
> -#ifdef CONFIG_X86_32
> -	apm_info.bios = boot_params.apm_bios_info;
> -	ist_info = boot_params.ist_info;
> -#endif
> -	saved_video_mode = boot_params.hdr.vid_mode;
> -	bootloader_type = boot_params.hdr.type_of_loader;
> -	if ((bootloader_type >> 4) == 0xe) {
> -		bootloader_type &= 0xf;
> -		bootloader_type |= (boot_params.hdr.ext_loader_type+0x10) << 4;
> -	}
> -	bootloader_version  = bootloader_type & 0xf;
> -	bootloader_version |= boot_params.hdr.ext_loader_ver << 4;
> -
> -#ifdef CONFIG_BLK_DEV_RAM
> -	rd_image_start = boot_params.hdr.ram_size & RAMDISK_IMAGE_START_MASK;
> -#endif
> -#ifdef CONFIG_EFI
> -	if (!strncmp((char *)&boot_params.efi_info.efi_loader_signature,
> -		     EFI32_LOADER_SIGNATURE, 4)) {
> -		set_bit(EFI_BOOT, &efi.flags);
> -	} else if (!strncmp((char *)&boot_params.efi_info.efi_loader_signature,
> -		     EFI64_LOADER_SIGNATURE, 4)) {
> -		set_bit(EFI_BOOT, &efi.flags);
> -		set_bit(EFI_64BIT, &efi.flags);
> -	}
> -#endif
> +	/*
> +	 * Translate the fields of struct boot_param into global variables

s/struct boot_param
 /'struct boot_param'

> +	 * represting these parameters.

Typo...

> +	 */
> +	parse_boot_params();

Also, why not move this explanatory comment to the definition of the new 
helper function?

Thanks,

	Ingo


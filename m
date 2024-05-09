Return-Path: <linux-kernel+bounces-174378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF2C8C0DDE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 11:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6CD328484D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 09:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588D114AD24;
	Thu,  9 May 2024 09:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ij5teho5"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0090614A4EF
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 09:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715248578; cv=none; b=eWtEYOKSxEhqW73g/RF1oVtPBojSTf3NYrO+zqeEgQZm+bJ5/+CR9xOxi8JpqrkVMjCEmwEbT1D7nNjC1eybH7bHlwe2UBWJvR2FjyT//9WHnyctGUgb5q/m6+XX3SnXT4iVTuVrDd7u2MZQ28mR2EeHh7/Nhb8lTFwXxb5xuDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715248578; c=relaxed/simple;
	bh=kkjEihY+JrbuXzccOQshi6V9Y4jUOo4YzRmV+iQdXFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipxCuLROrDHxxaQ14ZGub+ZivmYBunGmucASdVEP6YYNuOcpEVXbf02kf6vUt7BDLUFXMBlQuF6JWuButjl4G4y6mkITthv47qC1Smcj0U2myo3iHu2GT2o98HNyktmKErqVVxv0furwNjswlsaBu6OlS4GIhouF8DD6dqTLDjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ij5teho5; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 9 May 2024 17:56:11 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715248574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eavQZFD4au3dlPwrV1ymL1bS61CYH03uO5yiejStr2A=;
	b=Ij5teho5U1KSmt4XbjvZiGl0K3hmrd0r3eKQgIMljouTYknOOI+CObgps9hz9B91cKKnTZ
	fbZuHkgVTgAEHmRoeUN43EBPkou5m/e2c0EQDfXccD73atIomUt0SUSKRAWlRoVuD1oOIi
	Aa++DYFcUXN2m0rke1ZWIsyumYluch8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ruirui Yang <ruirui.yang@linux.dev>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, rafael@kernel.org,
	hpa@zytor.com, peterz@infradead.org, adrian.hunter@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com,
	rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
	michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
	bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
	jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] efi/x86: Fix EFI memory map corruption with kexec
Message-ID: <Zjydu25Z26dH81NX@darkstar.users.ipa.redhat.com>
References: <cover.1712694667.git.ashish.kalra@amd.com>
 <cover.1714148366.git.ashish.kalra@amd.com>
 <6dfe98fb95d7193ba2d692a2b6900a4d5d73db26.1714148366.git.ashish.kalra@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dfe98fb95d7193ba2d692a2b6900a4d5d73db26.1714148366.git.ashish.kalra@amd.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 26, 2024 at 04:33:48PM +0000, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> With SNP guest kexec observe the following efi memmap corruption :
> 
> [    0.000000] efi: EFI v2.7 by EDK II
> [    0.000000] efi: SMBIOS=0x7e33f000 SMBIOS 3.0=0x7e33d000 ACPI=0x7e57e000 ACPI 2.0=0x7e57e014 MEMATTR=0x7cc3c018 Unaccepted=0x7c09e018
> [    0.000000] efi: [Firmware Bug]: Invalid EFI memory map entries:
> [    0.000000] efi: mem03: [type=269370880|attr=0x0e42100e42180e41] range=[0x0486200e41038c18-0x200e898a0eee713ac17] (invalid)
> [    0.000000] efi: mem04: [type=12336|attr=0x0e410686300e4105] range=[0x100e420000000176-0x8c290f26248d200e175] (invalid)
> [    0.000000] efi: mem06: [type=1124304408|attr=0x000030b400000028] range=[0x0e51300e45280e77-0xb44ed2142f460c1e76] (invalid)
> [    0.000000] efi: mem08: [type=68|attr=0x300e540583280e41] range=[0x0000011affff3cd8-0x486200e54b38c0bcd7] (invalid)
> [    0.000000] efi: mem10: [type=1107529240|attr=0x0e42280e41300e41] range=[0x300e41058c280e42-0x38010ae54c5c328ee41] (invalid)
> [    0.000000] efi: mem11: [type=189335566|attr=0x048d200e42038e18] range=[0x0000318c00000048-0xe42029228ce4200047] (invalid)
> [    0.000000] efi: mem12: [type=239142534|attr=0x0000002400000b4b] range=[0x0e41380e0a7d700e-0x80f26238f22bfe500d] (invalid)
> [    0.000000] efi: mem14: [type=239207055|attr=0x0e41300e43380e0a] range=[0x8c280e42048d200e-0xc70b028f2f27cc0a00d] (invalid)
> [    0.000000] efi: mem15: [type=239210510|attr=0x00080e660b47080e] range=[0x0000324c0000001c-0xa78028634ce490001b] (invalid)
> [    0.000000] efi: mem16: [type=4294848528|attr=0x0000329400000014] range=[0x0e410286100e4100-0x80f252036a218f20ff] (invalid)
> [    0.000000] efi: mem19: [type=2250772033|attr=0x42180e42200e4328] range=[0x41280e0ab9020683-0xe0e538c28b39e62682] (invalid)
> [    0.000000] efi: mem20: [type=16|   |  |  |  |  |  |  |  |  |   |WB|  |WC|  ] range=[0x00000008ffff4438-0xffff44340090333c437] (invalid)
> [    0.000000] efi: mem22: [Reserved    |attr=0x000000c1ffff4420] range=[0xffff442400003398-0x1033a04240003f397] (invalid)
> [    0.000000] efi: mem23: [type=1141080856|attr=0x080e41100e43180e] range=[0x280e66300e4b280e-0x440dc5ee7141f4c080d] (invalid)
> [    0.000000] efi: mem25: [Reserved    |attr=0x0000000affff44a0] range=[0xffff44a400003428-0x1034304a400013427] (invalid)
> [    0.000000] efi: mem28: [type=16|   |  |  |  |  |  |  |  |  |   |WB|  |WC|  ] range=[0x0000000affff4488-0xffff448400b034bc487] (invalid)
> [    0.000000] efi: mem30: [Reserved    |attr=0x0000000affff4470] range=[0xffff447400003518-0x10352047400013517] (invalid)
> [    0.000000] efi: mem33: [type=16|   |  |  |  |  |  |  |  |  |   |WB|  |WC|  ] range=[0x0000000affff4458-0xffff445400b035ac457] (invalid)
> [    0.000000] efi: mem35: [type=269372416|attr=0x0e42100e42180e41] range=[0x0486200e44038c18-0x200e8b8a0eee823ac17] (invalid)
> [    0.000000] efi: mem37: [type=2351435330|attr=0x0e42100e42180e42] range=[0x470783380e410686-0x2002b2a041c2141e685] (invalid)
> [    0.000000] efi: mem38: [type=1093668417|attr=0x100e420000000270] range=[0x42100e42180e4220-0xfff366a4e421b78c21f] (invalid)
> [    0.000000] efi: mem39: [type=76357646|attr=0x180e42200e42280e] range=[0x0e410686300e4105-0x4130f251a0710ae5104] (invalid)
> [    0.000000] efi: mem40: [type=940444268|attr=0x0e42200e42280e41] range=[0x180e42200e42280e-0x300fc71c300b4f2480d] (invalid)
> [    0.000000] efi: mem41: [MMIO        |attr=0x8c280e42048d200e] range=[0xffff479400003728-0x42138e0c87820292727] (invalid)
> [    0.000000] efi: mem42: [type=1191674680|attr=0x0000004c0000000b] range=[0x300e41380e0a0246-0x470b0f26238f22b8245] (invalid)
> [    0.000000] efi: mem43: [type=2010|attr=0x0301f00e4d078338] range=[0x45038e180e42028f-0xe4556bf118f282528e] (invalid)
> [    0.000000] efi: mem44: [type=1109921345|attr=0x300e44000000006c] range=[0x44080e42100e4218-0xfff39254e42138ac217] (invalid)
> ...
> 
> This EFI memap corruption is happening with efi_arch_mem_reserve() invocation in case of kexec boot.
> 
> ( efi_arch_mem_reserve() is invoked with the following call-stack: )
> 
> [    0.310010]  efi_arch_mem_reserve+0xb1/0x220
> [    0.311382]  efi_mem_reserve+0x36/0x60
> [    0.311973]  efi_bgrt_init+0x17d/0x1a0
> [    0.313265]  acpi_parse_bgrt+0x12/0x20
> [    0.313858]  acpi_table_parse+0x77/0xd0
> [    0.314463]  acpi_boot_init+0x362/0x630
> [    0.315069]  setup_arch+0xa88/0xf80
> [    0.315629]  start_kernel+0x68/0xa90
> [    0.316194]  x86_64_start_reservations+0x1c/0x30
> [    0.316921]  x86_64_start_kernel+0xbf/0x110
> [    0.317582]  common_startup_64+0x13e/0x141
> 
> efi_arch_mem_reserve() calls efi_memmap_alloc() to allocate memory for
> EFI memory map and due to early allocation it uses memblock allocation.
> 
> Later during boot, efi_enter_virtual_mode() calls kexec_enter_virtual_mode()
> in case of a kexec-ed kernel boot.
> 
> This function kexec_enter_virtual_mode() installs the new EFI memory map by
> calling efi_memmap_init_late() which remaps the efi_memmap physically allocated
> in efi_arch_mem_reserve(), but this remapping is still using memblock allocation.
> 
> Subsequently, when memblock is freed later in boot flow, this remapped
> efi_memmap will have random corruption (similar to a use-after-free scenario).
> 
> The corrupted EFI memory map is then passed to the next kexec-ed kernel
> which causes a panic when trying to use the corrupted EFI memory map.
> 
> Fix this EFI memory map corruption by skipping efi_arch_mem_reserve() for kexec.
> 
> Additionally, skipping this function for kexec altogther makes sense
> as for kexec use case need to use the the EFI memmap passed from first
> kernel via setup_data and avoid any additional EFI memory map
> additions/updates.
> 
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  arch/x86/platform/efi/quirks.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> index f0cc00032751..af7126d9c540 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -258,6 +258,26 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
>  	int num_entries;
>  	void *new;
>  
> +	/*
> +	 * efi_arch_mem_reserve() calls efi_memmap_alloc() to allocate memory for
> +	 * EFI memory map and due to early allocation it uses memblock allocation.
> +	 * Later during boot, efi_enter_virtual_mode() calls kexec_enter_virtual_mode()
> +	 * in case of a kexec-ed kernel boot. This function kexec_enter_virtual_mode()
> +	 * installs the new EFI memory map by calling efi_memmap_init_late() which
> +	 * remaps the efi_memmap physically allocated here in efi_arch_mem_reserve(),
> +	 * but this remapping is still using memblock allocation.
> +	 * Subsequently, when memblock is freed later in boot flow, this remapped
> +	 * efi_memmap will have random corruption (similar to a use-after-free scenario).
> +	 * The corrupted EFI memory map is then passed to the next kexec-ed kernel
> +	 * which causes a panic when trying to use the corrupted EFI memory map.
> +	 * Additionally, skipping this function for kexec altogther makes sense
> +	 * as for kexec use case need to use the the EFI memmap passed from first
> +	 * kernel via setup_data and avoid any additional EFI memory map
> +	 * additions/updates.
> +	 */
> +	if (efi_setup)
> +		return;
> +

efi_mem_reserve is used to reserve boot service memory eg. bgrt, but
it is not necessary for kexec boot, as there are no boot services in
kexec reboot at all after the 1st kernel ExitBootServices().

The UEFI memmap passed to kexec kernel includes not only the runtime
service memory map but also the boot service memory ranges which were
reserved by the 1st kernel with efi_mem_reserve, and those boot service
memory ranges have already been marked "EFI_MEMORY_RUNTIME" attribute. 

Take example of bgrt, the saved memory is there only for people to check
the bgrt image info via /sys/firmware/acpi/bgrt/*, and it is not used in
early boot phase by boot services.

Above is the reason why the efi_mem_reserve can be skipped for kexec
booting.  But as I suggested before I personally think that checking
EFI_MEMORY_RUNTIME attribute set or not looks better than checking
efi_setup.

>  	if (efi_mem_desc_lookup(addr, &md) ||
>  	    md.type != EFI_BOOT_SERVICES_DATA) {
>  		pr_err("Failed to lookup EFI memory descriptor for %pa\n", &addr);
> -- 
> 2.34.1
> 
> 


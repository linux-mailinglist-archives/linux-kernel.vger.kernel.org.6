Return-Path: <linux-kernel+bounces-441311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B239ECCA3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50EE5165138
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5432123FD1E;
	Wed, 11 Dec 2024 12:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hxqi7iJi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BEF23FD00
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733921772; cv=none; b=cP0q06qM8eHz/HqkYAEhEdhVa0vKyRZ9HwLu07uYwYxFTQdXIJmHwZRLPlFWqyW/Iixm0celPHrjLUAgGGYXK5irRig1yIwzFrYw8IRfAxfhuaF8+vYCusBIY+/Hx3Pu0ckadEbyi4a4ssKtdfru/qEcDXHvwoh/hrzC7swy0pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733921772; c=relaxed/simple;
	bh=oNtxG8sMGJj0/38SDJ32RqpzGDghXwShWI9ef5dnXBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzSN534s72uF75yVFfMAxopPXAOV06b7bcCds+YSwUTmdyGOZ4HbM05LdxEC/XtSRaqbJoQ298wBuXMckxR5vb9AuLh2F4gimt4Q+q9rMDuMiB0S8U4LudujPWabMsm177eRjt3UXKXl4Riu+Rgy42GJMPfcATfTG5edQb2Ve6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hxqi7iJi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733921769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qd9NakjpvIytA6vjwOGgInJVtxHEb9hPMV7KW579E9c=;
	b=Hxqi7iJir4/xTQWBWiPJUF0bs+gWA5Utj5xlAEtxh/K4h1cQtMhbh4zcQ758Wu7savej4O
	tltcaF76zQ6Vu8dBsaMDroSfr9iMjY6qjsIEoDQ+pvV+R/UHvwzs+Mj0OXmDhOD7vl91ag
	2koyqRLXQggpnTB855+VOymlqADlEl0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-5w0geDonMzCS8396TgF_XQ-1; Wed,
 11 Dec 2024 07:56:06 -0500
X-MC-Unique: 5w0geDonMzCS8396TgF_XQ-1
X-Mimecast-MFC-AGG-ID: 5w0geDonMzCS8396TgF_XQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61670195609D;
	Wed, 11 Dec 2024 12:56:04 +0000 (UTC)
Received: from localhost (unknown [10.72.112.3])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 921081956048;
	Wed, 11 Dec 2024 12:56:02 +0000 (UTC)
Date: Wed, 11 Dec 2024 20:55:52 +0800
From: Baoquan He <bhe@redhat.com>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>, Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v6 6/7] x86/crash: pass dm crypt keys to kdump kernel
Message-ID: <Z1mL2KBcRskFlffk@MiWiFi-R3L-srv>
References: <20241029055223.210039-1-coxu@redhat.com>
 <20241029055223.210039-7-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029055223.210039-7-coxu@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 10/29/24 at 01:52pm, Coiby Xu wrote:
> 1st kernel will build up the kernel command parameter dmcryptkeys as
> similar to elfcorehdr to pass the memory address of the stored info of
> dm crypt key to kdump kernel.
> 
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  arch/x86/kernel/crash.c           | 20 ++++++++++++++++++--
>  arch/x86/kernel/kexec-bzimage64.c |  7 +++++++
>  2 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 340af8155658..99d50c31db02 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -278,6 +278,7 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
>  				 unsigned long long mend)
>  {
>  	unsigned long start, end;
> +	int ret;
>  
>  	cmem->ranges[0].start = mstart;
>  	cmem->ranges[0].end = mend;
> @@ -286,22 +287,37 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
>  	/* Exclude elf header region */
>  	start = image->elf_load_addr;
>  	end = start + image->elf_headers_sz - 1;
> -	return crash_exclude_mem_range(cmem, start, end);
> +	ret = crash_exclude_mem_range(cmem, start, end);
> +
> +	if (ret)
> +		return ret;
> +
> +	/* Exclude dm crypt keys region */
> +	if (image->dm_crypt_keys_addr) {
> +		start = image->dm_crypt_keys_addr;
> +		end = start + image->dm_crypt_keys_sz - 1;
> +		return crash_exclude_mem_range(cmem, start, end);
> +	}
> +
> +	return ret;
>  }
>  
>  /* Prepare memory map for crash dump kernel */
>  int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
>  {
> +	unsigned int max_nr_ranges = 3;

Define a macro and add code comment to explain why this value is taken?

>  	int i, ret = 0;
>  	unsigned long flags;
>  	struct e820_entry ei;
>  	struct crash_memmap_data cmd;
>  	struct crash_mem *cmem;
>  
> -	cmem = vzalloc(struct_size(cmem, ranges, 1));
> +	cmem = vzalloc(struct_size(cmem, ranges, max_nr_ranges));
>  	if (!cmem)
>  		return -ENOMEM;
>  
> +	cmem->max_nr_ranges = max_nr_ranges;
> +
>  	memset(&cmd, 0, sizeof(struct crash_memmap_data));
>  	cmd.params = params;
>  
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index 68530fad05f7..9c94428927bd 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -76,6 +76,10 @@ static int setup_cmdline(struct kimage *image, struct boot_params *params,
>  	if (image->type == KEXEC_TYPE_CRASH) {
>  		len = sprintf(cmdline_ptr,
>  			"elfcorehdr=0x%lx ", image->elf_load_addr);
> +
> +		if (image->dm_crypt_keys_addr != 0)
> +			len += sprintf(cmdline_ptr + len,
> +					"dmcryptkeys=0x%lx ", image->dm_crypt_keys_addr);
>  	}
>  	memcpy(cmdline_ptr + len, cmdline, cmdline_len);
>  	cmdline_len += len;
> @@ -441,6 +445,9 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
>  		ret = crash_load_segments(image);
>  		if (ret)
>  			return ERR_PTR(ret);
> +		ret = crash_load_dm_crypt_keys(image);
> +		if (ret)
> +			pr_debug("Either no dm crypt key or error to retrieve the dm crypt key\n");

If it's error, do we need change ti to pr_debug?
>  	}
>  #endif
>  
> -- 
> 2.47.0
> 



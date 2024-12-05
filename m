Return-Path: <linux-kernel+bounces-433349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B00169E574F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 14:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 908951883391
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D093B218AD1;
	Thu,  5 Dec 2024 13:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6uLUiP7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7A11C3318
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 13:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733405585; cv=none; b=b+gSrHorIwd7v8BR4bKMJCEl5UYjQCAiijHn4tvLUoRJYFDf4z4cUZ2DKCRfPmd9A8GSjR6ZpasqaAL7KsW6qPZAJ41lF4d+7ZU7E6iKyC3mivqFt7wxfOEA49nTH4gveyffSVpFusS6GsNXTH2NPzlj4CmhCN+8m9F/KkoGAS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733405585; c=relaxed/simple;
	bh=BKPpgKXKsPxA88qjG0dHh7o0xInSFG6ROTDS6QljBm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPTusXgdo10KpQBhGz58xYqaIZYneQmlt5xzXg0VXRukpxPOWnaoqcjrsPOylP7AcunOQEKoyCVPrFa6ECf4mfysXuxUvfn14WZrsCVCt3UfajFW4waglAjEpwEMP40KR3+E+0Ur4wkKoLr8b+c0zFvk292wkWk1L/pOUGGX9HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6uLUiP7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15514C4CEE0;
	Thu,  5 Dec 2024 13:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733405584;
	bh=BKPpgKXKsPxA88qjG0dHh7o0xInSFG6ROTDS6QljBm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u6uLUiP7mWr1AlOj5bDhHGYwabj2YbEpSTyR3OfSAt9zgANa7lXf6znFg1cOgy8kd
	 KaDOHbrxxLTZpm6rTlWeYV3bziOIwsufMNHhhqmazR06EVV/N7f1YnJR1wplzWfwKx
	 /wZcsO3DKTrCd3J+jatdVwAoJEzpx6YfloZe48/BonLPWup//aXF0/pgWqmnTwuIGL
	 oTc4GKQbKPz3soNZaNCc/QuohA31HqkUd4gGizochTcQZh/Jdvu+uuQz68bkkB8K3A
	 gScL9yVHkEoygNEsKmRpVXOaL/UztHlt3jf67DSlgKI3FsqIjaRwRcIcld+NL2BPwJ
	 La2Ys1wU+e6Mg==
Date: Thu, 5 Dec 2024 14:32:59 +0100
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
Subject: Re: [PATCH 2/4] x86/boot: split kernel resources setup into a helper
 function
Message-ID: <Z1Gri651igCkRVsx@gmail.com>
References: <20241203112525.591496-1-rppt@kernel.org>
 <20241203112525.591496-3-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203112525.591496-3-rppt@kernel.org>


* Mike Rapoport <rppt@kernel.org> wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Makes setup_arch a bit easier to comprehend.
> 
> No functional changes.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/x86/kernel/setup.c | 36 ++++++++++++++++++++++--------------
>  1 file changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 2383e73fc140..d299fe5bda25 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -524,6 +524,23 @@ void __init reserve_standard_io_resources(void)
>  
>  }
>  
> +static void __init setup_kernel_resources(void)
> +{
> +	code_resource.start = __pa_symbol(_text);
> +	code_resource.end = __pa_symbol(_etext)-1;
> +	rodata_resource.start = __pa_symbol(__start_rodata);
> +	rodata_resource.end = __pa_symbol(__end_rodata)-1;
> +	data_resource.start = __pa_symbol(_sdata);
> +	data_resource.end = __pa_symbol(_edata)-1;
> +	bss_resource.start = __pa_symbol(__bss_start);
> +	bss_resource.end = __pa_symbol(__bss_stop)-1;
> +
> +	insert_resource(&iomem_resource, &code_resource);
> +	insert_resource(&iomem_resource, &rodata_resource);
> +	insert_resource(&iomem_resource, &data_resource);
> +	insert_resource(&iomem_resource, &bss_resource);
> +}
> +
>  static bool __init snb_gfx_workaround_needed(void)
>  {
>  #ifdef CONFIG_PCI
> @@ -842,15 +859,6 @@ void __init setup_arch(char **cmdline_p)
>  		root_mountflags &= ~MS_RDONLY;
>  	setup_initial_init_mm(_text, _etext, _edata, (void *)_brk_end);
>  
> -	code_resource.start = __pa_symbol(_text);
> -	code_resource.end = __pa_symbol(_etext)-1;
> -	rodata_resource.start = __pa_symbol(__start_rodata);
> -	rodata_resource.end = __pa_symbol(__end_rodata)-1;
> -	data_resource.start = __pa_symbol(_sdata);
> -	data_resource.end = __pa_symbol(_edata)-1;
> -	bss_resource.start = __pa_symbol(__bss_start);
> -	bss_resource.end = __pa_symbol(__bss_stop)-1;
> -
>  	/*
>  	 * x86_configure_nx() is called before parse_early_param() to detect
>  	 * whether hardware doesn't support NX (so that the early EHCI debug
> @@ -894,11 +902,11 @@ void __init setup_arch(char **cmdline_p)
>  	tsc_early_init();
>  	x86_init.resources.probe_roms();
>  
> -	/* after parse_early_param, so could debug it */
> -	insert_resource(&iomem_resource, &code_resource);
> -	insert_resource(&iomem_resource, &rodata_resource);
> -	insert_resource(&iomem_resource, &data_resource);
> -	insert_resource(&iomem_resource, &bss_resource);
> +	/*
> +	 * Add resources for kernel text and data to the iomem_resource

Missing full stop.

> +	 * Do it eafter parse_early_param, so could debug it

Typo...

Also, this sentence isn't proper English AFAICS.

Please do not submit write-only comments...

Thanks,

	Ingo


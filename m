Return-Path: <linux-kernel+bounces-407609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FEA9C6FD2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C44A1F21B6B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A048A1DD55A;
	Wed, 13 Nov 2024 12:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V1FcSVgE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258A16088F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 12:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731502562; cv=none; b=ZgLxu1LiH3H4nqgoCzs30DHrU1f65Swq60gqJoITmNCFVhA4B7Kag+fygfp00vJPs7jcb9AmhjLb2+31e00U40/vr8mxs1MJ36Dxiz3JUCWvzJ3pKVU8+WK1HIQJNPXV+deiFVdslgp+ESZJhcRkn7p73egJtcSDU8oKoC1gg2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731502562; c=relaxed/simple;
	bh=Rw1hVZ7d3AKNZexZC/1kRGn4ufOg3lp+pAmxPNd4RPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ym67OVSnO6mQDiThOWi581wGSzUGwRplncAeZbI1m7cSamMzCLPbtm8bsLzfrcYOQzC2ufXqblhhbJ1BYkaQ2J8JhNGuZCp+Az9hdjgT2yIrU7FX76B6POPvxPSsuhX0xsd5Jel5WQv5MfedyORtd1/e4Pp7rFJ9Kfoyfqt3jjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V1FcSVgE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731502559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wdv+VVxJAX9WwJWxe+bYl+tm5LZyKAbTSEEijJF0+7E=;
	b=V1FcSVgEE4TOu+qJ4vECHlNFGZwb+3Zk+N10Won6UcHwhjj3vdGjC3IIZbqiStf103jm0Y
	FCBpq8hEon5eBLKFY2Sd3+8RurAiBlhW1KdIx8D2x/mugq2aroKvvc2nxcdv2Nwcn/zW5I
	8QjhOJIDsaeXG6E9ImYXWwmTQSr6zWA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-512-LuI3AqNeNcOWjxUiqby2YQ-1; Wed,
 13 Nov 2024 07:55:55 -0500
X-MC-Unique: LuI3AqNeNcOWjxUiqby2YQ-1
X-Mimecast-MFC-AGG-ID: LuI3AqNeNcOWjxUiqby2YQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D9B1419541A0;
	Wed, 13 Nov 2024 12:55:53 +0000 (UTC)
Received: from localhost (unknown [10.72.112.83])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 275E330000DF;
	Wed, 13 Nov 2024 12:55:51 +0000 (UTC)
Date: Wed, 13 Nov 2024 20:55:47 +0800
From: Baoquan He <bhe@redhat.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
	dyoung@redhat.com, daniel.kiper@oracle.com, noodles@fb.com,
	lijiang@redhat.com, kexec@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v3 1/2] x86/mm: rename the confusing local variable in
 early_memremap_is_setup_data()
Message-ID: <ZzSh0/i0HXDnfUof@MiWiFi-R3L-srv>
References: <20240911081615.262202-1-bhe@redhat.com>
 <20240911081615.262202-2-bhe@redhat.com>
 <20241029181101.GXZyElNXVuF6596TKG@fat_crate.local>
 <ZyGDlYsg6YWNXSVo@MiWiFi-R3L-srv>
 <8c81835b-97fe-a0b3-a860-0bbd5c0341f6@amd.com>
 <ZyL8WDTw9F3laupG@MiWiFi-R3L-srv>
 <20241101161849.GCZyT_aSMcGIXnGr1-@fat_crate.local>
 <ZyVxBbGYsEjifLgp@MiWiFi-R3L-srv>
 <20241102110618.GAZyYHquhmVJd4yM9O@fat_crate.local>
 <20241106112052.GCZytRFKTESZI8_3qD@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241106112052.GCZytRFKTESZI8_3qD@fat_crate.local>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 11/06/24 at 12:20pm, Borislav Petkov wrote:
> On Sat, Nov 02, 2024 at 12:06:18PM +0100, Borislav Petkov wrote:
> > Ok, I'll take your 2/2 next week and you can then send the cleanup ontop.
> 
> OMG what a mess this is. Please test the below before I apply it.

I finally got an available machine to test below patch, I can confirm
that without it the breakage can be reproduced stably; with below patch
applied the breakage is gone and vmcore dumping is successful.

> 
> Then, when you do the cleanup, do the following:

Will post cleanup patch later. Thanks.

> 
> - merge early_memremap_is_setup_data() with memremap_is_setup_data() into
>   a common __memremap_is_setup_data() and then add a bool early which
>   determines which memremap variant is called.
> 
> - unify the @size argument by dropping it and using a function local size.
>   What we have there now is the definition of bitrot. :-\
> 
> - replace all sizeof(*data), sizeof(struct setup_data) with a macro definition
>   above the functions to unify it properly.
> 
> What an ugly mess... :-\
> 
> ---
> From: Baoquan He <bhe@redhat.com>
> Date: Wed, 11 Sep 2024 16:16:15 +0800
> Subject: [PATCH] x86/mm: Fix a kdump kernel failure on SME system when
>  CONFIG_IMA_KEXEC=y
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> The kdump kernel is broken on SME systems with CONFIG_IMA_KEXEC=y enabled.
> Debugging traced the issue back to
> 
>   b69a2afd5afc ("x86/kexec: Carry forward IMA measurement log on kexec").
> 
> Testing was previously not conducted on SME systems with CONFIG_IMA_KEXEC
> enabled, which led to the oversight, with the following incarnation:
> 
> ...
>   ima: No TPM chip found, activating TPM-bypass!
>   Loading compiled-in module X.509 certificates
>   Loaded X.509 cert 'Build time autogenerated kernel key: 18ae0bc7e79b64700122bb1d6a904b070fef2656'
>   ima: Allocated hash algorithm: sha256
>   Oops: general protection fault, probably for non-canonical address 0xcfacfdfe6660003e: 0000 [#1] PREEMPT SMP NOPTI
>   CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0-rc2+ #14
>   Hardware name: Dell Inc. PowerEdge R7425/02MJ3T, BIOS 1.20.0 05/03/2023
>   RIP: 0010:ima_restore_measurement_list
>   Call Trace:
>    <TASK>
>    ? show_trace_log_lvl
>    ? show_trace_log_lvl
>    ? ima_load_kexec_buffer
>    ? __die_body.cold
>    ? die_addr
>    ? exc_general_protection
>    ? asm_exc_general_protection
>    ? ima_restore_measurement_list
>    ? vprintk_emit
>    ? ima_load_kexec_buffer
>    ima_load_kexec_buffer
>    ima_init
>    ? __pfx_init_ima
>    init_ima
>    ? __pfx_init_ima
>    do_one_initcall
>    do_initcalls
>    ? __pfx_kernel_init
>    kernel_init_freeable
>    kernel_init
>    ret_from_fork
>    ? __pfx_kernel_init
>    ret_from_fork_asm
>    </TASK>
>   Modules linked in:
>   ---[ end trace 0000000000000000 ]---
>   ...
>   Kernel panic - not syncing: Fatal exception
>   Kernel Offset: disabled
>   Rebooting in 10 seconds..
> 
> Adding debug printks showed that the stored addr and size of ima_kexec buffer
> are not decrypted correctly like:
> 
>   ima: ima_load_kexec_buffer, buffer:0xcfacfdfe6660003e, size:0xe48066052d5df359
> 
> Three types of setup_data info
> 
>   — SETUP_EFI,
>   - SETUP_IMA, and
>   - SETUP_RNG_SEED
> 
> are passed to the kexec/kdump kernel. Only the ima_kexec buffer
> experienced incorrect decryption. Debugging identified a bug in
> early_memremap_is_setup_data(), where an incorrect range calculation
> occurred due to the len variable in struct setup_data ended up only
> representing the length of the data field, excluding the struct's size,
> and thus leading to miscalculation.
> 
> Address a similar issue in memremap_is_setup_data() while at it.
> 
>   [ bp: Heavily massage. ]
> 
> Fixes: b3c72fc9a78e ("x86/boot: Introduce setup_indirect")
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: <stable@kernel.org>
> Link: https://lore.kernel.org/r/20240911081615.262202-3-bhe@redhat.com
> ---
>  arch/x86/mm/ioremap.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index 70b02fc61d93..8d29163568a7 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -656,7 +656,8 @@ static bool memremap_is_setup_data(resource_size_t phys_addr,
>  		paddr_next = data->next;
>  		len = data->len;
>  
> -		if ((phys_addr > paddr) && (phys_addr < (paddr + len))) {
> +		if ((phys_addr > paddr) &&
> +		    (phys_addr < (paddr + sizeof(struct setup_data) + len))) {
>  			memunmap(data);
>  			return true;
>  		}
> @@ -718,7 +719,8 @@ static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
>  		paddr_next = data->next;
>  		len = data->len;
>  
> -		if ((phys_addr > paddr) && (phys_addr < (paddr + len))) {
> +		if ((phys_addr > paddr) &&
> +		    (phys_addr < (paddr + sizeof(struct setup_data) + len))) {
>  			early_memunmap(data, sizeof(*data));
>  			return true;
>  		}
> -- 
> 2.43.0
> 
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
> 



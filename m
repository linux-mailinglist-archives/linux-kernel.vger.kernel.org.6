Return-Path: <linux-kernel+bounces-205775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D370900024
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D48A1F2295A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F1C15EFDC;
	Fri,  7 Jun 2024 10:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QR4j25i4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F77415D5AD
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 10:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717754460; cv=none; b=BjmVwfXI1lFwcYu0lO3ogiPgJG4Tty8M4i4m50dX61DfxZuT9DT627yIbD+1mSIi1itAq5XE2fYqLYvhsnHBYD84sGdYpeCmA4cbaO337hLlYcmAIUfoMyKgQUsBk4Ly4wtTm4vsCOVcOMSuaosj9mSYziMiTumutPZUdrkk/I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717754460; c=relaxed/simple;
	bh=FmBJwoatTD3ubavkLq7yAGUCYfFAazwL4EVqq/cDjuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvNpm5SunWWovVxp9BVD6kpLb6ZUh0hqMIYyWirDRHEYqgc6kXPU1cw5ccio7DapoIbaMnzBWGwm6EdS7sXDK+H2VDi6+a3dUsK6Q0JU+M2Bue7pnfOemy8es0zmPUhghKzgEg14vBcaEUssss5thbFOrYxAFuEhHvQesbWiFUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QR4j25i4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717754458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NH3oO20QFn673bgiV5dG3f+GU8g8vUS9TOFN0xj1Yvs=;
	b=QR4j25i4CcYC8ij7Mi5+p5iJZIxBfUlE1hsJaOM/o3uOhlfYbxgUtyl8J0e8E9cvOAoi8g
	WM71pNtnyzg8j5kfsh21KoxbHPePnuzdZ0ZYMSY+3fuP8qnxDtKcP2bWfpF0jVj1GARaLu
	lrqCfcQ79zRtYSvn/fNrkATocftH3o0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-xgL2DSfJMR-vi7a64Cs1NA-1; Fri,
 07 Jun 2024 06:00:54 -0400
X-MC-Unique: xgL2DSfJMR-vi7a64Cs1NA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C312F1955F34;
	Fri,  7 Jun 2024 10:00:51 +0000 (UTC)
Received: from localhost (unknown [10.72.113.124])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B87A41956089;
	Fri,  7 Jun 2024 10:00:49 +0000 (UTC)
Date: Fri, 7 Jun 2024 18:00:44 +0800
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
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 7/7] x86/crash: make the page that stores the dm crypt
 keys inaccessible
Message-ID: <ZmLaTJA6Vq1a9x5z@MiWiFi-R3L-srv>
References: <20240523050451.788754-1-coxu@redhat.com>
 <20240523050451.788754-8-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523050451.788754-8-coxu@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 05/23/24 at 01:04pm, Coiby Xu wrote:
> This adds an addition layer of protection for the saved copy of dm
> crypt key. Trying to access the saved copy will cause page fault.
> 
> Suggested-by: Pingfan Liu <kernelfans@gmail.com>
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  arch/x86/kernel/machine_kexec_64.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index b180d8e497c3..fc0a80f4254e 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -545,13 +545,34 @@ static void kexec_mark_crashkres(bool protect)
>  	kexec_mark_range(control, crashk_res.end, protect);
>  }
>  
> +static void kexec_mark_dm_crypt_keys(bool protect)
> +{
> +	unsigned long start_paddr, end_paddr;
> +	unsigned int nr_pages;
> +
> +	if (kexec_crash_image->dm_crypt_keys_addr) {
> +		start_paddr = kexec_crash_image->dm_crypt_keys_addr;
> +		end_paddr = start_paddr + kexec_crash_image->dm_crypt_keys_sz - 1;
> +		nr_pages = (PAGE_ALIGN(end_paddr) - PAGE_ALIGN_DOWN(start_paddr))/PAGE_SIZE;
> +		if (protect)
> +			set_memory_np((unsigned long)phys_to_virt(start_paddr), nr_pages);
> +		else
> +			__set_memory_prot(
> +				(unsigned long)phys_to_virt(start_paddr),
> +				nr_pages,
> +				__pgprot(_PAGE_PRESENT | _PAGE_NX | _PAGE_RW));
> +	}
> +}
> +
>  void arch_kexec_protect_crashkres(void)
>  {
>  	kexec_mark_crashkres(true);
> +	kexec_mark_dm_crypt_keys(true);

Isn't crashkernel region covering crypt keys' storing region? Do we need
mark it again specifically? Not sure if I miss anything.

>  }
>  
>  void arch_kexec_unprotect_crashkres(void)
>  {
> +	kexec_mark_dm_crypt_keys(false);
>  	kexec_mark_crashkres(false);
>  }
>  #endif
> -- 
> 2.45.0
> 



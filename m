Return-Path: <linux-kernel+bounces-184472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F078CA727
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84E281C20CEE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AA21F959;
	Tue, 21 May 2024 03:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DiMe3lGB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AE9DDD7
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716263469; cv=none; b=jHyDVtWghI4NHGQXICSzDhAzOHFd+gCGIuyaJhhXMNAkyzANvzaH61WS6jUZ0YHXs5LNwbMc/+oshYMHvyoE++3FKyhi6ls63Ed5fweOH8N07i+IxUudcIwP0WbCeWieZyIYte/Tqc6oTdrK0LRIntu2SgGCSF4SDR2JHzVdoug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716263469; c=relaxed/simple;
	bh=BCjuTKMiV0cn4O5twtOwrfBUB/gPCarjL14EkA7FQJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/M05UzTMpt0CftJRoQJTSa62CVkptdHCGrnEUX3dKlzdOTn/cxsC7hYvXvjLH2suLvgzt0Fi8lPMw/aOmu86Woz+z9WCNDcGelN4WdoMk5DJnR2vWoIw9XKKC8eyyg+p+EeQFymphhLoFl354ixF81RznJFz5XMiL4mV8R2Mqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DiMe3lGB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716263466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+1//QAX2V35y7ue97weY5s6BlfgEJ/aIsjDY5//7erc=;
	b=DiMe3lGBSS6hFwwho2bGK5dz8MFWj0FVGv2R4rJHZlSNRCAFC3ZF8iTjV4SsucHI6XzLEw
	+uXF+BGpmGQUiNJmI2azTDmypkotxMTsxfIfRbVjA/4267+GMiaFQE0p51sdpasAb7a3Lc
	gd8uOxXiYrKwVxIIuMMIIoDppXxCu3k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-ASJivBHvNIG_K8643YWBYA-1; Mon,
 20 May 2024 23:51:05 -0400
X-MC-Unique: ASJivBHvNIG_K8643YWBYA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6448429AB3E2;
	Tue, 21 May 2024 03:51:04 +0000 (UTC)
Received: from localhost (unknown [10.72.116.65])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 74E2551BF;
	Tue, 21 May 2024 03:51:03 +0000 (UTC)
Date: Tue, 21 May 2024 11:51:00 +0800
From: Baoquan He <bhe@redhat.com>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	 Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>, Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 7/7] x86/crash: make the page that stores the dm crypt
 keys inaccessible
Message-ID: <ZkwZ+PubwfDzEQ4v@MiWiFi-R3L-srv>
References: <20240425100434.198925-1-coxu@redhat.com>
 <20240425100434.198925-8-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425100434.198925-8-coxu@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 04/25/24 at 06:04pm, Coiby Xu wrote:
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

Really? Are all x86 systems having this dm_crypt_keys and need be
handled in kdump?

>  }
>  
>  void arch_kexec_unprotect_crashkres(void)
>  {
> +	kexec_mark_dm_crypt_keys(false);
>  	kexec_mark_crashkres(false);
>  }
>  #endif
> -- 
> 2.44.0
> 



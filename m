Return-Path: <linux-kernel+bounces-436626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1059E88C4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 01:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1838E1612A6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 00:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABD0DDD3;
	Mon,  9 Dec 2024 00:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="izqrPFqi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0635234
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 00:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733705579; cv=none; b=EDrLmor7DArbTBS1Ducu3Tg1khhz3uY2K3w5Ux1k9FBEycPutQjsrx1MKvRHXhJHG4rvjYjN+DHK761p5DcbiHMWUPHFDsuREbn2YIbH+53Drru07T3AW3wilPayoUfRNZjLqLUlY3VvxZgCtsYLw+r9q7wnFOKzSTxWLBwczxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733705579; c=relaxed/simple;
	bh=2Mqx28IRscEJIh6OkOgl7K2H+jNVWuIVITrM520LBro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4YBG4x3ZwCBmaWGeRcVndCHts39uzd0zlbzjy5dHtCAy1ZyJdmD0mZdTFDzN5StCkA3jYvBfBogjVYXDgJ2i67btD5wAaEL2OYrWTytYNFT8A40qmKp+r4zaYdsYWxDOfRjd8o0RMaT6XZ/u/Ng6zWlO+F3kYRMwqLDf28YGXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=izqrPFqi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733705572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NdMrVY3C3B2SlNlH22JxmNudckZuoxhVnkxDsrZIe/A=;
	b=izqrPFqiaExkvAubhuX2C401iPilLC0CvEdWGdZSONpv3T0Fe0LNHKaXVTJvfvXCIa7Vja
	iJwwaPRDo4tf2JWXGML6MyrbRO6AgqwSuNq+DOsLF6eYip6Fyk1KwitqkJL/qJbMYlQKBU
	8BBlmmsc9NY2bdObVa4IJRFnSAaX3BY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-FZ5-geIFOwCizaF9mRCYDA-1; Sun,
 08 Dec 2024 19:52:47 -0500
X-MC-Unique: FZ5-geIFOwCizaF9mRCYDA-1
X-Mimecast-MFC-AGG-ID: FZ5-geIFOwCizaF9mRCYDA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E1DC19560A3;
	Mon,  9 Dec 2024 00:52:46 +0000 (UTC)
Received: from localhost (unknown [10.72.112.3])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3151E19560A2;
	Mon,  9 Dec 2024 00:52:44 +0000 (UTC)
Date: Mon, 9 Dec 2024 08:52:39 +0800
From: Baoquan He <bhe@redhat.com>
To: Borislav Petkov <bp@alien8.de>
Cc: mingo@kernel.org, thomas.lendacky@amd.com, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v3 1/3] x86/ioremap: introduce helper to implement
 xxx_is_setup_data()
Message-ID: <Z1Y/V2lDsB3R4kfg@MiWiFi-R3L-srv>
References: <20241123114221.149383-1-bhe@redhat.com>
 <20241123114221.149383-2-bhe@redhat.com>
 <20241207160411.GAZ1Rx-9eQHH1IXOwP@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241207160411.GAZ1Rx-9eQHH1IXOwP@fat_crate.local>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 12/07/24 at 05:04pm, Borislav Petkov wrote:
> On Sat, Nov 23, 2024 at 07:42:19PM +0800, Baoquan He wrote:
> > Functions memremap_is_setup_data() and early_memremap_is_setup_data()
> > share completely the same process and handling, except of the
> > different memremap/unmap invocations.
> > 
> > So add helper __memremap_is_setup_data() to extract the common part,
> > parameter 'early' is used to decide what kind of memremap/unmap
> > APIs are called. This simplifies codes a lot by removing the duplicated
> > codes, and also removes the similar code comment above them.
> > 
> > And '__ref' is added to __memremap_is_setup_data() to suppress below
> > section mismatch warning:
> > 
> > ARNING: modpost: vmlinux: section mismatch in reference: __memremap_is_setup_data+0x5f (section: .text) ->
> > early_memunmap (section: .init.text)
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  arch/x86/mm/ioremap.c | 104 ++++++++++++++----------------------------
> >  1 file changed, 35 insertions(+), 69 deletions(-)
> 
> Some touchups ontop:
> 
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index aaf40a712b04..fe44e8180bdd 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c

Thanks for optimizing these.

> @@ -632,9 +632,9 @@ static bool memremap_is_efi_data(resource_size_t phys_addr,
>   * Examine the physical address to determine if it is boot data by checking
>   * it against the boot params setup_data chain.
>   */
> -static bool __ref __memremap_is_setup_data(resource_size_t phys_addr,
> -						bool early)
> +static bool __ref __memremap_is_setup_data(resource_size_t phys_addr, bool early)
>  {
> +	unsigned int setup_data_sz = sizeof(struct setup_data);
>  	struct setup_indirect *indirect;
>  	struct setup_data *data;
>  	u64 paddr, paddr_next;
> @@ -647,24 +647,23 @@ static bool __ref __memremap_is_setup_data(resource_size_t phys_addr,
>  			return true;
>  
>  		if (early)
> -			data = early_memremap_decrypted(paddr, sizeof(*data));
> +			data = early_memremap_decrypted(paddr, setup_data_sz);
>  		else
> -			data = memremap(paddr, sizeof(*data),
> -					MEMREMAP_WB | MEMREMAP_DEC);
> +			data = memremap(paddr, setup_data_sz, MEMREMAP_WB | MEMREMAP_DEC);
>  		if (!data) {
> -			pr_warn("failed to memremap setup_data entry\n");
> +			pr_warn("failed to remap setup_data entry\n");
>  			return false;
>  		}
>  
> -		size = sizeof(*data);
> +		size = setup_data_sz;
>  
>  		paddr_next = data->next;
>  		len = data->len;
>  
>  		if ((phys_addr > paddr) &&
> -		    (phys_addr < (paddr + sizeof(*data) + len))) {
> +		    (phys_addr < (paddr + setup_data_sz + len))) {
>  			if (early)
> -				early_memunmap(data, sizeof(*data));
> +				early_memunmap(data, setup_data_sz);
>  			else
>  				memunmap(data);
>  			return true;
> @@ -673,15 +672,14 @@ static bool __ref __memremap_is_setup_data(resource_size_t phys_addr,
>  		if (data->type == SETUP_INDIRECT) {
>  			size += len;
>  			if (early) {
> -				early_memunmap(data, sizeof(*data));
> +				early_memunmap(data, setup_data_sz);
>  				data = early_memremap_decrypted(paddr, size);
>  			} else {
>  				memunmap(data);
> -				data = memremap(paddr, size,
> -						MEMREMAP_WB | MEMREMAP_DEC);
> +				data = memremap(paddr, size, MEMREMAP_WB | MEMREMAP_DEC);
>  			}
>  			if (!data) {
> -				pr_warn("failed to memremap indirect setup_data\n");
> +				pr_warn("failed to remap indirect setup_data\n");
>  				return false;
>  			}
>  
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
> 



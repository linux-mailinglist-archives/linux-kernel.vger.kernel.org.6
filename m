Return-Path: <linux-kernel+bounces-387990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BD89B58D6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 01:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB7F91F23C51
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABFB282FE;
	Wed, 30 Oct 2024 00:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ao/Vx4mR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564A5C13C
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 00:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730249639; cv=none; b=KXxVek+ZHI7nu8cGI9PgiDkC5AuLahLiioAxZ5eTlV3PyFYc6CL1fb3HyUtWS6dWD2sS4AR7grpZVrwdy6LkZn1w4mTm9PBHoO9KRnbC38qR6NSimsWnsE3gHCg65N2OpZ6uxz4DifENq94nJ8cgiKPJVhOgSfA834GqoWS3DNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730249639; c=relaxed/simple;
	bh=gZIHW5xlucMMTF92OTkejlmYFNysbrWsEcXX1MF0Xc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Id9nYpEQDNBq4I6Udu4eVFgVpJV7cDJG9WphDOxUnkpkcp1CDR5r7yQ9ckI8u7aWZp+mKHEXtGhYblnDM3vf5cERvp08Mdo1s7AW8VZ4b4F1j/q8FYRmMJ7CROmCObrjx1PvvePGbDlPin0FBocm2SUxk/M7ErruOEw+FDkhAac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ao/Vx4mR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730249636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RysMNn00bfjiieSchZk4oQjSR3YgZyjt5uPFsZQEN1k=;
	b=ao/Vx4mRtoM3HKwlKzM4pmVQTffUuHoDPlf5cLWkTcCY8xVWx0MZZpweUCz8l7FvmLwawT
	TvnzXB7tGkQ/B38javV1eBS8/4jE+d4jPG5/QEeFovMAKc1Lxv3RnZge78XG0vfSsshVoh
	KVFOv2T0vAZxnrEC0kOTp6tMbZCzVVw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-AGGzzpJ_MseSwJEw_nko5Q-1; Tue,
 29 Oct 2024 20:53:54 -0400
X-MC-Unique: AGGzzpJ_MseSwJEw_nko5Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE0691955EAB;
	Wed, 30 Oct 2024 00:53:47 +0000 (UTC)
Received: from localhost (unknown [10.72.112.14])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E752300018D;
	Wed, 30 Oct 2024 00:53:45 +0000 (UTC)
Date: Wed, 30 Oct 2024 08:53:41 +0800
From: Baoquan He <bhe@redhat.com>
To: Borislav Petkov <bp@alien8.de>, thomas.lendacky@amd.com
Cc: linux-kernel@vger.kernel.org, dyoung@redhat.com,
	daniel.kiper@oracle.com, noodles@fb.com, lijiang@redhat.com,
	kexec@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v3 1/2] x86/mm: rename the confusing local variable in
 early_memremap_is_setup_data()
Message-ID: <ZyGDlYsg6YWNXSVo@MiWiFi-R3L-srv>
References: <20240911081615.262202-1-bhe@redhat.com>
 <20240911081615.262202-2-bhe@redhat.com>
 <20241029181101.GXZyElNXVuF6596TKG@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029181101.GXZyElNXVuF6596TKG@fat_crate.local>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 10/29/24 at 07:11pm, Borislav Petkov wrote:
> On Wed, Sep 11, 2024 at 04:16:14PM +0800, Baoquan He wrote:
> > In function early_memremap_is_setup_data(), parameter 'size' passed has
> > the same name as the local variable inside the while loop. That
> > confuses people who sometime mix up them when reading code.
> > 
> > Here rename the local variable 'size' inside while loop to 'sd_size'.
> > 
> > And also add one local variable 'sd_size' likewise in function
> > memremap_is_setup_data() to simplify code. In later patch, this can also
> > be used.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
> > ---
> >  arch/x86/mm/ioremap.c | 18 +++++++++++-------
> >  1 file changed, 11 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> > index aa7d279321ea..f1ee8822ddf1 100644
> > --- a/arch/x86/mm/ioremap.c
> > +++ b/arch/x86/mm/ioremap.c
> > @@ -640,7 +640,7 @@ static bool memremap_is_setup_data(resource_size_t phys_addr,
> 
> Huh?

Thanks for looking into this.

I ever doubted this, guess it could use the unused 'size' to avoid
warning? Noticed Tom introduced it at the beginning. It's better idea to
remove it if it's useless.

commit 8f716c9b5febf6ed0f5fedb7c9407cd0c25b2796
Author: Tom Lendacky <thomas.lendacky@amd.com>
Date:   Mon Jul 17 16:10:16 2017 -0500

    x86/mm: Add support to access boot related data in the clear

Hi Tom,

Can you help check and tell your intention why the argument 'size' is
added into early_memremap_is_setup_data() and memremap_is_setup_data().

Thanks
Baoquan

> 
> ---
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index 70b02fc61d93..e461d8e26871 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -632,8 +632,7 @@ static bool memremap_is_efi_data(resource_size_t phys_addr,
>   * Examine the physical address to determine if it is boot data by checking
>   * it against the boot params setup_data chain.
>   */
> -static bool memremap_is_setup_data(resource_size_t phys_addr,
> -				   unsigned long size)
> +static bool memremap_is_setup_data(resource_size_t phys_addr)
>  {
>  	struct setup_indirect *indirect;
>  	struct setup_data *data;
> @@ -769,7 +768,7 @@ bool arch_memremap_can_ram_remap(resource_size_t phys_addr, unsigned long size,
>  		return false;
>  
>  	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
> -		if (memremap_is_setup_data(phys_addr, size) ||
> +		if (memremap_is_setup_data(phys_addr) ||
>  		    memremap_is_efi_data(phys_addr, size))
>  			return false;
>  	}
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
> 



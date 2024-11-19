Return-Path: <linux-kernel+bounces-413784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE269D1EAB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 04:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B95C1F21E50
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 03:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6E914883C;
	Tue, 19 Nov 2024 03:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A9r98J/O"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753C81482E8
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 03:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731985656; cv=none; b=aZBsZpn8Pl2WwhraKqQmqYaksYLpIm2nCFnXe/57RGXgIC14lFI6aPj7YhQeF8O00Fnu2wkIAEIwndNOcbi05xqSDLNlhOjaj9NsAqeNExfC3IvjNtnSK0NrjcngYW03VdzKLDC+9C3BQZTipJW8085eOjmIx+oFHpp2Yl+m3yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731985656; c=relaxed/simple;
	bh=PaQ6GoC3L62wf7mnPBMJ4Lk6g+uSByeYhT3vZjLpIm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8LYBUak3X9o2ebl1NVpTaWaqdC1o6WtSA3UvJ0DqZMEQ8HW1vnGC+UuFKeTw3+Z54fWqw6YH16RQAEYlrxt5AilrcHmVZeusR80NWWzdmR2uzAGe+ytEImWQKcvemwJ2xcdop7QAI24CwgwvFgH2G1Ax/32jLG7ZwM1SB9BHcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A9r98J/O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731985653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ad3DWsTRmAh67Zw7YIt0SNlgyERHCEdV3hix+y3aMdU=;
	b=A9r98J/OHHXfIF9KqmaDRqYO9qOV4ypD3528KmMxQ1g9Ggfz3Y2K1CdCB4GyJulgIhsnD+
	Mw4VADSYGRJ2nyuEHI78NVwWMYRGM3FPwQlps1UnKd3vQsJ5cZTlkdkqFMFh7kCZZL8LH2
	8RsJi5ZecK4zG5ftohjjZoB2NS0CxH4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-6HfceLvHPpertIYlYnDhAg-1; Mon,
 18 Nov 2024 22:07:27 -0500
X-MC-Unique: 6HfceLvHPpertIYlYnDhAg-1
X-Mimecast-MFC-AGG-ID: 6HfceLvHPpertIYlYnDhAg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 685691955EE9;
	Tue, 19 Nov 2024 03:07:26 +0000 (UTC)
Received: from localhost (unknown [10.72.113.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0953930001A0;
	Tue, 19 Nov 2024 03:07:24 +0000 (UTC)
Date: Tue, 19 Nov 2024 11:07:19 +0800
From: Baoquan He <bhe@redhat.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, bp@alien8.de,
	x86@kernel.org
Subject: Re: [PATCH v2 1/2] x86/ioremap: introduce helper to implement
 xxx_is_setup_data()
Message-ID: <ZzwA53x3KYQgDbeQ@MiWiFi-R3L-srv>
References: <20241118010819.46602-1-bhe@redhat.com>
 <20241118010819.46602-2-bhe@redhat.com>
 <7cc5e26c-42fc-a700-ae19-608920cafe44@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cc5e26c-42fc-a700-ae19-608920cafe44@amd.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 11/18/24 at 09:19am, Tom Lendacky wrote:
> On 11/17/24 19:08, Baoquan He wrote:
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
> >  arch/x86/mm/ioremap.c | 108 +++++++++++++++---------------------------
> >  1 file changed, 38 insertions(+), 70 deletions(-)
> > 
> > diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> > index 8d29163568a7..68d78e2b1203 100644
> > --- a/arch/x86/mm/ioremap.c
> > +++ b/arch/x86/mm/ioremap.c
> > @@ -628,12 +628,13 @@ static bool memremap_is_efi_data(resource_size_t phys_addr,
> >  	return false;
> >  }
> >  
> > +#define SD_SIZE sizeof(struct setup_data)
> 
> Nit, I still think you should use "sizeof(*data)" in the code instead of
> creating a #define.

Thanks for reviewing, Tom.

Boris suggested this. Both is fine to me. If there is indeed a tiny
preference, I would choose SD_SIZE. It's going a bit far, but not too
far.

> 
> >  /*
> >   * Examine the physical address to determine if it is boot data by checking
> >   * it against the boot params setup_data chain.
> >   */
> > -static bool memremap_is_setup_data(resource_size_t phys_addr,
> > -				   unsigned long size)
> > +static bool __ref __memremap_is_setup_data(resource_size_t phys_addr,
> 
> Oh, I see why the __ref is needed now, because this calls an __init
> function based on the early bool.

Exactly, I explained in another thread replying to you, it could be
ignored.

> 
> While this nicely consolidates the checking, I'll let the x86
> maintainers decide whether they like that an __init function is calling
> a non __init function.
...... snip.......
> > -	return false;
> > +static bool early_memremap_is_setup_data(resource_size_t phys_addr,
> 
> This should retain the original __init reference.

OK, so you suggest they are like below, right?

static bool __ref __memremap_is_setup_data(resource_size_t phys_addr,
                                                bool early)
{
	......
}

static bool memremap_is_setup_data(resource_size_t phys_addr)
{
        return __memremap_is_setup_data(phys_addr, false);
}
 
static bool __init early_memremap_is_setup_data(resource_size_t phys_addr)
{
        return __memremap_is_setup_data(phys_addr, true);
}

I can make v3 if we all agree on this.



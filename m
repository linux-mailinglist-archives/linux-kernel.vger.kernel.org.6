Return-Path: <linux-kernel+bounces-430819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864D19E3603
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3C72857E5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8951991CD;
	Wed,  4 Dec 2024 08:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZUMJfIC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB3719309C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 08:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733302601; cv=none; b=qfoKpsgr17VC4+AyBo5JzJ4btA0jin0ZW5niv4m8L1z0GdXZKf9F3u3Mmo04D/yldlAklwbhOWx2U11GiYtSU0eK5lY+2EeCsBeHB1ZbNV0ktIn9/Vuk86oO+Cc6RVxfUjnEjUnvlFUmAtvagnPDw7jttZtYPjBpT+bPkhh/az4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733302601; c=relaxed/simple;
	bh=Yxjz03f7YodAcFNWgPYlbjlPTqBBEgCdSqNH6Yu1n2I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IB/tHSp8HY9Nts2FkrtbAKagYNFVvCFibCjSZ8moFAilqigUY61FSV9NVkdkTbeKABo41kpqbukgxl/l0x0uRpr7EuKK2D0edOxOJMKD/mxz0fk2SFKmTUOoGXJ/zdOH+ivypUVr/VzXppN8W4w4FBxEBTOWDLL6hSUhomYRWLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZUMJfIC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E0DC4CED1;
	Wed,  4 Dec 2024 08:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733302600;
	bh=Yxjz03f7YodAcFNWgPYlbjlPTqBBEgCdSqNH6Yu1n2I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sZUMJfICmSw5hLZaZVsxoyreIQxAXAfsqxhGH2q5GCKVHhhQzOW4rRXiubXGWxw9s
	 /xkk6fq4A1MHnBkN9nl6LsX4K8uTKr/DBDBjHOlpWpo27ps6+CH+AyMgT2K8uCHUZF
	 g1F+D2S/lsJOemrBKaGI9c9XCK2EUr01B6jjxee+N0mgEfogSz/r+vRSzwFFl4tgxw
	 xqjrft2V/MMxEd7A6BPR2fcoONzZreez4Rxp98+r5hA3mydQOSpxwxLTJk2cSz5cqj
	 TBSMjR3iiNp5Nu1dxEmEToGS8PmhqBeDHlBQ/JmkCb0hJiN/z+FhkkIKAhDsOPAnt8
	 tBLZ8o3NaBLOQ==
Date: Wed, 4 Dec 2024 09:56:35 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 13/15] acpi/ghes: move offset calculus to a separate
 function
Message-ID: <20241204095635.512a44d5@foz.lan>
In-Reply-To: <20241204085440.4640a476@imammedo.users.ipa.redhat.com>
References: <cover.1732266152.git.mchehab+huawei@kernel.org>
	<e5661a6383449675b28e15c8479ebca42c939368.1732266152.git.mchehab+huawei@kernel.org>
	<20241203125143.7171892a@imammedo.users.ipa.redhat.com>
	<20241203144730.47b8ca86@foz.lan>
	<20241204085440.4640a476@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 4 Dec 2024 08:54:40 +0100
Igor Mammedov <imammedo@redhat.com> escreveu:

> On Tue, 3 Dec 2024 14:47:30 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Em Tue, 3 Dec 2024 12:51:43 +0100
> > Igor Mammedov <imammedo@redhat.com> escreveu:
> >   
> > > On Fri, 22 Nov 2024 10:11:30 +0100
> > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > >     
> > > > Currently, CPER address location is calculated as an offset of
> > > > the hardware_errors table. It is also badly named, as the
> > > > offset actually used is the address where the CPER data starts,
> > > > and not the beginning of the error source.
> > > > 
> > > > Move the logic which calculates such offset to a separate
> > > > function, in preparation for a patch that will be changing the
> > > > logic to calculate it from the HEST table.
> > > > 
> > > > While here, properly name the variable which stores the cper
> > > > address.
> > > > 
> > > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > ---
> > > >  hw/acpi/ghes.c | 41 ++++++++++++++++++++++++++++++++---------
> > > >  1 file changed, 32 insertions(+), 9 deletions(-)
> > > > 
> > > > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > > > index 87fd3feedd2a..d99697b20164 100644
> > > > --- a/hw/acpi/ghes.c
> > > > +++ b/hw/acpi/ghes.c
> > > > @@ -364,10 +364,37 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
> > > >      ags->present = true;
> > > >  }
> > > >  
> > > > +static void get_hw_error_offsets(uint64_t ghes_addr,
> > > > +                                 uint64_t *cper_addr,
> > > > +                                 uint64_t *read_ack_register_addr)
> > > > +{      
> > > 
> > >     
> > > > +    if (!ghes_addr) {
> > > > +        return;
> > > > +    }      
> > > 
> > > why do we need this check?    
> > 
> > It is a safeguard measure to avoid crashes and OOM access. If fw_cfg 
> > callback doesn't fill it properly, this will be zero.  
> 
> shouldn't happen, but yeah it firmware job to write back addr
> which might happen for whatever reason (a bug for example).
>

The main reason I added it is that, after the second series, it could 
also happen if there's something wrong with the backward compat logic.

So, both here and after switching to HEST-based offsets, I opted
to explicitly test.

> Perhaps push this up to the stack, so we don't have to deal
> with scattered checks in ghes code.
> 
> kvm_arch_on_sigbus_vcpu() looks like a goo candidate for check
> and warn_once if that ever happens.
> It already calls acpi_ghes_present() which resolves GED device
> and then later we duplicate this job in ghes_record_cper_errors()
> 
> so maybe rename acpi_ghes_present to something like AcpiGhesState* acpi_ghes_get_state()
> and call it instead. And then move ghes_addr check/warn_once there.
> This way the rest of ghes code won't have to deal handling practically
> impossible error conditions that cause reader to wonder why it might happen.

I'll look on it. Yet, if ok for you, I would prefer dealing with this
once we have a bigger picture, e.g. once we merge those tree series:

	- cleanup series (this one);
	- HEST offset (I'll be sending a new version today);
	- error_inject.

Thanks,
Mauro


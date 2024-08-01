Return-Path: <linux-kernel+bounces-271430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DCC944E20
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5017DB2674B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C9C1A4F38;
	Thu,  1 Aug 2024 14:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2AIQLJJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFFF1A4887
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 14:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722522858; cv=none; b=MsZI5G9Cg0gNz6R2I4IcUoZhCBrKZ/V3XI2YX9mX2u1j+E8SgCWHUiT+K7XBZecHCbVe/fj9i/KmZpu6fs9zX5SePX/GiH+A5sGzbcSXQ5x7dsFp/fnNrysOLhL8WrgwPKdp6paFnYTfoMJS6EWQqxtvDog9FwD9bxE5KgaG5PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722522858; c=relaxed/simple;
	bh=pCLks0KKkjWtBuTbXUEEAzmun/Ei05ls4gs/i/vnJkA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VlPuHrZXD/9prYkE904xjNPI/i1VMb6L6EEilXLrKSLstIfrEX1yc39fA/5J43FMCXzYxYYCgjggqJGMuA7JvCXpfEv/gXLeTFUvHPnYqO1CLXOA1C12R2qPPR505hD1CZnR7hd7yb/oUQ2C/QvfePII01u2NfaveguvAK9zbYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2AIQLJJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F49C32786;
	Thu,  1 Aug 2024 14:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722522858;
	bh=pCLks0KKkjWtBuTbXUEEAzmun/Ei05ls4gs/i/vnJkA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n2AIQLJJf5bEF80+we21wlGogYviVoZsrJTtML8CzYbHiFT+ORLqStGsFzUVHepmr
	 bYejuNe5A81NwCH+QMWgFRKAVBHVZQjEMHxsVJTNb/zTnk0dmQrs1RWuGvNtKbzGBW
	 BIPYND2tmJ2hnwU6vNQHUuYDIimSt8Q+eSq+5TPjfVlnfUOCM7287ln85SmfFDIV4C
	 NvY2k4sBq/YgT3Sdmk0vNKggUFOo1iQIt+HxPw59mZ8bl2byN47cXVz1wl7yxlooeF
	 LJennGKlTygqwvoHoaFkrbvK87Q7R1oem1ibFwkLF2nUAR0UkAHotbx32GMT845yeD
	 YX8szBWN6mcHQ==
Date: Thu, 1 Aug 2024 16:34:12 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Eric Blake
 <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 4/7] acpi/ghes: Add a logic to handle block addresses
 and FW first ARM processor error injection
Message-ID: <20240801163412.48740ddb@foz.lan>
In-Reply-To: <87zfq0b75i.fsf@pond.sub.org>
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
	<6a3542a7d8acfbf88c906ec6f6dc5a697257b461.1721630625.git.mchehab+huawei@kernel.org>
	<87bk2lreeb.fsf@pond.sub.org>
	<20240729142154.44d484c4@foz.lan>
	<87zfq0b75i.fsf@pond.sub.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Mon, 29 Jul 2024 16:32:41 +0200
Markus Armbruster <armbru@redhat.com> escreveu:

>  Yes, as this CPER record is defined only for arm. There are three other
> > processor error info:
> > 	- for x86;
> > 	- for ia32;
> > 	- for "generic cpu".
> >
> > They have different structures, with different fields.  
> 
> A generic inject-error command feels nicer, but coding its arguments in
> the schema could be more trouble than it's worth.  I'm not asking you to
> try.
> 
> A target-specific command like this one should be conditional.  Try
> this:
> 
>     { 'command': 'arm-inject-error',
>       'data': { 'errortypes': ['ArmProcessorErrorType'] },
>       'features': [ 'unstable' ],
>       'if': 'TARGET_ARM' }
> 
> No need to provide a qmp_arm_inject_error() stub then.

I tried it, but it generates lots of poison errors. Basically, QAPI
generation includes poison.h, making it to complain about on
non-ARM builds.

Anyway, the new version I'm about to submit is not dependent on
ARM anymore (as it is a generic GHES error injection that can be used
by any arch).

Still, as I added a Kconfig symbol for it, I still needed a stub.

It would be cool not needing it, but on the other hand it doesn't
hurt much.

> >> If we encode the the error to inject as an enum value, adding more will
> >> be hard.
> >> 
> >> If we wrap the enum in a struct
> >> 
> >>     { 'struct': 'ArmProcessorError',
> >>       'data': { 'type': 'ArmProcessorErrorType' } }
> >> 
> >> we can later extend it like
> >> 
> >>     { 'union': 'ArmProcessorError',
> >>       'base: { 'type': 'ArmProcessorErrorType' }
> >>       'data': {
> >>           'bus-error': 'ArmProcessorBusErrorData' } }
> >> 
> >>     { 'struct': 'ArmProcessorBusErrorData',
> >>       'data': ... }  
> >
> > I don't see this working as one might expect. See, the ARM error
> > information data can be repeated from 1 to 255 times. It is given 
> > by this struct (see patch 7):
> >
> > 	{ 'struct': 'ArmProcessorErrorInformation',
> > 	  'data': { '*validation': ['ArmPeiValidationBits'],
> > 	            'type': ['ArmProcessorErrorType'],
> > 	            '*multiple-error': 'uint16',
> > 	            '*flags': ['ArmProcessorFlags'],
> > 	            '*error-info': 'uint64',
> > 	            '*virt-addr':  'uint64',
> > 	            '*phy-addr': 'uint64'}
> > 	}
> >
> > According with the UEFI spec, the type is always be present.
> > The other fields are marked as valid or not via the field
> > "validation". So, there's one bit indicating what is valid between
> > the fields at the PEI structure, e. g.:
> >
> > 	- multiple-error: multiple occurrences of the error;
> > 	- flags;
> > 	- error-info: error information;
> > 	- virt-addr: virtual address;
> > 	- phy-addr: physical address.
> >
> > There are also other fields that are global for the entire record,
> > also marked as valid or not via another bitmask.
> >
> > The contents of almost all those fields are independent of the error
> > type. The only field which content is affected by the error type is
> > "error-info", and the definition of such field is not fully specified.
> >
> > So, currently, UEFI spec only defines it when:
> >
> > 1. the error type has just one bit set;
> > 2. the error type is either cache, TLB or bus error[1].
> >    If type is micro-arch-specific error, the spec doesn't tell how this 
> >    field if filled.
> >
> > To make the API simple (yet powerful), I opted to not enforce any encoding
> > for error-info: let userspace fill it as required and use some default
> > that would make sense, if this is not passed via QMP.
> >
> > [1] See https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#arm-processor-error-information  
> 
> I asked because designing for extensibility is good practice.
> 
> It's not a hard requirement here, because feature 'unstable' gives us
> lincense to change the interface incompatibly.

IMO keeping it as unstable makes sense, as this QAPI is specific for
error injection, which is hardly a feature widely used. Also, with the
script approach, the actual CPER record generation happens on a script.

If we provide it together with QEMU, if the QAPI ever changes, the
changes inside the script will happen altogether. So, IMO, no need to
make it stable.

Thanks,
Mauro


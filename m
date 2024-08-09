Return-Path: <linux-kernel+bounces-280589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B3594CC7C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C51ED28685C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A616918FDC9;
	Fri,  9 Aug 2024 08:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjt10ljt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C5012FB34
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 08:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723192951; cv=none; b=Z1rRGEO5Egiend6xaHecbmAS1UohtYFEPZY/8CH/ztX2EuySyrkzHSftWZe01A7miRwhtAlkwNFaX2Lkal6AQMdlXdzPbXObdkHkxHrhHUDFpa8/itfJQD6xolXmdCzJlJzkdT0nnr2jRv79jx5DqR54LuZ/+XRzGtPY3VTcVRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723192951; c=relaxed/simple;
	bh=1tsZLQjJ+/fNUeon+ajhVtnb6LzjfZ7DnmB0JqRBQpU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cV+6N5API1qQxFP/ljMMA+YgkQTRBQFaH90pI1jY0rvVbehmb9CBA73edeQ6iS7FG/CopgRW/b8vWpAaBH19iwMH2+AvhjFxi8XgXIzw/Yb3IxpBHvVNzKP+pzoIArrK2v66wMGHR/iJ2y96Vomh7KHPyVqPsiARcDGhOM1TE1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pjt10ljt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017D0C32782;
	Fri,  9 Aug 2024 08:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723192951;
	bh=1tsZLQjJ+/fNUeon+ajhVtnb6LzjfZ7DnmB0JqRBQpU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pjt10ljtMIzBL7WTMVTf2vq2wQt+XFouPEJhyGzCaGZmvMTgvNLlCwP++mF4jzniH
	 m3r7rrfDwwFAY2tZfHktrdq4ITz94BPcNtZi9woWL0wTF7L4HPeb88ZYuIDt7vbEyr
	 kQYd52ZSS5vqP6CN8PXovowChsiX5a12HbI7aoL5RaYH8M5xwIXYJKEcrvqxVhqw9X
	 42bYb1HU58IFS2UXtTcauaIkVEXrvoi/zChzPKa+CX74809NmkkCTiEce0KnxDWeHo
	 tw6RXc+3hKmKdOuRulvhXkt59tj4jkxNM+X9Le1pG5N0wjEUHEp3MkPc6O5ZFg4mHP
	 /a/x7T038y7GQ==
Date: Fri, 9 Aug 2024 10:42:22 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, Eric Blake <eblake@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 5/7] qapi/ghes-cper: add an interface to do generic
 CPER error injection
Message-ID: <20240809104222.08d197cb@foz.lan>
In-Reply-To: <87ikwbrs2o.fsf@pond.sub.org>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
	<51cbdc8a53e58c69ee17b15c398feeeeeeb64f34.1722634602.git.mchehab+huawei@kernel.org>
	<87v80b1jqe.fsf@pond.sub.org>
	<20240808161141.5ffe730e@foz.lan>
	<20240808162205.3a85efb6@imammedo.users.ipa.redhat.com>
	<87ikwbrs2o.fsf@pond.sub.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 08 Aug 2024 16:45:51 +0200
Markus Armbruster <armbru@redhat.com> escreveu:

> Igor Mammedov <imammedo@redhat.com> writes:
> 
> > On Thu, 8 Aug 2024 16:11:41 +0200
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >  
> >> Em Thu, 08 Aug 2024 10:50:33 +0200
> >> Markus Armbruster <armbru@redhat.com> escreveu:
> >>   
> >> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:    
> >>   
> >> > > diff --git a/MAINTAINERS b/MAINTAINERS
> >> > > index 98eddf7ae155..655edcb6688c 100644
> >> > > --- a/MAINTAINERS
> >> > > +++ b/MAINTAINERS
> >> > > @@ -2075,6 +2075,13 @@ F: hw/acpi/ghes.c
> >> > >  F: include/hw/acpi/ghes.h
> >> > >  F: docs/specs/acpi_hest_ghes.rst
> >> > >  
> >> > > +ACPI/HEST/GHES/ARM processor CPER
> >> > > +R: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> >> > > +S: Maintained
> >> > > +F: hw/arm/ghes_cper.c
> >> > > +F: hw/acpi/ghes_cper_stub.c
> >> > > +F: qapi/ghes-cper.json
> >> > > +      
> >> > 
> >> > Here's the reason for creating a new QAPI module instead of adding to
> >> > existing module acpi.json: different maintainers.
> >> > 
> >> > Hypothetical question: if we didn't care for that, would this go into
> >> > qapi/acpi.json?    
> >> 
> >> Independently of maintainers, GHES is part of ACPI APEI HEST, meaning
> >> to report hardware errors. Such hardware errors are typically handled by 
> >> the host OS, so quest doesn't need to be aware of that[1].
> >> 
> >> So, IMO the best would be to keep APEI/HEST/GHES in a separate file.
> >> 
> >> [1] still, I can foresee some scenarios were passing some errors to the
> >>     guest could make sense.
> >>   
> >> > 
> >> > If yes, then should we call it acpi-ghes-cper.json or acpi-ghes.json
> >> > instead?    
> >> 
> >> Naming it as acpi-ghes,acpi-hest or acpi-ghes-cper would equally work
> >> from my side.  
> >
> > if we going to keep it generic, acpi-hest would do  
> 
> Works for me.

Ok, I'll do the rename. With regards to the files implementing
support for it: 

	hw/acpi/ghes_cper.c
	hw/acpi/ghes_cper_stub.c

I guess there's no need to rename them, right? IMO such names
are better than acpi/hest.c, specially since the actual implementation
for HEST is inside acpi/ghes.c.

> 
> >> > >  ppc4xx
> >> > >  L: qemu-ppc@nongnu.org
> >> > >  S: Orphan      
> >> > 
> >> > [...]
> >> >     
> >> > > diff --git a/qapi/ghes-cper.json b/qapi/ghes-cper.json
> >> > > new file mode 100644
> >> > > index 000000000000..3cc4f9f2aaa9
> >> > > --- /dev/null
> >> > > +++ b/qapi/ghes-cper.json
> >> > > @@ -0,0 +1,55 @@
> >> > > +# -*- Mode: Python -*-
> >> > > +# vim: filetype=python
> >> > > +
> >> > > +##
> >> > > +# = GHESv2 CPER Error Injection
> >> > > +#
> >> > > +# These are defined at
> >> > > +# ACPI 6.2: 18.3.2.8 Generic Hardware Error Source version 2
> >> > > +# (GHESv2 - Type 10)
> >> > > +##      
> >> > 
> >> > Feels a bit terse.  These what?
> >> > 
> >> > The reference could be clearer: "defined in the ACPI Specification 6.2,
> >> > section 18.3.2.8 Generic Hardware Error Source version 2".  A link would
> >> > be nice, if it's stable.    
> >> 
> >> I can add a link, but only newer ACPI versions are hosted in html format
> >> (e. g. only versions 6.4 and 6.5 are available as html at uefi.org).  
> >
> > some years earlier it could be said 'stable link' about acpi spec hosted
> > elsewhere. Not the case anymore after umbrella change.
> >
> > spec name, rev, chapter worked fine for acpi code (it's easy to find wherever spec is hosted).
> > Probably the same would work for QAPI, I'm not QAPI maintainer though,
> > so preffered approach here is absolutely up to you.  
> 
> A link is strictly optional.  Stable links are nice, stale links are
> annoying.  Mauro, you decide :)

Well, I guess I'll add a link then, keeping it in text mode as well.

Changing umbrella is something that doesn't happen too often. Hopefully 
those will stay for a long time, if not forever, under uefi.org. 

If not, we can always drop the link.

Thanks,
Mauro


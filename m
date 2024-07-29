Return-Path: <linux-kernel+bounces-265779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F160893F5DA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C9291C2212C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0A0148FE1;
	Mon, 29 Jul 2024 12:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHDtvnXk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42135145354
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 12:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722257347; cv=none; b=gvYGYufYjq7WuFs7NTS2QkcSVFOzB+nMTiY1hgMK44Cv7LyKNb81n18aj0EOh7Toi+5wgITR2KrjhjFk1fRGSWxJ7tNCjQVUG9G4uQtaDR0a3lVttHTrGe/O3E7ZonCw/3oy0LH9/UG7iNqG8tJEnfdJTC2Q2W7jAsKF5gI5Aow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722257347; c=relaxed/simple;
	bh=qiXNpi1eTOPDfP97kK82wC1o8JCtBMWHZhQTd5JEvm0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LRBMvh+X7y+rRyXCGvqriyO0vhnv6y5UtYElbeU5d2K+pxM3kERqoYz3m/kYnvXc3Bik6ZdfsYSeR81y2luJlD9/SRfdid7jISu1FqfeRgqHRrjXMQmQzOaAjuN6j+GyRWlw+hzWrD+QXS9NWsccCZMFUPYKLjHL4QhrBNC1jSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHDtvnXk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3784C32786;
	Mon, 29 Jul 2024 12:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722257346;
	bh=qiXNpi1eTOPDfP97kK82wC1o8JCtBMWHZhQTd5JEvm0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sHDtvnXkt1avsRE4G2VxEXzbJzZO19bsvalHW82b3sv59QjOGjFxGMlHWv1/kFQCV
	 t/Gp8RZ+3WO/lHeLQUowJJz0cj/XpMHuc1mSkINsMCCpYXvC6ZeO9hPkKZoelYMcCU
	 vKzlP2YCJmphZTwvUaGcXHxSvGXG+CE7ei9mMB4y/2+Q3avUvpLnzAXL7zPFQ45sTP
	 3ZROSt5H8tJuVfMjEYerxXQ5rFe7uHJPA5yBBeLZNXIBL+PhhwTYaPS2peN0UoyP3D
	 sW4iqf04vpb73PXpxsULOTzazuippCR+KZEJnrJv3QyPt1SuNIZ9XMpXwMShPakRn7
	 2XfMlKYJz/Iyg==
Date: Mon, 29 Jul 2024 14:49:00 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Markus Armbruster <armbru@redhat.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Eric Blake
 <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, <linux-kernel@vger.kernel.org>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 4/7] acpi/ghes: Add a logic to handle block addresses
 and FW first ARM processor error injection
Message-ID: <20240729144900.459c0a42@foz.lan>
In-Reply-To: <20240726134646.000046e3@Huawei.com>
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
	<6a3542a7d8acfbf88c906ec6f6dc5a697257b461.1721630625.git.mchehab+huawei@kernel.org>
	<87bk2lreeb.fsf@pond.sub.org>
	<20240726134646.000046e3@Huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 26 Jul 2024 13:46:46 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> escreveu:

> A few quick replies from me.
> I'm sure Mauro will add more info.
> 
> > > +           'tlb-error',
> > > +           'bus-error',
> > > +           'micro-arch-error']
> > > +}
> > > +
> > > +##
> > > +# @arm-inject-error:
> > > +#
> > > +# Inject ARM Processor error.
> > > +#
> > > +# @errortypes: ARM processor error types to inject
> > > +#
> > > +# Features:
> > > +#
> > > +# @unstable: This command is experimental.
> > > +#
> > > +# Since: 9.1
> > > +##
> > > +{ 'command': 'arm-inject-error',
> > > +  'data': { 'errortypes': ['ArmProcessorErrorType'] },    
> > 
> > Please separate words with dashes: 'error-types'.
> >   
> > > +  'features': [ 'unstable' ]
> > > +}    
> > 
> > Is this used only with TARGET_ARM?
> > 
> > Why is being able to inject multiple error types at once useful?  
> 
> It pokes a weird corner of the specification that I think previously 
> tripped up Linux.
> 
> > 
> > I'd expect at least some of these errors to come with additional
> > information.  For instance, I imagine a bus error is associated with
> > some address.  
> 
> Absolutely agree that in sane case you wouldn't have multiple errors
> but we want to hit the insane ones :(

Yes.

> There is only prevision for one set of data in the record despite
> it providing a bitmap for the type of error.

Well, there isn't anything at the UEFI forbidding to use multiple bits.

On a "normal" field with a bitmask, more than one bit set is supported.
So, as spec doesn't deny it, it should be valid to have more than one 
bits filled.

Now, when multiple errors bits from this table are set:

            +-----|---------------------------+
            | Bit | Meaning                   |
            +=====+===========================+
            |  1  | Cache Error               |
            |  2  | TLB Error                 |
            |  3  | Bus Error                 |
            |  4  | Micro-architectural Error |
            +-----|---------------------------+

- if bit 4 is set, as specified at the spec, the error-info field is 
  defined by the ARM vendor, according with:

	"N.2.4.4.1.1. ARM Vendor Specific Micro-Architecture ErrorStructure

	 This is a vendor specific structure. Please refer to your hardware
	 vendor documentation for the format of this structure."

  So, provided that the vendor-specific documentation explicitly allows
  setting bit 4 with other bits, I don't see an UEFI compliance problem.

- if bit 4 is not set, but multiple bits 1 to 3 are set, the content
  of error-info is currently undefined, as tables N.18 to N.20 won't
  apply.

Anyway, from spec PoV, IMO UEFI API requires an errata to clearly enforce
that just one bit should be set or to define the behavior when multiple
ones are set.

Thanks,
Mauro


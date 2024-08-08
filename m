Return-Path: <linux-kernel+bounces-279598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A66894BF6F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D72ADB2770A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664FF18E776;
	Thu,  8 Aug 2024 14:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgSsRyDF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A929818DF6E
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126307; cv=none; b=h8f+eWI6OVj/ZWLSwFdNE+vKOHdAqLRs+cUgnoE1V5/UB8C2CsdQgYzTNbQtUi8sBE57PxU5r9npWcdKscZGvH90ceC3cW1f3BvWnYGvRObgks7m6zaQB9qo1SRhMhPCEDV81HmhmCgiH/ZuYEpFl4Ws9qiqe9kJ9oZtfYn1Ojs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126307; c=relaxed/simple;
	bh=+8KhZkMTI5fRZGMzqJiKMgxHC07OvLU1UljF56wsFDI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y8JOTKaIjjxPXIx6rRykA8VzoD9a/fo5fP/1vAxORk9i9J/gSUjrzTz0aaEpogEvgNmOOOSm+aye61GWEBFGuZkEoMfGDyuW/e+JfuuXa1KleP10xH72nmPa6JyIMWCwoea1VnTxb5tybUn5af4YE3Pi8yex3d50XmI0vBAvsoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgSsRyDF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30833C32782;
	Thu,  8 Aug 2024 14:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723126307;
	bh=+8KhZkMTI5fRZGMzqJiKMgxHC07OvLU1UljF56wsFDI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sgSsRyDFt7OAwOaW34uDzSl+7WLoS2aAgUs/xckW5EK/4cWOfyAlSYT64mTCgLcJb
	 s1aexZW+xsPXBmmUNg33vx5AuKwMuALesWFRK/zxpFRo1ewo/4o2uqlaij7JIctLCz
	 +5UVeyBMbJQf57ushrLmciG8wwZI0zDiDBddOs9BlQKMnjpb7u0t4V99NmUUYVt9Fr
	 q7zEICRDImzWheYij9Vg3Jaa4MnvH9Xf5Z1AWHWBn2MSfb8m6zcATy0NSl5mR9LY++
	 KV/zbZ0q413U4IzKvvL7Xz25IMG/FY+u9CpsCyyhFIQMJkO+70iSB1rzBm7r8m67BU
	 gG8d9zKVBxbUg==
Date: Thu, 8 Aug 2024 16:11:41 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Eric Blake
 <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 5/7] qapi/ghes-cper: add an interface to do generic
 CPER error injection
Message-ID: <20240808161141.5ffe730e@foz.lan>
In-Reply-To: <87v80b1jqe.fsf@pond.sub.org>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
	<51cbdc8a53e58c69ee17b15c398feeeeeeb64f34.1722634602.git.mchehab+huawei@kernel.org>
	<87v80b1jqe.fsf@pond.sub.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 08 Aug 2024 10:50:33 +0200
Markus Armbruster <armbru@redhat.com> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 98eddf7ae155..655edcb6688c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2075,6 +2075,13 @@ F: hw/acpi/ghes.c
> >  F: include/hw/acpi/ghes.h
> >  F: docs/specs/acpi_hest_ghes.rst
> >  
> > +ACPI/HEST/GHES/ARM processor CPER
> > +R: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > +S: Maintained
> > +F: hw/arm/ghes_cper.c
> > +F: hw/acpi/ghes_cper_stub.c
> > +F: qapi/ghes-cper.json
> > +  
> 
> Here's the reason for creating a new QAPI module instead of adding to
> existing module acpi.json: different maintainers.
> 
> Hypothetical question: if we didn't care for that, would this go into
> qapi/acpi.json?

Independently of maintainers, GHES is part of ACPI APEI HEST, meaning
to report hardware errors. Such hardware errors are typically handled by 
the host OS, so quest doesn't need to be aware of that[1].

So, IMO the best would be to keep APEI/HEST/GHES in a separate file.

[1] still, I can foresee some scenarios were passing some errors to the
    guest could make sense.

> 
> If yes, then should we call it acpi-ghes-cper.json or acpi-ghes.json
> instead?

Naming it as acpi-ghes,acpi-hest or acpi-ghes-cper would equally work
from my side.

> 
> >  ppc4xx
> >  L: qemu-ppc@nongnu.org
> >  S: Orphan  
> 
> [...]
> 
> > diff --git a/qapi/ghes-cper.json b/qapi/ghes-cper.json
> > new file mode 100644
> > index 000000000000..3cc4f9f2aaa9
> > --- /dev/null
> > +++ b/qapi/ghes-cper.json
> > @@ -0,0 +1,55 @@
> > +# -*- Mode: Python -*-
> > +# vim: filetype=python
> > +
> > +##
> > +# = GHESv2 CPER Error Injection
> > +#
> > +# These are defined at
> > +# ACPI 6.2: 18.3.2.8 Generic Hardware Error Source version 2
> > +# (GHESv2 - Type 10)
> > +##  
> 
> Feels a bit terse.  These what?
> 
> The reference could be clearer: "defined in the ACPI Specification 6.2,
> section 18.3.2.8 Generic Hardware Error Source version 2".  A link would
> be nice, if it's stable.

I can add a link, but only newer ACPI versions are hosted in html format
(e. g. only versions 6.4 and 6.5 are available as html at uefi.org).

Can I place something like:

	Defined since ACPI Specification 6.2,
	section 18.3.2.8 Generic Hardware Error Source version 2. See:

	https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#generic-hardware-error-source-version-2-ghesv2-type-10

e. g. having the link pointing to ACPI 6.4 or 6.5, instead of 6.2?

>   # @raw-data: payload of the CPER encoded in base64
> 
> Have you considered naming this @payload instead?

Works for me.

Thanks,
Mauro


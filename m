Return-Path: <linux-kernel+bounces-174871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E24D8C165B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD7B7B23664
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B72139D0E;
	Thu,  9 May 2024 20:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="ZwA/zztk"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BBF137923;
	Thu,  9 May 2024 20:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284918; cv=none; b=oKsCvW+PJSBNJBZsbD988KKIrheydO8n7jT/Ij5G/gfpIwNDik7/fUqTQ1gkN6xWJu90xqB0ErS93B/ZmdjIkAnjFU+Jy/nqPlqhR58SyDaMJaTdgeYFQJzz1fAnMRlODvB6Mej4LH4Pu/+wwn5rHl45SJKvN8fYBTz0w0Jdu4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284918; c=relaxed/simple;
	bh=MjekaYglvxnoUU0c4VwltXNfI+gRitDEcGsolq9SIpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L2hr79HVBFvHO1GteWCXRG41g8bKmYqWkcZ+WZgWJLhncR3mqwzv9mZEiszgpQMHLoYnERW+W/AJIgjEbmSuggWCJH5SVPWb+/Mg7QlgC57AynB7EjNhpCe8zyfIj34b9uPXPp9bXiFDEw3H0GSW3yCTFjdDN41WhBFQIY15E2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=ZwA/zztk; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 068B31C3276;
	Thu,  9 May 2024 22:01:49 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1715284909; bh=EVqEcpbQt5wTkwvxHRqJKUX2tSGchUs142WzCK5AFSY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZwA/zztkya4irG3ezVLRCaSAAlnzPdiOIBiiEon2zfOQD1oCH+/jV4aOyLkcw2dKj
	 6STNO4zn6TomTuMe98g7qHSNrzMC3fBies86Lrhy9XqgDSfPQPPiab9pM8ofFYupat
	 iPWnjaJdNAwdPhMo7d3UmtseInNGvL2AEWf7EE+ycwjQZSmkR74bSf2ZwxHJzMEuKD
	 NSuHD/Tkw6cVqPn9Q8AphAkGEp6yKOSIeUQ0h1obhSXwqixsqNnnbA/en8PzrCp1c+
	 sng8Bokv2fh/jpyxchYQM1NcTT2RhqiOl50Hsv4yPv2BBKWEL7rkIKRYxfRoK1K4Vg
	 Z2ZUsC5vaMoUQ==
Date: Thu, 9 May 2024 22:01:47 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet
 <corbet@lwn.net>, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 mhklinux@outlook.com, robin.murphy@arm.com, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/3] doc: swiotlb: Document SWIOTLB areas parameter
Message-ID: <20240509220147.3b0a0073@meshulam.tesarici.cz>
In-Reply-To: <CABdmKX229OjjzQ9BYC96QtwKdVyqdYEkLaBi1GN4oDNMD5SDpQ@mail.gmail.com>
References: <20240507013502.3095744-1-tjmercier@google.com>
	<20240507013502.3095744-2-tjmercier@google.com>
	<20240509081403.28c424d5@meshulam.tesarici.cz>
	<CABdmKX229OjjzQ9BYC96QtwKdVyqdYEkLaBi1GN4oDNMD5SDpQ@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 9 May 2024 09:04:16 -0700
"T.J. Mercier" <tjmercier@google.com> wrote:

> On Wed, May 8, 2024 at 11:14=E2=80=AFPM Petr Tesa=C5=99=C3=ADk <petr@tesa=
rici.cz> wrote:
> >
> > On Tue,  7 May 2024 01:34:59 +0000
> > "T.J. Mercier" <tjmercier@google.com> wrote:
> > =20
> > > Commit 20347fca71a3 ("swiotlb: split up the global swiotlb lock") add=
ed
> > > the ability to specify the number of SWIOTLB areas, but boot-options.=
rst
> > > was not updated as part of that commit.
> > >
> > > Reported-by: Michael Kelley <mhklinux@outlook.com>
> > > Fixes: 20347fca71a3 ("swiotlb: split up the global swiotlb lock")
> > > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > > ---
> > >  Documentation/arch/x86/x86_64/boot-options.rst | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/arch/x86/x86_64/boot-options.rst b/Documen=
tation/arch/x86/x86_64/boot-options.rst
> > > index a37139d1752f..18161657b301 100644
> > > --- a/Documentation/arch/x86/x86_64/boot-options.rst
> > > +++ b/Documentation/arch/x86/x86_64/boot-options.rst
> > > @@ -287,9 +287,11 @@ iommu options only relevant to the AMD GART hard=
ware IOMMU:
> > >  iommu options only relevant to the software bounce buffering (SWIOTL=
B) IOMMU
> > >  implementation:
> > >
> > > -    swiotlb=3D<slots>[,force,noforce]
> > > +    swiotlb=3D<slots>[,<areas>,force,noforce] =20
> >
> > This is not quite how this parameter is parsed. All the following
> > specifications are valid:
> >
> > - swiotlb=3D512        // only slots
> > - swiotlb=3D,4         // only areas
> > - swiotlb=3D512,4      // slots and areas
> > - swiotlb=3Dforce      // default size
> > - swiotlb=3D512,force  // default areas
> > - swiotlb=3D512,4,force // explicitly specify everything
> >
> > I believe the syntax should be somethig like:
> >
> >   swiotlb=3D{ | [<slots>][,<areas>],}{ force | noforce }
> >
> > Petr T
> > =20
> What does the leading | mean in front of slots?  How about brackets

I wanted to mark somehow that "force" and "noforce" alone do not
require a leading comma, but if you specify slots and/or areas, the
comma is required, like you write below.

> around force/noforce since they're also optional and mutually
> exclusive?

Right. I missed that.

> The Rebooting section uses double brackets instead of
> braces for groupings like that.

TBH I don't know what syntax is used here. Use anything that can capture
the variants I listed above.

> Only weird thing here is the
> force/noforce comma being potentially unneeded, but that's getting
> pretty picky and I think the intent is clear.
>=20
> swiotlb=3D[<slots>][,<areas>][, [force] | [noforce] ]

No objections from my side.

Petr T


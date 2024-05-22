Return-Path: <linux-kernel+bounces-186438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9188CC42B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 822041F22B9B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6537CF39;
	Wed, 22 May 2024 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JXCw+3DE"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C730A1171C;
	Wed, 22 May 2024 15:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716392103; cv=none; b=MkveClFuqxhNrh4ujFBtjlp+SVjU3c3a2FC6gJP2inGl87phs4lsMuT/FOO6WGXd4MahBbvNe7ZR3AyEMnzWBNkexfeNEdiQHh3rxCdPVNobb34J5NjLrqKAfSpc6+eBIuvYuRoJvyzJzttCqSBSETSrjDmlRyOGK8lhPJ6Pwv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716392103; c=relaxed/simple;
	bh=8480QhKUdQoJHZDBOHDLuO3cqndu/sU4gw6J3Z4J4uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHlpw5bJSEYhMFktwo6mOwYGiGTDGHkh1yrslvxf3KwUY6XrBUSVJAkumeMuQtN55kGiTrS/qstyEKGGxtZHcOaEKgT6KlqignnTwRSZiylbc5ozvP+cw483aMCBWKJluZSx2xIQsFgA4cYnZ1NU2hZlKyBEWDzW5ItgjcyK6Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JXCw+3DE reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0C7FD40E0254;
	Wed, 22 May 2024 15:34:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wqTkxvV73S00; Wed, 22 May 2024 15:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1716392094; bh=Xmy+3e1HHHTBNLSRHwnL6nlYDa9k9Cp2lomF07Vmx8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JXCw+3DEfJjYLRkVQzMmJsoxUxb+crd9QUp2D6N8qTU23wQL1oV/VtjD7TdS7JbIs
	 r/ysPLnKN+8KFBqQI0a83WEVeCL4oTMhh5DZFqSrqA7bkpu9x04N+VTgYZCEBJ/5rE
	 cF75WoiavAXMd0B122qI8/O1e77WlcDAJ9dCSAmE3klJV19jAfqDu1m38BrupUhDhf
	 McCnH9C/SxtmUWB4ZWy5Ep1KCbpARCkfZGVRcoJtdktYekLjaCweHv1FSsr8QnZKxV
	 MsfwK+qVnWgOK1/GdEEjcmmGtEPJRMgsihVhLM4n/ngg9kdOpCgZIZSvYM0TL6xWnq
	 4jylzsuUSB1IjGPQ88EmHuVUx7hXBAM+D4CaJbfMkWOrRJE9cUoFUlURqrY1puKJ16
	 ysex2xRY8nflVtq5FqraGbEihfAsc7KEoW5Fnqp6FoeClUWqOv79qdQSG/XUYSLE7s
	 DGO3ISzCpus26E9YbSQJHqlEy1YbQ0/66Mns9aScxJpE4fEv4mcmt+QY1qxS8HBudo
	 e0bCVVs4yU9214jWMb2XPWbIUUKHxdI+MFUYjP+WEtD8nDFg15JEoJ2PbUQ2r8rh0+
	 bJceLUXnJIZhUDNAcPpqnp/+2KR14NZ0O0qfKPV13VuanhWMBH7GNccH9UM1LMR+kB
	 zeOfji83xzWdJqjiOI7FwJKw=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2368F40E0177;
	Wed, 22 May 2024 15:34:34 +0000 (UTC)
Date: Wed, 22 May 2024 17:34:33 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Balasubrmanian, Vignesh" <vigbalas@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"Balasubrmanian, Vignesh" <Vignesh.Balasubrmanian@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>,
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>,
	"npiggin@gmail.com" <npiggin@gmail.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	"naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>,
	"keescook@chromium.org" <keescook@chromium.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"George, Jini Susan" <JiniSusan.George@amd.com>,
	"matz@suse.de" <matz@suse.de>,
	"binutils@sourceware.org" <binutils@sourceware.org>,
	"jhb@FreeBSD.org" <jhb@freebsd.org>,
	"felix.willgerodt@intel.com" <felix.willgerodt@intel.com>
Subject: Re: [PATCH v2 1/1] x86/elf: Add a new .note section containing
 Xfeatures information to x86 core files
Message-ID: <20240522153433.GCZk4QiX4Hf0OuI48E@fat_crate.local>
References: <87wmo4o3r4.ffs@tglx>
 <4a090901-9705-40aa-ac3d-d67c52660f22@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4a090901-9705-40aa-ac3d-d67c52660f22@amd.com>
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 06:42:55PM +0530, Balasubrmanian, Vignesh wrote:
> > > +enum custom_feature {
> > > +     FEATURE_XSAVE_FP =3D 0,
> > > +     FEATURE_XSAVE_SSE =3D 1,
> > > +     FEATURE_XSAVE_YMM =3D 2,
> > > +     FEATURE_XSAVE_BNDREGS =3D 3,
> > > +     FEATURE_XSAVE_BNDCSR =3D 4,
> > > +     FEATURE_XSAVE_OPMASK =3D 5,
> > > +     FEATURE_XSAVE_ZMM_Hi256 =3D 6,
> > > +     FEATURE_XSAVE_Hi16_ZMM =3D 7,
> > > +     FEATURE_XSAVE_PT =3D 8,
> > > +     FEATURE_XSAVE_PKRU =3D 9,
> > > +     FEATURE_XSAVE_PASID =3D 10,
> > > +     FEATURE_XSAVE_CET_USER =3D 11,
> > > +     FEATURE_XSAVE_CET_SHADOW_STACK =3D 12,
> > > +     FEATURE_XSAVE_HDC =3D 13,
> > > +     FEATURE_XSAVE_UINTR =3D 14,
> > > +     FEATURE_XSAVE_LBR =3D 15,
> > > +     FEATURE_XSAVE_HWP =3D 16,
> > > +     FEATURE_XSAVE_XTILE_CFG =3D 17,
> > > +     FEATURE_XSAVE_XTILE_DATA =3D 18,
> > > +     FEATURE_MAX,
> > > +     FEATURE_XSAVE_EXTENDED_START =3D FEATURE_XSAVE_YMM,
> > > +     FEATURE_XSAVE_EXTENDED_END =3D FEATURE_XSAVE_XTILE_DATA,
> > > +};
> > Why can't this use the existing 'enum xfeature' which is providing
> > exactly the same information already?
> First version of patch was similar to what you mentioned here and other
> review comments to use existing kernel definitions.
> https://lore.kernel.org/linux-mm/20240314112359.50713-1-vigbalas@amd.co=
m/T/
>=20
> As per the review comment https://lore.kernel.org/linux-mm/202403141629=
54.GAZfMmAnYQoRjRbRzc@fat_crate.local/
> , modified the patch to be a independent of kernel internal definitions=
.
> Though this enum and below function=C2=A0 "get_sub_leaf" are not useful=
 now,=C2=A0 it
> will be required when we extend for a new/different features.

No, Thomas' sugggestion is to use the existing xfeature enum - not
define the same thing again.

Why do you need that enum custom_feature thing if you can use

/*
 * List of XSAVE features Linux knows about:
 */
enum xfeature {

from arch/x86/include/asm/fpu/types.h

?

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


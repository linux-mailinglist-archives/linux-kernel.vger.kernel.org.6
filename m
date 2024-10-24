Return-Path: <linux-kernel+bounces-379780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9849AE3B1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 13:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EBB41F239A7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492521CEE8A;
	Thu, 24 Oct 2024 11:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bodenbinder.de header.i=@bodenbinder.de header.b="YM7foC2H"
Received: from nx121.node01.secure-mailgate.com (nx121.node01.secure-mailgate.com [89.22.108.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94161CCED2;
	Thu, 24 Oct 2024 11:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.22.108.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729768868; cv=none; b=V0XWKkv/pUWlRYIeXkLRJfKg3JXTXj6dU7ioYSUMeMwGNi2pKhyJWCXYSllr8ldVlBXolIxVf/go0BIBKOjZeX2YXds+z89IrDr0isLygH8DMVeAiDhDdQ+d3Mt/lzXaBJDdXarE1lA+WGv+hCKPVLItQf94GxF4a3AJA99qd9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729768868; c=relaxed/simple;
	bh=j0C/pykth4QzWKBHNtXedAHf6zFx4Jk2buB39tGU3Yg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UEHE9rxFfseGQ6EboaWyvRoPy0i2YNf8KjnQ1ds/7tUV4aqS4Cd9lWhsOW7Y+Fg1iO86LZzWo7lIzd0kTNlnfXYtShpoV5MXZtYoQzgS+Xn2WGtPsL4TIBNIEpwpVhAFAAU2jUdaMJBEwHd5+tCOTGF0lg5I/qSt2QkXZqwJDUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bodenbinder.de; spf=pass smtp.mailfrom=bodenbinder.de; dkim=pass (1024-bit key) header.d=bodenbinder.de header.i=@bodenbinder.de header.b=YM7foC2H; arc=none smtp.client-ip=89.22.108.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bodenbinder.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bodenbinder.de
Received: from web263.dogado.net ([31.47.255.43])
	by node01.secure-mailgate.com with esmtps (TLSv1.2:AES128-GCM-SHA256:128)
	(Exim 4.92)
	(envelope-from <matthias@bodenbinder.de>)
	id 1t3vtb-008vL6-Rm; Thu, 24 Oct 2024 13:20:55 +0200
X-SecureMailgate-Identity: bodenbinder_de;web263.dogado.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bodenbinder.de;
	s=cloudpit; t=1729768848;
	bh=XWkfa5fEX5V4GuUQI0dMU/2kxx2O9C5ZTvyOv87JHak=;
	h=Subject:From:Reply-To:To:Cc:Date:In-Reply-To:References:From;
	b=YM7foC2HNgQY8mlrhpzLQDHfJ6YAL2L93gpMghtvOA/C3KoxuCmXA/kD+uuVDTkld
	 0IPlnxIWX5A5LLlhn65C6Ca5CQKi2h9DcQ3M8Rn5EmOFyufDWLv0Bj+I+c7mlZZmhS
	 /GH7sSwoEFkckf9RTSYRm+NRhH9P/ONEuY5yleNA=
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by rakete.bodenbinder.de (Postfix) with ESMTP id C69692B0C863;
	Thu, 24 Oct 2024 13:20:47 +0200 (CEST)
X-SecureMailgate-Identity: bodenbinder_de;web263.dogado.net
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by rakete.bodenbinder.de (Postfix) with ESMTP id C69692B0C863;
	Thu, 24 Oct 2024 13:20:47 +0200 (CEST)
Message-ID: <8f1e0a5a10df71a8b4e8856feefd256bb150c38a.camel@bodenbinder.de>
Subject: Re: darktable performance regression on AMD systems caused by "mm:
 align larger anonymous mappings on THP boundaries"
From: Matthias Bodenbinder <matthias@bodenbinder.de>
Reply-To: matthias@bodenbinder.de
To: Vlastimil Babka <vbabka@suse.cz>, Thorsten Leemhuis
	 <regressions@leemhuis.info>, Rik van Riel <riel@surriel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux kernel regressions list
	 <regressions@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>,
 Linux-MM	 <linux-mm@kvack.org>, Yang Shi <yang@os.amperecomputing.com>,
 Petr Tesarik	 <ptesarik@suse.com>
Date: Thu, 24 Oct 2024 13:20:47 +0200
In-Reply-To: <ce35b58e-f18c-4701-8494-fa8d1f6e5148@suse.cz>
References: <2050f0d4-57b0-481d-bab8-05e8d48fed0c@leemhuis.info>
	 <f81ef5bd-e930-4982-a5a8-cd4aca272912@suse.cz>
	 <ce35b58e-f18c-4701-8494-fa8d1f6e5148@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SecureMailgate-Domain: web263.dogado.net
X-SecureMailgate-Username: 31.47.255.43
Authentication-Results: secure-mailgate.com; auth=pass smtp.auth=31.47.255.43@web263.dogado.net
X-SecureMailgate-Outgoing-Class: ham
X-SecureMailgate-Outgoing-Evidence: Combined (0.01)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT+Di/w7YEBINGW0nwvCkZUyPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5yWDQ52YYvt9IisBTB4Q1BTDELDtmPLfdT2Vjpgvg+rlDS7
 ZzDoczvwl69Kp+t4ZfNPMFkC7dju0wVi9xVi6etz6t4nFv6HbQROxrKHBWdVz0bCVIVYbbDzsdz7
 jC0gj9bsucSeir9YkXOhPyRNXzDt2sHfcJwOEA9jKCSl094oPEA8vZNIz+4a7F8dfU2Fqbk2yWsN
 Z8gyqKw33bw2+EiXjgEQn6pw4NBZ8mDUNUFs7J2IA5RYNsQ2FJ5vBgmf1IHrXWU6cgGy8Nw/36CI
 Z8AWNlDo60GNfZ2F/yvXF5fp0ZC7J/Kxq6Wlezg2CfSW1DENoYkVbhZSPkZJaDp+CfVLudCSOzNy
 9PUk3qu+PQAnn/V7TUmIicDOOWMzcOyJSvmS9X7umXUE4oWoGV4TyQjTv0kyaSBiWCAhy4JMoK+Q
 fW5+fLO9VVhpK4T4aCzoygxALto4Brt2dyUUhL+IPYnjcMOfNZZ7+Vw90V7OmzZlr23m0/SFC0zn
 ggTAyrq6gEQM2HNV91gBZQ/1Pbs8eo64jl36TXkSKbxR+NrMuhHwDU+tT6G6A1eH4vLMfHwjJ7+g
 ei65y0Nk9SLcHStypSM5+CyAq35eV5Znh58ZuD0Sly5wxy0DV+mfZOyx7yN0vJPMqA9uSzHf/EOh
 slWB0B8sZaOjZ/HsdGn4fWC/8/Uc4odvMYH3HM2nOIg1Q8cK42gKNzj+12gTeiYOwewVmnsVsQL4
 NXHrQIQdbY00d7mOmyRu9qsmwsU/3Onabsct4Toal0h743VOpKNY+4MjijihJW/2S6VsWr8v8wYU
 22Gz7taKCC+ZDU9vfHgXkJXgxBoG4yf4TuzSUn4Eqv2AnTV4aIfVaCHpEB6cFH6WJxE4ZoQmEszT
 mvj5plaKBwW8kAExvt39Pt9gUdZK44J+sQGUc+HLqmn/pLC2GklQLRsGsoX0fOQPR5LGYRx/IHNE
 wGOtC2+FKqdOMATtOe3+6YoEw/O+Anfr832S2bh0h3+LfdufaG44omTNnk2+H8rLwHveYa7+ehlS
 W35MGtD26+UkLrogMSVlrPEWO9GJc1lxPlJx1/MWs0nunOY0mMo2j57SrYfhlozbi+DDGJdOZmGm
 maNdVZCPNCR8FQT9g6A3PUsRyHdQM1T4ZnIJmHmedG43iN+78rrGceX2Us+1iu/dlWkx9G5WKnjQ
 eRgRsesUUlf9uZG5Xlf2yOMcW110oNec2/lxh3SFN2BqdKJL9fPSszlVwj1n2JAvHUSGQgae9xme
 Szqs5sL/ee+qsUXMYe2z/zdoQyyytN1h7S0B/89UrnroWE66jLebXsBVS+Akcg==
X-Report-Abuse-To: spam@node04.secure-mailgate.com

Am Donnerstag, dem 24.10.2024 um 12:23 +0200 schrieb Vlastimil Babka:
> On 10/24/24 11:58, Vlastimil Babka wrote:
> > On 10/24/24 09:45, Thorsten Leemhuis wrote:
> > > Hi, Thorsten here, the Linux kernel's regression tracker.
> > >=20
> > > Rik, I noticed a report about a regression in bugzilla.kernel.org tha=
t
> > > appears to be caused by the following change of yours:
> > >=20
> > > efa7df3e3bb5da ("mm: align larger anonymous mappings on THP boundarie=
s")
> > > [v6.7]
> > >=20
> > > It might be one of those "some things got faster, a few things became
> > > slower" situations. Not sure. Felt odd that the reporter was able to
> > > reproduce it on two AMD systems, but not on a Intel system. Maybe the=
re
> > > is a bug somewhere else that was exposed by this.
> >=20
> > It seems very similar to what we've seen with spec benchmarks such as c=
actus
> > and bisected to the same commit:
> >=20
> > https://bugzilla.suse.com/show_bug.cgi?id=3D1229012
> >=20
> > The exact regression varies per system. Intel regresses too but relativ=
ely
> > less. The theory is that there are many large-ish allocations that don'=
t
> > have individual sizes aligned to 2MB and would have been merged, commit
> > efa7df3e3bb5da causes them to become separate areas where each aligns i=
ts
> > start at 2MB boundary and there are gaps between. This (gaps and vma
> > fragmentation) itself is not great, but most of the problem seemed to b=
e
> > from the start alignment, which togethter with the access pattern cause=
s
> > more TLB or cache missess due to limited associtativity.
> >=20
> > So maybe darktable has a similar problem. A simple candidate fix could
> > change commit efa7df3e3bb5da so that the mapping size has to be a multi=
ple
> > of THP size (2MB) in order to become aligned, right now it's enough if =
it's
> > THP sized or larger.
>=20
> Maybe this could be enough to fix the issue? (on 6.12-rc4)
>=20
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 9c0fb43064b5..a5297cfb1dfc 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -900,7 +900,8 @@ __get_unmapped_area(struct file *file, unsigned long =
addr, unsigned
> long len,
> =C2=A0
> =C2=A0	if (get_area) {
> =C2=A0		addr =3D get_area(file, addr, len, pgoff, flags);
> -	} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> +	} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)
> +		=C2=A0=C2=A0 && IS_ALIGNED(len, PMD_SIZE)) {
> =C2=A0		/* Ensures that larger anonymous mappings are THP aligned. */
> =C2=A0		addr =3D thp_get_unmapped_area_vmflags(file, addr, len,
> =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0 pgoff, flags, vm_flags);
>=20


Hi,=20
here is Matthias, the reporter of the darktable issue
https://bugzilla.kernel.org/show_bug.cgi?id=3D219366

I applied your patch to kernel 6.11.5 and it works. darktable pixel pipelin=
e goes down to
3.8 s with this patch.=C2=A0Same performance as with kernel 6.6.x. It was 4=
.7 s without that
patch.




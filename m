Return-Path: <linux-kernel+bounces-380901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C38A9AF791
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 04:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DFC11C21E35
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 02:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7338F18A6D3;
	Fri, 25 Oct 2024 02:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jA9XIliP"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584D418A6AA
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 02:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729824034; cv=none; b=UY/LumB3HMXLIgDT+f24Eawu+kcu+DDcncZaYQ2967apw47AmjSxsm328voE72H5aEmBkRJtFcdcnmiZ04HdgcWTR5SEcyPVkmSVZEq+Vy0Gsc1sC7wzXHpn9dkHS2viEur9fiGgnAW+oQT9ThxSRY15IlSMU5Crx8M8Qlaf5Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729824034; c=relaxed/simple;
	bh=TN2/QjRxDjW8pgzbFK3owiahhYmzbXqcoO2hYmfEbvA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FqTSQ5SAXt1JfdOCj5KG5mUKLXD2jW5o7EM0IYYnFHZO1a8aKk3S3Vq9tPxTTvkz6KuWp4uRFTtqJwzPMWAL2ptTfxluS5ymMe2hDfXCk2uA7CwAiymEEDgmcifpCbkvBK/EV1f7vKzjeZTVsGZpmUgpEHoSvANsVRDMUYzbYHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=jA9XIliP; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1729824027;
	bh=hRz6ek6f2mhiXmZ8EACPo8c6GZXKJ6CFOZ2CJK0Ot8c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jA9XIliPS9NYc7b1XDiKTxyz0jxtXbbSCmM3C4UGmOuqn/eKlTvqJqHxPazXMQmNW
	 8swM8ZSQM0LhxSM+VmeRuPgN/HkK2xwCyf/ZZGXYtaDaPJT9GYHqqhrXA5kbjwwWOq
	 /DYMUF2fie8RIQOj5T0tuVZUP0Lp6l8clLVlnIklZyu/nOCIeEGL07vu+L3tODmXaX
	 g/AWliAXsrNpm0b9YdqWVHHrC1Eb817VbWqnNyJM3rRJ0YMxZoBPVA2jYln1xpekth
	 lltyI2i6pBTW+j5qUGTCnEBYgobrYGK6cPQ568NYGFygD354VDyqk2dQaAAKn6MpFW
	 Bn+afqtpfr9/Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XZRpd5yN9z4w2K;
	Fri, 25 Oct 2024 13:40:25 +1100 (AEDT)
Date: Fri, 25 Oct 2024 13:40:26 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Nysal Jan K.A." <nysal@linux.ibm.com>, Andrew Morton
 <akpm@linux-foundation.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linuxppc-dev@lists.ozlabs.org, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, Kent Overstreet
 <kent.overstreet@linux.dev>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH] sched/membarrier: Fix redundant load of
 membarrier_state
Message-ID: <20241025134026.54ca0d57@canb.auug.org.au>
In-Reply-To: <87frolja8d.fsf@mail.lhotse>
References: <20241007053936.833392-1-nysal@linux.ibm.com>
	<87frolja8d.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xJN4qG0cvTfW=1E8/KUET+a";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/xJN4qG0cvTfW=1E8/KUET+a
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Fri, 25 Oct 2024 11:29:38 +1100 Michael Ellerman <mpe@ellerman.id.au> wr=
ote:
>
> > diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> > index 07bb8d4181d7..042e60ab853a 100644
> > --- a/include/linux/sched/mm.h
> > +++ b/include/linux/sched/mm.h
> > @@ -540,6 +540,8 @@ enum {
> > =20
> >  static inline void membarrier_mm_sync_core_before_usermode(struct mm_s=
truct *mm)
> >  {
> > +	if (!IS_ENABLED(CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE))
> > +		return;
> >  	if (current->mm !=3D mm)
> >  		return;
> >  	if (likely(!(atomic_read(&mm->membarrier_state) & =20
>=20
> The other option would be to have a completely separate stub, eg:
>=20
>   #ifdef CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
>   static inline void membarrier_mm_sync_core_before_usermode(struct mm_st=
ruct *mm)
>   {
>           if (current->mm !=3D mm)
>                   return;
>           if (likely(!(atomic_read(&mm->membarrier_state) &
>                        MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE)))
>                   return;
>           sync_core_before_usermode();
>   }
>   #else
>   static inline void membarrier_mm_sync_core_before_usermode(struct mm_st=
ruct *mm) { }
>   #endif
>=20
> Not sure what folks prefer.

I case it matters, in general I prefer the first as there is less code
to get out of sync and all the code still gets parsed by the compiler
whether the CONFIG option is set or not.
--=20
Cheers,
Stephen Rothwell

--Sig_/xJN4qG0cvTfW=1E8/KUET+a
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmcbBRoACgkQAVBC80lX
0GxfUwf/UNwbgf6ltUL5TSkUcQK+MHS1rAhtchOQGS8DB54i+pHE+xlMxRHVb7Vr
EBgHyKCS51DkgnpYstfbe5SohYx6cwHkewS4QsG3e4GCEoSskhtKPycCuhYvM5Am
dR4UzX/HZEZ8wPZytaqPFlnauT4lAnNBZ9yWK6uae/yXeTlWYL/pApuXpoeSknK7
vioVAYku96ksRs6afhzcv9C0TWPuv7G4+RaEp80B8FY6qtFLoaookb24jm5boKN0
5eM5t0Q1Oajk7Aq9kThjResSlk/0pdJz4QNaJ7mGJFQulHIuOJLwYn589kAK7z0G
ETGGHKj/fRXzVNNgXIPqNie9czn1lQ==
=62J7
-----END PGP SIGNATURE-----

--Sig_/xJN4qG0cvTfW=1E8/KUET+a--


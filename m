Return-Path: <linux-kernel+bounces-280662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8213894CD71
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 380561F21351
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F090190693;
	Fri,  9 Aug 2024 09:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="yqQc+Y7n"
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AB0BA41;
	Fri,  9 Aug 2024 09:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196286; cv=none; b=fcQvOMciSNDPKkYN7TAvaClm7y+olBSG4BuvP2/D9KreLMuVtiVKj0RYYmESYxPymgLJBJYslHTbSvx2qLbPeY3eRs0PA11O3x8zcXSSm2LdYU5MorEqSdVfBR5NVH4/j3yHD9wiAOS9q/wgumn+5S0mYFruHhJzbgDGidn1TYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196286; c=relaxed/simple;
	bh=d5nspmA/pbwkat/qPZ71h9zN79WSiIkFUjew2mrZZoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXRz3EY3u9HoDY73BCBcOvtGvud8myqzwcsh8HEsj5VakjgsJGk2cYeenVl5XNBnwiPpxSTJZAJsdRkp9RdW5lhjoouzU2ZDM+LCQ9HS0P1oNKqjRqPFB2ZLkov30utA1emr/idcIJFRAEYBT7gv+9G7Fc2VpwEsQ2O0I0h/Hho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=yqQc+Y7n; arc=none smtp.client-ip=212.227.126.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1723196256; x=1723801056; i=christian@heusel.eu;
	bh=ooe/R/iT1AwlKFN4hiopuC61Fn2bSHjWVPgT8QwZmrQ=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=yqQc+Y7nS0x+DLvZW8k7rhJhyALsWwJUXGEt3smXzBgO/d7S4GuS15gKf0sJVjIQ
	 Zd2f74sjRYpsRfrDqsczWazfNSUKKn8hHUa0o97XXMXaYuLyO67RcW8LgSyagaQ0b
	 CCzMYSG0Q8mXIK9t58mJO4g32VAjY0Mi/0b99kMDacie+/ocTwI+UMTejOE1d78DM
	 kqgHXBLITAFtCcdCWuHWpOc9U7vv0xBtLXHAUA1kKM7vvSmsPKu0Dz72Hi+PAQSCt
	 ZXC2MO+H+NsELuwdmIjebuexmlcYGbVlBnSccmtFn6ByX5lnLrum2WXPr2RKr6z4C
	 PPpb0L5hUlxz/O2uDA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([78.42.228.106]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M2w4S-1sdT3T36fU-00625y; Fri, 09 Aug 2024 11:37:36 +0200
Date: Fri, 9 Aug 2024 11:37:31 +0200
From: Christian Heusel <christian@heusel.eu>
To: Rob <rob@durendal.co.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	regressions@lists.linux.dev, x86@kernel.org, Joerg Roedel <joro@8bytes.org>, 
	Tony Luck <tony.luck@intel.com>, LKML <linux-kernel@vger.kernel.org>, 
	Paul Menzel <pmenzel@molgen.mpg.de>, Lyude Paul <lyude@redhat.com>
Subject: Re: [PATCH] x86/apic: Remove logical destination mode for 64-bit
Message-ID: <c7b68723-6ecb-42be-a9f8-14d64c696283@heusel.eu>
References: <20240725105029.GAZqIt9aLsIaG7JqN5@fat_crate.local>
 <12df8b45-6100-4c8b-b82a-a6a75bed2e05@heusel.eu>
 <87a5i4whoz.ffs@tglx>
 <ZqQSmw51ihns03ob@vendhya2>
 <ZqQl79UhhSQ5IobX@vendhya2>
 <8734nvuvrs.ffs@tglx>
 <ZqTufKvJKvotC-o_@vendhya2>
 <87cymyua9j.ffs@tglx>
 <877cd5u671.ffs@tglx>
 <ZqZ3Kp2NVctgstxs@vendhya2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n2dkjomquggalyiy"
Content-Disposition: inline
In-Reply-To: <ZqZ3Kp2NVctgstxs@vendhya2>
X-Provags-ID: V03:K1:ZufdIasE7+/Hjmun+zZy2clD3s4FsMMvUVIbkfL+ZvPP4P6FiDK
 f5oRdRmoOrbg815OEf3jCULs0WOuN+e/Xh2IIx9sqO42qfqgX96StmkVNtUaiLy30TtUUj4
 oli71eJSXKkJ3hO8kKeJfkLX1duP/cItBlMi6NQdMwEbmOLP+CjaYZG1YA+CMWBx8GRIMLm
 IbAxX6M2mVqcqAECIIwSw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ftTL1hHybkQ=;xfqDqVfPPzahFWxCVIQsykhpeBe
 s7+ibyBh46M8PEXe+QJhP57K63FEEuBngZNGKSgP2PadsCFJ8B7x22P8KakGhKmbinEONhx+u
 lLVg09E1Hio23kIEZ5A3fzQ5BsSkZ/hqIKzzXqvlY4e2/Y2K66OnlqhfjAAu3QLKglkyKFolF
 IsEDetVHtj3F7WoZ2sHH8+f3vfHFkahqvlqjgL6vItlxDqjAiAaQ0Wj5Ab9SuZHS4MtinNk9o
 twZlUycEupIRPQeqmlS6pDm+M5hFUCN1G0BlnfEIXCBoO9aPSCgKDj9A5j2z0tkt39o4P/tpk
 XSIoRc+sW3NUgQIuy98AEbLJPkxvbGR9z+cZtZiSsi9MwFBxM3eXL2hDgkr5MkXCFKeSkQPcF
 637SqnjC0iLo5AItv70ivfw14jd5wH+YpNlQjQiLXKqM5ozT6IJkiQ2BQkGV2OAhPFhZRVpQ4
 dOP9eq/9iUjBmjH4CFneDx6EMcmyvJK0p9KvmnlqFpeVa3Az2WNOenOo3JwtS7sQVKzASfwEV
 Qz/+kBRRmZbaYNnI3qfSCol4afaSwrmqwNEUq5MirhXvlKWx4lD2JUoiwNqfeMe1JnqkhPQ5G
 fLUoU5A+hACnPV/VVR+0U6xHSOgF738JKoJBgDFM8J+VLPNOtbFekHml7dsz/gY+2detKdshR
 D6G3vi198cbA2A/w9OaHFbWK/CsdoaHlIM/k/2SIQOg6gkCp87h4oVG1GREfZlNtBU/W5QfNg
 v+yl1iHXMNvso6Z390AX1mRqquRBXERiA==


--n2dkjomquggalyiy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24/07/28 05:51PM, Rob wrote:
> * Thomas Gleixner (tglx@linutronix.de) wrote:
> > Logical destination mode of the local APIC is used for systems with up =
to
> > 8 CPUs. It has an advantage over physical destination mode as it allows=
 to
> > target multiple CPUs at once with IPIs.
> >=20
> > That advantage was definitely worth it when systems with up to 8 CPUs
> > were state of the art for servers and workstations, but that's history.
> >=20
> > Aside of that there are systems which fail to work with logical destina=
tion
> > mode as the ACPI/DMI quirks show and there are AMD Zen1 systems out the=
re
> > which fail when interrupt remapping is enabled. The latter can be cured=
 by
> > firmware updates, but not all OEMs distribute the required changes.
> >=20
> > Physical destination mode is guaranteed to work because it is the only =
way
> > to get a CPU up and running via the INIT/INIT/STARTUP sequence.
> >=20
> > As the number of CPUs keeps increasing, logical destination mode become=
s a
> > less used code path so there is no real good reason to keep it around.
> >=20
> > Therefore remove logical destination mode support for 64-bit and defaul=
t to
> > physical destination mode.
>=20
> Thanks Chris for applying the patch for me.
>=20
> Thomas - The patched kernel boots successfully.  I held off updating the
> BIOS so there can be no ambiguity.
>=20
> Thanks,
>=20
> Rob

As far as I can tell this patch did not get applied anywhere so far,
right? Or did I miss anything?

--n2dkjomquggalyiy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAma141oACgkQwEfU8yi1
JYVczhAAqygUqUks9yM91GUeNN13Fo3z+TmeXSGQJ4PUnHScZCiL+UQJv9QhZIKz
cgGnagOJGS0xG158NY74n7NzymMyfs1jArSGtXrcy/t58c7DecYRY3m18b6SryuZ
lFU4E86CgkZtz7JDElvSyl50/vXq0JcJfxkP2o9/BPTuZg8Qb1QeZSF2EUK90hTi
thz9SQ3nz1JpZJHKXsdDvepx1M7mEPvdYr7e5VSRr3gChmbRArvDUxcVy3SU8zzM
YzE5CaOqQ4UX/92ANK6ohaS13BmURgYWzGbg24xvagDfInTVbS8M77Ko8ilpuBnW
ykHcuoJhCYBB173SR7biUlbndUTzHCOg1jHTsTQuBlJts3p1X3CUKuWY2sy9/QNw
HAsVuZENno8Ps8SVvBBa4seYT9BHdPpqhBEgSnZsdnk1Z0cIKj4H0nelyXe7iaVd
vRLwlYPbf0EeY3oHTfb7AcI9MP5ZkDk/Vr9ap4NH7d8dC99YUvI3onB6STU5SmY1
R5mz/iymhjLDYaqBJ1ySRb6xGtYetxsObsuKhUS1WPe7lovXF2FVahUoN6s7KgNl
gArr1fOtYzrnciM+jMxCazFbP9tFudTpuVv9ot9Ht7g9wLT9yhq5/7RAHzIAiVTa
Wjnh+GQagdNjLoG366/d2TR7ZCc1aBp/IxqBcQfuP8Cagmgv3FI=
=8Vlf
-----END PGP SIGNATURE-----

--n2dkjomquggalyiy--


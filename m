Return-Path: <linux-kernel+bounces-436667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E159E8933
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 03:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D19B816244E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 02:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3383C433BE;
	Mon,  9 Dec 2024 02:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Tjt4rE+y"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2FD43179;
	Mon,  9 Dec 2024 02:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733711386; cv=none; b=erzzMak+hq2+iy+K5j40qoZorqBxZjfOiHYq5Nfrf6qsw+E6CgdNVGCE1NLya3KdVFDnC6yAwiSSItn3mdzj0voisotnldwv+gQ94tQt0Q4oRnDVU9ns9iW3Q/6lOcUfLmG83900Y/2NMp4YVRVCRJmuj5wqHsXuOT/SDVVYjk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733711386; c=relaxed/simple;
	bh=k38WUPNxbbD6cKa3HGr/66zLInk7U6SJunfld1qmoJk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=qdBNKHJSRavphciikeu2Zull3XYjBmD/r9K+HNs/qk/e7W+rpPSWDI+hcupEJeTbllVQlpGuqCFGxRU88OH9qJpd6b3pheNdPxdbgzWdCnLQLrAqJTsNMRtFSUfOQ+U6qLCs5WVKvkMQ4tk9T1rdguqZdjcFtJkfOAYIeh3hWpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Tjt4rE+y; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1733711378;
	bh=oRx/jcL0DiMBKu6MliJznyCPIpW6qeSQAHAbGggrr2c=;
	h=Date:From:To:Cc:Subject:From;
	b=Tjt4rE+y7zLa8g8+giv+BCIO1kT3AbMziSV05uVahxPW56XrAeIoOBOJxZxNIRVyh
	 XgzDGE1cDdIbhrLYu3m3QEjCkGECloiT3C7tPXyLsQVbd+P18BH/XsBFQYX3m0GelI
	 fcnp0AXS4OHYF6XMVYPDHvs2mLYOEHqY5e2erBQ6s3AMqtjcaOc8bdnoM23pxg+w6y
	 H/mbgpryr8+/+sXHnq5YHIMN0ODumXw0RpGN/5qQrzTe0jiavTBnYnitzvgGnWy2B/
	 auTl6viEAMQPq2Tz1vMNnoS9Icrt92bHY+5DHZj1cKttSx2/9pTsotgXZTaaZQNlDw
	 7f3ai1Ttg0X0w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Y65RQ1mB4z4wcs;
	Mon,  9 Dec 2024 13:29:38 +1100 (AEDT)
Date: Mon, 9 Dec 2024 13:29:41 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the tip tree
Message-ID: <20241209132941.58021bb7@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LsgEo4.MV3YldZwULFhKqA9";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/LsgEo4.MV3YldZwULFhKqA9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the mm tree as different commits
(but the same patches):

  96450ead1652 ("seqlock: add raw_seqcount_try_begin")
  eb449bd96954 ("mm: convert mm_lock_seq to a proper seqcount")

These are commits

  46dbe8ab1205 ("seqlock: add raw_seqcount_try_begin")
  5f0d64389e1f ("mm: convert mm_lock_seq to a proper seqcount")

from the mm-unstable branch of the mm tree.  The latter ones are already
causing conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/LsgEo4.MV3YldZwULFhKqA9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmdWVhUACgkQAVBC80lX
0GxJMQf/YMsH6zwcafzij0g85fgVvlOGUwRhvUAcKOkrkZKE7/wAHW/N1SR59JTz
HvALmv716zW0BcElq1SAutTJ5/ebXW6MP09zVF6bOfUOhvheDMJaCck6ylgmCvbl
CT7hTIpI/f4IFVIv0KQ+h6Rq9R/DJ2OC65NR+P5lZP0QjjPU75d8OT5v1RLOuYGX
Sk3BegSyltiDAYy5XLc1j+x5xJmm5niX8X8dS2EDCoqJAG/dhm/XfiqdUs7YUiBp
ITaV5KBUydISzY5tnRlp3UyuzDwl5zLXDYx7glpCLSImOXuwIOrTMJqHjjb48lGE
sDIxXW9Tuh2t60/0YwEeJzEs9Abc9w==
=EPYv
-----END PGP SIGNATURE-----

--Sig_/LsgEo4.MV3YldZwULFhKqA9--


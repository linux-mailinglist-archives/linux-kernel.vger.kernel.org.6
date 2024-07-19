Return-Path: <linux-kernel+bounces-256952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B19293730C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 06:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 855701C20E9B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 04:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DA937708;
	Fri, 19 Jul 2024 04:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nbxBncsg"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95F028F5
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 04:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721364302; cv=none; b=dmc/6Bousw9aEjrxYjiFcRqOhCiYmsgXFbks062VCFxoNacvhfsklQIuAHEqRbdljefjSQilYGyxNqXaJY8FMWquut46/tSD1hn1PRzhDkEcphHGfYfaXnl1OiWDdXYw5hRYmJu/DDopAU6vLZijCn/AbTQivwbc72mfSxhAGlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721364302; c=relaxed/simple;
	bh=cs+zVqvaPJTm9dNKJzNrosYNHQwLFvqmCEFYzdb2624=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rW8moErQpYfslKdgi8wyjojvKF7/beIrk8f47TKicarxzEkQLMBm9mGY4x8ht6x7K9jd+OTfcjI1/BHMv2Cvzs8/1cauhK+1i5SG6GkfXdm5xlVcH02hB96cW/yi+kEacC8LMiqnASKFpT7i5/VndN5OsAgJaW4aY2DoG8XfrsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=nbxBncsg; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1721364297;
	bh=3coruL5Ji/ROGFJRvsooAMyXc4geoz3qlY628p41qAk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nbxBncsgcNUHEuLZ4aGYnFg2fvoz8rV6rC0FrorL4E4zi4y6sSXKlBceR1j0oeHuD
	 gark/2tCqRK/NW/KX7ypySFsIGEqUn5MYbqafRUhgblykl8iE50kxYxazh7vnqYbKh
	 7LZvN4snDSPG1bSqqcKoOQcZqrWAjaCUJAV1hMl3ovFBqHRti6UzQCQFfU4nFosQ1l
	 zCIpgxUmikQ+n4r30T8J83LdoCqHEf0aROSB7v/pOkT1UAFDyNFROtXapEL85cLMjF
	 qiPq2sSozdxupG3Rjov60cOxOdEL3aYbVzCgVkJ+phai2MKOfvfvSPMVBVq4MoDaxu
	 O4aX9mtp37n7A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WQHCX6gfRz4wxk;
	Fri, 19 Jul 2024 14:44:56 +1000 (AEST)
Date: Fri, 19 Jul 2024 14:44:55 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrii Nakryiko
 <andrii@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>, Jiri Olsa
 <jolsa@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] probes: Updates for v6.11
Message-ID: <20240719144455.5db778b3@canb.auug.org.au>
In-Reply-To: <20240719105242.e3c76c4d7958b73ca3428603@kernel.org>
References: <20240716234445.a17a40e8d3d7b4ba5cef949e@kernel.org>
	<20240719102824.1e086a40@canb.auug.org.au>
	<20240719105242.e3c76c4d7958b73ca3428603@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wOq6L6hKN5rAR3GC1YpaCM1";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/wOq6L6hKN5rAR3GC1YpaCM1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Masami,

On Fri, 19 Jul 2024 10:52:42 +0900 Masami Hiramatsu (Google) <mhiramat@kern=
el.org> wrote:
>
> Ah, I missed "script/syscall.tbl". Yes, I need to update it to reserve
> the syscall number on it. (But that did not exist on my tree...) I'll send
> a fix. BTW should I wait for xattrat series being merged?

No need to wait.  At worst it will cause a minor conflict.

--=20
Cheers,
Stephen Rothwell

--Sig_/wOq6L6hKN5rAR3GC1YpaCM1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmaZ70cACgkQAVBC80lX
0GwrGAf/SxtTVKUTfntiuPn2rNVaLkOyrEhgiiHJncSDyaP3C3ELkc9gzVVfSnSM
dQWYv2JCO7MQrVsstNnF7u+/SmX20MPYb94FoZuT+4xBXVwtSkAG1J3TDOmHjQV2
lkZ79ZjSDOLzYQh3nHpiMd4VdevmyQfJWHZYu2IMoN8SeV8VZE9skNOvMIePvIcr
AJPaUSoyn1ZzNFrAa462yLEFbx5m3PdgTNR96LRKa0wLkdbSHBJqIuqSxkdAxWGu
zDTNLqLg3GwCnLHqpKIHRs9zdoR4+Ve0FDkeCohuoRiv+usJNMsJAyuBEydVyFyX
cGZ/ZHcIF50RYFPrg/ufYDOoLc+3Jg==
=1+TX
-----END PGP SIGNATURE-----

--Sig_/wOq6L6hKN5rAR3GC1YpaCM1--


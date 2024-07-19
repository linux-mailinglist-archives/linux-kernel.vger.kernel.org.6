Return-Path: <linux-kernel+bounces-256863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BED1937180
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 02:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BEDD1C20CB3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 00:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427AA137E;
	Fri, 19 Jul 2024 00:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nXkAt3Fc"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A47AECC
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 00:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721348911; cv=none; b=lpFqzCD7RGTjM97B/wiupLO69RRQXjbFg7cbUOnnTUE8Fpo+H0sShHWDk2fNw9UMrO9erwo0Qwn58on9lJ2SAhjhEW3FP3Rudro4Nn/7K026ylA7bkP0DkfTIyQZvWeDOBUb/zAANsvYp1u8i8Na4/dmuy2beco4IvE+EpeyN0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721348911; c=relaxed/simple;
	bh=pgHXLnuXgqEJnT6SyU0T9PKJ6pyN7FkIB7QXrCSMTuY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ATqtmvmOy1WEWT8BSGX1aNrpyX3eYmE67qhq874YBjyzji2/78fCQcVxZClCqIvwcckLAcTr3EwNqt5/NQMI9icu0sMO+rPxYEVpUuS9NIs9ruVct4T4RpZEaHIrFLYSUN7VSuDM8sge5B45vszohduVUE00qIkXiencdN+r7wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=nXkAt3Fc; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1721348906;
	bh=JEqgyex94+wHbVwHrZtVYndua/wqo2jfYIyU2lN7E+M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nXkAt3Fc9z+/wxpZRIAEutoXl+c2m08Nhp+Pa+d9ojFxw5OLD58SIiEU0WvNjWz4p
	 5c7DIWw58i5jIPW40j0+ygrWXRVeGNo5Mg/NKeeKqkxxZ+zfX3MB+5+5kS0/fp7k99
	 29e3AlGeTdtjwUVcu2myP2elm6cz8AOvBjVOp61MzwzHlL5LbldYobBDaM3LedfCbi
	 sEWJNlkLPSkC3qJk01ZpDqztkMPkLD/se+FUgkn3dWF9/LU9o/ulQAFHnGSsj8IpMw
	 T+6bSymvLhvxD055zGH1VlL4r1/T0Yg4CACQWpIuVEDtp108uDjJf+dyGeoYDG7qYc
	 ihezCgvCTBSeA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WQ9WY5j0Gz4wxk;
	Fri, 19 Jul 2024 10:28:25 +1000 (AEST)
Date: Fri, 19 Jul 2024 10:28:24 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>, Jiri Olsa
 <jolsa@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] probes: Updates for v6.11
Message-ID: <20240719102824.1e086a40@canb.auug.org.au>
In-Reply-To: <20240716234445.a17a40e8d3d7b4ba5cef949e@kernel.org>
References: <20240716234445.a17a40e8d3d7b4ba5cef949e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GU8nrsEarRb8cYCZuEydbMz";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/GU8nrsEarRb8cYCZuEydbMz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Tue, 16 Jul 2024 23:44:45 +0900 Masami Hiramatsu (Google) <mhiramat@kern=
el.org> wrote:
>
> Probes updates for v6.11:
>=20
> Uprobes:
> - x86/shstk: Make return uprobe work with shadow stack.
> - Add uretprobe syscall which speeds up the uretprobe 10-30% faster. This
>   syscall is automatically used from user-space trampolines which are
>   generated by the uretprobe. If this syscall is used by normal
>   user program, it will cause SIGILL. Note that this is currently only
>   implemented on x86_64.
>   (This also has 2 fixes for adjusting the syscall number to avoid confli=
ct
>    with new *attrat syscalls.)

But another fix that I have been carrying was missed:

https://lore.kernel.org/lkml/20240717132155.6ca2ce47@canb.auug.org.au/

Just the added change to scripts/syscall.tbl (and obviously needs
adjusting because the *xattrat* syscalss have not been merged yet).
--=20
Cheers,
Stephen Rothwell

--Sig_/GU8nrsEarRb8cYCZuEydbMz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmaZsygACgkQAVBC80lX
0GzDpgf/S2EpbG7P9i/dI1NDcd9NEEqglIm3SYVH4gwKWF3ZrOci811lV/dRAmWa
bZgptZBNUtz8WKyP9PvGtLOc9AYyNZAiInpOVv/tzBbGFnuVnTQI9rPT8+UUPn0S
TDFG6qGxdWgNEvyDBf1chlZGPJlvPRhrSWEgL2zbrInsLpHsebQ/cVHZ7KqKLb0g
M+7QMxwSRS3WLlDOQBRQG9peOFeDwJTpCpVk/AnlpDTsQcNvrxtuyBGBCqYVqjG5
U/P/do3QXRwmBY5V7T1kltUja8xG5pNc2I4cTtNSISYIow1D3sm9cru2kAQsWgG7
9RQcbc0ZmnIPpMJC2fLE87sQsglXAQ==
=ux9Q
-----END PGP SIGNATURE-----

--Sig_/GU8nrsEarRb8cYCZuEydbMz--


Return-Path: <linux-kernel+bounces-373464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B509A56FF
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 23:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E2B7B22334
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 21:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1644019883C;
	Sun, 20 Oct 2024 21:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="crdjJMdw"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115C02F43;
	Sun, 20 Oct 2024 21:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729461329; cv=none; b=iQkGmV2jeOL+cGUhiTtmMoPxS8J7JP/O9uxQM9nE1bwV6JGarIbJra3lu5+2ygYfJARfH+hDNwC0jG9PlkIFDZlUfwXEBau46h8p+X3G+2Boft18rBk7XdhHAkSjKTQxatzn3pzQkHA4YWX7JLS8N7xhHoLeHJqVcoVEmXRW/Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729461329; c=relaxed/simple;
	bh=NOnVrxtLjBpuSvRyDb4z4o1r8GmJpAg9bpp/PsYgu0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=dTHeiSZcQZTdQChpCHek8gw0fgybMGnUShu51rvPAtX1x0vZ5687cQ6jTRLsTuMx5aRDWkLvAgFG6V9b9yxkhHurUAtdKNA/Wy/bc3EY4LxiA974w0a+rkgc0whVDPJ1+c8oJ/j3YGjvKQcpa+6xywzMzDmuiCUd1PwNSI67xP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=crdjJMdw; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1729461322;
	bh=D4qRk1kWd5IIjy1PpvBbGtGD7g8q1Gj31Pnf6NkOaPE=;
	h=Date:From:To:Cc:Subject:From;
	b=crdjJMdwSEYPicPZ6Dx+zuTqnAmccaSsAwS9cH0txH5WjCSEuO7aLcbQhxdiMKvgq
	 qWGe22+/L+0ScICdvYfUgRXChBCSjE/tE6drl3AtA2QpAYON9+64w5yASCiv+mKgXU
	 AwkLkeWRJWX66UobX9eDkXiwNWtq0Ys6vCaUUt87kaE4SyFojEXBMKkAiud7o5ewzm
	 aWrHq1yEdK7UL75N1Au8pbo9hVfxUGQTsvSa8IiJF0f7FiOOZ4LPFEdwuGx/5z8w9e
	 blbSqQeaLK7YEl07EBdRg9NWnQB0EPu0dFgO277dqBDgt5zJh3DHbNfCkmM7rMnVEe
	 w1XC8oKRr+Ebg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XWsgZ3PwBz4wbp;
	Mon, 21 Oct 2024 08:55:22 +1100 (AEDT)
Date: Mon, 21 Oct 2024 08:55:22 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Manas <manas18244@iiitd.ac.in>
Subject: linux-next: manual merge of the mm-hotfixes tree with Linus' tree
Message-ID: <20241021085522.1da72792@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/31p52a3IPBHHdP=2tO3MnsG";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/31p52a3IPBHHdP=2tO3MnsG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm-hotfixes tree got a conflict in:

  mm/memory.c

between commit:

  b1b46751671b ("mm: fix follow_pfnmap API lockdep assert")

from Linus' tree and commit:

  dc68a7b3e7b4 ("mm: fix null pointer dereference in pfnmap_lockdep_assert")

from the mm-hotfixes tree.

I fixed it up (though the choice was arbitrary - see below) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc mm/memory.c
index 3ccee51adfbb,3277454d3585..000000000000
--- a/mm/memory.c
+++ b/mm/memory.c
@@@ -6350,11 -6361,13 +6361,11 @@@ static inline void pfnmap_args_setup(st
  static inline void pfnmap_lockdep_assert(struct vm_area_struct *vma)
  {
  #ifdef CONFIG_LOCKDEP
 -	struct address_space *mapping =3D NULL;
 -
 -	if (vma->vm_file)
 -		mapping =3D vma->vm_file->f_mapping;
 +	struct file *file =3D vma->vm_file;
 +	struct address_space *mapping =3D file ? file->f_mapping : NULL;
 =20
  	if (mapping)
- 		lockdep_assert(lockdep_is_held(&vma->vm_file->f_mapping->i_mmap_rwsem) =
||
+ 		lockdep_assert(lockdep_is_held(&mapping->i_mmap_rwsem) ||
  			       lockdep_is_held(&vma->vm_mm->mmap_lock));
  	else
  		lockdep_assert(lockdep_is_held(&vma->vm_mm->mmap_lock));

--Sig_/31p52a3IPBHHdP=2tO3MnsG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmcVfEoACgkQAVBC80lX
0GzkwwgAk5M1VScHjdF0aalNfQ5Ab/3J1Lb41pmIcJB83Cem3Oky0gqC1uuqFvbY
8FpxTETGlShnfY85xAV0mh2lk6ZBl/tUQryDh16iNIxyxz0uoBq2cXVA9NIY1OX5
Gm7QnTzFSROp9B1y6NbGaprg7vrHpTll0zQOmJTwHF9dMsg1f9pK1TE+Wbzqjrgb
k7onmFgmPpEQgfdFKoYhXtStbmyoaTwA6bt1y/LwI3hRKWrdFy87LxWx2FjFuZBX
/OVhXOW6si+Vj6xizs1XKNNbJdMLr0vC1x9kWi3y8PkU/Y7S+kvZzHvq17919pyu
Eb3V5mKYKwWoyC+WvQFx/jex/9rcfw==
=tY4s
-----END PGP SIGNATURE-----

--Sig_/31p52a3IPBHHdP=2tO3MnsG--


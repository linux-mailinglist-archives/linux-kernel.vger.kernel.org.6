Return-Path: <linux-kernel+bounces-540869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10755A4B5FC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BA4316C118
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 02:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616F514AD20;
	Mon,  3 Mar 2025 02:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="oZ67D71J"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7BF139579;
	Mon,  3 Mar 2025 02:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740967956; cv=none; b=Kl4oFtl2SKXOD02ZxLpU5EnsYgKjoOe2IqhE+OZetyxILzNSk2zmdpVl/v/bts/qsipq+xFe4bQmaH7ePX2Bz9VZejT85Xa2m8qY3Rk4mG53Vy6FE83CSceCcaAT4YKYtNOTI6j9wEnUUm7MxjIZzrf8dFlexhG56PhtHaMOqWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740967956; c=relaxed/simple;
	bh=cZyY6X5or0WCowOJc4+5dJ/g2LRWtOpsEyb2uNJbTPo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=lgP3Rq79yXVeJKMGMww24j3R7DWv9RkdvCXh8HVv4qCZJxLw9+084xSJGtjbsB44ooJWi8Q1BP4uSa8N8BFou9QqZXVLf2a7vstvFoCZrRD5YaLi7PSuKPQIdVVjji03TYG2lhQtfATeM9s7nXVKVCa0Wej724HZBexQRReLAs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=oZ67D71J; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1740967950;
	bh=P6pWr0vI1wgeuCv27TqPbjo0Csg0SDZmUev1mSW46Vo=;
	h=Date:From:To:Cc:Subject:From;
	b=oZ67D71JXzCZ/I4ateJ66LRwUzHnou62dAcU5/IuscIAdBzBCvPxxgnFzgXnuX8wA
	 wWnomDh/sOvtc6WXVzWHCd+Ulv5HGqcOZPWKqJD9BSlANPrkYVXkCIHQuX4aBVZISm
	 tJLK6ysyW8bQf2Uf9lirMSOkuIakhSqqlh7T8/cmju/6znYoAGY9H2ZZDyIKwHEdwR
	 rHb0/gO4n/17Glk4MFBh/Tq3Ofkph/dh4Y8EOl4g7Nh09v8OmywwiR9pVFGF57XBQ/
	 EjMF5+x3Zf+XfcnKdCB1+Erffw2CKZ04p952VZZIhqujfk8CntM00WDBefrSjNYPoK
	 2EGdRLTNiD5Wg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Z5j4t1lhxz4wcy;
	Mon,  3 Mar 2025 13:12:30 +1100 (AEDT)
Date: Mon, 3 Mar 2025 13:12:29 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the drm tree with Linus' tree
Message-ID: <20250303131229.4ebeae00@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=TQbOEJSUTTs+u_8zOlQmB.";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/=TQbOEJSUTTs+u_8zOlQmB.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c

between commits:

  e7ea88207cef ("drm/amdgpu/gfx: only call mes for enforce isolation if sup=
ported")
  748a1f51bb74 ("drm/amdgpu/mes: keep enforce isolation up to date")

from Linus' tree and commit:

  80513e389765 ("drm/amdgpu/gfx: only call mes for enforce isolation if sup=
ported")

from the drm tree.

I fixed it up (I used the former version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/=TQbOEJSUTTs+u_8zOlQmB.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmfFEA0ACgkQAVBC80lX
0Gyz5Qf+OK1bM2hrrhPa7Rqansukt1vIT4ZJHvLvfiXgL7W89B3EVaOkAOu9bhYy
EFW6GRQaIem1M/Sn8Q1LNGEivtp6y7ZjWHWACk4XVxFtPUNJs5Ftf8IJyNcroke8
qL41M8+pGbT61AkGpafranzm6ejvYeQzVwWwaB/Z9RpCCzF8Z2Rd/NjFuT1XbFuO
NTQP2216M4veQ80e4qSX1FGUbimNeNCVtL/ZaP17FERgPxMOHnoQ/qsyW7Jfkq1b
vWioA5qTc3w7sF/lVvJZvKiupDmBK5o7ie0AR4bveqeiSreraUpmU8AtBh7Hj/sX
bpRdFhVbj8fzQmogDaXUs0GQa2E3fg==
=BmVQ
-----END PGP SIGNATURE-----

--Sig_/=TQbOEJSUTTs+u_8zOlQmB.--


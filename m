Return-Path: <linux-kernel+bounces-255236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE32933DD0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDA49283DFB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AED180A6F;
	Wed, 17 Jul 2024 13:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtviZWWc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBA9180A60
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721223755; cv=none; b=fp9Hi55inwH9Ru8tgfvTFF9WVli7++yXkHCDoVKlU121RVCx2K9uQuWjzeNKl6UtpYj7M/iO7yIMbXlzpx1kfquFx2CO39jDO52vQKYg/muinMqzXcLlkfHEiQAHUJFMXkoNmiD6edFcxcICUMp8OXZnI3dWWxMtvwM7NaQHx+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721223755; c=relaxed/simple;
	bh=OUqIMtjVeiKpTtaIAlYI6sa7gaYOLRReI4XGc/N5mfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qft10hn/dc7MHsFcwhKEVbDb4xuMrvs8NCJxaEhOmbL5enGjczI3A/JPtp2865WEk2yetXyr5By3IHB4e2w7m4Iscub4yPee5UiUvKo4qNnCokbxt7EYj5t719Gf6HtK74dQkK3ivvoPsczZUZD2wr5BFOZQdsKAEFa4HJymWn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtviZWWc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3F9C4AF0D;
	Wed, 17 Jul 2024 13:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721223755;
	bh=OUqIMtjVeiKpTtaIAlYI6sa7gaYOLRReI4XGc/N5mfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BtviZWWcIerFEJZYEp6y3kkaTE2RkITWziH5krmkHYqSRBdTk27RunKE+gxGlFyqO
	 7ygIO9Dd1KeaBCCYcPtRPNngcTVXh6nGyw5aS5TJ/iTYbcFCXkeDm7CkG3j5zXHBCj
	 99r1n6EX3zif8auA0YcEoAho6Yt5ymbpPxndSvIUFHadxP0gggQcOamfggCxirYifb
	 AIdeCCjfbqbatvLB/C97rZCcElQwfBK+irz/Zw801Udjc3Gt0W4vz4LHyguE4lvkr/
	 Fwa0d2CdAjfjsFF+bCfnVnk+VdgDP5I26D2dcIeH8jNbp0puwyn5+UQi0tcMjJYC1H
	 ewkQDGvMYsAZw==
Date: Wed, 17 Jul 2024 14:42:30 +0100
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] RISC-V: hwprobe: sort EXT_KEY()s in
 hwprobe_isa_ext0() alphabetically
Message-ID: <20240717-unluckily-collide-1aa35c97662c@spud>
References: <20240717-dedicate-squeamish-7e4ab54df58f@spud>
 <cba0c880-a1b2-4bb8-bef0-d280d87ec308@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QH2DqXGUy+ZdMcY/"
Content-Disposition: inline
In-Reply-To: <cba0c880-a1b2-4bb8-bef0-d280d87ec308@rivosinc.com>


--QH2DqXGUy+ZdMcY/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 03:34:06PM +0200, Cl=E9ment L=E9ger wrote:
> On 17/07/2024 10:54, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > Currently the entries appear to be in a random order (although according
> > to Palmer he has tried to sort them by key value) which makes it harder
> > to find entries in a growing list, and more likely to have conflicts as
> > all patches are adding to the end of the list. Sort them alphabetically
> > instead.
> >=20
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> >  		if (has_fpu()) {
> > -			EXT_KEY(ZFH);
> > -			EXT_KEY(ZFHMIN);
> > -			EXT_KEY(ZFA);
> >  			EXT_KEY(ZCD);
> >  			EXT_KEY(ZCF);
> > +			EXT_KEY(ZFA);
> > +			EXT_KEY(ZFH);
> > +			EXT_KEY(ZFHMIN);
> >  		}
> >  #undef EXT_KEY
> >  	}
>=20
> I'd prefer that to be done after removing the "if
> (has_vector()/has_fpu()) by using the .validate callback for ISA
> extension. This way, you'll have only a single commit reordering everythi=
ng.

Right, and I do have some WIP for that here
https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/log/?h=3Dva=
lidate_fpu_and_vector
but won't be sending that until it's cleaned up after the merge window.
I was intentionally sending this during it so that there would be no
moving pieces for this to conflict with - because it will conflict with
any other patch adding things to the list tails.

--QH2DqXGUy+ZdMcY/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpfKRgAKCRB4tDGHoIJi
0tuBAP4xR2iBKZLXlrM2beOQBYy76+eg35CePlufL/1bi/2akQD9GK3RQVgmlN4X
6n7zSdmdkP7k0Z5bzLQoEOqkHa6ZHgY=
=zp9K
-----END PGP SIGNATURE-----

--QH2DqXGUy+ZdMcY/--


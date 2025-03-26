Return-Path: <linux-kernel+bounces-576479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D802A70FCA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 05:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AEC03B1BE9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 04:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0304165F16;
	Wed, 26 Mar 2025 04:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TGkXtYlz"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FEC13AA2A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 04:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742962220; cv=none; b=ZMax2QebID2hRExwjDu3ADYIVHyama9awvNlTV4cc51RhPX6WwNPdxIa7tt7ffvO+en27sVJm7hXJD85faeZf4lyGp2iIcP6WxPNIzbOM51Mc/G/7lSZpHLvOGuRQZruyX2EUEUG3L7IbGeRfb4fntx00RmvCMQEPqy9E5XOHEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742962220; c=relaxed/simple;
	bh=5OVzdy8+yyhJNUfmHdBUhH2WgwhbQfJlF7HcFu43WpI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VLKomM9qWv5bFT0i77SFCbB9fQfaa9jOa0C3EAmsBvkl0W10ZdIhlkwliQmlZtRAb8U5Y06LPSU3+SmNs519WstrPMtS/u8oRDd3M4H9eAD1a8K6y65UALnhN2svpKf7KE24b27XMLZCEUpDRGloOKMpjvbhWIAzJr6jLCKzY9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=TGkXtYlz; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1742962215;
	bh=NqGabLQDHZ/ffqAij5vltrnM2D9upO51DjEv8gS+HMU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TGkXtYlzUKaOsLKcq8M3thmN0vucVQ6PhFfEZecbrOsoL2qVEq1tyfrgfnqnWNocx
	 4jOwMpceg2ij6qXaoAcU41w0R36twOPwwMe0q64BNtVabnktwdiH2wbYxlXSz0wGj0
	 DecpcA2d0wTezd7/Mmf8Roxl5VmUJ2Nvm7WdmLEVeCrV9AjDgS5puhTBkcLRDL4FYg
	 1o0fvdDf8mPn0g7/7kd5n2ReBzgwaapoW2QZVU9cYBMtUIcWGEyyJlFB4nVQt3VIfJ
	 W0KY1kazjCY65aULI7oHBBe/4yofw97P+3TuglktSKV4o67feMH39BYFHta83GiEhu
	 aa2b0sNntnFbg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZMtc72nb8z4x1t;
	Wed, 26 Mar 2025 15:10:15 +1100 (AEDT)
Date: Wed, 26 Mar 2025 15:10:14 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar
 <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin"
 <hpa@zytor.com>
Subject: Re: [PATCH] objtool: Fix NULL printf() '%s' argument
Message-ID: <20250326151014.6a006c93@canb.auug.org.au>
In-Reply-To: <a814ed8b08fb410be29498a20a5fbbb26e907ecf.1742952512.git.jpoimboe@kernel.org>
References: <a814ed8b08fb410be29498a20a5fbbb26e907ecf.1742952512.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/I0E3k0E5RavfCd8u8OqRyed";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/I0E3k0E5RavfCd8u8OqRyed
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Josh,

On Tue, 25 Mar 2025 18:30:37 -0700 Josh Poimboeuf <jpoimboe@kernel.org> wro=
te:
>
> It's probably not the best idea to pass a string pointer to printf()
> right after confirming said pointer is NULL.  Fix the typo and use
> argv[i] instead.
>=20
> Fixes: c5995abe1547 ("objtool: Improve error handling")
> Closes: https://lore.kernel.org/20250326103854.309e3c60@canb.auug.org.au
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  tools/objtool/builtin-check.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
> index 2bdff910430e..e364ab6345d3 100644
> --- a/tools/objtool/builtin-check.c
> +++ b/tools/objtool/builtin-check.c
> @@ -238,7 +238,7 @@ static void save_argv(int argc, const char **argv)
>  	for (int i =3D 0; i < argc; i++) {
>  		orig_argv[i] =3D strdup(argv[i]);
>  		if (!orig_argv[i]) {
> -			WARN_GLIBC("strdup(%s)", orig_argv[i]);
> +			WARN_GLIBC("strdup(%s)", argv[i]);
>  			exit(1);
>  		}
>  	};
> --=20
> 2.48.1
>=20

Thanks.  I have applied this to the merge of the tip tree (which
include the tip-fixes tree) in linux-next today.  It fixes the build
failure for me.  I will apply it to the merge of the tip-fixes tree
tomorrow unless it has already been applied by then.

--=20
Cheers,
Stephen Rothwell

--Sig_/I0E3k0E5RavfCd8u8OqRyed
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmfjfiYACgkQAVBC80lX
0Gy4pwf6AoT8O92NsoRiihhDMXRi6O9bPSI8byb1JMXkCmS9PsWEPLPKiiJEqd/H
KJ0VhFiIvCdCzKapc3e243YBbLtAMnk0dit1ZPgzL0ZhftPKVJMbHM8bcSQ4/Dvi
tOT3bXY5di616AH0m3iugeLN758Dotc6Lb9RjOnsTLLNzY8zGY+EKZ84AQ9I0GZz
WxgXIOA3pskiXxQkTei4hRbsHVOx3GooctearnSPFQQ71M/tRjBoMvfbk33SA835
p2z4hUFE5W+jx1oaO0vsYvJJUbD4/ynaN5g0nVFWFBvVZwBro+gKLSBctOsilF4o
/Pb3ShMe4eq7nANvrrjo871NygkFvw==
=YIsm
-----END PGP SIGNATURE-----

--Sig_/I0E3k0E5RavfCd8u8OqRyed--


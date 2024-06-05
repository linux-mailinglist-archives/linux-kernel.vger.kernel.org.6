Return-Path: <linux-kernel+bounces-203180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739B58FD788
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7EB2B210FC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44685153BC7;
	Wed,  5 Jun 2024 20:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="jYJ0bS7F";
	dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="KoFkL2S0";
	dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="Ebj0numf"
Received: from e2i411.smtp2go.com (e2i411.smtp2go.com [103.2.141.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF4515EFAA
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 20:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717619448; cv=none; b=W3C0MUACTYFJDIuETqvIRMIzu2eCDNG9Dr0yPPBZ6+DvFbBudu8xccWr5hndUm7t8h7EF7LzeXT4/BJGc8F3i8r6Wntq4whFnXOKVtFKdYFNEF7aONMZkJKQB7Vowvz9U7YOjbMba6Ii+Ot+TMqIhsuIg6TFl2RxvkZO+1zlFqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717619448; c=relaxed/simple;
	bh=mdrU7IXXPrTDsyZxMk5347kg6bKIJX6oSNzN/UsIxz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubx49kYQiBwuo4BcmaYLnpwW//j5YFrn3Bv86brTWrJP0F+l+EPZCohCOPvKT5H5SKewNpAs+PvVA3KTC1QDngqSoCdLnsJcbTqYs52IhJYM8LULKQb9bCNrsyp68VbjtndO20nQn+Z1tfj/JD4W0pyQJ7L283K4UnYvC+d/hAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=em1174286.fjasle.eu; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=jYJ0bS7F reason="unknown key version"; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=KoFkL2S0; dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=Ebj0numf; arc=none smtp.client-ip=103.2.141.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174286.fjasle.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=mp6320.a1-4.dyn; x=1717620341; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=l3p98x5jJGF8A39qDI7zM5bqnbdS9m3RepjjSWwE1i0=; b=jYJ0bS7FkJrzlo6OrMCaW55NGf
	s0BhHeoHX5LC5fEusmbuESP9fQdKqRQ01rtpDDyxFs3g2dKOfrPG50zFMb3jZsDC2qVp+8mrYvg/n
	0idwvfy5dNTGZNmzbK0HsSb6agU0+TMoDQmKMH0fCUWKLjnpK1Jj5pVPFGrSPLV7IQ4m3pv/2ciOH
	8rZGKOCSBTnjkEZs44VJeKg+NIMqgx31bKa2GpiXjZUZ4XgjumOATPIzsEwN6k8PcvOTnyfu8/7Pv
	xjbW2UvOS3uA+VScBP3XF9Cn+pH+pwKPyONiLgzCDMyjb3J4rF3ySZR+jeJG6PLQLXgAGdMfGIgO0
	11dgWpbg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjasle.eu;
 i=@fjasle.eu; q=dns/txt; s=s1174286; t=1717619441; h=from : subject :
 to : message-id : date;
 bh=l3p98x5jJGF8A39qDI7zM5bqnbdS9m3RepjjSWwE1i0=;
 b=KoFkL2S0F6QmTtneETM3CTDjD9/7sw0hCiOHMivDEygqUhTDeXSnBIRuhA/sAasDg+aPE
 eeoEb2EWELM7gkw0l76wD9lg3t7E4DGmSIOgLA7gbmu1V2LxkpMP95h8UXs5mIZgb1s84T7
 DCPFM8/hu1rcUrG15yFcUGylW4bjicgDRmVFNS+Li+bQlB0YT1tzXgfnykrZy7aQKercRZG
 oMNwhR7kjRxSi7jPtcnnqhva4g9JIzoZOTa1pTw6lTLoVBp0jKN+ARFxYN272fT91S2XqyG
 tcexwBBupiy5wkUw2mjg63WfpsY3Hn6nvpnN7l0vttYMlMOj+u8mCKWnRPZw==
Received: from [10.176.58.103] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1sExGy-TRjx8l-Gw; Wed, 05 Jun 2024 20:30:16 +0000
Received: from [10.85.249.164] (helo=leknes.fjasle.eu)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1sExGx-4o5NDgrgOol-sOb6; Wed, 05 Jun 2024 20:30:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
 t=1717619414; bh=mdrU7IXXPrTDsyZxMk5347kg6bKIJX6oSNzN/UsIxz8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ebj0numflf5PFOF+vCHwFrP+z6qd9hYad1YcWXXNzlGoFTtW/GA2jL91z4JTQ/Lr2
 hCZm9xQthuX9qfNWenw4NhXopd87QccM9luPYfC8NfVJJH1gXkl7BN/ApCjNE0eFQW
 PAI2VL5ThSDs7XNpBB+RPbZJntVFzXaZPsDGdkJo=
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
 id D2D13449F3; Wed,  5 Jun 2024 22:30:14 +0200 (CEST)
Date: Wed, 5 Jun 2024 22:30:14 +0200
From: Nicolas Schier <nicolas@fjasle.eu>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] kconfig: refactor conf_write_defconfig() to reduce
 indentation level
Message-ID: <ZmDK1lCE8VRdWmWU@fjasle.eu>
References: <20240602125416.976336-1-masahiroy@kernel.org>
 <20240602125416.976336-3-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hQIwDeXNxeCl02bX"
Content-Disposition: inline
In-Reply-To: <20240602125416.976336-3-masahiroy@kernel.org>
X-Smtpcorp-Track: A9QiPRM17qaP.frfTRJgCMcHy.VgCe5Ql-pd8
Feedback-ID: 1174286m:1174286a9YXZ7r:1174286sd201zyaj4
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>


--hQIwDeXNxeCl02bX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 02, 2024 at 09:54:16PM +0900 Masahiro Yamada wrote:
> Reduce the indentation level by continue'ing the loop earlier
> if (!sym || sym_is_choice(sym)).
>=20
> No functional change intended.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
>  scripts/kconfig/confdata.c | 47 ++++++++++++++++++--------------------
>  1 file changed, 22 insertions(+), 25 deletions(-)
>=20
> diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
> index 25c327ae3c5c..1ac7fc9ad756 100644
> --- a/scripts/kconfig/confdata.c
> +++ b/scripts/kconfig/confdata.c
> @@ -774,34 +774,31 @@ int conf_write_defconfig(const char *filename)
>  		struct menu *choice;
> =20
>  		sym =3D menu->sym;
> -		if (sym && !sym_is_choice(sym)) {
> -			sym_calc_value(sym);
> -			if (!(sym->flags & SYMBOL_WRITE))
> -				continue;
> -			sym->flags &=3D ~SYMBOL_WRITE;
> -			/* If we cannot change the symbol - skip */
> -			if (!sym_is_changeable(sym))
> -				continue;
> -			/* If symbol equals to default value - skip */
> -			if (strcmp(sym_get_string_value(sym), sym_get_string_default(sym)) =
=3D=3D 0)
> -				continue;
> =20
> -			/*
> -			 * If symbol is a choice value and equals to the
> -			 * default for a choice - skip.
> -			 */
> -			choice =3D sym_get_choice_menu(sym);
> -			if (choice) {
> -				struct symbol *ds;
> +		if (!sym || sym_is_choice(sym))
> +			continue;
> =20
> -				ds =3D sym_choice_default(choice->sym);
> -				if (sym =3D=3D ds) {
> -					if (sym_get_tristate_value(sym) =3D=3D yes)
> -						continue;
> -				}
> -			}
> -			print_symbol_for_dotconfig(out, sym);
> +		sym_calc_value(sym);
> +		if (!(sym->flags & SYMBOL_WRITE))
> +			continue;
> +		sym->flags &=3D ~SYMBOL_WRITE;
> +		/* Skip unchangeable symbols */
> +		if (!sym_is_changeable(sym))
> +			continue;
> +		/* Skip symbols that are equal to the default */
> +		if (!strcmp(sym_get_string_value(sym), sym_get_string_default(sym)))
> +			continue;
> +
> +		/* Skip choice values that are equal to the default */
> +		choice =3D sym_get_choice_menu(sym);
> +		if (choice) {
> +			struct symbol *ds;
> +
> +			ds =3D sym_choice_default(choice->sym);
> +			if (sym =3D=3D ds && sym_get_tristate_value(sym) =3D=3D yes)
> +				continue;
>  		}
> +		print_symbol_for_dotconfig(out, sym);
>  	}
>  	fclose(out);
>  	return 0;
> --=20
> 2.40.1
>=20
>=20

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

--=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--hQIwDeXNxeCl02bX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmZgytYACgkQB1IKcBYm
EmnPeRAAnUmonbGlYZfpAdixUvrePoFIE5BKpovbtT+Zt9L37gAXWNqpT5qEA4mY
LbeCsSlHeckJXoSCbDI008J4zm7dGhXVRw7aukQWDMqEfVLtZ7jdOD9CwDQzVMGh
tL/hI5HtJqSJtZHGW41cSFlmPG9We2CeP97zbuUCeY/6aiwyIgRYWsAqhTzL/Klz
mxUEaeQLQQ3BC3RuFZnY9uBMqd2rHY+d03eEgTUaQl7ouGiCdH6vTXBxcAdFURDi
b4olF87uZ8WekGCuycRWcisIylhWIS3PXfljkh57Wl7Hn/ItJC+5rSEaE01ZAmb4
ukk9DUBSmDOKydcDyMlbCnL0yxd8ZAiAXakzyYHRxmayVSQkPUEB0c2OMIqAO6C9
7Mm7720MYd44TpLIdDiAmN7OAPNdJrKlmIeIIVkaGR2QSa9pDoQVfQBhVanZxjrh
GlN4WDPaiM+RBKDUmSwd6m/F+3/Wea60HsQqHwoKVWwAEUnuNhFmYKaus9ItZ7H5
0bh7hnRP6m6qsfNzVpyEhMR1NZse0/xfZRtPd3iwleEDv0qR8gsbfQAnTyN8WIDF
QLcQmsIaKAkwBb1oU/z7qVOs/a+CH9R9BucH50itPQLA40PK5Xo30hofY5ZQOZ2F
/dny5wW2hLOSY/o9rzqeMx2ORDvm3mWOrHSVrq+VW4S5yALkRgo=
=ikzb
-----END PGP SIGNATURE-----

--hQIwDeXNxeCl02bX--


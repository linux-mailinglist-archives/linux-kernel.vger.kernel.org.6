Return-Path: <linux-kernel+bounces-319272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A7A96F9E9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 19:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F38D1C22150
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3D41D5CDB;
	Fri,  6 Sep 2024 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="mwWcw3lu"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA3FE55B;
	Fri,  6 Sep 2024 17:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725643778; cv=none; b=t0FMiPmvGqawtE6V4bQbWpykEM1k7Ky8ZuzybkNN/tx5GXDo/tjijywWiZ+vMrmrhTM+qaZ9lSonZtF8P/XGkVX6o6P/UYpvpZ3tVequH1Mdm42gssu8cw8Ks7CZNuZESOEl37Etgy9emU09omkuEV5FrTYbs7/TZbmXx3bURGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725643778; c=relaxed/simple;
	bh=PImS7UJ48429hdSI7psmmfyEJFCe/jIV68VMqGI9S70=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KPRufohPBht/3JK0O88zH4g1YE0fO36qy0frCwfMlv0P+KW77nIYEiJUHZyBsSR4Tt3dJA7CbDEQQiwAWA4S7gSpIspZTE9MLgSptM6zz27qncP9s5z/d+JSzaijrJA11T9jviXVcpEsDvPjefLKNBMwqAqYgyQEtuKgU7bvSUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=mwWcw3lu; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1725643773; x=1725902973;
	bh=PImS7UJ48429hdSI7psmmfyEJFCe/jIV68VMqGI9S70=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=mwWcw3luUzoMt+vZTtSx77c96wwb0xyp+NKVtorWE+itT2wX4VS64ryYpS02bZxpx
	 +LHVcaPaMrR/6nIqwoMUZ4Ab3qfc74JoXeIU5bHvHx/XAqnMeq7yFH7zWkmhT3wj1/
	 RRbH+RqSRk1k2jmuBdy40UsbKJPT6nksOQ9Ewjj84ktG6rQ3YbtaraikKD3d/JVyOk
	 z05f6v5y4wsrAgYX3o8McXKK1aYGd1iojpCl8QGsXhTQSg/l0YogTfjqKrPPdVP2m+
	 IafRqvuHjXzUxKhnAH+h6p6UN/aFwJZ77IfQHhcsRXwTUuDLGZvYVe1PC9+ZX3pl2h
	 Ju1x/DFqZZXjg==
Date: Fri, 06 Sep 2024 17:29:28 +0000
To: Greg KH <gregkh@linuxfoundation.org>
From: Patrick Miller <paddymills@proton.me>
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, aliceryhl@google.com, apw@canonical.com, benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dwaipayanray1@gmail.com, gary@garyguo.net, joe@perches.com, linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com, ojeda@kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu, wedsonaf@gmail.com
Subject: Re: [PATCH 2/2] checkpatch: warn on known non-plural rust doc headers
Message-ID: <SP3tXoSxg14Ga_W2X_E6G3HpeqZjRVwWUhlMCcUMgDvvJOageFJiaQ1OLnZ0mxKuyueW4z10jZZgGankXKf8ezLTTEbyo_pF7vTbjrt0pZU=@proton.me>
In-Reply-To: <2024090620-clause-unfrozen-f493@gregkh>
References: <20240906164543.2268973-1-paddymills@proton.me> <2024090620-clause-unfrozen-f493@gregkh>
Feedback-ID: 45271957:user:proton
X-Pm-Message-ID: 40dcb189ac704d41f0abcb9d729c4cdc87ef8fb3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------92cba60f43a877a473dc0e95e992924985a3734b9d75f3703e94d444401cdbe1"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------92cba60f43a877a473dc0e95e992924985a3734b9d75f3703e94d444401cdbe1
Content-Type: multipart/mixed;boundary=---------------------b57f89715bba07d51bf9c942a183d4da

-----------------------b57f89715bba07d51bf9c942a183d4da
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8






On Friday, September 6th, 2024 at 1:00 PM, Greg KH <gregkh@linuxfoundation=
.org> wrote:

> =


> =


> On Fri, Sep 06, 2024 at 04:45:49PM +0000, Patrick Miller wrote:
> =


> > Adds a check for documentation in rust file. Warns if certain known
> > documentation headers are not plural.
> > =


> > Signed-off-by: Patrick Miller paddymills@proton.me
> > Suggested-by: Miguel Ojeda ojeda@kernel.org
> > Link: https://github.com/Rust-for-Linux/linux/issues/1110
> > =


> > ---
> > scripts/checkpatch.pl | 8 ++++++++
> > 1 file changed, 8 insertions(+)
> > =


> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 39032224d504..0e99d11eeb04 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -3900,6 +3900,14 @@ sub process {
> > "Avoid using '.L' prefixed local symbol names for denoting a range of =
code via 'SYM_*_START/END' annotations; see Documentation/core-api/asm-ann=
otations.rst\n" . $herecurr);
> > }
> > =


> > +# check that document section headers are plural in rust files
> > + if ( $realfile =3D~ /\.rs$/
> > + && $rawline =3D~ /^\+\s*\/\/\/\s+#+\s+(Example|Invariant)\s*$/ )
> > + {
> > + WARN( "RUST_DOC_HEADER",
> > + "Rust doc he
> > aders should be plural\n" . $herecurr );
> =


> =


> Something went wrong, your patch lost the tabs and it had a line wrap?
My bad! Editor settings strikes again.

> =


> And why is Rust unique for plurals here? What if there really is only
> one example?
Per Miguel Ojeda (who suggested the issue): "We prefer plurals when writin=
g code documentation sections: # Examples, # Invariants, # Guarantees and =
# Panics, so that it is consistent and so that one can add more examples w=
ithout having to change the section name."
> =


> thanks,
> =


> greg k-h

I apologize, first time submitting. Do I submit a new email or add the fix=
ed patch to this one?
-----------------------b57f89715bba07d51bf9c942a183d4da
Content-Type: application/pgp-keys; filename="publickey - paddymills@proton.me - 0xDCA74891.asc"; name="publickey - paddymills@proton.me - 0xDCA74891.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - paddymills@proton.me - 0xDCA74891.asc"; name="publickey - paddymills@proton.me - 0xDCA74891.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4ak1FWWs0UnNSWUpLd1lCQkFI
YVJ3OEJBUWRBU1FhVy9FUmQ4dGZncXNNSHQweTY3ZFdRTEU3UnV2T3gKM2p6YWdhRWI0c0xOSzNC
aFpHUjViV2xzYkhOQWNISnZkRzl1TG0xbElEeHdZV1JrZVcxcGJHeHpRSEJ5CmIzUnZiaTV0WlQ3
Q2p3UVFGZ29BSUFVQ1lrNFJzUVlMQ1FjSUF3SUVGUWdLQWdRV0FnRUFBaGtCQWhzRApBaDRCQUNF
SkVKdFJHcnN1cjU0UkZpRUUzS2RJa1N2VW5DdmU4MDFtbTFFYXV5NnZuaEZpcUFFQXQwVCsKcGdw
MFJvV3dJZm1EUEZUbjNsbVRRcVA0dUEreDRnNXB2OG5SSHBJQS8xVU1YLzh3akZlK24wZUM0V0pq
Cnk0bjUvTmVLcTF6LzhQSnRZYXVzZVZnT3pqZ0VZazRSc1JJS0t3WUJCQUdYVlFFRkFRRUhRRi9m
TnBEZgpsbERSbkhIcmVIdlR0SXRGd3VETDNLWkFhaDhZd3dxV0FyNFJBd0VJQjhKNEJCZ1dDQUFK
QlFKaVRoR3gKQWhzTUFDRUpFSnRSR3JzdXI1NFJGaUVFM0tkSWtTdlVuQ3ZlODAxbW0xRWF1eTZ2
bmhHR2Z3RUFuWkFzCkdwb0w3UWk5VkNOT3Bja3IwdjhONUt4YnNsSUxmZVArMmNJU0hlY0Erd1Rx
WDNsZ3dnNVJDN1lBT1MvUQowQ3NxMGNrT0kwSm5zTEtVWlNyOE5Sb0IKPVcxOG4KLS0tLS1FTkQg
UEdQIFBVQkxJQyBLRVkgQkxPQ0stLS0tLQo=
-----------------------b57f89715bba07d51bf9c942a183d4da--

--------92cba60f43a877a473dc0e95e992924985a3734b9d75f3703e94d444401cdbe1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmbbO+8JkJtRGrsur54RFiEE3KdIkSvUnCve801mm1Eauy6v
nhEAAOiSAQC7RvdqJpdVf7jVhiJbP0U+H9gUzeiCVNKOyq/rjj4PhgEA0VcB
7RH14ZU1Fihr6tG3RAE8/eDBghmh/kkpgDNt/wo=
=pHNQ
-----END PGP SIGNATURE-----


--------92cba60f43a877a473dc0e95e992924985a3734b9d75f3703e94d444401cdbe1--



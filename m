Return-Path: <linux-kernel+bounces-191492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DAE8D1045
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52F31F221F8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 22:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233CF167294;
	Mon, 27 May 2024 22:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVwWWkqI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2B7161338;
	Mon, 27 May 2024 22:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716849097; cv=none; b=dVX6j5wVX1tw+lcb4HjlfadT/gdUKZ/ukQ8c5Y3RyDGj4aKumZiAXOIM3ggxSl33b/6ZHs2fIZXORdWVPuUlRi0UVCviyoYMB07oWksHRza006qRkWiu94SVSS/YMIC9inKO1J7JW89lnFJfQq5a0IV9zfAtP2sgET1eTCb4Lyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716849097; c=relaxed/simple;
	bh=qIiHGScAf9xK3Q5Jsuj5LAVARfVcmDIP34BjvR6r7Ac=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Bo4jpQOKmbmeXPKUKX+i+mzAg6kVVMFq/eLU7IO7QsIdnDBudGKWmIctv3Ez96I5sxTtHUpRJD0YLWzdecVh1f+xiMEw/sElOYmjGn5F6y2ShhApS1X03OSSYATeiPnKeK16tGFYaxJ8bjR/uZ6CkEd/MXvQSIdJvV5NyYGJzGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVwWWkqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C25C2BBFC;
	Mon, 27 May 2024 22:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716849096;
	bh=qIiHGScAf9xK3Q5Jsuj5LAVARfVcmDIP34BjvR6r7Ac=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=CVwWWkqIZ1ZUflGbUlGo8Md8OT4PzyY1MQiaPbUn2g5i/OoXhdLVGqP8ArXg9IQ8p
	 3qagIdTe84AXmCVP0CLwN5rcsxYwpz68as3cgnM0hgGN5E5wfiTkneRafKOSK9flAe
	 iCh8KJlRDCMnMF0yfzUNygbM79yhzIPxa4rDB+NJq6dHibERg4HwYjkWn1pi5av/Zd
	 6Tc8v6kWbxJPFwmVWPYG56zXWzb7oqzQfIEH8r0CA2yRiXyH3EmrOkz9NBDYDaXXYO
	 l/AbS478DpnPVcvj1BfDajFPSGIlMRUnCw5NXOocPiQFLODYxX4jzve9a02UUKaJH2
	 pFKLwMK7U20cg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 May 2024 01:31:33 +0300
Message-Id: <D1KS7LCALKD4.1J13QGYGZ6LBW@kernel.org>
Cc: <linux-crypto@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 "Stefan Berger" <stefanb@linux.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: ecdsa: Fix the public key format description
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Herbert Xu"
 <herbert@gondor.apana.org.au>
X-Mailer: aerc 0.17.0
References: <20240527202840.4818-1-jarkko@kernel.org>
 <D1KQDPOZRWCW.1763CCYF1B84X@kernel.org>
 <D1KRILI1KRQ8.2CNPU7PFES0VI@kernel.org>
 <D1KRXI87G4S0.1ROKTQENIZHT7@kernel.org>
In-Reply-To: <D1KRXI87G4S0.1ROKTQENIZHT7@kernel.org>

On Tue May 28, 2024 at 1:18 AM EEST, Jarkko Sakkinen wrote:
> On Tue May 28, 2024 at 12:58 AM EEST, Jarkko Sakkinen wrote:
> > On Tue May 28, 2024 at 12:05 AM EEST, Jarkko Sakkinen wrote:
> > > On Mon May 27, 2024 at 11:28 PM EEST, Jarkko Sakkinen wrote:
> > > > Public key blob is not just x and y concatenated. It follows RFC548=
0
> > > > section 2.2. Address this by re-documenting the function with the
> > > > correct description of the format.
> > > >
> > > > Link: https://datatracker.ietf.org/doc/html/rfc5480
> > > > Fixes: 4e6602916bc6 ("crypto: ecdsa - Add support for ECDSA signatu=
re verification")
> > > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > ---
> > > > It is a bug fix that does not really need a stable backport. Still
> > > > categorizes as a bug because by following the existing documentatio=
n
> > > > you end up with an error code.
> > > >  crypto/ecdsa.c | 5 ++---
> > > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
> > > > index 258fffbf623d..55114146ff84 100644
> > > > --- a/crypto/ecdsa.c
> > > > +++ b/crypto/ecdsa.c
> > > > @@ -215,9 +215,8 @@ static int ecdsa_ecc_ctx_reset(struct ecc_ctx *=
ctx)
> > > >  }
> > > > =20
> > > >  /*
> > > > - * Set the public key given the raw uncompressed key data from an =
X509
> > > > - * certificate. The key data contain the concatenated X and Y coor=
dinates of
> > > > - * the public key.
> > > > + * Set the public ECC key as defined by RFC5480 section 2.2 "Subje=
ct Public
> > > > + * Key". Only the uncompressed format is supported.
> > > >   */
> > > >  static int ecdsa_set_pub_key(struct crypto_akcipher *tfm, const vo=
id *key, unsigned int keylen)
> > > >  {
> > >
> > > Based on this, is this now along the lines of correct format":
> > >
> > >        *ptr++ =3D 0x04; /* uncompressed */
> > >        ptr =3D asn1_encode_octet_string(&ptr[0], &in[sizeof(in)], &x[=
0], x_size);
> > >        ptr =3D asn1_encode_octet_string(&ptr[0], &in[sizeof(in)], &x[=
x_size + 2], x_size);
> > >        in_len =3D ptr - in;
> > >        ret =3D crypto_akcipher_set_pub_key(tfm, in, in_len);
> >
> >
> > I fixed up the above as it should be only single octect string to this:
> >
> > 	ptr =3D &in[0];
> >         *ptr++ =3D 0x04; /* uncompressed */
> >         ptr =3D asn1_encode_octet_string(&ptr[0], &in[sizeof(in)],
> >                                        &data[0], 2 * x_size);
> >         in_len =3D ptr - in;
> >         pr_info("in_len=3D%u\n", in_len);
> >         ret =3D crypto_akcipher_set_pub_key(tfm, in, in_len);
> >         crypto_free_akcipher(tfm);
> >
> > It fails in:
> >
> > 	ndigits =3D DIV_ROUND_UP(digitlen, sizeof(u64));
> > 	if (ndigits !=3D ctx->curve->g.ndigits)
> > 		return -EINVAL;
> >
> > I checked that in_len=3D67.
> >
> > The tfm is deleted at instant because the above code is part of *_query=
.
> > TPM2 ECDSA asymmetric key that way that signature verification will wor=
k
> > when it is needed. The key type signs with TPM and verifies with the
> > software cipher.
>
> 3rd trial, i.e. no octect encoding at all but with the undocumented
> (in the current mainline) prefix byte:
>
>         ptr =3D &data[0];
>         *ptr++ =3D 0x04; /* uncompressed */
>         memcpy(&ptr[0], &x[0], x_size);
>         memcpy(&ptr[x_size], &x[x_size + 2], x_size);
>         ret =3D crypto_akcipher_set_pub_key(tfm, data, 3 * x_size + 1);
>         crypto_free_akcipher(tfm);
>
> I added also kprobe:
>
> echo 'r:ecdsa ecdsa_set_pub_key $retval' >> /sys/kernel/tracing/kprobe_ev=
ents
> echo 1 > /sys/kernel/tracing/events/kprobes/enable
> cat /sys/kernel/tracing/dynamic_events
>
> Results:
>
> ecdsa: (ecdsa_set_pub_key+0xc1/0xe0 <- ecc_is_pubkey_valid_full) arg1=3D0=
xffffffea
>
> So I guess this is on a right track reverse engineering the format used
> in this API at least :-)

AFAIK TPM2 x and y are big-endian but I have no idea what
ecc_digits_from_bytes() expects because it has no documentation.

I guess it expect little-endian format, is this correct?

BR, Jarkko


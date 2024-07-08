Return-Path: <linux-kernel+bounces-243862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73563929BDF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 046302817B7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C813B125AC;
	Mon,  8 Jul 2024 06:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BAQyB6kA"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4A1C148
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 06:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720418483; cv=none; b=Dt5GZUI9gdtNrdP2Xa7ai4JmOR8dATdsXz90s9hobNT3q+qD5eCmxze+mN+WwAbYxuDChgTILAsfMKqaTEHR4Hi3VIvlOzBQPsorIaCrY74+cICSukJDTSCNu2A6UeyTJVF6ctG/OGyxvxMO5rIN8PfvijHBGWhBEHsZPsx1Ga0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720418483; c=relaxed/simple;
	bh=O2S9yt6j+sqoeTXskQTy+MnfC8JIcR8VeLV6E0CRjQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPEGUIY8TFELOYSqXtQ8tHAdPZS//FcFqeHN1zg4IXmUEwXkZY1jRQp2bmfpf78fwTo6JCXbwptCwYZwySzPGfNJP3dXSBLsqFvG7SXQfZ1qS9yN0Tb18QcePJS5U72VQQr/j6as30guWeMN0dXOLmgZI63rcruh/E2TAwYq6EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BAQyB6kA; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52ea929ea56so3224264e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 23:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720418478; x=1721023278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eN7s1Sf9162VIQBibjFw6vDR+SEml9rfHP4z7qP5f6o=;
        b=BAQyB6kAPJF3nOZQhyz8vJsN4Uk/L5TC3fVdWRKJI0FZkJoBw5itGmqsZIO470nfzd
         qWYrGzCg/OapNIJEutmwmUn1FMnBBwxHS66+TBY+LORknhQBaF+7LCGo5xtD7JDd0EJ5
         MNEZSPES+3cj4+2Y8dfr88xO/7n6MDcCLudcFouNA/fmGRWiQ1XwZPeKTdU+3y3jd3io
         1lC6BQTtmH3sppMDkrO2rODHo1JghROULk5V0Io4XGEuknnzdsE6rsyyhpEHQ0c4QV+4
         wHxxKq78eppLyz1LoyzKsE5EYv0GUoAodP0q2ztx8+rg95l8ld+/x8uZ97AAE5uIKNKj
         UoAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720418478; x=1721023278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eN7s1Sf9162VIQBibjFw6vDR+SEml9rfHP4z7qP5f6o=;
        b=G5XtWwkaK/vKhzv73+eDEn9wta4Fu47kdyB4jkA1E4Dus08RRPLH29mL/IIJLmBAI5
         JAzijB8SqldcwbTyyGaKKngRzbB4vNV572wbIuC8Akczw+VfJpU7hBAtkjihirsPOK6Y
         Gqgz4VBrb9ZCTKVizkdRQDNzW/u0AiNgL6lx2XuKDkqc/yStGO8qqDv0wFgGfGjXKZcG
         V7gZvFK/CcEioipxAjE7AnE1OwS4KfYick3e4Zx73cZzoVxooo/ekBpftrT7U44CiSc5
         jLJEz+yYy0Z1ugdYHOoUoVnz5K97Ll6R6pbjIia5mRgH0vXMOzIyogKsjdTjbyZU0jY1
         +HOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuNitn03ONv5f6WEve5L41f3hngNwA+L0TkDwoIYzZFfI0P9UMT5UDnQLp9WoEAxmtp4X5e471SXbpZWK2NKFcFagL6l/+Yhd43cTt
X-Gm-Message-State: AOJu0YwCIxUQtCHKMD19D2uv0XV2lvnzR3UIaeCdhUt6AyeeaplYYH1u
	6g95oVqI+sp+aC+ApY/P/g2oCZ3nPFxpzm9cij6Nymf3+084Se4cYAaCMuDK9eM=
X-Google-Smtp-Source: AGHT+IE2Q2MUkn0sww+VRfakTHKqqwCWwehjSBC1fRYw1FLhy0Rl2iQUjDLGYeXWll6/dJkLSPZWyQ==
X-Received: by 2002:ac2:47fb:0:b0:52c:e080:6a07 with SMTP id 2adb3069b0e04-52ea0632f61mr9132147e87.39.1720418477535;
        Sun, 07 Jul 2024 23:01:17 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:7e44:f701:52e9:e297])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77e6a6ecddsm175173966b.149.2024.07.07.23.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 23:01:16 -0700 (PDT)
Date: Mon, 8 Jul 2024 08:01:15 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, jacob.e.keller@intel.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH [net] v2 1/1] net: ethernet: lantiq_etop: fix double free
 in detach
Message-ID: <yf42hl2qh2ah2egswvlzscpywtooo4zqod2trx3hpmrf4fj4bd@zesc4vyus3le>
References: <20240707161713.1936393-1-olek2@wp.pl>
 <20240707161713.1936393-2-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="erxnqvdkhak7lhqy"
Content-Disposition: inline
In-Reply-To: <20240707161713.1936393-2-olek2@wp.pl>


--erxnqvdkhak7lhqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Jul 07, 2024 at 06:17:13PM +0200, Aleksander Jan Bajkowski wrote:
> The number of the currently released descriptor is never incremented
> which results in the same skb being released multiple times.
>=20
> Fixes: 504d4721ee8e ("MIPS: Lantiq: Add ethernet driver")
> Reported-by: Joe Perches <joe@perches.com>
> Closes: https://lore.kernel.org/all/fc1bf93d92bb5b2f99c6c62745507cc22f3a7=
b2d.camel@perches.com/
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/net/ethernet/lantiq_etop.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/la=
ntiq_etop.c
> index 5352fee62d2b..2a18e473bac2 100644
> --- a/drivers/net/ethernet/lantiq_etop.c
> +++ b/drivers/net/ethernet/lantiq_etop.c
> @@ -217,9 +217,8 @@ ltq_etop_free_channel(struct net_device *dev, struct =
ltq_etop_chan *ch)
>  	if (ch->dma.irq)
>  		free_irq(ch->dma.irq, priv);
>  	if (IS_RX(ch->idx)) {
> -		int desc;
> -
> -		for (desc =3D 0; desc < LTQ_DESC_NUM; desc++)
> +		for (ch->dma.desc =3D 0; ch->dma.desc < LTQ_DESC_NUM;
> +		     ch->dma.desc++)
>  			dev_kfree_skb_any(ch->skb[ch->dma.desc]);

I liked the first version better.

If you care about the line length make it:

diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lant=
iq_etop.c
index 5352fee62d2b..3dabe56d6f62 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -217,10 +217,10 @@ ltq_etop_free_channel(struct net_device *dev, struct =
ltq_etop_chan *ch)
 	if (ch->dma.irq)
 		free_irq(ch->dma.irq, priv);
 	if (IS_RX(ch->idx)) {
-		int desc;
+		struct ltq_dma_channel *dma =3D &ch->dma;
=20
-		for (desc =3D 0; desc < LTQ_DESC_NUM; desc++)
-			dev_kfree_skb_any(ch->skb[ch->dma.desc]);
+		for (dma->desc =3D 0; dma->desc < LTQ_DESC_NUM; dma->desc++)
+			dev_kfree_skb_any(ch->skb[dma->desc]);
 	}
 }
=20
Best regards
Uwe

--erxnqvdkhak7lhqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaLgKgACgkQj4D7WH0S
/k5YXgf+NSZrDYyJbVx8ndzBiZLfrsrUw9+hoHiX8JdxLY0GPH5oRm1qyzIKzv21
ngTUQvrLdRgp1LcC4Lb7RyTvfwzcNa/Fv9Lh5FdKmwWG6021kH55jSNheVb9YmpD
pz71OPuJqvII6C2ML+EPD7kBFI1EoOAxQDEwwQjceQppRUI0o15vtGkYO6FmF6sc
G8aM5iXlNjGsobN+IM3l9NQpd5V+JiTILJiySZvmvtyaUPYL0EL9X5CfbnhyEvM7
WtM72v7D1CBtKFqKHmrwKdvsxXwC7BNR9V7Jx+/LEXfXHbCDUtbGmG5MU/MTI16q
twghFtjhojdchJv6znQ3c20QLS717g==
=XkV6
-----END PGP SIGNATURE-----

--erxnqvdkhak7lhqy--


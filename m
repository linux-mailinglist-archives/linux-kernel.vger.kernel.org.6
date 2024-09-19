Return-Path: <linux-kernel+bounces-333520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4516F97CA27
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 15:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D27DC283F9B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 13:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6706819E7FE;
	Thu, 19 Sep 2024 13:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CI8JxwF2"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C5D45C0B
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 13:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726752388; cv=none; b=kDMDSLQnEuXHsPWUaXePJmofFsmeWflsvJxyfP5gn8B6EC9qWiI+DVGFEFW4JZDQxyIcENS6BmUIr0/jHYD1chfLQNyiHix/Mzd9LHhi6rhpUZ49UMHVgbFkOmeCdth3xhItHozFdbz851d1TCF+IILvOHhqQfoTQb7lVV+X1jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726752388; c=relaxed/simple;
	bh=fq247Ts16yy6Gu/W66bUmWm7J1owns0OHqbZqz1OChM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nye/WatVfjo4rI6jNPK9Vvap/lrpFPfOOfmSbQIwXkGIpOf7Gsh+qrKAvgUsbMXyD32O6gEMQ1mW2tgw5pwTqvyV7dJlA1db3H83JfXrVkQ4JvayvJdjqJ8X0N+I0yXWsusSf8Muq3FgoJP2iAnIAsMvGxhzx3uZvtBpSMEIao8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CI8JxwF2; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c241feb80dso3930292a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 06:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726752384; x=1727357184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CxqgBeByiqEGN7btCj/bU6+qAg4akgJ/31iLPDvaLhw=;
        b=CI8JxwF2tTGtxIeCl8XbPZnQMb1fRRgfRhsQLzFHRyGFVTy4CN1TCFTlpDZVBg4z3y
         eQpfW3RR+rWnxwuCcumeWxy7gM0oyZilydJezD8oecKRxecGGjLU1zU5qT1ppTCumK/h
         zuipNdi2tg2C55fGF93QrHoSwAB87lmj9SMo7wzvVECdX9J/DGnaCsZ2IV/9nLG9/p5w
         rEY1zwr5V3DXl9bLcu9SZQydjYvpk5inJWWMzhyGm61MgeXE7l+e+0qQH18l4t7E/Bi8
         BBJDSxEi7Fat/bKr+5RO7TMQGQVibTulmU1Fmrkd/JHkCeQp4wpnC6fp5O3a+yaq37iE
         oQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726752384; x=1727357184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CxqgBeByiqEGN7btCj/bU6+qAg4akgJ/31iLPDvaLhw=;
        b=UnQUmk2xVZb0h2/imNvcqDKSp4r01egwCEaePhC7sh9KXgd23hKvkJgKG7CEiIm4A8
         pNv/oFFoGT2QDYXpa0s8dtWUfgGSToV/Dy0kk2v6rMPM8rpP6EnaYbvbKP8Jju4rRTd4
         5ocZH8EOjjCiDpdxG54Be0vfUhT1Hh8wF5PRBxi1P030uBz89T4tSh2oBs3X0ZPX9HdJ
         EWIThCkwmLFqWLZU8Fg82SUnad4XkEA9D4c7a2XABAZTlZt1EwOJjs6t567TEVXwuQG0
         QD2PUwO4KOBJ5xhKiFTSB5zq7zjfir1cAv7P0IV3YbjtzsMmLdKPJsYKwiHntsSANXHD
         kbRw==
X-Forwarded-Encrypted: i=1; AJvYcCXeTVl6Lwo/6R6O1S4i2qKfPYDOIWuGIGyJGfhGJ5PFpeWbFWTfqv4H/QkIstkCW+lbBlWs5qopEZ5t26s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjwtu2GcKa6crkfqaQHcg4nDf5DxlKzdBqIb8+IWB0shHvGpue
	v9d66JDkizQX9aAsfi+Cgf5ke81G8xNyG2L6NsKMTspvYWOqlEaQ5hJ/4eKyHfo=
X-Google-Smtp-Source: AGHT+IFLarCnOacvRt1Pc8xDIhYuWcNW+sbuUln+ZBlKC/vL9ZzdFB4p9yXoeNYHkl4c9QklvQ4Zlg==
X-Received: by 2002:a17:907:94d4:b0:a90:126f:bcbf with SMTP id a640c23a62f3a-a90c1c77f83mr274686966b.10.1726752384267;
        Thu, 19 Sep 2024 06:26:24 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:3d88:df0a:afe5:8794])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612e7c72sm720216966b.187.2024.09.19.06.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 06:26:23 -0700 (PDT)
Date: Thu, 19 Sep 2024 15:26:21 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH] firmware: mtk-adsp-ipc: Switch to using dev_err_probe()
Message-ID: <4426qubj6oy3kwrxtzjyc5imhxhmgapjibbv55gig22pxfrjrm@qhk7larn3qnk>
References: <20240919120208.152987-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x5s3i6p4o36fjocm"
Content-Disposition: inline
In-Reply-To: <20240919120208.152987-1-angelogioacchino.delregno@collabora.com>


--x5s3i6p4o36fjocm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello

On Thu, Sep 19, 2024 at 02:02:08PM +0200, AngeloGioacchino Del Regno wrote:
> There is an error path that checks whether the return value is
> -EPROBE_DEFER to decide whether to print the error message: that
> is exactly open-coding dev_err_probe(), so, switch to that.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/firmware/mtk-adsp-ipc.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/firmware/mtk-adsp-ipc.c b/drivers/firmware/mtk-adsp-=
ipc.c
> index a762302978de..fdb083f42ebf 100644
> --- a/drivers/firmware/mtk-adsp-ipc.c
> +++ b/drivers/firmware/mtk-adsp-ipc.c
> @@ -95,10 +95,9 @@ static int mtk_adsp_ipc_probe(struct platform_device *=
pdev)
>  		adsp_chan->idx =3D i;
>  		adsp_chan->ch =3D mbox_request_channel_byname(cl, adsp_mbox_ch_names[i=
]);
>  		if (IS_ERR(adsp_chan->ch)) {
> -			ret =3D PTR_ERR(adsp_chan->ch);
> -			if (ret !=3D -EPROBE_DEFER)
> -				dev_err(dev, "Failed to request mbox chan %s ret %d\n",
> -					adsp_mbox_ch_names[i], ret);
> +			ret =3D dev_err_probe(dev, PTR_ERR(adsp_chan->ch),
> +					    "Failed to request mbox channel %s\n",
> +					    adsp_mbox_ch_names[i]);
> =20

Looks good to me:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Best regards
Uwe

--x5s3i6p4o36fjocm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmbsJnoACgkQj4D7WH0S
/k6JyAgAs8EPVGdHwR2cB7KuBTWmMoG7vZXS/QNTBCOM2liWpNQWO3y8vgj+52UQ
cRsevvScsmaqeEYiot0086YWIUKSQbdjN5s51QXWDI3Jys4jU/T1f67zoD7tY1Xi
FtOzWIp28KYnKEYdQ44oAA18QCNAj1A61PUHyZEgcM1SMJKq5B71xq0c3rjz4MXW
eDiIARnloVG3n2kZ96CM1e1OwfkaOChFG+1aQwZX5bU3NNJAjTXAuvNI0jqEIiOt
doQTaQU2nTsDSMsySjzzZKUNv/eiaNGrfuFmThYrslPo3/dIRkUaxyIp4EP5lmBp
iDa9Eph0rYL3PLm+lXexsm3J+bcmdg==
=NQRs
-----END PGP SIGNATURE-----

--x5s3i6p4o36fjocm--


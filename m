Return-Path: <linux-kernel+bounces-381875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 365689B05C5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62BB91C227C4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDED202648;
	Fri, 25 Oct 2024 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Tb792vHT"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7480C1D90DC
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 14:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866435; cv=none; b=d7gHaSTMdr7lrI2qJY79SUWdG4s2KEBgD3Y+Iy9xhPfVePWzSJ2OAcxmXBCee0mpY4dp39GGanSq+fI5R4dkdJP4pK09P7whxtguym8NuqL9YRPGGWO0wd86Xg3Rt+ZB7/xfUCuy0qOia319agzDnx8eewDZmvOaT0cfeHmajjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866435; c=relaxed/simple;
	bh=cYrU01+vs8JnT1+0uzUTRHT5ISaLXhGhS9KnyMKjeWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3KBFXvMox2Py/7C4mfbPvQUiKC5T5rP8aPQQzoPtgslnZqsoQgc3EFrawodcYbytjjW+sPvhprVcfG4hwWTLmc44ZZu2klIQ8fanHOj2BAFcfeqJ9Zz6rmo2esG0Y3DjDTYMufkEsBZlRunQlAWJjbI+S/RclUG1ckYFYwzRKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Tb792vHT; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4314f38d274so27331735e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 07:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729866429; x=1730471229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cz/ZpQzkOEXhpSATdwYFTyjss6etUyLHorpfFXwy6YY=;
        b=Tb792vHTeufKBmye4pbjqoGoxerwFHxaJFJ5l/rRNkJjTzE3CSzoCp8jl71Uacqyk3
         06kHMbvFECQw9Te1VhPR7jCZzjz/UfO52YYnnsZtwmTFjak7/8h6kUuRziNoK8EkvGiu
         QOIsvToYYA6LCyqR4EQKYscHoaoMufkcxTIhw1s65ZOPvuQFJri6vQila40WvgVcQwqL
         Bp2WtmzNb7D5qVDyAG4uPEim8HCE4h1bzmoaOijayfVQBV/5JHI+21mdDtoXcfx8MkeS
         /mJ1jb0M0AyY0fJdU2NDwbuZiTFPq6qLmmspS4MClHiuKeN9wMuFWksRQIW5ZoJv/YZf
         oiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729866429; x=1730471229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cz/ZpQzkOEXhpSATdwYFTyjss6etUyLHorpfFXwy6YY=;
        b=GyVp0+F88V56+KDYfJmC/NGTx2lzPefeYPViMTrEASNiPp/LEPUDEzbWNPgyth+YGK
         YbfEtiM4UjshJBojp8yEhaxxzGx634gNXYyaVNse0VpgvsQdqBbuZJd89O57PjsAuHFA
         j76uTM00TVPyR0fUVXMnyeeELmbxql/ZpOr2ogIs6w1u+fjcdWA+uML99wgCiAzFMLIg
         VAIYonr0xy/aIaphMLb0Se1GBSErcC14oW+U28vjCQVlwqTTGKO1SCgz2TboyjWlex+H
         Ux38dyAg1fW57IHQcyZEJHJKACEx5CakFFmLxsy/iLcsNS847kaX4ihWW3NGl/JO0ylS
         eHRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVo57qoHaO5cNoj8naWYUj7YrrviE5tL2EGvCfI+02aQdkI1Fg9yeeRUN3XT1Xe8UAcTgbiYat9EqXotJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpDbsfonmPDVxTwVcvbQfOx/af+pIOCOORtSBtpWAcPMLTShn2
	tv4SIpwa85mk6Zo1EWdQTAHmyKHWjhTLpM5tJDmNX32AicB2X/bRu0Q+I73UM5E=
X-Google-Smtp-Source: AGHT+IGzqbaTc2261LLl/UzSQw5vuy2RdBXHXX++uxU+WMogRjLSB/WntDtfLaLSBitiwURijkqQdg==
X-Received: by 2002:a05:6000:1f86:b0:37d:5359:6753 with SMTP id ffacd0b85a97d-37efcf06030mr10257560f8f.15.1729866428773;
        Fri, 25 Oct 2024 07:27:08 -0700 (PDT)
Received: from localhost (p50915d2d.dip0.t-ipconnect.de. [80.145.93.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43193595470sm19151505e9.15.2024.10.25.07.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 07:27:08 -0700 (PDT)
Date: Fri, 25 Oct 2024 16:27:07 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Zeng Heng <zengheng4@huawei.com>
Cc: jia-cheng.hu@intel.com, gregkh@linuxfoundation.org, 
	quic_jjohnson@quicinc.com, jinqian@android.com, alan@linux.intel.com, 
	linux-kernel@vger.kernel.org, bobo.shaobowang@huawei.com, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] goldfish: Fix unused const variable
 'goldfish_pipe_acpi_match'
Message-ID: <ttlc5ppgljd3plbk6kw4ndi47pqafivtxk2sosdhlw3zeda273@dn74s3eluxqp>
References: <20241025074129.1920707-1-zengheng4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hit3xbxtw6ye6c5j"
Content-Disposition: inline
In-Reply-To: <20241025074129.1920707-1-zengheng4@huawei.com>


--hit3xbxtw6ye6c5j
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] goldfish: Fix unused const variable
 'goldfish_pipe_acpi_match'
MIME-Version: 1.0

Hello,

[Cc +=3D Andy]

On Fri, Oct 25, 2024 at 03:41:29PM +0800, Zeng Heng wrote:
> Fix the following compilation warning:
>=20
> drivers/platform/goldfish/goldfish_pipe.c:925:36: warning:
> =E2=80=98goldfish_pipe_acpi_match=E2=80=99 defined but not used
> [-Wunused-const-variable=3D]
>   925 | static const struct acpi_device_id goldfish_pipe_acpi_match[] =3D=
 {
>=20
> Only define the const variable when the CONFIG_ACPI is enabled.

Note you also need CONFIG_MODULE=3Dn to reproduce.

> Fixes: d62f324b0ac8 ("goldfish: Enable ACPI-based enumeration for android=
 pipe")
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
> ---
>  drivers/platform/goldfish/goldfish_pipe.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform=
/goldfish/goldfish_pipe.c
> index c2aab0cfab33..aeabacba3760 100644
> --- a/drivers/platform/goldfish/goldfish_pipe.c
> +++ b/drivers/platform/goldfish/goldfish_pipe.c
> @@ -922,11 +922,13 @@ static void goldfish_pipe_remove(struct platform_de=
vice *pdev)
>  	goldfish_pipe_device_deinit(pdev, dev);
>  }
> =20
> +#ifdef CONFIG_ACPI
>  static const struct acpi_device_id goldfish_pipe_acpi_match[] =3D {
>  	{ "GFSH0003", 0 },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(acpi, goldfish_pipe_acpi_match);
> +#endif
> =20
>  static const struct of_device_id goldfish_pipe_of_match[] =3D {
>  	{ .compatible =3D "google,android-pipe", },

Looking at changes like
https://lore.kernel.org/all/20241024130424.3818291-11-andriy.shevchenko@lin=
ux.intel.com/
I suggest to drop the use of ACPI_PTR() instead.

Best regards
Uwe

--hit3xbxtw6ye6c5j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcbqrgACgkQj4D7WH0S
/k6Enwf/RAoLI8smEpzIHrmCNNbja27SEkWThWWrEcuCnZwWPeroRDSZUI3wYWsR
0mwxEiREvLdf4wwUUk0uN0XDjdw7pUVhti9erQxiK64kmJp0D30crzhTB4z6Mn4l
CV0mhOzGwUPkW4Q+2Yetw6YE8tsl/Bdco8aPVXsVlAfvg3vqZY1G+X7YKUdjYJqo
JpKz338wqXjP6qK2y4urHhYWkG58FDAxD7kK6QH0QyJzCn49ZOkxmpdleYd46Ntf
2fDSG7s91OfF9N3qwetUlHThpvQ/O5HTedpf/wT57dvEqbDspphkMd9H+zMwUAAA
/Sv7cZUrrSwRsYt6ggfXLuxdS65enA==
=/oPB
-----END PGP SIGNATURE-----

--hit3xbxtw6ye6c5j--


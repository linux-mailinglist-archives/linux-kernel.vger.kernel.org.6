Return-Path: <linux-kernel+bounces-353568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D49992F89
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A537B202F7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DF01D5CD1;
	Mon,  7 Oct 2024 14:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zRHX1B2D"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39577F50F
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 14:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728311915; cv=none; b=NizR6u56eEjdJO/t3gh6UvEo2B135Q5hgDWjI6+SuWhTgFkmx06htZbEJ1Ghukc/9zv6oQzR3ZTLz5NhweKJ17xkN1C6RAd/6x6onBOkOmqfsFGO/XxPvLtZuFOQ+4DGNl7KtVz1sv1SYfsVudWnoZh2JVeJoijR2RByYatkU3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728311915; c=relaxed/simple;
	bh=NorN5g77MRFOGCV3RAcQIbEBQCvwltowLG85qpRMvo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHMWD1MMBMRfIS2Je246YfVAtPr9iThC0aumj/veMsi6VQDtUpW4R5Xm9hM0gvZ2uB1Q+zZswht7T1oJG9qmwz3aO2Tty/sf1nBAvjovmTMIlnTCRmQmwMXkAw51Dsm/6JnFXfE6lK/PjACx00qBFmRQt4/XbNp3CsngFOrT9OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zRHX1B2D; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cbe624c59so39088745e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 07:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728311910; x=1728916710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UIZjUi4+ZJvfUpBU9pJXCtXeXIdn9Bs3Tlg34HIba6w=;
        b=zRHX1B2DtD9L5VuH0Ib+FSf2GtNVHmRcQaHBj56r8PgxE1R1pBmNdfFJscF3cakR8A
         an1gm0lCq5mf/DwKhHHSIz8Ihkj3PqgN7ztHIfDJ7DJiGw3VCKp/hE8o8RF6+xQ8nHCr
         ohykQcDnutWzqHeMKoqwp4Rg6QRDtCsJ4dynJcwRTTIac+G8blWViZT/2zq6mSyfPkGu
         4FMPNCn48fTY2i+wvVarRYQyyb6zsETXEzR+NM45lrLGdc8t2ZGdzHiXWf0X6otAzJFP
         9q/PX48Z6XR/PcjblPIJiuUO1wqzTdKduhkfVge8kKd061KsV5HbuObVLdbh7nVSUVbs
         01AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728311910; x=1728916710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIZjUi4+ZJvfUpBU9pJXCtXeXIdn9Bs3Tlg34HIba6w=;
        b=Cg/WRHOhDba3NgpSRIZBdtEUr6+MLJ4roScnMa7sOwwyWc+3smhnchiBurAyvagp1l
         /ux4kEhxYNgeeboYms+ScKiLgWiZNRA1GPz4nKALCzUFqiSe49zIYHzcy7pOTr5qcq/G
         igtrmV7l7kuIvm9UbUIny1pp4PYd33Hc97CddLoZkoE4khxtvk34+k8JzOh/Qn/0hY+p
         rCOGdtboWf2uXy9R03dr0fN1Y/67ewf9av6euhidO7N5N0Pwh+xCqrik7L2Nckt0Bz0J
         QdC5c9ZdpbItko5HG+hirPRPdlORhyxeKZKSdIIv7C84n83Gmi1eqRhYB4WM5TH/f1/o
         hMhg==
X-Forwarded-Encrypted: i=1; AJvYcCXsYEYHwg6fR82pO3SI+ZgupMWpw6SFFQpm/FwyieC3nH/xY+6rvbUqxoT3gkD37G4wyYtGnSSXh79Ka/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg1ChCmT2c9NIAz1pRxeTz2o3YucltMCctLMbqiPlrUprUQ68T
	zhsF66DKK9GlB6eNoXzfXiibqurZorZKOWbhrOW+sFuz8HiEc5W9Pgq7wuKrKN0=
X-Google-Smtp-Source: AGHT+IGfZvYFYOO0yH3239TeRsJPqii0ekScAJEHHk+kwZ6ayGnYWFsKdJeGmpeFVzV11y5uKBs5Cg==
X-Received: by 2002:a05:600c:5103:b0:42f:8e2e:c00a with SMTP id 5b1f17b1804b1-42f8e8adaacmr40665965e9.2.1728311910164;
        Mon, 07 Oct 2024 07:38:30 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b1d672sm95080335e9.28.2024.10.07.07.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 07:38:28 -0700 (PDT)
Date: Mon, 7 Oct 2024 16:38:26 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Armin Wolf <W_Armin@gmx.de>, Guenter Roeck <linux@roeck-us.net>, 
	Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: Error "ee1004 3-0050: probe with driver ee1004 failed with error
 -5" since 6.11
Message-ID: <znkp6x44lnrvn4c7xnb43kiwfmyp3ovsnzi37xgaw3eyvgcm6z@pfxbrniec7jf>
References: <D4G7XD1WU5GY.D22KFST6MHIT@cknow.org>
 <2024092616-showing-fragrance-f70a@gregkh>
 <D4H312REVAZ3.3JWUT4NMWDA7C@cknow.org>
 <sr6p4lwnlznee73t4jof537dcwdl6m6vxriwk3pk4dnlxyaih4@6wv52esrfpyq>
 <D4HPXGCB5GGE.1KQFZR61CHMVF@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n5ahkixglsqj3dn7"
Content-Disposition: inline
In-Reply-To: <D4HPXGCB5GGE.1KQFZR61CHMVF@cknow.org>


--n5ahkixglsqj3dn7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Diederik,

On Sat, Sep 28, 2024 at 08:54:12AM +0200, Diederik de Haas wrote:
> On Fri Sep 27, 2024 at 11:59 PM CEST, Uwe Kleine-K=F6nig wrote:
> > [ extensive description on what to do when git bisect results
> >   in a merge commit as 'first bad commit' ]
>=20
> This is awesome, thank you very much :)

Were you able to understand that, or did you just bookmark it for the
next time? If you still have questions, don't hesitate to ask.
=20
> I haven't made up my mind yet whether I'll apply it to this specific
> issue. It doesn't cause any actual problems (AFAICT) and most
> importantly, it seems to be fixed in 6.12(-rc1) already.
> And the 6.11 kernel is only a 'temporary' one which I don't care (much)
> about, while it is fixed in the kernel I do care about (6.12).

It might be beneficial to find the commit between 6.11 and 6.12-rc1
that's fixing the issue. That would allow to backport the fix to 6.11.x.

(No need for a complicated procedure as I described, just bisect between
6.11 and 6.12-rc1 (maybe with "new" and "old" instead of "bad" and
"good" for less confusion)).

Best regards
Uwe

--n5ahkixglsqj3dn7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcD8mAACgkQj4D7WH0S
/k6Tfgf/bFhoj8Bbvjo5WlXhKCAx6wEEDdbtAy5N0LtxIag1UyJcKtVEaD1Ib5GS
fzrKeFDnvTkAsnAEO/4SDRs/SWmVVvhZxGo3+AtewuoF9JeqJcLKGApSyJRU6zjW
lZc2EIqRtbNdkXUGLGv9aSSGT9G3w88bVaJml0lUhl0klo5p8UHo8ynrGO0YNqQl
pDW/yo16RbTrHcQURrsN+LoyMJsJF2lcwK2bW3TNrGwkJSt3DBCT+p6E3kMIytsd
zfzsOzU3YYJpctBITQKxR84hhtKxwSpSm6YMEaM0TeTNSZ276TtrRgvJ82msB1MF
P1WJfIQ8z2u0Od4IXdd7DGW8V0PGOw==
=rQ8i
-----END PGP SIGNATURE-----

--n5ahkixglsqj3dn7--


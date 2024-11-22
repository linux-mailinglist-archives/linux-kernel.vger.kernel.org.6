Return-Path: <linux-kernel+bounces-418665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5BD9D6409
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 19:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDD1F282175
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B211DFE02;
	Fri, 22 Nov 2024 18:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZsdFvC5T"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6521DF75E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 18:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732299397; cv=none; b=YDyErcofC1rNSFAnC+hl5yFfMMX31cpbPO3C4comJ336PXuB4vBmYJWQl7kO5jXaGMqZ1Mt786N/tY8TybGXlPsTbMz6oRN/aXsfMwNaNJKx3jEQ1M2dmZBCsLiaIvADXB15tVJSPUzEvkCn5CfbsaI4NpXNXeN9wSgXyDKreIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732299397; c=relaxed/simple;
	bh=aM47pbPVNtrMOQanMHQ7ktZXfApmfUGeliGraS2mMOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bO7AggTbx0Z526lrEKldZBgQ9tg6PdwuB8Rvyq88l8nS2xC0h0dGwwI4+cQjTaUBzS5tnCDWSGW8pdhMDuRkiyalNlB3eNYmanzZQbkUggX10+scv4J+erZCtbZdpiYhTNEQ9cGCxLCE6WYUkear6KrMqd9xPvSkTi9RDTJNkME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZsdFvC5T; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43159c9f617so19749095e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 10:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732299392; x=1732904192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zShOcXTAhIOrL1GD9fBhb4zbIbWmFf6wLfZDDFFuD6U=;
        b=ZsdFvC5TwY7ulhtmW7BcIOPTfl50kDhzWc9rCDJuWSqhovxjXBkhQwjAM/ZZ+kxwnT
         g2PeSGwvZpIYjFNxyKMP9hU7sJ1J1+0oM6tW/xddhILfj71i7NvXj/0VBmLTrVSSRivU
         qoLXehsYwhaJdTCoJ2viM30xAgC8B8nxBHgImFnj/2SHkGqdarKB/seZWZRM8YuiqXat
         k9/iYwiPsHq3hCu4EAgzMP+osSO9U4uu1fS+gi+kycHRry3miR4GADkAuDNbgbCEx63+
         eZVqqBvB9Q+6YY9zVqdiJzYnf38aJ42KrTPmnnkKMcEUFhlUBS8EobZj+tXEtdJ6BcWk
         n2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732299392; x=1732904192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zShOcXTAhIOrL1GD9fBhb4zbIbWmFf6wLfZDDFFuD6U=;
        b=sIMhRf+Nyo4EjeVdcrcRDCoAANHpmHxI74SVjE/Ledy6VA9a8gwXKjiqpAretUpIZv
         dZoRToYVR8rGy2BAF4HPoqZccufOSd71cx0kb2EftR0SGwf/Pz+9n60YAF8fwfx6FHqv
         OVTi/sA+nnIU485NcEvS62s5sa4QijQ0ct/8z81JdjPVpEFCyIpqF+RtriIKDHu+ixhe
         vY984dXpeMRaILXVZjASHraGwda+HmcMNRL1e4g8QHTWz/z5qoxH4cgFXILsC98ggiyM
         JnKdzInUznQUMtwZFDB49JdpednFhM+AXtLvOpcObedXlQtZA1q/leGG9UJ8CLz71upY
         8FqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbxzqlDzR1YL7Zs+L+1ohLQ5vDAOOTsuZv9qypsL4QKHKfmaCJjVwWeH+no2Id8o7HMYAa99pSF/0xL24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7ihsp5TCW9RcEPbvQeBEDY+HLUu7D1bfc0u6HanJ1G0xJ6JPu
	GcIgQanl+BwzeOGIaOUexqAdt4dOd3ejq/MqvRyVO+czpg9PNlr0wH9pVCj6fjs=
X-Gm-Gg: ASbGncuB6KYnoAUFfLJ5QBf+qozppC+6cCy+tyO79I5To1aET9e/d8064wL585gj98M
	+E92U/P4yWf0hc0mcqZW6Q8/6U0EQpjNm2pzOBUlM9FulaH/x+RAglp4E7rpY4fRHAsGEm6hmK2
	MglJtwvkmZU29Dp//2K9OLzErddmUYXyJZtTMXKuKyctw+SA63FbgkAxhNNvkJ9BBmnIE/DCIHD
	tvR+XRwog0u6X8jye60JoJFOPK1jG+yhofPdmAm3ZYCGi859QbB2SNVnkBw6l2+mH9fSSGCaqZA
	Hpc=
X-Google-Smtp-Source: AGHT+IHO3jyqLCOcTS3wh4+2xhK12la2E5PqJC9zeMvnqEaUzAlAA/kD0IsAvSGpyvD3nUkmL5b/wg==
X-Received: by 2002:a05:600c:154d:b0:431:5d4f:73b9 with SMTP id 5b1f17b1804b1-433ce4c2324mr30034465e9.26.1732299392126;
        Fri, 22 Nov 2024 10:16:32 -0800 (PST)
Received: from localhost (p509159f1.dip0.t-ipconnect.de. [80.145.89.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433cde8c8d3sm35357205e9.31.2024.11.22.10.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 10:16:30 -0800 (PST)
Date: Fri, 22 Nov 2024 19:16:29 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Stanislav Jakubek <stano.jakubek@gmail.com>, 
	Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: sprd,ums512-pwm: convert to YAML
Message-ID: <dbptlfuj5peehd5i63cbvdhnargexmfk6pncnnofir5wghpiwh@rtpe7cyj7g3g>
References: <ZyH-JASRcpMXYsmH@standask-GA-A55M-S2HP>
 <ielio4ys77kgo5qsvrbbqfg6yzlit33yun4leei2giplbedsc4@5qmkwgvqe6xl>
 <84dfe382-65d8-4743-84ba-d70699b6f5e7@linux.alibaba.com>
 <jjfajijz7xkh6rh4ekmvta5rum7tod4ts2j3y7sbdkbhkcgryr@6bbxclrkyzgq>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ni7e7r325tknnap5"
Content-Disposition: inline
In-Reply-To: <jjfajijz7xkh6rh4ekmvta5rum7tod4ts2j3y7sbdkbhkcgryr@6bbxclrkyzgq>


--ni7e7r325tknnap5
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] dt-bindings: pwm: sprd,ums512-pwm: convert to YAML
MIME-Version: 1.0

On Mon, Nov 04, 2024 at 09:28:34AM +0100, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> On Mon, Nov 04, 2024 at 10:52:09AM +0800, Baolin Wang wrote:
> > On 2024/11/4 04:24, Uwe Kleine-K=F6nig wrote:
> > > thanks for your patch, looks fine for me.
> > >=20
> > > On Wed, Oct 30, 2024 at 10:36:36AM +0100, Stanislav Jakubek wrote:
> > > > +maintainers:
> > > > +  - Orson Zhai <orsonzhai@gmail.com>
> > > > +  - Baolin Wang <baolin.wang7@gmail.com>
> > > > +  - Chunyan Zhang <zhang.lyra@gmail.com>
> > >=20
> > > An Ack from (at least one of) them would be great. I see Baolin Wang =
in
> >=20
> > Sorry for late reply. Look good to me though I'm not a DT schema expert=
=2E So
> > Acked-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >=20
> > > the recipients of this mail, but with a different address. Does the
> > > maintainer entry need updating?
> >=20
> > No need, I have already done the mail mapping:)
>=20
> Having an entry in .mailmap doesn't justify adding old/wrong email
> addresses. If your linux.alibaba.com address is the one that should be
> used, it should be listed here. Not everyone consults .mailmap before
> sending mail.
>=20
> If you agree I just substitute your address while applying.

Assuming silent agreement I applied the patch with your address updated
to the linux.alibaba.com one.

The patch now waits in

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
nexxt

for the closing of the merge window. Will put it into next then and
include it in my PR for 6.14-rc1.

Best regards
Uwe

--ni7e7r325tknnap5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdAynkACgkQj4D7WH0S
/k4ubgf/T9lngTW46evn+d4FyC5/oaYb3HlwKomgqWDmXWgNCo4j4hUZgeNjlZJ0
peA9kJ4812Iuwx8kj2J5l5QvGiH8AB3iV4IyPg12wuVfsQE2AG8wZ/GruMH05bg7
8/duQHFtmTJ6r5LE5oJwcu8WYQdGlFLdJWaIv5ru+jfDGLMEEFD+Pistvj8z2dcc
jKMUBp9aJCgxHY99Q4yN0bdbKvUZUr+Sx9kt+DbrpUmAJR76rJkWVKkoVK1t29CT
D//4VyZJV2BHb/FT0nvPwR7jRDhOkL21rFMF9/fxJdZ3uEbB2RnPeeLzC2aQsYoi
5r9YGCu2ld5ZEKND6g9VYfqMkAMM1g==
=fIyv
-----END PGP SIGNATURE-----

--ni7e7r325tknnap5--


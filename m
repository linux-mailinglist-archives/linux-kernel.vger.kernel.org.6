Return-Path: <linux-kernel+bounces-266874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E114E9408EC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11A851C22E4E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 06:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EC119005B;
	Tue, 30 Jul 2024 06:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZroeGkZ5"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE0F2114
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 06:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722322507; cv=none; b=D6hHf/EGcHV9p8044Dn+OWOYyNvkF9C2JNcTIcvIAz4gRPSv/2OpTS9j2f/uTZ+Zs1y6g8oNOTn1FTPZNl1OhomBvvc5frVo2xEOuJ8R39VRmQljiiHrPXl2/J1dPR+HEbym+CkICAdmD7yKxaHtaCKY3aZqQY36l5cBk3KV9lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722322507; c=relaxed/simple;
	bh=xBO2MpYEwtBfpev2mKImPJcX9SjLu8M8dLyrQoCPX9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DsN3I1BWptn7mjcS7jdqdPIFZTReERWc0zxtVr+e3bxNJVq7P1JKeg/qy0Rhm4ZPl0SBOToSjIIVMv4gsz+HhbbdQBsgmJ6yo5w46atHxb6qOZH3pFomseFXEIALJ8R+kwNcBe9HQEO8GzrS3PDHLURYQ1ZLk3Zl9iDp/cM17vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZroeGkZ5; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7a8553db90so600289966b.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 23:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722322502; x=1722927302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4+KXlpDUuYsmfJstf04E514Wv6wKYNLKlK179ZjkGZI=;
        b=ZroeGkZ5R3bBZCfIk64smgcLne9VcfnzmeabtJChwfVQKg2pzKr/xk3b9MA40C53gb
         GVhFcrC0WL4TVr4leT7657k144+TAdUQOhSUle+Pag+yXdZnSSNt7Dk27iXB/Jcvy/4P
         Yrwrn2VlvcpUoSHTjOICkEFB5Ql5o7enCiVCxpM9bZSBN5ROCywIKPlIzXhQADsSUqGA
         16cNJgzroExKUUWyzDXy9V4swJhfZoHJw8zS3uATI6Qu2346IEC3ytPl5QRd84ZD0oeI
         OKAo92unC2tN2Z1HR1kKxm4yWcFTiTyVEgeosRoVfV5x7RvJ0Hp9jZtKTQWq4g9UoY2B
         PAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722322502; x=1722927302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+KXlpDUuYsmfJstf04E514Wv6wKYNLKlK179ZjkGZI=;
        b=tnomIDfdPN/d7z5S8Pa7biujJZTJMyTPT6npT57kvWXKJscmoNy9HM85eBhtHIJ+MY
         9ISKQF8LVx0Owje3NlpCL0CzlZ0MelN5f0kAK5jut7vXm2yZUkXXTDUp3Eda+GhXqRtQ
         gOWQJIbEiv6t+UQieytmiNyDIfmZROrNjuc/73MuuebOalRht2HS6fOQWIwvMx2j9CP3
         /zjJjx2hcCgFElsRgkeiO08NE57HQ4Fjs78oecuvyjml4vazj7mHKBzcQn4JamgKqsEg
         8IYclxrA8Mo8iQJ4L5ZV3eWbhPxDZWoRI81d9tKMGwNkGckqEBeqf0rGD35OBJB0AKDd
         rxHA==
X-Forwarded-Encrypted: i=1; AJvYcCWEuu8vG9K1yCH8gH7iDJoWvmxrSRlEJWa1ppCAbtRT33lq6p/cIQ/50mkvNposnQ9RaLr6VwPqjOn/aWkfcDU6uhqXVsqNCXSgDD93
X-Gm-Message-State: AOJu0YwF+weCmioi5mKrylQt5LbI353R9ESrYrWOpFZD4FNCU88071B3
	7g0Ivj/Dgmq9cAEciKQ0M/JspG9Zf+5f7XHWXhV/VIP9ZXfW3Q/ZYCbOQJM6tjc=
X-Google-Smtp-Source: AGHT+IEqgokRSYk2wC8FR1bGSdqPzW+3LzeJgu7fScoPnHEMruuYbKorDJ/7Rcd8D2FgUHVp8UB7Gg==
X-Received: by 2002:a17:906:d54f:b0:a72:7d5c:ace0 with SMTP id a640c23a62f3a-a7d3ff57f95mr799622566b.11.1722322501982;
        Mon, 29 Jul 2024 23:55:01 -0700 (PDT)
Received: from localhost (p50915eb1.dip0.t-ipconnect.de. [80.145.94.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab580b4sm598039966b.58.2024.07.29.23.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 23:55:01 -0700 (PDT)
Date: Tue, 30 Jul 2024 08:55:00 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Zheng Zucheng <zhengzucheng@huawei.com>, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
	bristot@redhat.com, vschneid@redhat.com, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <npitre@baylibre.com>
Subject: Re: [PATCH v2 -next] sched/cputime: Fix mul_u64_u64_div_u64()
 precision for cputime
Message-ID: <pwir36nw3vfzcya7hkil5iop2vi45mbrvd7aevsanqiw22vl5w@ll2unlznmtmb>
References: <20240725120315.212428-1-zhengzucheng@huawei.com>
 <20240726023235.217771-1-zhengzucheng@huawei.com>
 <20240726104429.GA21542@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p2ayxcrepwcvayej"
Content-Disposition: inline
In-Reply-To: <20240726104429.GA21542@redhat.com>


--p2ayxcrepwcvayej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Jul 26, 2024 at 12:44:29PM +0200, Oleg Nesterov wrote:
> On 07/26, Zheng Zucheng wrote:
> >
> > before call mul_u64_u64_div_u64(),
> > stime =3D 175136586720000, rtime =3D 135989749728000, utime =3D 1416780=
000.
>=20
> So stime + utime =3D=3D 175138003500000
>=20
> > after call mul_u64_u64_div_u64(),
> > stime =3D 135989949653530
>=20
> Hmm. On x86 mul_u64_u64_div_u64(175136586720000, 135989749728000, 1751380=
03500000)
> returns 135989749728000 =3D=3D rtime, see below.
>=20
> Nevermind...
>=20
> > --- a/kernel/sched/cputime.c
> > +++ b/kernel/sched/cputime.c
> > @@ -582,6 +582,12 @@ void cputime_adjust(struct task_cputime *curr, str=
uct prev_cputime *prev,
> >  	}
> > =20
> >  	stime =3D mul_u64_u64_div_u64(stime, rtime, stime + utime);
> > +	/*
> > +	 * Because mul_u64_u64_div_u64() can approximate on some
> > +	 * achitectures; enforce the constraint that: a*b/(b+c) <=3D a.
> > +	 */
> > +	if (unlikely(stime > rtime))
> > +		stime =3D rtime;
>=20
> Thanks,
>=20
> Acked-by: Oleg Nesterov <oleg@redhat.com>
>=20
> -------------------------------------------------------------------------=
------
> But perhaps it makes sense to improve the accuracy of mul_u64_u64_div_u64=
() ?

Note there is a patch by Nicolas Pitre currently in mm-nonmm-unstable
that makes mul_u64_u64_div_u64() precise. It was in next for a while as
commit 3cc8bf1a81ef ("mul_u64_u64_div_u64: make it precise always")
which might explain problems to reproduce the incorrect results.

An obvious alternative to backporting this change to
kernel/sched/cputime.c for stable is to backport Nicolas's patch
instead. Andrew asked me to provide a justification to send Nicolas's
patch for inclusion in the current devel cycle. So it might make it in
before 6.11.

Best regards
Uwe

--p2ayxcrepwcvayej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaojkIACgkQj4D7WH0S
/k5+5gf+MPiZNV9CvGBq3u8auK9aufxwOt6vmkyzS/B+5yUsy6vZnJD4r2ubv2UH
FQPTxo7lHbwMQnNGLfCOmYQpdm6+kLUOZhNTLofBLKXfv8Rl8dgCHsedWorv0Pp2
sNEXqAOZnIE2tovlXUb0Bb2rWLOf92B41qfDga24UkA9VH4Mr7ATCtEBLhsLJKbd
zY7ydQOQVKSDbOEgrWhgDcw0ZliFqRQgwOmenAkQulGyvhaTIGuruWf2phCE2e6l
87TJGiQKvwtmIFl4Ao0Z4xzw03GsDqZHdPi8jGIE/PfCKH5vQGjYIdMWxfgEg5BL
rPp6Y91EEHX8t1zyphclqgkfLppNEQ==
=w2uZ
-----END PGP SIGNATURE-----

--p2ayxcrepwcvayej--


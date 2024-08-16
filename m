Return-Path: <linux-kernel+bounces-289093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D23C954209
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 08:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A49D51C2493E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 06:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11ED912CD96;
	Fri, 16 Aug 2024 06:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="LbODWuwk"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F031612C530
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 06:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723790869; cv=none; b=js1CyZitugr+j64/OzImVsYcThqt6P/qKp9ByHk4zOEhxYWQQxKJ8VIZDyBhPnM+YhAdS5vbdFUmP3soXDVBD3mhA3DvbIktn9b7jsldg3QiWnlSSUD/2gkPOk2a9EyQ450noc0lbNV3UDmFVla0xVAm3lm/nqRlmNvxKlFRhCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723790869; c=relaxed/simple;
	bh=T0VdKduPQGJi6AkSLeo9BQStbWgPyO4FqVFbuyz7Ck4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mt6uTtvljnZHZ9PcL8twv4pyrUKy5iOCgnVyDWSZnU65RNkpI4HuTjQMALMRCVKQyRx5Qcqx+2FauqHo1K56fJXZi0jg4xeuOGB38tcJvoQzHMLsiCk9wN15X5wLJJ64X7wCwOd2bis97PNxq6otOwl0DSrGRsv0f4IXpQUw/wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=LbODWuwk; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-530c2e5f4feso1685181e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 23:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1723790864; x=1724395664; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8lLzgjSB2IoK1vnwVoKunnSOI/FsPkT6j9SB5PkWlag=;
        b=LbODWuwkl+V6YKHJuKlFsOJ0mitIABEdIZPiVMZbzBSSviSYVl/iZ7TFeM9oGwx3FV
         EhUaaExWvem/ndMD6475r0dAQqNmYY3/ylhLUntDglHpxi1a5rib8jAePl8SanEaFYP4
         bCPEIySMozuxFWZDA/TEVK1v4o8NtrU2xzvEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723790864; x=1724395664;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lLzgjSB2IoK1vnwVoKunnSOI/FsPkT6j9SB5PkWlag=;
        b=N/NU7t+Eqh7z4SIf0nQEoNz4AsyxZVsxFucWcoOOQKgw8n/0qQmbqZaFqUpSg8h6iG
         iA6MbeYB/6NUfwAaYrEddHh5rBesgc0p2PQJ8c5FduSFUMnnJbLGrsfgRq62Hzk03Sxi
         wpsJT+J2+oqfFk6Pf5w8nEXDumDQwsqPAUG35tbLCUqYLk+h0UJOTgl1KMFkD3rZaZua
         EvUAVbe0I1TVbXDIgroAsjYWQHpjZPmDsZoUrWBtW77jt8yQiqn4WBdww99mDIUy80GP
         qQwy4sXoU3/IZ5cKXbir26nJUFZrz8ClQd1X2Pa/ZXVSp1kbFNTzhoGhm1jMLX2cvOfN
         LhYA==
X-Forwarded-Encrypted: i=1; AJvYcCUH2mKA1vGkiX/+36hGKKVDy8QFacp0vLGY6ZeVxKSyZ/82u868EEHkXBsUfSDZdpzwR7QspkHbcpIVJPwchkUFCNgFoMoW5cJAUfdr
X-Gm-Message-State: AOJu0Yw8Ly1ugEUCj63f2OdlIt8jTLuH2H1DWyl09JLbsyi/XkT9JAYm
	0u2k+XZpifJkcq2tYtgPVA43rgoz1A3lDXTS41LQfR4qdKzqCVg+4PJHqPZ1E6U=
X-Google-Smtp-Source: AGHT+IEUDb8Jqbq6Wtv9gX946gkofBEOlosk4U1gR7lhhl4/uKn+1ZZOLRCcShXy6Z61zpDe6D6i6g==
X-Received: by 2002:a05:6512:b9f:b0:533:7ce:20cd with SMTP id 2adb3069b0e04-5331c6d942amr1062447e87.39.1723790863633;
        Thu, 15 Aug 2024 23:47:43 -0700 (PDT)
Received: from able.exile.i.intelfx.name ([109.172.181.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838396ce0asm206737266b.206.2024.08.15.23.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 23:47:43 -0700 (PDT)
Message-ID: <7fca93ba155921cd3d32678899bbfcea58d23da3.camel@intelfx.name>
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted
 increased execution time of the kswapd0 process and symptoms as if there is
 not enough memory
From: Ivan Shapovalov <intelfx@intelfx.name>
To: Andrea Gelmini <andrea.gelmini@gmail.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 16 Aug 2024 08:47:41 +0200
In-Reply-To: <CAK-xaQaPbmZ+pcqFvfgtwTyMnHbMcs6j8KjgVOYBxGzGgoAJ7Q@mail.gmail.com>
References: 
	<CAL3q7H5zfQNS1qy=jAAZa-7w088Q1K-R7+asj-f++6=N8skWzg@mail.gmail.com>
	 <277314c9-c4aa-4966-9fbe-c5c42feed7ef@gmail.com>
	 <CAL3q7H4iYRsjG9BvRYh_aB6UN-QFuTCqJdiq6hV_Xh7+U7qJ5A@mail.gmail.com>
	 <3df4acd616a07ef4d2dc6bad668701504b412ffc.camel@intelfx.name>
	 <95f2c790f1746b6a3623ceb651864778d26467af.camel@intelfx.name>
	 <CAK-xaQaPbmZ+pcqFvfgtwTyMnHbMcs6j8KjgVOYBxGzGgoAJ7Q@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-hHNU7Ev+t4Y6VgdH7HVw"
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-hHNU7Ev+t4Y6VgdH7HVw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 2024-08-16 at 08:42 +0200, Andrea Gelmini wrote:
> Il giorno ven 16 ago 2024 alle ore 01:17 <intelfx@intelfx.name> ha scritt=
o:
> > Can we please have it reverted on the basis of this severe regression,
> > until a better solution is found?
>=20
> To disable the shrinker I simply remove two items:
>=20
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index f05cce7c8b8d..4f958ba61e0e 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2410,8 +2410,6 @@ static const struct super_operations btrfs_super_op=
s =3D {
>        .statfs         =3D btrfs_statfs,
>        .freeze_fs      =3D btrfs_freeze,
>        .unfreeze_fs    =3D btrfs_unfreeze,
> -   .nr_cached_objects =3D btrfs_nr_cached_objects,
> -   .free_cached_objects =3D btrfs_free_cached_objects,
> };
>=20
> static const struct file_operations btrfs_ctl_fops =3D {
>=20
> This is from my thread with Filipe about same topic you can find in
> the mailing list archive.

Yes, that's what I did locally so far, on those systems that I _can_
run custom kernels on. The others I had to downgrade to 6.9 for the
time being. So I do have a vested interest in this being resolved in
the mainline/stable tree :-)

--=20
Ivan Shapovalov / intelfx /

--=-hHNU7Ev+t4Y6VgdH7HVw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJJBAABCgAzFiEE5N8nvImcx2nJlFGce94XyOTjDp0FAma+9g0VHGludGVsZnhA
aW50ZWxmeC5uYW1lAAoJEHveF8jk4w6dt7UQAJoqWG6Kq290zPJnc/NJ3VCUee12
eFLw6Ur1TW2XTzsra9Qhq2CrzycXVD1q60mvDPevnZJfq0tLLMMvWef3UC35UYv6
um6uiyzeXpzw2lv08k4ONEaI8fL53B8Rv+3GfUL376LrVBtQNdFcy5W7ozIzXE59
RN8GdC+bky1x1rT0vlK5qzra2ZXWH2yeq1TaTduO+UXYGv6qKArqGmHpJjF9Fq8d
jlW8lz1svDlBBFYJhrnjjf43W9tsK3DjsdtD3eVMrE0OaLylsfael0bDCT07IIPK
PouqvaKnEuVBqDy7ZQhuDXTPTkjy0Q9oqQ/J/p9bZadV4KwOO04yBYv8cN6VAsNP
eKF1wK0uYXuYcDQTvSQVpRvSnU47llhYoG2exa3yXj8EXOFpN1eYTKb40BKz9vg0
D0JKU9IcXvTJDd1jztbZG/FHxXctMpq0q16GtBxXCyDD4XYBNDV9oLYpIpNGHuWP
Mkm7++BZ88q/P/hF4jfuOVRwUmJ1ggl+wIwx/c6jP9OeGSHg3RrNQI9GslV/csDY
67rC3dKJ9R0vwZo+DxlBmyXtoqU0cMtyr/4aNDHRbnfYZMysXNijjjjys3582ztL
EgQhBfBK3lub0WlHAaRaRHR5D36slXROKWT0Y6oikigNTNkad2WGDJxAExxxHyYd
LdHV5gDt63z+Mpaf
=HcSM
-----END PGP SIGNATURE-----

--=-hHNU7Ev+t4Y6VgdH7HVw--


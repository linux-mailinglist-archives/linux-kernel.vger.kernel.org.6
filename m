Return-Path: <linux-kernel+bounces-249350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD4E92EA6E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C7F28109F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 14:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D232163A9B;
	Thu, 11 Jul 2024 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Tu7Hs5cM"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475F416130C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 14:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720707271; cv=none; b=VhYLhwprIms1Lkywn5DLIXt2BHGMxczWSh+BSKYRathAXhjdWqdoxgjTnFV7uM9JKA8Zs0C32e3dkoyBIFOpZ1C7ycqkVJOObpX4eQDcdCElYy2TCc+HvY/VCVyTWXERMjSiGcdkWqCKRU+tjT8EYMY2+9qR+xyCGj45pu8UTaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720707271; c=relaxed/simple;
	bh=k6gEHt+xvUkeIRyoiWjWbAiSg5WbedFbm/FHPHtlVRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aU44W9+MUmYxBJBXHdjGjKlpkkLO18BuqvggLnjexUHXIpzwONFwitSt/tBkmfKtEqBzILKQb6QzQP+Pd4D46zkLCQWvtrEqHl6lylcc+5RFSvmUh2voN9r0Mz+kwEsiT9YJFZhx9Fk0wrRbhbsbXCh3PznSqR5PDnezsYcdqPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Tu7Hs5cM; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52e99060b0dso1002882e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 07:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1720707265; x=1721312065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ETcGYWGq4nimdvPCfHodnKlCUrAHYcZUT9Kd0lfRhLg=;
        b=Tu7Hs5cM/U/Iw/ASeGNjbQp517UHoNZcVR756O0iesE63YWkkrQU/fV/DvOXSx5f8x
         77oEdCzBZXmMdwIt048/owv6pyW9gn0a1wn/O98g7P5OxtOhFA4n3oMIxPtxOATV4IVI
         hPGOgtt9SF2s27jXNA9RtIwbigfVUKmNBOlOKcRyCxm/umJXHckCFWj521L+kNfwnTNN
         gzmE2eSQan/Hx/MLx1BQm/hpojUb3zldbVv5eTLu7iywY7p9VNCx9nwLfg80uh3U9gVw
         nJDTxj5vz4rPXjNxDcH7nGbv4OJdPHxyhiauKu6hrrpZQ3F1F0Y9RF1lQUZeHEtJ6T/e
         ip0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720707265; x=1721312065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETcGYWGq4nimdvPCfHodnKlCUrAHYcZUT9Kd0lfRhLg=;
        b=GbH08JrueQvMdZM9UYQ6jJHJNQNEMs6HrqtEprWgzBtQdEf0OXvUs0UUn2tp2OPcTV
         hF5E/vuYtgZH/EcAiFybAQMgmIhWdnx8yZnRRCFb7Hbjl9C5sLnsnLBf4Ypa42tiR4EE
         Ww2ncEUXzTUlB4TOY56rXH/BetL/hMGxbYG4Qu4AwoZ224KYQN9ZcRySZl0TvjnAuezP
         6Bd5+OlPpdfAQW4EY1ZbXl694RRB5uGQKV0DVUdYNz8M2OTm9OOi2i8ycqdXq5rBuPv1
         0br8UgIVh4MWyJEieye8yLjotWweHtPWBcHyQ17ayS5vr9iP9kIBO8PbuJ9o5D9rbzLZ
         EjZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcQWPo2VjG4S96L4sBhVkbEek6rIMBu8213zrGC1yKqlaG974tHFidF0s/nMfwZZknc67Mp6QWvAu+whBWXDVU0XP4oVt9kxprl62t
X-Gm-Message-State: AOJu0YySOkAMkxKoWJNJyKrK/heGRoN8ok/p2q3LH7+aQvNLvP/Nv4GS
	IR8dV2zBciQDaZvsHalAdciMJGxoRkC2yyYPapSK7tCfg7gl0nu35xr460Pf3h0=
X-Google-Smtp-Source: AGHT+IEzPG+qu6OL9MzbpwkC6XP8o+jkAEZwKCZapFXu49qLNouCsz3lCZ+8q2VzbI+KQgfySGooLg==
X-Received: by 2002:a19:e05e:0:b0:52e:9765:84e8 with SMTP id 2adb3069b0e04-52eb99da425mr4901525e87.66.1720707265401;
        Thu, 11 Jul 2024 07:14:25 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a7ff045sm257878966b.126.2024.07.11.07.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 07:14:24 -0700 (PDT)
Date: Thu, 11 Jul 2024 16:14:23 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, 
	Zefan Li <lizefan.x@bytedance.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH cgroup/for-6.11] cgroup: Add Michal Koutny as a maintainer
Message-ID: <5yfatxvtkpti2mrym2kd7j4qcdu7rxkyp5xvvwcefzvpdc2mkp@q5f7ug5tij6o>
References: <Zo8OzWUzDv3rQIiw@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5uhdydamedm7ydyu"
Content-Disposition: inline
In-Reply-To: <Zo8OzWUzDv3rQIiw@slm.duckdns.org>


--5uhdydamedm7ydyu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Wed, Jul 10, 2024 at 12:44:29PM GMT, Tejun Heo <tj@kernel.org> wrote:
> Michal has been contributing and reviewing patches across cgroup for a wh=
ile
> now. Add him as a maintainer.

I hope this to be helpful to you and the community.

=2E..
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5536,6 +5536,7 @@ CONTROL GROUP (CGROUP)
>  M:	Tejun Heo <tj@kernel.org>
>  M:	Zefan Li <lizefan.x@bytedance.com>
>  M:	Johannes Weiner <hannes@cmpxchg.org>
> +M:	Michal Koutn=FD <mkoutny@suse.com>
>  L:	cgroups@vger.kernel.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git
=20
Acked-by: Michal Koutn=FD <mkoutny@suse.com>

--5uhdydamedm7ydyu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZo/ovQAKCRAt3Wney77B
SVSaAQDl/jTgKWUbqGX7f4PGpzw+02qS3ODuDV7XRrjJHXM2bwD7Bs0rBaW5Zo3t
4Ww0qfl2Qg0TLkMplYXm2qlvmy9fdQ4=
=LWj3
-----END PGP SIGNATURE-----

--5uhdydamedm7ydyu--


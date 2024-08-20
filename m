Return-Path: <linux-kernel+bounces-293904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E66595865B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 817F61C20F76
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271E518F2CC;
	Tue, 20 Aug 2024 11:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NZg8fdQ2"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869F118EFC9
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 11:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724155198; cv=none; b=C/Av75RuyzfFDBTBRFGZRLLZT8QXRmKApwnidivqSui3JBa3e8bg2x/0Hbt7OsN7XFDNiEurdbPlaHt6gAgrpv13pFrv4aeCIE7YdYiDDP/oF64RpSSV8q7Zjeys4FrwDELRoKJpbp2N995Me448p2nvccp+Ecc8ItAlj77oFp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724155198; c=relaxed/simple;
	bh=Fq/xweB6DECDmKQbmytl29CTiLmUyRhS9q8ArnfiM8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dw7P6a31Q3G8D7KySupIaGUUNaW/GetTdlRmE2IdvcNCpcxiIA8o/G6m39O+DLN95Ycwe95PTjZqlokset37euZ1TvK9iuYgZYP9qM2QjSk69tTvY5SnleOtNeLfvinhg5mpF15D74gfn5SiXzrQ+KpoAzCFKo4mrGqkVx0HG24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NZg8fdQ2; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5becd359800so4338633a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 04:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724155195; x=1724759995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ok6dysghFHVigyRo3DH9cQOmyL3eWl3oXud5BKTx3k=;
        b=NZg8fdQ2O1zYysygTWf8KGTp2mCvVZuwI2LRJiaBbhon6PLr9TopzwzgkYn0i0RauS
         CJtN16fz1fCCyx4elGlGa28hG1TtZ/51CbdQrt2D7+Bl3m1yEjOsEuG/qvfC0B8rcZVh
         7OQ57Nc2DuCRk1JJeorZyQk5q1k6C8CwvAB/MQhR7dkKDtdkvHAtYbqKYZ2dF6Spv414
         f+mSUX7g9E6fm7RDnezJKopAMM54j8IVrozpl4Td8R+pvR38rn/ARup1dinYuvjBMfmD
         4BiDr5K/W5o55ot/DS7DIYzPoKqDQeeMIAArpdgPj/Jwmw5t3xwMC0vLgUfvVqNCsxNM
         W5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724155195; x=1724759995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ok6dysghFHVigyRo3DH9cQOmyL3eWl3oXud5BKTx3k=;
        b=irW4orKB8DL89RkkPDqB8tUgtXdyOxIHp6A0xuS0pPonIVecY8ZBbvWEChSbcnh5yn
         mSIp6lsYyG/PKjkol2kDRLXzH7Y5K/lhhHMI9dXhrwbmXIIwsMP/cdgM5YPIXj0TZsZd
         xvPDk8gZ13Ko2jdqRjZXx/3cW5teQTALGYlKeE5MbiGsSdP6bYJQoq8BekZ5NfI5yKP5
         dQ3JAgwaqUEPk3BkGWgC8C+T3Kaeo0WceWfE8KHEqSbP8P3LYC35VwJNbUQw3KVkUlUb
         drKtH0AbT4UNqSKcWvffIhpEP52afUwba3UYRhUupaCqVTk88JcnEtZttcidY0YOtEuD
         ZBMA==
X-Forwarded-Encrypted: i=1; AJvYcCU4Gvmm9zmS1jprrPtuuma6gqREldSypnpl8+W5PyoIIeUs0GvDtSXxUPt3LVciOA9bGlnj1qZpktCNYws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOVyt/DcLi8FB6f61GN6QMuE6yT+Odw7o87gvfpe0g/c4tne7U
	npFwFYC2EtkzdVol+IAfOksFCLeFgyWlIw7+HWDMcXgV2+Wnjqqr9DnPSDyEhg0=
X-Google-Smtp-Source: AGHT+IHzpM00fkrHeTvxg9EkEg42LSJ/v4KOU5xgMNB21uMZaO/jkIpJj7Y+mXEKN1yBe+c3h8QkAQ==
X-Received: by 2002:a17:906:d265:b0:a7d:3a85:7a3e with SMTP id a640c23a62f3a-a8392a494a3mr908782366b.59.1724155194593;
        Tue, 20 Aug 2024 04:59:54 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83839470ebsm755475766b.159.2024.08.20.04.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 04:59:53 -0700 (PDT)
Date: Tue, 20 Aug 2024 13:59:52 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Kinsey Ho <kinseyho@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>
Subject: Re: [PATCH mm-unstable v2 4/5] mm: restart if multiple traversals
 raced
Message-ID: <cjvz3rhv2wkoev3gwikb72x4ecwx76lpdvxvur3qdzpnykyvvb@k44wu2ec2htf>
References: <20240813204716.842811-1-kinseyho@google.com>
 <20240813204716.842811-5-kinseyho@google.com>
 <zh4ccaje54qbi6a62rvlhclysyaymw76bona4qtd53k4ogjuv7@tppv2q4zgyjk>
 <CAF6N3nXmQ=+j5VNf16KL6Ma8RaO0o-Nv=C7reJKQOzdpHzWOsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ajk7qmdwnuv6drcb"
Content-Disposition: inline
In-Reply-To: <CAF6N3nXmQ=+j5VNf16KL6Ma8RaO0o-Nv=C7reJKQOzdpHzWOsg@mail.gmail.com>


--ajk7qmdwnuv6drcb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 12:27:27PM GMT, Kinsey Ho <kinseyho@google.com> wro=
te:
> Hi Michal,
>=20
> > I may be missing (literal) context but I'd suggest not moving the memcg
> > assignment and leverage
> >         if (memcg !=3D NULL)
> >                 css_put(memcg->css)
> > so that the is-root comparison needn't be repeated.
>=20
> I might also be misunderstanding you with respect to the is-root
> comparison =E2=80=93 the reason the memcg assignment is moved is because =
it is
> possible that on the restart added in this patch, css could be NULL.

I've played with this applied up to 4/5 and I see more changes would be
needed to preserve the function. Please disregard my initial suggestion
':-)

Michal

--ajk7qmdwnuv6drcb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZsSFNQAKCRAt3Wney77B
Sbe0AQCqKc678v6xKlFe6veLAdsc1gPRVpg9yKjZ3q02OmMDAAD+KpFdcpw2LANz
Y88ecO/8A4H/9QQ8MQ4PqwfNql79bgA=
=znwP
-----END PGP SIGNATURE-----

--ajk7qmdwnuv6drcb--


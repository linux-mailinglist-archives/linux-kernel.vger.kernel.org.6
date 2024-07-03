Return-Path: <linux-kernel+bounces-240220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 005FF926A60
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8007BB222C6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D94191F7C;
	Wed,  3 Jul 2024 21:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zoDtJQyt"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4972BD19
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 21:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042596; cv=none; b=T+W4Am4+nNfudTd0mHG1oyXlpW7+Ql6BSs57ves4i+Zk/lC4LF+hBppJa9pR9n4e3pa6CWzuFJF/5FuOi6Kj6vWKwB0/OqkQuPAnXhIHep2ushU7aohkq9NKjSI+UAraKHDPjs1DKh15QoW4ncZhD460CxPqfLapNt4EM8YJpgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042596; c=relaxed/simple;
	bh=nBEsWAwQ8bVtUAg33CAax9OvnECUXvitIjR3Wwy8RSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rp+RTPnU564/uAs5BBlhavMS8AiGY2uSEzlT6Nn3EL5EawgKNAon+s80DdtpNEYLJkSVIhQEIurr/3Br9Ucr8MYMxkaseZtW+oaFACPeFUsLddbpQeGv77lnu07qljb1C9vRuuKdDWuoi69k24LHie3+JYTt9iuH8YE1JkqqDJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zoDtJQyt; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a77abe5c709so61579066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 14:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720042592; x=1720647392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S2mSSOU6idQMZOTqlLlnSJzLAYRvC2mcLjXu7OsvByI=;
        b=zoDtJQytXx+ge+/Ufuv/oa1Q9cJMOD7nTbOb418+ywnCTZdXxrussremWWwd4pkIyN
         lxldQiEotigt93dRdZH6YM+Ic/Fdkf+To+nsZKoAKon4egwTs2VPFEj3i9WFbrfSG588
         64xk8gVSTAvzgr+i2wkJ2AsRibrpNuyWcZUpNiRqo8eHoI6/HQmGEvhSQLvhYNjCPkIs
         iA/7obNVtsWNMEQxHSBa7o71+TIj5CPpHFsVNx5SiuQkVDBSTuz/DOz2XKcnt2EGTRDb
         y9qZ8Mti5UR5k7kved5ZzXzs3psa/vtsKES8MabvHTfbbrRJgDE6d6EhjwKTGxV5B7Rr
         Tw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720042592; x=1720647392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2mSSOU6idQMZOTqlLlnSJzLAYRvC2mcLjXu7OsvByI=;
        b=dCC3CAX1/3EgQA2Sa3w9TVkp5H5dPEs1Vs+5akzqty3QfpA6GB6gb66AWGUmYNrlwM
         pq52GAE+EkmAYBGeeAEHCryPuy2p9pjmFyaVE7/DijB8CnIlVj6vMGw/odhwd91Ga/36
         Er4/IROkF2xPnGjfHAt9FyaSOPbszi68bRMI5ZHT8PLUvUj1reO61g8G2u5qj4PMdCgY
         mhqJWDlvXNYJ7SHiF8OatgjXVe46ztM7llH3tBX0l/zNQAcWb5y1Ik/tcsuyJ27ok1j4
         yNU+huw2HE6DYkNN3s33AwztXM8QScjugwuv79RAYlXA/1nkTFAMEg/tYDQpjYAznmmG
         RGCg==
X-Forwarded-Encrypted: i=1; AJvYcCUV+XJC3P7CLS9BKTxIOrLAZ8/RnNQ/EF7Ct8h5FbnCcL3NiBTPTQJBrgtMNyiTDXkN3sa8M9kdmbVqPOqUse7H6YOoW83Lxdqe/A45
X-Gm-Message-State: AOJu0YxqEQSF8lvW8VHnJECy+C0iHjq/b8sZVFNUuWMnk7ZyKiKjAfyN
	TA+72zxO6oBnMFGVSmdmHCTZALNkr1KPb8C69ezGX52LLWHCWoHrkQonK51P/BNTPBMZSq2517g
	wjR8=
X-Google-Smtp-Source: AGHT+IFrl2ba2wAsE8SzZxibKzeeEqiqoL6Imr1Fl/L8lCNwDk7OyCd2sZpxWmXNTa7aMXXAfMY64g==
X-Received: by 2002:a17:907:1c95:b0:a75:3c9a:2fe9 with SMTP id a640c23a62f3a-a753c9a30admr491530466b.68.1720042591520;
        Wed, 03 Jul 2024 14:36:31 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:5696:f293:6e5e:98bf])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77ae5bfcddsm35518866b.173.2024.07.03.14.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:36:20 -0700 (PDT)
Date: Wed, 3 Jul 2024 23:36:14 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nicolas Pitre <nico@fluxnic.net>, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2 2/2] mul_u64_u64_div_u64: basic sanity test
Message-ID: <yforvmqwgvkuulicbkbzf4htlcssvo5pz4s6ieksa57whj4smi@lgdnfo2svceq>
References: <20240703033552.906852-1-nico@fluxnic.net>
 <20240703033552.906852-3-nico@fluxnic.net>
 <20240703103529.2283c3c4683c60f1ae50a152@linux-foundation.org>
 <n92q9p5r-9o9r-prp3-s256-110322s5n233@syhkavp.arg>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qpomt6w55ypakcsd"
Content-Disposition: inline
In-Reply-To: <n92q9p5r-9o9r-prp3-s256-110322s5n233@syhkavp.arg>


--qpomt6w55ypakcsd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andrew,

On Wed, Jul 03, 2024 at 01:47:10PM -0400, Nicolas Pitre wrote:
> On Wed, 3 Jul 2024, Andrew Morton wrote:
>=20
> > On Tue,  2 Jul 2024 23:34:09 -0400 Nicolas Pitre <nico@fluxnic.net> wro=
te:
> >=20
> > > Verify that edge cases produce proper results, and some more.
> >=20
> > Awesome, thanks.
> >=20
> > Do you know of any situations in which the present implementation
> > causes issues?
>=20
> Uwe could probably elaborate further, but the example given in the=20
> first commit log is causing trouble for a driver he's working on.

Actually the example was a constructed one. I became aware of
mul_u64_u64_div_u64() being only an approximation while reviewing a pwm
driver by Biju Das:

https://lore.kernel.org/linux-pwm/TYCPR01MB1126992DD51F714AEDADF0A4F868DA@T=
YCPR01MB11269.jpnprd01.prod.outlook.com

mul_u64_u64_div_u64 is used in various pwm drivers, but in practise the
periods used are small enough to not be problematic for the status quo
implementation since commit 8c86fb68ffcb ("mul_u64_u64_div_u64: increase
precision by conditionally swapping a and b"). At least I think Biju
(added to Cc:) only hit this problem during testing, and not in a real
world application.

I intend to do a performance test of Nico's code. I hope I get to that
tomorrow.

Best regards
Uwe

--qpomt6w55ypakcsd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaFxEsACgkQj4D7WH0S
/k4Enwf+NNk6u5SSrkTA+7pl7fNYbbsJKAtqI6xvoQwXg+smLpdxOUFTqVymeyxW
iAn1cYOI5yaRpiBYKywqiGqdUIUvwsdzAihII1xHdTAcDCc1eue6f8PFV8JBSAvh
iCyi4LzZg5dTwsByC+21n9ZcmiD0yV8d747vwXh9xeWZz44D3kAKHyD47+yuHp9V
dBslXQHr31Q5/LQgMsIAbFB9f7BoALDArUsywCDwZxe8bZ5V8XpKewtyNqo49o49
8b2S2/R5VVvFT6EVbvTNS2NYLPfjikxj6hh7i/6nMv2rLQSUDTsdAW/ec8C6Sv67
EyjxGbVm/94O/oCilNSEVehJT4rj0A==
=25j9
-----END PGP SIGNATURE-----

--qpomt6w55ypakcsd--


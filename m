Return-Path: <linux-kernel+bounces-567258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA13A683E1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 04:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D23D33B93BD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 03:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB2C24EA84;
	Wed, 19 Mar 2025 03:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rhbw2PIw"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE41A186E2D;
	Wed, 19 Mar 2025 03:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742355856; cv=none; b=gpg6HE9ZXgn1wNExlyQR24nBnflUcdxyQanM25FQIYP45SxT7Jjbf1y3rR+dci6Lhx+VBb3mDtorwLQ4YoVLaeE8qFY05yuiGEdC5MujLOEn213+6KHSM/5WT6/BM9cWjaAAskFbmJvgg/niRKZb03YU4SWPbg0H4VNmyLut8zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742355856; c=relaxed/simple;
	bh=+GAbF5SpSc6oQqFDuV3LJR9UnoESsAOk8fkh+YD1Rt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpG30zb0h/EkTlUJlB3nBnKTL9T5tYVaLbTaS1lBbnU0ijMmYNPzfE3AJLISxr7+X63uBXPHTG82fUmiKZD6GQ6Vfq/4u1tsy3Fh0XG1fBoWiO8beCSZE69WQHCJMcU1Dooatu5ObtRrvW4exXLqD+JGV3Gp3Hk4HJrP68c9dEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rhbw2PIw; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ff6e91cff5so6252443a91.2;
        Tue, 18 Mar 2025 20:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742355854; x=1742960654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LmrhgRaZQ2esJD5Ee8Q5WTZMqeQvEp9WPDtHlhFhYRo=;
        b=Rhbw2PIwQPaFDotRDELMeEM6c0M0GoqJJZ4D/hzQL78WqqULtyMPZQCOzfh7ugn8Ry
         JAjfbrnzj3rY9XNyFrgt9eMpNnTAWP2Jhx22d1TrDttL+bq5qme58/GjeRgk9pZWaCJd
         1npxLsfamte+mc6ia1h4nD6Pn/ck9bmKq+w7WurSvUDRbeEgoKx6T/vko8D6Z9FP31LM
         x1ZJx9nq03loAgJx5qxEz2+6SQdJkRuD3WAQtGTHB2IZgbU+MS4/lfW0xkpQGgeg2sEa
         6ews2A3jTkUSMV9eO1vGGAE9d86kf3v5qXgDlqSpYdPmrGdw93Yt+5VwvB0+/qJSt5rR
         7t0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742355854; x=1742960654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmrhgRaZQ2esJD5Ee8Q5WTZMqeQvEp9WPDtHlhFhYRo=;
        b=GsCQ9XjKr1vClo4+2kMDEJsZG1nK+SuIQ02kI8SUCAZ4DvMkwaJM6iwWyix5LyBbkN
         V31J7yyfSozW/+oNz0vH8ctvlX7qWCzR14Z8lDDKk7vMDxC+VGLUfrCOThZahLfMMESi
         nI6hsWE0lwvYwLPpabQBrIeuHwXI6QFAxfffr7KeUXFA91Yk1fOnZoiLT7gVL1wd+jbt
         mE54YqYBi1OYOKwmWxnBRodRLfMG64+jjQXmm3v7G16hQ3KWonHdQFfosvM97p1zQa4n
         sVQpqWLWceXgVBAOGT1UNFxvwcVrVSF5aj+yuVVAS6B4fqAXBIJ/+XYu52EMoNyXCHSg
         J9qg==
X-Forwarded-Encrypted: i=1; AJvYcCWoWMz+yN1H6hZduaQ9o1uv37PXnJFEiw51Dk8GEThbpxMYkkk0z7dAhyj2X0Vrg0uW72/osuKYHBc=@vger.kernel.org, AJvYcCWy05MoJ70/sLV2E757wdIRcPylGBRXytV0LhQ5z3n/dGreznzdAcKVuVcU9MibI05NDactVpSrVTUSUIOR@vger.kernel.org
X-Gm-Message-State: AOJu0YxRgKWRmcWnuNi+PPIF57gUpkZa1faiwg+F4aXQDS5RPZ1n6s4t
	8lWBb/kleLK1CgRS1soy9X5YLP53MTHfWRXZj2R6Ij/XN87z5rvl
X-Gm-Gg: ASbGnctBus+t3il8b3118Fc8jzWhVZQCHeSgPqU4r9k6xlTl+d4WOsYiS8rJ3WiQq/l
	nLzYiQwm0OKX0/FyjfXnLEm1rxMtHX8ONos7+/h5UecHFL90hKPXZ8L0hQQKKjk8syblSLzpuEV
	kz4n++883ByC1rl+eLcu/Lbvvd1IhC2H93lNnpcpOMO+Gj2o6Ag8M/Oj0GMDqZuCLdGazB6YDiq
	9D7ZtvG4NcZORl11JKPc9oHszlwkTcGVPJPXo0SJ2uKKlic2dq1lIQydvv2FSaMpXP9kKGpaQWM
	p5IBJA0Hh+U4aArgWI37xlk2HB6yy9sl9yhr81Z0cpuIUN5x/LhHwno=
X-Google-Smtp-Source: AGHT+IH/iT3MtS2ax7POPPW1zeTwh0K1LGntWioMM24k31dXIZG9jeCFE1wxGR3hbW1JG1oYXmT3uw==
X-Received: by 2002:a17:90b:1a89:b0:2fe:b937:2a51 with SMTP id 98e67ed59e1d1-301be205ce4mr1756074a91.33.1742355853746;
        Tue, 18 Mar 2025 20:44:13 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf59cd49sm365744a91.22.2025.03.18.20.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 20:44:12 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 167FD424184A; Wed, 19 Mar 2025 10:44:11 +0700 (WIB)
Date: Wed, 19 Mar 2025 10:44:10 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Pranav Tyagi <pranav.tyagi03@gmail.com>
Subject: Re: [PATCH] Documentation: vgaarbiter: Fix grammar
Message-ID: <Z9o9iri2uUCoIxdK@archie.me>
References: <20250318041249.20786-2-bagasdotme@gmail.com>
 <87a59icsbw.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JSr2fAOfACuQ+50l"
Content-Disposition: inline
In-Reply-To: <87a59icsbw.fsf@trenco.lwn.net>


--JSr2fAOfACuQ+50l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 08:43:31AM -0600, Jonathan Corbet wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
>=20
> > From: Pranav Tyagi <pranav.tyagi03@gmail.com>
> >
> > Correct grammar issues:
> >
> > - Fix "co-exist" subject-verb agreement
> > - Correct plural form of "server" in context of more than one legacy
> >   devices
> > - Use passive mood for intro sentence of libpciaccess section
> >
> > Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> > Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > Link: https://lore.kernel.org/r/20250220164946.18007-1-pranav.tyagi03@g=
mail.com
> > [Bagas: massage commit message]
> > Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > ---
> >
> > I have to carry the original patch [1] because DRM maintainers doesn't =
seem
> > to apply that AFAIK. Jon, would you like to apply this patch before the
> > merge window in case DRM people don't apply this either?
>=20
> The DRM folks manage their own docs.  I'm certainly not going to
> circumvent them during -rc7 for a patch like this.

OK, thanks! I should've post this after 6.15 merge window closes then...

--=20
An old man doll... just what I always wanted! - Clara

--JSr2fAOfACuQ+50l
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ9o9hgAKCRD2uYlJVVFO
ozPKAQD81lszkWgPnWn6sjb1ZHh6b793Xx5tEtNM5I22Gh3qFQEAghGlHKJouvS4
vC7T2IcOxUIPNRvEi+MLHCsLIOMaRgA=
=woq5
-----END PGP SIGNATURE-----

--JSr2fAOfACuQ+50l--


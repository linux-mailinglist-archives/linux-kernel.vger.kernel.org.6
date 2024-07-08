Return-Path: <linux-kernel+bounces-243864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E013929BE4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9A591C210E0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D317125B2;
	Mon,  8 Jul 2024 06:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Wl07UTv0"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D42C10A3D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 06:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720418855; cv=none; b=rr9sL19kCoD192hNlWi8vcG3fBRXAbXRANG0YgZ9ZqBnPHs4lWsuhLmZy6SiNq4dVMNWoP2HkafVTmxxxvvqPtWzBaKYLbGynnK1SzpsAiSc2yFIaBRQKuhF0M9CnUsZz1DfyTz+LbM+LfSyl6/1+PYI0+UmiPe8lpg/Ng9A120=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720418855; c=relaxed/simple;
	bh=VHZs+Hs0Lc0hQJIKmeqVyikE7Kctk5t9nm3sgVx34OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnwO8icZj9v1ycHQKRVolo5fvT+zxI5VltuOpsHTFct8/2KSJlAPAdZTxDJ9n9AgyqQwDVDzQcPEjehfxzSwTsolZjjo1pu/x4One2GR5IiyP/FFLJ7aLj6Jer88uBOksni8/Ka2wkoKO7xZEusnpsBea0IudcSTCjkrsHtjcK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Wl07UTv0; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a77c25beae1so357456766b.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 23:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720418851; x=1721023651; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iNM6G5IfDBy843HuK595EURkoqyDO/J0YWAIfqdCdUQ=;
        b=Wl07UTv0IwKI04jP1rFnYzweWlm9ixlapx+n8MZNtG8h0l4BrG2gW1QyS0dbVD6IhZ
         g3G3yc2yN/KaGhEFI0K2r34UV8Xg1TALIzOk8d8OVdOPyJZJvv7+yvCU8Fl3Vy+bTZ+H
         d6ZbIkEJZCXBqCGXdhevL44hRziDOhq/ouQXuzLQDsnN18kIX4r7W2Lvg6oNTrVhrtck
         YyTm2xdOsmm9sNwwQgJfsNQY8u2azRw0Yft/5vW+onnxSfSKCV4JlDCBRjieHl7fLpEL
         qAO0jm8N4+y1H4MeIxZe0VhYL0MheWZW2ZAeXytUMx4wwiuKlFyVSnIgaK9xFf7GJ1OG
         XlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720418851; x=1721023651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNM6G5IfDBy843HuK595EURkoqyDO/J0YWAIfqdCdUQ=;
        b=ElfqQ3Gvqkedju66Ax88Pb7k58GAo55OsIgIdrj3hwVZDHuuvIT523Yk3nib3na+4j
         l2nKq37DUGkeBge60xQ2L+t5OKBeNjJg/p6KrzvPPr/k1sGNCUg81L6Jnj1JFdV+sSjM
         odxLyBUCvlHVRN3TvziKpBCMAVW9Tz7bpP1ZqOZRlQnA/JROODxyFGvP8XOD17U8FOb9
         aNFCu0FD2ARYp+0dZEPDYUNWc2TkMFe11Av+NozaSiaVLRXX9QTgj9XRaLN//JD2tWb1
         sDfEp6IAHiA4STvyHOdN0DxZi153Mgt0s0+sRuZcB+EnnFuTbGk79OnxF3oz+tegY9FF
         eICA==
X-Forwarded-Encrypted: i=1; AJvYcCXWbobVQ2GN/ivfJb5Sv8NsBk0i94J/Yzv0idEhrIjuf31m9nUZe2vx1PpcPUyv196nEl7L4XoVcvoYMZ59us30BVk6A2OZeEAARjNC
X-Gm-Message-State: AOJu0Yy0l1CQS1IZ2V3/e5KrZ3RjV/Qn2BBycMIkm6W4g5LWeQ1MUOc7
	DJoLhUU8A/IGbwiS92MtbsC2piueqod+QCf5QGSXbtemCeXcxRDvylg7JVbYuXA=
X-Google-Smtp-Source: AGHT+IH3QhUNjWmMpv02scsrM+/yPE+4othq1bSZxCGmjlqmKUJu/umDkXx1yyt6y6TGOypWrew/eA==
X-Received: by 2002:a17:906:1b55:b0:a77:c583:4f75 with SMTP id a640c23a62f3a-a77c583a93fmr569431566b.38.1720418850618;
        Sun, 07 Jul 2024 23:07:30 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:7e44:f701:52e9:e297])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77c4cdee52sm310361966b.128.2024.07.07.23.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 23:07:29 -0700 (PDT)
Date: Mon, 8 Jul 2024 08:07:28 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Nicolas Pitre <npitre@baylibre.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mul_u64_u64_div_u64: make it precise always
Message-ID: <fxqlcqxvcmfuviqtlkcd4qrhxf7xmcpuokkj4ebua2q4h36bkv@vgy53gbeqrdt>
References: <20240707190648.1982714-1-nico@fluxnic.net>
 <20240707190648.1982714-2-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hy6s7rb6vchq6eub"
Content-Disposition: inline
In-Reply-To: <20240707190648.1982714-2-nico@fluxnic.net>


--hy6s7rb6vchq6eub
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 07, 2024 at 03:05:19PM -0400, Nicolas Pitre wrote:
> From: Nicolas Pitre <npitre@baylibre.com>
>=20
> Library facilities must always return exact results. If the caller may
> be contented with approximations then it should do the approximation on
> its own.
>=20
> In this particular case the comment in the code says "the algorithm
> ... below might lose some precision". Well, if you try it with e.g.:
>=20
> 	a =3D 18446462598732840960
> 	b =3D 18446462598732840960
> 	c =3D 18446462598732840961
>=20
> then the produced answer is 0 whereas the exact answer should be
> 18446462598732840959. This is _some_ precision lost indeed!
>=20
> Let's reimplement this function so it always produces the exact result
> regardless of its inputs while preserving existing fast paths
> when possible.
>=20
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> Tested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> Tested-by: Biju Das <biju.das.jz@bp.renesas.com>

I would have wished that parts of the conversation about v2 made it into
code comments. Anyhow, *I* have understood the code, so:

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Best regards
Uwe

--hy6s7rb6vchq6eub
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaLgh4ACgkQj4D7WH0S
/k4EvAf/fo7vMBbBGoX1iDCLR31RzrSEHFVD6NXcRQ2GC1hC5kRPFGJK1Fxr2xgx
kBBiLIZJtK1EIAUL/mzw/TI5dVSBpr+/Y3dMTC90IbsNO6Nx3K2O1IjhOsW2ORj7
NKotnj0N2kLSkrjy9hnVMOhREy57+kuv2bImtf2ptQyBb6InCMEQTLD8V0jDIJTZ
iSiN+30/mtw7Hq1mOHa21qqZdtRaelMen5dt7wK6QMcQUNJ+DwbKgIB3wJ81qpf7
z1AN2hLikSSU4Ql+hJPM1CqCq++BL9DUqxA4z6Z+FeNKtBr4xAwxUJeAB3ZPGn7S
wNSUsVZkubuv0VMByc4dWL6VpGQ38w==
=6TEj
-----END PGP SIGNATURE-----

--hy6s7rb6vchq6eub--


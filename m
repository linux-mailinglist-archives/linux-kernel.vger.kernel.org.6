Return-Path: <linux-kernel+bounces-382610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 487739B1109
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 22:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7B721F21721
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F6F21B86B;
	Fri, 25 Oct 2024 20:48:09 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD7C21A4D9
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 20:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729889289; cv=none; b=I/55mTef7FG72PaUPtJBtM8wfjQ8We1OHaV4jxyhvbsHM9YQPYdb3EFa6mS0BKkNK4s9uBvnwachzG0EizloSPCM93q91wqjz5mTNtBkmnWNY36oKXoBZEK95dvjIuMEeqATfMuy5QwFtv+Tpj1kudiOt25afQivzAFby9Mce3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729889289; c=relaxed/simple;
	bh=sValJAQvX5AxaNmTjGZzBJwOh14do82tDXUUsoqP+5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFYFwhstlaORr72XET+hnKsp6BmyTAD7qpZdGDsVUFLHwA6U48IjAR1nu6rEwWbls3CFc6vOxB4SDiAsAiYNTY9rgFlParDnO7v1vNm1Lhr+X8wDPyZs/fBQIIZGj1FvpjlO8vjTzjm7Krf4Ko1UtyIHikPpGLCPJ9l1cItflIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6cbe90c7c95so15750326d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 13:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729889286; x=1730494086;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRjaD6H/hy34iYED4AXqAZh2gsECEe35fRPiuThhm9o=;
        b=docYM7ZOG9HtA49nAlbmCQLxJi5NW4+FLqm3Ze/d17I2rBTdixm9VI6iRLbaHhUe6l
         mzovosEValFU8kLiOLnAdfpWz1G1bN/SewFPqGBtcBVruDz88x03TRxROzMvgWH3X0yf
         UUIgv6JJR4TS3kt4eifkNQvLZGshbcMEA7kVwgFDbhtZTi2CK3T3EOKmd4VOYXn/HVoj
         JMDdTYICQ+RVKJ2xQ517kKtZRvDObQSP4Eb8BMME0gdM1tLg9UodPs1B2ejl0MoQwu22
         /3friFWOd7Dzf5op5+govSuQ4LhZ31YQmCgI8cOoXvoWQaL9B+x+cNJWWlOVknJfUOtB
         WPqA==
X-Forwarded-Encrypted: i=1; AJvYcCUoZs6KfPXVZOJdF717CJmp79MDAD5LKpnTeRXEITk3W1ZroBK9M0vIGqZnv3Q2tflX55BjFFR4eweKo8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2sF0I9EsCwM1lhx0ygvaYFvkelSjdX+eAFlM+fnn3Z7Kq7pwv
	qqUS06cpGm/CV6GuHWSrH0v3ln5Dpc5OEscj34kMTBH0/pvmq2tu
X-Google-Smtp-Source: AGHT+IECIkXB+fdK0+u+4To88RYENspNPtL18iOtAw7uiVxLvIgBzAPSuSp5uvXiZU5L7KzQ/JS0cg==
X-Received: by 2002:a05:6214:4305:b0:6cc:37cf:5dc8 with SMTP id 6a1803df08f44-6d1856f27f3mr8239636d6.21.1729889285965;
        Fri, 25 Oct 2024 13:48:05 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d179a2d466sm9124716d6.115.2024.10.25.13.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 13:48:05 -0700 (PDT)
Date: Fri, 25 Oct 2024 15:48:02 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@meta.com, kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scx: Fix raciness in scx_ops_bypass()
Message-ID: <20241025204802.GA24112@maniforge>
References: <20241025203929.22839-1-void@manifault.com>
 <ZxwDCUcyTABN8Exj@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zhwkI6gVP57BwS0T"
Content-Disposition: inline
In-Reply-To: <ZxwDCUcyTABN8Exj@slm.duckdns.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--zhwkI6gVP57BwS0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 10:43:53AM -1000, Tejun Heo wrote:
> Hello,
>=20
> This looks great overall. One nit below.
>=20
> On Fri, Oct 25, 2024 at 03:39:29PM -0500, David Vernet wrote:
> ...
> >  static void scx_ops_bypass(bool bypass)
> >  {
> > -	int depth, cpu;
> > +	int cpu;
> > +	unsigned long flags;
> > =20
> > +	raw_spin_lock_irqsave(&__scx_ops_bypass_lock, flags);
> >  	if (bypass) {
> > -		depth =3D atomic_inc_return(&scx_ops_bypass_depth);
> > -		WARN_ON_ONCE(depth <=3D 0);
> > -		if (depth !=3D 1)
> > -			return;
> > +		scx_ops_bypass_depth++;
> > +		WARN_ON_ONCE(scx_ops_bypass_depth <=3D 0);
> > +		if (scx_ops_bypass_depth !=3D 1)
> > +			goto unlock;
> >  	} else {
> > -		depth =3D atomic_dec_return(&scx_ops_bypass_depth);
> > -		WARN_ON_ONCE(depth < 0);
> > -		if (depth !=3D 0)
> > -			return;
> > +		scx_ops_bypass_depth--;
> > +		WARN_ON_ONCE(scx_ops_bypass_depth < 0);
> > +		if (scx_ops_bypass_depth !=3D 0)
> > +			goto unlock;
>=20
> Now that we know irq is disabled in the body, can you also please change
> rq_lock_irqsave() to rq_lock?

Ah good point, will send v3 shortly.

>=20
> Thanks.
>=20
> --=20
> tejun

--zhwkI6gVP57BwS0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZxwEAgAKCRBZ5LhpZcTz
ZI94AQDAUzuRMJUKoB6XqP0d7PIJ5qNcsWW6A16YJ9X/fr2x9AD/WGAFDukRUWPd
5gNg1vqfuseuFWKtUaW4OdY6BeyzUQo=
=qg65
-----END PGP SIGNATURE-----

--zhwkI6gVP57BwS0T--


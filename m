Return-Path: <linux-kernel+bounces-348674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C2798EA48
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ED8A2856E3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7845B839F4;
	Thu,  3 Oct 2024 07:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eIBTDTjH"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B546A208A9
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 07:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727940088; cv=none; b=PCFPI36xK5Eovi3kueokDRBbJm4xexjGRcaqM45wYCq0NNKjsMSjtjN+gN0p1kxZkkP4eqZTk68stT9nIDZD8kX8/8vY/0MLt+mw1g8V9QJ5dqM0zF8W64Ony3k3BvJdAnRZU85YmJ6SBWbxWfvqxCVApkTMIxLd3AvsGAxqH+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727940088; c=relaxed/simple;
	bh=KAFi0DVtk50bO52mjqiQRByssH78Gq8mZQLl6je1+/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nusDy9hNOjxfMyzHMzdRzWOHyOZil49W60GDubywb0t1dpYwuEuMTMRwR99DZvyk+CsSSZgPw9bgM3no0XRNoBIJi5XaiVoRMqrsimbEtwRb9rhVDeNq3aN+JiDiD19XdTy9sdxdsn64dnmshy6UL/yWDBzy0YP5fzOWNUdLFdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eIBTDTjH; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37cd3419937so412815f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 00:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727940085; x=1728544885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iPgZXeELc3Zg4/DpNtWi3UzW49BiAHfgX/BBTfdIiOo=;
        b=eIBTDTjHKNf5FGngfGaL8wwhpE4ZXrq67pembCphi1aRM7IVDSJqfxspNg0R8looQD
         +weXbn8C/ZvpnVPOszItAMQVNoqw4+ZQOk9Hwaf9OUPt7Xs6WF8hrG05pXgsaOqvejKO
         XatBVJe55uDtNbYaR8o2d3RltlpJ6bgYRVzfoDXHo22CF5hXbLM7X7g/oS3Wl1W38vsK
         ZbeWHfmyWW4NJlC73lfpPFVgJ7g2HAjsLYFD51+Q6LJjeGtoSV7c599+JCvwKOH9UhdO
         Va7cXAhbhTCFJWxhixI3/vCEhHKA54WEhWvl3lTVQsde0TDFYhT9Bqv2s0TbqLcKziVR
         x/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727940085; x=1728544885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPgZXeELc3Zg4/DpNtWi3UzW49BiAHfgX/BBTfdIiOo=;
        b=L/an6ArcLhTw1Ic01p/0E0YMnJGLVGvqJmBqXSg4qDjC6mG9YpD17z5SegMHayYVia
         hQH+jnBd8GwmVlUCOwt78TknPGFUBg7cxv4lmKhKG+IYqrB+HhXaxtvmMO00rYPpclzP
         AQyYFGhY9S8jBiYkxfpMn1tQ07l0jIGNGemJJS0H1JYDUFrGfvd//EXR8Y6zX5jwplk9
         3uER34jJI2UnD6iv6C2EjbgrbfKDnBPl1aM/a5DHurbMRHR3MnEWX+T5KRfv9SX80mPp
         Q2+eRqtrhjiH4XmYm7NscGlCj7MtxSZsIMz4M4CfwouvJMg3lxrv/+jbvqJ47odRzDKo
         6CQg==
X-Forwarded-Encrypted: i=1; AJvYcCUyQf0oU9LftKjES74YDbBm5b8axrcZEM3aTz7RjGmhYQE6PeVtt3oZMhxxCqh/kBKzMHtBfaLuiR6LnQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCv/lKqnvRlDhn//5wrKX88vZdBGuzhhT5cBx4tD/t8FNsrs6N
	8pADI3vf+ojdUN7mLIYijd8aCttndFjtbGpA/KfQN/EQg7XCrjbUL2UVlJrZ6i3HIBe6Zxut/GO
	Q
X-Google-Smtp-Source: AGHT+IFrOiqBAIwd7dHobzY4mxrbh5jrP8h9t6/vvLZIijMNEkV68GQAekcFmejzaF+MYGGNUWovNw==
X-Received: by 2002:a05:6000:a84:b0:374:cd96:f73 with SMTP id ffacd0b85a97d-37cfb8b6405mr3020175f8f.3.1727940085072;
        Thu, 03 Oct 2024 00:21:25 -0700 (PDT)
Received: from localhost ([2001:4091:a245:8155:c84f:5b4a:8d3f:75b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f7a01f4a4sm37239545e9.29.2024.10.03.00.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 00:21:24 -0700 (PDT)
Date: Thu, 3 Oct 2024 09:21:23 +0200
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Len Brown <len.brown@intel.com>, Vishal Mahaveer <vishalm@ti.com>, 
	Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PM: QoS: Export dev_pm_qos_read_value
Message-ID: <hdvczc6j3fhtjadxwy3cybmzldaq42x2g6jshq563neji6evze@o2p27ox7tz3f>
References: <20241002194446.269775-1-msp@baylibre.com>
 <2024100333-maternity-equity-c7fa@gregkh>
 <tqsrnsvciupbovlalqsnrp5whst2mrpqntjblvymcunpesvake@o3gxa7vik7he>
 <2024100336-left-shadily-3321@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yadq6qw7azk7sply"
Content-Disposition: inline
In-Reply-To: <2024100336-left-shadily-3321@gregkh>


--yadq6qw7azk7sply
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 03, 2024 at 08:49:48AM GMT, Greg Kroah-Hartman wrote:
> On Thu, Oct 03, 2024 at 08:28:12AM +0200, Markus Schneider-Pargmann wrote:
> > On Thu, Oct 03, 2024 at 08:02:04AM GMT, Greg Kroah-Hartman wrote:
> > > On Wed, Oct 02, 2024 at 09:44:46PM +0200, Markus Schneider-Pargmann w=
rote:
> > > > Export the function dev_pm_qos_read_value(). Most other functions
> > > > mentioned in Documentation/power/pm_qos_interface.rst are already
> > > > exported, so export this one as well.
> > > >=20
> > > > This function will be used to read the resume latency in a driver t=
hat
> > > > can also be compiled as a module.
> > >=20
> > > We don't add exports for no in-kernel users, sorry.  Send this as part
> > > of a series that requires it.
> >=20
> > Sorry if this was unclear, it is for an in-kernel driver (ti_sci.c) that
> > can be built as a module. When built as a module it can't use this
> > function if it is not exported.
>=20
> So the current kernel build is broken?  If so, please add a "Fixes:" tag
> and say this in the changelog.
>=20
> If not, again, just make it part of the series where it is needed.

It is not a fix, I will reintegrate it with the series that needs it.

Thanks!

Best
Markus

--yadq6qw7azk7sply
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd8KHufh7XoFiu4kEkjLTi1BWuPwUCZv5F2QAKCRAkjLTi1BWu
P+UtAQDFPwSmUxZSxOCkLOHzRZh6biOMe3RBvDkO1kUYs6xozwD/TfvfZFCOqwxZ
4NPcbYGYqAMCSAnin+PMj6NW+a7RVQA=
=saUS
-----END PGP SIGNATURE-----

--yadq6qw7azk7sply--


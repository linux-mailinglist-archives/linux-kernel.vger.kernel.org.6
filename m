Return-Path: <linux-kernel+bounces-341252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 269CC987D47
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 05:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A53E284C76
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 03:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB1F14A60D;
	Fri, 27 Sep 2024 03:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="jxoBYAEI"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAAA320B
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 03:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727407975; cv=none; b=YywhNKyRvTepqz6DfPcuGNCtB++mSCJlymzOHISASxfZhC8e4TcN8ka5GwP5HGgDJYuVEpF+0ZtIpRMAQOfkh//88+8I/2Cjgsq1s2g3+aS8Ed18x8b9ohoYTIKKH+jkXME3m2FgvFgidJBom2nu6x5hX4WGhNErrqg/Fzt56Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727407975; c=relaxed/simple;
	bh=/lrc9CI4Z6b5YWKVdzvQG16q2Euckn6VYFOfZiKj3lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmYjfCIY0PDQXys38ViZqhOnyKrS7yGyLhxyK4c3ziVROP6QUULMJMdvY/J7USb0o1pPw7c2J5Y+un6FetxV+PaJ1QC1gkSgMSoXz7yKU88GVFhOO0R4UEC9ekpYs6q8MQx6d81jRkRusduLlQBs/9lxRxUazOGsf4Nf3kcjc6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com; spf=pass smtp.mailfrom=konsulko.com; dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b=jxoBYAEI; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=konsulko.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a9ae8fc076so172529185a.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 20:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1727407973; x=1728012773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FT1AYz5ZInguyhAyQkfDu1T2c/wYVULooHBd2Lxz9b4=;
        b=jxoBYAEIfZfUsyJWCW9goW7loHfw0Kxs09tvJqOMCYjUlwPcFqcjnMyeXQGFAMuh5E
         dgH2/zsxCqq0aiDKM3a/U3FFCq7sKLVBikj6sd87/B4NaRsGmfa+YFx4EYhlW3oUf0Wx
         JdlqFdKM0YoX2jB09UN+Y2AwlTqnpNv07kjH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727407973; x=1728012773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FT1AYz5ZInguyhAyQkfDu1T2c/wYVULooHBd2Lxz9b4=;
        b=vqX1p8lgRzfM54XG56Z2scQUU124YeFBSPcinyNxG0tntpB02ESwingMXzkoQbmEz8
         0gIYyzmuGLnrtpokKxHv4C+KH2idYQ7uwPdqvma6o7kEXP+xjo1rWOrZzBadZDSIbhMn
         IDTE1a6hWP4OvpN6HD6ysb0Gdrv9zqjjhdcOgDUk+TRXcDzcFLA3OXZBGisbQIBHLdzB
         mk1h/XrzLaoYwsWM7Dg2TQUZo+ceDHUW7pC/b+VjYRbGTCpQEYryuibya6ZQoF1Ckdal
         bot0oJjvILXwCUCXBT+SlvHqvTXq6cuIg2/NeH9BHUUZUPMXhkBLqzVGsMf30YVjYCw6
         d9Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUzAWd8hjfstPwoHoVvPgwn0SlEv1mTgu9TPtRtzcBWXaVrbafRwmuBlVI0ejTcH0WkZHL+t/0svZVKRHE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya+yp2ypS57Q1mV9ItPNIULpq9IctT32/OAoDtqoOzappnEXcM
	VlIKoskdX2qYuJSSQRn01n3wqWZ5B1C8F9lUUstOw5hsSFpfGiIHX3mfsJY73Rg=
X-Google-Smtp-Source: AGHT+IEcmXZPf/zk6kP93+GxoV8YurBmmJ962brMLc51p02WqaR751M62UZL/cdqx7HBRWbB0y4peA==
X-Received: by 2002:a05:620a:430d:b0:7a9:9fb6:64e4 with SMTP id af79cd13be357-7ae378c0de3mr256634185a.51.1727407972584;
        Thu, 26 Sep 2024 20:32:52 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae3783d462sm48236085a.103.2024.09.26.20.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 20:32:51 -0700 (PDT)
Date: Thu, 26 Sep 2024 21:32:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 36/36] azure-pipelines: Enable qemu_sbsa
Message-ID: <20240927033248.GT4252@bill-the-cat>
References: <20240926080021.148031-1-patrick.rudolph@9elements.com>
 <20240926080021.148031-37-patrick.rudolph@9elements.com>
 <CAFLszTgNiRAh3bo26avy+tPZvu9L1R=CuFKJP4LBCJ0gdXfb0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AyNwxBt30ZuYrK4k"
Content-Disposition: inline
In-Reply-To: <CAFLszTgNiRAh3bo26avy+tPZvu9L1R=CuFKJP4LBCJ0gdXfb0Q@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett


--AyNwxBt30ZuYrK4k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 11:29:12PM +0200, Simon Glass wrote:
> On Thu, 26 Sept 2024 at 10:12, Patrick Rudolph
> <patrick.rudolph@9elements.com> wrote:
> >
> > Add QEMU's SBSA ref board and run tests on it.
> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > ---
> >  .azure-pipelines.yml | 8 ++++++++
> >  1 file changed, 8 insertions(+)
>=20
> Reviewed-by: Simon Glass <sjg@chromium.org>
>=20
> Should add gitlab too?

Please, if there's a problem when applying that part I'll fix it up but
it should be clear enough I hope based on the other examples to get it
correct.

--=20
Tom

--AyNwxBt30ZuYrK4k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb2J2AACgkQFHw5/5Y0
tyyCwAv/XHarj6b5AaF1ezWI95Ikc1RKgvIUZKtFzoLNV3HYGpy99uB+eqoy23HM
MzrnDcmgY5wE7AeFwFKC/6Uh9DvdJrkbCBMTR+2pQMiS252mvatjQrd5Jn+hRF22
RPs1Ks8gso87u9C9MqSD4Pumq8hQ7WwOj352D5tJ8j3kVJnIzVWLeYhKnODWUzWc
Hf4okyqzSbiI3s3sAH48WC+MpRrWV249SYa2T7RYM8uAPrJyVo2kDyLjGker7+ym
zDS6/B6ecwPbCVqcCIUX7m+y6a7qCqMv7BJLu4meTaLzl1eLuS7N+u0V7OAkm0nf
Vgl2phKaDUinHtJWl+I6utdkDM2TI0v9eEfIbbZ4MH9Tj+win5iEy6vXxpEaTbjd
DgY2zhzkXxv9aRHhxkUw0vrHH4l6RyivDruJJHvvL7twkRs89kTWfLXOUQ1oTwQK
c0GXN2I+d4WUY2iT2Lmkl0ffXD5QDCtLJHly3bhPHVTJJY8rV87DvpHlVFU888I8
pdlHK7vQ
=4CCt
-----END PGP SIGNATURE-----

--AyNwxBt30ZuYrK4k--


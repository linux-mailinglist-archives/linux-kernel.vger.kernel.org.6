Return-Path: <linux-kernel+bounces-235228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4EE91D1DE
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 15:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA083281C5A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 13:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B1513E032;
	Sun, 30 Jun 2024 13:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGYCY8VO"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B2A3A8E4
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 13:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719754891; cv=none; b=C5Aq5GhJgximYfeU+eCQXIN9GuNiaDk0/LzvDMc+DjYTySFh+Ru6wdnn3TBD6cLkpfoGSfLLNBUL4qkIypZTKlUAx9NvdTnFrrV1H3AoNsNqDWKJCOVSQsTgcBEo7G63mqdTT/i8H51AlU9t0cU/apPKbNrFsh54kOWigGa6ggU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719754891; c=relaxed/simple;
	bh=stR/4EG0tqfvtxoABxHU7XCzR+czOAtuGq4CzGikbXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9gDxc+P8RwcZQYv5bNFDl0qwn3s4IeNNvAQKEz+iRnOUXX757a8CntSVM/yBELpn4leo9oVQpchQ5iM2dqdp+wwm5LP9jTaR/yVs5+qWLLBGvitMzdjFFn9NSrWh25LbGhHwWPZsCHxShkmS81FcT2WGKlcbCxqUufvapWFkOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGYCY8VO; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-6e7b121be30so1099977a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 06:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719754889; x=1720359689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=stR/4EG0tqfvtxoABxHU7XCzR+czOAtuGq4CzGikbXI=;
        b=aGYCY8VOtUQO0rCGdLhhjJodhgx/rGxclnyWb1EXpMyx1+Y/aGnI7HOGTUBCTWk+xm
         6+8uxyw3an5ci4yueN7ZRxwxqo4Rdupq68dOiS4hJbQlTBxPRFTBjEp1MbJCPykAN9Ao
         47dTussTVopHL78vylBM04o67dB3R3SzJo9LZI25lnSrZJ7Zv6JjgikIeJyxonts55m+
         eEiLT5Ktjo1BfRTHVNGjBa/z4SZB5FBTmcdMbLq0Bi8PX9P3LRLcgitaggI2HhZFUUle
         MDLxPhNcsmRbu2J3FhWD6uqWfq8SLgIa9QvVfzhXBkPUjeRLmyXBHpbbBvWh5nwGssbB
         Vxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719754889; x=1720359689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stR/4EG0tqfvtxoABxHU7XCzR+czOAtuGq4CzGikbXI=;
        b=bJPeA4r7dx/JvxQEWhOlHysD6VB5wqThBys4zHoLxGzII7QbNGJaI9lGAaTj2qYMoV
         K8e4fiqvgR48zi5J0dCnFN6E43EqBkGr9iAnXNXij9NZM8T+7jINlKqVm1/ExS1JcF6s
         ruCuqY19sSqzojIzTZPcYmKeMp98WYPqWayLL4rcGFIEfOOgu41gJBVxdZvkf7NlmWKM
         qJ/WV0QTG0vmoa3v2YavOj1swW5Em3zSYW8utEByKTGNMZvJzNt1Da+NOU7gKQRwIeyi
         1whkUblHZwFkJtYNZn+W+g6G5hLo+cZDH7I0Ql0IURP2eopGOZZHF+yOderaVjPILS8w
         bRSg==
X-Forwarded-Encrypted: i=1; AJvYcCWCtbJsOp+C7Z/Zcv9J54S4LqhDLNl5xU9ogQCHfIJ8tM9DfYKMMsyaiuxvqTWzApztnUZn+IfKzrFJd2hIdExlP7zBNr7fLNLCCAyF
X-Gm-Message-State: AOJu0Yy0KrmBwZo2G0GgPZW0QsqEyJQP9baoCjbwaR2RgJy8H1tuWpI2
	ivASWVkF3Y4lhmt3UDDVZLAnHhEdNXyA4aHHHOS29o0xH24UPwLE
X-Google-Smtp-Source: AGHT+IHLTBbv2dwB8EENkGJW+3Khc+RR96BHsDvWZpf71sLRj6VsrpgUe48FWwRoQZpNSZdz9oeQKQ==
X-Received: by 2002:a17:90b:d87:b0:2c8:dad2:83e3 with SMTP id 98e67ed59e1d1-2c93d72d7a7mr1359364a91.6.1719754889276;
        Sun, 30 Jun 2024 06:41:29 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce1683csm4870399a91.8.2024.06.30.06.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 06:41:28 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 179A4184B5560; Sun, 30 Jun 2024 20:41:21 +0700 (WIB)
Date: Sun, 30 Jun 2024 20:41:21 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: David Polakovic <email@dpolakovic.space>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: proposition for fixing Y292B bug
Message-ID: <ZoFgga45QCh2uA0i@archie.me>
References: <3be3235a-dea7-a5ca-b5ea-4047bdeb695d@dpolakovic.space>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mtp0d7qpyejkCAan"
Content-Disposition: inline
In-Reply-To: <3be3235a-dea7-a5ca-b5ea-4047bdeb695d@dpolakovic.space>


--mtp0d7qpyejkCAan
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 30, 2024 at 10:05:18AM +0200, David Polakovic wrote:
> Hello dear developers and enthusiasts.
>=20
> My name is David and recently I wrote a blog post about "necessity"
> of fixing 64-bit signed integer overflow of time_t, sometime in year
> 292 billion. I proposed this to simply have software complete solution
> for timekeeping. The blog had somewhat nice feedback and few people
> told me to write to your mailing list.
>=20
> As I mention in the list, I am no way experienced enough in kernel
> space to turn this into full merge request, so I post it to you and
> if anyone would like to build on this idea, it is GPLd for your convenien=
ce.
>=20
> Any feedback is highly appreciated so please, include me in CC's.
>=20
> The blog is written with funny attitude, but it is in no way meant to
> be joke, parody or insult.
> https://dpolakovic.space/blogs/y292b

Reading your paper, it seems like the userspace solution is to introduce bi=
gger
int type (i.e. int128/bigint); and you want the same to apply to kernel, ri=
ght?
Also, if that happens, I think C also needs built-in bigint type.

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--mtp0d7qpyejkCAan
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZoFgfgAKCRD2uYlJVVFO
o+xDAP9HWGu5pme27MJ85HzcmTNf/viNjunk8CA1N+nrU/Q3ZgEA3Kl8x7f9oDZK
3DOWL+RFSx6MEFgzygqLfCh1/c+Gpgg=
=mBCq
-----END PGP SIGNATURE-----

--mtp0d7qpyejkCAan--


Return-Path: <linux-kernel+bounces-242614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC04928A79
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 16:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD7C61C2302E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 14:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4048915216D;
	Fri,  5 Jul 2024 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2oJZCa6"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410EE146A69
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 14:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720189036; cv=none; b=ScGxffMOUjpW96S0SMt6rloZqCUuhmDFTcu/DF5gQzviGZJMTBiq61U5T8CgBvA8GAGGVpeQOo2VmBjXWPD8XlMSu5Hizi/CyEJYespbb9hJMfwczIzFhuUTnROEisEKoV7ObF8rhfeSzEJppxAyuVGPmXmabrefvv2wb/YqDJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720189036; c=relaxed/simple;
	bh=n8zcsf+cKLFVPpClQ4xkpjOCCIvIJFw2OCxLNBkkVz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vtv0GE/hic1M+KIhRgH84LcCR374oH8Q6sUyr8gRmE0UvQZTDGya8mVBoSqsVwTvZbHj0z5xM6suqK7cngVJsx8hr5YANCxzNYy8n4lLpMWFXAFTPxP2pSjch933psBhhFWZl1gNJVNwJSddmUoGXQmFIkJ40R3L39fyCWS/rNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2oJZCa6; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-6e7e23b42c3so956919a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 07:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720189034; x=1720793834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b+BcpyzLQnxvJ1Kfe3UTbGBPJSneNJ41TWH5rNXfDpo=;
        b=J2oJZCa6PJ4gV7EinC/2h5wOucokHcgvRA0FP3Uhp2+r7HwCzWkInHZaJO39FES9Li
         D4MvSt8SdyRcNUvG9BGaLvvHd6P6OkNKLFt6DbIa6FXLgtRdikO/BO2EUG4ApXTWMbSN
         UihL33RzAPgQ++Zt/yxEaIUS+e1a8/LvsBLa5Q4Tv6+gs6wPY7FEsmZ9lY67luqp4TAJ
         NGAL2d8r/2zvnM/QuIldM8rSeoEOS/VMrlYnrAHQQJfkS4XW7BzDDMA5DNnptzy8qam2
         JBs8iMXAkZbdRQtpmQ7QqRWh5gRUYuYC2mUbv2QXhuPV+2qH5fmCU5XIpCy6dXGpMJHg
         NKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720189034; x=1720793834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+BcpyzLQnxvJ1Kfe3UTbGBPJSneNJ41TWH5rNXfDpo=;
        b=G/b4j/0EcCpBso8LfXbU8egY8sOGPn+cQ9deq3uvU97ksMLIAIIBToDwpGOxM3/Mpc
         HsA5GQrUMtYuNcf/pdUhp/P9MIn8YlljX402PfAugLPdXT/wkBWJj53W98aN7TgSonWN
         tBLOMrMGEBx598EG8dqw6bXuD0Z4pLe35DFDvUTIX8hZqFo6xAXiQEBM938TnhkGAH5A
         1K226xJ8nZghNIbXIgMWZCAFtXBfVb9LTk3NKv6CFcMfpqh4n4Jt1EKV2Q2/3nHky65d
         2b/w/UBBIuEs2NRFneIWZif1mn3LnD2JUXAmu5BIto7+qnAIrPNpXEUZr1DA6gNq1awT
         AULg==
X-Gm-Message-State: AOJu0Yz9b8U/QHr4aAbBpo8bxFuCZ1ZCjiNk4srj31Z3tVYMwJzgSzgh
	KX3UdDA5HT/MuYISdeOEXFv1NAiZFocmZ7nmxNYQ88+kHJEmsJV8
X-Google-Smtp-Source: AGHT+IH2gZQ/17IR2+hr1qvtD889PWpZBS7KGodEU4flUX6Dz8znVlKZmOM2MVb5TfdJ5+5ARd0vXg==
X-Received: by 2002:a05:6a20:7347:b0:1be:c0c9:d007 with SMTP id adf61e73a8af0-1c0cc8baa87mr4545783637.44.1720189034362;
        Fri, 05 Jul 2024 07:17:14 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6b584624sm11321449a12.53.2024.07.05.07.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 07:17:13 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 17517185D7BCC; Fri, 05 Jul 2024 21:17:10 +0700 (WIB)
Date: Fri, 5 Jul 2024 21:17:10 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>,
	David Polakovic <email@dpolakovic.space>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Lobakin <alexandr.lobakin@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: proposition for fixing Y292B bug
Message-ID: <ZogAZltQIks_cN-y@archie.me>
References: <3be3235a-dea7-a5ca-b5ea-4047bdeb695d@dpolakovic.space>
 <ZoFgga45QCh2uA0i@archie.me>
 <9e3b638d-76f2-8520-2a24-7de0cd0bc149@dpolakovic.space>
 <ZoJx5GaBDHg7nayw@archie.me>
 <cef39a6f-426d-4c4d-950e-edbbe5e95acf@intel.com>
 <d88861a6-ccd9-3fe5-67e0-b50a72ca1e51@dpolakovic.space>
 <848ADF85-6138-4D56-8DDD-E327B8AFC5EC@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fzQRhIhgQALCnCeF"
Content-Disposition: inline
In-Reply-To: <848ADF85-6138-4D56-8DDD-E327B8AFC5EC@zytor.com>


--fzQRhIhgQALCnCeF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2024 at 07:59:13PM -0700, H. Peter Anvin wrote:
> On July 3, 2024 8:29:58 AM PDT, David Polakovic <email@dpolakovic.space> =
wrote:
> >I am not sure if I don't understand your solution, but extending the
> >memory designation from 64 to 128 bits, is another temporary
> >solution, which will again overflow one day.
> >
> >The sole reason why I was proposing the new "BigInt" type was to
> >store each digit of the time_c as separate element of array, which
> >could be resized (added one digit) as needed. The only limit would
> >then be the physical amount of memory in the machine.
> >
> >dpo
> >
>=20
> So now you are worried about the Y5e30 problem?!
>=20
> You realize that you are now talking the orders of magnitude of time for =
which:=20
>=20
> "	The estimated time until most or all of the remaining 1=E2=80=9310% of =
stellar remnants not ejected from galaxies fall into their galaxies' centra=
l supermassive black holes. By this point, with binary stars having fallen =
into each other, and planets into their stars, via emission of gravitationa=
l radiation, only solitary objects (stellar remnants, brown dwarfs, ejected=
 planetary-mass objects, black holes) will remain in the universe."
>=20
> I genuinely thought this whole thread was a practical joke...

And that's what I thought as unnecessary engineering churn...

--=20
An old man doll... just what I always wanted! - Clara

--fzQRhIhgQALCnCeF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZogAZgAKCRD2uYlJVVFO
o8LCAP949QKGFVY+WlBqWM/C08C6TfT9uPLUBdWMyHBy/UJ7/wEAu0VFc6if9CvA
ihXFSF8fVtTsGOtVZ5kWkUle9QfoUQ8=
=LWAS
-----END PGP SIGNATURE-----

--fzQRhIhgQALCnCeF--


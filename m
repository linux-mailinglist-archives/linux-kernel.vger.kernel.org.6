Return-Path: <linux-kernel+bounces-402582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B7F9C2958
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 02:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 914CB28513E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 01:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FA5288B5;
	Sat,  9 Nov 2024 01:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UG0bC4vy"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9B9D2FB;
	Sat,  9 Nov 2024 01:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731117071; cv=none; b=hIgd9N+62N99B1S78Xv70diKxhvjqy8d5suL5xly/gN2woowFodlhZgRXeRG6XhLUDWUoef7HbqBlvwXNIceEXHGPlI9mgxPlA+Mb20MEPQ7FqpARPpU7CbnomIULR40YHXnmto4CAgQx/fZi3bJkmWSbzfpBdxco5cJF4ASgBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731117071; c=relaxed/simple;
	bh=xfyJag2T35ytm36Eyc1zqhnhEsYhh9HIqhZOfJzFaeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2WtgUooJYK0N72oJtXq5TSw6iGboO/BVF3FVZuc92igCzSAbEaPTXHJuGAn5aqnyI8xwty2jj8zT5Jng/ul7Zr/GXRruu8Vl/DtXk8K82Tboez5LG9hKr2T56Tp17DZDedNLhWzihmoumL6pM43T+7jD9Ln4P8vTB/0PpfvWFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UG0bC4vy; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e2fb304e7dso2273537a91.1;
        Fri, 08 Nov 2024 17:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731117070; x=1731721870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NCSnHC5kBQ2EW/JF6VDQllI84SxLSCTPTHUF+4cUQIg=;
        b=UG0bC4vyQGmhWO4PHiq67KIZxGBjTxosNWToZYHhq7H3lsOcO62ZNKHrQMQDvg1hB7
         //MDTf50ZKkFvB8bTVMq+2bfg/nhQifG1RXmePE4GUrjqwYm4JK7a2EzX4fF4Z7HW7wJ
         x3mjItweWMxaY3xc09Ba+y4jzrCbrt9Tcawhp2kivhXYkfzYVgapGdtipYasspdJzA8l
         MWLI3z8WU6QpwhOzYOvHUXGPMayV4MJ7Exztizvr7afKDPR+p3KNWYVyhWIaI57iM6uN
         fNWIm1csTh0oDw4b116QnR0zNXe5VLz4VxeDwQBEuejWFMM+HYiV2nHSs/m220KVKAQe
         FQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731117070; x=1731721870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCSnHC5kBQ2EW/JF6VDQllI84SxLSCTPTHUF+4cUQIg=;
        b=Idddh3TF8mqaOfqKIZvdZ1Hfaa6Ck+r4WT13FOFRtK44IyWAesyiw4g/GVz43N9RgG
         LUgt2RSVtFzPt1Xy1DI6rxJayrwVfjCEwAeoJYOCrRsxHkHcFn783asApQvdosjBep/R
         tAt5dSbMdImouxq1nBpzo4uUdPny87vzm468mxw9WMucaE02BKqrQKgEFn37nGhMY6t3
         CVPHT4zPoiemmoORO1XVgh/0XDi1uEAAmtEUtNoDA+Gee+3lvS4OFMPzEh3ck0GyiftU
         1vBvVUZAWsuTc9jeKIpvfHuBQF71a5S9SFY5z7nLb3C13Ft3Pwe2lbt7Ilum5NCdeYDw
         RLsw==
X-Forwarded-Encrypted: i=1; AJvYcCVVixy6QF6ofexfU4rvonOyPs8Iyu5yg9HqGCjifoAo6hUu88aJpmK2vLxcyKD11hlP9mpgTAHYfMNfjL8=@vger.kernel.org, AJvYcCXbSA0zkLt6F9M4TcRcX7djVgDJ8H9r4dDc5ibUPy/DDqhfrjGWxOnj3mfIbkPeMDT1IhG8Fm/VjvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyJwzJBvupUQhy5m7vUAr2EqfSsYJF+i6MDB4aE6rs4fQ0yiE0
	S9b4FtcBPFWUzjsVGTlAAXARHdI896P+zoh5h/fc5UKoKUVV7Z65
X-Google-Smtp-Source: AGHT+IGW7cddmXwpgLZWeCkAUVTIcid6sLrD6AbdNBAPmPn3l0sTJkjWTFjXjgXL/E+DvP1HdbQQzA==
X-Received: by 2002:a17:90b:2792:b0:2cf:fe5d:ea12 with SMTP id 98e67ed59e1d1-2e9b177d820mr6531348a91.24.1731117069760;
        Fri, 08 Nov 2024 17:51:09 -0800 (PST)
Received: from archie.me ([103.124.138.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e44586sm37499075ad.165.2024.11.08.17.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 17:51:08 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 3771041F52F8; Sat, 09 Nov 2024 08:51:03 +0700 (WIB)
Date: Sat, 9 Nov 2024 08:51:02 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, anish kumar <yesanishhere@gmail.com>,
	lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
	tiwai@suse.com
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH V2] ALSA: machine: update documentation
Message-ID: <Zy7ABgpAcxrpid5Y@archie.me>
References: <20241108192413.10751-1-yesanishhere@gmail.com>
 <87y11twmlx.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H5TatopWhAH+XSYY"
Content-Disposition: inline
In-Reply-To: <87y11twmlx.fsf@trenco.lwn.net>


--H5TatopWhAH+XSYY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 08, 2024 at 12:29:14PM -0700, Jonathan Corbet wrote:
> anish kumar <yesanishhere@gmail.com> writes:
> > +Additionaly below example macro can be used to register cpu, codec and
> > +platform dai::
> > +
> > +SND_SOC_DAILINK_DEFS(wm2200_cpu_dsp,
> > +	DAILINK_COMP_ARRAY(COMP_CPU("samsung-i2s.0")),
> > +	DAILINK_COMP_ARRAY(COMP_CODEC("spi0.0", "wm0010-sdi1")),
> > +	DAILINK_COMP_ARRAY(COMP_PLATFORM("samsung-i2s.0")));
> > +
>=20
> This will not give you the literal block you were hoping for.  Please
> actually build the docs after making changes and look at the results.

My htmldocs build gets:

Documentation/sound/soc/machine.rst:81: WARNING: Literal block expected; no=
ne found.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--H5TatopWhAH+XSYY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZy7AAwAKCRD2uYlJVVFO
o9jSAP4oxqQ+PfIQ5Chdbl+3eQnDt3IXGhPLXutty+wWIWRmCgEAlhYDuiBk3e63
1LhcgoKbolpJXL/czizfY3ivQvWkxgk=
=adzc
-----END PGP SIGNATURE-----

--H5TatopWhAH+XSYY--


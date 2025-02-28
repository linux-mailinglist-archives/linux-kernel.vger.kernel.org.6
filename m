Return-Path: <linux-kernel+bounces-537624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C247A48E43
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 03:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65FF3189196B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 02:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEF813CFB6;
	Fri, 28 Feb 2025 02:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPrKQvl8"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A44125B2;
	Fri, 28 Feb 2025 02:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740708018; cv=none; b=XQHM8uFz57jxH9DsiT9P7q6rchBASK/v6bMgcrqD4XNmftVL9Hbm9iYzxI20Umq2xo4LpQtDazjY/CFGzFBom+3Okg9UbmRNM7mJt/2uVZ/Zh+CVhCVf/N26v9/U44uwFFSESQQYPIigtohwU1+JC00Qlca6kQT6hdMkQWWjLao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740708018; c=relaxed/simple;
	bh=i0m66G0oGYlw4dGrr3+zeRfE5q6XWuv5OG1RasO80/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUuITUp0szCow/2jMaKWiUhphmsdqkBy/C3hlqANS+VaQiK05Efrf2svQ6pBMx4fydrl9ZF15Ed70ea8wTf8pCcpQTyIAPOxFHqlwmyW9W60VWjh9J0cKwsjNvEPkv8Z0KSjcZzzzy8LSHt5+/+CQwyM+17UrFo7f2lPZt7IFMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPrKQvl8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22104c4de96so27624805ad.3;
        Thu, 27 Feb 2025 18:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740708016; x=1741312816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i0m66G0oGYlw4dGrr3+zeRfE5q6XWuv5OG1RasO80/A=;
        b=YPrKQvl8aElWP6bgNo7sEUyPVTbitwxK1rspwSPNdsjuiwjfax3oTd/opt8dst9oXm
         d4SsNk3BG5HWIBin4Vrl2Xu65MkxXUyDU+egFGFMEiXFyHHoZu/nnni82qeSWsQ/J/f5
         CX47d2U/ZhRC4tXrgYbnUnBxk+ilJSXN1ylkSOGoTiLk6nJuEVzW3pvmEhsVjUXok1ib
         kKe/KRMIsWjpQnOLk4sRMR8GJhELLJFIycVpZ/1MhiOVJto68ykGqaukRs2c+aJfWws1
         xT1/ZmAcSph8ZPrdWE94euKb7Sha2+7/U+BY33BrqqcEBt0sIPnMIMFKkY7rF486rr1b
         ic+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740708016; x=1741312816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0m66G0oGYlw4dGrr3+zeRfE5q6XWuv5OG1RasO80/A=;
        b=TJVK0p0UeMdKnltJmS6aoAzGnDfdDcmL2Ub5W3BIcArreZRXhpZ75xXWO6R1yjTsAK
         J4j8dRwblX3QYBP3RWmTtyxzwWYZOIivZ3cNaEiYrYQeGgVDKZolvufXXr/YMAwcK3uU
         j/j03T9EGDdXonFCKn6+ldnGZsOyGjhdZZaPl9ksAKGCF+NQYiDWBw11jHcjFFiXopZ4
         Z3Me0ylPeM3SCU6ytCHWviTJCfHNp2H8wU3TE+Y18ihV9cNCMocDrvtFFOZs/npHvKeH
         unt0OTuinxhLdgWc8bg2i469V17sECxNiYaRAf/CBEXjmdhykQiqwvozvQk2VpgKcA3m
         ingg==
X-Forwarded-Encrypted: i=1; AJvYcCV2a1JQtipWZUvuAOQBGyW8WFAN4uxQ9MnistgIxoLvNId7yGlbnquiEA8b+7YZBEXE2QCmEpiZhpz59qc=@vger.kernel.org, AJvYcCVd+xNHzjT/4qBxLwbm2D5z5Kfq47yQUYSWRmDVzKvADmBaJOTiLqhHodfgnhMs26JcHkT8cgyYWy4VrJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDA4mxiosN2qpjcm7zZuxcOzqxSYpPk12IW9CSdUrsi/i5SdXV
	09XKwFCKYRYFsP+7kQs8DP1Zihp0+EACZ2VMUWysMh613Wa+p4Y/
X-Gm-Gg: ASbGncvOESHY8IFntfCQ6ZptAHMbmd5ztUOK44UAKGMlNGxm7rbIjBgccFTCiIXFh0d
	c0XRVESTsQMruyxWqmGamSwaPkcwJ9mk26I9Z9OhI4QmtHg4aJaLCP4VyFJRHwo6hycB39QcTmD
	QixR2RhOK47Cb2ZR8lw+KYTotR3EwXb8Dxa+qouEegL+FnLIQYeT4piIEUsPpOiUu0Txs3EpwZs
	AZ84/zlLJ3bvbsezMILbUd3kX9RwOuLz9dzEOiDyl/WAqTgktT5JGOuzDSVGSXV0AyxLSnnNc6C
	WsYAz0OkdAdZP/5A4oPy8aW/+A==
X-Google-Smtp-Source: AGHT+IGW0dMFonepaakj1wuRrMpQ/un424w5pZ0d2CME1+ku+UQCi3/74lPDSjsGl3+iiwyUPwVOKA==
X-Received: by 2002:a17:903:2412:b0:21f:8099:72e4 with SMTP id d9443c01a7336-22368fc97b7mr28153775ad.28.1740708016067;
        Thu, 27 Feb 2025 18:00:16 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501f972esm22767215ad.58.2025.02.27.18.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 18:00:15 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 2B1D9412B0AC; Fri, 28 Feb 2025 09:00:11 +0700 (WIB)
Date: Fri, 28 Feb 2025 09:00:11 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Bard Liao <yung-chuan.liao@linux.intel.com>,
	linux-sound@vger.kernel.org, broonie@kernel.org, tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev, bard.liao@intel.com
Subject: Re: [PATCH v4 01/16] Documentation: driver: add SoundWire BRA
 description
Message-ID: <Z8EYqyqfW1xUpdAo@archie.me>
References: <20250227140615.8147-1-yung-chuan.liao@linux.intel.com>
 <20250227140615.8147-2-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lH9YPecz6GDZKscb"
Content-Disposition: inline
In-Reply-To: <20250227140615.8147-2-yung-chuan.liao@linux.intel.com>


--lH9YPecz6GDZKscb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 10:06:00PM +0800, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
>=20
> The Bulk Register Access protocol was left as a TODO topic since
> 2018. It's time to document this protocol and the design of its Linux
> support.
>=20

The doc looks good, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--lH9YPecz6GDZKscb
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ8EYpQAKCRD2uYlJVVFO
ow9hAP9LdvfzTcTegjos7NiaBDntFIH12hipdZ/yfwB49Tj2tAD/UvVnRMtymG8P
KMdB/2WZ1/1su+ZTXFYqdAZp+f7T4wY=
=+mgO
-----END PGP SIGNATURE-----

--lH9YPecz6GDZKscb--


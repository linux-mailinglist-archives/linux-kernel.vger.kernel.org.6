Return-Path: <linux-kernel+bounces-205804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D521A900087
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71BD0B228EA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BBA15B0E0;
	Fri,  7 Jun 2024 10:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBA4TkDI"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FF1224D5;
	Fri,  7 Jun 2024 10:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717755557; cv=none; b=nelkmYV4yOW2wW/HJa7fyLK8aiMxsNEjMbK9LXLUzb3lgC0FaxYtYw8q0Yf6Uq7dnxKs6Bsf66lkwUAdex8sjB9RmI1wOUg4OhoC8NdoQizMbhC0izd7fIegBKX21eCPV/xloKa8zSRgzTs0Efx/UeLIGRKfjATjG5dEjg6WpR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717755557; c=relaxed/simple;
	bh=QCZHpWK3iHF9Nj6nDnoKMCz5HjK1CLECoGyNt9nPBhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZ5lf6D02qn4gv5YKIHXNfy3sauD4aKfOXnlTtYQ1AhKmOsKTf6olOy6f5e7mdYkBeTMLUqbUB7noXV/KiaP3Hn7sN34wAPnCRHb4J+RVqU5RRkVhVQAr6B0mbnN8H2/pg1G7R6n5HRZmqop0E110kxd/cLI2kh6Ivv2catdIXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBA4TkDI; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c29c487a94so1429403a91.1;
        Fri, 07 Jun 2024 03:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717755556; x=1718360356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wxYrxOo+Bm8pOYfTxpDq7GYqUsxkUBuHF4IE+q+WX9o=;
        b=aBA4TkDISEa8cXwk4YOzwZvvtLDS3D0Ei0w0FLY0NMN3WjFZAye9sWkihUew+YeKjJ
         Are5tYOEZpFSFaVyKbPdKaP3CRKz0Doli8mu0xDUX1d4JQfh/M1Cy73BTLwSF8rK7A1D
         MRk3kjdrKs0/K8Ns5A+xC+QybI8f9lP+Cnf6703wJK+78kUaHmC9v+0d/ztmAxSdJ9Ck
         YDaEVDiTAgzhKZgTstntOfRkre0jHSfuqjS0aKW8rex7bDw+wNb4eMNxwQW7jb/bQar2
         fekOkbs5VS/5quiQEy16XgJRWHrkXCRbl4GJTgVPtSP0s/mMjUqtezzh7pD8Kci/T0ov
         GEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717755556; x=1718360356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxYrxOo+Bm8pOYfTxpDq7GYqUsxkUBuHF4IE+q+WX9o=;
        b=mxReJ4u+VF8/dNk+pB8pK7W3oBZnSWe0aH7UC0/Smho2yZEzKNv68K5XGygNruJi6e
         kDoTjVjk6xZigpq0iSOoy+dkv+GfFCWGwS0VHDs/x+/pyUY+IddaRXK+kcj1noiecgP5
         og86I3B66nLq30cZ7981wRukhRqaZAqiNCYEjay+tCWBcnuFbvsptvUJZii6O40lsETF
         8rCh8GliHuAupqAZmSRApJLTx+B9Z+TCZdiBEPEHlEJMnhimKpVXo+BBkF6OoG9f+y58
         uhQaUW0Pw9xndJtxzOYOCdQu3lhcQH/DnNeLQauFDcnLpdOC6hqV0EXEIgbdYPkxPWcM
         x45A==
X-Forwarded-Encrypted: i=1; AJvYcCVmvjCCvwc2omAaIfTkgI9NWpbCFQRhPjYGMu0wO7eymNpwF8ai2m2UXPGVa9jDfdzJp9uhLDm5Mi6scisbPcc4lKuxvWsmR/TFBpQg7MzDI9/v01Br2xAVny0shReTE47sTLKrWQhs
X-Gm-Message-State: AOJu0YwIs7/DFsbktVDJ+1HSHTYWH9krk+XTmHMLspTjsawrClioYg8c
	e41pIKFYrEBD/uEPTLnSmFOrBhkpg8t/R/NkaNhhQYedBcaF75GggRbXIA==
X-Google-Smtp-Source: AGHT+IEm6c/Q5B9vJIw8FRzlSd8REJszxYs3hm4a4v+zd3OtWa6JASXKZc2z9En4cJnl7UZ+lWaQ0Q==
X-Received: by 2002:a17:90a:bd0a:b0:2c2:b2a0:169c with SMTP id 98e67ed59e1d1-2c2bcad0d81mr1915629a91.3.1717755555453;
        Fri, 07 Jun 2024 03:19:15 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c2a2430365sm2856187a91.54.2024.06.07.03.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 03:19:14 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 8D4A71A023F27; Fri, 07 Jun 2024 17:19:11 +0700 (WIB)
Date: Fri, 7 Jun 2024 17:19:10 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: lakshmi.sowjanya.d@intel.com, tglx@linutronix.de, giometti@enneenne.com,
	corbet@lwn.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
	eddie.dong@intel.com, christopher.s.hall@intel.com,
	pandith.n@intel.com, subramanian.mohan@intel.com,
	thejesh.reddy.t.r@intel.com
Subject: Re: [PATCH v9 2/3] Documentation: driver-api: pps: Add Intel Timed
 I/O PPS generator
Message-ID: <ZmLenotdvHdCQRcz@archie.me>
References: <20240605153554.11584-1-lakshmi.sowjanya.d@intel.com>
 <20240605153554.11584-3-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9BD94tjZXN0vDobM"
Content-Disposition: inline
In-Reply-To: <20240605153554.11584-3-lakshmi.sowjanya.d@intel.com>


--9BD94tjZXN0vDobM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2024 at 09:05:53PM +0530, lakshmi.sowjanya.d@intel.com wrot=
e:
> +Usage of Intel Timed I/O as PPS generator:
> +
> +Start generating PPS signal::
> +        $echo 1 > /sys/devices/platform/INTCxxxx\:00/enable
> +
> +Stop generating PPS signal::
> +        $echo 0 > /sys/devices/platform/INTCxxxx\:00/enable

You forget to separate literal blocks above:

---- >8 ----
diff --git a/Documentation/driver-api/pps.rst b/Documentation/driver-api/pp=
s.rst
index c812d1cb760eee..75f7b094f9635e 100644
--- a/Documentation/driver-api/pps.rst
+++ b/Documentation/driver-api/pps.rst
@@ -264,7 +264,9 @@ the PPS signal to an external device.
 Usage of Intel Timed I/O as PPS generator:
=20
 Start generating PPS signal::
+
         $echo 1 > /sys/devices/platform/INTCxxxx\:00/enable
=20
 Stop generating PPS signal::
+
         $echo 0 > /sys/devices/platform/INTCxxxx\:00/enable

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--9BD94tjZXN0vDobM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZmLemQAKCRD2uYlJVVFO
o8BtAP9yWtBFjjePAasesCSU8ZZwSkjdM+8zMU9DQBCtz9lQUwD+IOIeje551r1X
MXasa+JpV4hSyT+AUSn2TK4lgVUIGgo=
=ZdMc
-----END PGP SIGNATURE-----

--9BD94tjZXN0vDobM--


Return-Path: <linux-kernel+bounces-445856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EFD9F1C70
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 04:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EF031630E9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 03:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229802940D;
	Sat, 14 Dec 2024 03:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6A4PjiF"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2883427735;
	Sat, 14 Dec 2024 03:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734147658; cv=none; b=suzqBDI4kWLX+/M9b+EO02iB69PMMR1YHOoQnfZChsNokyil59UXAyWWwvVCE0eXRtwHvKL88PAU3m/NWfK4J/no0c+Vkug7Emvae0Zeb+JTt6POgz/N9nykys3CPHnJhyVw56h+wgAPr0HYps95fClzowQMnxtW0r92EnHIC5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734147658; c=relaxed/simple;
	bh=iKUUUT6ljuDt8vem2EB7JGlcuNkV4mkGQjGhG2SSqPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pELt0fQ3+vEg74MZu96WwwzhG3nwzIvJbdEcAqQbt5CmpF3/lPbYvPa52QZCzWWB46DlYssizuBvqhnSBHfnBhDTmDX/+wIuyT1AGGcDgJc9vi3SCVN+oXUX2QdQB1ung0iQ7GNqeQDNqQMO1an26UBRr0smL2Fou1K/GIh7NkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6A4PjiF; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-723f37dd76cso1965853b3a.0;
        Fri, 13 Dec 2024 19:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734147656; x=1734752456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iKUUUT6ljuDt8vem2EB7JGlcuNkV4mkGQjGhG2SSqPI=;
        b=e6A4PjiFKGdN27Nyu6l7UmVs6ULydxBRz77Ch5hfvNR6reASQmoL9/zWN0gbnolzFz
         n2wV/1Zz6cqCf6ay16TbT3YlHPuhnVCyhq4zJMdEl6SnsxkHanZ5ZFkilIC/MqNJVlwo
         MV2uNdWpAUwgFaQV9mtEjXaleV+63GxaIDPi5bFgLjzaBAwUHGoqKD67N3ic/k+qSaCP
         QM3oZpJW29faAlp48yLcv/2GfliN0CXyzORMZpfwSjhotoUs8h/OYj5gdMp+74sExh5j
         GZgHOykME840as0rnbDIlVqxY2kwb6MksjVsaEMksY1UK5sQ/hZVG2xZHiY9W7snrepj
         6V8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734147656; x=1734752456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKUUUT6ljuDt8vem2EB7JGlcuNkV4mkGQjGhG2SSqPI=;
        b=BCKmoUvUtrRVy8wGMUVYShNniFIM1TqRd8PodLQJeFVj7OZGaIkNgRswGuK6AVRZZb
         KjVNmueTYyTIrGas6qCWo1cfo9G5GcRACXuP3t9T47WzIE96OS40K3L8lLzBf2NcZunD
         j1CXzZxf+ewgUKQQ5o8zXd3WeGxO/ePSwNodbGdWlaMJuDYL7XowHOVzcimDDkqiYN8W
         6TTVw6Hi61V26l4TaXiLoSBydS5VjAVk4/NCf7/nAOBdJoY9z3wdLahSGYjf3qvzu1Kc
         6+LSRBai+NyIulcEAZ8cHKh107BCF719WKNzdYsWH0FnxktTHKH7lcvLCTHLO5AkQb3j
         N9Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWX4f/gbdNurguUjLYQX2GrSxxtcgkC94f0jh2HyB+tZXE5Q/llgRngRI+3D3+UgjdWpUBsbNVApEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5LAuuk96srpxpsQmsGg9cj+GVeTJeC537Gv13en5SogW4ozl9
	S2NZUcgn0FIyrUSxFsUydNDh76mCwvIpsK53KUX7ZJU+69yN5vG395S2bA==
X-Gm-Gg: ASbGncvnpgPdBuqBVqT5gNBVTR7nQM+ZXAcPWiWkjQmMDw9GgzU3euCBbg/0KDued44
	MLhGkytrzSqzv323u8pKjr43SBG4kcHibdFGf+J9bzXFdOerudzXBisIXLY4cFTkavMw+UMy4Tg
	NGO/f6WwzJXdZZNP1EW9A96n8A9RegmEENkAujjEuwihaCu+56QMEzY1EFguJQurq9x3uGvPbLz
	bEdTqEfQOX5Xan5v6JWeyjfAsjA1aGxF4wvMw3n00nRAZ8AaKtTqW8V
X-Google-Smtp-Source: AGHT+IE0L1Q6ofi465+8gQViC0pKh6DWZQg2ALuIXrg9But6lYo76fjM1x120AydoPH25CuhLw2Dpw==
X-Received: by 2002:a05:6a20:4393:b0:1e1:a434:2959 with SMTP id adf61e73a8af0-1e1dfc19820mr5645384637.6.1734147656056;
        Fri, 13 Dec 2024 19:40:56 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ac5449sm552985b3a.1.2024.12.13.19.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 19:40:54 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 04D0641F5559; Sat, 14 Dec 2024 10:40:48 +0700 (WIB)
Date: Sat, 14 Dec 2024 10:40:48 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] docs: admin-guide: join the sysfs information in one
 place
Message-ID: <Z1z-QNcaPSRyP7EY@archie.me>
References: <20241213182057.343527-1-corbet@lwn.net>
 <20241213182057.343527-2-corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="13DyoRej8VWuQL9T"
Content-Disposition: inline
In-Reply-To: <20241213182057.343527-2-corbet@lwn.net>


--13DyoRej8VWuQL9T
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 11:20:52AM -0700, Jonathan Corbet wrote:
> The documents describing sysfs are spread out in the admin guide; bring
> them together in one place.
>=20

Looks good, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--13DyoRej8VWuQL9T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ1z+OgAKCRD2uYlJVVFO
o8z1AP9h0nVoP/xzgACB/Cy118QgpMOS/GAkSO8WvFp/N7CBrwD/VWfybIfPk97Z
QVLSe939HSyNoJmno6aoY/rsidn1UQ8=
=sz+i
-----END PGP SIGNATURE-----

--13DyoRej8VWuQL9T--


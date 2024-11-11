Return-Path: <linux-kernel+bounces-404818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BC69C489F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 22:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F4191F21E28
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 21:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA691BCA1B;
	Mon, 11 Nov 2024 21:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eddNke6Y"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D1814600C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 21:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731362188; cv=none; b=esWuMTAWUTD4vyvbhbxl99fKFrHIL22ybVnCy/VCMz2FiIKfh3xKuivsKw9x/SaeMlvTuXsRoTzev9G1RdMrGKXEwPqNZX6bhhPVF8v5o8YLf4+Anc7dOL6TAbsnRHw6l4kBOM/IOBONacQalQzpxMkc+a9dTLuHL26a+qcmYuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731362188; c=relaxed/simple;
	bh=X2B8lbXgjFXRqPkQwSeUoHXC4XBeWwW4i/owLjH/JCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVFj6IKG0Z1Ks2AnvqWHr2OspHJqjo+UvF+w37vZ2Zz479KKuP2K7Lz5WeBwB1RLSMZ+DtLQWLkhRBVd2RvCLLd2N0MFNRyIV7kXfvU0aXanAYSV0emgBZP1fqHMf4dvh6f9FreDB74vm+XkAkhcvgQle2bsTMte8YPbhCokzv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eddNke6Y; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5cece886771so1134213a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 13:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731362183; x=1731966983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X2B8lbXgjFXRqPkQwSeUoHXC4XBeWwW4i/owLjH/JCE=;
        b=eddNke6YaiV5+RYnZnZbtkM9cFrKj32uXHpxEwZfVcptFUKobYv+K7931+pWlh+Jjg
         ZjvHulavdBaAmdRL8rz22JYtLfUTxLfbbq9AWv2k9SBp5hqjssoK32qVV3lOdGQR7nZF
         TMNGX7OpcC+rkX9EveElbzq6kTP6tajBqE19u/7+5Mh8k79Z+9NnUSbs+G7Flye7i1EG
         tRkYjfmzzBbG8lvASN7hRzejshKvDxY9qTIefiKYNTKzr2zx2uo79UQdNUaN0kYII2XA
         DKqCXLMe+q6W+ELpLlLp73B3wguj7cXdJoDOvL1K3wKBThQ0IKWKkO53rtmhFXE0cenY
         UM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731362183; x=1731966983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2B8lbXgjFXRqPkQwSeUoHXC4XBeWwW4i/owLjH/JCE=;
        b=CzO9KshouF2dWtRX/TL3VvF6n0M8qvMAgLzRvcAnm9GTevJUDqNJSgiX0Ku3fdAVqr
         U6UMY/Pa6dkpxjxJe5Z2lb31sNsOY6ygxvneA/4Vi+GoExZyeVdCLeHnREhLF7g0s+Lx
         6wR4kWx4PKgw5HlPGuOWb7cyliF3FOQy35lNs+v9nmyFYFuMpEBN4WPRw+dRP6HEnNeI
         XACUNoEw3yo7P0TBmok13ZEh2l9plBb/SyrLNVsbY8slTMKnseVERm0ROIMBGj/TAMwj
         27NZ+uSjYS4x/U/K4OjQk31+0A5jOIwSxEUocLUQRlc2Gs6EqU2T64trx1WC8FmJxp6x
         79nw==
X-Forwarded-Encrypted: i=1; AJvYcCVga2ulnUskj8yK9EtOCPLIWTXa70WGXQefdbY8xR57XgEV85fOC8Nty3WexxW6L/kMNoXqHFdqeGWDF4w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ev9nvKbRGxVgwf6xS+C68W8xgtuPSZR6rA8/DIMbjWArrg0W
	90lWk5y6rotIehKPiuP8+OGVTJ3H1J/wGjvj5xddXiA+ybFwhlF8WtmVZ9fXLkCsqq5YObigGtt
	O
X-Google-Smtp-Source: AGHT+IESSpILR/iPGZm0pAhRtjg22DxKyqisSYGKu95NrISH3frP1PvPbrRXMGKpBiJ0cLMHB83xqw==
X-Received: by 2002:a05:6402:518e:b0:5cf:202:57f0 with SMTP id 4fb4d7f45d1cf-5cf0a4fc0admr14132879a12.12.1731362182661;
        Mon, 11 Nov 2024 13:56:22 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:5160:f0ec:2465:28a0])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c7cd57sm5263715a12.81.2024.11.11.13.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 13:56:21 -0800 (PST)
Date: Mon, 11 Nov 2024 22:56:18 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: Replace deprecated PCI functions
Message-ID: <dewm5vj3owzv4z4c7r7coev6dxsiu3gtecavve6h73pui3vmcw@w4zh4i7vdobd>
References: <20241111090944.11293-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="faadkvccw56m7kg5"
Content-Disposition: inline
In-Reply-To: <20241111090944.11293-2-pstanner@redhat.com>


--faadkvccw56m7kg5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] pwm: Replace deprecated PCI functions
MIME-Version: 1.0

Hello Philipp,

On Mon, Nov 11, 2024 at 10:09:45AM +0100, Philipp Stanner wrote:
> pcim_iomap_table() and pcim_request_regions() have been deprecated in
> commit e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(),
> pcim_iomap_regions_request_all()") and commit d140f80f60358 ("PCI:
> Deprecate pcim_iomap_regions() in favor of pcim_iomap_region()").
>=20
> Replace these functions with pcim_iomap_region().
>=20
> Additionally, pass the actual driver names to pcim_iomap_region()
> instead of the previous pci_name(), since the 'name' parameter should
> always reflect which driver owns a region.
>=20
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
nexxt
and scheduled to go into the mainline for v6.14-rc1.

Thanks
Uwe

--faadkvccw56m7kg5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcyfYAACgkQj4D7WH0S
/k5pUggAjScI9j/x/+n0cffC7BTBFHTwo9/8/l2A6Qq7JehofXA1wO3Ct4oPvny+
d27Go6GDo8EGqt8dPSz8ZFZnJO4z/8oOAeW3HyGNKCYg/6jmDCvLZMWUSOQGPjFv
UnHIY5BJULDJM3Iw2LIBnMQb6UrZ7w3RoBsaqJk6cr5i1kf2vm9hblBlSqtKjsE8
GTV+mysLp8rJFPvVkY6NfHjNlAAMTIiTIbFr4zfMlOsvuP3D2cXuX2It93qYclix
sOoZrTjZatzwbep8p6puMZT4erhBbizw3mhFBwLXZkI1loUGi+9/Hm5N/NYFcTJR
EByH+W/ihAXSyOoX/I8+FpU9ZpRo/Q==
=TPlp
-----END PGP SIGNATURE-----

--faadkvccw56m7kg5--


Return-Path: <linux-kernel+bounces-558995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 306A0A5EE23
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C4EF189FA37
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B65260A58;
	Thu, 13 Mar 2025 08:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JBTrMilk"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9281FAC57
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 08:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741855029; cv=none; b=pzF5X2SNKV+C3BOzAsxxJ81iIT7BfcVLKYvKUZ2zJFU45XShvjP4dpZKzfLbGZXu55TJdbEv1EQvk5bKH+tznk3sxy9hiarniTac3iunTMACpDwiw4fZ2G8YNUkMQ3r2HyFmn9hS+0bmQ58rXFz2LIGj0jhsd5s3w0tpsMdzPEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741855029; c=relaxed/simple;
	bh=ugQkNECBfRXgcwGIrw7wTjZKexEfnOnVSzCf4Z+ebew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IB+oAqf6BFoeZN4mCyQ5Stc2/FTLTCFL5N7DEZVzsrfQxTpfepMrcL2a45mdPyRDd0z4QmorAF/nltZDeMfPo9BAncxznaSFjqq8U9PYbLMTscsIGZXD+wKjSXousKVn+FY/uhkmOeSGc1C7dAcINooIyxFGA5tM9P/ms9GkHvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JBTrMilk; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-390fdaf2897so572305f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 01:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741855025; x=1742459825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ugQkNECBfRXgcwGIrw7wTjZKexEfnOnVSzCf4Z+ebew=;
        b=JBTrMilkuvKTyNH42BIJc+G2g8U1sFQczl/icNGgI53R8s/OGZASAeE7BGNP7DhlvS
         HYBxrAcHgYIPrI8C/oVsgak5GrfKJ08hkTvzctm18B2aPCzcYriAIkipUWX6iMiPqEiB
         26fDvUme/hXvhRllqw7zmwyO7voD0EzDyoFkrxgt0J5pNFlG4Q3kNs73GMSOv0G4ZWev
         UfcrUkXx9ZD+WKUXZXryVkXoFqGp2zsSuy/Y9WbKydEclfGHXF4GyFVVz9CczFPI4M15
         D7enMRX8fidk1tFuHgxpOpL851CXOqgjeSsFArtxdqr7hJ51yfa+vJTHSN0UwXY6gB4b
         V5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741855025; x=1742459825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugQkNECBfRXgcwGIrw7wTjZKexEfnOnVSzCf4Z+ebew=;
        b=v+bh+nrxPhlHN0ENFFWUvPd0MA8sc5A1M2KBroRoyOkoPwNEO5fSY3qWXYtIIxK7p4
         fv5P7YJYSYCGLqs84Xk5yhmo/YaclwY3v7IBwkOD8FyIkNVDaV+yJRR/30D+pDuEg+At
         cqrjBUqqZho7XWLitcwj3i6ELZPW2LUBGZ0KqDOHtvluhnJwiUx8bECewlTkBIT9iiqE
         jNyc7dqHIlhoC/PRssjpw/HQXWi3x4XYnXke0EBXHOBrSYoYSG9EvuIt9a1rU6obPdyH
         m/z7K6XdzG7NWeQJORhTBXjMa3E7fUWmyOQMEbO3h/ZZe3bdxl7vGqPDEKJ9d8NUZ16J
         A8tg==
X-Forwarded-Encrypted: i=1; AJvYcCV5lCbe9BVZxBDSc2L95/5v7heX6HuiV37/4tETz4OccleHFfu6lSOIWaBgqfQeTR+JniRlQ7BSx/3alLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzeTdVuGwtGcZLqykYEr3dnEsxn6rycUNa8tFQPWPWHuPWpmQG
	wqh669pvWt8GCLL+Ewhvc/NX9t/soTbS3peLu2jA91CDp2B8kqcqyADvHY74m4g=
X-Gm-Gg: ASbGncuKzDB5hh7vj28s1v+buoALv6gG65/J64TwoBDEVVjTy/657AgDKnofyB8j8k0
	dq59OFAvMZkJAgpFi8hTblLHiKXyG401+rJuS+cO68IkTsUdvQ0W/swjPmwqQa6FXHeThAnZ6Js
	oKJT1Zpks2hFMDUNPxqQehtR4B3kKUoM2CIQm5p7DPKzaNeLK5Gzb7zvu2LxFuDCod+FKptHypH
	3BkkGcRzXY3JZLSXiC/lLi3zkK6kxQTaWqCIKXehv5vXQh48oNngF8e72yBrE5GB1dqu7XBCncN
	YURPSYGygPuur3HqaPz+Lqpa+R7gLni9GvrP+SHXvIb/gI2FOf1IT+43jaoP8U/jzPiraWQQeaS
	l36i/bofAT/BqwVE/8YDQLw==
X-Google-Smtp-Source: AGHT+IGa8APTeQnlwxDKUjS+ax6i5zNtH7Hdestp2aTeidDLtPqJonK/5BqJTKtWco5wTr7shcT4Dw==
X-Received: by 2002:a5d:47cc:0:b0:391:3049:d58d with SMTP id ffacd0b85a97d-39132b58ad8mr23026970f8f.0.1741855024695;
        Thu, 13 Mar 2025 01:37:04 -0700 (PDT)
Received: from localhost (p200300f65f14610400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f14:6104::1b9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975c6dsm1358884f8f.54.2025.03.13.01.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 01:37:04 -0700 (PDT)
Date: Thu, 13 Mar 2025 09:37:02 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: int340x: Add Null check for adev
Message-ID: <uudh23zxngyi534idmutg6v3aowjnokedomv76iyanuda4nocy@m5xqjtdc47kh>
References: <20250313043611.1212116-1-chenyuan0y@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ltu4d5dxxuaxnqmp"
Content-Disposition: inline
In-Reply-To: <20250313043611.1212116-1-chenyuan0y@gmail.com>


--ltu4d5dxxuaxnqmp
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] thermal: int340x: Add Null check for adev
MIME-Version: 1.0

Hello,

On Wed, Mar 12, 2025 at 11:36:11PM -0500, Chenyuan Yang wrote:
> Not all devices have an ACPI companion fwnode, so adev might be NULL.
> This is similar to the commit cd2fd6eab480
> ("platform/x86: int3472: Check for adev =3D=3D NULL").
>=20
> Add a check for adev not being set and return -ENODEV in that case to
> avoid a possible NULL pointer deref in int3402_thermal_probe().
>=20
> Note, under the same directory, int3400_thermal_probe() has such a
> check.
>=20
> Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
Fixes: 77e337c6e23e ("Thermal: introduce INT3402 thermal driver")

Best regards
Uwe

--ltu4d5dxxuaxnqmp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfSmSwACgkQj4D7WH0S
/k4m9Qf9F3arLo1S4o0YnlIA3s90IPd/1RuM3dHBs1oXzLpWHkvtrNy+6z0Bb+l8
IrZMDcMoO43Yn4610voPh2aJS7NVSzU8LW4NYP7skMYS2E65lqFH9maHWT49w8x9
fm0hCNnS82eev85GZHPaMZmrSGWUCI6l6+8vOifElW1dXbhhr8//RiHK5rEr4O2t
6TtRYR3uW9vhE3u0827TbScAntRLdiVJ0sC0ZTYav10TooeU2BkflCQcEHPIWna4
aEylb5kABebeN3peUje2/DuaXu/Y/lWjhyJR0wPfrEjjnROuvrnbRWygLZH2yen3
zpCPvf2yI7IKBVjF4/ykIN196LjkkQ==
=1hnP
-----END PGP SIGNATURE-----

--ltu4d5dxxuaxnqmp--


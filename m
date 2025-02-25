Return-Path: <linux-kernel+bounces-531066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC3AA43BBB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15B6D420BE7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8450D1C84B8;
	Tue, 25 Feb 2025 10:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dXQfYYfK"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C094F261399
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740479336; cv=none; b=cFuVWai/XbDAvnzdCPyX7iq2vSFndwDKzoJBumC1MRNgsnzgWsz40UQhLio6RjmFtpbxgrxyJXKHvykX5jqKz6w547CX6DuhaJENc6vdwRsJVq+2Q3psy661yjD0K1B/O+pZ2UnIyRV1LNaq/WB/K0zLjxC4qijnVeVyYuIUm7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740479336; c=relaxed/simple;
	bh=lw7LGz5u4+UY3MSVtdaDIcTdVd1t9SjnuxeMySHbeIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jq6Bv84T/Khbfyx8uLIXXhWfMpglD7CjIMWCMDGbdGHAhVdq3DjFx+rh7BqRjRMG5YyJHhBPmxv061+NNOimys0MFncQtKr9TUryY014v9xIqZk1RRlN/fbgxWXeXvTLBL9NrlhJJBfhLkIAcTURzh5+NeYANB7/ppSG7YEoyDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dXQfYYfK; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-439a2780b44so33823585e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 02:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740479333; x=1741084133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lw7LGz5u4+UY3MSVtdaDIcTdVd1t9SjnuxeMySHbeIw=;
        b=dXQfYYfKuOPsuHKGMYaAyYAlL5LjoJTcuej+QOEToCgzk6dHhny0zasRm2kNVTu6D0
         m9OwIkeLxTfrL+hXi7oeWX1c1XwWS5+evTuEcjUKwPKrCNBq0/RkfgjfosqqAlLTEXKk
         cERwlFUjYnOikFvtGetgok5ilAXny++i4nv4G44dlVV3tI5GuonqyiFCrIv7xGM5FP0w
         6Co+zukyLgB8JEylIqCAKTKB3jA18vWUDtaHCgM0Gcn+a3BXOvJaPb98A9uKcDqCIHxU
         +0b8L7udU6k0b8yO3AU4hXX+eTfyYho7BCDUGJcizeEeFBj4BsINpR/XhjvHIUudX8uy
         Ho9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740479333; x=1741084133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lw7LGz5u4+UY3MSVtdaDIcTdVd1t9SjnuxeMySHbeIw=;
        b=SN94+hgwZBddnuI3Zzfhjc5LOqiBx7N0jKKx0EK6e2JIgwAsTrlJ5YmU6GPnVakQFL
         Cxa/c9e2BCNzaZrRVblAjilrP69eQ/gYCKng6iC4Hp8c2LcZiLwrEekaStg52K9uU0kq
         3hfqBBcZvBTcdyQWUa4B1xbtK4wFjMQQd4SLGkoskoDGEvX6knsP8q8E12ePQUGIQsh7
         B9R8Y13Kg/WXgvX/fGk//orXdRQ2a7qNJPoXc+QO6/oFemgHpaWi+ylJPvRd8TqYlt7I
         t90v6B1TBWYlsnb/b4Uj6PHHpF2Re6Qrc6KQrskYpELxGgqkcR1FVUNYcf6JPZRFotBd
         jcuw==
X-Forwarded-Encrypted: i=1; AJvYcCUAsQR3CY4bAkSaw7yCAfaYknGvJeu9/a+L2yMcylreaqokVf7INsPu3TqTN3begHYvQ97ki83O860J0lM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5GCYaXfLgpILS+UhONI/2XU/CdtHYoaICD6/rEsU/SiKa7oB9
	+YlJhJeIVIj2Hk9EXt2f7mYVfJGYSf7ohHoK7UWmfmgTS2gaR02sWRHG2MR8Nr0=
X-Gm-Gg: ASbGncvHhrVHix6hehB5K5dXvDKaaVdGuD4UFxYu4kTbMwjlTejuTDKNntqGN51d7Vl
	TYZIGzsrOUUU14RgorVgwlAum7qNBuMu/GC2yClNIqBXBmWPjoY9ecaKYX6DESDxAhlKpf5Evxj
	J5gjR3P/Y+dzR+Wk3Rx6327plTo1hlYWsHogcvFP+HlXJcI9uCkTOa3DMBLwpALj+D8zrzbVPyJ
	QJ86q7gmrI2lZKNwF59ApSZg8KKPL8cApbJUQmC6uoMDrAHuNU75xC8uXFzo039fBvvOUVpED7n
	WxQ+AdnjJ/Z4zUt+3GYqmQ==
X-Google-Smtp-Source: AGHT+IEIzE6LVOdzTaiF/XQxe5YVoLSwzJB4+evEnTKWGqEM97O2xxmk4cpePWYkQ5BISMx7dPcrxA==
X-Received: by 2002:adf:ea8f:0:b0:388:da10:ff13 with SMTP id ffacd0b85a97d-38f6e95b41dmr13202225f8f.21.1740479333083;
        Tue, 25 Feb 2025 02:28:53 -0800 (PST)
Received: from localhost ([2001:4091:a245:8327:7bba:546d:aa63:621e])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390cd8e7233sm1802184f8f.66.2025.02.25.02.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 02:28:52 -0800 (PST)
Date: Tue, 25 Feb 2025 11:28:51 +0100
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Judith Mendez <jm@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tero Kristo <kristo@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hari Nagalla <hnagalla@ti.com>
Subject: Re: [PATCH 0/3] arm64: dts: ti: k3-am62a/p: Add r5fss nodes
Message-ID: <qlqxmqluqrw36bkjaa7efcsk6cinyr2rxvznfhz6dopeu67dsf@w4lkuq65uwno>
References: <20250122-topic-dt-updates-am62-wkup-v6-13-v1-0-f74835b91da9@baylibre.com>
 <c81ccd05-4fb7-4ec0-8cc0-c59ac4dff91e@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="obza7ftg5kvgvlah"
Content-Disposition: inline
In-Reply-To: <c81ccd05-4fb7-4ec0-8cc0-c59ac4dff91e@ti.com>


--obza7ftg5kvgvlah
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/3] arm64: dts: ti: k3-am62a/p: Add r5fss nodes
MIME-Version: 1.0

Hi Judith,

On Mon, Feb 24, 2025 at 09:06:56AM -0600, Judith Mendez wrote:
> Hi Markus,
>=20
> On 1/22/25 3:54 AM, Markus Schneider-Pargmann wrote:
> > Hi,
> >=20
> > am62p-wakeup already has the r5fss node defined, but it is currently
> > missing from the am62a-wakeup domain in the devicetree. This is added as
> > part of the series.
> >=20
> > For am62a and am62p starter kit boards the r5fss memory region is added
> > and referenced for the r5fss core 0 node.
>=20
>=20
> This has already been sent here:
> https://lore.kernel.org/linux-devicetree/20250210221530.1234009-1-jm@ti.c=
om/

yes, I saw that recently. Could you please cc me on the next version?

Thanks!

Best
Markus

--obza7ftg5kvgvlah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd8KHufh7XoFiu4kEkjLTi1BWuPwUCZ72bXgAKCRAkjLTi1BWu
P3ayAQCmje7sVfMPAH4ZyOoLuKscrkF/LVOMHgeJryGd7sabvwD/Z4OE3BQ8OMVR
Z4ksn1XTyKXHDVVnCnaiIwLS83cpoAU=
=qRs/
-----END PGP SIGNATURE-----

--obza7ftg5kvgvlah--


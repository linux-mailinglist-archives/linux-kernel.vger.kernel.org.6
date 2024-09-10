Return-Path: <linux-kernel+bounces-322294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB209726E4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 04:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0FACB22627
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 02:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596A81411E9;
	Tue, 10 Sep 2024 02:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPoWyiHf"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FF21E517;
	Tue, 10 Sep 2024 02:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725933747; cv=none; b=Gixwnox3zMLASheZovMJULySdDT3/XTuVHrxKU6oWjVyev6OdxJ74FqnsKYrq/Ov9aeR+N4Xkqgq+QyXq4maoMXZaSxYqlvEhfIvOyQyxKoR/anzuhBp0Gb1ALWLV4gpYUc8sPEKpf87IOxd6iNTvsIF/6wlZRfTpta4LIoZXrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725933747; c=relaxed/simple;
	bh=oo9et8eatV5v0o5cwFeOQ7zBYoEYomcd/MQiVgwvVEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8D1mqRoDB4mHMBMIgdpdkr/iBpEsoI3cu2PLB7xltpxLQCtZn/P7RE8Jcvf1Dz8Xc8Ahy9BBZZ7bGmM6V7Euql8XHf0dWcKN9RdMeZdM+cfGopR6hGvo1B1ZPWW+kjYoZ/qYWuV05Y9EK5EL4V7tmZpGmFabdg8gzyDulpJEkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPoWyiHf; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20570b42f24so2387095ad.1;
        Mon, 09 Sep 2024 19:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725933746; x=1726538546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oo9et8eatV5v0o5cwFeOQ7zBYoEYomcd/MQiVgwvVEs=;
        b=BPoWyiHf+cURhaTsu20Qsk9ltuv4yV+VzO/IynvdO0tDx5W9C7IZE296c59K3fz35f
         t8jRgj9/nVUdQPOTZBFnnAM1JOwMSu7OdwL+noqiYubOA92teecRmI+2yBxKknUzaJmM
         zTNTNxl915ck/Y2VdLGcpnGfxr3eMkziYFIZy8IZ1K5yJMLUEos13PRb1tMduzeL3vx2
         q0WQu5m+qMUpsqCLxVLIoTB6a6kvcr9w+YaQjg/hTosRJQYdecA/3TgQHBfSAh8Wkga2
         c2ebpH6RyoQeIK6zDwenNwSM2ckIAe5ArpsOi5UJUQw2LfhOrKSwfdbTMdMBhCQfX6GJ
         +kKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725933746; x=1726538546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oo9et8eatV5v0o5cwFeOQ7zBYoEYomcd/MQiVgwvVEs=;
        b=u6EvyuvJ5R/OLhs8oUGoasn/4yI7CSpprYHex3IdfzCjkMh0dXWskQ/njjnNPwfOQ9
         DlOX2M7eDnWl4gdyuOPHUIrV+FZGeiad7VBRUWfHQN4wkcdekq0knk7NBFOzHBRk7a+J
         +hui1MPfQnrfj59w0EqVKGpHF2UmPSS5FrNW9Ud+NuI3m00/c89xtizq4Q8iESMRI6Kq
         9yzQ5usdg5tFxzmkg74KMaLv7v4nEFXmNUG0jvVtQ94t2BD03RAG0FpcuXXfXSGkDk7F
         Pu3fP+ia3eUtqHgdZJzkOzW1zJSU59kMkwUrgH5VgkkEAAcPgdphzvJl/TUlanynEAeJ
         9MHg==
X-Forwarded-Encrypted: i=1; AJvYcCWazTVep5FpmsLqseZnuNdYFAwYCwf3o0dTV2edmM8urPZCZY9b0P39bTajJF8R8h50whcHEfAk+bhTFUyH@vger.kernel.org, AJvYcCXz/VFtTLWOOKR+SE212KwKv8J2h56ZyPn/sivwFISw6j70Rp9FOvz9LWgGg2+Lae1vhU9ptdLW5dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTKUfgdsjwO5Lc5MWMN4nsQXwsaKF13RPNN2RF/46tlSyX2T7g
	IXLZxGvS9RUhGku3BhNh9pHr/KllPxqU5v8oibApjD8c6JyIumN+
X-Google-Smtp-Source: AGHT+IFE520PjC4tkS5HlvkQJ8Ze/9dl8z9Fj4HV6j3FUw28wJqwGyaFdtwAXDYkof0yQhV5q9iokg==
X-Received: by 2002:a17:902:ea0b:b0:205:2d09:9a30 with SMTP id d9443c01a7336-206f04f1ab7mr124575695ad.13.1725933745514;
        Mon, 09 Sep 2024 19:02:25 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2073c488bc8sm11934125ad.135.2024.09.09.19.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 19:02:25 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 50E894A0EB86; Tue, 10 Sep 2024 09:02:21 +0700 (WIB)
Date: Tue, 10 Sep 2024 09:02:21 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, cvam <cvam0000@gmail.com>,
	kbusch@kernel.org, axboe@kernel.dk
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Typo in the file 'feature-and-quirk-policy.rst'.
Message-ID: <Zt-orTrbAO5bJEKC@archie.me>
References: <20240909200253.19818-1-cvam0000@gmail.com>
 <8734m8h9ce.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BeuglxcILx6Ttd16"
Content-Disposition: inline
In-Reply-To: <8734m8h9ce.fsf@trenco.lwn.net>


--BeuglxcILx6Ttd16
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 09, 2024 at 02:15:45PM -0600, Jonathan Corbet wrote:
> cvam <cvam0000@gmail.com> writes:
>=20
> > location: 'Documentation/nvme/feature-and-quirk-policy.rst'
> > tested: Not breaking anything.
>=20
> I don't stress a lot over changelogs for simple tweaks like this, but
> you could still try to write something in our normal imperative style.

Something like 'Remove duplicate "and" in 'Linux NVMe feature and quirk pol=
icy'
title heading.'

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--BeuglxcILx6Ttd16
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZt+orQAKCRD2uYlJVVFO
o9kWAQDyqIR4IxzJDaRN5ocAdAzJhdpQINXvVtj2T7FJtmWw+AEA6kHe261vKPHS
UTZ7bO7aqiEIS1XGgEP5slT1O7i+cAE=
=ZEWk
-----END PGP SIGNATURE-----

--BeuglxcILx6Ttd16--


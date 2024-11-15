Return-Path: <linux-kernel+bounces-410395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AAF9CDAF1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 09:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16080282E92
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 08:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B556618C924;
	Fri, 15 Nov 2024 08:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/qvP2QI"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928AC1632E7;
	Fri, 15 Nov 2024 08:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731660784; cv=none; b=nEpg5mBMzhDobhG5wrTOKwJrTExy3CFc09HW+vTFasQpYjS56DpmPYGk//GcYr0HOP29F/52LW34TQPx43pJvvPnCeW8WA0oCcA8mNGIxoWLzkmoOXLKFnZO3v05DNHXSx4ucWb72C0XFaB9VGnoNUqz5VLIBOm55UtdfgUkIT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731660784; c=relaxed/simple;
	bh=iU6eBIp6waOhY6SP64Je5OJAdsoOlzresKnQlFYoS8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVbSbE/4CyKGi/zoiIbml+h6D5cGq+OxMb0JOJEuZW/VUpKr8j9rOA0aFTniRxegYEPlsjo9pa3J6kVHhxrNdaXJFSw+WPCZv+cZ6SDulvFOxQOgW2YPYAaCRb1du/t13pm5vAJixYPNnhzxNH7k26TXCX5yZ7Ov7af578eWHGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/qvP2QI; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53d9ff92ee9so1735553e87.1;
        Fri, 15 Nov 2024 00:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731660781; x=1732265581; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iU6eBIp6waOhY6SP64Je5OJAdsoOlzresKnQlFYoS8A=;
        b=c/qvP2QI0OYQPJ02u0XKsHcKnAPA4I6xAQOG5Dzh3bvUq5MZwMiQr3Ej2G0iHYtlqk
         9hwOUYwzNfho7RCQAJlkmnHPRtNABn0OpNCjfxVteTGW9/l2XvqGiyw0HJFT8/Ry0izN
         OMj006UnjL26vFm4tABf+RIEHo9IyUTN4D2zqdyX7eLhw5bi1PxghMYoBEDsjPfdjiQd
         tGVsAmW5/+BOHRRjQ1V2fVl0i0VZ58l3/rElgfJ3mDl1MuexywVt180JV69qeQ2KJ/Vs
         PcK+wZDsrWB8wUAbIqO63ONzebcPWZqEtim4hdL3sgQsLyXrGv049jJPM7JBDuhfLLH2
         kSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731660781; x=1732265581;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iU6eBIp6waOhY6SP64Je5OJAdsoOlzresKnQlFYoS8A=;
        b=OeBxjaKeqcAnoLY6NrjOzez0NB0C/V3UepLIYGlv7ENd/mxXEytmwb+CJigX8sEliz
         rUwW+hJ+F+oonTIGtPxp9w60UeQD6dEQJe+g5h++xR208rsCYdL+i6CiriHcqiGWL5ad
         x1gVnxU2/Mqav6vbqUkO2vSI6PHJOdGkhkCUgHhbeEFqyV6kjkivklz7IjyYV7kkmrCK
         +MP4vUDY7BhudEOP6E+iKtVQsZbsLuXQxEok8mSe+qsXKbFfOk6wv7c4X6ZHesl7rPhR
         g+7K6gAOTBK7blH39Gg76E0R5+TVJ/Y/k2XF4iqwnx9J9WBrnhQ4CvF16bqIXMJFzq6t
         MnjA==
X-Forwarded-Encrypted: i=1; AJvYcCUY5qo9l87N6iganl0d8ckjO+jxX4QRd25Y091tH8QZDPVroOu0IHkCxlUMufNDQdI8FzAk+h+5UfLU@vger.kernel.org, AJvYcCVgST4w+JDuFiY4Lly+MJVACZMCQ3eD2c5jJrTA8Fga7hSKQIookvDcsJIjLpKXxUnuxirYcj9l7deTLfSG@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmp0pu5N+iWYkhfbVLrG+p+IDaHQ/Zemf2xo1Vf6fGVGIiE/QS
	uB45hxAj1rpGvcS79rM2QoWkkfXViUNeyTTTIXBseqDXzlP8mlgZBwM9A24C
X-Google-Smtp-Source: AGHT+IGLBF3qhVVzM7RshxSuc6/es49n+LJgEE7VoQSuh4kNKt+Ja+wDG4nGENjUfW+XrS+fGjH+kg==
X-Received: by 2002:a2e:be93:0:b0:2fb:5ac6:90f0 with SMTP id 38308e7fff4ca-2ff609a8cbbmr11354861fa.34.1731660780276;
        Fri, 15 Nov 2024 00:53:00 -0800 (PST)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff597a0650sm4838791fa.51.2024.11.15.00.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 00:52:58 -0800 (PST)
Date: Fri, 15 Nov 2024 09:52:55 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v7 1/2] mtd: nand: davinci: add support for on-die ECC
 engine type
Message-ID: <ZzcL53TmSOwTuIFM@gmail.com>
References: <20241107-ondie-v7-0-98829fc8a958@gmail.com>
 <20241107-ondie-v7-1-98829fc8a958@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="h1/h1bN/JLK5O4bQ"
Content-Disposition: inline
In-Reply-To: <20241107-ondie-v7-1-98829fc8a958@gmail.com>


--h1/h1bN/JLK5O4bQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 07, 2024 at 02:47:07PM +0100, Marcus Folkesson wrote:
> Some chips, e.g. Micron MT29F1G08ABBFAH4, has a mandatory on-die ECC.
> Add "on-die" as ECC engine type in order to be compatible with those.
>=20
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---

Can someone please take a look at this patch?

Thanks,
Marcus Folkesson

--h1/h1bN/JLK5O4bQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmc3C+IACgkQiIBOb1ld
UjLVIA/9G82izGoDipxNJ2R/Qw3k3V+JB+WnT4Hf4XnW3qpuQZ4n7o7FndyQhg1t
Z6i7neMMsPhbxUwq2FGZWmlEfX9novuQIoSFS7t40uqClyPYfr+yjNknoEtZ4N3g
xbCL14+vPzU9dNqiJxAwwpcAn/xvfPSbb4P5rPmqObKCNwm2TjrR+CAd3B9MeTLH
MpTGyZMVyv3Z6xFMXChHhPxGZRMtTG/KDt1QIUZnqJ0vj8d1Z3ctpYhh+o1klTtI
0jBrF8GxNV77WAOBpYFg7PhVqToBAbOJfkOSB+uQVgKWpNVA1lYHWRM9VUwBepAv
0WY8cpQp4uf5ZLn7oUUWsHy0/eIK90b822hgneXNgdNk6i1F/PxWP2FccqW5VESi
rAJpU6P89nUlYkbiyorE3bkK2t04yTnpk0dNgvvBhLYncPdqy94PpWSw8olNtVAV
Snqg6iiRQ18oXmsXFGAbCGXYaSx7F8GcGRYi24G0MSAFDXa5deuS9cjYAwJAmclw
PYio87RbVtnSyrj0U07ylJ5gxpD0H4/aXROU7jwzJ8upUrDYl4iXIjjzmY63wspF
SEJrOjZdLSWtnXoskB18RU8isFrY2uYK/8b5gH+zKNyGiK/VUNv1AT86B3OlKl0N
O3CuyYPWzOVlGi991nM9j0JqEzt+FmUveQWKHNgAQYkYSsrCzwk=
=oDRL
-----END PGP SIGNATURE-----

--h1/h1bN/JLK5O4bQ--


Return-Path: <linux-kernel+bounces-382616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D909B1115
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 22:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF75B285412
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1202D213145;
	Fri, 25 Oct 2024 20:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="urAwzhEo"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3E520EA3C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 20:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729889674; cv=none; b=KyN7BB5CYJ0cpIjH8yZgrEIyYvLsDgbC2rkXEuyqPyM6PilVlGE1Zw6DU1UEVkvPxz4P3tOhgODI7PcNOU44VETI9/FiLhVyEiigdpvfZ5Igr8qCnWsGooL2pMpew54KxxjGb8aVv4/F7M6qZ4hLnbR+jJpmI72DlA3AdSD8zC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729889674; c=relaxed/simple;
	bh=UovCrfPyiLvrmTLVq2JyxreTUbMckaKmOg9CDHOp6jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Guq4PHP/iS/HniN1xICwM3nCflZRRRmiKR61ky2jzMkFwSXcthupagSVoqrGYXATc/7CnLwKUkIN3nMp4i62pbnWr9qaeh0s2sTUToZZW0BZVrdY2SqTKtQbe4oWRYDsXq0r98brp+jHFyHHm3mbkgr1+pJ+goi2wAUQGaa6SMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=urAwzhEo; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4315abed18aso23487715e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 13:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729889668; x=1730494468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UovCrfPyiLvrmTLVq2JyxreTUbMckaKmOg9CDHOp6jY=;
        b=urAwzhEo8ULau9QWpG2N+0iAoO+51bT9p3eX8fIEmEr5LkXaArUBIBnlJAqs8lOJVe
         nVZI0X774EJ97rgTQy7ePSV/eRLC1F89p0aDNIURWmTHuiuW4n1LXQ7hRmZGgwWzd5l5
         wioMNMf3z5ob4GQrtRlgtDLcV+F9WVl6yzUplyz98kjI42ZqQJvD91vnsR11jbs0F2yN
         bGP5/bJOxu+BEXwqCUsc7RT9Iue36PYs0EPc4U0wuy6Bj6454+1Hx5KtjDX58BG8Saj1
         xgPtpm/YUzDuaPTbZYrMebCxaffCr7JS/TzeDn+VOFjljkKFFUm4sGGqCxMVmRagBkH4
         l/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729889668; x=1730494468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UovCrfPyiLvrmTLVq2JyxreTUbMckaKmOg9CDHOp6jY=;
        b=cdez6Lue0KB+ti9OFbkc8Gr4yYBrq4joi798mtIHuta7obhsCAz5B5OwNJpzdhcS9h
         5S0DjUVRfia/kzuuA/7tRYAq4Ki1r10LG3YH+rBIDYrIS8FtALB4FTsY9bk2FIn+WP8I
         1V9cSblYSVqYKgj1AzXeXkSrTsoJdMVseu6adBerRpNzzdRyiywT+42skujE5jMHgmDJ
         LDQ4T99JsoXqZgdNuVpIxpR0LkgZar94kQBDBH2ZIYU1DhlxbFbXYY78Yps93k81A7s0
         6JdwfaMIsVmziOMnQBSFDU5HFLFde9nT4MPC5JkjjJoK6bLuv99fdV3PxEvnetk6D932
         97lQ==
X-Forwarded-Encrypted: i=1; AJvYcCWA2Puuq+AeGt7OahOt4HtrEEVKriLZROug92yHPz7G3H0W87XiIE7yGYmYOHQP1x0VgrLFKZCd5y5BVcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDuCGkybkqAuJ0DS8VCCs+cw9dnCkSm09oIfZWqMbY0rapwXU+
	WoNHXZ0HN5T4Zh599o7tZx9DZ/ztYT07qLe1HQFmeMAEXO88ISRWRV7aodqe2Tc=
X-Google-Smtp-Source: AGHT+IHxLhLEfFxRgu7h9w0l+WztIyINqpEmMUJPx34Cr6SvnF+wJrpmY8/idMcg5DzJB4v8afF1Vw==
X-Received: by 2002:a05:600c:4588:b0:431:51c0:c90f with SMTP id 5b1f17b1804b1-4319acc2ca1mr3810585e9.21.1729889668135;
        Fri, 25 Oct 2024 13:54:28 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:e349:2d5e:1c7a:6c80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b5431ecsm59693375e9.5.2024.10.25.13.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 13:54:27 -0700 (PDT)
Date: Fri, 25 Oct 2024 22:54:25 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] pwm: core: use device_match_name() instead of
 strcmp(dev_name(...
Message-ID: <eojlu5tv3kltam2eumfqzcsl7npexzpm6elwt4uc5whpfnq7qs@z24uatucv75z>
References: <20241025142704.405340-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jxwieeydcay2izkt"
Content-Disposition: inline
In-Reply-To: <20241025142704.405340-1-andriy.shevchenko@linux.intel.com>


--jxwieeydcay2izkt
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/1] pwm: core: use device_match_name() instead of
 strcmp(dev_name(...
MIME-Version: 1.0

Hello Andy,

On Fri, Oct 25, 2024 at 05:26:34PM +0300, Andy Shevchenko wrote:
> Use the dedicated helper for comparing device names against strings.
>=20
> Note, the current code has a check for the dev_name() against NULL.
> With the current implementations of the device_add() and dev_set_name()
> it most likely a theoretical assumption that that might happen, while
> I don't see how. Hence, that check has simply been removed.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

thanks, applied to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

Best regards
Uwe

--jxwieeydcay2izkt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmccBX4ACgkQj4D7WH0S
/k6nPAf/bhbbVveHHfmxCHN1jdSAQ8u1TN9jcvBoVp1VKY91cqkuOMI9hJknHCeE
ytyw7c9VZ/BLat7W4TWUvSpDV6gNr/+VkzozpXX3TkObeqUn0IxUEvn9pfR0ZtN0
z4vQCSieYXDdA40OIJCEnGpRaGyF0Xq6Yi7AdbsljPOmkH36mfWTZOJwvmEnlsf3
2rkay4xJW8zk3+GxRl/r0hrZSYz7xLd8dPzhginc9n41XiVrS4qaVrGfWYslGXn/
ufszpxIiccVQDaTz7r5B5+E9onqNASzgtQNg/2MeBv/HEgs/rVWFBBIP8t670iFX
oUYrs+GWoZlnazEzPByfXezPOQ4W6g==
=e/l3
-----END PGP SIGNATURE-----

--jxwieeydcay2izkt--


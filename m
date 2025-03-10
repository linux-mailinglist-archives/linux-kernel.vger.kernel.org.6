Return-Path: <linux-kernel+bounces-553818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D760A58F33
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AC137A63B5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A054022423E;
	Mon, 10 Mar 2025 09:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="E/DHiQZD"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2157E13CFB6
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741598072; cv=none; b=GeS0mxus6i6bqLrr+FPWRUV1qNOfk8lzXeJHcHsTsoty9rKvEaRPBnodlS+GiKWcO2bWj/qV16Hsjt7d5oZlFSm8nbEi0935fwepxQz4FAJqPLQ/V5PflYnew5DyUcV69Orr2J1rn3K7vRuV0cI7bpeysJkI5TM+KDZyMdfoYrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741598072; c=relaxed/simple;
	bh=Luqd5qJDerYY56SVYxkqiHGsWQEnWc7dsdUx6yqSP0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKdS0z9dWjyAffAQhQYKV5UgwXGXpdhWXm8pjRUzzM5RnxPA3zZjNeUi+XRLWobi2EZi6jbKNfAut8iGXh9u48+8KwnmqB3eA3NDZeTjhw6VhAJSXXGX5je+mYVVXbjOn2WSPvuzSUT57xvdYNVVjiGeZYrQ2uznj+Ib/1Q5TRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=E/DHiQZD; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac0b6e8d96cso577239966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 02:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741598067; x=1742202867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M2AFDf7Np+5eqeDRg3+giF4aI5aOo69QM3HUv/FvtGA=;
        b=E/DHiQZDCo6VYJun1JTnzWDLhBf85zmgphPIeB4RtGRyY6s47K+J2TRo/TJsQoyi/W
         0NhmwGjaZNaDhlDMGD31Ad+/nfbalI0ZTquc8EmZiuUSJpanW0Yp0cxz/vXbsf7piUF+
         j5QOYeTME2NDkqFcX9sjmIu2tG5WDeMh1OwrlStQjgbUDlbpAa/V25j9/n4qlliDlRwD
         j0lb6R6bFBUGNzwZ3Kn5iWRxDANQnPXAvfuxBe2e3haZTVFTq0zfIf6NyC3XCngC2HNr
         LsbIUF9PW6jlUS3tnM+7Oij437CNU4eIux7Be9S68Jze1OtuR4CrawOvtPwXQX8Ef0MW
         Fpjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741598067; x=1742202867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2AFDf7Np+5eqeDRg3+giF4aI5aOo69QM3HUv/FvtGA=;
        b=ggKC2b9ImtHXKnvctirYLoQgHCCQVUwPHWrFzMcUMi0KRLQrD0OHFcHmFediMIFyYu
         P1JzVGbOvf0Arke6uLvdVEBPZt5a0S1D7BpIDODOimopmc9o/RpUjFCTC03eFZSmKANp
         7c+D/dlRAWEjmQ63iKjVQ27CyIVlCr1g5bgSBMm8oGUJkx3zdsLzThHz39l3Ckoupx3n
         S/tvOUxL4yRtdgVrGlWEfQ0KYlPRMwaFCURacG2r4CgLvrj24bUEt0XzSXJMaelelYj5
         R8IlXlOHmtZl8jdr6uqPn0r2L/9rMkt+FLaUhQP9ECu/UpHWSiMJ0dos08utjEPa6FJs
         IinQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbWnssbvMLdZfO+lTJaaQMJxHMlWCLOh2FF1f2xBC0C/Lw2knCl4QR0k7l5fLDoYaOZLxuBcp8L0hmQ5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdWoy+LHR/aU9bIfLxoldHp445RQ1cTcjzZL0e4qlcZdEo1Mln
	4FUZHNivgh8QmG28h35lKsnzV41Oy4kvyemdHHynPyDc0TANkOltzwaHaSKc9fU=
X-Gm-Gg: ASbGncuu9wixuJtleFEQ93NO3zsYZiY8nthrrBn3x/uK23JaMD2sDPqEQhbzxwCLnys
	L54mE9T9fumYlbPT9NBqYO6LiMy3k6Dlm+kzIGsKsfbJ5AwSU7z32Um1EaE3N2SVEPiBPbwpnRV
	ymjaxDRwuvuR9bn2IyQBnZdcjNXEXHJM0950Tx6REFckxIxTDfLX1UUd1ttBOO+GV5dPtlCcgUw
	Xq0e/2opihQ58viTHmjLEO8ykbWsa7wreiEKWkNbf6g4aft3w0OCch7yDQUb9Jr6k8fAGf173LW
	LR9a/IzokUmuy0RTbKVbUM2oZd/dHtvoRlsYpe7LUDodLrLuW3a3XXtKbzqx8LWpkI+5RbbJBPm
	MTuPMIOw=
X-Google-Smtp-Source: AGHT+IEtKkKBpM7vJgcnY9TXytbV/kIe46JnVxeVKL/rKi0cxkwuBUhSX1GFWK3r6UV3V93xyzgxSA==
X-Received: by 2002:a17:907:3f9b:b0:ac1:ea6e:ad64 with SMTP id a640c23a62f3a-ac2526e5e87mr1604200066b.28.1741598067222;
        Mon, 10 Mar 2025 02:14:27 -0700 (PDT)
Received: from localhost (p200300f65f2c000400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f2c:4::1b9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac29363d604sm226706366b.76.2025.03.10.02.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 02:14:26 -0700 (PDT)
Date: Mon, 10 Mar 2025 10:14:23 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Adam Ford <aford173@gmail.com>, 
	Frieder Schrempf <frieder.schrempf@kontron.de>, Marco Felsch <m.felsch@pengutronix.de>, 
	Lucas Stach <l.stach@pengutronix.de>, linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Makoto Sato <makoto.sato@atmark-techno.com>
Subject: Re: [PATCH] phy: freescale: fsl-samsung-hdmi: return closest rate
 instead LUT
Message-ID: <v57uy3gddzcoeg3refyv7h6j3ypx23mobctybt27xzdyqy6bgb@atzdlqlytz3c>
References: <20250310-8ulp_hdmi-v1-1-a2f231e31987@atmark-techno.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hbn3u5scrvz7ixpx"
Content-Disposition: inline
In-Reply-To: <20250310-8ulp_hdmi-v1-1-a2f231e31987@atmark-techno.com>


--hbn3u5scrvz7ixpx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] phy: freescale: fsl-samsung-hdmi: return closest rate
 instead LUT
MIME-Version: 1.0

Hello,

On Mon, Mar 10, 2025 at 10:21:32AM +0900, Dominique Martinet wrote:
> From: Makoto Sato <makoto.sato@atmark-techno.com>
>=20
> If the requested rate is not an exact match of the integer divider
> phy_clk_round_rate() would return the look up table value,
> but phy_clk_set_rate() can still use the integer divider if it results
> in a frequency that is closer than the look up table.
>=20
> In particular, not returning the actually used value here made the hdmi
> bridge driver reject a frequency that has an integer divider rate
> within 0.5% of the target:
> for 83.5mHz, the integer divider generates 83.2mHz (-0.36%), but the
> next LUT value (82.5mHz) is 1.2% off which incorrectly rejects modes
> requiring this frequency.

Is the unit here MHz or mHz? I suspect the former?

Without having looked in detail, I think it would be nice to reduce code
duplication between phy_clk_round_rate() and phy_clk_set_rate(). The
former has

	if (rate > 297000000 || rate < 22250000)
		return -EINVAL;

which seems to be lacking from the latter so I suspect there are more
differences between the two functions than fixed here?

Ideally the implementation would look conceptually like:

	static long phy_clk_round_rate(..., unsigned long rate, ...)
	{
		hw =3D phy_determine_register_settings_for(rate);
		if (hw_is_error(hw))
			return someerror;

		return phy_get_rate_from(hw);
	}

	static int phy_clk_set_rate(..., unsigned long rate, ...)
	{
		hw =3D phy_determine_register_settings_for(rate);
		if (hw_is_error(hw))
			return someerror;

		return phy_apply(hw);
	}

Best regards
Uwe

--hbn3u5scrvz7ixpx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfOrW0ACgkQj4D7WH0S
/k7gagf/Y2P7oymDjrfXm/iN4GTuPoKu5hSM+CyX/Lsjb4YvVl/NK1hJJSmNav5G
8klQotxMRKJE0ucdaGv9hSgrK8MQuyV440H0f8Idpv1GTHjQiaMi13kMerzfvJIf
/xVRmw5GO0HV+1NEUS4xTVpUcCNeobAAOw841PY8wyHo8v/ml90LugLVg+wJs9lM
rCPiv6MbDHyEw9IUnkztM+LK0dnEvxVOmbuGaG6LfG/YBqxhJqrL1EwIsJnsSt4Q
6xAadOZZvGwgT73BumBalZH0z8xG6CWrHHyoqMQnQ6KE9nhnPouyOT1a35Y281bb
XjbCmTyQC37mJNKirDEM1K6AMeU5FQ==
=uTzQ
-----END PGP SIGNATURE-----

--hbn3u5scrvz7ixpx--


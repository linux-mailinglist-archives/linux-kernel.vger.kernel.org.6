Return-Path: <linux-kernel+bounces-199082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A178D81EA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 018BDB24CCA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EFB127E3C;
	Mon,  3 Jun 2024 12:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXUBy0DL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBFA127E21
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 12:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717416496; cv=none; b=OAAA9v41eXj2Cko7e20rJyY6q5l1d786sRgM9/ec1N6AIT4KDzNU1UALXBPMEVzP/kFxaKoTMOgUBVqSPbcaaoyjV0cnTcISb7U43yeOb5UNck958F08ztbR7Lf/phTd43XdfQAi4nkAPWM4CH5vNDY/c9phhYMuKL/PPgRnWec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717416496; c=relaxed/simple;
	bh=txo1zrYkxf+0ZJQAqK5afPzV4wne0EoLNFtJcUAUCj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBMBZTajlmyg/UdkD4Tm35jWipLrRBR6HbsJwoM+lPlBnPoNtywuFELeiXpd5BzvnieHoalRRRVSq09Fx0UAXs23muxKiEtrA5vJFBNb8f0F7jStw0xVQLrvs8wGvvRy+ZIJ26S0Rm+LCyPkg8RkwcUQ2xyacpny6KW0G0hZowc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXUBy0DL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90B9C32789;
	Mon,  3 Jun 2024 12:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717416496;
	bh=txo1zrYkxf+0ZJQAqK5afPzV4wne0EoLNFtJcUAUCj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SXUBy0DLUaohXY9twKQYiuvqKG1GzXp+01Y48xtFw2v9k/q0Q3etClTbrJ5tVa5Br
	 0hdlQrTS2ltzYbDlgWqzuokh2MEVIex17i2tN0CUnhzFfQoC351kNW3+mABkBK10Tu
	 x2BNIxiYBZx6Co2vBKRdEdICTQp1U2VTWQ7WvsvfewdPszZzBHnNytXBhKIP211j6b
	 dLi6hY7thvwHsKfZ6vR98FWTK83dfxAs40K9SMVC9kC/SGW/VqDd/VDdZFWFUr2JAQ
	 2GGQDnEN6kHgQjtO0mPBcsqUoOGH3832YBYOvWHT0mM/jp6S8LC+PL82UFuwS3KFyb
	 5NxaR2bv+suFA==
Date: Mon, 3 Jun 2024 13:08:11 +0100
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jim Wylder <jwylder@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] regmap-i2c: Subtract reg size from max_write
Message-ID: <37abbb4e-cac4-4278-98fb-0af75e5b3ef4@sirena.org.uk>
References: <20240523211437.2839942-1-jwylder@google.com>
 <ZlwfQ3ERbo5snLcK@surfacebook.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o/3PMIcJ4m5eaYT/"
Content-Disposition: inline
In-Reply-To: <ZlwfQ3ERbo5snLcK@surfacebook.localdomain>
X-Cookie: Don't let your status become too quo!


--o/3PMIcJ4m5eaYT/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 02, 2024 at 10:29:07AM +0300, Andy Shevchenko wrote:

> >  		    (bus->max_raw_write == 0 || bus->max_raw_write > quirks->max_write_len))
> > -			max_write = quirks->max_write_len;
> > +			max_write = quirks->max_write_len -
> > +				(config->reg_bits + config->pad_bits) / BITS_PER_BYTE;

> Interesting. regmap-spi does this slightly differently, i.e. reg/8 + pad/8.
> I'm wondering which one is more correct (potential off-by-one I suppose).

The above seems more correct if we have less than a full byte of padding.

--o/3PMIcJ4m5eaYT/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZdsioACgkQJNaLcl1U
h9AAkAf+LVj40HA9xmSzj0Hr25sNKsNGbVaeKDNu4SfyvU4xByXqHWlF7IKQZC7w
4IQgrm5DThNk+dX34NeuR7IjC3wp3/rQLGPvYiH0IKoArBoGXB92/R50RB7piFhp
bFw0OgWyJ/jxWrwPAz8a/zHaxNLdN1ck21WhwTGr2z3IONKgo/k293keZJxt7kvD
fw6O9ljs1tka5yrF82DDDGGae+G6sHvhlpvdqj4hC9Yv2fzNy+ep/uXsy5aeNg2I
z4mW6fFpjYmoqZSEoiZKWNW3NzffOV9ZxTlgn4Lw39DkXkMEqT+d1riKNQi8lQSv
ZgCt9QB/2D/PrV0KY0UDDGc6Qm6zrA==
=OKvO
-----END PGP SIGNATURE-----

--o/3PMIcJ4m5eaYT/--


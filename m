Return-Path: <linux-kernel+bounces-200536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 773CD8FB166
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 142071F237B1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E54E145B34;
	Tue,  4 Jun 2024 11:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qEFeODUP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CBC145A07
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 11:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717501816; cv=none; b=XXJNvApSV3QH2R/5/8OhIC5i+w3q4TkHYPpSpIc8kMrkuxYKsas+k7FpqyffRZOSq5G5j/2Qy41vZU4alv1hHIaBfTWYoDQYiBMctaAsdQvlMbpggo+rOnVpIUQcUh0vxpMysBtV5uJ6SCdjN1uq2OepzYvPj26ojVHrCpxBbV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717501816; c=relaxed/simple;
	bh=mFSfIKByx6aZ1W4YLw/zLDTvluO5wM4RDhYZh9oEWhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UT5oL1yM8x/pX4E35uO1HcYGI9L0EcjzNoZ6vDGKCpnxWbTOXRnd0X19Q4EHpJkK2rjTUihfs+pATkPfYczWNi3sXUlXcDn9pkk7m4mZiDxCAZv3Xm5mS6DYFvJ58AHpM7ytGV7Yyb9qLDqmoIY7/Ux2j2JWmQbSg5VCo3wOXJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qEFeODUP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB61AC4AF07;
	Tue,  4 Jun 2024 11:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717501816;
	bh=mFSfIKByx6aZ1W4YLw/zLDTvluO5wM4RDhYZh9oEWhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qEFeODUPozNWRgMm91/WbrDAfQADEJMSMmyULvD2q1Ci3/SwyIVHdkrP/RgauHb3e
	 Lj0WJaLMM8MMJqGMxrgzMPay7m8Fs91+DAVNn/yh/Td1q5x6tZDCePPHu0d017hwF1
	 wnXMYLpscbvEbEXt2qEgenBlyvBw8Wd8oebcG2CzWP+j3UmzY2VXXfcPDENGcwL2uu
	 r/i699ELh6W9geoSSVrrT9P0QgSRnGnzPxUVr3GCfN0cqSYfpbiLyzYnl97VffuNDj
	 yu0Lb/x9Te1FQL7CugzJg8zutJPTj6oiwnq6CPb4QJKsnCwYZ7SEw87P2nm6iYWZkC
	 SXqGtbSGRIOHQ==
Date: Tue, 4 Jun 2024 12:50:11 +0100
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jim Wylder <jwylder@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] regmap-i2c: Subtract reg size from max_write
Message-ID: <fba0b9ec-744b-4b8f-acdb-becb7d14ee93@sirena.org.uk>
References: <20240523211437.2839942-1-jwylder@google.com>
 <ZlwfQ3ERbo5snLcK@surfacebook.localdomain>
 <37abbb4e-cac4-4278-98fb-0af75e5b3ef4@sirena.org.uk>
 <CAHp75Vfgu0eXXJ_FTgMC-VUzTRSo7zoA4C9j3WsevPzhajpDSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Fnf+u0jLkXcfkqNi"
Content-Disposition: inline
In-Reply-To: <CAHp75Vfgu0eXXJ_FTgMC-VUzTRSo7zoA4C9j3WsevPzhajpDSA@mail.gmail.com>
X-Cookie: Is it clean in other dimensions?


--Fnf+u0jLkXcfkqNi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 04, 2024 at 12:15:33PM +0300, Andy Shevchenko wrote:

> The only difference AFAICS is the case 2.
> Do we need to patch regmap SPI for that?

> I think SPI just works since we don't really have devices that use
> less than 8 bits per register, and hence we never enter into such a

It's not a practical issue as far as I'm aware, I don't think anyone
actually uses weird padding like that but in principal I think so.

> case (while I2C is naturally using 7-bit addresses).

Realistically not, the 8th bit is a read/write bit.

--Fnf+u0jLkXcfkqNi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZe/3MACgkQJNaLcl1U
h9A33Qf9ENNfRB7AXqdWq5inPb9c9x6cDP9RMIRHx71D3xOIojDMw/NkPT3NywjF
p50ndtc0JYw+iznCrGw0BfuGQH3zKeV4aUG81Co9crm3pwg24otyuktJx4hQgTbz
v6MEdbs089XOxoKH2+p4UdDCEPaw1C7uMaXJs6lTUysHma2STRcdc9lLh+Zl/HPT
3e4A57BqC0K36i4syxHA4T1TAcWk+rmsJ57FZDRwfY9iKJhruOJQhik3MCirQGl3
Z35Li4z5n808z/waSz7o/IiRBmD2yly15uFIAJvKQ4Sm4Fn9+cckszScx3fzAF9v
8Ui8oE5cGJPhDNmsfwiADq3JYVpRaw==
=zAWg
-----END PGP SIGNATURE-----

--Fnf+u0jLkXcfkqNi--


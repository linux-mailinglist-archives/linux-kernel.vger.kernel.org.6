Return-Path: <linux-kernel+bounces-544949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF27A4E6B3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ACBF7AAC63
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF0C24EAA6;
	Tue,  4 Mar 2025 16:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXUVU/Lt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D78824BBF7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105495; cv=none; b=QQTi2+j3SblUM3fkw2WiVYPghGFpWgqbK9MaJ2G4/X6mDDW5bNFOoNGkL0t8Bg6Gm9wzXgcTc/rvUTCmzBSq6U5OEpz/m5Hu2ZwAcz22u2zInJYdJgKlqaQVxQkZbbYhMe8Qw55EUF5vflsZ0UZksKwAer2Avw8itJBEL2PgT58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105495; c=relaxed/simple;
	bh=ddesxlsbSXgBMtJSMmHJZnyUOzDZhT2en8jYRDdsisg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbRr+LCGRkQ83ssklf9WpwH+Ig1cBBZWVhcggFlluKtqBKG6/xgXZOp60VFaIb7BH5elaUgaqwvOtx/C6TimAQdxKq/tIUe4ojYseZSpI8nOmaq2SNZemWuy3SXOMv16mZwiWypSpTRWv7+9cz1kOtK9J2MwOY1HYh5ZwXJ/sAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXUVU/Lt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595C1C4CEE5;
	Tue,  4 Mar 2025 16:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741105494;
	bh=ddesxlsbSXgBMtJSMmHJZnyUOzDZhT2en8jYRDdsisg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eXUVU/LtL0ifzSTu+1wU7jJ3wUAuLEdIPojoDBfdvltHr9m0Fs/XsEPMQoLSu7hXb
	 2+LV34a/zA1hZxtKoNCdX4guYboXFoqgojyYj6vQIYpX1iJEyMogD8RT0Aqa3DOKRw
	 erYoThQu9ThxmjLQou6Bg4URNTS9Av/EexhKyLCDv6f8FWmsRDH6ZQagowgMKfjKJX
	 bI/WL7Q8UTO/I8rO7xSNwXmjfqEMWb8lPvXJ5VURcoqlWM8nSw7pzFF9sLp7Broi1X
	 uo8x/qlMBgJ2LkTGPzDacD0/9jd/ssEK2xywV3wAl80aOhZdnRRq8H3gvZ8zXI6b0l
	 6QRuwxUZqrkew==
Date: Tue, 4 Mar 2025 16:24:50 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Zxyan Zhu <zxyan20@163.com>, rafael@kernel.org, dakr@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] regmap: debugfs: Fix name collision without atomic
 operations
Message-ID: <1fb8c10b-6f80-4acd-8f32-f67d94583c5f@sirena.org.uk>
References: <20250304142452.3521828-1-zxyan20@163.com>
 <2025030437-copious-irrigate-1b63@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iieIFLKZtO6gUcdO"
Content-Disposition: inline
In-Reply-To: <2025030437-copious-irrigate-1b63@gregkh>
X-Cookie: Do not disturb.


--iieIFLKZtO6gUcdO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 04, 2025 at 05:23:02PM +0100, Greg KH wrote:
> On Tue, Mar 04, 2025 at 10:24:52PM +0800, Zxyan Zhu wrote:

> >  		name = map->debugfs_name;
> > -		dummy_index++;

> Shouldn't you just use an idr here if there is a race condition?
> There's a lock built into it that should solve all of these issues.

Yes, that's probably the easiest thing.

--iieIFLKZtO6gUcdO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfHKVEACgkQJNaLcl1U
h9D4kwf/WD4YKK5mYS07vpQRL+9BvECoPRvMoD8E3TILnhmpBSUUx6nueZHD9h3O
dxQ+T+CiT8fj9VIBMHPDSHPM1pX1kvPaOOJbOYGqPbS8p6lCIxWuzPTvYF10DvLJ
vCvuW0lBIuY858fd45l371AuKIvl0BQY/TQm3Efv/2k/Q0buHn5naGGi70XBhEjm
jrqltdF/vMGBQSLF1FezfG3UqQix9tRItCSPoIn70tsYMEpvtLcu1Z75VzYDsFZ7
IghdZ9n3jpnvTBhJ6cthv+syanMgbUI9p6WAJRxDzXji9egA3oEhjtCWplZ3JqMM
1qLdh2WCe4xx9PJxdElRNHbrJdPx6g==
=KCyi
-----END PGP SIGNATURE-----

--iieIFLKZtO6gUcdO--


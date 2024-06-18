Return-Path: <linux-kernel+bounces-220292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C9190DF24
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 00:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5F271C2393D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD71017E8FB;
	Tue, 18 Jun 2024 22:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="eJBEKMMx"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FD424B26
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 22:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718749702; cv=none; b=IbPj9UpHPNfb/Q+J7WxQGw0taHvu9x4mb3sUcwnBVBV23EmJk0PL8kOR6EP0s2TmHC0LF5VsRJTSINX8r27vAbBQmcJHuokEvHkfDvdGWiEfR2iPLCGbQ/1zBqSuzMKx+Jvj9bgfo3VHkygOL5YUrmJD/JvfZPjPvOekOaZ6Vo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718749702; c=relaxed/simple;
	bh=ggDnly1otFnyOYreB2zxQas4IHFank3hv5Y/uC5wT7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/n1+xuRsC6D/GSrmM9mRZIfqClt3Hihlh9z8tDZIGFqrQ1UOiqe4A3z1xluoion7aIB7WvaAE85G248kYnhBgiItLPziyeItJ7PkE8aq1/iSAtO/ni75XDpJguuuYYDODdlCwTYBPqCSF8cH6omww/2KVOOcRKHjrKRKm35ZwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=eJBEKMMx; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=ggDn
	ly1otFnyOYreB2zxQas4IHFank3hv5Y/uC5wT7k=; b=eJBEKMMxj9sKLBH4MQ83
	6PfvpW2v53HAxmlhju8GNYWh7C7S1j+JHfyj7zDT/YVdelhKHP6jyLlTf7anogiu
	TNHLyEFekNx6Qeh2BG1ORtutpLWrFcjg+PWlMxq2CZuAFjoCHIBErbuPqB21f3Lk
	6+sEIOKGHXrZx9p+G6dG32tIScrREOFdezM12/tgsGhQYyshCaxZseq/wtfwqjXo
	tOLSlphDSQ6u6nlNrKaTsBGqrGs6uJMkfo1NLWlvTTHLTJfI9inh4eVwGUwi7tRv
	XNCW5CBzRNS7kWmZF6WexME1MFIxbQaA6h/lbIwi+qCpA1ShrlLbEArxq0rXfrRe
	Vg==
Received: (qmail 362709 invoked from network); 19 Jun 2024 00:28:09 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 Jun 2024 00:28:09 +0200
X-UD-Smtp-Session: l3s3148p1@xf+omDEbrMZehh9j
Date: Wed, 19 Jun 2024 00:28:07 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, linux-kernel@vger.kernel.org, 
	=?utf-8?B?UmVuw6k=?= Rebe <rene@exactcode.de>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Armin Wolf <W_Armin@gmx.de>, Stephen Horvath <s.horvath@outlook.com.au>, 
	Sasha Kozachuk <skozachuk@google.com>, John Hamrick <johnham@google.com>, 
	Chris Sarra <chrissarra@google.com>, linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>
Subject: Re: [RFT PATCH v2 2/3] hwmon: (spd5118) Use spd5118 specific
 read/write operations
Message-ID: <omsjeb6zbkcdhh4a3urjdrdeyj2kczb734tbhxwdcvngzlm7pe@dzdphvmm6asq>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Guenter Roeck <linux@roeck-us.net>, Paul Menzel <pmenzel@molgen.mpg.de>, 
	linux-kernel@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Rebe <rene@exactcode.de>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, Armin Wolf <W_Armin@gmx.de>, 
	Stephen Horvath <s.horvath@outlook.com.au>, Sasha Kozachuk <skozachuk@google.com>, 
	John Hamrick <johnham@google.com>, Chris Sarra <chrissarra@google.com>, linux-hwmon@vger.kernel.org, 
	Jean Delvare <jdelvare@suse.com>
References: <20240618195348.1670547-1-linux@roeck-us.net>
 <20240618195348.1670547-3-linux@roeck-us.net>
 <a7f208df-4c9e-4fa2-9d17-80895db51182@molgen.mpg.de>
 <661def21-b0a9-49c1-937e-8526008f529c@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vz573t5jeo6foleo"
Content-Disposition: inline
In-Reply-To: <661def21-b0a9-49c1-937e-8526008f529c@roeck-us.net>


--vz573t5jeo6foleo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> to 86 degrees C. If that doesn't work, we'll be really out of luck
> with that controller (or at least I don't have an idea what else to try).

Try CCing Heiner Kallweit for ideas about the i801 controller.


--vz573t5jeo6foleo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmZyCfcACgkQFA3kzBSg
KbYc5xAAnuedpO5VQIb+3gt8m+/ub3XHXu28wphu0tuxy5c7TzoOGqEAvFwNbBXr
+WvcCy2xJnfoPYJX2R/PnstkT00nHVMXJto6tkil+85KnTGCCielWpkAvPvqI1cS
cIhDqbEarqWjDwe+Tawf8kjGsv2JXbujVfFYAt6E9x128t+y4kV/vd2EdaTulPwb
sA/EKfL+dT6TczWG/1+HZpl+WNHD9qFv4TxYn+I0JECLDKTvmYJh6FCmoW3VkRtX
eMvUrx/gbjwM3O6Wpqw/61L86xd+oocrQUqIonhwCkSj4dIzbAk+su/7HXrg6XsL
648n8OYm4i1BVM4T2sjXYVxQ0Wxceq7S+y7sftcvNbuv7PN12XLvaKbXJKykOCZO
XUC5maPa5amFDvtLB5aPMDlkmd1j4FL5BmZ7uyzFLATd46vBoM/VGm0GqJicHh43
O6zwqo6pq/gpPeatusixJb9ee5/dgtmADJdYgJRu9ETHX7Ht7k9rn6u4kpyNPjit
eAR/gAlpKlfEcCBLWWpmw6kAv955/LJtEQeVlVX/unCLv/QPcmXiS72wQgKGjyWB
4zxK1B7afSx5beHZh+wLb+fiM+KRmhVHQUoZ0bbAKudl3/vE1OHduFmwMlfNr8Sa
qVy0AhHcjSGv5ZOBe7hfcuXWTcVs/bhD6UT1j5gC2N8rCJHJoBE=
=KwHN
-----END PGP SIGNATURE-----

--vz573t5jeo6foleo--


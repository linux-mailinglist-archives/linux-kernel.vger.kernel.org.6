Return-Path: <linux-kernel+bounces-240473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50321926E25
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 05:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE4A31F22D5C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 03:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8199D1B7F7;
	Thu,  4 Jul 2024 03:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="c4a2YTFV"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E181DA32D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 03:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720064598; cv=none; b=A74rkGOruksI66xZdcjPlOt0tsnqoqqSveY9BHaEN5VPLhCi8y6J6TOW265i91qE6S4ZFENThmFvoPhh9q+9JQGf9+fYqscgQv/X4rBlIHIPvS+OB3Q8BhFwagHe1RvzXtOf+Ycdjis41bjI/ZUUINiySFdBhIXQ4eK8pnA9xkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720064598; c=relaxed/simple;
	bh=wwylZkOHxQEdXH7KyMeYbGoqWedrZgsd3Z1RJBOGcZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0SKkZJaVDAmoj2JAy2Ostdw/rW1F8ItD5mFhEefvNpFTo9PdbZ5JhqXzrtTr7vdK5GrxWyz2aL4G+1KMtpOfibxH+Xu9B1I13dLC+45HtnfRqaAZKbMcFWvOZZ+rcuvh1Xbf6LvowaVAFkMdn0vC0k9LU7Iqj83+0IKUStfUiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=c4a2YTFV; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=wwyl
	ZkOHxQEdXH7KyMeYbGoqWedrZgsd3Z1RJBOGcZo=; b=c4a2YTFVTMUiHr9dQzAa
	h4Ej+1wF/cuGWSocN72PKTi9xTwo8k/ZZshOOV5hwd4vDudDqi2quFliH4Trqpkj
	+OuWOhV4MZE4kE+EQZNChBWlVWX2bvk7W1wrGLtAB3oHj6bIRbk8hFe/GDrrajNf
	8atZ5JyEsttATlY0wssRmdAqHkHl8wTc11fhwsmqtcUuoHmSH+GhHq6FN4m+gF0/
	iVFHwXTKO+0HP1knyjDvEgQykLNqQaPNKEWhWSrMG3TruX8XJbMZVXKRMbIsCX5Y
	ck5CiDvnvtt97mQjSxcjOqmwLqystdh14x3BCRplnuzMo2SJ0v4ONk1qDfXy/5zN
	ZQ==
Received: (qmail 3007272 invoked from network); 4 Jul 2024 05:43:12 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Jul 2024 05:43:12 +0200
X-UD-Smtp-Session: l3s3148p1@z/0Iv2McdL8ujnsa
Date: Thu, 4 Jul 2024 05:43:12 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Michal Simek <michal.simek@amd.com>
Cc: marc.ferland@gmail.com, andi.shyti@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marc Ferland <marc.ferland@sonatest.com>
Subject: Re: [PATCH v2] i2c: xiic: improve error message when transfer fails
 to start
Message-ID: <ZoYaUPcOS1CRcKHC@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Michal Simek <michal.simek@amd.com>, marc.ferland@gmail.com,
	andi.shyti@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marc Ferland <marc.ferland@sonatest.com>
References: <20240513160324.3761564-1-marc.ferland@sonatest.com>
 <88d22b96-2754-40ba-a8d2-dcf4880446d6@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bJM1vjSOILLYzbSL"
Content-Disposition: inline
In-Reply-To: <88d22b96-2754-40ba-a8d2-dcf4880446d6@amd.com>


--bJM1vjSOILLYzbSL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Acked-by: Michal Simek <michal.simek@amd.com>

Andi, can we pick this up?


--bJM1vjSOILLYzbSL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmaGGkwACgkQFA3kzBSg
KbY49g//Vad0qwFYvSKmAjT8FQxyNyXsH8WCLYYWYs9yTVhjq83wkXnFlDY3QSzV
yb9v+QZlqegYxKyqQWQwExmlNi1VYLna3LaOgsPqlqtNHudutvYlX0ZlaNsieQQj
CgBB4OvxnJcoufJltzClxXKmpiB2onwGcZmUZr39h/Fw4Q/Cp1OGgyzUkIP6LqXO
iRdpxf/lpN7YvLDV9t03Y8VJko+sF9EdH8MRfZ672/60TEtDKmWma+L293hEGaOR
yfF4VsOy91PIk9F8AKKZ69tHlbppt37+SY74iNT+FF9Uyy6zSS9llnaxKpAOgUdJ
GmrcCpID+PgcNwUaU1f9/FKF+TVfu6ZR/WuQcJ3ICxh+CC6faeNF5TLbLgYM0TN0
eTOpaF8s5wocQfrGS+65nHPHBN+sYary77zFxG1IekgCRNo0E5QIn0PzCcc11F75
n8kCyb3C6ya29f7YU9lGtzMhVSwyZDOC63KnSoQbdSkXAc1237iFjkk6jR6MbW/N
xq5oV65HEyAg03TsN1t1zJjmtnNrypdgafKILyuKmCmjqQfdvSGfIWxWKXSqAV0G
PbFmsJEjHwLelUnRNvAx52GhWYsyXfkkC3tHEhFWFlDEgwMNYwtXXx32P8rciQV1
FrRXW+ehUVn4Kil+2LjVQEeq48fyT8G6XecsU9lXJ22BSu5E3cc=
=QXOk
-----END PGP SIGNATURE-----

--bJM1vjSOILLYzbSL--


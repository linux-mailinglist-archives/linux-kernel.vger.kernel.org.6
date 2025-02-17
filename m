Return-Path: <linux-kernel+bounces-517310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B25A37F3F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF6C01736F6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7699216E11;
	Mon, 17 Feb 2025 09:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="QePWrydq"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1675E217650
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 09:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786264; cv=none; b=pQEZgM75ClH1DsNzhqvoaSegebpChiwg/dJQ5zCroILevXvThVb/9nEJ/6vxl9lsClUXs3jc4n77lrxZhiWedOVa04l0v5EEH0QSDsQFk7XU9Zcez4Vj1nI2i+JAZFvsvinNJOnCUY5ePhjxiUqgdY00eddMg5zE410ORusyapA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786264; c=relaxed/simple;
	bh=3Wl6jNtwrSVCHakEqmjvcU8HEauXByB/TvM8qyD6KDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XgsFthn9anldRStlFHbCktTUt1kBhqCevDaiG6VWxXzMqolNqPWn81Iy/589R5ZZIzYuc8q5r2LYocCmD1CbrColASkP41wHcv3qTKrtqO/dhNieScr0O2TEDtS8pP7pIrjGxAOGB6Zfq+vJ/ZFnkQ+fQt83p0BkLqX2A3mJStY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=QePWrydq; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=3Wl6
	jNtwrSVCHakEqmjvcU8HEauXByB/TvM8qyD6KDQ=; b=QePWrydqSsp0C4NhNnOO
	Hi3/WYWY/EKpmM8Ga8FlHmycRxxvNPXVfTAhptI7UOWJIV4dWRAJykVX/5o46FNT
	hzAjrB3+/d+bfpIvgdd1T9vuN57tTPzv0OvsbgWSySbpQ9RjZniK/h2TOMfCVdsI
	jXJSuAjl5tD4Jo9SVhKnt+sLy2aPbbAelOreQY/tNj5b8UWvDiHm7kVKIvZ5/+xF
	sG8VI4BQnlGzKpQiAYQxUkRoX63U3TWz/CRVFPOYjlZIe7/95pjqMlW+tMuhtBrZ
	tdx0rljl5tSezx/e7dczppIBZkmN0DTQZAkWgrphGobR7uoYWsOIjJ4emdpOPz5R
	sA==
Received: (qmail 3242575 invoked from network); 17 Feb 2025 10:57:37 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Feb 2025 10:57:37 +0100
X-UD-Smtp-Session: l3s3148p1@oi3bjVMuwtkujnvP
Date: Mon, 17 Feb 2025 10:57:37 +0100
From: "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	"pgaj@cadence.com" <pgaj@cadence.com>,
	"miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
	"conor.culhane@silvaco.com" <conor.culhane@silvaco.com>,
	"aniketmaurya@google.com" <aniketmaurya@google.com>,
	"Shyam-sundar.S-k@amd.com" <Shyam-sundar.S-k@amd.com>,
	"jarkko.nikula@linux.intel.com" <jarkko.nikula@linux.intel.com>,
	"xiaopei01@kylinos.cn" <xiaopei01@kylinos.cn>,
	"Guruvendra.Punugupati@amd.com" <Guruvendra.Punugupati@amd.com>,
	"linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [PATCH v2 1/2] i3c: Remove the const qualifier from i2c_msg
 pointer in i2c_xfers API
Message-ID: <Z7MIEWbrK9bGUr4d@ninjato>
Mail-Followup-To: "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	"pgaj@cadence.com" <pgaj@cadence.com>,
	"miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
	"conor.culhane@silvaco.com" <conor.culhane@silvaco.com>,
	"aniketmaurya@google.com" <aniketmaurya@google.com>,
	"Shyam-sundar.S-k@amd.com" <Shyam-sundar.S-k@amd.com>,
	"jarkko.nikula@linux.intel.com" <jarkko.nikula@linux.intel.com>,
	"xiaopei01@kylinos.cn" <xiaopei01@kylinos.cn>,
	"Guruvendra.Punugupati@amd.com" <Guruvendra.Punugupati@amd.com>,
	"linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	BMC-SW <BMC-SW@aspeedtech.com>
References: <20250204091702.4014466-1-billy_tsai@aspeedtech.com>
 <f9f730b6-4620-49dd-9700-ee18f777045f@t-8ch.de>
 <OSQPR06MB725203E31EBAC2B71A7901E48BF42@OSQPR06MB7252.apcprd06.prod.outlook.com>
 <f05fb969-0632-48a6-afcd-c526c8568d4b@t-8ch.de>
 <2025020416561726c9efa0@mail.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7En295CQNKdStu7i"
Content-Disposition: inline
In-Reply-To: <2025020416561726c9efa0@mail.local>


--7En295CQNKdStu7i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I guess Wolfram will be the one have the preference, I'm fine using the
> existing API as-is.

Happy to take (tested) patches.


--7En295CQNKdStu7i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmezCBEACgkQFA3kzBSg
KbZVyA/+OGxQAvWCnRz6vlu52N3SURN0xynMNAZ+EdTwe0QrjDs4OVk+QQP90P/7
CkBut5jW38JF0AVuIXeE4Rwv8Vy2pQ1UNgG0hcmZxP/11urMQiQwGfiFBqYCPGuO
6uqe4nC+HmOb2k2aSLjX75VZ9skr4/illWkVmX52/exrtRWmrgdYnRjotR364ZsC
xlMQrWfYgDg14yMexjPRZJgputUpK4poeezw/NW+FhAzmqcFsi0U+bmcGaHbLvCE
QShc4LWX+0BCP9pC3e+GvEBHSp+ek7DH7zqkDVZuDmr+WYEh2eETUEfIY5GZv/Di
pUdXj0iODrM2Osq6zms29afTy+UQod926LBVHNp3C5wQEHb26ujgP4+Pr9/AegcC
BOVxAlivZAsOwd0iugQkJveq7bj8eelbwCTxp2Olbf4rm6ab8ZTrUkLzkKU4KBvv
4s1dPK89IGPCxaLmnfe5JCse3HnTyEy/mMO1OOlOKNnJelGsf5tbeF/SYHEyuPsc
Tk+2DmOYqfOLi3CaphyQx6tfjnJJYTitk2m8tlfX7FRpvKtbQC9iaOQeencbQ/fc
SZzgfi3dXOHJ9n2zLSIclXozO6niezvfnSlzUj3twr6XsiMNQ0wCLOE3rqCp+i1/
M2inE7EYxEJSISfO1Xz7IryARHqn85rvZjCmvh1TOMBDQHPSK9g=
=c+SX
-----END PGP SIGNATURE-----

--7En295CQNKdStu7i--


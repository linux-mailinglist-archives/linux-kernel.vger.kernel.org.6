Return-Path: <linux-kernel+bounces-410861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 228629CE97A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCE0228727A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7551D5145;
	Fri, 15 Nov 2024 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Co6tX4Ce"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC231D0DDF;
	Fri, 15 Nov 2024 15:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731683224; cv=none; b=kOrHRlZwZ//ilVLl4KwuoyXt5lOSlB18OdauxFdrQv3DyLnGZHy0/DaDz4G4asJXQAu+ypmKUE+pBfRkGIqAmyxm6zLvw+JMd4c3CfJThUEYivGCMVVcw9YizwqkP9LQMuGWAmuW4Utvg0eEqpsGn9Qs7vbA/MBhPm+aOm306Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731683224; c=relaxed/simple;
	bh=488LeDMT03GJrMxbHp32JdOvGZEH1XPQ5yO1aJUMtrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMzcEjcReWbInUhf957M2QUPVaWmTKT7sp5yuuB+4/RHt7iFtshTYwV1f6SQO9VDiTcgn2Z1MI93un/fImgz4m1TyoyH06yZNfyD0unjoYMJYsTbfMqmk2kkFND5cozoW9s8fyZ78Tm69HeXhl4BhAIDa1ojIlRBlpwi11BmnAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Co6tX4Ce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E5AC4CED2;
	Fri, 15 Nov 2024 15:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731683224;
	bh=488LeDMT03GJrMxbHp32JdOvGZEH1XPQ5yO1aJUMtrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Co6tX4Ce0VaVN457Y6xZQmCTc8t+xi/xAm+t+3InloQINTJh2BpB/nwZgf3oai06a
	 f02yy9DrXsJVjdJs+lDhPqAQGlqA0DvdCa3UquyRZBmNYIAy3SXtjG6oNpabz+RAY3
	 V/IRL6sP4LBMG6pop7ujpqTnoIX23FYhsceHWpFMYQ/R1oztbtFc9NtPLsBluf/a8r
	 MlBgjtKTbNUKIynZLJKvBlKF6yxoBnD53h4SdcxrBcOwAkDm/RNzudoosoqcKiM1Zn
	 rH8XL/yQL3ORJGnUTOfNgYMjyjlcttz1dD6JWaw3MtO9NuwFvF24656s3dLKtjw/ah
	 Z4Z1EsPp+B1VA==
Date: Fri, 15 Nov 2024 15:07:01 +0000
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	Mesih Kilinc <mesihkilinc@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v5 0/3] Add support for codec of F1C100s
Message-ID: <ZzdjlbelMywpXOAI@finisterre.sirena.org.uk>
References: <20241102125712.2647325-1-csokas.bence@prolan.hu>
 <594b2929-f7ab-4d30-a97c-1b1b31258d25@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ep0istO153xYfToL"
Content-Disposition: inline
In-Reply-To: <594b2929-f7ab-4d30-a97c-1b1b31258d25@prolan.hu>
X-Cookie: Editing is a rewording activity.


--Ep0istO153xYfToL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 02:10:18PM +0100, Cs=F3k=E1s Bence wrote:
> So, if there's no further remarks, can this be merged? The next window is
> coming up, and there's the DT addition still waiting in the pipe.

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

--Ep0istO153xYfToL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmc3Y5QACgkQJNaLcl1U
h9CPLgf/ZgHaaghsRbFT07zKYB2H+48YxD21K6sLJgxlXtbMMZxTghpDMVHRI19W
mt1JU3JUgIXEIyrAT9ya5WZlvPygJWxblECU0+Qqg/MXR19qGco9nQ/roMTS1xIE
GbkbECeHM1V21BdDIQt0Od3a0fwUBgrqV8IsJfpsV2FI51+1IeMmZ8RAeBCnoE2G
EjudHbRo4hmY7+J/deS3+eZxCK9eKYsmasrrfFXejlr0JqHEan1uPyLF8oqRdf5e
ZjEi97j4fAuladvktKKzAADVuVMa0+exvloFO1HUABgUgY7T9xkWAOzy5q/rOScJ
4gDyakjE2bFbI9NDZE65L6Q5FdGctQ==
=r8ND
-----END PGP SIGNATURE-----

--Ep0istO153xYfToL--


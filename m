Return-Path: <linux-kernel+bounces-385291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7509B351C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 093811C20365
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998A21DE3CB;
	Mon, 28 Oct 2024 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIU4DVl/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0061A1DDC13
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730129993; cv=none; b=r6KFHPWAGxscYOAoRK6SVcy204RZlFLaXoR71pTg9BA8/XsfK75ohpCx1W2uV1Qv1FW39IS2F3kj3AdswYhR0ShIC8fclZk0TWmBK1MqjvU/g3kPNVDZYDl1dFaRE41l8j+TltXB/C2ld4/zBU7O/DChMgOtYA1anKZjgJHPBfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730129993; c=relaxed/simple;
	bh=Fx4vDdViRJ8GcQyvhRhbci3FJE9Eix0UuCepUomfBko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OT2HgoySW4BanPFFoo6vbeXXZ6qC4z1SzvrtIa9cg4N97DdDNJ3aSkUmB7lKHXHe/fOrK16BG5moxxleAwj+s0KYaEQqAce6dZl/8e2AU6DCWVZ03wgzC+rk0rGrACBK8rbtA/HnKclLD1oCm4AU3nizmbE+1sMF32grCcoqMks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIU4DVl/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDF4C4CEC7;
	Mon, 28 Oct 2024 15:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730129992;
	bh=Fx4vDdViRJ8GcQyvhRhbci3FJE9Eix0UuCepUomfBko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MIU4DVl/ICbBONRfOJ78jWcnPlXWX85nIcNollz35p37CBnWr9WE2D9YFGUqwpy6T
	 AvMZkI8V/mOsMw7s3ICzEeTM7go3Wbb1xF4fflMPVLaR94dzQiXS9mSokovK150zzg
	 Dl+56JLPy1/2kkXed3l09MLTA0Ra5c+m1gyVO8m+ELozLlI304K04eSdUx42QlTzkt
	 cuuZxEqgUg1ezOWocpl4laFF4Afho3rBK4cGrMXZjZDRHZXa88FLFc2xa6kf0DoH3t
	 V6s/obpZt83YsWAihAQpvAWPl1LYvwI3ARFkaPn3EOCrj6rhO0Aii+53fPf+qEQMIE
	 aOHXQT3sJ6WSA==
Date: Mon, 28 Oct 2024 15:39:47 +0000
From: Mark Brown <broonie@kernel.org>
To: Mikhail Rudenko <mike.rudenko@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Liam Girdwood <lgirdwood@gmail.com>, Alex Bee <knaerzche@gmail.com>,
	Lee Jones <lee@kernel.org>, Quentin Schulz <foss+kernel@0leil.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	Chris Zhong <zyw@rock-chips.com>,
	Zhang Qing <zhangqing@rock-chips.com>
Subject: Re: [PATCH] regulator: rk808: Add apply_bit for BUCK3 on RK809
Message-ID: <a979db13-9ced-487a-ad35-47d6ea50ddf2@sirena.org.uk>
References: <20241017-rk809-dcdc3-v1-1-e3c3de92f39c@gmail.com>
 <87v7xcp7bh.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5gCpyIDO+BYmkXID"
Content-Disposition: inline
In-Reply-To: <87v7xcp7bh.fsf@gmail.com>
X-Cookie: Remember the... the... uhh.....


--5gCpyIDO+BYmkXID
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 06:20:55PM +0300, Mikhail Rudenko wrote:
> Gentle ping.

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

--5gCpyIDO+BYmkXID
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcfsEIACgkQJNaLcl1U
h9AP3gf/Uo6vVVZ6YhtYq18TjA/BmdNMf6/mLW1e27b4glU3DHiJ0/C8Yi0FIFgq
v0b2Xiczw/KjSc5T/xu/lz4epzO5vCnqOQ6zk+xzUyOkAg5OGcEEXnq7Ru75YJUL
+CZj+n8OzccZ+OBtwCSV4AJeValaUO06/ZSRdkY8Y62/fQphXNTJ0SpBBMEV1LJd
Nb2aL2R5gkQzxRdzEEtG/I8BZIh5XG9PtC+LgkqsoPBCZKderLmJ5huCkrnuBVUN
DZAF6s6jYDG+wjXYzdfdII4o3l44UDarGzcViWIYlZCeuhw+YPXNxNp0L8Z28bFs
ln4TlJl1jvXbqEciGDsDAjPI3RmpYA==
=29HX
-----END PGP SIGNATURE-----

--5gCpyIDO+BYmkXID--


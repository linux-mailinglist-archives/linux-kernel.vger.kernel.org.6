Return-Path: <linux-kernel+bounces-568360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4754A69460
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591283BEC66
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AD2156C69;
	Wed, 19 Mar 2025 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMLTALj6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3466B1D61A5;
	Wed, 19 Mar 2025 16:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742400498; cv=none; b=V8Id7wPy2LTSOi+snbgHLgfP98lE9rXYQUrvl4X3hJV1ry8GxDa8Uv/nefMH+tTToxT2FDSOww7320sZtXLSAWVbKOGjkjyqpUyS3gx23y+/BcjkiKpRfAHSE/i3ISUGFgqWmh7A44y4Q//VYvmVGMr2XHIgdXQ/BL+TxGY8edU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742400498; c=relaxed/simple;
	bh=N18/cuSuzMqhjYi0UDCHrV8LEMGzuWP3weeSt1EyLiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5zZ9xMphI5R1JpzKscMZSsTOQz4V6wr+Hpx3kn7TNzgbOVgJa5bQFA93Av7qXGfde81xxnqSCMPFyy5EYq6zD+3d7lNpmaXDBvDlvIEePhx2nGuWei5PqUlvaxSWhSOxXHRYsu2J9wmsbYruHKyYYeTVrtrdttW/a/TMAMCk0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMLTALj6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED237C4CEE9;
	Wed, 19 Mar 2025 16:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742400497;
	bh=N18/cuSuzMqhjYi0UDCHrV8LEMGzuWP3weeSt1EyLiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sMLTALj6s2xXN6cHNjbM8Sk1ewBMw8GSnna52/VE0W76F97tukdEksOl64fDqR40C
	 mZcAfRTt1sI2JLKh/ULFaC6Hb64UrZCf12SmiLX72cbCCMqY2GC29DEV/rfOsE7i2T
	 OI9fpFNkxNw58KXvEs077W1JcedH+a5BOLnHT3vvQt1sO1mB30zuy2X6ZflLf5l2AA
	 y6E6u0VXB5ZzjM11dqXBZG9q8wx4LC4laGOWw539bgHuvemPZ/ZAunFuSlL0FoYD2H
	 XM31egpIiriB3Bxo5vFhsyq3GFY5e1oUbQXzFWI2XpsCw66a773+I7hg5M8dJShx3l
	 uYuG8nlrX9RAw==
Date: Wed, 19 Mar 2025 16:08:13 +0000
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: lgirdwood@gmail.com, shenghao-ding@ti.com, kevin-lu@ti.com,
	baojun.xu@ti.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 13/15] ASoC: ops: Factor out common code from get
 callbacks
Message-ID: <51c074c0-3668-4bf4-8cd3-1711d091bdc9@sirena.org.uk>
References: <20250318171459.3203730-1-ckeepax@opensource.cirrus.com>
 <20250318171459.3203730-14-ckeepax@opensource.cirrus.com>
 <1d6d7537-1dcf-4bbe-a16b-902705efa860@sirena.org.uk>
 <Z9rrKd1PoZ0WEaa6@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Dtgn5d5paL6V35J3"
Content-Disposition: inline
In-Reply-To: <Z9rrKd1PoZ0WEaa6@opensource.cirrus.com>
X-Cookie: Chairman of the Bored.


--Dtgn5d5paL6V35J3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 19, 2025 at 04:04:57PM +0000, Charles Keepax wrote:

> Sorry those do get cleaned up in the next patch but will respin
> to move them into this patch, must have got muddled in the rebase
> at some point.

I've still got all the prior patches queued so only this and following
patches need a resend unless runtime testing turns something up.

--Dtgn5d5paL6V35J3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfa6+wACgkQJNaLcl1U
h9DHgAgAhhPP3+ibC6RWzAI6bzhW7cbVL5kJO8s6K4NhRQva4uVkuO7+HdDg2P/3
ogt4fziiHyR9aA+Dubr2+PkW1CPr8GA57XgaQ9jXcJbkMNE55TMHDIK+FtZUX80k
uOdfVj9+rtyr3IdIGKFkEQdnfcOQ8Z3CNwnUwn70X/5cKWyhcZlf7kwe53l5BmS/
4MsjOVJ7euGli32OTOXpwDkMJQfQFJGxK2kKL/sGIMpZDeDd7uQWFsc4b5yYqahd
7ZDor3lyTSNe/Pdu2MdJCJfkWy/xyd+rWutfxQXUgsZKHBb65P5S+6q/X75lvBGs
NjjVTd2NLO+qkx4MqTN4KqheIplbeQ==
=QI01
-----END PGP SIGNATURE-----

--Dtgn5d5paL6V35J3--


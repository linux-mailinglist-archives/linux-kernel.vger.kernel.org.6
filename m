Return-Path: <linux-kernel+bounces-390656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 513869B7CDC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F06C61F2237E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 14:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B862C1A0718;
	Thu, 31 Oct 2024 14:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2QsuzYb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E0219D07A
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 14:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730384991; cv=none; b=Wwaqb3llxWqycGrzM1vzbTz8UhkCTD5WX3U9G1cRaSApDvjLMB6ChPzYK5Ak8vg3+jFB/mlWF2WjvCJemWgGJK+eThfWkPd8K0gNtrPzpCrkEGnyQqNoQQXX3VZZLDrSzYH4VlfBbJoIK1Mvv2Qf5zDKmhlZzvmuBPnZkX+KHx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730384991; c=relaxed/simple;
	bh=LPKfUGyf1Rsh5zeNhU0UoGiA9NuM5MTlSpatdTPCOXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAT2FmQar11ccstRq1+w8CKRHlpwRfJqO6kSJGuRyEHlSnmnTgLKduF5/WZmVs7vaPTyj8cqUifAK9RnHCc4g5gwpYlPo63zQAh2tQCIi6E5qXI/3dmQkIYLwgzVO/v3CsBVGA9OnfofWJa4xE3hkuPG7abNITa7TZgF7uviiTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2QsuzYb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3FBC4CED3;
	Thu, 31 Oct 2024 14:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730384990;
	bh=LPKfUGyf1Rsh5zeNhU0UoGiA9NuM5MTlSpatdTPCOXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B2QsuzYbUzT7EmoAikiBWF2nlT9NRz8NjySM+6doVansy4faGCSFGi8WFMI0lD0wQ
	 +Rf1PsTTHgrPq9ttfw6wmOGvAtYwXEPo4RDziaY5OwH7Udk85pfiF5foZUB0dC5OaR
	 GLjUuNRR7POpJYj6349v0QOi3CGvYcs3LQxL5Ii7RtTrMFtl4L+GlRK+9kXtuWkiwk
	 O2LzolegRZYqC4jCKrTmr8P5Kfkq2XgtRxwTrAPFvDHJfGog9vWinwlx3FxS03Ax6h
	 IyAz8Q1qwFZ8QaeIGUUkifIBdWsbyAWxA8p09vvkMdKvdDe+a3mWZgHC/+bMbzZTpM
	 sTJCQAsZ/a9CA==
Date: Thu, 31 Oct 2024 14:29:46 +0000
From: Mark Brown <broonie@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>, kernel@collabora.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] regmap: maple: Provide lockdep (sub)class for maple
 tree's internal lock
Message-ID: <5e6291c5-06a6-490e-b4b0-18a6563d336f@sirena.org.uk>
References: <20241029-regmap-maple-lockdep-fix-v1-1-7589e57390bd@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t4k/L2yyjNYa4AkX"
Content-Disposition: inline
In-Reply-To: <20241029-regmap-maple-lockdep-fix-v1-1-7589e57390bd@collabora.com>
X-Cookie: Make a wish, it might come true.


--t4k/L2yyjNYa4AkX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 29, 2024 at 11:50:12PM +0200, Cristian Ciocaltea wrote:
> In some cases when using the maple tree register cache, the lockdep
> validator might complain about invalid deadlocks:

This doesn't apply against current code, please check and resend.

--t4k/L2yyjNYa4AkX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcjlFkACgkQJNaLcl1U
h9BBfAf8C7QlvqB6+H4p0p/bWs+K8p3OanOpC3PVo6fS1RtB2SvIOieHKZFa4iXl
p0O2dctjm4/mPzFg2biYiWPkfM5j40Ipo71pVQXR+kXWq3plf9AsKUJsJP8IuM6z
lgtVq+nWhL5ga5KV/Hkq/q7ngj8xo+tvDtyZQSE+YNhzKj8nTJlTbqjdbYmAXA7Q
upsgeQHcQOPRv2QCmLirYt3uiHy/jFuU/WJXINNLZB2fFH1e93QbZ/ksJqwxmk+e
/7t1obZs0wHVSABBo/IAmqnpZoTv1uP9PYc8/9VLlDl036dqzg8+LYFHWHhivaJd
rSvmqfXCCvfJhE7VKjYyGLuTghivtA==
=r/PW
-----END PGP SIGNATURE-----

--t4k/L2yyjNYa4AkX--


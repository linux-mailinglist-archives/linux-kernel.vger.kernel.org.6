Return-Path: <linux-kernel+bounces-194260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 229048D390C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B580B1F2424B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC35157E84;
	Wed, 29 May 2024 14:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAT4Mtv8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122ED157A7D;
	Wed, 29 May 2024 14:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716992593; cv=none; b=Bco76btzh/ZmuMgnCxFOBRzQa2ymIqf+PqaOQEh7X/WiGhzMvkBJlWotfZel1rmI//K7AbYrOqL4Ikojqj6WuW1B6OdeA3KUl5lDgW9yDWmBO6vZWxPw+Rb05QbtY3Kg8yR1cL9cgKaqV0ZoZeZHNrRpkrXclXK3I0vhQeEBsh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716992593; c=relaxed/simple;
	bh=bhCG4kplqmrZggYyow0NngpMzA6V+smGjmtFA4lsZrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iofI8FvuaiQ+KcBpGGYFbBMBmeoN8dS2+nkscXn3FuTRTrWKLvAvFriYnLWlOa7tLwVCDzQEqlBZQCocISI4XgkzW8p6sXAc25lmh+YhF2hKmKjU4b+3HyF+wqH6FreOzNJpYi8noK4JJodlj45t7xBZ1ccL2FwmBrm6PyhcHaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pAT4Mtv8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E66C113CC;
	Wed, 29 May 2024 14:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716992592;
	bh=bhCG4kplqmrZggYyow0NngpMzA6V+smGjmtFA4lsZrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pAT4Mtv8GPIvyCcYfK1Aalw8Cb/DS3AIFrZzn1djhuXr8tqy97h50w2f+Yi9ecorg
	 FHLDesY7g+kk782SCHj6dMYBMxFOMlRHYIs6PB/MXH66FKZOEQzyHni48Wjomaku4O
	 OAhyK9KBHbFleyVnYGWVfeKSatYucXF+PraPUSVaAtaQE1IzfZvkZ9rJjcQoXDCbiK
	 MmBwzNlyMtkpdfJN94S3XjI/sAzwKYRh+y6Y3YMWbVsWrW0AUsuQggO8Ebl0wq5r22
	 WsWbW5Yai37XptWeqB/wuNhNTlSipZF+eAH9b2Ap8Cv5veDihpfK6w+mkZOREx4FdC
	 ZuWwFwnIUyDCw==
Date: Wed, 29 May 2024 15:23:07 +0100
From: Mark Brown <broonie@kernel.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>,
	Marcus Cooper <codekipper@gmail.com>,
	=?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
	linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] ASoC: sunxi: sun4i-i2s: fix LRCLK polarity in i2s
 mode
Message-ID: <d02e981b-da33-45c4-9d9e-f47a890e0e79@sirena.org.uk>
References: <20240529140658.180966-2-matteomartelli3@gmail.com>
 <a003dac1-de47-4a15-8959-25f7d5f1c129@sirena.org.uk>
 <665739895996a_26e4f3704a@njaxe.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q0vjnQJ659h0qWMK"
Content-Disposition: inline
In-Reply-To: <665739895996a_26e4f3704a@njaxe.notmuch>
X-Cookie: Everybody gets free BORSCHT!


--Q0vjnQJ659h0qWMK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 29, 2024 at 04:19:53PM +0200, Matteo Martelli wrote:

> All right, sorry for that. Should I resend this patch without cover letter?

No.

--Q0vjnQJ659h0qWMK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZXOkoACgkQJNaLcl1U
h9AGhgf8Db0kv+/TVscfXv8n4MsdBaq44VCh1YU+cMMdVJoaaDIvm5/0mIXc1it7
kHp+1xm35g38cgoFTP8VTcHdeBpb7BNtSCDAkSodtnHrI/fUvxbjnbFue3EEAN2+
Ni+tJ3X/j2EuXIBuLdj6bacgJ5WajhmEHIeHjFudYSSJr9ZBM9mTS8pzVrbiqOkK
pXr+ckX+pgH55DZVyQaiREWUN+ajiRJdbZyOtzgxYntJQI4sI2KbjihclEJ+0BYj
Rq5DAvwlhGRevlPih81PsoB+Z88E5VYQExJrNpEQKaEc6xZshI1N8v/qwm0/OImM
wu7ZWqoof/PEuEx3TEGdjzzbRsIVIQ==
=CFCV
-----END PGP SIGNATURE-----

--Q0vjnQJ659h0qWMK--


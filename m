Return-Path: <linux-kernel+bounces-174645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9ED8C121A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 17:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF3041F21EC8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 15:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CC916F271;
	Thu,  9 May 2024 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZ7pCB7M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C463712FF9B
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 15:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715269222; cv=none; b=DpCPwCnIxsdYb8/wr+pGZH9iyIdI/j4U/QNM8pYXF7/aLBj0mc/upo/XW+1BNmNi4hTZnW1LEnuYM2bb8HXzeh1JWetnGUXAZDGrFM1n69Y++9BSjOQZmU2iCNTJNk0uKFSEwb2l3iZxrTwDh7NFpUD98Bl3x0o6dE+DfTzbYDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715269222; c=relaxed/simple;
	bh=d/ybe3IpNkTAWOs4xhYNPD9F46r7PFSGHYXWADXFcas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwzd2FPgt7B0pWfGB2vN7GRjdU79KJVkzGUvZkwB+uDYBRCsELeqTV3lK35CNW+IXgDTNSq4SboXV2z/RO4uNiPYjXVzaND/cMUCtqCiTtjczCHgM42zG13epinLWGUVhoAQqHPV0yRi6az0wv4XwsbekAJ4hA1ZNOSN0NIDsoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZ7pCB7M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30913C116B1;
	Thu,  9 May 2024 15:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715269222;
	bh=d/ybe3IpNkTAWOs4xhYNPD9F46r7PFSGHYXWADXFcas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IZ7pCB7MJRxGtre7ABZ/Q9fbR2ufnkpcjSqSjnZpCdEx5BLqhxXgJ5lYAUgjDUvKB
	 JvrAhfBsTdGwogqJ0tQH74r/DJWrZFg7nXHSMzapisMhwIh20baS7n1nVGQuoKFYOg
	 Kkh/MLhehDALMFE9ztyBzKgBx88W424+gCGFg7His7J4jrtgBXM1An/WzEGOxwKOeN
	 X9UN6dfIR0nW+z3aUI60o+QqlW0JEEHKYtsF8SLi7yPlsPy0iHvDrJ4YzkKGVq9Qwe
	 xGrvm7rbzE0RtKzA03wCzIrsE0uNTPhYkE4wwdNyuYnKaJsgb/CyhT0MG7mCxHCPDj
	 jiAmqJeI1iZqw==
Date: Thu, 9 May 2024 17:40:19 +0200
From: Mark Brown <broonie@kernel.org>
To: Alina Yu <alina_yu@richtek.com>
Cc: lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
	johnny_lai@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v2 2/4] regulator: rtq2208: Fix LDO to be compatible with
 both fixed and adjustable vout
Message-ID: <ZjzuY6RZ2ar7ZI_N@finisterre.sirena.org.uk>
References: <ffeecd61c194df1f7f049bd50cb2bbbad3cf1025.1714467553.git.alina_yu@richtek.com>
 <ZjGmmYWHu-ZQQdIh@finisterre.sirena.org.uk>
 <20240502073029.GA4055@linuxcarl2.richtek.com>
 <20240502092614.GA31518@linuxcarl2.richtek.com>
 <ZjRAsJHn57pZy5UH@finisterre.sirena.org.uk>
 <20240503073536.GA12846@linuxcarl2.richtek.com>
 <ZjjwFTtiopqsYdeJ@finisterre.sirena.org.uk>
 <20240508065402.GA7462@linuxcarl2.richtek.com>
 <ZjtnvjlJpfNn7qVT@finisterre.sirena.org.uk>
 <20240509091503.GA32333@linuxcarl2.richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+fqQWX3eMpPd7L1K"
Content-Disposition: inline
In-Reply-To: <20240509091503.GA32333@linuxcarl2.richtek.com>
X-Cookie: Sorry.  Nice try.


--+fqQWX3eMpPd7L1K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 09, 2024 at 05:15:03PM +0800, Alina Yu wrote:

> Or may I add the following condition to check the constraints.min_uV and constraints.max_uV match the specified fixed voltage ?

That seems like a reasonable check, though I think we should just do
that in the core any time we have a fixed voltage regulator rather than
doing it in a single driver.

--+fqQWX3eMpPd7L1K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmY87mIACgkQJNaLcl1U
h9AqEAf/WfHbAT/MjcZ7LKyk7l69eIAHw3dbFSMqRewUbDOfIekojilGzySkpjzT
m5AeTDsLb8QjjBATK+JVjYwqGn3OxLSfjnJ4LCSbGFH6A5ukRxcPLizXeLMa6ile
92j6QF85xOeNH9i+pr4+/9r2FZlD5acfDSsw+OuwKSIoyYufiN7H1Cq/YEfOoyDz
+WEWMAnjpUnkFq4lEKA39kOq9xrzkrLwi3zsew8Yh80bWuYmnU+DBDq3oaolapG3
16HB+++kqzefAzk8NmzBP4JPdzdSux38IN6unxUqNio9ishXQTR9HyhZ1XT/Z2oH
eN6WHYWOgqbyvM/5h9KboG+KuLt98A==
=xArT
-----END PGP SIGNATURE-----

--+fqQWX3eMpPd7L1K--


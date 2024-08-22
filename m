Return-Path: <linux-kernel+bounces-297976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD4795BFE6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 22:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFC7EB25350
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 20:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B6716F907;
	Thu, 22 Aug 2024 20:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWUKh0j4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB78D13AA2E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 20:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724359538; cv=none; b=jdw7I7faTiCDW13dRop26MflC5hoa0bjZlv3CkJKAzhArnSmzVNozafZ+pN3k9AAtzew+B9yXfq/TVSCKdkwWcPsj8Wwi6alN2A4wx6Xj/KX2SDFNG7S7t8Vi3tQUYEbfHJH36ssSZcH5HpTVtR0kuEj75HyPz3tQL5LQt3ugdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724359538; c=relaxed/simple;
	bh=XWJGcW0yVcEmLEupBHIYRHIv6dBL2UB76q3jGJxsu4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OhcIZzGGEDnlSpWcgxIKll1gWI0fUTQbx8GK8eFlUot+deNABP5tWq71W940Y6KKNRgDYfFKerJqj19nwqouABnCwKqThXnl1g4LR2AlhWjhPvTW7WOjFqdM16kHceemd8QHrxsRbv3tiXzaSwjJ1wgdEpTfRFC1UzbYf3JemQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWUKh0j4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10DFC32782;
	Thu, 22 Aug 2024 20:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724359538;
	bh=XWJGcW0yVcEmLEupBHIYRHIv6dBL2UB76q3jGJxsu4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HWUKh0j4Cnsa8UbbM0rYlW6UaYrDnlnMMy5ONE/G/1I8lZs6rqAJKAY7tGZGco2sn
	 Zsfn+vxVAbYQky8PrH5ItBXkW84tn9atEv7OIT7jB6RziMjk+J1rS1+ZfsEhkZbq5K
	 hhwdZVTah3kZnzUH9t6/QbR3C5HI184vmhXU9DPhLEaL2U+ofNy4PTX8n/5v3cT/mw
	 10bPorKmYobSnJbbikHHdHrvr1xozjGqkFBvNFIraF9YaMvJJKupLu39L8SbB4p5aw
	 Noy89LDpzhw6Cm2H/8heFfa6c+OPEwDtL0k0LOefHp+O40gxTKDiUIx2JuZYUP6s6u
	 qy24raiK6Ak8Q==
Date: Thu, 22 Aug 2024 21:45:35 +0100
From: Mark Brown <broonie@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	maple-tree@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] maple_tree: Allow external locks to be configured
 with their map
Message-ID: <ZsebVzVVzcA4QBhG@finisterre.sirena.org.uk>
References: <20240822-b4-regmap-maple-nolock-v1-0-d5e6dbae3396@kernel.org>
 <20240822-b4-regmap-maple-nolock-v1-1-d5e6dbae3396@kernel.org>
 <ZsePxD2FtYcBIaD5@casper.infradead.org>
 <ZseWKBCkxTrJfEot@finisterre.sirena.org.uk>
 <ZseXqP6q7qyFeiCO@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eY41iKqCdtWMhFlH"
Content-Disposition: inline
In-Reply-To: <ZseXqP6q7qyFeiCO@casper.infradead.org>
X-Cookie: Your love life will be... interesting.


--eY41iKqCdtWMhFlH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 22, 2024 at 08:55:20PM +0100, Matthew Wilcox wrote:
> On Thu, Aug 22, 2024 at 08:48:56PM +0100, Mark Brown wrote:

> > I mean, we do use the internal lock here since otherwise lockdep moans
> > but it's pure overhead which just complicates the code.  It's only ever

> When it's an uncontended spinlock, there's really no overhead.  I wish I'd
> been firmer on that point earlier and prohibited the external lock hack.

> The point is that the lock protects the tree.  If we are ever going to
> be able to defragment slabs (and I believe this is an ability that Linux
> must gain), we must be able to go from the object (the maple node) to
> a lock that will let us reallocate the node.  If there's some external
> lock that protects the tree, we can't possibly do that.

If the external lock guarantees that nothing can possibly be contending
access to the tree (including the read side) I don't see any issue
there?

--eY41iKqCdtWMhFlH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbHo2UACgkQJNaLcl1U
h9BYKQf/fju1QFL7eew4kcIkh7VOofjEAnrdmk+guHPAJJekLZH5oIqXpak7g+u+
9evsL/NIqhR6tZQ7iJSUBnJf2hyriOAmHDzyD0X+ficeQhHGB7d+8ASkq53bUmWz
PhVVxFYFJ5bk2DG9kpcHvOdh1wxEk8VHGv8EalkVapEbQuuYwH/ZnJ/x0GyuJ0EO
SoE7mcgjkrxDl6QpJDTOAIu5UWgjfa/R77LgcT7jCaOXmsn8LR6Kx8VTC/6z1TDz
61qmV+XcvHMSJ4O4hLm5fVFQkBP6fEPl7V8rVKmT5ebV8XmNyNg1NsjhbMYpjtki
GfONtM47Oz++f4QHafeNdUxjtV+GBg==
=ZFM8
-----END PGP SIGNATURE-----

--eY41iKqCdtWMhFlH--


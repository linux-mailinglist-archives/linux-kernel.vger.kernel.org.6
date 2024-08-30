Return-Path: <linux-kernel+bounces-308842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED479966284
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A32651F22355
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEFC1B1D45;
	Fri, 30 Aug 2024 13:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zn8V8fYE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28B21ACDFD
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 13:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023129; cv=none; b=MQYKoSvoEVw328xJZaMuWRr7kCmC/DqwFVZPQimXWjKserBBVRReV+EYU81SM6noGRbGSoV9//kkzUkiI9fdVggpw8u6NQaM1ds8X3VbFpxoXM1leejzSRAVosPZDdbUaxGfkuhfrB2SJiqu10C6qiLV2qp/GxPN2gdT23TYjB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023129; c=relaxed/simple;
	bh=13ZInjYWA/lVIMWe9FrRhEllqUoe/mlTZFl/UiXHhWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6PSQsYcLFWVG58ZBGa5mo/9h92At81tjF9Rlna3sjSk+aMIOpuME9mT6lEJNjgbnF9UvZfsB3HxAfJXtB7AmOHyhXQQiaJzPPArhn2nDQuuLD+W666Hg3brfoKh6Pd+UKLH533NE5e4Kpb5xsw6vVOEIfQu7tiB5eJyOd1WNWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zn8V8fYE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F3DC4CEC2;
	Fri, 30 Aug 2024 13:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725023128;
	bh=13ZInjYWA/lVIMWe9FrRhEllqUoe/mlTZFl/UiXHhWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zn8V8fYE5BLGVJ02kILIiiqn6XcQ9AeksSjm3giye3OoTA4k9deuTtzERqRK1cutS
	 aXuktZj+NN8vpYqwRqixamiPn6X/WaphAbx086xNDIU0cV8wJ7MfZAOxtUt2u/tsmM
	 1+l1wyn1CqLn0iX3ivnzbajhuzUa9QmtVoj+oUzGHAU6nsSqRXfAQoNbDVhdKx4fjh
	 WW6iNKHp87WgO7XJ2EFXjLWnhm7vVNRumEkovjrjOs63JpeLu0rNEchlM6GkSftUvP
	 0wwtxj6wDJs7reKddD/kcEEsWf6RiKlvjyj9Vw7MEJ/k8EwGd1EVabZAT6ox9DetbR
	 pugOef3PqaB7A==
Date: Fri, 30 Aug 2024 14:05:23 +0100
From: Mark Brown <broonie@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Aishwarya TCV <aishwarya.tcv@arm.com>, dev.jain@arm.com
Subject: Re: [PATCH v2 06/10] mm: avoid using vma_merge() for new VMAs
Message-ID: <9e3b42ca-ef40-4400-b4ed-3d082da82a0f@sirena.org.uk>
References: <cover.1724441678.git.lorenzo.stoakes@oracle.com>
 <57f55a1473586a88211e04b44c6b128332d4272c.1724441678.git.lorenzo.stoakes@oracle.com>
 <51452bab-65ef-4924-8ca8-61536d2bc168@sirena.org.uk>
 <9dcddc2c-482b-4e12-a409-eee8d902ba26@lucifer.local>
 <622b3769-fb5c-4a3e-82b7-1301623faf43@sirena.org.uk>
 <82718839-dacb-4774-a72d-99d9c2b134c8@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H4IlusNa3+d2EykC"
Content-Disposition: inline
In-Reply-To: <82718839-dacb-4774-a72d-99d9c2b134c8@lucifer.local>
X-Cookie: for ARTIFICIAL FLAVORING!!


--H4IlusNa3+d2EykC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 30, 2024 at 02:02:33PM +0100, Lorenzo Stoakes wrote:
> On Fri, Aug 30, 2024 at 01:59:37PM GMT, Mark Brown wrote:

> > Tested-by: Mark Brown <broonie@kernel.org>

> Thanks! I will be folding this into a respin soon, are you good with me
> adding this tag to the patch 6/10 in general? No worries if not, as fix
> will be subsumed there.

Sure.

--H4IlusNa3+d2EykC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbRw5IACgkQJNaLcl1U
h9AkEwf+NghTY2sWM7k+eA3WA4rfNZnXcTW5Knwbp8SsfL5lBn6oUjUheUTefGwM
aiiw3h+Y0pyTXE4wPoz722B3nogTEP2d3NJR3M/QDXmDvSV7Ndl/v4ON3wZi8jbF
6S5fS2ZvOHsAe7gdI/qGuHSdM8RngKcm1V4PkAnz3abZXqc+9joRxm5UEKRycilF
lo+EGK6y56FIMqOpiAM62X7oVVlGclHjkmNymdKfvZo6P6og5FMHCWUAXvsC+cPV
RA9eb+wsMyGp+3NCU47glykC1vA6PU5Q7Y52My1Tp68l8Md4VtiLlJNGeTqqI/+e
8mpDjeeW13lPw/kt7p54sA7vnCFuxQ==
=jB1/
-----END PGP SIGNATURE-----

--H4IlusNa3+d2EykC--


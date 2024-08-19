Return-Path: <linux-kernel+bounces-292521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA448957071
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB7E1B276E7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4090F177991;
	Mon, 19 Aug 2024 16:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIasNv4A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB86188CA6;
	Mon, 19 Aug 2024 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724085243; cv=none; b=t1l4Lf9FntXxz9A25VysC+0hxGnVVhm5ZUiUWXC/BL42DfGT9CbvILS/xP+clh8YKBN+cUv9ikrFXcARp1Bfeh3OmUTJ051S0FHUTAWtfajo1H6VQOwIKYUVwOkZk3SRuiPYfQZ5DzVrIRHPKySjuD93Cqhu/ILM+qJaoDJ6u7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724085243; c=relaxed/simple;
	bh=OpA0bFu4iJtsDTOjp51pA0FGakX8XWm8K0OLXNLj9ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYxPXz8K656L7nTIzgUAwb7NztJkQw0gUk9fvXOQYprx+bvnYqRaN00Vn4+f96EdN6L+mt+CasO8VAs7clLPHTsNPEquoDTYAJDaVPFvnNL3bVZKy1wBZchAVl3In5GzDihripihE84iVRe2F9ddkag6UPlTtF5izBUE45u1Zdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIasNv4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6C1C32782;
	Mon, 19 Aug 2024 16:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724085243;
	bh=OpA0bFu4iJtsDTOjp51pA0FGakX8XWm8K0OLXNLj9ik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XIasNv4AlouUSJ194eK4+OU0lPELs9UFLWyb7ofQUcsH56JfMV5pMKj7A3y0qM6/o
	 qu61VSm7+A+8wpaqIvwOAJI8YYFyQMrK8Dud89vx+xRlwBkJ4Pdn4Kf6vg1HUs1vtO
	 spACC3+NtZXIwxi8VIFh2t1cJQkSQYX05HBOCo0Rm/DpMs4AdRWCoDjyBMxAKMREnu
	 U4iYLRFahvq5f2Cy1rgfxfVkhV1wakh6MRxve5OhAwvTzb3TBHiJctVFbMPwBKsdUI
	 NLuUIMXQWJyg+BQcEmYZJcqWB2pWhweHHxkY4OUtnnfWHsypOXhA9Hh7vcpqQ+7eFh
	 ZMXlcxmLR8frA==
Date: Mon, 19 Aug 2024 17:33:57 +0100
From: Mark Brown <broonie@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Andre Przywara <andre.przywara@arm.com>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
	Chris Morgan <macroalpha82@gmail.com>,
	John Watts <contact@jookia.org>, Ryan Walklin <ryan@testtoast.com>,
	Philippe Simons <simons.philippe@gmail.com>
Subject: Re: [PATCH v3 0/3] regulator: Add AXP717 boost support
Message-ID: <bb15d8ec-060d-46c7-9446-86a483d05af4@sirena.org.uk>
References: <20240816001824.6028-1-andre.przywara@arm.com>
 <CAGb2v66LeA5gV-WTn3_Hyfx2o83_46Z5nBoLV12D4SLUmy0DLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+Nn/pGhbaqeE+VRq"
Content-Disposition: inline
In-Reply-To: <CAGb2v66LeA5gV-WTn3_Hyfx2o83_46Z5nBoLV12D4SLUmy0DLw@mail.gmail.com>
X-Cookie: Interchangeable parts won't.


--+Nn/pGhbaqeE+VRq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 20, 2024 at 12:31:02AM +0800, Chen-Yu Tsai wrote:

> Not sure which tree this is going through, but since Lee already gave
> acks, maybe we could have it all go through the regulator tree?

That's what I'm expecting given the acks.

--+Nn/pGhbaqeE+VRq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbDc/QACgkQJNaLcl1U
h9CGjQgAgJ4qmvHzn49tyTRUbU9m5Iq7+gsFn+Yt4++njHTN7abl/zLO9p/z3BhL
pZUbYOdzNwVmLxcoGkItnrH2a6nihNmlDWtRqbu3t4bmO5RqP5fnWPLngJBnu17r
5/u2ZnujGyht8PT0iNJDTEFpf0KXtneKY348AgXeUdBPCRJoYasZgT101Z9PqwsK
bIShhuowuZWaH7zZMFr/DaXmXpam0g+B/N8Hx4YkkuoW8zvgltPjMgAoArV7rGqc
23dvlChWu5D7MI6bvRF2zyq/mgUi8A7iZPxVxw5dUJp9m9fsIXLuRrpmkWnfwsBZ
lffWNBgBTTF3QkiGbmRnWzZVehgbKg==
=OxhH
-----END PGP SIGNATURE-----

--+Nn/pGhbaqeE+VRq--


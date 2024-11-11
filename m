Return-Path: <linux-kernel+bounces-404255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 823999C417D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46BED283495
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E551B95B;
	Mon, 11 Nov 2024 15:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVRaDlbh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EE41BC58
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 15:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731337648; cv=none; b=QIGZlWRfRKMS4L+XnPNN7ttJY2vre3Iin6AHboAynQRzB/xtlPEZ6zC3feeIZEeAvq24rR7hW1ILL98raP1A5JmrG03e1GRDTaqXnV0wHh74oP1x1GMxhcT1FWRnOOzF6iUCMO6ctpYPFZAVZ+yK6zbDQdCJv1z2N7J2KQIRXBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731337648; c=relaxed/simple;
	bh=EeQ1W77WnlhLgrZ8umVogm1aMhCQjYm/zHBcOXKxA80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4Z0iHzNQksLaW2BpiOHNX8GFVIrEi/ZFF9vdXZxssW324I7ZG1M9uWd9qjdd2Yn7gw7UxmSZYXl8oC26wB5aQRhR/L30Bek1zwPKE5RprGHdj8USfcLhp3JayOhZ3YHo111+BDcHIclL0OjorPnpWE6XA2wzsDNDvF/eCuFPYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVRaDlbh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96F9DC4CECF;
	Mon, 11 Nov 2024 15:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731337648;
	bh=EeQ1W77WnlhLgrZ8umVogm1aMhCQjYm/zHBcOXKxA80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hVRaDlbhsVKjtVfl34ePsC+PPF4r9JoQjFH47RcRNgvxU2tHudiagyjXObS9mXos0
	 O1ADP0P49hJZ3yw36ciNjrppXqRRiD6e5VpvVtr0rdi4QfECDA0pRSHuEhCe2HhnA7
	 uvcWOANKk2xHmCb6QPTnH7CYE/NdieIU2uodIM4hRSXNW+u+eqZHopVs8CYyn1rHBZ
	 3Ulgu8KKs/Qsvbc6lVPQQIGph9u4gMs/VVVedNjZQ4Mwja9DiRVVeymeOeHyMkSwR5
	 JGvPGMY1rT3vxvmif1k7PCMn6aVwilc2sBwVgv8B8IH1xQtEj2UwrlsVYXZa1mI252
	 7uRfnWhXVxcog==
Date: Mon, 11 Nov 2024 15:07:24 +0000
From: Mark Brown <broonie@kernel.org>
To: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
Cc: will@kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Refactor conditional logic
Message-ID: <ZzIdrLFldf_L3X_V@finisterre.sirena.org.uk>
References: <20241111142204.67751-1-hardevsinh.palaniya@siliconsignals.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jLaKpQKhPiD7qWCe"
Content-Disposition: inline
In-Reply-To: <20241111142204.67751-1-hardevsinh.palaniya@siliconsignals.io>
X-Cookie: Editing is a rewording activity.


--jLaKpQKhPiD7qWCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 11, 2024 at 07:51:45PM +0530, Hardevsinh Palaniya wrote:
> Unnecessarily checks ftr_ovr == tmp in an extra else if, which is not
> needed because that condition would already be true by default if the
> previous conditions are not satisfied.

> @@ -989,7 +989,7 @@ static void init_cpu_ftr_reg(u32 sys_reg, u64 new)
>  				/* Override was valid */
>  				ftr_new = tmp;
>  				str = "forced";
> -			} else if (ftr_ovr == tmp) {
> +			} else {
>  				/* Override was the safe value */
>  				str = "already set";
>  			}

Your changelog wasn't very clear on this but the tests in this if/else
tree are

			if (ftr_ovr != tmp) {
			} else if (ftr_new != tmp) {
			} else if (ftr_ovr == tmp) {
			}

so your analysis is accurate, the first and last tests are the inverse
of each other so onr must be true.  This should be clear from your
commit log.  Also all of those branches set "str" and we then
immediately test

			if (str)

before logging a diagnostic.  If we're looking to reduce unneeded tests
then either that one is redundant too or there's another bug in the
logic (I think from a quick scan just the former).

--jLaKpQKhPiD7qWCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcyHawACgkQJNaLcl1U
h9AIBwf/S4sIzyv0MYLeiGMOs74lTFYGTLaaUiWL+raT0oiKmEr6z1uHARM3BURo
CcYib2NgF0ggHoxTAYp9T4C2IslG7PRWkZQlqfd2rEpSXzp4NTqhA1FCDVDGw+/j
NFkg113XDJupC+/+ZVNVRzeP6zS5FtBN3V0NxYtJRQb5ibD31UOJtUS8Lfh+jl/b
JL42EpVAToZFhhjgbJ7odYRZflKg0fT1SwWwIb+fOhg9N3Aw+yPdVHm5v4wBAXq6
G/PLBGoi/Khw2CV1b2pHDHmTqzIY7EecoO0LMwdq1IlxrxuIymDHcGUVK64ovC/h
5YWVzNz7gaq29oZAoneZ3Wpb283iFg==
=oJTM
-----END PGP SIGNATURE-----

--jLaKpQKhPiD7qWCe--


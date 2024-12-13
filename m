Return-Path: <linux-kernel+bounces-445265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C39A99F1383
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E62A1682C8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB7D1E3DF2;
	Fri, 13 Dec 2024 17:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtdISbky"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2153364D6
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734110515; cv=none; b=kEwn4MGqfwOMdyl+vlVH2a0xDsFRS9Pp5JDRfjfK3YnTp9e/vvFNGi6LNjWqRuGqsRhqpVCzJbiYv3XJ14znnSEAUNCPTz6NyzORdhpRyfk2ox1iCImDq9tmToX2F5af6B44/uIlhYo3AbXJrD39avjizheaOTJH3ypMXicg52Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734110515; c=relaxed/simple;
	bh=XjbszIPs/n7b4p5KIBRoTwuiUU9LW0qDdu2zkchL+yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgWTjcmbP7/TFevqSia3AFv64RCbPO2q8exeByVd+4PljU8wy981XM13Gb4yGRzW8WZD0gGSkhl5WqbL5wKzKCaALB2mj+CQWxFu0RlMgF8PRISoKdRkGwfNWHVPhAtEgKOCxxDkoQj93mpeVSKw8UxDR9cKS/7bVuoQlhTiDHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtdISbky; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACFAC4CED0;
	Fri, 13 Dec 2024 17:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734110514;
	bh=XjbszIPs/n7b4p5KIBRoTwuiUU9LW0qDdu2zkchL+yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FtdISbkyY80zUrkwLQ5rsJjuw9Xlq/oJ9Hh4oqs0R6dhPRTUJfBWAp4xlKWYXDJrW
	 pXePzLW4nSAPbv2tY2QgYgOpFjTB79aRcfD+QswvDeQO3t9D6EZ1rw+WpgyNTRRYjr
	 wEmDz5G0itB5ZCIS2hcpQ0M9ECFHWISDBWuKLt34D4wfsEEwY1ilI8y/Sr7V+CKrLX
	 7M/pTfzuFSWwCFB6INOJKGIYjJdp7En4F2w4oJCtTwbd9yr1Go5+ag4FEABPnULCSJ
	 4hjgpqXwPZK2aRa9RD3368T0yFNzCOzH0e7pJAy6YCeGkz2tKk+ckIO/kFIjpLtWUj
	 hwyOm9Y/Nhg2Q==
Date: Fri, 13 Dec 2024 17:21:50 +0000
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] arm64/signal: Silence spurious sparse warning storing
 GCSPR_EL0
Message-ID: <e9259a94-652c-470b-8ad0-b6fd2dcdc0c8@sirena.org.uk>
References: <20241210-arm64-gcs-signal-sparse-v1-1-26888bcd6f89@kernel.org>
 <Z1hU0Ii-Sm9NHnhj@J2N7QTR9R3>
 <20c12aac-193e-43ae-9418-39db1af4ede9@sirena.org.uk>
 <Z1ht7X2LRw34pMJK@J2N7QTR9R3>
 <6d839dfb-0a85-44c5-90cc-2b2426353a5f@sirena.org.uk>
 <Z1xeLCKoSWyn2sko@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pLtlhyeX8UkM8kV/"
Content-Disposition: inline
In-Reply-To: <Z1xeLCKoSWyn2sko@arm.com>
X-Cookie: Not for human consumption.


--pLtlhyeX8UkM8kV/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 13, 2024 at 04:17:48PM +0000, Catalin Marinas wrote:
> On Tue, Dec 10, 2024 at 04:52:49PM +0000, Mark Brown wrote:

> > Yes, I had already removed the references to spurious and false positive
> > locally and changed the unsigned long cast to a __force u64 cast.

> I still have a slight preference for treating a sysreg value as an
> integer and cast it to pointer when needed rather than using __force.

I've now changed to that and will send it later - TBH I'm having a very
hard time seeing it as an improvement, especially with the update to
gcs_signal_entry() where we do two writes.

--pLtlhyeX8UkM8kV/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdcbS0ACgkQJNaLcl1U
h9CWxQf9FYCi81Mft1lRJXVju7GTWF/hR4f7L8c37sR6fd7AOWUKUEeSDIIyQsKm
6u0/kyAWr0oFbLH1Kd1PyB7SmYTsk/O5jOYbT/W6s15OWaFEYUBoAI3a/Ql/1aqR
4hecDva2rqQcCf4TijoLt7N7U+f2gFd/J44uxPEfmgtLQ+HlqiguQujnk3n/G+6P
JjYp6GYbOYbVNosVDxke1YhbOM0BgiV2dIJ8ML2RfMBYShnpesEQCU26rpmfk9PV
mygXhdjjSDz9UxytvgC7MRN+7X6Rk3U3S0VR1mWSlUxNNm4d+jwsDfTR3U8sGYu+
ti9p9BaHpU5qPMkln/0dW9BcZdh9GA==
=Tu/G
-----END PGP SIGNATURE-----

--pLtlhyeX8UkM8kV/--


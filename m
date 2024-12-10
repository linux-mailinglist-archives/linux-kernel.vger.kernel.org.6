Return-Path: <linux-kernel+bounces-439875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEE49EB54C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03DEB284B6D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508F3207DF9;
	Tue, 10 Dec 2024 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbeFBcL2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE30F205513
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 15:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733845474; cv=none; b=tBsyH46l8w3o7xhxJYoRGlbMzQM+6yAceHsehqsp/E4RXACZuGRwup7XyQbJ4IyLvD5aIy0J3nN7kje+I87+M6SFEYXGKYcFbxlPdsJLLdXf5dr9NHjvXj00B+rWQC28smZEjJECJEF6gsHhNfnG4unAWMIiM7deJhizlQCm6EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733845474; c=relaxed/simple;
	bh=QnOwJAo3qEIG/EbKUjinI5a+rADGWNu6gqAoQZuMGaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gg+WGHxpcvUhIIL3UgiPCj6fk4yPqu6+IXPUQvnb4hFDFlf3fi0r49j7Baq6nYipt7aAF+A3R/Ea6KNKPTk1dW6O71UjCrFxeDhBAa4Teg3oYiPg+DaAYtjB9cfIO/xyk1VFdBgf1i/pbSBASOyegt75BYQ4TpHtwa+aaWrRyu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbeFBcL2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73B8C4CEDF;
	Tue, 10 Dec 2024 15:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733845474;
	bh=QnOwJAo3qEIG/EbKUjinI5a+rADGWNu6gqAoQZuMGaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XbeFBcL2tSMPjXMptCmCaVOB45UyG/n/NNJfg9GgcAblNy6z3IZ1i4AAcF9jFw4oT
	 7LsYFW8RRzMX0sIATSoGaXFXOukkvT8+0jCmmLNUzaGC7o+y1UF3Ec/oBVnnuEdzeJ
	 1oGu9E8HvqOVzIWWVJtQFpYd36m/S7Ug9g1aR+J2ZOyGQKRvsmyFIvxyQkzhQtk2vX
	 ErJXZV+XXBRzX6NHFfiMPBj0M0ESe7Df0zZ0C++jArW8RIZH6RALH9o3I/qBK6bD3r
	 bRhlJ5IIt/uTUNRTXCrTyZ1ndSgF5nj94uHUDAkFaLcL1a4crOJHU+ZugniJ4JnzR4
	 bSvUuAxJ1vTkg==
Date: Tue, 10 Dec 2024 15:44:29 +0000
From: Mark Brown <broonie@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] arm64/signal: Silence spurious sparse warning storing
 GCSPR_EL0
Message-ID: <20c12aac-193e-43ae-9418-39db1af4ede9@sirena.org.uk>
References: <20241210-arm64-gcs-signal-sparse-v1-1-26888bcd6f89@kernel.org>
 <Z1hU0Ii-Sm9NHnhj@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x8GGSUOpIkUcP8JD"
Content-Disposition: inline
In-Reply-To: <Z1hU0Ii-Sm9NHnhj@J2N7QTR9R3>
X-Cookie: Leave no stone unturned.


--x8GGSUOpIkUcP8JD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 02:48:48PM +0000, Mark Rutland wrote:
> On Tue, Dec 10, 2024 at 12:42:53AM +0000, Mark Brown wrote:
> > We are seeing a false postive sparse warning in gcs_restore_signal()
> >=20
> > arch/arm64/kernel/signal.c:1054:9: sparse: sparse: cast removes address=
 space '__user' of expression

> This isn't a false positive; this is a cross-address space cast that
> sparse is accurately warning about. That might be *benign*, but the tool
> is doing exactly what it is supposed to.

The spuriousness is arguable, from my point of view it's spurious in
that we don't have the type of the system register we're writing to.

> > +	write_sysreg_s((unsigned long)(gcspr_el0 + 1), SYS_GCSPR_EL0);

> Only one line here wants a __user pointer, so wouldn't it be simpler to
> pass 'gcspr_el0' as an integer type, and cast it at the point it's used
> as an actual pointer, rather than the other way around?

> Then you could also simplify gcs_restore_signal(), etc.

I find it both safer and clearer to keep values which are userspace
pointers as userspace pointers rather than working with them as
integers, using integers just sets off alarm bells. =20

> Similarly in map_shadow_stack(), it'd be simpler to treat cap_ptr as an
> integer type.

With map_shadow_stack() it's a bit of an issue with letting users
specify a size but yeah, we could do better there.

--x8GGSUOpIkUcP8JD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdYYd0ACgkQJNaLcl1U
h9BJngf9EZ+7dJoTevRJcuZEVo+biv2jW0Dp3rEnaTFnZbcN3AmR7R4gFeuEdJIi
v2uoHPbHGqXQIjDpu52mNwGUFhzjUCb0TOyA1hxr1WEGdZIQ8hHbQv1FanC6G97T
MAb6MgA8xdc3KHhNO3RYYWHFkOBApX4FV/X8JLSfFWVuGkG1zSBbBK8lEIJZfQkH
bWrtDnX+7ySd9zUrKIq3BfInOwHwCH1EKcVd3Mi2pQL7AO1AJfKWSUVo1tiE+QoV
6YKXoMahnnkF0Af+fARiCpOXi4+5vg4kj6pBh48M2etz+AkTe0PsmaqBAbBgcXxm
JauRjQeO7p+2jj5Gu/3cd/aOQw3ozw==
=FjKv
-----END PGP SIGNATURE-----

--x8GGSUOpIkUcP8JD--


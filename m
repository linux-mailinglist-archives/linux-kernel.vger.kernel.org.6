Return-Path: <linux-kernel+bounces-213452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EECAC907586
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7462028171D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E180145FFA;
	Thu, 13 Jun 2024 14:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r976s8pP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73D2399
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 14:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718289870; cv=none; b=jOqEZxsgXZwN9IUIn9SCnExpEqqAkL+f54PL4gZPczdCVcRMsYGGJxlShUacBlSaD4mHY4Oux2KTcYj7alVIU2F4ASoaJ7+S+0lPZKT6hN2+soyHGcUXg3vCyIiFH+HcuW9G48c418qsTFAygqqdsQIKbs+kJYs17z2uGeaTeKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718289870; c=relaxed/simple;
	bh=yWSohq+9rzlktRl57vGSLSRf01m1OZRSVju2Mkb1OEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F727jwC+9JQgRJQPuWvHZ1WhSVzly0OgI1EAzpxU6lRfaU9D2E0MjaDoW5sd3sA1yqXiZrvtk95v+g1i3rtptKtfdA/F3rrbyj8cBlNUfOmfeo8I0nDm7r5wYWdR5nbXrEz7UvBI2C60VFwhWFWBg+nD8w6rY+IIM6ZB4+/yw7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r976s8pP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A282C32786;
	Thu, 13 Jun 2024 14:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718289870;
	bh=yWSohq+9rzlktRl57vGSLSRf01m1OZRSVju2Mkb1OEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r976s8pP9rjrr7ALu3lQ5TJkega+RsnW2+KqzXAeqDnaHB4R69lsHN3XC4Xq1nwhf
	 MotP/XQVdSzxRtALOPdnvavj7wHt/z2r5q29SFY+80QMmhziwH+UUZmLHxf/fejIy/
	 BDcnBAGgwIii1kns9zAxsMdcyFofik0Y+ZfunmRb9EyNybwoSEVYeUtAOTZZ89JHpn
	 PTOz6PSpQlsabiTx/xYD7vPIUYbTQsn3+aFNmKACNaZbqRwvGES0Ujkwd2kmjMQktn
	 DjEhgvs/S2ZV46YLsMFaAjkQaDqOoASlFj9BvQjgeTd8nXEpMFlvc2f+bomhgM2cLe
	 VL+Ffx0QlqWng==
Date: Thu, 13 Jun 2024 15:44:26 +0100
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor.dooley@microchip.com>,
	Evan Green <evan@rivosinc.com>, Andy Chiu <andy.chiu@sifive.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] riscv: Extend cpufeature.c to detect vendor
 extensions
Message-ID: <20240613-award-dubiously-49252229b020@spud>
References: <20240609-support_vendor_extensions-v2-0-9a43f1fdcbb9@rivosinc.com>
 <20240609-support_vendor_extensions-v2-1-9a43f1fdcbb9@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m/3ptYUdWpWGnqQv"
Content-Disposition: inline
In-Reply-To: <20240609-support_vendor_extensions-v2-1-9a43f1fdcbb9@rivosinc.com>


--m/3ptYUdWpWGnqQv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 09, 2024 at 09:34:14PM -0700, Charlie Jenkins wrote:
> Instead of grouping all vendor extensions into the same riscv_isa_ext
> that standard instructions use, create a struct
> "riscv_isa_vendor_ext_data_list" that allows each vendor to maintain
> their vendor extensions independently of the standard extensions.
> xandespmu is currently the only vendor extension so that is the only
> extension that is affected by this change.
>=20
> An additional benefit of this is that the extensions of each vendor can
> be conditionally enabled. A config RISCV_ISA_VENDOR_EXT_ANDES has been
> added to allow for that.
>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--m/3ptYUdWpWGnqQv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmsFygAKCRB4tDGHoIJi
0h5fAQDeYsSVtPQVBHXjvECQRibHazGog0hdC8ToeSy3Svxj+QEA+ANOFwkbAuZq
Nz2CAa9yaR4rlEda/iWTRhGgXvTvKgQ=
=NpFb
-----END PGP SIGNATURE-----

--m/3ptYUdWpWGnqQv--


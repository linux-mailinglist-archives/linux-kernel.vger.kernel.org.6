Return-Path: <linux-kernel+bounces-181295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 430C88C7A17
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 18:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8651F244DF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA6F14D710;
	Thu, 16 May 2024 16:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ba/wtGx2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B356A143874
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 16:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715875757; cv=none; b=qwwLkezkuaSdzs/AtyyrdU7ATL2OqOa/A4gyNkTxihbXzSz9zZCwvfJY61+4IaSY7BbsssmOi0DpSUGGQtnn1wXZ4hwhTaSbUhNIQBaCwZm88EJb6lt5SdZhZMrk93Mh18ivZn/JXZ3hxROI4yTveXzie+Q5yFJHb/Ic+ukKP1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715875757; c=relaxed/simple;
	bh=BuB1lBuPqSHeYAZRlNth4Ne+6BiznLgjo9Q2PlJemPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9tZ9tS7BIqS40aNj891IvgRkUhtUHFJgF+kIHMtz9TRiqwsAwIFBVnxS3Gtne2gEcMam0i2cUTe6T15mV5oVcaC28JSQwf+F2flEGsbaZAozfE+RJDxJ9PwXTk0hZ+k2J9kJOY9bVnHpKPIDjJpvJkGiskqfmO5FxPuMw83PI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ba/wtGx2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93BAAC113CC;
	Thu, 16 May 2024 16:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715875757;
	bh=BuB1lBuPqSHeYAZRlNth4Ne+6BiznLgjo9Q2PlJemPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ba/wtGx2vX3cqrPfKBAa+K8BYIBEfPXL8ABcCbOyBeoqITFyr9fmyoJQg9NMi0f9O
	 dOg9y0QrpMX/Dnos2RNeS/Tr/vUB6A5YjCP4l7On3vJPyGNRxmtIU9HxvzUAAUoSc0
	 OFxe37TAV2TjTQJUpl8uR2juQaJ0Dl7NDkj6iwb60KK33hByDxDzNJyF3Vlbuhyabk
	 I/rEy/Df6VMutIvLPlQJT5tkcqvCaVAbqBP7np5noNraJVIiDt9zb5AEkRLLGMXHVD
	 2ZU5xKaNpHk0+CUk88bjgNUn0S6gPpq/Oe/Ob/seUmaEiYEVrH11Zb/t41wwx2MCHK
	 Iwb6GrPT4jkfg==
Date: Thu, 16 May 2024 17:09:13 +0100
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor.dooley@microchip.com>,
	Evan Green <evan@rivosinc.com>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] riscv: Extend cpufeature.c to detect vendor
 extensions
Message-ID: <20240516-undergo-bruising-00b2dda7fdb5@spud>
References: <20240515-support_vendor_extensions-v1-0-b05dd5ea7d8d@rivosinc.com>
 <20240515-support_vendor_extensions-v1-1-b05dd5ea7d8d@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IrlPhg3iJOawMNuM"
Content-Disposition: inline
In-Reply-To: <20240515-support_vendor_extensions-v1-1-b05dd5ea7d8d@rivosinc.com>


--IrlPhg3iJOawMNuM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 02:26:13PM -0700, Charlie Jenkins wrote:
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

Cheers,
Conor.

--IrlPhg3iJOawMNuM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkYvqQAKCRB4tDGHoIJi
0vPmAQCjYL7DFqx7XDKaJSfCyQ8gk+EFN+XsJQlo7vj1Euw1gQEAjxLQCPf6hokg
WsJvsba6+KjbLP00vCozW0FMGxUkpAw=
=hoDt
-----END PGP SIGNATURE-----

--IrlPhg3iJOawMNuM--


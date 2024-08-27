Return-Path: <linux-kernel+bounces-302879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79413960497
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 241921F23D4E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF35E19923A;
	Tue, 27 Aug 2024 08:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1bN+dca"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EE3198A11
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 08:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724747886; cv=none; b=qi/7lsbJbrxeY2RwXGqzpPqiloWzKwmM9sJp7d0qOIFVstM+yyRPwJY5Vij3HtkSEp2XpwVYfsiiS36O5nQ1OIoayJKDY46RbCeVaxqNYb2qA4H7H4NxtBqA/ejgHGZW0aTJQJcL1vyKZdUlepzewQzWzpy+9cminKGoJcUE4Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724747886; c=relaxed/simple;
	bh=3nRrCcNh+WKk3hvq0XOgP1afEtOult9YOcUxytPerZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcdNe2wzJwBsaPVn/KNxu1pVAdAJb4PeUY0rFFe+2F7UjeN8tz4fcLO9F4Z2RMeynFrtGlD1rclLvkMc/c3pru53P7LmYqA5uFwR7vzsweomI6b+EnJPcpjDB809DTB3516fv8xZi4ODtnx0JQWlLdcSHLuAqkh9TEw3Tc2AQnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1bN+dca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB228C8B7B1;
	Tue, 27 Aug 2024 08:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724747885;
	bh=3nRrCcNh+WKk3hvq0XOgP1afEtOult9YOcUxytPerZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d1bN+dcawacxtmJn73wXDUWD3ZDFeOKXp8i2MOAZZeL7vLJ/cH951XwPUOmY0feve
	 5s936d3tdjJpgIwBrpMlVIXtMpKSJ2ZwcFBNppxhYBscyq0pp1ikZH7fpjh1nklkkO
	 Kx8cMYDcR1xEk/Py0qhyaOnXzEUSpn7dVpQ8haJrzo/014Wd4Pr/pyb5ljZySgiuyP
	 XgXdKDHQBnNeM9CjuK6xlmfTSlTVK0mLtBy8KjdBx24pb/F/C1uGgWWayxxcJOPE3U
	 Ypd9hynZDRIVaxM1RNXz8zv89U/CPqkP2G/wvdYyS8BuMd5RlftO842zXH3U9Tejc1
	 nuJXr8Xj4x8AQ==
Date: Tue, 27 Aug 2024 09:38:01 +0100
From: Conor Dooley <conor@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Tomsich <philipp.tomsich@vrull.eu>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -fixes] riscv: Fix RISCV_ALTERNATIVE_EARLY
Message-ID: <20240827-striving-dispute-19b6cf97139b@spud>
References: <20240826105737.106879-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WUoEQbA1AuWx5rCS"
Content-Disposition: inline
In-Reply-To: <20240826105737.106879-1-alexghiti@rivosinc.com>


--WUoEQbA1AuWx5rCS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 12:57:37PM +0200, Alexandre Ghiti wrote:
> RISCV_ALTERNATIVE_EARLY will issue sbi_ecall() very early in the boot
> process, before the first memory mapping is setup so we can't have any
> instrumentation happening here.
>=20
> In addition, when the kernel is relocatable, we must also not issue any
> relocation this early since they would have been patched virtually only.
>=20
> So, instead of disabling instrumentation for the whole kernel/sbi.c file
> and compiling it with -fno-pie, simply move __sbi_ecall() and
> __sbi_base_ecall() into their own file where this is fixed.

IOW, this should fix the issue that we discussed here
https://lore.kernel.org/linux-riscv/abec162e-f3f2-488c-83d9-be17257a5df8@gh=
iti.fr/
also?
I'm sorry I didn't get to test that yet, we had some pretty bad IT
issues in the office the last weeks and I have been avoiding going
there. I'll try to test this one instead..

--WUoEQbA1AuWx5rCS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZs2QaQAKCRB4tDGHoIJi
0s4HAP9R7DRRgtrxWKs/ooG2L716azXsarufF81XC3XFVzH61wD/WgnopbRqbSZM
rAkoD48sOPA15UGrJsrtmq7Aslc1SA4=
=gQhL
-----END PGP SIGNATURE-----

--WUoEQbA1AuWx5rCS--


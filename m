Return-Path: <linux-kernel+bounces-403445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA699C35D1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 02:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801181C20AE4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 01:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDBEA939;
	Mon, 11 Nov 2024 01:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="jn9mWKx/"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0BFE545
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 01:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731287502; cv=none; b=lyKot0nVglAfeOU5hppykqNsLaDWM0+/dFKpDEXJvhwrZvGJzSMt/qxWG+pVujHXHeF5ZPXZmdjl0keWtQcPW0iSnaUill6NJTGW1QxgWvTKXi6gaK1OQ7UPvqOMV6tbzqZhPmgSkaX/g6nf64UhDcxJPS0SyoAERpmfSkqbn9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731287502; c=relaxed/simple;
	bh=JkNcqT55Dgd99dlNbNCn+AP/EmL/69mSsCMzWH3IB2E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=THSfH7XNxncnOyO7DKrSgFBKd94p87PNcpYPWm0lILAyR3yojMbodbmDdDdhD3Q3jEbyy7ZBmhs50q4dL9sSY0bDCaOWzgpRgPpiEA/gh1jWEZZvdxx2qWguSO2jyXJI37t3TTjdL/X/S3O4s33iR0i2BohH+3QFeqCdcVpv0pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=jn9mWKx/; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731287494;
	bh=a/0zm3MDXQoyiuSwhNM/q97OKgNwCzM8MCZdUyeHH08=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=jn9mWKx/RaTVuSdEMIkaaWGe9emYy+XspqqHekK+sCMMnM03JnUzsntVfbwWHtwfO
	 qLo8Z2lVxHK1/lbYloNJbGivOkEXjbZzkqyzRe8+LHnvHue+8Cw8h4TGSYR1JTDoq3
	 /bwv1kZxoD3yqn+rpNu24wHHaaVhkL1A5JQS7NaiosVQPGczm1iVq48cu/Af259JO3
	 NTLd0jqiC8p0G3oN3qm7J96seZqrg9iJytCvZoB7MTLgFmVt1b+3FkKhbUGHJH9WZc
	 vN1UDursvGoBG86QK7J5onghYVgiF9vAint+hpltfOsXxBaTvNmBflgJRc8QpWvX19
	 NSOklzYy7VFfg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xms2G0fFRz4wbr;
	Mon, 11 Nov 2024 12:11:33 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thorsten Blum <thorsten.blum@linux.dev>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Thorsten Blum <thorsten.blum@linux.dev>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Transliterate author name and remove FIXME
In-Reply-To: <20241110162139.5179-2-thorsten.blum@linux.dev>
References: <20241110162139.5179-2-thorsten.blum@linux.dev>
Date: Mon, 11 Nov 2024 12:11:34 +1100
Message-ID: <87v7wuy3p5.fsf@mpe.ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thorsten Blum <thorsten.blum@linux.dev> writes:
> The name is Mimi Phuong-Thao Vo.
=20
Is that the correct spelling?

The github commit below suggests it's Mimi Ph=C3=BB=C3=B4ng-Th=C3=A5o V=C3=
=B5.

And presumably the author preferred that spelling, otherwise they would
have just written it in ASCII in the first place.

https://github.com/bminor/binutils-gdb/commit/6603bf38d74409906b3814f6a26c0=
483a5d32e41

cheers

> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/powerpc/boot/rs6000.h | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/boot/rs6000.h b/arch/powerpc/boot/rs6000.h
> index a9d879155ef9..16df8f3c43f1 100644
> --- a/arch/powerpc/boot/rs6000.h
> +++ b/arch/powerpc/boot/rs6000.h
> @@ -1,11 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /* IBM RS/6000 "XCOFF" file definitions for BFD.
>     Copyright (C) 1990, 1991 Free Software Foundation, Inc.
> -   FIXME: Can someone provide a transliteration of this name into ASCII?
> -   Using the following chars caused a compiler warning on HIUX (so I rep=
laced
> -   them with octal escapes), and isn't useful without an understanding o=
f what
> -   character set it is.
> -   Written by Mimi Ph\373\364ng-Th\345o V\365 of IBM
> +   Written by Mimi Phuong-Thao Vo of IBM
>     and John Gilmore of Cygnus Support.  */
>=20=20
>  /********************** FILE HEADER **********************/
> --=20
> 2.47.0


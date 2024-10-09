Return-Path: <linux-kernel+bounces-357980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BF39978B7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 00:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B05F1F231B7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 22:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53163190499;
	Wed,  9 Oct 2024 22:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oE314xCc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7C838DD6;
	Wed,  9 Oct 2024 22:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728514349; cv=none; b=rkAdwzbhglj6SqCTsYUql6tGRVKLC1CxfUt/42Ohsxeb9U953zEjxFDP9nLML6mKAmMMc9vt98Xkzuw212VhbLTtauVuTHrdMifevzHDZd9+79Akie0N6cGW3ymzglwQoSIM3+jzRjSUoFoRhvTYmZFi+ZIrwEYPERi3LqwZQyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728514349; c=relaxed/simple;
	bh=2DpsgIC2xB71M9j4e8NiR2ZDb0cZVWPP969bZsamMWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBy9LIL+G9hFmBkKeysi30BBRj/y1iedNF2ap6A92RUXXiG3gtkOJa084BgjVpOji65eD0UsIivuaCaWVA0227VqObC1k5+TI5rgiWA/dcEe/KIAkqJEW7Zmt4yvnMopUeK0sppUPNeVC8y/KCID6wigtjlPRF+lO1Egz7A/q58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oE314xCc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B556C4CEC3;
	Wed,  9 Oct 2024 22:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728514349;
	bh=2DpsgIC2xB71M9j4e8NiR2ZDb0cZVWPP969bZsamMWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oE314xCcsktTLph2aDLrxjDWtbYCtywhl6o9feGp2GnNJaagXf6V0osJD/EgorZWr
	 MOe69SILnOZIaJCk/xuX9Ncw6n0yUK1TxKZueDdN5DlD5vBnIUiEsHi5jNzS4VJGkF
	 8cLH9yeNPgdgOoqyBvOC587WUrJ2wQiIXK5PLnmi0l5r9zzUo0i6y0BD9URZ4ZexGQ
	 cCS94Wh5UXOXiOV/W8TjqbeJxSsfGhc87Zk6q4E1DCvjRejTjulnvoySGXb4Wxpjlr
	 gQwxYB09kC+0+dQCKQOEAvKk75Idne0opaa+15E3eCaCmqHWdJbiGNivhIlRHicY/V
	 FWLpEPYGkb8QA==
Date: Wed, 9 Oct 2024 23:52:23 +0100
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Peter Zijlstra <peterz@infradead.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>, Guo Ren <guoren@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Yangyu Chen <cyy@cyyself.name>, Jinyu Tang <tangjinyu@tinylab.org>,
	Hal Feng <hal.feng@starfivetech.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yixun Lan <dlan@gentoo.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: interrupt-controller: Add Sophgo
 SG2044 ACLINT SSWI
Message-ID: <20241009-retool-decorated-f6f7b61119ab@spud>
References: <20241009224410.53188-1-inochiama@gmail.com>
 <20241009224410.53188-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mORKp+RCsc5th9HZ"
Content-Disposition: inline
In-Reply-To: <20241009224410.53188-2-inochiama@gmail.com>


--mORKp+RCsc5th9HZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 06:44:07AM +0800, Inochi Amaoto wrote:
> Sophgo SG2044 has a new version of T-HEAD C920, which implement
> a fully featured ACLINT device. This ACLINT has an extra SSWI
> field to support fast S-mode IPI.
>=20
> Add necessary compatible string for the T-HEAD ACLINT sswi device.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

This is not a complaint about speed of reposting, but I do have
outstanding thoughts on the previous version of the patch. I've just
been really busy with work this week and not yet had a chance to get
back to you on it. I'll, hopefully, get there tomorrow.

--mORKp+RCsc5th9HZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZwcJJgAKCRB4tDGHoIJi
0leXAQDu/yK6OUIRAlXZ9jiK2OQUR90cLjuSBNWMpu5QDGZr+AEAyqf4vq9FHoNV
FdDEIVwNZH0JxVX3zAAZ9TjJiaveUAo=
=wYUM
-----END PGP SIGNATURE-----

--mORKp+RCsc5th9HZ--


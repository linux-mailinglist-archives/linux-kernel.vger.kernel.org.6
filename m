Return-Path: <linux-kernel+bounces-344209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC7998A677
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0A47283084
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951C31990AD;
	Mon, 30 Sep 2024 13:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gy/sIJZP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED52919006B;
	Mon, 30 Sep 2024 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727704598; cv=none; b=Pwqr9iI5fnzNFYiviWmKDy9UBa6tMVPj1cx5Quun+1gILT40tqsCalXBSeM+Qlri7TL4z0R+wcxQt/yzJ7wkh1IC64XxE1VQbuvj5GeIaeb+AeXuxG7w+yBzTt50hHi0TcmalPXJS1lBswP7uoecuaFtvLSFZ3RoN1B/QpjsTKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727704598; c=relaxed/simple;
	bh=30NRGciFseMG6N93v1AGJlHJgDFYXppiGH3pl4yPVmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3myJ66L/IuJQ6QfIzzxUtsDhY8Srx9S2nw3uSD/WLjJKKdQ2k4BCW8GfcJLtrLqjS8IoLrCOd4wsKtMa6iObqS2WQuXu85gwqyY6vOeGaGFqcLykVqjQsyxQWdPCe4ZqnrV/cEN9zs06njFl5YuMWLbJaMrZKVa1TGHYxZ9S9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gy/sIJZP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D16C4CEC7;
	Mon, 30 Sep 2024 13:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727704597;
	bh=30NRGciFseMG6N93v1AGJlHJgDFYXppiGH3pl4yPVmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gy/sIJZPJEMVZ6DUdpwMWiGXhzqjz/ZnXbd/KmR4OT7m2hpqg0qXpvVEFWBZsISpG
	 d38jzm8a7GrBr4BPoPbt4rNq3nEiQIEAEKs2q7RJRpjT5L5rIJspmfK5NbxES++JOe
	 EySB5iN8yw8ElrI0Q6coqOv6KD3HdngTTT61c1KB3+Z2lNm79pxVEoCzzfUkWaw/SP
	 bkYewUeUmUxy+8b0ESzczObsd+VHjKh04IcY0W4PTZIj2BSF19LjKyCI7KHurcvOwr
	 Yt6jZLM/zG5exmr8xI6RUDkukey75j4cf+L9cS7HpJo+/mT6wZXvaiupjZpl23z0Nv
	 U7vCmKSrutetA==
Date: Mon, 30 Sep 2024 14:56:32 +0100
From: Conor Dooley <conor@kernel.org>
To: pierre-henry.moussay@microchip.com
Cc: Linux4Microchip@microchip.com, Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [linux][PATCH v2 18/20] dt-bindings: interrupt-controller:
 sifive,plic: Add PIC64GX compatibility
Message-ID: <20240930-flashcard-pediatric-98e9f5840ba2@spud>
References: <20240930095449.1813195-1-pierre-henry.moussay@microchip.com>
 <20240930095449.1813195-19-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NcogEg1qfug/E1k0"
Content-Disposition: inline
In-Reply-To: <20240930095449.1813195-19-pierre-henry.moussay@microchip.com>


--NcogEg1qfug/E1k0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 10:54:47AM +0100, pierre-henry.moussay@microchip.co=
m wrote:
> From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
>=20
> As mention in sifive,plic-1.0.0.yaml, a specific compatible should be used
> for PIC64GX, so here it is.
>=20
> Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--NcogEg1qfug/E1k0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvquEAAKCRB4tDGHoIJi
0phxAQDv1/ocSlJFG3Wbb3BrbFvRTascd5cVGFJFD/sQy8o08QEAoHHsHlMeyfk8
FXkvbGxJnyxKymhOXgPuYFjYiq3/LQk=
=YfCP
-----END PGP SIGNATURE-----

--NcogEg1qfug/E1k0--


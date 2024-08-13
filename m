Return-Path: <linux-kernel+bounces-285469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1C3950DE7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D5771C224B1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E531A7054;
	Tue, 13 Aug 2024 20:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4sXSiNP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897AA1A7047
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 20:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723580783; cv=none; b=JIozE3WVE/qVC87Wk1yyNPBi9TeCSLiFHk3OTJhjsKSALtw9sdL7fimX5t31KygRrHtOnLffImjV/Ckl/XV3nP+EYi3bcaG1NrxCvUNQC12iYwW2xgHGYzpqH3kf2bRqIVN3ywGE2PEnWuVmflZW1HV797B1YLBFpWZRZHuVR2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723580783; c=relaxed/simple;
	bh=b9/65zj5W7y3m9K1QCNO8Q2g3pMkjwhzHfl+MK7Cowo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ha8Xf+97VgeuhqtstrqVsaBo+jCFcFL1tNu6/9mkVyPLMB8P33RmizHfhBvJCexbxmEel4KQvSR0sOgvzNbpo0bW7ZxwcYXynnU3raJRU8+QAmWT3+Mki/sGkRaMmFIXEuKKu2Q52z1uzG5x1hpmHwQV6LuhyWbDJMqxOSHLgWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4sXSiNP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBEFC32782;
	Tue, 13 Aug 2024 20:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723580783;
	bh=b9/65zj5W7y3m9K1QCNO8Q2g3pMkjwhzHfl+MK7Cowo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K4sXSiNPCVo7y/BPr6l8hxXBaYL6KYB+h7lNqhIkZIA9jp0PPFDkN9gqZoJptkIpU
	 d7hzLzPvW/LkfAcsk+4hpyCCYN58drw2GjpoFSMeTEhGUYlfyMEHGuhCmaIM8pUa9n
	 2yCooRZHutwLdY1vHfy1suN89TgQD9HzmXQ+lOWNEU9OrVLtg/U/TdVl9O/2/9UToH
	 MHBad5GvGmwbrbo/idefhcBI3tEAfSEUaBeMp7lkMMsY2BYc8NS29bX/I9aRlD8y7h
	 1Kmdb0V3OBWChGzRyRtb8bdM5Ci1rKqLEhD3hHevWE1by4Wb9OgFdEK9YZsQs3ZeTw
	 n5S74QBvLtXag==
Date: Tue, 13 Aug 2024 21:26:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
	Andrew Jones <ajones@ventanamicro.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>, Marc Zyngier <maz@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: Add tracepoints for SBI calls and returns
Message-ID: <20240813-pony-truck-3e7a83e9759e@spud>
References: <20240321230131.1838105-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bj7Z9XFSKFWYyR1t"
Content-Disposition: inline
In-Reply-To: <20240321230131.1838105-1-samuel.holland@sifive.com>


--bj7Z9XFSKFWYyR1t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 04:01:25PM -0700, Samuel Holland wrote:
> These are useful for measuring the latency of SBI calls. The SBI HSM
> extension is excluded because those functions are called from contexts
> such as cpuidle where instrumentation is not allowed.
>=20
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

I seem to have bisected a boot failure on v6.11-rc# to this commit,
with a crash before the kernel ever gets to output anything - even on
the bootconsole. For one of these crashes I got the below (which is
actually U-Boots exception handler), but most of the time - nothing at
all. I'll try to decodecode that tomorrow and fish out a config, because
this is either config or toolchain dependant (I saw it in work, with a
slightly different config etc to what I have here).


Starting kernel ...
=20
Unhandled exception: Load access fault
EPC: 000000008020e09c RA: 000000008020e510 TVAL: ffffffff81cbf1f0
EPC: 00000000408a009c RA: 00000000408a0510 reloc adjusted
=20
Code: 3597 01a4 b583 1f45 5613 0035 9a61 95b2 (618c)
=20
=20
resetting ...
reset not supported yet
### ERROR ### Please RESET the board ###


Cheers,
Conor.

--bj7Z9XFSKFWYyR1t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrvBagAKCRB4tDGHoIJi
0pGvAP9I6enEyZuQa0f9l9fmEv9kvOLZTT1Q4nZnyq+/56u/4QD/dgond/OfEUDK
RHZ2lvKQTpBLAMMpK6ElrsJMJT9+LgM=
=2DeC
-----END PGP SIGNATURE-----

--bj7Z9XFSKFWYyR1t--


Return-Path: <linux-kernel+bounces-255197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF2F933D59
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28A991C22DFA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E171CAB1;
	Wed, 17 Jul 2024 13:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBN0Vm3z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0F317FABF
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 13:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721221606; cv=none; b=GQkB7gMWeVMIl91d9Ay5PYWhDmG3lkXDM0TiKmH+XJxeT9mgduZoDGIEUi9SxxURGoqE1g3KswdzqGePhlMFrmMctMauqx4RUE+FRjwRyf36WDVdT8yiRQQYijtPlsNXIgOMKe5ttVfifsOj+uF5KrxItx1tOaR7sKimZKbZeDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721221606; c=relaxed/simple;
	bh=C0t1p4/tPnP1VjckQRuFWVTqpJzCj/as7FvZ2OtK1FU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dR+alOc346BUNWh6U2ctdViPBBMtY/B1QkEDBQ0hIIUc3HWrLmlHHFLpYWmizv0NcL+5NVoDu/CnletYAVjpdjw6CZQOidJecVhN34T5qpJ95IX+pOurVhGd9xh2LuCya0Mzzi8cCSd8u9bsQQ8ViZvtDHms+e7SlZFmfx8oUh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBN0Vm3z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737F1C4AF09;
	Wed, 17 Jul 2024 13:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721221606;
	bh=C0t1p4/tPnP1VjckQRuFWVTqpJzCj/as7FvZ2OtK1FU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PBN0Vm3zfQglSh2z2hOBJcGSr6u46+zZMw7HBXU1EJirkcatyCEo9GxLnywePcACe
	 QjbL9eRFJCZ+rM9xxgQB5KOLMbXHqhSUfrs9Tl9eTFK8t9OSJ2lKpwyl1b6HH9OHF3
	 eifqboVxfEOdyu6pXmZqzb0wzc6dnNFiPJnZXg1EqvzI3jWYZUcrgi9nfsih80IQN3
	 aMmNE4J2N7kuJx8QyeZM8FgPEBRyjGKdi9V3F+5EJWUZThMp3VMR52UftDYVT5DyKR
	 mch8x/m5MSZfmKxARiWtldp27yNeLKS6/ZzBMGc6euPDdbwp58KbPESew1jzYsYs8u
	 jSGM4zEcF72MQ==
Date: Wed, 17 Jul 2024 14:06:42 +0100
From: Conor Dooley <conor@kernel.org>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH RFC] riscv: Allow to build only with LLVM >= 17.0.0
Message-ID: <20240717-commuting-channel-4ad202950e4c@spud>
References: <20240717111716.157149-1-alexghiti@rivosinc.com>
 <20240717-synapse-decade-a0d41bd7afce@spud>
 <203e8784-54f2-43ea-a442-833d7e4a06c8@ghiti.fr>
 <20240717-theft-resample-19c248bb2a26@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2Tdx5ZzAQtnjYisr"
Content-Disposition: inline
In-Reply-To: <20240717-theft-resample-19c248bb2a26@spud>


--2Tdx5ZzAQtnjYisr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 01:06:39PM +0100, Conor Dooley wrote:
> On Wed, Jul 17, 2024 at 01:41:23PM +0200, Alexandre Ghiti wrote:
> > Hi Conor,
> >=20
> > On 17/07/2024 13:32, Conor Dooley wrote:
> > > On Wed, Jul 17, 2024 at 01:17:16PM +0200, Alexandre Ghiti wrote:
> > > > The following build failure happens when using LLVM < 17.0.0:
> > > >=20
> > > > kernel/sched/core.c:11873:7: error: cannot jump from this asm goto =
statement to one of its possible targets
> > > >=20
> > > > This is a known issue [1] so let's upgrade the minimal requirement =
for
> > > > LLVM to the version 17.0.0, which is the first version to contain t=
he
> > > > fix.
> > > I think doing this unilaterally is kinda insane, LLVM 17 isn't even a
> > > year old. Debian testing doesn't have anything later than 16.
> >=20
> >=20
> > Debian will very likely select the qspinlocks when available anyway, so
> > they'll need llvm >=3D 17. And Debian won't ship a kernel >=3D 6.11 unt=
il some
> > time right? So they'll probably update their infra to llvm >=3D 17 (and
> > they'll probably do to take advantages of the new extensions).
>=20
> What I mean is that you are going to prevent people building the kernel
> with llvm on machines running anything but very recent rolling-release
> distros. Your patch would stop most developers, including those who don't
> care about your qspinlock stuff, even build testing with the version of
> LLVM that their distro provides. I'm not talking about distros building
> kernels in their build infrastructure.
>=20
> >=20
> >=20
> > > Why does
> > > it need to be done unilaterally rather than just when the qspinlock
> > > stuff is built?
> >=20
> >=20
> > We can do that indeed, it may happen again and we can keep requiring ll=
vm 17
> > on a per-config basis.

Nathan pointed out to me that I misunderstood the build failure, and
that it happens whether or not the option is enabled. /sigh.

--2Tdx5ZzAQtnjYisr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpfB4gAKCRB4tDGHoIJi
0l6BAQCd0FpEzXdgZp2Uy/j3HO577wh65f4yVPgCTfXFW93RSAD9EVU1EgR+YBzH
OU9kSaTlxRGRHmENI0ilR/fv4OZrJwU=
=bjUU
-----END PGP SIGNATURE-----

--2Tdx5ZzAQtnjYisr--


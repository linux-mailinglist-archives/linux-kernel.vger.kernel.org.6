Return-Path: <linux-kernel+bounces-255175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12281933D1B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 14:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0913284C44
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 12:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB45817FAD8;
	Wed, 17 Jul 2024 12:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQLsAH+F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F74741C63
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 12:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721220195; cv=none; b=AQS7F2LMprHxV9KbL6F64+j/uycUq5KdlzkQuULtDSx2ob5UCyen8nMtfDL0xn0J9CM0wMqO+NDrByE04zTO52jyEgAhCTdeNkZXefZtzB02m15CAScf81Zq91DeALSnAeg92btfFSRbNXlRljn4Ziu3hn147fsvoOMIXIStO/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721220195; c=relaxed/simple;
	bh=o8L/1xWvvMqYhwIVZeAmc5Si5NeHaEu+RWc4qcM9T60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTjTbL0X6Bbr/FcSwLi0pHcM2v5CYfQRDUnN5qm9ugy0ZU+xsy0igyIXhxmEBAalsxYIqV+2qNW5EOUvEK7IZhyz5obIWpzfAxHOnQHF0VlC+npzRmPqZk1466tyWM36gB5rWmioemAMJiOJNbBDNK8D5FPvHCvv9WANbxA1EyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQLsAH+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C45C32782;
	Wed, 17 Jul 2024 12:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721220194;
	bh=o8L/1xWvvMqYhwIVZeAmc5Si5NeHaEu+RWc4qcM9T60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XQLsAH+F7TI4KWqV18Ro9auCg3owA3fv1+BKhqGEUi3MLpBWNzYAsXAlAGjIJcI+0
	 Nw55t19kP6Yy7KtLF3IsJ27P5ppkwTx0W3CNCmUMeRETt0X6ee6okjTeRCbPayE/jD
	 ntnqVuP6nGl6mnWDvywqJzy5AJgPFxuTylxzJsnnyoBuBLcP0UYCuce1QCLLTMlMkQ
	 WNfTo0nUbH2Wg6/OKE8/3mdIAmhfokzp2Gw4BpMyvsBnhgkvs8n4X4Dh0UGYq0wVvM
	 UWWtXtxwjociB63ylyOXKYjtd+wgG4+5a8EnOCifYSNSB4wVxXit3QHIGZKftzmzJF
	 IugLKiBDRcLlA==
Date: Wed, 17 Jul 2024 13:43:09 +0100
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
Message-ID: <20240717-catsup-corny-def9db822c4e@spud>
References: <20240717111716.157149-1-alexghiti@rivosinc.com>
 <20240717-synapse-decade-a0d41bd7afce@spud>
 <203e8784-54f2-43ea-a442-833d7e4a06c8@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QHQw7inv+90Ljupu"
Content-Disposition: inline
In-Reply-To: <203e8784-54f2-43ea-a442-833d7e4a06c8@ghiti.fr>


--QHQw7inv+90Ljupu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 01:41:23PM +0200, Alexandre Ghiti wrote:

> > > Link: https://github.com/ClangBuiltLinux/linux/issues/1886#issuecomme=
nt-1645979992 [1]
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202407041157.odTZAYZ6-l=
kp@intel.com/
> > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > If Nathan wrote the patch, you need to set him as the author of the
> > patch :)
>=20
>=20
> I thought I did, how should I do that then?

$ shazam 20240717-synapse-decade-a0d41bd7afce@spud
Grabbing thread from lore.kernel.org/all/20240717-synapse-decade-a0d41bd7af=
ce@spud/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 4 messages in the thread
Looking for additional code-review trailers on lore.kernel.org
Checking attestation on all messages, may take a moment...
---
  =E2=9C=93 [PATCH RFC] riscv: Allow to build only with LLVM >=3D 17.0.0
    + Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
  ---
  =E2=9C=93 Signed: DKIM/rivosinc-com.20230601.gappssmtp.com (From: alexghi=
ti@rivosinc.com)
---
Total patches: 1
---
Applying: riscv: Allow to build only with LLVM >=3D 17.0.0
$ git show
commit f64f8420ca518b5dde35224cfff7ccfd14e5b496 (HEAD)
Author: Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Wed Jul 17 13:17:16 2024 +0200

    riscv: Allow to build only with LLVM >=3D 17.0.0
   =20
    The following build failure happens when using LLVM < 17.0.0:
   =20
    kernel/sched/core.c:11873:7: error: cannot jump from this asm goto stat=
ement to one of its possible targets
   =20
    This is a known issue [1] so let's upgrade the minimal requirement for
    LLVM to the version 17.0.0, which is the first version to contain the
    fix.
   =20
    Link: https://github.com/ClangBuiltLinux/linux/issues/1886#issuecomment=
-1645979992 [1]
    Reported-by: kernel test robot <lkp@intel.com>
    Closes: https://lore.kernel.org/oe-kbuild-all/202407041157.odTZAYZ6-lkp=
@intel.com/
    Signed-off-by: Nathan Chancellor <nathan@kernel.org>
    Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
    Signed-off-by: Conor Dooley <conor.dooley@microchip.com>


When you commited it, you needed to set --author. Just adding his
signoff is not sufficient.

Cheers,
Conor.

--QHQw7inv+90Ljupu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpe8XQAKCRB4tDGHoIJi
0hl7AQDHfW37RGUzqroCvREuQMRJha3XF9ktK9M72+YjcNoGHgD/apWw+RC/zTmt
Lk8+0u1e05REJLDm6x45cI++lSGY9gU=
=OrOa
-----END PGP SIGNATURE-----

--QHQw7inv+90Ljupu--


Return-Path: <linux-kernel+bounces-176177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F538C2B42
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 22:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A0EA1F25EE4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 20:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BBA4F211;
	Fri, 10 May 2024 20:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXZkQa3p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6E843AD9
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 20:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715373818; cv=none; b=aLEzgyNGNTeSLerAj6XmGg8cjp660XhAhAYt872fjcvQQpNx/k5kpodTBrQaldwgu30Z9j5XQMRIWzUW/uDcd+J4Wm8SxuT8Gwil5aFG7llZ58jy6Q4D2/e/9D8d+pvtDg9MnBB/+rW4QON60baJoKDqNY5Uz300Vh6pgUe3/ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715373818; c=relaxed/simple;
	bh=V1weiyqYUi8cf0/ypiHaTqUR1iBXGA2Jxo6KOzagAx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWAfw+H7YT+efQ6N23R+h5IJetrWaJXVmZPEpUyp0SDBo6ahqosXtUwZhOGk1zVTTX31DWRjUiZtxO8c024rFzn7l2gVoZhDW4t8BNgFY/G0wk51W2iauxOzjuwahmDLxYnUWfGLaNuIapHe/i/TleLx8DljwJMnl9s/axglcSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXZkQa3p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824FFC32781;
	Fri, 10 May 2024 20:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715373818;
	bh=V1weiyqYUi8cf0/ypiHaTqUR1iBXGA2Jxo6KOzagAx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZXZkQa3pJnj42KiEXIR1BP+TayP4gESPmBa6+RH8LUZrZlcAKDsgA8sI5IK3F13vB
	 +ibcG3vY+8oNiJJJOu+DsPmfvRnKbaL0pf4Fxa9Yi6k89Tnn+zOAAoIDdmc5wIwS0E
	 jmh6xA+pLxIcHfDHR4qZsqnL5sccoupfGTEJwaqq920X/OeZJtrYU/BS8YwgHmSN9q
	 JQWYjqzbAFrgImdxj7kaIJmGMd7LAIJD4ET03kSwowkAGljZorS8YvpKF2Sj2GordG
	 jePeLEMLyNSi4szrut/FoCSe70RPX79lSrYdHgnfMGHzPKwluHdRAS9qhVE/yM2gFu
	 03vgHJeLDBY3Q==
Date: Fri, 10 May 2024 21:43:33 +0100
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor.dooley@microchip.com>,
	Song Liu <song@kernel.org>, Xi Wang <xi.wang@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jessica Clarke <jrtc27@jrtc27.com>,
	Andy Chiu <andy.chiu@sifive.com>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] riscv: Add PLATFORM_MAY_SUPPORT_RISCV_ISA_V
 Kconfig option
Message-ID: <20240510-earthly-regress-7a8c8dba55db@spud>
References: <20240507-compile_kernel_with_extensions-v2-0-722c21c328c6@rivosinc.com>
 <20240507-compile_kernel_with_extensions-v2-2-722c21c328c6@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kt7YioCjm2Pco75f"
Content-Disposition: inline
In-Reply-To: <20240507-compile_kernel_with_extensions-v2-2-722c21c328c6@rivosinc.com>


--kt7YioCjm2Pco75f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey Charlie,

On Tue, May 07, 2024 at 06:36:28PM -0700, Charlie Jenkins wrote:
> Current versions of the kernel add "v" to the march and then immeidately
> filter it out such that "v" is not passed to CFLAGS.  Instead of doing
> this filtering, code blocks in the kernel that want to use vector
> assembly have been changed to locally enable vector (using ".option
> arch, +v").

Other content in the series aside, since this is a change that could be
made independently of the main series objectives, I figured it was worth
pointing out that this is not a change without downsides: I think that
it would drop support for vector with most versions of LLVM as
option arch support there is much more recent thing than it is for gcc.
Off the top of my head I don't know exactly the versions involved, but
it is something like LLVM-14 supports vector but only LLVM-17 and later
supports .option arch.

Thanks,
Conor.

--kt7YioCjm2Pco75f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZj6G9QAKCRB4tDGHoIJi
0q+gAPjjKuRZgtdpysJjkfjOXgAbIViLfJa9YW6kDhN9A8nZAP9+kEU1aZXKxvFD
4McVJZQgAsM/xY3ZI7ahJNfgyKE5Bg==
=hfje
-----END PGP SIGNATURE-----

--kt7YioCjm2Pco75f--


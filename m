Return-Path: <linux-kernel+bounces-386922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C73F9B49BC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB686B217CF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29519450;
	Tue, 29 Oct 2024 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0XX2WtU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E438539A
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 12:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730205200; cv=none; b=e+F2ClsMtDsnETONi60W4FfsmEOKkA9hpp6PaG7qtpCI5fwh190//N3WGUnGFOMQLZFbhu1lfrKUExAUOzWoe8mAGStXr9YOgII4DAoelPxTZRzi2xXlZb2rHYBaVCkJtyNp4QST7qzEN5yGTpo62hnB2S0/Wn3KKxRv5HjX1dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730205200; c=relaxed/simple;
	bh=3oz5OCzkZXQC+rHxhytPMECDTe+7K0m2PqLGlcDUmM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQWTaERw5l+ZFc3vlM0H5/YU5ToCCmqBaq/8Dk2ISCIQ7lWPcSKDKA6ZjUY93f5ILCDB61ZyxswTUFkoQ59T0AUtfvLkwkSkFVQyRTSuj2RKWXYe9ZzFmZsBAAFzlqFgTThIJudbnpCABOejBKmrXUu4sfV45a3MHiec5spWVGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0XX2WtU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DFC6C4CECD;
	Tue, 29 Oct 2024 12:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730205199;
	bh=3oz5OCzkZXQC+rHxhytPMECDTe+7K0m2PqLGlcDUmM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R0XX2WtU/ewSgT3aG9pTCgLn1bK2naVRGOXUb693RM18Kb7jctHhyUlvBnyB2nnHt
	 CTt3ZJq25U3qXw1GaLP6EDei2p75AXW2w8yVNkhfKLOewbUXPHcO3R7CGVH6OJgeO8
	 /2RC4LYcJHjIE3IA8RC6lvrwsorrQZFIAYJ561d8iavr9YpagDZvZRHVu1fGKbW7+c
	 K61XRF9dakPBbBM4zKIdK6J+JO/sRjupd5/S2KBsBi2iN12ZhBm8Utxr5v9E03e38B
	 BV4ZXyX872RuAkn907OrS5jfHek8XkOMf867Nfo75U/m+j0gCBDgy5f7E/SDg/Ch8h
	 ghk3yU46ByPlQ==
Date: Tue, 29 Oct 2024 12:33:13 +0000
From: Mark Brown <broonie@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Peter Xu <peterx@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Aishwarya TCV <Aishwarya.TCV@arm.com>
Subject: Re: [PATCH hotfix 6.12 v2 4/8] mm: resolve faulty mmap_region()
 error path behaviour
Message-ID: <0d3237d7-cb70-4979-b262-29ffe7d7a608@sirena.org.uk>
References: <cf1deb9b-c5c4-4e85-891d-62ecf9a04e0f@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+c7bJTQfcONVyaEN"
Content-Disposition: inline
In-Reply-To: <cf1deb9b-c5c4-4e85-891d-62ecf9a04e0f@lucifer.local>
X-Cookie: May be too intense for some viewers.


--+c7bJTQfcONVyaEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 10:14:50PM +0000, Lorenzo Stoakes wrote:

> It doesn't make sense to have shmem explicitly check this one arch-specif=
ic
> case, it is arch-specific, so the arch should handle it. We know shmem is=
 a
> case in which we want to permit MTE, so simply check for this directly.
>=20
> This also fixes the issue with checking arch_validate_flags() early, which
> would otherwise break mmap_region().

The relevant tests all pass with this on today's pending-fixes.

Tested-by: Mark Brown <broonie@kernel.org>

--+c7bJTQfcONVyaEN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcg1ggACgkQJNaLcl1U
h9DLswf+MdDUA6uK1U8jVbIG476TdL1quD1o3LXC15bDaBLUC8cZL7UsJWh1t203
yMbqza4KA6GjA5Rbbcvy/07Y5fvtHMmkHkQ7gHt7zgAmY8jBFYeQUueJzMpy23Jx
MRYiKblk+Ezh6SRMBHJy09dB2yCorGmPJ/uXfUo4tZ5lvffqPd7CkULu4DWZGbcT
YHrLZQmXKOZbSTOxSQHxehCoOOFevRgW3qQgTjUiFXb7+Oi0ztZO1Z9Aptcrnfnb
0/kCRUZ0eRLwCkZao+cMo7rW5fTv8a4EcU0H4SzO84KD8ode1ZLnZkbpEbEt6eAe
9hLCdN4QURUV//NVaY6j/dvu2GzYyQ==
=OcfD
-----END PGP SIGNATURE-----

--+c7bJTQfcONVyaEN--


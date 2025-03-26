Return-Path: <linux-kernel+bounces-577000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 730AFA71728
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54A7E7A4765
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967FB1E5B6C;
	Wed, 26 Mar 2025 13:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RiCfGsPc"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5391C701C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742994801; cv=none; b=roxvgrOqpAu1feSgpvaDZoihomCpACsyiRJETmAZGg2/Vqo//AnUHsz4Oi890WZQSTxmhtMYkDKopYnjoMCuYrjHWIyOpQtJI8U/7rVLP6194MU0u4LizcGVQal0PvbWqt1RRLgi0vA8qMbncP/8KCfwcCIwsw8PNyDRu3StQa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742994801; c=relaxed/simple;
	bh=jFg9wv/JLVp4O097cPYsg6wFFeya5WHBKUv3ztZpqeE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KID14IWeiwTp/e4fcmKIxEtLrtdZeB+0EJCiOleIYsr3VHR/iWVU7R7QCNqjXBmNAYh1VtIoe4X4j8zflRu1MjR2JI3gywrLb8AKDsAl5iFli2F6HXiA2fquVUoRpcPSXoe5aZWCvxbWrBotbR3JR6FHbkAcf6hLh6FTuQWL/80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=RiCfGsPc; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1742994791;
	bh=jFg9wv/JLVp4O097cPYsg6wFFeya5WHBKUv3ztZpqeE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RiCfGsPc7e5xvuhP9Wq75plR8oHjMy5cT6wSVosydGXL2iOCVz61cj88vcPI624NA
	 U6Egcb4q5mRkdBgtfrgpOcG5ID1vqyi3Y07nLXnkDs0555kgP0vGK2Rlcvzn9Trv21
	 loVMHQLdgsZ2LpmXmUtEhxbSu6N6rzV0Qzb3Lhv/MoRswhS4FCXq6EqPV0kY1IMcBi
	 lD3Vnfw9fxsJZRLJTI80JXfitrpfMMzewXSWLmiFDwNZlY9QD+1gcLZf4R4wgqF1Is
	 5B7XIiHswIalC4gVMFKEZUB38QpwBit2xkQdU9yq856L44cxKi78CEOe0RmVGLOEQ0
	 KfQ54jgCo9Cmw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZN6fZ1PhPz4wbp;
	Thu, 27 Mar 2025 00:13:10 +1100 (AEDT)
Date: Thu, 27 Mar 2025 00:13:08 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Ingo Molnar <mingo@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, "H.
 Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] objtool: Fix NULL printf() '%s' argument
Message-ID: <20250327001308.05910bd9@canb.auug.org.au>
In-Reply-To: <Z-OsCFQ_qUHjRVmV@gmail.com>
References: <a814ed8b08fb410be29498a20a5fbbb26e907ecf.1742952512.git.jpoimboe@kernel.org>
	<20250326151014.6a006c93@canb.auug.org.au>
	<Z-OsCFQ_qUHjRVmV@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FOgQcg9IXkWp2jybJTrx0IN";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/FOgQcg9IXkWp2jybJTrx0IN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Ingo,

On Wed, 26 Mar 2025 08:26:00 +0100 Ingo Molnar <mingo@kernel.org> wrote:
>
> Thanks, I've re-spun tip/urgent, so the next -next iteration ought to=20
> pick up the fix.

Excellent.

--=20
Cheers,
Stephen Rothwell

--Sig_/FOgQcg9IXkWp2jybJTrx0IN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmfj/WQACgkQAVBC80lX
0GzTHQf+IQ4oxn68rqcr0vqDzGTfcb1co5NiVuNR4NehyXpTPef9vRPzfiOTmrWV
3dVBGejgNfPXhIpNHzmCB4xuTiJo/UJ5WNJfqQWNiX929xsigtbCsRSkn4BohwQi
ROn/TqORxyUshyov3+w4y6moLDN6mgZbnd14SNPMQnLCah5FtYX+LJgFTqLBgDro
/24NYfzbb1/Sh8S0QudCeMkdd7VXbaIqs6+l79m0x8XAeevMy8PH3nlqRswEaIVf
tVSNgpXX/cvjSNjgIEmYsqcJtmi7as6IJmwOVzIfZ3/O1WO6hTRC5gMMMWT8Z6a8
37GkClz1gb60YvxjYWMlxNv3D8uZSw==
=jSpu
-----END PGP SIGNATURE-----

--Sig_/FOgQcg9IXkWp2jybJTrx0IN--


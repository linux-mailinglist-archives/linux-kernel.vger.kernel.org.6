Return-Path: <linux-kernel+bounces-355874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB97995848
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91D49289642
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B12215004;
	Tue,  8 Oct 2024 20:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Wbf8mIAj"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D1A2905;
	Tue,  8 Oct 2024 20:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728418849; cv=none; b=JRMocdY0Zw0yiwqL30FvLRYu9z/ahu700OP/RnZLk/RTG+/DbVw+V5luwnW3fY07yBqRlxQYFWG0mCAGlK2uTPTBQswCBRPUegtyYkLFw0CXl19q2XBrozkRnUSyTRZaxEhZSRpDLma0elkV+874xX2/cM8lE9qnYHLMtvaX45M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728418849; c=relaxed/simple;
	bh=a+CvXQsfvb9W0/UUGySvxVG4bRVf92+QlgygJfurKFg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=KIciiZ5tyHExU6wn7gHGhDWk0owz4UW5CdoOKJWs13WdUYCvKp33X/t89e06YujyRyiDRyNP0il8vpLDNf9ZNpqhkakVg+Tob4C031IoELn+S9Ag+AfPCschvLHu8qdCLDBCFdUrDaHJDnTbaIvj0I7HK1JW1M8Im04IgvO1bDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Wbf8mIAj; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1728418845;
	bh=ZUAX+nMXdMMBK4bJn355F73977ikaUcKeALd46qz2xY=;
	h=Date:From:To:Cc:Subject:From;
	b=Wbf8mIAjsqtp36GLo5CP94iicjq7qVPy8TK4dHOd7qGl8jcY3cKLtdpmIPyfDYily
	 URWMOTji1xfbzZLsKgOETBP1UybpQZUM0oBNGadXxriCoPMIsM01tkqodIea0wrd2D
	 7iIADOUVyZHzJmOtpahF+KIOI9f96PoLgGUjehujrqyUd8+ME3uYKKFARTEG2lOwFq
	 Gnmsgbyv+QYvJNOIHdYDHM7LwGhMTuIhd4SZyoMgQMbTZcbsFiip2ehoZ3oflPLcsd
	 VEQSndDCQ1FjMvLq1bS5FDsyZZRwiOCiLvmRUFQ2qYlhByiQVMBRwYnB9ckdUkUMva
	 oyoPYu7t8z7NQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XNS7x0M1kz4wnr;
	Wed,  9 Oct 2024 07:20:44 +1100 (AEDT)
Date: Wed, 9 Oct 2024 07:20:44 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the mmc tree
Message-ID: <20241009072044.67f195b0@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TR000JQqvI7yc5729qgWj3n";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/TR000JQqvI7yc5729qgWj3n
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  14b473254d60 ("mmc: sh_mmcif: correctly report success when obtaining DMA=
 channels")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/TR000JQqvI7yc5729qgWj3n
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmcFlB0ACgkQAVBC80lX
0GwPhQf9G2/SfbOyjZ4W62YiiC73u5jdlghFkstXNRBJo7NsHsncwFvLaDMJu5Bb
SE17VBz97FKTJRl2/M99smdcnZK+svNmXlBSQJtgYy8iRFvBhzTBfDU/CqC6R/5e
gB/FYDmdPuRvQAg+Z759Frq7qoTdrFy8Q4dgoTuJROu1bJmtSinCj6w+oxu8HAcG
FlLzNo3whZHL3csK0frdCAsaOEdkZuJ1yjgBqIUoRHNvcVy8EEEicdGXMUE0TSSr
10XEuPw6UbgQs81SMu2N+JBoReEU91xPvEUqdP3QVoFVNbbSEunmfG9OlJznmPRv
PtA4rkYO/D6f8FmIotJt0WVKv5jrIw==
=EQ/M
-----END PGP SIGNATURE-----

--Sig_/TR000JQqvI7yc5729qgWj3n--


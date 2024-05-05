Return-Path: <linux-kernel+bounces-168856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7268BBEEA
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 02:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05BA81F2184B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 00:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260E263A;
	Sun,  5 May 2024 00:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="X2xoR3v7"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06581197
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 00:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714868946; cv=none; b=clROoi43zh0MmeCLepVKkgJdgIwiMSOv/OPtJhK1sBi7iu4MKjFSqy5Fkr0WsxiYICjf2+kpkVixzlYRRNrPRZxP5dfDc4MLjsONE0lc5cjfvAwoQNrIdg14fTenVLI1SH4iDylFZ2FEkI8OEwDHTeySdvDaUbZwS6gICUHcVGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714868946; c=relaxed/simple;
	bh=Oct8tH33jpLG4KPdTu19d2fWb+qb7ZEeQiyQaPrGtmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o/T+pQL5d67KdGm9gigzz0DrM0uJiprXSijdYWhmtarUS9XmItQJQxuQhphKiTe+NB89/zI/ISlm5M8EHVR1XP4nfr4FYoudKGlXCH08IU7wSN6JP9sc/ryuSl/vqPPbDfrOApDxQfFpqrGenym+yp9kZVpykOHer2XvQ8l4ZUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=X2xoR3v7; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1714868934;
	bh=W4X7cR0LaXN5r6M5SrLOReenkryNgmrUe3eXtF0epm8=;
	h=From:To:Cc:Subject:Date:From;
	b=X2xoR3v7ilzS6yaheJ5VftNMzyZF/jHb2R0/yH0eALLfHVCmi+ZMk1cWP3VC/+ObZ
	 tVGRQFDCGZVcfLPPkI95IqHuCUKt6pAp2hMl8+GO1WeypZN7Ffo6+u7NxIixNGs5NZ
	 PaVJCXxhh+jVmdV2h9Jdi9ugVx4eydEVyct863KQDKiLeEsmeUQ1wi8OGiXqO8qoiW
	 ztuEP3Hh/qGBHxnzZvYTFei1KW04z9Uuk1kyBGwmyC+GTmcWCewOtj+qb6enfV8F08
	 L1QlFECgk5HJcvMsoPHpL6q7yJx6hIZungC64MZ6VCXdIxr5t42DLWOfe/Q9GCqRBo
	 S+iHiCtE5LaWA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VX54k4rzwz4wp3;
	Sun,  5 May 2024 10:28:54 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: gbatra@linux.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, nayna@linux.ibm.com, ajd@linux.ibm.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.9-4 tag
Date: Sun, 05 May 2024 10:28:53 +1000
Message-ID: <87fruxumnu.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 6.9:

The following changes since commit 210cfef579260ed6c3b700e7baeae51a5e183f43:

  selftests/powerpc/papr-vpd: Fix missing variable initialization (2024-04-12 14:40:07 +1000)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.9-4

for you to fetch changes up to 49a940dbdc3107fecd5e6d3063dc07128177e058:

  powerpc/pseries/iommu: LPAR panics during boot up with a frozen PE (2024-04-23 14:34:00 +1000)

- ------------------------------------------------------------------
powerpc fixes for 6.9 #4

 - Fix incorrect delay handling in the plpks (keystore) code.

 - Fix a panic when an LPAR boots with a frozen PE.

Thanks to: Andrew Donnellan, Gaurav Batra, Nageswara R Sastry, Nayna Jain.

- ------------------------------------------------------------------
Gaurav Batra (1):
      powerpc/pseries/iommu: LPAR panics during boot up with a frozen PE

Nayna Jain (1):
      powerpc/pseries: make max polling consistent for longer H_CALLs


 arch/powerpc/include/asm/plpks.h       |  5 ++---
 arch/powerpc/platforms/pseries/iommu.c |  8 ++++++++
 arch/powerpc/platforms/pseries/plpks.c | 10 +++++-----
 3 files changed, 15 insertions(+), 8 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmY20ogACgkQUevqPMjh
pYACiQ/9F0++bTHAbQyWuEE18xmJIbicTWINXyNor9b2hzp4Z7vXFKriXw1PVbLj
oZXWyNfSfZKmcylRed7+a14Nd5dNKehEJnIYJ0Zvhca3Rh9gfKMtN/CfZgDbIFlL
5kLpSG1RV834PSu0tguU+lucJf2SSwkYotlKmQZeB1sSY80r2YGXdCJ24g+mZBIf
ervhfyJE+rd0RPNdxW6SaLxdLcEMcELTu+6H+FU3uNDFpWypstfQHQg6mgLN56hh
4ZEVWTrlq4SNSxlS0f7YthQHIVYqfSqw0FAnXDQHTsy3rqMDkLCZeYVB60kndigh
rOAuK+Hbs2XDCvgcNFeHOBaKS9n4t1AqreinYFLYwRTtnbVhOjEws9K1CPllWveo
2Y+qfOy+NovNUpqfv0xGbbikl8e15DXheA++xjNQqXcwMxl8nJOehjw3BkMQjm48
dhd0ulJ4naPkKfMKbu9/ifq8Xr54n1Cf0fkbECe12tbasvIrbXO74cf/Ar2Zw83N
Xbx1vOREKJ6zdvS5HIt5gG6d3CDG9UHP2JhP+9/JFAbjsVF38jWszcEPEfJBUBoY
3pcNFGNQBUY9me9D2J2wOL2XSA80FT0JQCJ5Dg8zjiJHQh8oBv1yXLT6VgCMjA5y
jnfrZec/IG7HaRb2m20AUCtrHsO56M42ZG5DjZYdTH976Y7+CLc=
=3rSG
-----END PGP SIGNATURE-----


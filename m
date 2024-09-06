Return-Path: <linux-kernel+bounces-318835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D40496F402
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAE2F1F2546A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DF71CBEBF;
	Fri,  6 Sep 2024 12:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="J1GdzgcJ"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88F11C8FC7
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 12:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725624478; cv=none; b=p0U47IQqukT69n1QLS+bHcs3bmVXSgDRLr1KBJQfSf6bDQ8apxkY1dDECdoGOqUvounPMSc5MR7jggTTMBGY7xR40RpP1dcBC4nC40ZerDw4hSJCMVrMwi8pIJ+V0JZgW8FPeWG5+JAOnOb4dW9vZ4xvAExLNtkAkIZuRLquJf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725624478; c=relaxed/simple;
	bh=AK3Bco56VowsPd2wmXf6dvMXJGHU4PXOgzX1/TedXec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nbKJjekAnYDHcW7++Qe4Xoo4BUvzIbvSzdTZn5u6mktzvFJg200MrJ9a/LSkJ/7xouJ60Jh2o3lz47ffNw6ISGJKNK3i6+0MVEoIopjKwa8MuY/rX8hAFEesQbkHHKoC6xuTPrJoPlZUbsZW3yx/UAqE2yTdnvHhncNp0RvZ7nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=J1GdzgcJ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1725624475;
	bh=LDbfFUnNpnF7jbDUTOMT7ZzS2g2NbIVeFFf4A5ujKEk=;
	h=From:To:Cc:Subject:Date:From;
	b=J1GdzgcJiyWEvw2Yzs+Vhr79KwgdvfmQTDtv6uuWQBx6n46PFGJJe5gaUCC8/0wDI
	 41dFISJk2MFQSS5Xh9ZkDZPJEH7HgVkeBUaKUOqts0ys1AqyCdt2qm4DGRFa2EiBz9
	 QqzD/sJ2NBk5HuPQwDAQsN15gWabOXjev2gtPydtBuMnzaAn9fSpRLAW1iOQE9ZeIo
	 yfHFtfgegbkzPI+yseWEM9Y7PgzL9co5G60CwHYOjy3iaZbJ1ebVPgclQe5ZT07z0T
	 17IiwGd0sTpYC0wVL7vWShASfPNgn+3TrKu1GNXLnOomewVMD9891qy2BhYmhT0W03
	 c12YtTpYkmtAQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X0Zk30R3dz4wyh;
	Fri,  6 Sep 2024 22:07:54 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, nysal@linux.ibm.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.11-3 tag
Date: Fri, 06 Sep 2024 22:07:54 +1000
Message-ID: <87ttet3rz9.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi Linus,

Please pull some more powerpc fixes for 6.11:

The following changes since commit 227bbaabe64b6f9cd98aa051454c1d4a194a8c6a:

  powerpc/topology: Check if a core is online (2024-08-13 10:32:17 +1000)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.11-3

for you to fetch changes up to 734ad0af3609464f8f93e00b6c0de1e112f44559:

  powerpc/qspinlock: Fix deadlock in MCS queue (2024-08-29 15:12:51 +1000)

- ------------------------------------------------------------------
powerpc fixes for 6.11 #3

 - Fix a deadlock in the powerpc qspinlock MCS queue logic.

 - Fix the return type of pgd_val() to not truncate 64-bit PTEs on 85xx.

 - Allow the check for dynamic relocations in the VDSO to work correctly.

 - Make mmu_pte_psize static to fix a build error.

Thanks to: Christophe Leroy, Nysal Jan K.A., Nicholas Piggin, Geetika
Moolchandani, Jijo Varghese, Vaishnavi Bhat.

- ------------------------------------------------------------------
Christophe Leroy (3):
      powerpc/64e: Define mmu_pte_psize static
      powerpc/vdso: Don't discard rela sections
      powerpc/mm: Fix return type of pgd_val()

Nysal Jan K.A. (1):
      powerpc/qspinlock: Fix deadlock in MCS queue


 arch/powerpc/include/asm/nohash/32/pgtable.h |  4 ++--
 arch/powerpc/include/asm/pgtable-types.h     | 12 +++++++++---
 arch/powerpc/kernel/vdso/vdso32.lds.S        |  4 +++-
 arch/powerpc/kernel/vdso/vdso64.lds.S        |  4 ++--
 arch/powerpc/lib/qspinlock.c                 | 10 +++++++++-
 arch/powerpc/mm/nohash/tlb_64e.c             |  2 +-
 6 files changed, 26 insertions(+), 10 deletions(-)
-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRjvi15rv0TSTaE+SIF0oADX8seIQUCZtrv3QAKCRAF0oADX8se
IbILAQDjj0pScmC9KZX8xYxH7QT7uw4WnTvuYclNNOMQAU/NhgD8DVMpHfMcj75r
ErmOete8qKyD/3w1P+70YGICf4yKewU=
=fFem
-----END PGP SIGNATURE-----


Return-Path: <linux-kernel+bounces-290879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F5E955A71
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 02:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDEA81C20B83
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 00:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE7917D2;
	Sun, 18 Aug 2024 00:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="n14UcT6m"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FED366
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 00:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723939401; cv=none; b=GaCIDoqRICrfcwGYSdxfkf5QoPkHTjYzuqBr7sBsp/yA3GEwn7X3NfGJn3z5ABmGqEJXvu7zfMXP9NH4JiKio2+F4hzPRICWKPnVGanHsYX2y3kvVq+Vh5MZ3jU8Gcxt0Ii7kCLFxGC/ktzLUh+amQys3Py0t02EfX2UBSAM4j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723939401; c=relaxed/simple;
	bh=43PNXDjta+N+EXhuUTIcjpCi7FZQMT1ibYrtMuZct2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oc4BXT0g3CZTLfqOQ5bdB+3XSOYs6BEPEeJ/T7qU4AwsLxJDYjCBs8jXZeeHBeIK2WROGHKQa77ofHjQhKa9UsXzObm1LQ/Ews97phAsRRQ7HPubpt+sh8+rm6zoQ4Tw6j3C/Fms36Nnjyqmbg2xSvGJ2WqVniXH8RQyEWFI38g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=n14UcT6m; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1723939395;
	bh=2UFLq6dlA8/JQmL3/dwSoFNJuKq4nWc6UNq2PkM3vB4=;
	h=From:To:Cc:Subject:Date:From;
	b=n14UcT6mT+io6/zpYQyiWlLaaijLJ43pu8MK9NkZ4m8euQtcr18HdyZPtWFrcwFa9
	 AwMpQl7gF46Zwq1LImMJPHBtnJk/xg3lWFgcyVfBdC4+uDrkB5g2shdLmrceKM133v
	 G6uw6qXfluoKbFUGFvQ+StxmxztLprbvO1fXLhM0jWGNcEBuDC6Osr25xhKE1rbe4W
	 Q12r764uAvX4ifGAqrV6rvJBpPy1ID8NJ2RSZ+o6h7dKdLdO1QdcJ1he9C3GfrRWzS
	 F8LVnBmgdnkVyMJ6kP3cvwCwKDTQQBHFHNaZJA3TOmm8cS20R3RxP/o8IpqggcygIe
	 z7ioXmP/hLkxQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WmbXd3cFgz4w2F;
	Sun, 18 Aug 2024 10:03:13 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
 linux@treblig.org, linuxppc-dev@lists.ozlabs.org, nysal@linux.ibm.com,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.11-2 tag
Date: Sun, 18 Aug 2024 10:03:11 +1000
Message-ID: <87r0ampuio.fsf@mail.lhotse>
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

Please pull some powerpc fixes for 6.11:

The following changes since commit de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed:

  Linux 6.11-rc2 (2024-08-04 13:50:53 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.11-2

for you to fetch changes up to 227bbaabe64b6f9cd98aa051454c1d4a194a8c6a:

  powerpc/topology: Check if a core is online (2024-08-13 10:32:17 +1000)

- ------------------------------------------------------------------
powerpc fixes for 6.11 #2

 - Fix crashes on 85xx with some configs since the recent hugepd rework.

 - Fix boot warning with hugepages and CONFIG_DEBUG_VIRTUAL on some platforms.

 - Don't enable offline cores when changing SMT modes, to match existing
   userspace behaviour.

Thanks to: Christophe Leroy, Dr. David Alan Gilbert, Guenter Roeck, Nysal Jan
K.A, Shrikanth Hegde, Thomas Gleixner, Tyrel Datwyler.

- ------------------------------------------------------------------
Christophe Leroy (2):
      powerpc/mm: Fix size of allocated PGDIR
      powerpc/mm: Fix boot warning with hugepages and CONFIG_DEBUG_VIRTUAL

Dr. David Alan Gilbert (1):
      soc: fsl: qbman: remove unused struct 'cgr_comp'

Nysal Jan K.A (2):
      cpu/SMT: Enable SMT only if a core is online
      powerpc/topology: Check if a core is online


 Documentation/ABI/testing/sysfs-devices-system-cpu |  3 ++-
 arch/powerpc/include/asm/topology.h                | 13 +++++++++++++
 arch/powerpc/kernel/setup-common.c                 |  1 +
 arch/powerpc/mm/init-common.c                      |  4 ++--
 arch/powerpc/mm/mem.c                              |  2 --
 drivers/soc/fsl/qbman/qman.c                       |  5 -----
 kernel/cpu.c                                       | 12 +++++++++++-
 7 files changed, 29 insertions(+), 11 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmbBOPQACgkQUevqPMjh
pYBHbRAAiC+nw/uRkmegLC601p+iVz80/GpzE3MwapPEZG1y38fTbFZBllRl9qsF
aZBsM6h8prUbMli00DjZo30nqxQQ0aHQo9Vl5Oo4MAu5Bhk4VwbwA6GkyVtrAjXF
aYeTrMsCAKngoHevyFn/7SLSfx8G+y3MK8VOtF3jA0KgW5JDNscBU3tDvt/A4iop
b5OUOv04C0CgZ1Hv90VxC2NOtMScqRn9PE9frSTGIO5nI5ZV7ufpjwrYWUBZVuPV
LWsR7AmK4hIqrd5wOxhVXyOqsf0swKZtF4/eQ5jA32Yh77cGi7tTuJjqS8vduhNx
9zaODA+EzjpnO/2Vgjf6FyOZeyh5x/DRXsBHzzCpCFdiCI4oYMVfutaCDKCAb1I4
9CRhQ+TXXFAziBkHiFZ+GcQyFxdjtNsnlf0dzm3fhVMYbz1apeLBVOYtuY6npLA0
l9udAlsdaxLrJs5VVT8ot85XKl8Hq2XTfBbtcqAO3TAz0JZJzLjK1V7+x3t5xOck
dYLDAl88Y7aOwfK7+eGTbJ9nEKS7jkln5YF6mLfy1tEJaa3j8fNXpiKm0e6s8qAl
1hsQH7FRQYqZ6vxfDuSqC6OTw1yY6UrJGrrEQY9W3d09agcAMMJwOSGvYQ4K32ja
uC1k3UgNq5L1HwbfD/I2iN4/9eGbGaTMYAvu8UkRaMnSek7pO60=
=2P31
-----END PGP SIGNATURE-----


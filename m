Return-Path: <linux-kernel+bounces-338384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECD4985727
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 12:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88F221C2140A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3112C15B559;
	Wed, 25 Sep 2024 10:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="PyLAOjHP"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C2E1B85DD
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 10:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727260215; cv=none; b=ixjZ+Kf2pOy0hfJxmxxTbLdQtA+PuCuFFsAEU2ZkA5jlPf12tBH9IXpGR9wJGBpRn4fLn8OcZIhH9ZzPWJq+8tBAkfj7ZCnpU0+XPHPm+NaZZ4oixfyZ2WrcGkzm3bR1M5MEFsJZQfID6w3m8wEANyzAqD8OECNwtl2YK5x5b44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727260215; c=relaxed/simple;
	bh=yHcbD2S80errCFFrzkXkg2EnB7WNmtfiXJ6D+8XL6jY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c5LICGdH7GlU6ydrqDU1KBu3hDsC1/V1PIY7phBnGyxcAwwnXjxZiNAHhWfLCTlU2Z6XkaVreWJieah4av7P/C40FLOhuBnq1GdZQZpr6ReJ+PbH8qCO3/cPXrKGpbuO44OYaoR70t6zXk9sRx7tQioe7j0ym4g6hjxoK3aPaX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=PyLAOjHP; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1727260208;
	bh=E4Bdh0fNaTtFYe9gHjWtFQgG3/q6LHFdqIPWSQ5Uy+A=;
	h=From:To:Cc:Subject:Date:From;
	b=PyLAOjHPpEPQxbS4uQKvbxrx0b0o3W1oDUQ6ZfSML3MpmrcUnwUOCmcFx4Gn6uidu
	 Che+rcMAvAYhPGZuoOHDRQNjUMid3rwiJSxCt0qaIXLh1aGCsTDV+Yvpco5jSLMO1Y
	 zWuW22vQBU7DXL/RRAR8KaxkXM31ly43NdRQJrkugaJtsOBVxlVyrmhGXbjohMDLdv
	 Lq1JhOxQ31qqRC9VANG8mG+1pIDhc52HL94FRU7riEfHx/FTuTISe5o87D8HGt2NRt
	 4yTfnEXpMX5z5mj0FLyoTUYgq6MW52MBChN9rqNSDynPDtsy6HF07GeDhJXWc9ruLy
	 gVVVf9tNtFqqQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XDCfS45klz4xGl;
	Wed, 25 Sep 2024 20:30:08 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, nnmlinux@linux.ibm.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.12-2 tag
Date: Wed, 25 Sep 2024 20:30:08 +1000
Message-ID: <87y13g10wf.fsf@mail.lhotse>
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

Please pull a couple of powerpc fixes for 6.12:

The following changes since commit 3a7101e9b27fe97240c2fd430c71e61262447dd1:

  Merge tag 'powerpc-6.12-1' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux (2024-09-19 08:03:00 +0200)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.12-2

for you to fetch changes up to 3af2e2f68cc6baf0a11f662d30b0bf981f77bfea:

  powerpc/pseries/eeh: move pseries_eeh_err_inject() outside CONFIG_DEBUG_FS block (2024-09-20 19:06:25 +1000)

- ------------------------------------------------------------------
powerpc fixes for 6.12 #2

 - Fix build error in vdso32 when building 64-bit with COMPAT=y and -Os.

 - Fix build error in pseries EEH when CONFIG_DEBUG_FS is not set.

Thanks to: Christophe Leroy, Narayana Murty N, Christian Zigotzky, Ritesh
Harjani.

- ------------------------------------------------------------------
Christophe Leroy (1):
      powerpc/vdso32: Fix use of crtsavres for PPC64

Narayana Murty N (1):
      powerpc/pseries/eeh: move pseries_eeh_err_inject() outside CONFIG_DEBUG_FS block


 arch/powerpc/kernel/eeh.c    | 198 ++++++++++----------
 arch/powerpc/lib/crtsavres.S |   2 +-
 2 files changed, 100 insertions(+), 100 deletions(-)
-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRjvi15rv0TSTaE+SIF0oADX8seIQUCZvPl5AAKCRAF0oADX8se
IXFDAP9VM7hzp0mbUtc4IgDC1yXVhIyeQnn4iZB99uplOl0rJQD+MAr+QY1YMS/d
8xE1RW8os//z8VJ+Kfq0JIWxKxqbrQw=
=Jokt
-----END PGP SIGNATURE-----


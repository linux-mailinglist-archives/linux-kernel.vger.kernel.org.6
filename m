Return-Path: <linux-kernel+bounces-321638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3F5971D58
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D27E61F21391
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCD91BAEDF;
	Mon,  9 Sep 2024 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="a3NruSw+"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763791BBBF0
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725893968; cv=none; b=GJ0QFOoN6UqFjEsxMyja9RnBLiaQCMQZ1tFlo73W8ld+PBjVDqoaspUk4cEDkfg6d9WCd5MzKvvBvJq5Vk6wInLZ/KdFjRNMCcXzz4aN5BOYx0ANsxlzOzwsLCM2u6PGq3Pom9LS0TqM2sBQsfr1d87O+QEOYGvUraHqgu8IpgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725893968; c=relaxed/simple;
	bh=Kh1ML38dVVQH393gCMC1hpdqtbkjDI3z9R1PecYdLhk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ChgcgkCAVO/gJl2e61caUAdojsXtQG4ss63xKm1yzfjML07xK/g4H4LA7kTYW3l18hAPI72NDPPxOhGA8mbiCjHF+UuQCT6+YjwuFEwEtvryTxfvhSkw6mPoekXC9A3WZg3DOTKahrzaIklZ6/eWeSOzZx3PHaT/aKUFi/pqCYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=a3NruSw+; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E140940E0185;
	Mon,  9 Sep 2024 14:59:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZYh8jnU8BETs; Mon,  9 Sep 2024 14:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1725893958; bh=7lTSxg9Hx3GUaqp8LnBp3+zAKrTOgl9B7+CLQYJhq68=;
	h=Date:From:To:Cc:Subject:From;
	b=a3NruSw+zTjqJyLwU7m2abvZ6wFB3+/UpL94liZwNUi2jjj184UUp7xiVB0N36rM2
	 /V8kLovsStEsO1yxV4ZP+HqQHNiWTdOnKLf8sFhmQUn4ADcle2i5vmNGAw6fQoaJMU
	 s1qKabmwO/XG5Zi2G+IQdu1ntS2TQeRBEZ5bc5guKR3ifoRX9DNWXYIqIsnCMf5jBB
	 VgWNbJ1FIJMwKtQPxW24Lb2cQ1Zk6aoDuDGNXD9MIkHEMJ1zWXy6s4miF/Vpjg3KKy
	 bY/wrzF0d1yPYQmNNj0P9DYjOSS0n49Hjor9PxeQr1pS8UECHdVPDoi4mhNj7iGbWc
	 RgrfcAryAmIqLHwZwWsH4niLgG7Cx8PzplSjWGhfgYZtWKWAy58IRpKRyiOOOOyAiI
	 GdvGH/V53b5pmMWaeWQXSMFOp+UK/yhZGx1fRotCrlinMw8D6XPKzMYXGm/k5C51yS
	 U/2jfQHGd3K6HGpxkZp2pZF6BxGHSCotSz4FqIokXM7hGHpzZgWmW+NzNmCoY4/Mtc
	 H8WsEOdcjomakLoD2K+TeFs+Aue3vf0NUEo9xlFKkcAWFKPbY+JERINr2UeFB7XAA6
	 o4VlHIHaLYJGvRSfnDO1W8w5yn+Un+DO7hojR2RddhmhNyOP62r6WMYHpQeqJZ6ZIm
	 14DeM7aXtRln8xdN7G4tasas=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 70D4340E0263;
	Mon,  9 Sep 2024 14:59:15 +0000 (UTC)
Date: Mon, 9 Sep 2024 16:59:08 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cpu for v6.12-rc1
Message-ID: <20240909145908.GAZt8NPCHCknkzaJBQ@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the x86/cpu lineup for v6.12-rc1.

Thx.

---

The following changes since commit c9f016e72b5cc7d4d68fac51f8e72c8c7a69c06e:

  Merge tag 'x86-urgent-2024-09-01' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2024-09-01 14:43:08 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_cpu_for_v6.12_rc1

for you to fetch changes up to db4001f9cc32e3ef105a4e4f492d7d813b28292a:

  x86/cpu/vfm: Delete all the *_FAM6_ CPU #defines (2024-09-04 18:11:08 +0200)

----------------------------------------------------------------
- Add the final conversions to the new Intel VFM CPU model matching macros
  which include the vendor and finally drop the old ones which hardcode family 6

----------------------------------------------------------------
Dave Hansen (1):
      x86/cpu/intel: Replace PAT erratum model/family magic numbers with symbolic IFM references

Tony Luck (3):
      extcon: axp288: Switch to new Intel CPU model defines
      x86/cpu/vfm: Delete X86_MATCH_INTEL_FAM6_MODEL[_STEPPING]() macros
      x86/cpu/vfm: Delete all the *_FAM6_ CPU #defines

 arch/x86/include/asm/cpu_device_id.h | 20 ---------
 arch/x86/include/asm/intel-family.h  | 87 ++----------------------------------
 arch/x86/kernel/cpu/intel.c          | 18 ++++----
 drivers/extcon/extcon-axp288.c       |  2 +-
 4 files changed, 15 insertions(+), 112 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


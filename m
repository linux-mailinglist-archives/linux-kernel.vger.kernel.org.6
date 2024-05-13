Return-Path: <linux-kernel+bounces-177497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 507538C3FB7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 13:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05B561F2388B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 11:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9175814C586;
	Mon, 13 May 2024 11:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="b3MKzT02"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF67B1487F4
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 11:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715599244; cv=none; b=Af2Qow3zK5Asn5d8k8lS2j1hJawTdogrRzNp0iWVVUpOgBWgpgi2VjKaVjJfHzMZxWgCKhKai5fGP1Fd6y9/vtl7duSOl5nf1IsARB4lI92pqXaf3uXoWhJJvH5/rcUymSYpiT6twteBHQ+50o/6FsjqHptm/tnweayj2gbi3es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715599244; c=relaxed/simple;
	bh=Ay8HaNODdtRU5tW7VXZZ7IB1i4BFsyqq9IPTZnp5Q/U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LIKS5XJ82H8gHPupd9L0B9AiBT9X9slkqP5UvZviMhLhop6GisQDYQdXD0HEQGfbE65FvXDuzOMjo0ol9a8cE6w6chwZxTd4d8htnjYr7nGLLnCpxSK/AHBb1swfDT9I+TVRVD6eKnIQwT2LUbyjVrxUhVkLEkoYqnw2gkj8PWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=b3MKzT02; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 79B8B40E0244;
	Mon, 13 May 2024 11:20:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kwrgBLOpZwbj; Mon, 13 May 2024 11:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715599235; bh=AhK3M4dhO0uFdeJRrlFeGVOqvcEf7r6V1Fc1ftCTcVM=;
	h=Date:From:To:Cc:Subject:From;
	b=b3MKzT02u6BDUE+PMiEoDP+xr6zvRNE6B2jusSQCB2F6UJuJ+m/+hRAnXGsjXgDh7
	 9MgN2mIT9DUqAUFcneBCj+OgzasjmNypUixpc1zXDcGD4XV0uBRT92VOy7Di0DUK20
	 0GL5ge0y9UyPizSLHKG1IwQhBbHyE304+VPiL8N+g8MlsiqoQxt3NRp/mHJ1UZpZf3
	 g9B3K51LmdWsxdzxL4FnkOMj5BNe32GM0k3aDpbJHuFL3xGogzx/xeJGzYHZ7Bnt/j
	 R3o9+XRtVy9tDadzzwM/wMFiQYBekZ+tD26KwHKSkF6zh69tJWBpFMEk198rUtIat8
	 En1V4Q8YAG7xomXZC4ue8+iNVdzeDLcnYvliPTf6tRhgfLnckEjQVG5EqzxGJqOJWE
	 gNTxFHwovl+JGdrUxcQOkZj2IYD8Ev9QdYTzmEZV1+oU81qliWlpfD3OO8TK3FxGDK
	 8DzpBjeLfsPPurL4tBy3uropiKwzx92UC+YEc8Tp/tjLO5o5Q+eGhYtskEhQGe0gnL
	 zm0XZaTjP5LOZOGzIrCYyIoMlYXRNsMnJgzVu1aGy1SN4+oSSIOZCFIgkI5zWh5fUN
	 op3ynBWpirSqrYXIQi1IV/5SRxMZ6BCSWEbRkR0gxj+yi7EH89Sh93N/GwsZGjT07d
	 bbdXwc1+3rwKO7Zw2uBIwe8c=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4DDEB40E0192;
	Mon, 13 May 2024 11:20:32 +0000 (UTC)
Date: Mon, 13 May 2024 13:20:26 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] RAS update for v6.10-rc1
Message-ID: <20240513112018.GAZkH3coU6jUY3LE0s@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a single RAS update for v6.10-rc1.

Thx.

---

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip ras_core_for_v6.10_rc1

for you to fetch changes up to 108c6494bdf1dfeaefc0a506e2f471aa92fafdd6:

  x86/mce: Dynamically size space for machine check records (2024-03-26 12:40:42 +0100)

----------------------------------------------------------------
- Change the fixed-size buffer for MCE records to a dynamically sized
  one based on the number of CPUs present in the system

----------------------------------------------------------------
Tony Luck (1):
      x86/mce: Dynamically size space for machine check records

 arch/x86/kernel/cpu/mce/genpool.c | 40 ++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


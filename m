Return-Path: <linux-kernel+bounces-177928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 951178C4654
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6A8F1C23413
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F49C24B2A;
	Mon, 13 May 2024 17:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YkracBHs"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18202263A
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 17:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715622060; cv=none; b=XMJhjM5LObm5nDNs/ScCUlx63krsuDc/YQmHyjqEUDHeoPam7xamVwnDILDB6xGrkqLuKByyOPCumiY8g799mjod5oK5eUXS0+B3X5SiqOMlbKcuhRV+0zqQjvGbZhWvrPGQPz2NkC1/ecNxn7ZZ1Si6GEWrIbY6kVnqpxJedB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715622060; c=relaxed/simple;
	bh=/L1/jnpE8b7+f3OHM4BP1SRT75MT3adXNsbtj+5NpW4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mwIcXUSj1+U7B4j4PDqXooQ2tCFiBxi942SxNbrGUiMaVKawEdiWVOQCiKUszwck4g/1j115aXv/CWUF6IdWSCqElKMLBVqPCeB2qKm9i+v9Mpyx0eBH6RnzqhW0G6yQVWbRhCeTrdoHj0udNGn0r5eFClRm8ads7+vh+PYb6Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=YkracBHs; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B31B140E0244;
	Mon, 13 May 2024 17:40:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id g74zZVoWWEGB; Mon, 13 May 2024 17:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715622051; bh=SF3hHmxLdQeF695Adkz40wb9aj7fiE1oJ7frwWYgGXo=;
	h=Date:From:To:Cc:Subject:From;
	b=YkracBHsf4Y0RjACVIknJfECEA3v+lMK5CY1xL9BVHTm5aX7XyTY5UUWvsOPttJQl
	 qVNtd0bmTbbMnY2/22wR2dgqECjPmBefPEKluktaZMq6Xb+fyM/1yChEXdJadUWmKb
	 wEGSgT5xbHmbtZSTud7bFxF7OkAXabwY5KnnruLhUqaAdjcCsycp142zR4OrLvQyCc
	 Tm+3+uyl6ulrLroS9WVY5H2zaDYXSRERfzZwQcjlAthINIPW7gJ4lNgIBc+LzhgaxP
	 Xj9DsqDjSoMAerHQfBKWK+jkszGy+k2GZwU/YNFHSrqOwlD+8VPwbmqWBQ6NqGzq4l
	 HTqN8Yp21CpBCC8SPyx0qry02CY6fbM9HYMdQeCijZmIeOP5aTub38c8QlWa+Emowz
	 KFuqH2OEU9QHGRaU6Gt+ftW4+7T2NhBAsgPPkBgzvKsBUlk24j5PyQ/yvaak/ORA6E
	 hCnzNuSdLSKy3nbru890N2NT2YzGAWCyfozuZdBja1AE56Y43JcquRzN5yhYJgklSS
	 39WiX8PzKCWpydHbNI0GB1PNDfckV/12Pb3tyR9isCoayM5mbcWkCZLvVsum9anXjf
	 NV9q+CaGmLwp2CsivXUdR+kRBXybG8J7ddVEqSyb3Fz+l8X5rRjzFObR5A/x4ByOG8
	 nzLGECMIZNBRvgDfiEx9BgGk=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 37FFB40E01A3;
	Mon, 13 May 2024 17:40:48 +0000 (UTC)
Date: Mon, 13 May 2024 19:40:42 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/alternatives for v6.10-rc1
Message-ID: <20240513174042.GAZkJQmuIGCVEfYCrg@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull x86/alternatives for v6.10-rc1.

You might encounter an easy peasy merge conflict which you can resolve
by simply zapping alternative_input_2(), i.e., what

  8dc8b02d707e ("x86/alternatives: Remove alternative_input_2()")

does.

Thx.

---

The following changes since commit fec50db7033ea478773b159e0e2efb135270e3b7:

  Linux 6.9-rc3 (2024-04-07 13:22:46 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip x86_alternatives_for_v6.10_rc1

for you to fetch changes up to 8dc8b02d707ee4167fffaf3a97003bcdac282876:

  x86/alternatives: Remove alternative_input_2() (2024-05-06 14:30:54 +0200)

----------------------------------------------------------------
- Switch the in-place instruction patching which lead to at least one weird bug
  with 32-bit guests, seeing stale instruction bytes, to one working on
  a buffer, like the rest of the alternatives code does

- Add a long overdue check to the X86_FEATURE flag modifying functions to warn
  when former get changed in a non-compatible way after alternatives have been
  patched because those changes will be already wrong

- Other cleanups

----------------------------------------------------------------
Borislav Petkov (AMD) (6):
      x86/alternatives: Catch late X86_FEATURE modifiers
      x86/alternatives: Use a temporary buffer when optimizing NOPs
      x86/alternatives: Get rid of __optimize_nops()
      x86/alternatives: Optimize optimize_nops()
      x86/alternatives: Sort local vars in apply_alternatives()
      x86/alternatives: Remove alternative_input_2()

 arch/x86/include/asm/alternative.h   |  14 ----
 arch/x86/include/asm/cpufeature.h    |   8 ++-
 arch/x86/include/asm/text-patching.h |   2 +-
 arch/x86/kernel/alternative.c        | 133 +++++++++++++++--------------------
 arch/x86/kernel/callthunks.c         |   9 +--
 arch/x86/kernel/cpu/cpuid-deps.c     |   3 +
 6 files changed, 71 insertions(+), 98 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


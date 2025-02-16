Return-Path: <linux-kernel+bounces-516538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBC7A373AC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 10:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51A501891D34
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 09:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD58918C93C;
	Sun, 16 Feb 2025 09:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Sv9AKbn0"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0FD290F
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 09:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739699598; cv=none; b=UhfZybwHExOvG10swvVVJzStfBNoH27Hdj6i5nHm7NH6aweug3Lr9Odc7vz6f+vHLsfdNAMVfCTHWakAR91fBHxxt+wBCACYuHMN3tVoWRTNNpczmqcGO0Xp8O05r7bbXRMz5f6WW61xOqRrZ16zQ/gM/7LDa8gmQN1DnG+9QGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739699598; c=relaxed/simple;
	bh=GRW9dLjDH4bhTt2UkYPP8YghJ8vtA0i+/uf8xl5bGdw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=n+3CCXeC0/Ia3hObCPZYx9jloUCUoJSl4v94BT70fDdl8S7/CXOqo6ohDv6flEqfzqE0KiVtWxK4wEE2R4tJztdaIvVD7ISIqhoZNt+vt7QIBPXpZJAKPqKtzEMnWi5pBhsmKeuCW1sRBNiZlmk83zTzzfxPhGCiHJsG+qYTkus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Sv9AKbn0; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 16B6140E0191;
	Sun, 16 Feb 2025 09:53:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rLNWiU24pLQa; Sun, 16 Feb 2025 09:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739699591; bh=L29Whz40E2Hp+lMhdhUfZf4f6lJh4LRv2sCzmO3G4kE=;
	h=Date:From:To:Cc:Subject:From;
	b=Sv9AKbn0A4vweDCCus30qnLd/fOwzhS0tT/irXeYwQjJ4BEcGeCQhSay61T1MaXHm
	 dM8JG7dxtOwzZRpZqKXX2wZjzBHotqZx6hBIksYZKEiaiQ17qpyuwOW1ySIZhVqPRI
	 BIu3yc35fnXp69zi2uK/mHonXGsZJWwBUXuPJp3j/0591Th+FrbWhPYOjsuewFTffN
	 UJPSAX695g4cvlyFNzXIj5LxNdr3h3a5oAwtsyQuxRtDCfu3N+0yFncXgnaxinq0pR
	 nUIIoD6hLCK8bMUdKmbqfY7zTLUyfU7zfqzK/5zJ6mgdPmRU7/DX0pvVbxbTPfTK+6
	 qx3CDN5QctsrfmJb+qtsy8OOZ0BbGA+2BYVNE9v/9bixn0TdEBE1UrkoGNX/lguHdV
	 kKKa9hSOJr0KOWbwm+jhClCHg+FrQvOrtGADYBk9Cr7T2bK/v0d0eelkooVaGELyFU
	 JVTe0Q6FnALJP+NUnhG9HAsleR4yRWFoyPpb20FA3wYTdOJda4mf5APxpRpIBwzdrJ
	 6jRTEhnveG/MCy1C9FjlptG7XFOVhEtVBVCO+2V5fI+tTUDLIXtoswOoYYnWhVjoBV
	 n+Do4hKvRMRIahTyJpDtrHddx39GM6YHksKmghk8ipFkF6VHneW8+GFSyCWdSvuMss
	 oT/p181sqSVi7VKZf0Ls1ldQ=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 58CB740E016A;
	Sun, 16 Feb 2025 09:53:08 +0000 (UTC)
Date: Sun, 16 Feb 2025 10:53:07 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] irq/urgent for v6.14-rc3
Message-ID: <20250216095307.GAZ7G1g8jr0xW0nGus@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull an urgent irq fix for v6.14-rc3.

Thx.

---

The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:

  Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/irq_urgent_for_v6.14_rc3

for you to fetch changes up to 4cf7d58620bfc2ebe934e3dfa97208f13f14ab8b:

  genirq: Remove unused CONFIG_GENERIC_PENDING_IRQ_CHIPFLAGS (2025-02-13 13:18:54 +0100)

----------------------------------------------------------------
- Remove an unused config item GENERIC_PENDING_IRQ_CHIPFLAGS

----------------------------------------------------------------
Anup Patel (1):
      genirq: Remove unused CONFIG_GENERIC_PENDING_IRQ_CHIPFLAGS

 kernel/irq/Kconfig | 4 ----
 1 file changed, 4 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


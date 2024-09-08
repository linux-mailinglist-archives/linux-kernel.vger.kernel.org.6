Return-Path: <linux-kernel+bounces-320082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A565D9705F3
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 11:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF5A21C20E58
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 09:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F0113A243;
	Sun,  8 Sep 2024 09:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="G34ucoZp"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1894D8D1
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 09:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725786495; cv=none; b=d9L4nQoyoHmd8vDa6qJc2iYrmL9tLGpfbmVfp2FMolY2V7+b0taJ+Mw94QSJHmcgk/w3G6ay4r3Bpoo+4A7yCT3Ox1bLOSFWpO4izXP8Qc74dBjnROc5oZYXoOpRIkkzlezrFeckCtbbUq4NdANDPSH46kggN4c2MOhXfTEU/pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725786495; c=relaxed/simple;
	bh=Vx6OgGzAgcl39R/q/+TloQpXfOERdKStw/RVMW6JK8o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qLgUzOmNgCFHeNTqMCWfXv8cB/Tdq3GfoqLDJWuxQ+NIvdpSUVRW7Jst4PBOqtGHI9iQiW4IW8xOeG4Wk8+ulyik/YFI4BlnFCf/ShEl+q8M10abb0ytqixXqKrNaRiaXfX6077IigAnmqNdBwX8bFdlcJ2LTh55NGVqEqs0dvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=G34ucoZp; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D222A40E0191;
	Sun,  8 Sep 2024 09:08:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IaY92hsLoZ_J; Sun,  8 Sep 2024 09:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1725786483; bh=rXaVuXgeGyVpDxKu+vpW4fnh5LVfuVYwtBwelt5oGPM=;
	h=Date:From:To:Cc:Subject:From;
	b=G34ucoZp9BpqUtGtGxCX5ZAa9H/UYFRLFbirTPel68QYzXcwVcMoT/FkTyFmzuudN
	 PtLfEyX32ScF+XkaHCzZ4HFdIC5bgK18zk3WfMtM0jYMlJ4CKiV4pbSnpZiZ1yVzw0
	 d1ZmRnvITYtMMfXYMEuctT01z+6pe4ao8Df7Mh6pnL2mL7zEk+79v+qnU+8eR0gVD3
	 Bnb+FOEaUk0faR6G7hyU/B8oPmzqjZRWsUolCHYW0lNxPI6uHenhmuEOD8I33p7Dox
	 MX8BDX+XIKoLo8rOvGjgCFXzFislvBTrEdX/DVi06G4nO08gCbtPkhdqLUfKkzTwi3
	 v2BHWxrzx3tdR0aa8ZR8Iwk9l7qd7zeOoSaXMVeUjGCM9a+rwi5GHg9oLcvmswN33/
	 iO3RveN3/2EA0rvFMHF03AT7k6g5Lr7F7vImjkZQpAOYZrX9PAWQAbBLcpbFWi6nvv
	 p/Pdwf4L0ZoZlFv15oT6D6vUXM1Mh0RArnd4gwxxOckI3d63Y0NK4jrvIgwA7/WFed
	 nHlcEV+RwK2r/89bI9HfvmDH11AIoBQBgbSkRPKXXyZcYuY7kmEjVDQr/OIu3XWGKb
	 II54hQ81Rb7YV4nMEpLOXGI1ScS6Yvm6gErt/27Qfcroow9Mma1lji5Ml6QEQTGAkm
	 tB7ML+/uEfWYqz8aMVM1u9U0=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A26A140E0198;
	Sun,  8 Sep 2024 09:08:00 +0000 (UTC)
Date: Sun, 8 Sep 2024 11:07:59 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] perf/urgent for v6.11-rc7
Message-ID: <20240908090759.GAZt1pb1NBL9QiXEq7@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull two urgent perf fixes for v6.11-rc7.

Thx.

---

The following changes since commit 25dfc9e357af8aed1ca79b318a73f2c59c1f0b2b:

  perf/x86/intel: Limit the period on Haswell (2024-08-25 16:49:05 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/perf_urgent_for_v6.11_rc7

for you to fetch changes up to 2ab9d830262c132ab5db2f571003d80850d56b2a:

  perf/aux: Fix AUX buffer serialization (2024-09-04 18:22:56 +0200)

----------------------------------------------------------------
- Fix perf's AUX buffer serialization

- Prevent uninitialized struct members in perf's uprobes handling

----------------------------------------------------------------
Peter Zijlstra (1):
      perf/aux: Fix AUX buffer serialization

Sven Schnelle (1):
      uprobes: Use kzalloc to allocate xol area

 kernel/events/core.c        | 18 ++++++++++++------
 kernel/events/internal.h    |  1 +
 kernel/events/ring_buffer.c |  2 ++
 kernel/events/uprobes.c     |  3 +--
 4 files changed, 16 insertions(+), 8 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


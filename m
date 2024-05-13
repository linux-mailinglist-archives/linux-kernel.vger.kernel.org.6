Return-Path: <linux-kernel+bounces-178014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 326328C4772
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 21:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0DCD2861BE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673314F1F8;
	Mon, 13 May 2024 19:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fNBtvkzY"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193FC4500D
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 19:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715628052; cv=none; b=dz+nE63G/N+4BU2YuCBXloU/pMbs96KeNaYuRcvyGba0uLOr5K0boEHZDJB4iq84yvjIl1BvRYewZ25Fj6D/2+ConpyjZxxUfHZ/lmQvm8Oq4D+pHe45EcmL8+YM/YRUU6w3pMtqjPdFO9F2OsRdtwNcwT0O3NRWCwsqR+Prv4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715628052; c=relaxed/simple;
	bh=TBNGFx+pj2pAtcMer7pWoKfjGxHWEeFo1r28Q0LhWv8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FwQzk9WetNW/FZ4ulKE1lWnySP092NY81XbSq9j6sODCMkNk6U9lcCmpJWAT8XdR5lcGxLrlTXDpPIapO3st+n4asx3efWV3ufT8IxtbV27M1AV8JSJO4Zud9Gu6OekxgJmgjY7lvmm/+IIanNPEIt4nsPPz0azIqFyywHX3XiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fNBtvkzY; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 10B3640E01A3;
	Mon, 13 May 2024 19:20:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KFh6YC0mW6Fu; Mon, 13 May 2024 19:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715628044; bh=Wla0UPNg81vHXnYPrg4pW0qRmPcq6SX+nvkQyAI752Q=;
	h=Date:From:To:Cc:Subject:From;
	b=fNBtvkzY5UNpiWfWk/R4OigxhGZEyaXKJuq1I+Siyre/ij4hEVZwN+DuPfjbgAMvD
	 TBLlCK2pGbgXoEQ90AX0JIxbZeDAj6R+R56KNdFshLuObM619Nl7U/eRhadC206aXS
	 8jz/k3iN+r7t5CsU9o57lT5y3F4Q9BXu7YzkTLkeSLROQFImwQgohdPIHtUCHsWpPn
	 18s0ve6M+IGd+VF8T5H4AwqkHQ86UZiU7Bx8G9NKPwz9PGBgNrZL3TN/mI38bh4xUo
	 9qgMk+hMh9bRHpEQ8kHp5fRZDObGAFz3rZZRx1rKQHppq6/wzD4YYMLeJZcII+fZGV
	 mQn5A+6c6mlttuLS2JPgKHSbBHuDIPYSJ7yrXA6a9GJ9Er8RJWQ4H34nvWNgcK4PyT
	 bamCd3kFy1HNYyebRmXS9muH82o2d8vYQdO5bC4Xe4mR29lEVs8Y/+BOS7se5EaQp8
	 xK2fbSz8/6Q419+KLIwgVBMH5PBuF0JKD5h6w4axSR0rYAJhFFeY9Fld1MrPkFFXEq
	 oLrIY/qlgxRCKIkq+G5F19Amv0JJeYsByEZHSAs8Pz8c2b4ylX1nfRiWl3WRBr8Xnq
	 c+nXtJ/ZoJ299QMZLbDlDhwOb9E1fHZ8FCGeJY55X60/xJGiix0msI8MNtMh4pUKgC
	 RjAYLWEPb7YeVTUAHzGPylFM=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4C5C840E016A;
	Mon, 13 May 2024 19:20:41 +0000 (UTC)
Date: Mon, 13 May 2024 21:20:35 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/microcode for v6.10-rc1
Message-ID: <20240513192035.GAZkJoA5i9naOdgz7_@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a couple of x86/microcode cleanups for v6.10-rc1.

Thx.

---

The following changes since commit 39cd87c4eb2b893354f3b850f916353f2658ae6f:

  Linux 6.9-rc2 (2024-03-31 14:32:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip x86_microcode_for_v6.10_rc1

for you to fetch changes up to 57f6d0aed7b0a6829044c7f1cea57b1e3ddb9a47:

  x86/microcode: Remove unused struct cpu_info_ctx (2024-05-06 11:00:57 +0200)

----------------------------------------------------------------
- Fix a clang-15 build warning and other cleanups

----------------------------------------------------------------
Arnd Bergmann (1):
      x86/microcode/AMD: Avoid -Wformat warning with clang-15

Borislav Petkov (AMD) (1):
      x86/microcode/AMD: Remove unused PATCH_MAX_SIZE macro

Dr. David Alan Gilbert (1):
      x86/microcode: Remove unused struct cpu_info_ctx

 arch/x86/kernel/cpu/microcode/amd.c  | 4 +---
 arch/x86/kernel/cpu/microcode/core.c | 5 -----
 2 files changed, 1 insertion(+), 8 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


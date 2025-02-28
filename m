Return-Path: <linux-kernel+bounces-539267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A05A4A2A4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 719DD1899806
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C801C54BF;
	Fri, 28 Feb 2025 19:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxzCP8bl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115D11AB52D
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740770726; cv=none; b=YJanoT/wrDYQdSBm/u4i2JrN7J8RYyqjTSaU6CDGWQjrsCp07utAmuBo1VuBs3LK+dkSgrdIwdZqjQOFkRWx9vamazX3mkRE/xRDpSxgJrsC4AF4hywmU3zuNVY6pSmlWa2gL1n9oPp4UpsEiMuckpUZjWvM1PevautUBsibM8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740770726; c=relaxed/simple;
	bh=/iGExK7c6V0AQuhwMvvuYfbXHAp/eaGtvLFgA7/VFeo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IDW9qo7Gs1B3k6EgjHirxL7JMkB384obI7FDYta3U3EgK4CRw3g/6Cr3rT4M/OZRyCPU4QFr9DnyEmsdgHp/wAi2usR0LnDi3i7cvLKXKFtXHh6bbOtyMJa7lzFrxQBfcEql/VHZjiVTBxEKsirxWGDLym8sLLFGzUFCfiGvl7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxzCP8bl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97936C4CED6;
	Fri, 28 Feb 2025 19:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740770725;
	bh=/iGExK7c6V0AQuhwMvvuYfbXHAp/eaGtvLFgA7/VFeo=;
	h=Date:From:To:Cc:Subject:From;
	b=AxzCP8blQDcwFMm0Q/kPiDeIzwPN01nGjbJHfoSrvJmkTHWIxoCkhdT6LmmRZfDns
	 GWY6GCu2XD8Xpwk+F9xfolDaBabKPyYIHBoAznX359uFLWtJ2ruQvD8E5XW63X2rIP
	 eUccy9JrBflImYsJVYhPu5kj0Tqh3d+JBVbIly+0yFx9DXhSW4bWnxYKYJCR3+jNjw
	 dJWfdV5fzs8qRf4a1c1xISHzJNpC3MWux7uOO9r7GKxdiJSf8DHK/Di3mNCnrujrUr
	 jUxf+oshgbQEm9HxpVm2bfizp/v89bEuAU3zhQ7lJJDKP31ydDeTn3ZFsAZXbyGX1r
	 BblCY/aTOS76A==
Date: Fri, 28 Feb 2025 20:25:14 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Tony Luck <tony.luck@intel.com>
Subject: [GIT PULL] x86 fixes
Message-ID: <Z8INmgpEYAFPMef_@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2025-02-28

   # HEAD: 0f6750b15ffdf274668b12824b09bd49ea854e18 x86/entry: Fix kernel-doc warning

Miscellaneous x86 fixes:

 - Fix conflicts between devicetree and ACPI SMP discovery & setup
 - Fix a warm-boot lockup on AMD SC1100 SoC systems
 - Fix a W=1 build warning related to x86 IRQ trace event setup
 - Fix a kernel-doc warning

 Thanks,

	Ingo

------------------>
Arnd Bergmann (1):
      x86/irq: Define trace events conditionally

Daniel Sneddon (1):
      x86/entry: Fix kernel-doc warning

Dmytro Maluka (1):
      x86/of: Don't use DTB for SMP setup if ACPI is enabled

Russell Senior (1):
      x86/CPU: Fix warm boot hang regression on AMD SC1100 SoC systems


 arch/x86/entry/common.c      | 1 +
 arch/x86/kernel/cpu/cyrix.c  | 4 ++--
 arch/x86/kernel/devicetree.c | 3 ++-
 arch/x86/kernel/irq.c        | 2 ++
 4 files changed, 7 insertions(+), 3 deletions(-)


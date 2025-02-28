Return-Path: <linux-kernel+bounces-539251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 893D2A4A273
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67CD8188F184
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF52C1F872A;
	Fri, 28 Feb 2025 19:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUCWplPE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198921ADC8C
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740769734; cv=none; b=A7NTpn/kdSJfJrj/GbGRZUhfyUWPHh4OYkoa/qWkA86m3gnKcg95BIPhAMFac18l8a8ELkEMfvVFQN/4JrqHXq5cuZC/YYtMi4UvRhRKrqDcQggNMwoh8qEci9pdP13MgBUzGO6VPgktilL06X6Kv50Jz6621vj5rWm97diq+sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740769734; c=relaxed/simple;
	bh=Kb2hdxm/Zjz+YD63WEuXjA2oClC/omYoCQR8WBWzkK8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZcTn8gkAc1yjBdCdLdbadYjX4Zvn5LtSiFNoXw3uSt3hVuI6Yug0jcTVGNzKn63Vh26gmbggicCUibBpKCO7ANINUkblUwJt4vaipEB4CGoPce/ThcF2jyZasUhbWM0JXc2AXXAZSt0lyVViUHB1Z5pudAWtzLfYas5d/EBPRaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUCWplPE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC081C4CED6;
	Fri, 28 Feb 2025 19:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740769732;
	bh=Kb2hdxm/Zjz+YD63WEuXjA2oClC/omYoCQR8WBWzkK8=;
	h=Date:From:To:Cc:Subject:From;
	b=ZUCWplPEFF6L9hiXY/kTMwtox8yGaY1PGFT80HBf5AUIhCJFTICqWI4rpA0d6VoTq
	 XVLXuJtmoPfVfR0VJboe3c+3iQXaIvaoPQA5DLHU+Dmrz1tuBFB9InyOW1mh035o8Y
	 hhKBcRF2uTPAs+4hCOL4RD/ZYlT9kMaLaxfKSH5CUIXyyTDUYuJlAZJSeIyVyOjJiM
	 P4mkl5/zadjZ5Jar+ROTNzy5jXoyNf4AM3FcVTLEZBb8/sxOiaHLTY9BhuO4heX/rY
	 esiJpyZFSxXpg17NwTacAhUu6OWm89JuXIzQZgaLNCtMj3Vw4uCXBMxcuT9yuIpgaH
	 r4vMiCfio5LCA==
Date: Fri, 28 Feb 2025 20:08:40 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [GIT PULL] objtool fixes
Message-ID: <Z8IJuFbHZVoe8joF@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest objtool/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2025-02-28

   # HEAD: b4ae43b053537ec28f430c0ddb9b916ab296dbe5 objtool: Add bch2_trans_unlocked_or_in_restart_error() to bcachefs noreturns

Fix an objtool false positive, and objtool related
build warnings that happens on PIE-enabled architectures
such as LoongArch.

 Thanks,

	Ingo

------------------>
Ard Biesheuvel (2):
      vmlinux.lds: Ensure that const vars with relocations are mapped R/O
      objtool: Fix C jump table annotations for Clang

Youling Tang (1):
      objtool: Add bch2_trans_unlocked_or_in_restart_error() to bcachefs noreturns


 include/asm-generic/vmlinux.lds.h       | 2 +-
 include/linux/compiler.h                | 2 +-
 tools/objtool/check.c                   | 7 ++++---
 tools/objtool/include/objtool/special.h | 2 +-
 tools/objtool/noreturns.h               | 2 +-
 5 files changed, 8 insertions(+), 7 deletions(-)


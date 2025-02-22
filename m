Return-Path: <linux-kernel+bounces-527254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEEEA408DE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 15:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1449E19C4AF2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 14:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACC714A095;
	Sat, 22 Feb 2025 14:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkJogeE6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90D42CCDB
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 14:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740233252; cv=none; b=O3fo+1QOUxntlmyOEvlyDX1u5A+pyEoRXuZxjgck7H0bVBVTncf0oCp8XxVXdWRwRVdA0LlLDI9K8hFNxC68G6OJ4Sy2U8IcnoulriCzVmpiF1n+Jh57Zmmp/Vu2Q4bbo1b8pOGuAdjHcgtPrm5aLJ8KorKoEp95uKEot7iF9sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740233252; c=relaxed/simple;
	bh=nE92ptBfc/AIw7gYV6MhCk9fekWsK03AbRBKlDoI/a0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=P+lTzigLO4F7/UxqeOvbJ9xmU23ZQi9NyUMxd4/twILq16YjznFeCy3Y/drtebdgXCgPItHLirukSzZkUqzsKXGBsVWX8G80501/iB8WQ1hhtaiXo2XvRIpbdwFKH7x18+SZCnm08C7XpR0Ec8h1k1AlrIJ8erQ5xAruMaTM87E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkJogeE6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB8CC4CED1;
	Sat, 22 Feb 2025 14:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740233251;
	bh=nE92ptBfc/AIw7gYV6MhCk9fekWsK03AbRBKlDoI/a0=;
	h=Date:From:To:Cc:Subject:From;
	b=bkJogeE6XiLRypNYN4PCbuEItLAKH5NgNqaGJJZtvG5GN1EzQmTK3IP8QU5arFi3q
	 zFbt3rGoQSN14d8jdHLnlFfFeuRwnuHc5nH0QDLk4N/ws3ryh2RtXHlkiUu7PDorR4
	 f5g0WkycjlEAMz5BTAhzJ37ustGYpkRb0axR0QIsJxSewTDN44TFkbmMMhIXpyt9iG
	 TujjFikPkUbksVxvRSIxumoU3mtWKtXyr5gZ8HHS24w9Ha6DbkxOD8TwiG2tyGqp3G
	 dQlZ88VbMRWqDvjfNI+cF0nWMt8V+zLWzRZD0VqrX0U0JZi9/pDfCYf+TEJLs+sm89
	 YXlc+7wKxJ7yA==
Date: Sat, 22 Feb 2025 15:07:20 +0100
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
Message-ID: <Z7naGFRn755UP0Ke@gmail.com>
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

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2025-02-22

   # HEAD: c9876cdb3ac4dcdf3c710ff02094165982e2a557 docs: arch/x86/sva: Fix two grammar errors under Background and FAQ

Miscellaneous x86 fixes:

 - Fix AVX-VNNI CPU feature dependency bug triggered via
   the 'noxsave' boot option

 - Fix typos in the SVA documentation

 - Add Tony Luck as RDT co-maintainer and remove Fenghua Yu

 Thanks,

	Ingo

------------------>
Brian Ochoa (1):
      docs: arch/x86/sva: Fix two grammar errors under Background and FAQ

Eric Biggers (1):
      x86/cpufeatures: Make AVX-VNNI depend on AVX

Fenghua Yu (1):
      MAINTAINERS: Change maintainer for RDT


 Documentation/arch/x86/sva.rst   | 4 ++--
 MAINTAINERS                      | 2 +-
 arch/x86/kernel/cpu/cpuid-deps.c | 1 +
 3 files changed, 4 insertions(+), 3 deletions(-)


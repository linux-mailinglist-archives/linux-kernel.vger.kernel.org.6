Return-Path: <linux-kernel+bounces-412099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A16689D03DA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 13:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59EC91F21953
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 12:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E6618E373;
	Sun, 17 Nov 2024 12:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="eGd9t9xK"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861461803A
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 12:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731847053; cv=none; b=s1XD7E2aUoNlKMPinN98fsFXObW0SWie8Ly5Tafjn33QzTMA3msI1nq3vpuwMUG3NEiLnHGmr63ya4DWjeAcjCycY5MLD+o6HsGYbS8EN8b5bYaDHY9bSQClzkuT4zqg6BvBQED2OANka9flbhe/iUmXu7v2LKIzv1pI1Gr/knY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731847053; c=relaxed/simple;
	bh=S893wIxUCVDSun7pHzH4xyeFlhHTdIfEzSfWqq9qXrU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lhzH9eeJeSWohdMEDlAsrZss41PREBKA7jMiWKTcXst2jQSutd18hisfESbgyh73cqTgIYzh2YYmC1yVN5/fVH99iWcsGMO7+f+emPMTffulaAK3oQacWreHv84fS6oI+f0hhaGEQ/xxrHFVA98F4MZ6Y5TA7nQmy432iNQ8hac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=eGd9t9xK; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9F95540E0263;
	Sun, 17 Nov 2024 12:37:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id F8f0csi1frr2; Sun, 17 Nov 2024 12:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1731847042; bh=39TkJ0PCXkHanY7+TVYgvBT/uNL7HtlkDZKaPcgOTAY=;
	h=Date:From:To:Cc:Subject:From;
	b=eGd9t9xKDXj2RHemLy6W4L6Jd+s4YGMOed8VVNZl8idJBs8TrWRBvWZQV9eEr17lp
	 2D7Xu2LAeOyfjqaYFhbQZ7yZknNlEDN8xpt5PmLDmdiwXW3k0kCynspgOzMkPnxAIM
	 Ma/32LSd4aBeKe5FYXHTXKqzyGXVdtuTKN67JW5vPUOJBbE968IJdCqivRkfShilSa
	 Sp83aPZ8l2TNZCLn3BoaH9i+NW0FlEIzdxj977smb9XYziZMOmRfUJVb711HY3I9Ej
	 yKJXqCZGilKY/c9wjKX9o7+SywO+0Kh7J7F5uhwofmBwSNH7iAu9Y6D5wCLVo9sbII
	 WQlvJUrURPx2vu+OPzlCihP9Pq+27k4zD2eQIpmClyak0ykjdCQqbcB7bOaivYQkfM
	 02s2Yol5EsLDLpwoTWiy9uSrksZMPj8JnRddIGNkEXRJPLj8tXO4gsQT6Mu33O2mbt
	 GhPXuJ0mlpfwN7Nqqe8IsVp3fZP1LV1bMkAJ9vkMTjj9FUKA0ZNHCtRhOC9yuHWoef
	 rbdVY/OAXn3pxcSOabuxNZvWiEiCOnidk9cE25s7zmYyf6oB5iAd7g2FeU+S30pEP/
	 vIC54Zh0/riQg8++/j8z0P1ndf3BhZExXL7nUKAT4KqhvQ9kFYQ8pe/z76GDv/N/rK
	 y3i/iJxyQLsz9ewvVr3HY2uI=
Received: from zn.tnic (pd9530b86.dip0.t-ipconnect.de [217.83.11.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 318F440E0208;
	Sun, 17 Nov 2024 12:37:19 +0000 (UTC)
Date: Sun, 17 Nov 2024 13:37:10 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v6.12
Message-ID: <20241117123710.GAZznjdtizJgrgwx1I@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the final set of x86/urgent fixes for v6.12.

Thx.

---

The following changes since commit 59b723cd2adbac2a34fc8e12c74ae26ae45bf230:

  Linux 6.12-rc6 (2024-11-03 14:05:52 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.12

for you to fetch changes up to 8d9ffb2fe65a6c4ef114e8d4f947958a12751bbe:

  x86/mm: Fix a kdump kernel failure on SME system when CONFIG_IMA_KEXEC=y (2024-11-13 14:11:33 +0100)

----------------------------------------------------------------
- Make sure a kdump kernel with CONFIG_IMA_KEXEC enabled and booted on an AMD
  SME enabled hardware properly decrypts the ima_kexec buffer information
  passed to it from the previous kernel

- Fix building the kernel with Clang where a non-TLS definition of the stack
  protector guard cookie leads to bogus code generation

- Clear a wrongly advertised virtualized VMLOAD/VMSAVE feature flag on some
  Zen4 client systems as those insns are not supported on client

----------------------------------------------------------------
Ard Biesheuvel (1):
      x86/stackprotector: Work around strict Clang TLS symbol requirements

Baoquan He (1):
      x86/mm: Fix a kdump kernel failure on SME system when CONFIG_IMA_KEXEC=y

Mario Limonciello (1):
      x86/CPU/AMD: Clear virtualized VMLOAD/VMSAVE on Zen4 client

 arch/x86/Makefile                     |  5 +++--
 arch/x86/entry/entry.S                | 16 ++++++++++++++++
 arch/x86/include/asm/asm-prototypes.h |  3 +++
 arch/x86/kernel/cpu/amd.c             | 11 +++++++++++
 arch/x86/kernel/cpu/common.c          |  2 ++
 arch/x86/kernel/vmlinux.lds.S         |  3 +++
 arch/x86/mm/ioremap.c                 |  6 ++++--
 7 files changed, 42 insertions(+), 4 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


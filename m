Return-Path: <linux-kernel+bounces-436323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 259019E846B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 10:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F7C7164B2D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 09:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE29F13665A;
	Sun,  8 Dec 2024 09:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Hvygz083"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EB31B960
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 09:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733651191; cv=none; b=MQ/NaQc64yase8fUr8e6JUt+iBEKC/MP1FptRQ+7RnZeYge0MUQVZTx/bckoeZ1twvwK6b0/SH8sy7p0w/1VC0PTBw9+JVIoU7gh6aOgmPORIsPzc69gJNRaBIf+mR6JoNpAGmq6QXiPXxnM5/ujZIhTsTUYxNaCwaLZNZXJkcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733651191; c=relaxed/simple;
	bh=dUYve6hl3rq9Of1rXDQiekJ3alH6cfwg6ArvrugVJFc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DYDgxycM38v/Sx9jBUCjNFpcfFmK5yGGUXJiwX6ldKVUkk0RIQB0O1xOlZwJ9XBGXGdQZjFDnxDoouiAgSqn6za1ZyjpEA6O0IdK4JOxnL+Ie+1YaUY98Bw5aoo1KXKxR0Oys+flnF0NHhObRmbqEEIlP5LI+Yc4WVvHOCpiOpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Hvygz083; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6DFA840E0269;
	Sun,  8 Dec 2024 09:46:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dy7LhcOyzDSS; Sun,  8 Dec 2024 09:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1733651179; bh=XKcGqxGq6SjQhbibaJBji1LMhup8Yj3bKWtma4RJQ/U=;
	h=Date:From:To:Cc:Subject:From;
	b=Hvygz083I1pOxeZLl/cCHbA7mkgqSjjut73mzcd5MLF2vk5H7N8Q17PVTm19MqDJs
	 PJsOvU+SXnyhCu0pPYZyi3KD2OjXILfsLxxdBlWvhmlM8XxgvBBUZl5mCdfrhgK01y
	 S2Bq55NT8NgTXYzTg9PiSV8aPVLHFcttnWY5ZAkMbuNxF2XkgfCWaObOoDOhkPoDYq
	 9ivUbo93vkXsUtJH5afdWErlL6hq2ppAg5CXRk+fEAGvJUWVeAQJ0Evk8CO/V6/XNi
	 5GWo14Ws0iRnl7yOdcmuygng6ovBlJTMJTVP3C2axypSF4gXQeiZjUF3Xc44gBJZHm
	 QKkVu4V+SP3rpemZou7N8sPzVtLOlgT1G9lJs9Juy8ehv7AVcjPPrfSvHDXyz1uL7z
	 iK/3wymdUFqlOg8b1quOG+DU+yrOVgmEc0BkTfAJhZZ9rbsQnCA03LEvXGBlb5O05n
	 pYLLyFbmqjUZROlUco7C+L2lR62OzfiS8e0P1ugEFu+NOAYWrJprtjDqj3oz9J+Hon
	 v2PSRZIa3sT+d7Pf5cT76PgGRV5bIeNgSS//6r7GK44t6kho+1RUKhQOwUxd/Hs+cQ
	 rkjObtWcwuCz6At7XeyN2nQmZXYVzVszlHokLZeO5c2VelanH+CwTOO+iaLYA/4ID9
	 7KRMoAuMJMb3IxnbXTZRonJU=
Received: from zn.tnic (p200300eA971F9358329C23fFfea6A903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:9358:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7933140E0266;
	Sun,  8 Dec 2024 09:46:16 +0000 (UTC)
Date: Sun, 8 Dec 2024 10:46:08 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v6.13-rc2
Message-ID: <20241208094608.GAZ1Vq4FKYipqWZ5Th@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the x86/urgent lineup for v6.13-rc2.

Thx.

---

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.13_rc2

for you to fetch changes up to 492077668fb453b8b16c842fcf3fafc2ebc190e9:

  x86/CPU/AMD: WARN when setting EFER.AUTOIBRS if and only if the WRMSR fails (2024-12-06 19:57:05 +0100)

----------------------------------------------------------------
- Have the Automatic IBRS setting check on AMD does not falsely fire in
  the guest when it has been set already on the host

- Make sure cacheinfo structures memory is allocated to address a boot NULL
  ptr dereference on Intel Meteor Lake which has different numbers of subleafs
  in its CPUID(4) leaf

- Take care of the GDT restoring on the kexec path too, as expected by
  the kernel

- Make sure SMP is not disabled when IO-APIC is disabled on the kernel
  cmdline

- Add a PGD flag _PAGE_NOPTISHADOW to instruct machinery not to propagate
  changes to the kernelmode page tables, to the user portion, in PTI

- Mark Intel Lunar Lake as affected by an issue where MONITOR wakeups can get
  lost and thus user-visible delays happen

- Make sure PKRU is properly restored with XRSTOR on AMD after a PRKU write of
  0 (WRPKRU) which will mark PKRU in its init state and thus lose the
  actual buffer

----------------------------------------------------------------
Aruna Ramakrishna (2):
      x86/pkeys: Change caller of update_pkru_in_sigframe()
      x86/pkeys: Ensure updated PKRU value is XRSTOR'd

David Woodhouse (2):
      x86/mm: Add _PAGE_NOPTISHADOW bit to avoid updating userspace page tables
      x86/kexec: Restore GDT on return from ::preserve_context kexec

Fernando Fernandez Mancera (1):
      x86/cpu/topology: Remove limit of CPUs due to disabled IO/APIC

Len Brown (1):
      x86/cpu: Add Lunar Lake to list of CPUs with a broken MONITOR implementation

Ricardo Neri (2):
      cacheinfo: Allocate memory during CPU hotplug if not done from the primary CPU
      x86/cacheinfo: Delete global num_cache_leaves

Sean Christopherson (1):
      x86/CPU/AMD: WARN when setting EFER.AUTOIBRS if and only if the WRMSR fails

 arch/x86/include/asm/pgtable_types.h |  8 +++++--
 arch/x86/kernel/cpu/amd.c            |  2 +-
 arch/x86/kernel/cpu/cacheinfo.c      | 43 ++++++++++++++++++------------------
 arch/x86/kernel/cpu/intel.c          |  4 +++-
 arch/x86/kernel/cpu/topology.c       |  6 ++---
 arch/x86/kernel/fpu/signal.c         | 20 ++---------------
 arch/x86/kernel/fpu/xstate.h         | 27 +++++++++++++++++++++-
 arch/x86/kernel/relocate_kernel_64.S |  7 ++++++
 arch/x86/mm/ident_map.c              |  6 ++---
 arch/x86/mm/pti.c                    |  2 +-
 drivers/base/cacheinfo.c             | 14 +++++++-----
 11 files changed, 81 insertions(+), 58 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


Return-Path: <linux-kernel+bounces-413198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DE99D14F9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06B812815F6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEEA1BD007;
	Mon, 18 Nov 2024 16:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PNKBHiB2"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EA0199EBB
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 16:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945849; cv=none; b=sCJWh+pGdKYsbD9/lcCzzSj0XPrXvDbccUI/yoMFhnTXWXeU+rTSNZtsUHqrVSFN/NsQlboaw5mqucbbS5QDnp3Rr3lfC5GftepIroU0twoIzmJJIHbZVz3pZuX4GphinDASJvMsCd2YxHrkirKSb4uDd2zrKBa9J4te3vEVsco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945849; c=relaxed/simple;
	bh=UNwvC7+JQW+t38JLVdpNSvOICUT6xwl2Dw7cw0XyIxw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZcVf/Sdspaa3bfZmcVdE4qJ/QzMShOsW7FZFOVSaoSLgN7SrIaI8cxrIaUhL9+rN0CJxl+YA2NnzMkoYV1jx5SPTrREY32JBppQR3CnpcdcKkT31NfxqqTVVX/dsN8ShsvBNC9z6Phaimat0BkOXxsPlUOMq1cZpr9uYBtE5Eds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PNKBHiB2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CF60340E021C;
	Mon, 18 Nov 2024 16:04:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id u6YCgIoVhhUy; Mon, 18 Nov 2024 16:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1731945840; bh=9vBz61TnIEUPx/fZ7hGYJ7Mz0Fi/X6ghV01dIXJ5kYk=;
	h=Date:From:To:Cc:Subject:From;
	b=PNKBHiB2a845C2HArYP5GlO1trmO9eJ3rZmLf0FzkP5pxJZ0Hq/IAMoEZDNL5uK68
	 u+D0slis3G/RI8P8KvJK2Xh+wtUSE9bHZFGrlWl9HRPruBuubv/ryBWSIElF2U4yy/
	 PXDWq7P1JjknLVPx6twrxwVc9ptJ9gQ89WKeBgbjmq+1xJtAuYdr+19nv/zxwuxC83
	 EAlFHU54cPPssWiOiQGt3TP5rvZLxLFcc8jLpsyBuHi8pPPGX28tJFvrIarl0rHV6d
	 XZ9jEwpPysggfOsB+q7dwBkzjstJXuND8AjMNcDt3BYhyrZrwPAJcYXzEb6IkJKjCS
	 0GE37M2bZv11fWOAI3qcZ6sS6IKpaTh+DpoQVM2RujaU49oa5Td4kfDWIW672QHEqH
	 UPy6M5NMTUW8622oztFlNg9ynCJLWf3wZOg7jMUyg6whVhmSDD8cDQZUDzYplPARy4
	 HkiA/jKTkjvg7/V6yW/MLhgGHBGaa6cjtqkjjh/A3O0gQ6nEYI5o4h/o8SvhA6pZ+n
	 gVvRNWUn1EmQ6qUCdGQogdPxR21foOhwnxkI6hixIQ7K1Vz3Glw3sCqxX5TchfGEBO
	 nQVZtJNqxZ5afLg8ghvb/87cRL7EfUFXXWMf/7TAmmvhVb5LOizXTsAUSQX16VL0Ow
	 guxAc6Pd5FnTeUxnJy3Ak9es=
Received: from zn.tnic (pd9530b86.dip0.t-ipconnect.de [217.83.11.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5449140E015F;
	Mon, 18 Nov 2024 16:03:57 +0000 (UTC)
Date: Mon, 18 Nov 2024 17:03:51 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/sev for v6.13
Message-ID: <20241118160351.GAZztlZxg0V5LMzeUq@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the SEV lineup for v6.13.

Thx.

---

The following changes since commit 8e929cb546ee42c9a61d24fae60605e9e3192354:

  Linux 6.12-rc3 (2024-10-13 14:33:32 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_sev_for_v6.13

for you to fetch changes up to 8bca85cc1eb72e21a3544ab32e546a819d8674ca:

  x86/sev: Cleanup vc_handle_msr() (2024-11-07 12:10:01 +0100)

----------------------------------------------------------------
- Do the proper memory conversion of guest memory in order to be able to kexec
  kernels in SNP guests along with other adjustments and cleanups to that
  effect

- Start converting and moving functionality from the sev-guest driver into
  core code with the purpose of supporting the secure TSC SNP feature where
  the hypervisor cannot influence the TSC exposed to the guest anymore

- Add a "nosnp" cmdline option in order to be able to disable SNP support in
  the hypervisor and thus free-up resources which are not going to be used

- Cleanups

----------------------------------------------------------------
Ashish Kalra (3):
      x86/boot: Skip video memory access in the decompressor for SEV-ES/SNP
      x86/mm: Refactor __set_clr_pte_enc()
      x86/sev: Convert shared memory back to private on kexec

Borislav Petkov (AMD) (1):
      x86/sev: Cleanup vc_handle_msr()

Nikunj A Dadhania (6):
      virt: sev-guest: Use AES GCM crypto library
      x86/sev: Handle failures from snp_init()
      x86/sev: Cache the secrets page address
      virt: sev-guest: Consolidate SNP guest messaging parameters to a struct
      virt: sev-guest: Reduce the scope of SNP command mutex
      virt: sev-guest: Carve out SNP message context structure

Pavan Kumar Paluri (2):
      x86/virt: Move SEV-specific parsing into arch/x86/virt/svm
      x86/virt: Provide "nosnp" boot option for sev kernel command line

 Documentation/arch/x86/x86_64/boot-options.rst |   5 +
 arch/x86/boot/compressed/misc.c                |  15 +
 arch/x86/coco/sev/core.c                       | 269 ++++++++++------
 arch/x86/include/asm/sev-common.h              |  27 ++
 arch/x86/include/asm/sev.h                     |  67 +++-
 arch/x86/mm/mem_encrypt_amd.c                  |  77 +++--
 arch/x86/mm/mem_encrypt_identity.c             |  11 +-
 arch/x86/virt/svm/Makefile                     |   1 +
 arch/x86/virt/svm/cmdline.c                    |  45 +++
 drivers/virt/coco/sev-guest/Kconfig            |   4 +-
 drivers/virt/coco/sev-guest/sev-guest.c        | 416 ++++++++++---------------
 11 files changed, 543 insertions(+), 394 deletions(-)
 create mode 100644 arch/x86/virt/svm/cmdline.c


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


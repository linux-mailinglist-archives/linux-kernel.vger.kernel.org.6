Return-Path: <linux-kernel+bounces-383558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F58A9B1D4A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 11:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4755A281A86
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 10:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921A414389F;
	Sun, 27 Oct 2024 10:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kkDGZwxX"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59E53BBC5
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 10:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730026692; cv=none; b=m/N4tH4l37uictjSdEEWFCjyUousYlXvTJkir+bp7WSKCNVLlU7nIQAIaZzxtp2UPr8DWZfIxuYC927ycOnzmTIzo6IyyU8MCBZh3hIt4SD5URLJYyMi8ZbvE91P9yyopm6+Ju03R6uVID+8qYV2qAVIzCUoVriGC2Lca7GtImc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730026692; c=relaxed/simple;
	bh=TAqnak62CxsU5fwfWN4e/426CubKkio1XUmDfxD7LjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VZnUHOpKRa6Y27oG6klSsP3Yx5I3R3h+yzHx6Ron7W8mhzdhsM3NBNWgW4uwg9lIYE/aStdwMAWCxQldzacH+n97voppimCMPJ0ZU5jg9usL0Ou7zga3EDU6GG1NA9dCcVypmYnCxnVNkCWcJHYD+Kvz/SFNyt3dQFYtRH1YxQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kkDGZwxX; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8BF9C40E0192;
	Sun, 27 Oct 2024 10:57:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NdnTJqdfcyN3; Sun, 27 Oct 2024 10:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730026675; bh=NNUoBBKMpKtZJZhfRFXbhgHAYPHOD/93KKMLNF8yXEQ=;
	h=Date:From:To:Cc:Subject:From;
	b=kkDGZwxXhBkFAcNa5Lcu+tEDIwJvUoMgM00dHx6mrQ3qmxg9mI+jomhosA0k0QgBU
	 FvbAoaLHkcWMl/qjaaakVN1dRC4Go1XjmZ89N3wvDjA9rOoCnkr8uK0rMrjLoKTC8S
	 a4Ud0Yi5Ns4mzytff5fSlbIIZMqDdLBC2M9e/UQSbkPOEBljXcBt7rjgqMVDlTHyNT
	 GT0yu2wlc8NCk0VAvLLq0Z3rdWXByTwTnyrol/gZ7rWyWuO7jlpoZQcJkwbYHgRWXu
	 G9D1wwp+r5iwvMFkZk4mItTIOXfZufSyQC0S4+hGtPDKvRBX4RG6Rn5SjUu+vhTjzV
	 DT1uQwiuVAVHI5BxxV6iukPgRv6Ffiw8z0q+uRUP3beVFuTfKduNE6QfK3gAAfxz0z
	 6PTeSvZDXRfZBEYDklbCbVQfHBpJVqAMngCsFxlyftALNSpXArmzKvYiS9eD9MfydI
	 KSzgwqF24uUfcr102ZHmESIYNlAUEXgMrccyn/68DiZwcOd1T11IVKr+Km7yfcsOw6
	 5T1fNhiIiwtMSnkkGEbSisats57MjZeaU0zXSIcMFHQgv98izR0IRmlIY0Os0nCbH9
	 1r15gyXYe7bOnhuJkdZWNS/i+zDiN7R0spjGUuJ1kqx7FwOnNIlK9elsZh7ClF+yof
	 4N11yj2/cYlIjqOaFO8x2AOI=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3050A40E0219;
	Sun, 27 Oct 2024 10:57:52 +0000 (UTC)
Date: Sun, 27 Oct 2024 11:57:41 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v6.12-rc5
Message-ID: <20241027105741.GAZx4cpWYuun5QaU8K@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the x86/urgent lineup for v6.12-rc5.

Thx.

---

The following changes since commit ffd95846c6ec6cf1f93da411ea10d504036cab42:

  x86/apic: Always explicitly disarm TSC-deadline timer (2024-10-15 05:45:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.12_rc5

for you to fetch changes up to 88a921aa3c6b006160d6a46a231b8b32227e8196:

  x86/sev: Ensure that RMP table fixups are reserved (2024-10-23 12:34:06 +0200)

----------------------------------------------------------------
- Prevent a certain range of pages which get marked as hypervisor-only, to get
  allocated to a CoCo (SNP) guest which cannot use them and thus fail booting

- Fix the microcode loader on AMD to pay attention to the stepping of a patch
  and to handle the case where a BIOS config option splits the machine into
  logical NUMA nodes per L3 cache slice

- Disable LAM from being built by default due to security concerns of
  a various kind

----------------------------------------------------------------
Ashish Kalra (1):
      x86/sev: Ensure that RMP table fixups are reserved

Borislav Petkov (AMD) (2):
      x86/microcode/AMD: Pay attention to the stepping dynamically
      x86/microcode/AMD: Split load_microcode_amd()

Pawan Gupta (1):
      x86/lam: Disable ADDRESS_MASKING in most cases

 arch/x86/Kconfig                    |  1 +
 arch/x86/kernel/cpu/microcode/amd.c | 51 +++++++++++++++++++++++++------------
 arch/x86/virt/svm/sev.c             |  2 ++
 3 files changed, 38 insertions(+), 16 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


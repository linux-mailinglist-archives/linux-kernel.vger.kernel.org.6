Return-Path: <linux-kernel+bounces-235130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A79E91D086
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 10:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24E0A281D40
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 08:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B8012C475;
	Sun, 30 Jun 2024 08:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JeUOSxbd"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7261812C474
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 08:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719735923; cv=none; b=CTNUrZcjWbXaNUUmveg7NqjdErsyJ9g+8vkEktALqmTGcsOulEC3stnvsJZMYC8eEVZFkd72NEWYLMUf8LegXYqWZpiVdrMqUoAu8SlufMGFq7qMsqsGGufeSlbihvJCfyav0JKjnmCm6ufUWQ8FzlvhCwUcxp2nLN17Cbaz/1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719735923; c=relaxed/simple;
	bh=ZRvJXSC6w8X02Xb9KptFL1thczL5JN55FA3WUW5Ns64=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BicRdkdrgxzlsNeZ1LVrbdq4cghxDkDwcg0zv1WkEtCchKibDNlyxvJFQova4g6ENeR+bSM4q4UmEzbBsNNIIEgk8fXarVMUtdeABb14B0C5e9rrAlkiuHWKA4KAfTkh+tB6hhmGztW1EqcH8ORqq0Sb89DFdvvoGNj4t5qTzDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JeUOSxbd; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1D76940E021B;
	Sun, 30 Jun 2024 08:25:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gX6jNmEA3pGy; Sun, 30 Jun 2024 08:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719735916; bh=LETWBp6ehYzID/DjSY2kxHGGv5hqpNuqQSs0pbZk+DE=;
	h=Date:From:To:Cc:Subject:From;
	b=JeUOSxbdhKbVhJiPVA9QvnFer6eQXKXrWwpKVEgIG0GxC/HsVUkzakjxkkzuNKXXU
	 o7fLmHqeYM158V0YjXJRZZxCzjMA8vaEC3S7Mx+KKzym4j0Y/suCtvMORizR15iJJ8
	 NCaTBas6vBuF44feg0h22uOXPVTMWVGBBCXCvXXRTh2OANrGBxUVeYII49UmHWFue4
	 suB34ePypz444gNjNwrC1REQDwXHDWt2ptgZl6xf1e//NwcsMEqSI7Q/iaudf3PFFk
	 bkULqdXdRXE3t/4dHL75FLysfC2fzZ6A+VcmdtWuAaLpDYW/drnlqtf5ftm/eXnCj3
	 xLw66bZlsuIC2IWCWPTN69TxWTEkt0uVG81q7mnPAaH9sQitIEmJmxP7GfqH3A/Qqr
	 Qwb5ylpZCUYF8uoXOjkkeHQ/sARU4GFwWrKv88KOKZ7gJS7gzzkRjcdIjC+MdlErv+
	 93ZfAH00wQuYRZN8w4aG7NDKAe5qpL3ls+8vKGfYxAunWSZwlTkoxsbCA5hYRA3Fgr
	 BnlDaAgiHT7+8FteeV61VNuj3SsZD5Zac5LqxmZ0h2UpzoFYZZxejFLUGJ1OPqpyK8
	 T5nUWVuct+chO28Q+VFiacR9aEbeM9Ks2kwjgUR1JyptMVf+d1Yq+/+fnECAa5d3wC
	 z7/XcV4i5UB9e1nt3VLKYr10=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 115CF40E0177;
	Sun, 30 Jun 2024 08:25:13 +0000 (UTC)
Date: Sun, 30 Jun 2024 10:25:12 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] irq/urgent for v6.10-rc6
Message-ID: <20240630082512.GAZoEWaIpE4ma790Gd@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a couple of urgent IRQs fixes for v6.10-rc6.

Thx.

---

The following changes since commit 6ba59ff4227927d3a8530fc2973b80e94b54d58f:

  Linux 6.10-rc4 (2024-06-16 13:40:16 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/irq_urgent_for_v6.10_rc6

for you to fetch changes up to 9eee5330656bf92f51cb1f09b2dc9f8cf975b3d1:

  PCI/MSI: Fix UAF in msi_capability_init (2024-06-24 23:33:38 +0200)

----------------------------------------------------------------
 - Make sure multi-bridge machines get all eiointc interrupt controllers
   initialized even if the number of CPUs has been limited by a cmdline param

 - Make sure interrupt lines on liointc hw are configured properly even when
   interrupt routing changes

 - Avoid use-after-free in the error path of the MSI init code

----------------------------------------------------------------
Huacai Chen (2):
      irqchip/loongson-eiointc: Use early_cpu_to_node() instead of cpu_to_node()
      irqchip/loongson-liointc: Set different ISRs for different cores

Mostafa Saleh (1):
      PCI/MSI: Fix UAF in msi_capability_init

 drivers/irqchip/irq-loongson-eiointc.c |  5 +++--
 drivers/irqchip/irq-loongson-liointc.c |  4 ++--
 drivers/pci/msi/msi.c                  | 10 ++++++++--
 3 files changed, 13 insertions(+), 6 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


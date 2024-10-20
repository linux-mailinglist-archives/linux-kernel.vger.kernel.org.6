Return-Path: <linux-kernel+bounces-373199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 805219A53AD
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 13:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 331971F22545
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 11:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E72E18E028;
	Sun, 20 Oct 2024 11:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="VdPBURVn"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D740E4C7D
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 11:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729423294; cv=none; b=CcSwTupSWEYZpkE/+HqjG8snMd13FdeGZxLb5FGeU5b2nCp/f46vjYukYNlt4Lv5OSeTPpTJhvU3254PwTYhYQ78YxctTjLW0fsNJG1DpAjbKRPTVi4eqL25M+QaNjvtZXC0dZftsC0S2LTndIUFMffvOHeSC3idkwfi3vjxnsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729423294; c=relaxed/simple;
	bh=Uqhjvq1TgmJNVOTsPhhKMnmKRRZ83kNaCkvseEoagHw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VOX+aHEvk/U3nVKhlzPEbadiUoyKaV6RLKD5JtQpRnRP5ka23o5EogKu9E7Elhvx8TQLLN37sRH9NKEDEBfIxWmtdWNzmYAjk5Rz/x24/DiwhtRifq7gXwybPw1dtktf8xvCvFemcMDfOYfrJ+9p1djADFwKrnibEMjhjAutlco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=VdPBURVn; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C3EC640E0263;
	Sun, 20 Oct 2024 11:21:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ayGyx7LWfDLm; Sun, 20 Oct 2024 11:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729423285; bh=qrjnOmqJeHut2eVYFnRu9TsuTvP8zfsQxmHGMWM3zkk=;
	h=Date:From:To:Cc:Subject:From;
	b=VdPBURVnLVi9ZZuCu0/VYTDpNFUGyNtcSun+I1TmmCwZI4hVxqk3hO+2Si9y8JZH/
	 Y1DqCwDvwyll8Jd+4R+NKAiUorwlvUKbQUUQWsYpXh8AcR/HenNaTRpX5lS6eDS4jT
	 /SSH4Ab5PYSUspP47fWGgi7R9f/GOJ7JPtENNhH/jqMDZ2b8mRZ/wX67YoNOzWqK2O
	 au3rhYaetQysINHLv1AeX3o3Kp/gLLW6CAlEU5kXicMde1zNzSi0MIRWegmgcdFxV/
	 dtqeuDnx2uyQJ1Wr3xdKrIeLOBlmBGrcehHUw3ZfKt7/qPfNCNyl6FXwAlHsM6hImF
	 dQZfpH4LrmR5f61X/jZze7/KmuAgcdG2T4Xq9WPwTJKN/QBxcOQqFU4gWEZMNOk3oh
	 JxGj+kzZURBY1LDoLJ9uAcX2YzdcBHT3yz2EFGrlgXv/GmCC5CelYVF353i6YN8GO9
	 bCuS0WFC9Lyvry9/uxP8Mypmm63/0UeiUt8wa5dm0u2qIejTEmDqAvW92SwueVtMDZ
	 3hpCHDvJBJCj4ue6MDLriH5cIZN2RRWSABqPKahCUPQDYJn0XYN7xFyieFLLLU7oaL
	 RxFquQ4AgXv5n0sPeMlN9IT7gcvmw3wfifrDIyZysvSfwtEIWcdSNpNoBMQoQsGhLT
	 +n2DsS0CI6IRMqfRhpSZFIv0=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 75B6340E0184;
	Sun, 20 Oct 2024 11:21:22 +0000 (UTC)
Date: Sun, 20 Oct 2024 13:21:10 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] irq/urgent for v6.12-rc4
Message-ID: <20241020112110.GAZxTnpjXjwKgF12oZ@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the irq/urgent lineup for v6.12-rc4.

Thx.

---

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/irq_urgent_for_v6.12_rc4

for you to fetch changes up to d038109ac1c6bf619473dda03a16a6de58170f7f:

  irqchip/renesas-rzg2l: Fix missing put_device (2024-10-15 23:54:35 +0200)

----------------------------------------------------------------
- Fix a case for sifive-plic where an interrupt gets disabled *and* masked and
  remains masked when it gets reenabled later

- Plug a small race in GIC-v4 where userspace can force an affinity change of
  a virtual CPU (vPE) in its unmapping path

- Do not mix the two sets of ocelot irqchip's registers in the mask
  calculation of the main interrupt sticky register

- Other smaller fixlets and cleanups

----------------------------------------------------------------
Andrew Jones (1):
      irqchip/riscv-imsic: Fix output text of base address

Charlie Jenkins (1):
      irqchip/sifive-plic: Return error code on failure

Fabrizio Castro (1):
      irqchip/renesas-rzg2l: Fix missing put_device

Lukas Bulwahn (1):
      irqchip: Remove obsolete config ARM_GIC_V3_ITS_PCI

Marc Zyngier (1):
      irqchip/gic-v4: Don't allow a VMOVP on a dying VPE

Nam Cao (1):
      irqchip/sifive-plic: Unmask interrupt in plic_irq_enable()

Sergey Matsievskiy (2):
      irqchip/ocelot: Fix trigger register address
      irqchip/ocelot: Comment sticky register clearing code

Sunil V L (1):
      irqchip/riscv-intc: Fix SMP=n boot with ACPI

 drivers/irqchip/Kconfig                    |  7 -------
 drivers/irqchip/irq-gic-v3-its.c           | 18 ++++++++++++------
 drivers/irqchip/irq-mscc-ocelot.c          | 10 ++++++++--
 drivers/irqchip/irq-renesas-rzg2l.c        | 16 ++++++++++++++--
 drivers/irqchip/irq-riscv-imsic-platform.c |  2 +-
 drivers/irqchip/irq-riscv-intc.c           | 19 ++++++++++++++++++-
 drivers/irqchip/irq-sifive-plic.c          | 29 +++++++++++++++++------------
 include/linux/irqchip/arm-gic-v4.h         |  4 +++-
 8 files changed, 73 insertions(+), 32 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


Return-Path: <linux-kernel+bounces-426584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2470F9DF54B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 11:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44B62811CE
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 10:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642FE136E09;
	Sun,  1 Dec 2024 10:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TyftiEbI"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337F05474C
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 10:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733050181; cv=none; b=BqvcugcpDr6RgRcI899JHWjuuwHuJfOCWUNeUAtZsJmWCOaqcxpXP2kawDBDt04ES7c6ezGoDULuLktCz4hStcohhcTlegsZeh+rIv8gEw5X4EWuUBkYv/+xmNPdJ+CpfQUdejz2vGQw+A7NNzHyFL0BMeE0U4gtooUyy9+Q07M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733050181; c=relaxed/simple;
	bh=fanVCjvB6xm75b5qDjouJClt+u3OMJ5Ee77jGiMr6mE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sEqNFdJerV7NlJ9nxnDO+5foeGYJpIF79uXBn8UoSvbvGW6QXy6qHloEOSX/QM9R4dKxTFSVJ/WxpQVC/nFHXldnJSZtcCA7Osw0Mb8t+N749q3131BigZ45P1GR3fbZF96u1lf2fc7PN4TxOlYZuOQuMbRT8/jjg4OAjQShoKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TyftiEbI; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AB30C40E01A2;
	Sun,  1 Dec 2024 10:49:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id uCRjvvviIS3Y; Sun,  1 Dec 2024 10:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1733050172; bh=b64U7B2PODDiOVIQmQ4Z9pVW7NFX1ld/vWQ1JfVc0yw=;
	h=Date:From:To:Cc:Subject:From;
	b=TyftiEbInDn3BPNRsHTu04GwCBZpD9fNpQYUZyo6J/PUjeVSLLgB2zZgWXJUjXYaY
	 TSemICk02A2uej5PVGxZEmSbkHwvjIKyJsPvsjG3sg/uvG03NC4DK5v+TQhxjdCblD
	 YTs62sPS6AdXOfqEjQhMcCuJ11LJtwdCTgy7vgu1QT8jQykLWQKNEyEnZYhQ5hDa5k
	 RcExo0UJaufecD/8kw7O30Q6dHcfOF3iPz35Z8AQlrtdR0/iQYFZx+jYvtdABVI/Z5
	 dXjy9MTbrzBvGtScGaTK2pZfLP/bkIyMsE0vYQ0BY2eMz3g5J8OHTpCFlSWpByJtvE
	 TpixXXd8PiiLrfbM97hADCTgbiHY7vVEtgh127cSIs3EOY+CDM8l8sM48XtjWSigHy
	 5YY+B9U+s6e2PBDcf+CpoYyTTWgunA+t0BsyuYdtsk/4DfyFPK60JuQUANz9uRuC8A
	 IqFVXf3rKLtixvBZtSmrjaHkIQ1yuBJjZVPbkOPeJKlfvgGYmLGL2OuPcRulDlKeGK
	 QIfxHiraupnFvDGpuNzteHTGdcrb2XDjFESGk4OPJbpe72czbeG9jpDKLOPWLwpe2q
	 6DfNM7ilDpu5XE0OfGi1+IlyxGtGoe+neD/2wmCHR3pUNU9l6oDJTHGvu5Ou6qfCeW
	 tRyZrGbw/+Z0GevPy4jGti+Q=
Received: from zn.tnic (pd9530b86.dip0.t-ipconnect.de [217.83.11.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4F4AF40E0196;
	Sun,  1 Dec 2024 10:49:29 +0000 (UTC)
Date: Sun, 1 Dec 2024 11:49:21 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v6.13-rc1
Message-ID: <20241201104921.GAZ0w_Mev3hhUdkHHr@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the x86/urgent lineup for v6.13-rc1.

Thx.

---

The following changes since commit be4202228e685d580d75ac7597c0e7e50a63dd6c:

  Merge tag 'x86_tdx_for_6.13-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2024-11-22 13:07:19 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.13_rc1

for you to fetch changes up to ff6cdc407f4179748f4673c39b0921503199a0ad:

  x86/CPU/AMD: Terminate the erratum_1386_microcode array (2024-11-26 15:12:00 +0100)

----------------------------------------------------------------
- Add a terminating zero end-element to the array describing AMD CPUs affected
  by erratum 1386 so that the matching loop actually terminates instead of
  going off into the weeds

- Update the boot protocol documentation to mention the fact that the
  preferred address to load the kernel to is considered in the relocatable
  kernel case too

- Flush the memory buffer containing the microcode patch after applying
  microcode on AMD Zen1 and Zen2, to avoid unnecessary slowdowns

- Make sure the PPIN CPU feature flag is cleared on all CPUs if PPIN has been
  disabled

----------------------------------------------------------------
Andy Shevchenko (1):
      x86/Documentation: Update algo in init_size description of boot protocol

Borislav Petkov (AMD) (2):
      x86/mm: Carve out INVLPG inline asm for use by others
      x86/microcode/AMD: Flush patch buffer mapping after application

Sebastian Andrzej Siewior (1):
      x86/CPU/AMD: Terminate the erratum_1386_microcode array

Tony Luck (1):
      x86/cpu: Fix PPIN initialization

 Documentation/arch/x86/boot.rst     | 17 +++++++++++++----
 arch/x86/include/asm/tlb.h          |  4 ++++
 arch/x86/kernel/cpu/amd.c           |  1 +
 arch/x86/kernel/cpu/common.c        |  2 +-
 arch/x86/kernel/cpu/microcode/amd.c | 25 ++++++++++++++++++++-----
 arch/x86/mm/tlb.c                   |  3 ++-
 6 files changed, 41 insertions(+), 11 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


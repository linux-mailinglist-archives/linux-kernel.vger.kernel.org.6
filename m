Return-Path: <linux-kernel+bounces-321658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C3E971DB9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 984401F23FD8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E851CD0C;
	Mon,  9 Sep 2024 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Q3p6bf7I"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8D3210EC
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 15:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894837; cv=none; b=UJgRJPO+pAZnki3MvZbpp02Xi8IuBkACrH4EaqJ4YncsBbuTSa7Xt7K2kYggZzjcx2b3CyUKyLBySaSOa+i38IU8lz4/cEIIy0ERS9ekFlDPi3/mp2GatCmmfJNFz4p+S38OoxgIGifh9GAe/J0CgHF1FDiN8IUqtHNg9Q3Iagc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894837; c=relaxed/simple;
	bh=e1T+ggG2nM3HGQTe+E4pN8Vy/hZEgl2T0UcLEhYKgJc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ls4Y4q+tl/ppGPof9ecvTYUHe9LmKh7tVds8IDNunNa04+ShX2yU9upuAuIhcivAwrAXi3lr8CbzxxJW3dBqA/HnzfMr9nt6y1EfDZ0UqC11vx+fL21Te7fAFHMmOOpvs34OHiHeezTUZ7RNzpALbuBVL1OFvrDb4IhtneMO35k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Q3p6bf7I; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 19DDD40E0285;
	Mon,  9 Sep 2024 15:13:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rPOYEgaIOUyE; Mon,  9 Sep 2024 15:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1725894828; bh=Nf7mCCqxIpfNdePq5t45R92pve67y3+QVwsU1AchnN4=;
	h=Date:From:To:Cc:Subject:From;
	b=Q3p6bf7IwZ9nBEnfBXbSdjaAEWQ3Td+zHQWxt4HnIElp/uGjj9+A726Q29yjTl7YN
	 EcA9zE2417vafyAhgLAJWMnQ6sTzXJhHKWXrcqty+6HJJ58d4bSG7bh1DGXMEHDUPS
	 pf4AjgS4lUOO2iNn8D2ZjXfmhHJLvIYCsILwVyGLq1AbJgBIJ24tODv3HYcwN2rj80
	 /qh1DVf5+/aRB6UaBV/VHpCrvVpbMWufSqU/Dqz047kDSkc20IvJ8bGJDQxEs6d8+O
	 /KH+7Y2mULJX63vImVf/ZjYkC7AKzCuAKwIPPoTkGZDmKxs6jYGP896/CH6GBUvYg7
	 APPO0R8M7yht994r2640LQGHsYuhlOhJ1oRUk7gr2aVAAqVEhzMeVCQiD9WzN3xjoO
	 Mblli+dqay/8ZOsfYwqxMqVpOLpc3SPuzgc1xf/FwU+yyjgNslvxPMN+PFT3iEYCJd
	 2B7EeYKRbhYXccs9qPVfSIU9+oKn0UTWICv+U5waop8VtP/VqNA/aJhXVCIDawzV0W
	 b+gH28ClPPNrbnUaRqEj+AKBX9CMx8HyZbPuDlezR0wJ2wP82wl3Xu3Nk2G46F05qQ
	 aC48kHuzG+GfMSANDBvEQdm7a8Me5iSBVYun6kWeDlf6Qp5jq0kMIc4fYWKut+hyYb
	 AYCWdesAy8oA4yESwh0xI86M=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C894240E0284;
	Mon,  9 Sep 2024 15:13:45 +0000 (UTC)
Date: Mon, 9 Sep 2024 17:13:44 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/bugs for v6.12-rc1
Message-ID: <20240909151344.GAZt8QqEDhZCMVYQbY@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the x86/bugs lineup for v6.12-rc1.

Thx.

---

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_bugs_for_v6.12_rc1

for you to fetch changes up to 1dbb6b1495d472806fef1f4c94f5b3e4c89a3c1d:

  x86/bugs: Fix handling when SRSO mitigation is disabled (2024-09-05 11:20:50 +0200)

----------------------------------------------------------------
- Add CONFIG_ option for every hw CPU mitigation. The intent is to support
  configurations and scenarios where the mitigations code is irrelevant

- Other small fixlets and improvements

----------------------------------------------------------------
Borislav Petkov (AMD) (1):
      Documentation/srso: Document a method for checking safe RET operates properly

Breno Leitao (11):
      x86/bugs: Add a separate config for MDS
      x86/bugs: Add a separate config for TAA
      x86/bugs: Add a separate config for MMIO Stable Data
      x86/bugs: Add a separate config for L1TF
      x86/bugs: Add a separate config for RETBLEED
      x86/bugs: Add a separate config for Spectre v1
      x86/bugs: Add a separate config for SRBDS
      x86/bugs: Add a separate config for Spectre V2
      x86/bugs: Add a separate config for SSB
      x86/bugs: Remove GDS Force Kconfig option
      x86/bugs: Add a separate config for GDS

Daniel Sneddon (1):
      x86/bugs: Add missing NO_SSB flag

David Kaplan (1):
      x86/bugs: Fix handling when SRSO mitigation is disabled

 Documentation/admin-guide/hw-vuln/srso.rst |  69 ++++++++++++++++
 arch/x86/Kconfig                           | 124 +++++++++++++++++++++++++----
 arch/x86/kernel/cpu/bugs.c                 |  60 +++++++-------
 arch/x86/kernel/cpu/common.c               |   4 +-
 tools/testing/selftests/x86/Makefile       |   2 +-
 tools/testing/selftests/x86/srso.c         |  70 ++++++++++++++++
 6 files changed, 281 insertions(+), 48 deletions(-)
 create mode 100644 tools/testing/selftests/x86/srso.c


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


Return-Path: <linux-kernel+bounces-235133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 599ED91D08F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 10:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EED1A2819EE
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 08:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E667281AC8;
	Sun, 30 Jun 2024 08:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FxhH0kYD"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3F639FE4
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 08:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719736248; cv=none; b=LyMNM59MiZlgaghn8i7W0umd8GXHqmyDuxkyjwthzwdzl6XDqBv/FS1AqB/NKe5Qk4Mi9DyG4drekAYc63aFpogIk7oR89hs7iZCebGFJkKpXDG7mfi5G3ecBaIq1oNW3WNGAcguDRQ157b7g2r5OEqseDdRCugSpOJHsiVWyQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719736248; c=relaxed/simple;
	bh=7p6pIvRA6BpzhaqPCTWuxIwG9Jxeh7EBEqIsSA6F7DA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DyXD+WjgJZwLIEGVK+vmXUy6W9h6iMI1Apem0MYq5eNjpUC9b5EeXZcOVxS1Bqny+zz6qSdbM42RvigKO5lL3lWrSLdNC0AiSIYAiekq4W65/ECID6d3n6fj4EOfDTty0wm3J+UFDMsX8k41IG971zun/1eg5d/jhPeRfKer9d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FxhH0kYD; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9AD7840E0177;
	Sun, 30 Jun 2024 08:30:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BmfY7EkKFItV; Sun, 30 Jun 2024 08:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719736241; bh=9p9/gPec1kLlRkz4B2vnMkSm4CDAWglalMbQoVnDduU=;
	h=Date:From:To:Cc:Subject:From;
	b=FxhH0kYDDNiBXAFtxnLHE0ZkbVrXD7C2Cpsi/Ewu9G2Q9sNSBgNndyC7GKaP0WDBT
	 R5f0vq/1zfXxIXzqYNT8PquIuHRSaiVu+GMjqpFzHXHP8GeJmQCg7dDWPlbysmMXCd
	 HDll0oVi4lo/BDwVpoaSf14/IZqTlQUUdx+1leHdmVCtILZ7ucSd/vVCYR+IWKZTqt
	 2M30w68zxNM+nyJABGNDKzZolF1LQZRDOxv/NqIM6st5IrKqHgO49TIdgdjmALv7+y
	 T/1WC0lzgONFa412bNwHuAFap2zYNBa1cOMUNVKFxjY8hhsYD3LGGyIis70FdJ41xM
	 PoSdckVSWpGdgWnIi00/y5PfBebPl6nFp5UKTYwUjfO1gh+beJw05rEgZBL3QVlWdn
	 bSqVoFSDI9jiu0nEgRo4FFblFHLjcFy6oTMFH3yjUbhzheKm46N1r78cvh2ToCMqhk
	 9+m7opdVi0gOxbEcut61ByLpsUGLz5RHmha5R2DLxkHjfIv88jp2bpQ/IK2T18ccMl
	 mXDBKyQk5dWKKwUiMs517G/y0STCNFDXw7Ml/OtkUvQ5PeqaVOqbl8WPDIoQqjlhHg
	 Xw1lSx60OwY0nvy8lEP0TnKJK+qDqnsTjJ42Hd/uNtX9Ues4mUdwZjSy3JGrJzON9y
	 +1HmV9B4qa23se1llTIJrO3A=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 53C0940E019D;
	Sun, 30 Jun 2024 08:30:38 +0000 (UTC)
Date: Sun, 30 Jun 2024 10:30:37 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] smp/urgent for v6.10-rc6
Message-ID: <20240630083037.GAZoEXraxiw1FTc-Mm@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull two urgent SMP fixes for v6.10-rc6.

Thx.

---

The following changes since commit 6ba59ff4227927d3a8530fc2973b80e94b54d58f:

  Linux 6.10-rc4 (2024-06-16 13:40:16 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/smp_urgent_for_v6.10_rc6

for you to fetch changes up to 6ef8eb5125722c241fd60d7b0c872d5c2e5dd4ca:

  cpu: Fix broken cmdline "nosmp" and "maxcpus=0" (2024-06-23 20:04:14 +0200)

----------------------------------------------------------------
- Fix "nosmp" and "maxcpus=0" after the parallel CPU bringup work went in and broke them

- Make sure CPU hotplug dynamic prepare states are actually executed

----------------------------------------------------------------
Huacai Chen (1):
      cpu: Fix broken cmdline "nosmp" and "maxcpus=0"

Yuntao Wang (1):
      cpu/hotplug: Fix dynstate assignment in __cpuhp_setup_state_cpuslocked()

 kernel/cpu.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


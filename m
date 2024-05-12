Return-Path: <linux-kernel+bounces-176815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2277A8C355D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 09:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 619F5B20F47
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 07:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B2814F62;
	Sun, 12 May 2024 07:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PFiGdm6h"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4712AFC11
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 07:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715499527; cv=none; b=GETf8qR5T1I/NmUSxohiKul75mLM9klAQCNRhaXEm+RKYQnH8O3JhzotCCBXLU8M7qT81sNUpV8yvZjlNAAA/f3SSKVw8DAvdDTrLs7/ffIjJdrJxumKbAAZuD9DruiYrKVKXHgJDEFfGEyvS11tzfKZT6h9qE2p2JKohCUOif0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715499527; c=relaxed/simple;
	bh=VXo86Rp0ieufg5LgH57hCEP5Nk0hfP71cAkcHH2/G9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GdFlbSKezUdR3qB8eoZxrDYVKRqaWr+qYv1QMKOuWrqgcmlTIDNoI50Khya74zXrtP+2mr0v70m/tNs6tyaEGRSbHW2bKLmJZJU21Hb3mYIEXS5i4ki0jo+Gw3NezLlQAH28dXMeBgdIOagILj1t6MS7KoyEUkmX6F3T5d78PfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PFiGdm6h; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0991D40E01E8;
	Sun, 12 May 2024 07:38:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id J-hIWidqnWtZ; Sun, 12 May 2024 07:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715499512; bh=IxwnDEneR7VaE1V9Al+Fz2IWeVa8kPOaN5RdmroiFPc=;
	h=Date:From:To:Cc:Subject:From;
	b=PFiGdm6hLQz+8sfMQoCirQ5VgonC7IW5ok4eMYm+KcEA+KLR43ankvVFtnByyHb3L
	 4z5E22mu/A2+pl2n6J+/1QQHqHHDYT2jvg4pKLBqze+1U4p1IPseO3nLPKQBKp9ycT
	 Q4LRBrkk0XdZoUWPBY1JijALQHlVQ+FOL7Icysca7I8bsbfHeBOmYfV3k5Bb4QhZDP
	 S1wpp0pkc+BKrHMBcJF/ZWOaH5s9T/QUptLAjnis5o7ow5eB8wn0aPwzpmOThVLpyx
	 d0Olali/ZNGuZcwFZLw78ypXHoKd83fUoDxDdSeqLKgcJJl2oaG0GpGrjiBWMVUKoJ
	 g6Fe/Tm++8DUTStqCuDO89FKtkR7H2X6XGHCcrz435Dzr5fAQ+HplmgvPCfwj/lQ1M
	 Aa/DNQloM2UUr94mBpYw7987xLBGTrTIpg2Iy7Lli2x8UM1Idic6+jeOPurET5QWgr
	 KhK1vVK//1aCXsmmCDNWCwFoJSOyicF9N8zs6kvmYmQXrlDIL8BifRcsutMHM3nPx4
	 KbvevEYaM5+J7XJ1G3KJXIENnQvi6MWImjfsYBhDUX/3h4/LxB421L+rBTYfSQ2/0C
	 fb68tuKvX6k7zpLCWJsoD+o0CxOPXnCvS9EJ4NhuzrwTXb2ocSdtJPMs5D8mlLWK/a
	 GpRDws2U3PCRPjguBTpHYBR4=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 746EA40E01A3;
	Sun, 12 May 2024 07:38:29 +0000 (UTC)
Date: Sun, 12 May 2024 09:38:21 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v6.9
Message-ID: <20240512073821.GAZkBx7VXlioXx6q6w@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the last two x86 urgent fixes for v6.9.

The merge window lineup is tested, pretty much all outstanding
regressions I know of are addressed, I think we're ready as we can ever
be...

:-)

Thx.

---

The following changes since commit dd5a440a31fae6e459c0d6271dddd62825505361:

  Linux 6.9-rc7 (2024-05-05 14:06:01 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.9

for you to fetch changes up to 5754ace3c3199c162dcee1f3f87a538c46d1c832:

  x86/topology/amd: Ensure that LLC ID is initialized (2024-05-10 17:42:50 +0200)

----------------------------------------------------------------
- Add a new PCI ID which belongs to a new AMD CPU family 0x1a

- Ensure that that last level cache ID is set in all cases, in the AMD
  CPU topology parsing code, in order to prevent invalid scheduling
  domain CPU masks

----------------------------------------------------------------
Shyam Sundar S K (1):
      x86/amd_nb: Add new PCI IDs for AMD family 0x1a

Thomas Gleixner (1):
      x86/topology/amd: Ensure that LLC ID is initialized

 arch/x86/kernel/amd_nb.c           |  1 +
 arch/x86/kernel/cpu/topology_amd.c | 16 +++++++---------
 include/linux/pci_ids.h            |  1 +
 3 files changed, 9 insertions(+), 9 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


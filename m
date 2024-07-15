Return-Path: <linux-kernel+bounces-252404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 328419312A5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFD202845B8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1BC188CD7;
	Mon, 15 Jul 2024 10:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Il79xw0t"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9021223B1
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 10:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721040939; cv=none; b=n65B+GCLgjdc5wVZE8nOkzbx83mRk+GlmeR9h18QNYnfT8vI13UeNl3PCm6/eFOyQ98uQOH+79Ra3BdcvqS9U21zmlJDau3ksQp/6EMW9dclAORIZKbfJbd5Rw2RqtGlUlAJ5EPhpf1N6jtrxTE/LAAMun0JOJWJFw1n8u6z03M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721040939; c=relaxed/simple;
	bh=9+RKM7tIkKupXFCSxjaCS0XGBYRZ4g19M1f7LgwRwx8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M4lpNdlk74qUkime4TVksgImwjRUj7FJIVxJLOKx1yLRbZCR2yZaPEBoOUV+bnoexmzOcb+yDjeK4VFI/Uv9cEsjVSUldhfVb6EyI9wQnb+BObz5jFm/De62TpXYtqXUymQVByPAMYtplHkAh19r7Ks2RpAUBL+vCqOm4P7tw64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Il79xw0t; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4181540E021B;
	Mon, 15 Jul 2024 10:55:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id S2j1SGRLABEh; Mon, 15 Jul 2024 10:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1721040932; bh=hQ0DchaqyRZ7iW2LAcih/Xp1E07P6ib0VSn/O1/wUSo=;
	h=Date:From:To:Cc:Subject:From;
	b=Il79xw0t5d+tnhgJsu9If5JF0scg66hfAxn97ZTXihnVqfc1qQn0NgoMECQ4QlF16
	 cGyBk6nnmvDtZHSKvLLivJbW7UwxktDGOLFYgJJHdHo/0DIatxdlJ3S5CgfyDig0vG
	 CMfzflhDJNAltWSdZK50Anx+ZuC1Kd/yTZd9d87cOaIKLpWQT8i82TbTTUBAkoSpWe
	 WbmUrGFKTL2P6r0RClQ3oPaBm/KoRZQsdXMnRnIMKsvyjmZBevEwYxcWe1cZWEILi5
	 pf+AKdL9QYbhsI4HRo+M3gwm9rGnsYb9rNeCX2YDVoCJfjz0Gu5lhhVLDFoQhLelc0
	 JSokmpIb+EqQbDe+O1rXodtQk+N19hXpsGh8HW9pAY4QzAMcTNTEN45XmBE9dntdpa
	 CgIWWw85dtY9jMP+zESsL7OVab7xSyifYalfi88nIC2Pfrjqs/w4LCoG8KrlciSbga
	 mLaUSyusTZ/n3J7T90cEOGo19AfdI3N12AmSKSuZBq0Ljczi2Ciu4Bie+Pz2dewtrz
	 lYfj0cBejiROuBq7+XCarzXcxiZcvtMnayHun7HFQwlcbmzMwNZQQwJejipWdZUhWW
	 ubGaa7yYoijFfG8Kguw7IYVUgNXXs904E39jhgBaN7fe3aTc2W5yIDQO16tbCf8Xve
	 3TgrN7DMNgQcQzwKtLzU8bDo=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1697340E0192;
	Mon, 15 Jul 2024 10:55:29 +0000 (UTC)
Date: Mon, 15 Jul 2024 12:55:28 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/alternatives for v6.11-rc1
Message-ID: <20240715105528.GAZpUAIBt5b-zr4ot5@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull updates to x86/alternatives for v6.11-rc1.

Thx.

---

The following changes since commit 83a7eefedc9b56fe7bfeff13b6c7356688ffa670:

  Linux 6.10-rc3 (2024-06-09 14:19:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip x86_alternatives_for_v6.11_rc1

for you to fetch changes up to 0d3db1f14abb4eb28613fbeb1e2ad92bac76debf:

  x86/alternatives, kvm: Fix a couple of CALLs without a frame pointer (2024-07-01 12:41:11 +0200)

----------------------------------------------------------------
- This is basically PeterZ's idea to nest the alternative macros to avoid the
  need to "spell out" the number of alternates in an ALTERNATIVE_n() macro and
  thus have an ever-increasing complexity in those definitions.

  For ease of bisection, the old macros are converted to the new, nested
  variants in a step-by-step manner so that in case an issue is encountered
  during testing, one can pinpoint the place where it fails easier. Because
  debugging alternatives is a serious pain.

----------------------------------------------------------------
Borislav Petkov (AMD) (14):
      x86/alternative: Zap alternative_ternary()
      x86/alternative: Convert alternative()
      x86/alternative: Convert alternative_2()
      x86/alternative: Convert alternative_input()
      x86/alternative: Convert alternative_io()
      x86/alternative: Convert alternative_call()
      x86/alternative: Convert alternative_call_2()
      x86/alternative: Convert ALTERNATIVE_TERNARY()
      x86/alternative: Convert ALTERNATIVE_3()
      x86/alternative: Convert the asm ALTERNATIVE() macro
      x86/alternative: Convert the asm ALTERNATIVE_2() macro
      x86/alternative: Convert the asm ALTERNATIVE_3() macro
      x86/alternative: Replace the old macros
      x86/alternatives, kvm: Fix a couple of CALLs without a frame pointer

Peter Zijlstra (1):
      x86/alternatives: Add nested alternatives macros

 arch/x86/include/asm/alternative.h      | 241 ++++++++++----------------------
 arch/x86/include/asm/page_64.h          |   2 +-
 arch/x86/kernel/alternative.c           |  22 ++-
 arch/x86/kernel/fpu/xstate.h            |  14 +-
 arch/x86/kvm/emulate.c                  |   2 +-
 tools/objtool/Documentation/objtool.txt |  19 +++
 tools/objtool/arch/x86/special.c        |  23 +++
 tools/objtool/special.c                 |  16 +--
 8 files changed, 152 insertions(+), 187 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


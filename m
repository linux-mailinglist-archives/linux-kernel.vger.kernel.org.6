Return-Path: <linux-kernel+bounces-321393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBD59719F5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDFB41F23FED
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D26F1B9B3B;
	Mon,  9 Sep 2024 12:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="R2BQieh1"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B9A1B9B25
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 12:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725886255; cv=none; b=iN5jeCQ8SPOZOhfi6e63cg0mIP7ri9uEfNPC+HjqxfpcR2QrqCj/89TmYwXBYFXVQMjOOWHg1mxM/Yj7SoCoLy0rc2/iPX2n80lSW5/cMjmkIOFj2Ik827Y+FbFyQrNA/wrmJyQmmES3RGBPSMWbJ2CppgAU4OIlMFXYevzLEkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725886255; c=relaxed/simple;
	bh=B0GeGCeqxTV7HRhC6jjkUDPP3gF6hn8VnvqBTrIuPIY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DoFlcNa5BdDpjxB5uMvtTvoRpPL10Diph9UazoWncbELJVpAYrxXSt6GF67YlECVY0ZvXaMMa+80gkI7FeaQJm4j1VPK4juFyvxQ/zjR+hpTpK0QroTCVBmUXFn89argFOMY5gUVhvIWBNVI9s6FW5kZHqAjiz7/d74fvxELvFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=R2BQieh1; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7553E40E0263;
	Mon,  9 Sep 2024 12:50:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kAI6MAHyl6io; Mon,  9 Sep 2024 12:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1725886236; bh=11qbqW1QzojUC4ahPK3yzmckmx27RXFXkq8EvRePEn4=;
	h=Date:From:To:Cc:Subject:From;
	b=R2BQieh13z++pmjnLfRw38RuL0AA6TGt48Hsr9256UwSz61A71SwkFhdd9wwShJLS
	 fw++4EmdsvskG2pFrfp9dPtTMGmC63yb0whUJ4cWaAF/o34Axn9z2lOnCD6IkHIGs2
	 tbUvLSddY4ihoHbQRpwQvVnGWu61e0z8TmeGElPwNiMCtRc7Tse030mwDZQb8dpoWR
	 9+isENbwWPTRkLPSr4LLDzg1UPGEGDzNZ96FjASunAaEG0f09JiD2w0el1viYWW7yB
	 BDEwTQz+3x5oSajmZbd7JaatjGnga65ULy5DJ4KbqysdfOMkGIqjBVpN2wo9UZZKqB
	 +5V4psGjJkkuwD/RQPX7ZpMR5IhDf7vz6TYZESSa7bvYb60tW2ewuyFyhBMQ3cBhd/
	 QmSF3Lxq53lJpJnjfUfH4iVGb2S+ygV9UbtZx/dO+zmOwRnTplxo1gcMIIgHnTHqHJ
	 yXatELbsZn3+74IozrNw1w7sgmpU5Na1O4b5dP9J8TcFw4aAH9ZJnhYYdAwCA+ypwx
	 qjcU76TbF/6m225DSwKyXw3iQhtjWm1j9JmcZMO5c/HUQJea6I3tuhJdJMqJLJNFUE
	 Q78XPSNAAT+wNFY2ge7LyDX+FXRgQq9FmBkTI7Aiv78D17eecxQ3spTHeL9iUE7IPK
	 qcIvlR5Y9/YFLZ0blsL7z8aQ=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4AF4740E028B;
	Mon,  9 Sep 2024 12:50:33 +0000 (UTC)
Date: Mon, 9 Sep 2024 14:50:25 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/microcode for v6.12-rc1
Message-ID: <20240909125025.GAZt7vEdURlnid5eDh@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the x86/microcode lineup for v6.12-rc1.

Thx.

---

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_microcode_for_v6.12_rc1

for you to fetch changes up to 5343558a868e7e635b40baa2e46bf53df1a2d131:

  x86/microcode/AMD: Fix a -Wsometimes-uninitialized clang false positive (2024-07-30 09:52:43 +0200)

----------------------------------------------------------------
- Simplify microcode patches loading on AMD Zen and newer by using the family,
  model and stepping encoded in the patch revision number

- Fix a silly clang warning

----------------------------------------------------------------
Borislav Petkov (1):
      x86/microcode/AMD: Use the family,model,stepping encoded in the patch ID

Borislav Petkov (AMD) (1):
      x86/microcode/AMD: Fix a -Wsometimes-uninitialized clang false positive

 arch/x86/kernel/cpu/microcode/amd.c | 192 +++++++++++++++++++++++++++++-------
 1 file changed, 159 insertions(+), 33 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


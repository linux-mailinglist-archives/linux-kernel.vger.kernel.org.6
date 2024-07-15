Return-Path: <linux-kernel+bounces-252415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C8E9312C6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0271C212DC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461291891A4;
	Mon, 15 Jul 2024 11:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="P0ILv9ie"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD832187321
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 11:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721041469; cv=none; b=a44S4ULxEEUtLNTJv5AltxRV3tGf4rpEUuPf6TEZsrWwgFr5S5o2jBeWevDG8nEmJ/ihUd/wL5Yf//6GH8t1Mmz8o8vDB3SJ7nBTM8cuU5aK+TYuPPxU+vod90cuh1tOoPXGfrBM3zG4sfNHb5K229PneebaeXgHaxGAi3N97k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721041469; c=relaxed/simple;
	bh=jYc0Xnto1M68lWJ+Qep4aXcfjfywyFRqPXFEArv3jLw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NrrR37DS5ETTfMwDymP+P5SxnyaCZgLo5ysxz7YFitlK3rS3jsAZSVUEh77vxNBPP4O5a6EZz7oJpZZiLxaFc8ooVHFlzIEM78bsDMDcCNVcmnj78PIClpx82UPjnTzKgNX8kVe0DAVuUGWlo1m4zJqQaJpJ8KqOT7WIAcb0DIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=P0ILv9ie; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 94E9340E0192;
	Mon, 15 Jul 2024 11:04:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kNe61VfhuUKr; Mon, 15 Jul 2024 11:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1721041461; bh=/ywQ+ihA8rF1rfkGsmAGn1OvQfOiyr0bnsh/1q3f4ag=;
	h=Date:From:To:Cc:Subject:From;
	b=P0ILv9ieNR6+UEIap34Kgv7SuooJp4hcpeTP7oukHHlNUYegMlc1D/ASpIHRVlmVc
	 fmgCA65ZKdsXoJ/sSubNO4R+msrmALpEvdBnPrOPKTxMK//jy1AdvHyrMJytzFxZE4
	 vx8xVYjeov/jug/Rxaspg9pfOqYnc62NXOi+yWbhWtSQ2fbTFG6kEri5CBPkXL5Jx6
	 Oh295zHDJRuPp4hrmeV2lqvVVjvb61Jfipj1qc/hXL/w4UCiL5ok5+Qj64CC5SFfuJ
	 zzydtKB1AvOUOHeZ3ifiyCyKK7kUokq95KFotVdqYHSmE2PTt/IvHE0HLs5NI/5Ckk
	 3Bsw79Z7tLVOiipsHdBjupD7FQWifWEbrZbqavrk5jKKuV9uaaJNz4grdQIZ68H7kR
	 nbDQrd8t2jLk7LerMOEqfj6Flef/TQ8TYJ/rET2JgIKuoysvSHIW3mUViqeJ/dqS64
	 HTxGiPkCRhfppXk7UR58MGXfp6hpZ9GZMCmh05gnIhyZg42mDqx/Z7bC1IM7XbN3MH
	 bjy8ZV6TaqoPD8aFrpp5KV0IyCclgWSsEF+bEfeQYJ/VNbg/WJlpTcp9q0/Po9CIOE
	 gmyfFmX3/M4O6rxtLGcKi0Ffaw+rjVr0bzzuirLuHByste3u5P0B+YJ0zR2ehqI8ny
	 ydmAXWxZS3lki0QBwenOCYdc=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A3A1640E019C;
	Mon, 15 Jul 2024 11:04:18 +0000 (UTC)
Date: Mon, 15 Jul 2024 13:04:17 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/boot for v6.11-rc1
Message-ID: <20240715110417.GAZpUCMQZXlXomdlGU@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the x86/boot lineup for v6.11-rc1.

Thx.

---

The following changes since commit 41c14f1ac82cdb1e009d635ffd5ae5dc4cc3f036:

  Merge tag 'x86-urgent-2024-05-18' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2024-05-19 11:42:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip x86_boot_for_v6.11_rc1

for you to fetch changes up to 0c40b1c7a897bd9733e72aca2396fd3a62f1db17:

  x86/setup: Warn when option parsing is done too early (2024-05-27 18:54:45 +0200)

----------------------------------------------------------------
 - Add a check to warn when cmdline parsing happens before the final cmdline
   string has been built and thus arguments can get lost

 - Code cleanups and simplifications

----------------------------------------------------------------
Borislav Petkov (AMD) (1):
      x86/setup: Warn when option parsing is done too early

Ingo Molnar (1):
      x86/boot: Clean up the arch/x86/boot/main.c code a bit

Uros Bizjak (1):
      x86/boot: Use current_stack_pointer to avoid asm() in init_heap()

 arch/x86/boot/main.c         | 42 +++++++++++++++++++-----------------------
 arch/x86/include/asm/setup.h |  8 ++++++++
 arch/x86/kernel/setup.c      |  2 ++
 arch/x86/lib/cmdline.c       |  8 ++++++++
 4 files changed, 37 insertions(+), 23 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


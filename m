Return-Path: <linux-kernel+bounces-426589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 699429DF555
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 12:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F6982811F1
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 11:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6227139CE3;
	Sun,  1 Dec 2024 11:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kfkM2wOg"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3683233086
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 11:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733051304; cv=none; b=fiWHViFuB2b9/r64q2Ie6b0itO6eKAE+bzd+xHZrsLUujR7YjFyXMRjJtD3t/HlMo3HJ/Z04bTEH/Cz17CYboUPnp6I95IDMAlPigrktp6XqLtCFXDiDd1AnaFF88eskZhVAg0H5jR4v+Wqdm0OCnTPufv36ZrYsJAcEw/ZVJSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733051304; c=relaxed/simple;
	bh=YP1t0L8XnNtt3+THjvDF+BlYo6ubzOmPou0aXfNwCLA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cCP1b5/k05sL0j952j1qMDa7mKSzrEXPuw5x5O7IDR/DbDOMDM8Q5Y6TbcUgrclI2Pgrop65ClRrmoAHdr5gaMkZazKfu8ax9RHV0uTmrWXqSEqlDVJ/BmlmvxTiRpag8uNOMt0a4L1dP+Yl3rYE1q01G/h1XC4A7WskSw6mLQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kfkM2wOg; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5627640E021C;
	Sun,  1 Dec 2024 11:08:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JNwIpmKVNWRo; Sun,  1 Dec 2024 11:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1733051297; bh=+D3E2HZsGf/M3lsKMUDTrSvVlQHkolH/psA+38DiLTw=;
	h=Date:From:To:Cc:Subject:From;
	b=kfkM2wOgL03cdDpzkUO7uiTnYzfhIEFUrYLBMbOUYSQ89gyT/jT3hR3y+WJpL2xze
	 9JQi7QlYGhObrw+7EFK1iAnMkA69YoWV3iPTiYUYuq+RHCVrKwiEMFhh7z0jaPeqtT
	 7d0FmO46/L124FiE9C62fvfrc+/I/3LcBPrhgFgTZrh/07B1PXKp+irsawzU904OmK
	 yJipPkquMzR1k+euqir2kI0eUAKE4iydWLDEUIE+UtZ8g22p0UN4wjymuoyeMm8it2
	 i7UFcMqASK+GMaJC6dB1KQArO+Y3czcDDfoFTf6o/VYC0CdgS4BGsRlC1aUqqMTwK2
	 F4yvXjCgeYQfTR55rnnMwnqpotXzRdgh5v0nu+uEeJyuzvyvCwXJ+0bAvIQs/y2kG1
	 FnCzV1PIeIjhC2gXz25CRkPepVu6u+MOmvKmd+ntJVbnQFFPX5UM7ScGJpwXzNKUYs
	 yUS9OgIh4B6wRJJgHor/Sc5UW8a2jX4/8tLpy64nYgG1vtPyXo+Egi1V/brl8C2E2W
	 9fjdPpqvfEoS+WiriRAk/swkEKKgWrE6RKLQinNuN4s33Lx7rcetY04uLdd9jwWqvp
	 H6l+e5KA7IbNRwACFPChT1ialKM3zYYp9ao+vFcUtoQ5twV02ik0/pvTZkmU+EljDL
	 Q/iayM5bM3+gxu3UMvvif8kk=
Received: from zn.tnic (pd9530b86.dip0.t-ipconnect.de [217.83.11.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0CF0B40E0196;
	Sun,  1 Dec 2024 11:08:14 +0000 (UTC)
Date: Sun, 1 Dec 2024 12:08:08 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] timers/urgent for v6.13-rc1
Message-ID: <20241201110808.GAZ0xDmFincppAQNOk@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the timers/urgent lineup for v6.13-rc1.

Thx.

---

The following changes since commit 7eef7e306d3c40a0c5b9ff6adc9b273cc894dbd5:

  Merge tag 'for-6.13/dm-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm (2024-11-25 18:54:00 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/timers_urgent_for_v6.13_rc1

for you to fetch changes up to 63dffecfba3eddcf67a8f76d80e0c141f93d44a5:

  posix-timers: Target group sigqueue to current task only if not exiting (2024-11-29 13:19:09 +0100)

----------------------------------------------------------------
- Fix a case where posix timers with a thread-group-wide target would miss
  signals if some of the group's threads are exiting

- Fix a hang caused by ndelay() calling the wrong delay function __udelay()

- Fix a wrong offset calculation in adjtimex(2) when using ADJ_MICRO
  (microsecond resolution) and a negative offset

----------------------------------------------------------------
Frederic Weisbecker (2):
      delay: Fix ndelay() spuriously treated as udelay()
      posix-timers: Target group sigqueue to current task only if not exiting

Marcelo Dalmas (1):
      ntp: Remove invalid cast in time offset math

 include/asm-generic/delay.h | 4 ++--
 kernel/signal.c             | 7 ++++---
 kernel/time/ntp.c           | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


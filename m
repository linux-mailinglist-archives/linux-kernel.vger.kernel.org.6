Return-Path: <linux-kernel+bounces-320079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 013059705EA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 11:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FD871F21A99
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 09:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D291136353;
	Sun,  8 Sep 2024 09:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Alms2yDT"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509164D8CE
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 09:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725786208; cv=none; b=goH2QRH0fQyCXk91VM/+EITWAqknnQ+mSmlIjDASHCEQ9khoi0eCvgp9pssgwbj6Q/NycQ+Si/BX+kBeGKkjSS9RKBHRl/+pzQlsEiTZy8gCC5UWQtp0Sd8DKHkeY3NcDjqJhlpIWrdjHxYNn1rI4W+FQe6FjIPLG12RTQ0yRNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725786208; c=relaxed/simple;
	bh=pluH5GVLHbVz66JIqkRrlKPpokM977q/boxnEB751Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WyalXHy+VyUyIZzLNXPU1cwkGibVr8OrytWYIvHbWkmoX0rkySNE1L/clD1gwc/fQ2s5ozBDkhNpfrRS6KqUoWX4Dz5POVHa6rggnRLN3zaXw4gAy7XTRgEGHwuBC2FF8g+0COlh9lRwcJPeg3Tm3hcy/QMTOcayYwKiaIpN5Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Alms2yDT; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4EA5040E0198;
	Sun,  8 Sep 2024 09:03:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Xxqo4dxPcXFx; Sun,  8 Sep 2024 09:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1725786191; bh=DKME3XFVEe8ofW3md/gCIKE8K8akYLZGHUMo9OeG8nE=;
	h=Date:From:To:Cc:Subject:From;
	b=Alms2yDTEMjF82+UoEpcj82gWhaSQujjEHzx8E6/CwbE28BKdwHCOpqHAsxUzUFpx
	 N45TOQ83bdKOlwajA384JDrxDf+OP3OPhJ+B/nUp7ws0AkALq4GxBZUMgaEzXZpjjy
	 1Btjg7E0OX97MTgYOl0pzZBRWaLrMG/nvwiJJ5msrGD9uL0pZn/FEFR0zYhCgVVaGh
	 TCz9Zl9C3FQJMKYV0ynAUTB470fl40+gOSwQl9DxiIBt/0UEk0bhb0wg0luvX5PWzV
	 EVKOmP2eW7fhkKJhFLhmJV/bHhId8PqROJP5AmiYRhNhlo9/uW3TX9Cm4uc44vYX9n
	 7g3n33c8PzInUH+Bt9YqdT0JPhLFACU1vLz+/i+8PXKUt3Oo1YDDmWj+wGj9BwQNYm
	 8IunjCo+fnn2d+eezM1p5lQ8NBI1+unmvB1H984pMP0LasR6Q76xlkmLg+HQFrG05J
	 EwL8z4E3tN/vawsL2o1HpKVYPImGQNEJA/V6TOpPCmTU1UrUOEhsv5pnqmqTXsowfe
	 Q9c4OP1sGJjn9hRKOk4IkGiIuCUL7UB0q1udjdXtFG2+UcYBaccKRzdkbIQ57G0FFp
	 1v7DLGyVvt7bHAGAH70jOSYK+7sfVmdd5Xr/JfV49tVqfmsuhHZ+hdpJ0zpml0sx1u
	 ZyRO0UbiVVjG36JBfD9FBv2Y=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D1C4A40E0185;
	Sun,  8 Sep 2024 09:03:08 +0000 (UTC)
Date: Sun, 8 Sep 2024 11:03:02 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] locking/urgent for v6.11-rc7
Message-ID: <20240908090302.GAZt1oRk_8H_68AxCe@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the locking/urgent lineup for v6.11-rc7.

Thx.

---

The following changes since commit d33d26036a0274b472299d7dcdaa5fb34329f91b:

  rtmutex: Drop rt_mutex::wait_lock before scheduling (2024-08-15 15:38:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/locking_urgent_for_v6.11_rc7

for you to fetch changes up to de752774f38bb766941ed1bf910ba5a9f6cc6bf7:

  jump_label: Fix static_key_slow_dec() yet again (2024-09-06 16:29:22 +0200)

----------------------------------------------------------------
- Correct unwinding the static_call machinery when encountering an error while
  loading a module due to a mis-assumption in the static_call_del_module()
  path

- Replace a WARN_ON in the memory allocation failure path of the static_call
  module machinery which unnecessarily leads to a panic when panic_on_warn is
  set

- Fix an ordering problem in jump_label's static key reference counting code

----------------------------------------------------------------
Peter Zijlstra (1):
      jump_label: Fix static_key_slow_dec() yet again

Thomas Gleixner (2):
      static_call: Handle module init failure correctly in static_call_del_module()
      static_call: Replace pointless WARN_ON() in static_call_module_notify()

 kernel/jump_label.c         | 83 +++++++++++++++++++++++++++++----------------
 kernel/static_call_inline.c | 13 ++++++-
 2 files changed, 66 insertions(+), 30 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


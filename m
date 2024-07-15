Return-Path: <linux-kernel+bounces-252726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C47E393175E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 17:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0914AB220EB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D8E18F2D9;
	Mon, 15 Jul 2024 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ODYjkZGd"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06153A1A0
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721056237; cv=none; b=bKTrDlkkVwV73jNbi58qmgRftcrKpGsNHQci6wKeXH/DD1PpZXwqnon5B/n/t3pefOQIW/BkIhaZHyW75r2xiLMFST40KTP0ItXtgIrwvhZBamZNOwlvuAOrFpeKf5j31lQbkFs023ELM/t5TNoin+fL7nRhWULo5bD1uC6dy0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721056237; c=relaxed/simple;
	bh=/YVHe4oc9vfoGQFAzbZrxOVOGz5ggFVfz8jMBCvJUyE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tFhQ+Q1Tlihx/ryNxb0qfsBJA+WAzW0j/oFLWCq1cvKRqwN7IOM5uj5C2Wc0405YxeSxuRc9LxSBG44cah44IEvGViNkbnzdfVauTcq6ORWLW2XyTjmeVh+UJNO2UfXZboB+ObnP5YsB34vkvFce5QAEve2AbPqTTzHwdnr5bU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ODYjkZGd; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 00EE140E021F;
	Mon, 15 Jul 2024 15:10:33 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Cb_aGWLaeRrC; Mon, 15 Jul 2024 15:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1721056229; bh=/4jVkti3xPcF4pGd2zgvlylf/F/6ttkWnrUIx/RdHGQ=;
	h=Date:From:To:Cc:Subject:From;
	b=ODYjkZGdSMtrWGp7gvfoaw91Se8k6CtzT/n+4xnGtOphfiyMcqc7r+Pk40NE6tuBd
	 LQUN6I7hxgCtEk/4gQJpFjrmTuJ19pS97C/JLBAXkUgh8XUbhXIDU+6LHJDqz7+Lcb
	 Ds6Rl7fW8VrukZV05nJ6X/aeGWNlAwk3l1Vx8LSsfR8nh2FhGSM3/dYQOqH7tg9X44
	 uDtNFmZX+lEJngEVvPLOTVWqQq+yqMBQ38LFBfSFqz12kJBFS93Wpx+H1vL93bsLXN
	 LGARckv9vlAztKqP6/KJ1PVpVCL3Qg4C7hzOImme2fdlJ06yCvfdOVzMPqxFXLBE8W
	 6SiWr7uDdzEhswC33fqViJ0dk/zkiGTMh8id/9TkapCeyjFAnZG+ZHjql73JhSQmdU
	 uyZFoWBzWnTudLqUExiYJ7Gd0YXlF/lAhn1kLJTlCijRLnIEUIdR3Khy4XDU+MlwjM
	 LD6vewhqSzorZTFMz9HzY9IyqXIvUmfgHHw/J6d3Rwh0tLoIr7+qcwsoHtdih6TZBx
	 H/lOILdoldympP/S7mn+RjsnjsWM1KrrRKrBDkO9WMyDvFo5vamWJA5UCE+Nb2bNkW
	 8qWFq66jx6YpfzukUqn6Vp3i6xXYqSmdGhC4Bk3gK2Qg/zKd/0Ej047PjNjgCprCaC
	 A4iu0hFyj6RB/i6RwXEEgnKw=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5108440E019C;
	Mon, 15 Jul 2024 15:10:26 +0000 (UTC)
Date: Mon, 15 Jul 2024 17:10:25 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/vmware for v6.11-rc1
Message-ID: <20240715151025.GAZpU74ZeeCqqMZpWw@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the x86/vmware lineup for v6.11-rc1.

Thx.

---

The following changes since commit f2661062f16b2de5d7b6a5c42a9a5c96326b8454:

  Linux 6.10-rc5 (2024-06-23 17:08:54 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_vmware_for_v6.11_rc1

for you to fetch changes up to 57b7b6acb41b51087ceb40c562efe392ec8c9677:

  x86/vmware: Add TDX hypercall support (2024-06-25 17:15:48 +0200)

----------------------------------------------------------------
 - Add a unified VMware hypercall API layer which should be used by all
   callers instead of them doing homegrown solutions. This will provide for
   adding API support for confidential computing solutions like TDX

----------------------------------------------------------------
Alexey Makhalov (8):
      x86/vmware: Introduce VMware hypercall API
      ptp/vmware: Use VMware hypercall API
      input/vmmouse: Use VMware hypercall API
      drm/vmwgfx: Use VMware hypercall API
      x86/vmware: Use VMware hypercall API
      x86/vmware: Correct macro names
      x86/vmware: Remove legacy VMWARE_HYPERCALL* macros
      x86/vmware: Add TDX hypercall support

 arch/x86/include/asm/vmware.h             | 336 +++++++++++++++++++++++++++---
 arch/x86/kernel/cpu/vmware.c              | 225 ++++++++++++--------
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c       | 173 ++++++---------
 drivers/gpu/drm/vmwgfx/vmwgfx_msg_arm64.h | 196 +++++++++++------
 drivers/gpu/drm/vmwgfx/vmwgfx_msg_x86.h   | 185 ----------------
 drivers/input/mouse/vmmouse.c             |  76 ++-----
 drivers/ptp/ptp_vmw.c                     |  12 +-
 7 files changed, 667 insertions(+), 536 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


Return-Path: <linux-kernel+bounces-575839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7C1A707D0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACEAD16C263
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E555025FA1B;
	Tue, 25 Mar 2025 17:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BDvF6d8I"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608192561AD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 17:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742922811; cv=none; b=At6dDPxLiyFRx9Z84+PDG2gRlWYDBEqnA9wa0cqpZF/SHb4KC9XX9A76yOqc/WEvevWK2CNkq7TsUXAA0y6jai6vVjIF2eqy1DJoyYwmNR0A0GW+LxJaQHxlPgdJ9UUQzP+XQG1/OfePSKshiAlFQYfLFWvo+OdvomtCoCOCCLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742922811; c=relaxed/simple;
	bh=cHMGTELfsdVgVpogKAdgWd/mwqRTPxY6INt118OB4Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NCmjKmj7I/jqiULSlQLx+Tc63QfNvwqR6WYV6LiOpAG+flM3zsK5LEWoSer/Y+ss8inKYDK7OD9HOzqOIyB1yzOXbR+8qkuuZY6RkqR/hVD5TN5VEk0vimeDy6DC+F7mQjkF/22CrRYTJOb+yTTiTfRnE8dsMud9lT1kdYxD10M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BDvF6d8I; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A0C6540E0219;
	Tue, 25 Mar 2025 17:13:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UHT_K_i8EGDY; Tue, 25 Mar 2025 17:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742922804; bh=yvXTl5sy7JBuIL7c56tpjCj24YNNiRGj4Zb1aDBMvkc=;
	h=Date:From:To:Cc:Subject:From;
	b=BDvF6d8I40taBLjKD9b923O2DOZl1zkacqWkovwIhakuiHEdgjsMm+m9f+3D0lJ14
	 dyu0Hmxr2OsvKRhBsdM8BBSbuP0XJy5sf1/jGkpuUF1gJQaAVTK8xwsUSksw4r8i3w
	 07gihT2NntKpdDDvfKgO1dF4fN/2kyewRGWZ8m+PS1vCij4yF2/oVAB+TLL5j2v89u
	 8taEr1SRt6Q1eBqbqlYcvuZwcZ6FE9QgerFar9cr4xeK+EwtbJqniltI/zRbNhLLnT
	 lTzIzXLj8TTM/0QprmChuDHwRe6tUoqeh8HH6HO94sYmnXJeSIv3O/LK23o/UtPler
	 HoOSiuigvq2SEwii7q4aFdNlW+iAnHvIDVEoNG4vcQMCoL1Zht24mR7IH623MtEj/Q
	 r3J/xiXX9fm85+xawqHoNmdlB5miBgCN655O2Hk2aBQvZBA3X6QBsMTLvd+lo854q1
	 YEViX8lTpNp9nXKGfcPsCIkOCnzSmPlIykeq6mQcz1g3+I845asB7bRM2arjorwdx0
	 Pqd2lNvuDW2OH3JB+Duqpax65mgkonmXL1fMDtT2KZHwL3GbZuzEso+SWPSX1zP2zK
	 A5dsU0338h7gbOQ7K2AyjuhHjbRNz37n49eJUwsI1jVNWj7tF0JFsopZkW1P+dQist
	 N3wg7JrCosLROXw2LlfUv0Qw=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5B6EC40E0214;
	Tue, 25 Mar 2025 17:13:21 +0000 (UTC)
Date: Tue, 25 Mar 2025 18:13:20 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cache for v6.15
Message-ID: <20250325171320.GAZ-LkMAFoSM7ZhDqq@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the x86/cache lineup for v6.15.

Thx.

---

The following changes since commit 80e54e84911a923c40d7bee33a34c1b4be148d7a:

  Linux 6.14-rc6 (2025-03-09 13:45:25 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_cache_for_v6.15

for you to fetch changes up to 823beb31e55673bf2fd21374e095eec73a761ee7:

  x86/resctrl: Move get_{mon,ctrl}_domain_from_cpu() to live with their callers (2025-03-12 12:24:58 +0100)

----------------------------------------------------------------
- First part of the MPAM work: split the architectural part of resctrl from the
  filesystem part so that ARM's MPAM varian of resource control can be added
  later while sharing the user interface with x86 (James Morse)

----------------------------------------------------------------
James Morse (30):
      x86/resctrl: Fix allocation of cleanest CLOSID on platforms with no monitors
      x86/resctrl: Add a helper to avoid reaching into the arch code resource list
      x86/resctrl: Remove fflags from struct rdt_resource
      x86/resctrl: Use schema type to determine how to parse schema values
      x86/resctrl: Use schema type to determine the schema format string
      x86/resctrl: Remove data_width and the tabular format
      x86/resctrl: Add max_bw to struct resctrl_membw
      x86/resctrl: Generate default_ctrl instead of sharing it
      x86/resctrl: Add helper for setting CPU default properties
      x86/resctrl: Remove rdtgroup from update_cpu_closid_rmid()
      x86/resctrl: Expose resctrl fs's init function to the rest of the kernel
      x86/resctrl: Move rdt_find_domain() to be visible to arch and fs code
      x86/resctrl: Move resctrl types to a separate header
      x86/resctrl: Add an arch helper to reset one resource
      x86/resctrl: Move monitor exit work to a resctrl exit call
      x86/resctrl: Move monitor init work to a resctrl init call
      x86/resctrl: Rewrite and move the for_each_*_rdt_resource() walkers
      x86/resctrl: Move the is_mbm_*_enabled() helpers to asm/resctrl.h
      x86/resctrl: Add resctrl_arch_is_evt_configurable() to abstract BMEC
      x86/resctrl: Change mon_event_config_{read,write}() to be arch helpers
      x86/resctrl: Move mba_mbps_default_event init to filesystem code
      x86/resctrl: Move mbm_cfg_mask to struct rdt_resource
      x86/resctrl: Add resctrl_arch_ prefix to pseudo lock functions
      x86/resctrl: Allow an architecture to disable pseudo lock
      x86/resctrl: Make prefetch_disable_bits belong to the arch code
      x86/resctrl: Make resctrl_arch_pseudo_lock_fn() take a plr
      x86/resctrl: Move RFTYPE flags to be managed by resctrl
      x86/resctrl: Handle throttle_mode for SMBA resources
      x86/resctrl: Move get_config_index() to a header
      x86/resctrl: Move get_{mon,ctrl}_domain_from_cpu() to live with their callers

 MAINTAINERS                               |   1 +
 arch/x86/Kconfig                          |   7 +
 arch/x86/include/asm/resctrl.h            |  36 +++-
 arch/x86/kernel/cpu/resctrl/Makefile      |   5 +-
 arch/x86/kernel/cpu/resctrl/core.c        | 181 +++++--------------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  93 ++++++----
 arch/x86/kernel/cpu/resctrl/internal.h    | 201 +++++----------------
 arch/x86/kernel/cpu/resctrl/monitor.c     | 119 +++++++++----
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  55 +++---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 284 ++++++++++++++++++++++--------
 include/linux/resctrl.h                   | 212 ++++++++++++++++++++--
 include/linux/resctrl_types.h             |  54 ++++++
 12 files changed, 769 insertions(+), 479 deletions(-)
 create mode 100644 include/linux/resctrl_types.h


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


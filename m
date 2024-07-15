Return-Path: <linux-kernel+bounces-252060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8DA930DB2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 07:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0C481C20909
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 05:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B648413B59B;
	Mon, 15 Jul 2024 05:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Gyd6ytwo";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Gyd6ytwo"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A66913A863
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 05:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721022457; cv=none; b=Fzd5SUP2tycoFnvQGMMKGR+q78WYIg+lbu6+0Emqyg5b3cw9POo/ROtZXz2kRXtT9PI4D8icDG703xeNlnTrnjFLl4/HW2OL73FIX7HOA0ONapuTfpQVncYFV3IJAan4mWImYNXyaaqAXeCjsJkDDod10nHQUKSyauqxzooEy0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721022457; c=relaxed/simple;
	bh=gSgG4iBt9z3pSKQCFEZ6j2bBGR9XIutDPS0Y6GctS4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=paCQ7kbUK6oQXVfaATHGhuE7ivy2/WaXO/IFxpk/krqJOzl6ZHiuksWjVWJ0WDfE+Xy58YQ7DhPzavutmloJzVR8aoUxKKcgRQfPbUO7OVNd7y6r714U74SVrvEM0s2a6mPVikViSbdm/RsOEt6iHKiw/sH6pJYkTIlhmDyni9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Gyd6ytwo; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Gyd6ytwo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 52C2C21B34;
	Mon, 15 Jul 2024 05:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721022453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=J+GqE3zqQG29fe01QvbOYJpv81BAnAV5DjIOqhm9FCg=;
	b=Gyd6ytwoPxlYStNOG4uxRoKG4Ae9aUO2b4WvlDdQ3kUafMozj8kLjj3FmpbEwah0pNLc6V
	F8UwY/FtRwuxsDz2eGxqcDKyfyzurkCJirfrYTM0sJPhRj0BeA4AMBUumoQ/rkJiUX0v+H
	0TKe1+JNSyA7Q9N4JDhnFVlEdZbpRaw=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Gyd6ytwo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721022453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=J+GqE3zqQG29fe01QvbOYJpv81BAnAV5DjIOqhm9FCg=;
	b=Gyd6ytwoPxlYStNOG4uxRoKG4Ae9aUO2b4WvlDdQ3kUafMozj8kLjj3FmpbEwah0pNLc6V
	F8UwY/FtRwuxsDz2eGxqcDKyfyzurkCJirfrYTM0sJPhRj0BeA4AMBUumoQ/rkJiUX0v+H
	0TKe1+JNSyA7Q9N4JDhnFVlEdZbpRaw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D74013686;
	Mon, 15 Jul 2024 05:47:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jhETBfW3lGZjSwAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 15 Jul 2024 05:47:33 +0000
From: Juergen Gross <jgross@suse.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	sstabellini@kernel.org
Subject: [GIT PULL] xen: branch for v6.11-rc1
Date: Mon, 15 Jul 2024 07:47:32 +0200
Message-ID: <20240715054732.7508-1-jgross@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 52C2C21B34
X-Spam-Flag: NO
X-Spam-Score: 0.99
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.99 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Level: 
X-Spamd-Bar: /

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.11-rc1-tag

xen: branch for v6.11-rc1

It contains the following patches:

- some trivial cleanups
- a fix for the Xen timer
- a patch for adding boot time selectable debug capability to the Xen multicall
  handling
- two fixes for the recently added  Xen irqfd handling

Thanks.

Juergen

 Documentation/admin-guide/kernel-parameters.txt |  11 +-
 arch/arm/xen/p2m.c                              |   2 +-
 arch/x86/xen/apic.c                             |   2 -
 arch/x86/xen/debugfs.c                          |   2 +-
 arch/x86/xen/debugfs.h                          |   7 --
 arch/x86/xen/enlighten.c                        |   2 -
 arch/x86/xen/enlighten_hvm.c                    |   2 -
 arch/x86/xen/enlighten_pv.c                     |   4 -
 arch/x86/xen/mmu.c                              |   3 +-
 arch/x86/xen/mmu.h                              |  28 -----
 arch/x86/xen/mmu_hvm.c                          |   2 +-
 arch/x86/xen/mmu_pv.c                           |  15 ++-
 arch/x86/xen/multicalls.c                       | 128 ++++++++++++++++----
 arch/x86/xen/multicalls.h                       |  69 -----------
 arch/x86/xen/p2m.c                              |   6 +-
 arch/x86/xen/pmu.c                              |   1 -
 arch/x86/xen/pmu.h                              |  22 ----
 arch/x86/xen/setup.c                            |   1 -
 arch/x86/xen/smp.c                              |   1 -
 arch/x86/xen/smp.h                              |  51 --------
 arch/x86/xen/smp_hvm.c                          |   2 -
 arch/x86/xen/smp_pv.c                           |   3 -
 arch/x86/xen/spinlock.c                         |  20 +---
 arch/x86/xen/suspend.c                          |   2 -
 arch/x86/xen/time.c                             |   2 +-
 arch/x86/xen/xen-ops.h                          | 148 +++++++++++++++++++++++-
 drivers/xen/evtchn.c                            |   1 +
 drivers/xen/manage.c                            |   2 +-
 drivers/xen/privcmd-buf.c                       |   1 +
 drivers/xen/privcmd.c                           |  36 ++++--
 drivers/xen/xen-pciback/pci_stub.c              |   1 +
 include/xen/events.h                            |   2 +
 kernel/locking/qspinlock.c                      |   2 +-
 33 files changed, 305 insertions(+), 276 deletions(-)

Chen Ni (2):
      x86/xen: Convert comma to semicolon
      xen/arm: Convert comma to semicolon

Christophe JAILLET (1):
      xen/manage: Constify struct shutdown_handler

Frediano Ziglio (1):
      x86/xen/time: Reduce Xen timer tick

Jeff Johnson (1):
      xen: add missing MODULE_DESCRIPTION() macros

Juergen Gross (4):
      xen: make multicall debug boot time selectable
      x86/xen: make some functions static
      x86/xen: eliminate some private header files
      x86/xen: remove deprecated xen_nopvspin boot parameter

Viresh Kumar (2):
      xen: privcmd: Switch from mutex to spinlock for irqfds
      xen: privcmd: Fix possible access to a freed kirqfd instance


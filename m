Return-Path: <linux-kernel+bounces-188741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3448CE63C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 15:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D88281F222BF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 13:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6EF86AD6;
	Fri, 24 May 2024 13:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qy9drsJU";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qy9drsJU"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59D01EEE9
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 13:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716557861; cv=none; b=oCUdafVibZ/Sh1/PgmXgK9P9reFunc7miWlcuNLfoUUmKG2Eu/eiKujpWxxAcSGsMLYS6awipskt0ztMdPSrKFzsEeAEKNTr3rNsiNXvqXdhlpo9adximCbHsFlcyvgMYfM0QKcMpkVABlTpQFyEaz0KXN9z3Qyicgfbf6C0Dgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716557861; c=relaxed/simple;
	bh=vPom3DkMhSpbyRBBabDqGPcu4MQ4zZW628XjWbKaq5E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KZOSNNaIC2v/XOuC2rQh1r9aPU/FI5qFlnPAzFyIa2G4KlbtizXNFawuhUdy6BydoBjQUW9rIy4COMPFTtYnVUgAJL6V6wqHB6fz8kO4Mb1EOAx9wXKujm2XqDyr6iPxK8yBkKfY6kKe6AmSfcdPc/ThFP4ymSSK3fpH+9JgUxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qy9drsJU; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qy9drsJU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 18B6E33B2B;
	Fri, 24 May 2024 13:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716557858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JKHA+2p18tBMJqJgM8JceeW8T9TO/bDEUGloQ6VEz/o=;
	b=qy9drsJUa5/BPf+w/P64RE3ruc3tnU95RQyGeW1R9ZlSldD9XjEEq2sjg2K/d1+7QpWChl
	KokgJFTHZr5Ml2tJ8s1R4b/RwfJDtqakOR0hejgPG4URnIl1F7EToQCOvT8CCr/lmD6kNf
	t5+nawkWosh5PgIj4fCVhH88h7vs/xg=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716557858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JKHA+2p18tBMJqJgM8JceeW8T9TO/bDEUGloQ6VEz/o=;
	b=qy9drsJUa5/BPf+w/P64RE3ruc3tnU95RQyGeW1R9ZlSldD9XjEEq2sjg2K/d1+7QpWChl
	KokgJFTHZr5Ml2tJ8s1R4b/RwfJDtqakOR0hejgPG4URnIl1F7EToQCOvT8CCr/lmD6kNf
	t5+nawkWosh5PgIj4fCVhH88h7vs/xg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A616313A3D;
	Fri, 24 May 2024 13:37:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wr10GiCYUGbAMAAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 24 May 2024 13:37:36 +0000
From: Juergen Gross <jgross@suse.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	sstabellini@kernel.org
Subject: [GIT PULL] xen: branch for v6.10-rc1
Date: Fri, 24 May 2024 15:37:33 +0200
Message-Id: <20240524133733.27825-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.15 / 50.00];
	BAYES_HAM(-2.35)[96.98%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.15
X-Spam-Flag: NO

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.10a-rc1-tag

xen: branch for v6.10-rc1

It contains the following patches:

- a small cleanup in the drivers/xen/xenbus Makefile
- a fix of the Xen xenstore driver to improve connecting to a late started
  Xenstore
- an enhancement for better support of ballooning in PVH guests
- a cleanup using try_cmpxchg() instead of open coding it

Thanks.

Juergen

 arch/x86/xen/enlighten.c          | 33 +++++++++++++++++++++++++++++++++
 arch/x86/xen/p2m.c                | 11 +++++------
 drivers/xen/xenbus/Makefile       | 14 ++++++--------
 drivers/xen/xenbus/xenbus_probe.c | 36 +++++++++++++++++++++++-------------
 4 files changed, 67 insertions(+), 27 deletions(-)

Andy Shevchenko (1):
      xen/xenbus: Use *-y instead of *-objs in Makefile

Henry Wang (1):
      drivers/xen: Improve the late XenStore init protocol

Roger Pau Monne (1):
      xen/x86: add extra pages to unpopulated-alloc if available

Uros Bizjak (1):
      locking/x86/xen: Use try_cmpxchg() in xen_alloc_p2m_entry()


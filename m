Return-Path: <linux-kernel+bounces-333120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A541697C421
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCEFA1C20BE5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 06:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD0717B505;
	Thu, 19 Sep 2024 06:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="S0sNRzj4";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="S0sNRzj4"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AFC17ADE1
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 06:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726726006; cv=none; b=nQbAqcj4AOx22dyQuElzp7EHeDPH0+u4hlxO330PYCXqm6OeljbgIzoTXFUAWW3C1qTQ6Wp0j/09uBWH9+K5nOP/q3HDJR5N2i/gIANXVxN8Wnv0nJCBenaAhlWdBvlKBs6/MYXz3sUt2KZs9QgXP4Q/uGarWxQ8b3KfVpmYqqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726726006; c=relaxed/simple;
	bh=uS8MPebciNxastr2lyahGjJv6rHuDY8mjcXxd1GdmVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c2csV5rGdIJVje5EPEOsNcj9xNIl14WjbALTT6ncoSUcCtj+P+peV3Kdb3t7XVTfGnBuxW5IPUtydhzBpr/TYez3WQHnpDrnppaGmepWkXlL2AU/GjihrsYxUstDtNC0AOG8WguHZdSGgFjzSzFb7T/PY25PM2L9OeE7X9EmZLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=S0sNRzj4; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=S0sNRzj4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7B736337AD;
	Thu, 19 Sep 2024 06:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726726002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0q8lpjbBdWl/Bwvse0JH1SoZIHUQkGzm3g/hvCMqczs=;
	b=S0sNRzj4z8lINVoaBdY2xH5OqnsEpShvCc35cy3NYCT9eyVRe6zvjsnPjpUR8qxdFcayPK
	gEKSNU58zdKgkhKJP9FCWIUnjeafDEF9SN0Oy8W/oirqOLoL0KkaNo6SP/uyrzidjkZ0e6
	7Kf0tH/WPJ8KclcKAgp0CmcyBBGdXqc=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726726002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0q8lpjbBdWl/Bwvse0JH1SoZIHUQkGzm3g/hvCMqczs=;
	b=S0sNRzj4z8lINVoaBdY2xH5OqnsEpShvCc35cy3NYCT9eyVRe6zvjsnPjpUR8qxdFcayPK
	gEKSNU58zdKgkhKJP9FCWIUnjeafDEF9SN0Oy8W/oirqOLoL0KkaNo6SP/uyrzidjkZ0e6
	7Kf0tH/WPJ8KclcKAgp0CmcyBBGdXqc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E03D13A5F;
	Thu, 19 Sep 2024 06:06:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8fAFEXK/62Z+NgAAD6G6ig
	(envelope-from <jgross@suse.com>); Thu, 19 Sep 2024 06:06:42 +0000
From: Juergen Gross <jgross@suse.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	sstabellini@kernel.org
Subject: [GIT PULL] xen: branch for v6.12-rc1
Date: Thu, 19 Sep 2024 08:06:41 +0200
Message-ID: <20240919060641.14017-1-jgross@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.12-rc1-tag

xen: branch for v6.12-rc1

It contains the following patches:

- A 7 patch series fixing a boot problem as a Xen dom0 on some AMD systems
- A 3 patch series fixing Xen PVH boot problems with KASAN enabled
- A fix for a build warning
- 2 fixes in swiotlb-xen

Thanks.

Juergen

 arch/x86/include/asm/acpi.h        |   8 ++
 arch/x86/include/asm/cpuid.h       |   7 +-
 arch/x86/kernel/acpi/boot.c        |  11 ++
 arch/x86/kernel/jailhouse.c        |   1 +
 arch/x86/kernel/mmconf-fam10h_64.c |   1 +
 arch/x86/kernel/smpboot.c          |   1 +
 arch/x86/kernel/x86_init.c         |   1 +
 arch/x86/platform/pvh/Makefile     |   1 +
 arch/x86/platform/pvh/enlighten.c  |   6 +-
 arch/x86/xen/mmu_pv.c              |   5 +-
 arch/x86/xen/p2m.c                 |  98 ++++++++++++++++++
 arch/x86/xen/setup.c               | 202 ++++++++++++++++++++++++++++---------
 arch/x86/xen/xen-ops.h             |   6 +-
 drivers/xen/pci.c                  |  14 +--
 drivers/xen/swiotlb-xen.c          |  10 +-
 drivers/xen/xenbus/xenbus_xs.c     |   6 +-
 16 files changed, 312 insertions(+), 66 deletions(-)

Alexey Dobriyan (3):
      xen, pvh: fix unbootable VMs (PVH + KASAN - AMD_MEM_ENCRYPT)
      x86/cpu: fix unbootable VMs by inlining memcmp() in hypervisor_cpuid_base()
      xen, pvh: fix unbootable VMs by inlining memset() in xen_prepare_pvh()

Gustavo A. R. Silva (1):
      xen/pci: Avoid -Wflex-array-member-not-at-end warning

Juergen Gross (9):
      xen: use correct end address of kernel for conflict checking
      xen: introduce generic helper checking for memory map conflicts
      xen: move checks for e820 conflicts further up
      xen: move max_pfn in xen_memory_setup() out of function scope
      xen: add capability to remap non-RAM pages to different PFNs
      xen: allow mapping ACPI data using a different physical address
      xen: tolerate ACPI NVS memory overlapping with Xen allocated memory
      xen/swiotlb: add alignment check for dma buffers
      xen/swiotlb: fix allocated size

Shen Lichuan (1):
      xen/xenbus: Convert to use ERR_CAST()


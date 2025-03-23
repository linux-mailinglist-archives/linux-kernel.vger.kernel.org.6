Return-Path: <linux-kernel+bounces-572781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BDFA6CEAE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 11:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FBDA16EB29
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 10:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB0C202F90;
	Sun, 23 Mar 2025 10:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BATVp5K/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Hb0C4ZDT"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240431FECA3
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 10:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742725583; cv=none; b=nGoKvPBnKoAHg0WP/k0FVCz2NZYeHN/lsv7h8GJp7HhfSmi8V0GSUW3uY8Xxb4kFl/5x3EFNIpoMrW18csXIsPTiR7D40lVT4QcVbSwuWhGpfI7i8GXPrRwEOzVtwRLe+x1Q9+Vo2WMvvLbh/E4So0WNVG/vvvEEjzO/r6A8tYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742725583; c=relaxed/simple;
	bh=JiVRavmCyG/4nV61pzDU4ftwxPFZU6GTflpuRIfJ9Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oRzL/Fr9VpggMbaMHGKsX6/s0XfQxbWmrOonkPHzJAfp2/GtxIeNk2ISA1i/97W2Y748dpX+UxgSATOkvofQWzm65qHPKgFluxRukohY4GF7dTDqFt2ZdnV9Kcg4EQl/WBGriqWfiktb5QNu7/1BjDoE5W0go01DIg3z4WvTt4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BATVp5K/; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Hb0C4ZDT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E797B1F394;
	Sun, 23 Mar 2025 10:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742725579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vuTT4KLfDEEyriyjSo0++a0zL0aCOp328WDIfaFymuM=;
	b=BATVp5K/TS4P4BkKJnzj5fklOiaxJMxn7rpS8+Q0MhLgmdfe/epJCOSp16WVBXJ5CoFYnk
	fkR3CtaRNxeVsOhVh5igW+GKBxPoW7n5KRNmrQh/2I1nShJtmwtzcSr9BgxxRjiGl6U1pi
	jkz9+++xEdfbJ8xJ/1WnNM2mJbayfZo=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Hb0C4ZDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742725578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vuTT4KLfDEEyriyjSo0++a0zL0aCOp328WDIfaFymuM=;
	b=Hb0C4ZDTx3dmF0arj0pSP0JMDDCv86578ocSgC9IgNcKPPStmknSu2TIjtBZA9F8Ayj1ku
	wEN7Myn2KMwjiQFuyPKGV1O2uP5bJFvTqzH9+SrypKKbRwmbU/aKO8r8IVnUTxQHK8dUQc
	um+Wi1uSjqm82o8LPXQzwHxRiZ1fYnQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B65391339F;
	Sun, 23 Mar 2025 10:26:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gG2OKsrh32fKCAAAD6G6ig
	(envelope-from <jgross@suse.com>); Sun, 23 Mar 2025 10:26:18 +0000
From: Juergen Gross <jgross@suse.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	sstabellini@kernel.org
Subject: [GIT PULL] xen: branch for v6.15-rc1
Date: Sun, 23 Mar 2025 11:26:18 +0100
Message-ID: <20250323102618.29516-1-jgross@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E797B1F394
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_NONE(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.15-rc1-tag

xen: branch for v6.15-rc1

It contains:

- A cleanup patch removing an used function.

- A patch adding support for a XenServer specific virtual PCI device.

- A patch fixing the handling of a sparse Xen hypervisor symbol table.

- A patch avoiding warnings when building the kernel with gcc 15.

- A series fixing usage of devices behind a VMD bridge when running as
  a Xen PV dom0.


Thanks.

Juergen

 arch/x86/pci/xen.c                 |  8 ++------
 drivers/pci/controller/vmd.c       | 20 ++++++++++++++++++++
 drivers/pci/msi/msi.c              | 37 +++++++++++++++++++++----------------
 drivers/xen/pci.c                  | 32 ++++++++++++++++++++++++++++++++
 drivers/xen/platform-pci.c         |  4 ++++
 drivers/xen/xen-pciback/pci_stub.c | 20 --------------------
 drivers/xen/xen-pciback/pciback.h  |  2 --
 drivers/xen/xenfs/xensyms.c        |  4 ++--
 include/linux/msi.h                |  3 ++-
 include/xen/interface/xen-mca.h    |  2 +-
 kernel/irq/msi.c                   |  2 +-
 11 files changed, 85 insertions(+), 49 deletions(-)

Dr. David Alan Gilbert (1):
      xen/pciback: Remove unused pcistub_get_pci_dev

Frediano Ziglio (1):
      xen: Add support for XenServer 6.1 platform device

Jan Beulich (1):
      xenfs/xensyms: respect hypervisor's "next" indication

Kees Cook (1):
      xen/mcelog: Add __nonstring annotations for unterminated strings

Roger Pau Monne (3):
      xen/pci: Do not register devices with segments >= 0x10000
      PCI: vmd: Disable MSI remapping bypass under Xen
      PCI/MSI: Convert pci_msi_ignore_mask to per MSI domain flag


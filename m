Return-Path: <linux-kernel+bounces-410996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 726349CF2C8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18627B479E4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF8212EBEA;
	Fri, 15 Nov 2024 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="O8bOmlas";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uNYG2pxG"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1C21BCA19
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 16:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731687787; cv=none; b=KSiwtS6LcgJANiN6EumKX4xOawQ4cBx9KixieiVQ8k8J5UfdE68UCJlKNDpVHI0eGRlEtfd2SN4b+iXINRPEEq3c/8ugkfV14DAMQsV9DZSjPlTMP8qzlapU9P5ticRIDqXRVEDZcvFjNLlesGBhznhhprtPwo9MMEOkZWRcsGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731687787; c=relaxed/simple;
	bh=BZjN6NCjpHdNlEkpNoIneyvy+anzbUzBpZoOi4TNLVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CK03a54/mOP5nAcfFATGr1DuEatKeVVGc9sLphFsnlznmbJJ/ML0uOCnif8svaD5Zc0yPQGEbr4Sv31gLY9DZGRpVGd+MdX053d3ykbVPHikJeHtVzpG7B06T8/v7MKEEfZuDcwywYzQMFYRgZlFHJ++QCwU9Oy18lDrjwxc4sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=O8bOmlas; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uNYG2pxG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A9946211A7;
	Fri, 15 Nov 2024 16:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731687783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JixwWm6LrqeD3xFJMDuRzgjzzoYJflV23s1C/UNsOxU=;
	b=O8bOmlaseOpms0wVxRP5NCxuSbf2jrJWRXGLlPDwC937zosmrJJNAZ9iw+tOGlxZr0615n
	hpQwXKmIhxO+C/rNOa2R55g7AzhkJQF1vKsIitX9B/1M8CRwBKsNSfAuI53nTdb9Ok3FNy
	CHq8VVCJguyIB5lbsngPns1SUEqxPl0=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1731687782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JixwWm6LrqeD3xFJMDuRzgjzzoYJflV23s1C/UNsOxU=;
	b=uNYG2pxGkmkUXjqiudoiKVl46j/SBccekuofQVqQqVNrn5rjrMONeUs6dL2GnkWux/sdtk
	vyWJzs4xNph4BjptkiMMKzsuK7M0Bty75cg9ErR7r03MapdAl0h9EBTKQBlBK2q16nf0k9
	jmL730VmPB3DoFZm7vFoEw7Kz7AeCJc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7EF09134B8;
	Fri, 15 Nov 2024 16:23:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id e5JsHWZ1N2eeTQAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 15 Nov 2024 16:23:02 +0000
From: Juergen Gross <jgross@suse.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	sstabellini@kernel.org
Subject: [GIT PULL] xen: branch for v6.13-rc1
Date: Fri, 15 Nov 2024 17:23:01 +0100
Message-ID: <20241115162301.28457-1-jgross@suse.com>
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
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid]
X-Spam-Flag: NO
X-Spam-Level: 

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.13-rc1-tag

xen: branch for v6.13-rc1

It contains:

- a series for booting as a PVH guest, doing some cleanups after the
  previous work to make PVH boot code position independent

- a fix of the xenbus driver avoiding a leak in an error case

Thanks.

Juergen

 arch/x86/kernel/vmlinux.lds.S     | 19 +++++++++++++++
 arch/x86/platform/pvh/head.S      | 50 ++++++++++++++++++++++-----------------
 arch/x86/tools/relocs.c           |  1 +
 arch/x86/xen/xen-head.S           |  6 +++--
 drivers/xen/xenbus/xenbus_probe.c |  8 ++++++-
 5 files changed, 59 insertions(+), 25 deletions(-)

Ard Biesheuvel (5):
      x86/pvh: Call C code via the kernel virtual mapping
      x86/pvh: Use correct size value in GDT descriptor
      x86/pvh: Omit needless clearing of phys_base
      x86/xen: Avoid relocatable quantities in Xen ELF notes
      x86/pvh: Avoid absolute symbol references in .head.text

Qiu-ji Chen (1):
      xen: Fix the issue of resource not being properly released in xenbus_dev_probe()


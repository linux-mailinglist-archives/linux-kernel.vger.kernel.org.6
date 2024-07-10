Return-Path: <linux-kernel+bounces-247347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 259C592CE4A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D42F6282364
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D300B13777F;
	Wed, 10 Jul 2024 09:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TZgdKOkh";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TZgdKOkh"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6876C17FD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720604246; cv=none; b=jdHrcpTDdoVYbsyJmL1J9gXAk5SEKRP3trpTipG7I8cAvW6GVLLvAhiAE9cTAwpAv6fqTjNIjQpVkkuFJ6dtTmAffrtuYj6YHc0N/OA7xAz/8o2fcX9Ht8SeQZ4XtPe792GG3lCCv448lC28IaEqGc9p6STuRAaSvtamvMQYPfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720604246; c=relaxed/simple;
	bh=VHZ06iO0MVagokGRRJijlnM/okROcRoZpXP1w5XsFuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PlcvMcTQThESoESB++UG2RUmTAWT+11dikEn1/JoIeBsgBjP6PSQJcNPKsbgHik74uK/KNAoML5FyuSvN7nEJHI76cHUI7hqkwk70z8qSLZlxo9AYL/U0lz24llb+e1oi9x/1mb+cDWua2iOU5vWDPD0/bR1kdstV2Dus9dOrdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TZgdKOkh; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TZgdKOkh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7994F21A3D;
	Wed, 10 Jul 2024 09:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720604242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AdPWVWbyk6GilbYgK6r8iH+eFHHYovKHeB/OAj0wy+c=;
	b=TZgdKOkhaj2jtwz2NuipEolNP1N5iaIqhW57xSDfdyghpruaSDvJYRDBh+398qPw1ob0SU
	/8L/yz79SPP5MAh823rx9yeTwc7NxgX3jxjnCJ/nq58S/tWfHgCrWE4esgVTqOTEWt1VX0
	d6C008hp4RiWebINz4In+RFulGEDglw=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720604242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AdPWVWbyk6GilbYgK6r8iH+eFHHYovKHeB/OAj0wy+c=;
	b=TZgdKOkhaj2jtwz2NuipEolNP1N5iaIqhW57xSDfdyghpruaSDvJYRDBh+398qPw1ob0SU
	/8L/yz79SPP5MAh823rx9yeTwc7NxgX3jxjnCJ/nq58S/tWfHgCrWE4esgVTqOTEWt1VX0
	d6C008hp4RiWebINz4In+RFulGEDglw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A8E6137D2;
	Wed, 10 Jul 2024 09:37:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kd4CBVJWjmaSWwAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 10 Jul 2024 09:37:22 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	xen-devel@lists.xenproject.org,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: [PATCH 0/2] x86/xen: cleanup of xen private headers
Date: Wed, 10 Jul 2024 11:37:16 +0200
Message-ID: <20240710093718.14552-1-jgross@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.60 / 50.00];
	BAYES_HAM(-2.80)[99.13%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.60
X-Spam-Level: 

Cleanup the private header files in arch/x86/xen by merging them into
one file and by removing unneeded stuff.

Juergen Gross (2):
  x86/xen: make some functions static
  x86/xen: eliminate some private header files

 arch/x86/xen/apic.c          |   2 -
 arch/x86/xen/debugfs.c       |   2 +-
 arch/x86/xen/debugfs.h       |   7 --
 arch/x86/xen/enlighten.c     |   2 -
 arch/x86/xen/enlighten_hvm.c |   2 -
 arch/x86/xen/enlighten_pv.c  |   4 -
 arch/x86/xen/mmu.c           |   3 +-
 arch/x86/xen/mmu.h           |  28 -------
 arch/x86/xen/mmu_hvm.c       |   2 +-
 arch/x86/xen/mmu_pv.c        |  15 ++--
 arch/x86/xen/multicalls.c    |   3 +-
 arch/x86/xen/multicalls.h    |  69 ----------------
 arch/x86/xen/p2m.c           |   2 -
 arch/x86/xen/pmu.c           |   1 -
 arch/x86/xen/pmu.h           |  22 ------
 arch/x86/xen/setup.c         |   1 -
 arch/x86/xen/smp.c           |   1 -
 arch/x86/xen/smp.h           |  51 ------------
 arch/x86/xen/smp_hvm.c       |   2 -
 arch/x86/xen/smp_pv.c        |   3 -
 arch/x86/xen/suspend.c       |   2 -
 arch/x86/xen/xen-ops.h       | 148 ++++++++++++++++++++++++++++++++++-
 include/xen/events.h         |   2 +
 23 files changed, 158 insertions(+), 216 deletions(-)
 delete mode 100644 arch/x86/xen/debugfs.h
 delete mode 100644 arch/x86/xen/mmu.h
 delete mode 100644 arch/x86/xen/multicalls.h
 delete mode 100644 arch/x86/xen/pmu.h
 delete mode 100644 arch/x86/xen/smp.h

-- 
2.43.0



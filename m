Return-Path: <linux-kernel+bounces-277738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 961D394A595
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6F391C213E9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75851D1F70;
	Wed,  7 Aug 2024 10:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ui9gXtc3";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ui9gXtc3"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604931C823D
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 10:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723026826; cv=none; b=UDoEClT4ek4iUmATViW06b5/43PZIA4h17yyLQuc155jpN9j9cMxEvL5MUGmImHfr72FX9FcWCsPKt1hg262yj6wGSpdvnDyS7XMcftyOCWYcw+Jeu8gnp0osVFVIX7dRkDsnHt9iwlubDYvN3wZIxLot5yFtH6j4uJJo+bfYcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723026826; c=relaxed/simple;
	bh=29gpPQrxiAC0TFM305q93oi+8eWHaIAl+jya4jk4VqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kvAztro4HgmkZHq1NEe60R2u/O0kNfr/JAibtkmEHjBNBqNjy8XVh3QsPkCvjUb/umVAZGV/vyf9SdoacruvdnPnAMShEW75+SChUXxZ25qS4j6tbdUv0+iSlDXrY/Q4cWoyCdeDBsTox5OkgEpJPLQmZ7Y7198B7RH0mgDveQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ui9gXtc3; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ui9gXtc3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7906F1F86A;
	Wed,  7 Aug 2024 10:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723026821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qsPSyX3JmaVc+f4Tkm+uJmQXt6zFhh500l0/kg//IC8=;
	b=ui9gXtc3qWxb6jKcxoJev/mYYLyE6GwG3QInrdzyJV7NL/OW2WM86pC8F9OC4BkA/qx0q2
	Uqc58iyxU0aJDBQbCJM5ZSxFGmnbjzmNjrZTxedCwQ/xoqGR3nc62gqGTfqEDWQts6NjPg
	RW0VLoMG2vYPHNSFA4q2Ix29zjTpwHg=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ui9gXtc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723026821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qsPSyX3JmaVc+f4Tkm+uJmQXt6zFhh500l0/kg//IC8=;
	b=ui9gXtc3qWxb6jKcxoJev/mYYLyE6GwG3QInrdzyJV7NL/OW2WM86pC8F9OC4BkA/qx0q2
	Uqc58iyxU0aJDBQbCJM5ZSxFGmnbjzmNjrZTxedCwQ/xoqGR3nc62gqGTfqEDWQts6NjPg
	RW0VLoMG2vYPHNSFA4q2Ix29zjTpwHg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 208F213297;
	Wed,  7 Aug 2024 10:33:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id e4WABoVNs2beHwAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 07 Aug 2024 10:33:41 +0000
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
	xen-devel@lists.xenproject.org
Subject: [PATCH 0/5] xen: fix dom0 PV boot on some AMD machines
Date: Wed,  7 Aug 2024 12:33:31 +0200
Message-ID: <20240807103338.22007-1-jgross@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 7906F1F86A

There have been reports of failed boots with Xen due to an overlap of
the kernel's memory with ACPI NVS reported in the E820 map of the host.

This series fixes this issue by moving the NVS area in dom0 to some
higher address.

Juergen Gross (5):
  xen: use correct end address of kernel for conflict checking
  xen: introduce generic helper checking for memory map conflicts
  xen: move checks for e820 conflicts further up
  xen: move max_pfn in xen_memory_setup() out of function scope
  xen: tolerate ACPI NVS memory overlapping with Xen allocated memory

 arch/x86/xen/mmu_pv.c  |   5 +-
 arch/x86/xen/setup.c   | 242 +++++++++++++++++++++++++++++++++--------
 arch/x86/xen/xen-ops.h |   3 +-
 3 files changed, 201 insertions(+), 49 deletions(-)

-- 
2.43.0



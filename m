Return-Path: <linux-kernel+bounces-277753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFD094A5E4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D9711F22E82
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11141C0DEF;
	Wed,  7 Aug 2024 10:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="c9s8q1h7";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="c9s8q1h7"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B131C6892
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 10:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027277; cv=none; b=QdDNINe8aT6TZ0Qw1QIZx4nSjnoOZyTtXyZzA/u9VZx1Q5rMRPGdLM7lHa079hY1JM8nN074YkwV8TQbQVbJbGAcjvYvonbAg37BsZTpY3+7VVs/hI1r0b0FbtrvCpcMUdoNgu1VAyVKDbY/sj+vL56boAoQCEkcshjE0hT3gNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027277; c=relaxed/simple;
	bh=29gpPQrxiAC0TFM305q93oi+8eWHaIAl+jya4jk4VqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PXWNQGiU0MqTZtQfEvEYiYmWb4qqFOA4ayz+srmtlNhv97Cn5tOCnFyMDB9Hy04YADaMMxzsl0IBVJ6HAAIYxgilhdpopDzYgzTJ59uhEYtS/3sz+LcU2AKtETubHq2FZnaa2mPkqe7xR7p6bFU8OwGazeN9zoe8b7Z7+PVSy9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=c9s8q1h7; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=c9s8q1h7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DD82721CFD;
	Wed,  7 Aug 2024 10:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723027273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qsPSyX3JmaVc+f4Tkm+uJmQXt6zFhh500l0/kg//IC8=;
	b=c9s8q1h7PuFNImDLnrn5CfMWUTg74m3RiiPv7cGwuc7yVANsH0pAOJAzvKj03s74HCs3ct
	uTMCIRl7eZCR+smQVnPEwaO0tXocBn1NJKEVKKHy8k1NGFfF+8YCMa0CyGhE9xbumEfvno
	G/T0xDuiWPCfOAttYvwmw56XIT0DgcY=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723027273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qsPSyX3JmaVc+f4Tkm+uJmQXt6zFhh500l0/kg//IC8=;
	b=c9s8q1h7PuFNImDLnrn5CfMWUTg74m3RiiPv7cGwuc7yVANsH0pAOJAzvKj03s74HCs3ct
	uTMCIRl7eZCR+smQVnPEwaO0tXocBn1NJKEVKKHy8k1NGFfF+8YCMa0CyGhE9xbumEfvno
	G/T0xDuiWPCfOAttYvwmw56XIT0DgcY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81B6E13297;
	Wed,  7 Aug 2024 10:41:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3omfHUlPs2YBIgAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 07 Aug 2024 10:41:13 +0000
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
Date: Wed,  7 Aug 2024 12:41:05 +0200
Message-ID: <20240807104110.18117-1-jgross@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
X-Spam-Flag: NO
X-Spam-Level: 

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



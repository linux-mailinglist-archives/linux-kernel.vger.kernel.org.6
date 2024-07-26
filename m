Return-Path: <linux-kernel+bounces-263079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2301193D0B0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 545421C213AE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32903176AB8;
	Fri, 26 Jul 2024 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dMfzfwgc";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dMfzfwgc"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEB0219EA
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 09:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721987883; cv=none; b=T1HrB4XU7AaMD/vjceFvsakBh5kV+knROQXV9Irc0VTbcfPEISt32nrK/56BGt99Qcbsudl1f1qVklWB05O98xk8O51fBcQJe0FUTBZgqPGbqRjLV+vFI4sjfuI4lTxyYjgIHwmSrHFkWH3Rga+pcJ15AWHJTf4qaS5uazmtW5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721987883; c=relaxed/simple;
	bh=XRf+e0x49BqDCz5MbtFuqrM/OZATQYuaaVvnFexu24c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WF2PSR03alVa26/IIfuEIPVqlYK7ns3ipRoE1po0g0w1rg/4DFDGBHqQe+sq4aaKKvp/WNaHwDNekpoGw2AUqALh9AX5AjKEHGyjd6rC2iDp5taTJvhPk1p4rrz+nMBIOeJ2N7RBZBBgNOHD0qc9GgIOfWQTRNqqmetj/UvberI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dMfzfwgc; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dMfzfwgc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BA8C61F892;
	Fri, 26 Jul 2024 09:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721987879; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1knbRafuZJdjClcPDZqqUCWVZiNFY1gGFmGIQ1GvI/U=;
	b=dMfzfwgczwDGZ9T7UZGIzIQ9LaT1E99Pvl1lrdn/YDSbRkKh/E5W7OIn4kJzatFhQv/Yfx
	/lkwhqtwvBZmkgRmidk8vE/sXTTBv3Xhr0+HQcq57VJCHbr2X4isJP+PzLCj7HppgWcnR8
	jmLG21dlXOefdMYiWwRASOnWKaVYT/k=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721987879; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1knbRafuZJdjClcPDZqqUCWVZiNFY1gGFmGIQ1GvI/U=;
	b=dMfzfwgczwDGZ9T7UZGIzIQ9LaT1E99Pvl1lrdn/YDSbRkKh/E5W7OIn4kJzatFhQv/Yfx
	/lkwhqtwvBZmkgRmidk8vE/sXTTBv3Xhr0+HQcq57VJCHbr2X4isJP+PzLCj7HppgWcnR8
	jmLG21dlXOefdMYiWwRASOnWKaVYT/k=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8646F1396E;
	Fri, 26 Jul 2024 09:57:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QHT2Hidzo2Y9TgAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 26 Jul 2024 09:57:59 +0000
From: Juergen Gross <jgross@suse.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	sstabellini@kernel.org
Subject: [GIT PULL] xen: branch for v6.11-rc1 take 2
Date: Fri, 26 Jul 2024 11:57:58 +0200
Message-ID: <20240726095758.15879-1-jgross@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.60 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.11-rc1a-tag

xen: branch for v6.11-rc1 take 2

It contains 2 fixes for issues introduced in this merge window:

- one for enhanced debugging in the Xen multicall handling

- a series with 2 patches fixing a boot failure when running as dom0 in
  PVH mode

Thanks.

Juergen

 arch/x86/include/asm/xen/hypervisor.h |   5 --
 arch/x86/platform/pvh/enlighten.c     |   3 -
 arch/x86/xen/enlighten_pvh.c          | 107 ++++++++++++++++++----------------
 arch/x86/xen/multicalls.c             |  19 +++---
 arch/x86/xen/smp_pv.c                 |   1 +
 arch/x86/xen/xen-ops.h                |   3 +
 6 files changed, 74 insertions(+), 64 deletions(-)

Juergen Gross (1):
      xen: fix multicall debug data referencing

Roger Pau Monne (2):
      x86/xen: move xen_reserve_extra_memory()
      x86/xen: fix memblock_reserve() usage on PVH


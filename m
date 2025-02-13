Return-Path: <linux-kernel+bounces-512512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A43A33A52
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26BD23A7102
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 08:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F53C20C01E;
	Thu, 13 Feb 2025 08:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ajQAG182";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ajQAG182"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4B62063DA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739436944; cv=none; b=tKpefE6S1rlTlooEhVc4MUF75xuptxoUqAWiavdbQYus0vhYYFS+MW8piHQ4YXmkL5ZJSrnlSjhzwSbtEdAccAInoPAVLM/lHrODvUtXtQ6JQimh/zysbGVmopkcVn0lf+joqNJR+ZDL79BBidsBOHnKQ1LfwDjqXegHQGTbscI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739436944; c=relaxed/simple;
	bh=l0geTxDlQteuQqauKvsshWGcclhOIB4qO6Um2LY9Biw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F/VfE0JqhKvSMDDabrZXDqRdlwMWn0niJrjcvVkeVPG7X00/s/wNnwx0+Ygr2oovAvy3bdeKe+xmTrFHAFId/JkOztfc+xiMEV5PRMK/7/K6hAJbfHJZORGEClNiMe4/vXfdMKitGngKglvD7UdFGUhXqsNQpwKPfy9g/l0OUIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ajQAG182; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ajQAG182; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3B4A52295F;
	Thu, 13 Feb 2025 08:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739436941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dvp+2zva3b1OzC9c49Z/oXKVc7Zk8EYxQY79anNSCaA=;
	b=ajQAG1827NLagTbTwYjbfqQpSVsCL9eywPM/N7ZN63lNQYOI5o/irGXlYPnLcGmryG1TwU
	Bt2mljd+T16zbOo+h8qZA30lhYwzIjATaCPxa4HAPErBPIKbco6haDbLyPcmWJDhQAWtX7
	UadBSlkpVPO2nglFEQoSN1iI2SoVrfQ=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ajQAG182
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739436941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dvp+2zva3b1OzC9c49Z/oXKVc7Zk8EYxQY79anNSCaA=;
	b=ajQAG1827NLagTbTwYjbfqQpSVsCL9eywPM/N7ZN63lNQYOI5o/irGXlYPnLcGmryG1TwU
	Bt2mljd+T16zbOo+h8qZA30lhYwzIjATaCPxa4HAPErBPIKbco6haDbLyPcmWJDhQAWtX7
	UadBSlkpVPO2nglFEQoSN1iI2SoVrfQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2402137DB;
	Thu, 13 Feb 2025 08:55:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8W7qLYyzrWcCdgAAD6G6ig
	(envelope-from <jgross@suse.com>); Thu, 13 Feb 2025 08:55:40 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 0/2] xen/swiotlb: two fixes
Date: Thu, 13 Feb 2025 09:55:36 +0100
Message-ID: <20250213085538.17060-1-jgross@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3B4A52295F
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Patch 1 removes an unneeded alignment requirement, which resulted in
exhausting the SWIOTLB with normal use cases.

Patch 2 allows to allocate larger continuous regions by reallocating
the frame list if needed.

Changes in V2:
- drop former patch 2 for now in order to avoid more lengthy discussion
- new patch 2

Juergen Gross (2):
  xen/swiotlb: relax alignment requirements
  x86/xen: allow larger contiguous memory regions in PV guests

 arch/x86/xen/mmu_pv.c     | 71 ++++++++++++++++++++++++++++++++++-----
 drivers/xen/swiotlb-xen.c | 20 ++++++-----
 2 files changed, 74 insertions(+), 17 deletions(-)

-- 
2.43.0



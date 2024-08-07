Return-Path: <linux-kernel+bounces-277756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B220994A5FF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A759B203D8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7842C1E2134;
	Wed,  7 Aug 2024 10:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qnE8fYFP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qnE8fYFP"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034301E4EF1
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 10:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027294; cv=none; b=LKQ8v1Uc+Afw415ezHFrW2FwvrY6bhvTfh8w50s73O8WRugAjj865VukHDdrsPIdW0Q+EmbRCf06VsmP+C94U7fKHZLyb3U7h9n/008RI7wcZEDMMQMkJs3fIf/5Vu0GtdOPaAJlVW8cp/TB7JqJLGdUSVra+j4ytFFMiV6JRho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027294; c=relaxed/simple;
	bh=lR2WsDlOYl/ZUfQPjJQt0WsulZRzgAzEfNlMyfU4TCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lSXXtTcyTK2TIivVMBBgHl5GGz3w2+NLM+zSQELS0o8XzotdPHKf21asIJxJcHvPFBzbra3y+oi28JnfnZuXq80awxm6jMptcR4DHzuU4yaAg8GS6wd7XJ0suj6B9pwoaQ98zos3MjcVMG69aG9RguQsN/epKiRGqV31baeyN/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qnE8fYFP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qnE8fYFP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4718221D09;
	Wed,  7 Aug 2024 10:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723027291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dWJJMR8rBuh/QPRtNN+RcR8hDqRUcjKWCA7J80NLso8=;
	b=qnE8fYFP4gwW+nXwpdR80jZOfndfb8Y101T9TucjArPeBoAuu5NCh26FxkpLUfqHm9d337
	JJGGWMlPMDTnN/dryUuQj5wuXwoQlK1gJI5n+rZauRhzL4t5mdByRms8c8ghks23PYC8jV
	a+m5cWwebAIabk/tl0zpo/Yk4UK4HLQ=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723027291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dWJJMR8rBuh/QPRtNN+RcR8hDqRUcjKWCA7J80NLso8=;
	b=qnE8fYFP4gwW+nXwpdR80jZOfndfb8Y101T9TucjArPeBoAuu5NCh26FxkpLUfqHm9d337
	JJGGWMlPMDTnN/dryUuQj5wuXwoQlK1gJI5n+rZauRhzL4t5mdByRms8c8ghks23PYC8jV
	a+m5cWwebAIabk/tl0zpo/Yk4UK4HLQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCB2113297;
	Wed,  7 Aug 2024 10:41:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id su46NFpPs2YkIgAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 07 Aug 2024 10:41:30 +0000
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
	=?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Subject: [PATCH 3/5] xen: move checks for e820 conflicts further up
Date: Wed,  7 Aug 2024 12:41:08 +0200
Message-ID: <20240807104110.18117-4-jgross@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240807104110.18117-1-jgross@suse.com>
References: <20240807104110.18117-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	REPLY(-4.00)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,invisiblethingslab.com:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30

Move the checks for e820 memory map conflicts using the
xen_chk_is_e820_usable() helper further up in order to prepare
resolving some of the possible conflicts by doing some e820 map
modifications, which must happen before evaluating the RAM layout.

Signed-off-by: Juergen Gross <jgross@suse.com>
Tested-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
---
 arch/x86/xen/setup.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
index 96765180514b..dba68951ed6b 100644
--- a/arch/x86/xen/setup.c
+++ b/arch/x86/xen/setup.c
@@ -764,6 +764,28 @@ char * __init xen_memory_setup(void)
 	/* Make sure the Xen-supplied memory map is well-ordered. */
 	e820__update_table(&xen_e820_table);
 
+	/*
+	 * Check whether the kernel itself conflicts with the target E820 map.
+	 * Failing now is better than running into weird problems later due
+	 * to relocating (and even reusing) pages with kernel text or data.
+	 */
+	xen_chk_is_e820_usable(__pa_symbol(_text),
+			       __pa_symbol(_end) - __pa_symbol(_text),
+			       "kernel");
+
+	/*
+	 * Check for a conflict of the xen_start_info memory with the target
+	 * E820 map.
+	 */
+	xen_chk_is_e820_usable(__pa(xen_start_info), sizeof(*xen_start_info),
+			       "xen_start_info");
+
+	/*
+	 * Check for a conflict of the hypervisor supplied page tables with
+	 * the target E820 map.
+	 */
+	xen_pt_check_e820();
+
 	max_pages = xen_get_max_pages();
 
 	/* How many extra pages do we need due to remapping? */
@@ -836,28 +858,6 @@ char * __init xen_memory_setup(void)
 
 	e820__update_table(e820_table);
 
-	/*
-	 * Check whether the kernel itself conflicts with the target E820 map.
-	 * Failing now is better than running into weird problems later due
-	 * to relocating (and even reusing) pages with kernel text or data.
-	 */
-	xen_chk_is_e820_usable(__pa_symbol(_text),
-			       __pa_symbol(_end) - __pa_symbol(_text),
-			       "kernel");
-
-	/*
-	 * Check for a conflict of the xen_start_info memory with the target
-	 * E820 map.
-	 */
-	xen_chk_is_e820_usable(__pa(xen_start_info), sizeof(*xen_start_info),
-			       "xen_start_info");
-
-	/*
-	 * Check for a conflict of the hypervisor supplied page tables with
-	 * the target E820 map.
-	 */
-	xen_pt_check_e820();
-
 	xen_reserve_xen_mfnlist();
 
 	/* Check for a conflict of the initrd with the target E820 map. */
-- 
2.43.0



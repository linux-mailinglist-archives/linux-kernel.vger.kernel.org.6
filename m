Return-Path: <linux-kernel+bounces-190024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A398CF87E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 06:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 541B61F2189E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 04:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB963C152;
	Mon, 27 May 2024 04:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gPTRxz2P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bxxPY0R+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gPTRxz2P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bxxPY0R+"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D34F184E
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 04:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716785133; cv=none; b=ugAJGhP9ixu5cjtLeIcYipefveEO+LxgoAop853Wp5nmENOj81EjiBCHPOZiV+cxdfToFu848KvP/PJ/TMSHhhsjuZ44jeENtM/Hk/Sbx+GuzMSGIRL7qDlx+ElvNy3mY3sVEsDHI1dHn2q1+Zn/uxAo9Okm29faINAYr0EmWv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716785133; c=relaxed/simple;
	bh=vWnKz8YceAuk3+rmKsA0sVzpPp6nNjiayV2oP+KKXqs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eNv4vyd3+KdSFJnR0i3aDoF/Vxt8bSxNx0kPdbUYQYjCtMXu8SyCc23I2eqCl7oLstfE2uHQP9m6NyGapA3RDLLCJ4bHz06rMLBPKPe3o+gSGNEAXNCGI6IOtHrOhdIumIose2aedsk8ZFmxKYTfaOksiDvInJG7QoYYiEiXXMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gPTRxz2P; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bxxPY0R+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gPTRxz2P; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bxxPY0R+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5091821C1F;
	Mon, 27 May 2024 04:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716785128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oHKis1I+pOLkw8HJby/EOpRamivMlzj/kg+HseG/UBU=;
	b=gPTRxz2P1cvBtmYcISxLv90rBSx3eg7xf6Q6e8Ne/Tfj7nXS76Fjso7cuhVUtMwfrU4RnA
	gU0/lKD3rJuI24MQn1LtOPqjLGl8bLdQapZ2VzOVMuLFcsb2JSD6rQoaSVLqGtzvz3aKDx
	sz0Tn61BUi9pAhhWVVN8x+yoV41HlWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716785128;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oHKis1I+pOLkw8HJby/EOpRamivMlzj/kg+HseG/UBU=;
	b=bxxPY0R+FYw57tSbnus1M4y/dKtMOYwZVxJjS9186MtJq3Hs7+kHx4JfEOtATQJ+douKwR
	kcZE3+aooqjGCvAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gPTRxz2P;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bxxPY0R+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716785128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oHKis1I+pOLkw8HJby/EOpRamivMlzj/kg+HseG/UBU=;
	b=gPTRxz2P1cvBtmYcISxLv90rBSx3eg7xf6Q6e8Ne/Tfj7nXS76Fjso7cuhVUtMwfrU4RnA
	gU0/lKD3rJuI24MQn1LtOPqjLGl8bLdQapZ2VzOVMuLFcsb2JSD6rQoaSVLqGtzvz3aKDx
	sz0Tn61BUi9pAhhWVVN8x+yoV41HlWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716785128;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oHKis1I+pOLkw8HJby/EOpRamivMlzj/kg+HseG/UBU=;
	b=bxxPY0R+FYw57tSbnus1M4y/dKtMOYwZVxJjS9186MtJq3Hs7+kHx4JfEOtATQJ+douKwR
	kcZE3+aooqjGCvAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5B1913A6B;
	Mon, 27 May 2024 04:45:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JZ3/MOcPVGYLMQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 27 May 2024 04:45:27 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH] arch/x86: Do not explicitly clear Reserved flag in free_pagetable
Date: Mon, 27 May 2024 06:45:23 +0200
Message-ID: <20240527044523.29207-1-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.71
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5091821C1F
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.71 / 50.00];
	BAYES_HAM(-2.70)[98.67%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email]

In free_pagetable() we use the non-atomic version for clearing the
PageReserved bit from the page.
free_pagetable() will either call free_reserved_page() or
put_page_bootmem(), which will eventually end up calling
free_serverd_page(), and in there we already clear the PageReserved flag.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
This has been like this since commit ae9aae9eda2d ("memory-hotplug: common APIs to
support page tables hot-remove"), so I might be missing something obvious, but
I cannot explain why we would need that __ClearPageReserved upfront, when
free_reserved_pages() already does that for us.
---
 arch/x86/mm/init_64.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 7e177856ee4f..9f4778c2cf9f 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -980,8 +980,6 @@ static void __meminit free_pagetable(struct page *page, int order)
 
 	/* bootmem page has reserved flag */
 	if (PageReserved(page)) {
-		__ClearPageReserved(page);
-
 		magic = page->index;
 		if (magic == SECTION_INFO || magic == MIX_SECTION_INFO) {
 			while (nr_pages--)
-- 
2.45.1



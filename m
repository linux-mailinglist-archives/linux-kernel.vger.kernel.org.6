Return-Path: <linux-kernel+bounces-240525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 522C4926E78
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0DB7B25DCC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3DF4655D;
	Thu,  4 Jul 2024 04:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sTaFfZGs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CWK1uG79";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bqsFGOa2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="B6iVvmiy"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC889146A99
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067557; cv=none; b=umKpN7aV4KXslCKKT145tRrDiZrxpSkhj6hABI97MPP70OnSfUlXlj7lY2yNL3SfFrwrCf4A+0oe8s/h24VMuG1KmXKQfZdD4LjBM9RdesMwBXZHy1IaM+EwdO1mODddK2F/mXOZB//Cu6QAHqGoaUDWcYhkv/gnVM/kv4DV6Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067557; c=relaxed/simple;
	bh=EGWKGVBtZJssI002yVffnY9LfU+kgVhFuG/CZwPEkcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WS1vV/OgTpgHmSjfQw11JGgT91joiqt5gRjBMoNZlbIKJ8zDpIjt+CHOigX+vTkyNj2uIkqMOG2Ecn42UAJrGeHDVoubp54ChX0gd5xXX7h8rW0yHK6kbbEA/amEqNHU4s9hIwV70FgwCmEOELeow9tbhdhGK8vpGAjng0F7yrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sTaFfZGs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CWK1uG79; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bqsFGOa2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=B6iVvmiy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 215491FCFB;
	Thu,  4 Jul 2024 04:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720067554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sh4f2O4+wRTS3lNqvGwH972LquLk6Sxiod9/OijqLHw=;
	b=sTaFfZGsh0QN0KmSZGZupmvc9+i8aT6yh6wqcxWRjw+XHu1zEisZrGN4NNNyCZDSvyJGEU
	PFjK4MlwkHT8GncglykUIdk+8ISfhp13f+z8nTbaYj1t2I52ze+OrMapZLKDq37mK/EAY8
	up94b5BLuEXKnEEwf9Dw0eVYsTwPEig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720067554;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sh4f2O4+wRTS3lNqvGwH972LquLk6Sxiod9/OijqLHw=;
	b=CWK1uG79vcWta/RwK11oIoeDmAvTnhOeCFGg5+Xlvmv5A/bL50Ok8Y/E9WOG3clC5ufnFC
	Qi1EyHmHHAYPxtAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720067553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sh4f2O4+wRTS3lNqvGwH972LquLk6Sxiod9/OijqLHw=;
	b=bqsFGOa2yGJrOu6R6Wz97cBOkJkF3/uec0u9bnCDleCJ/vApP0GE8p/TCajg1w1b3lZVJQ
	Wb9dzSwUbpFaSXKXl4Q6eXjlUVVBl4JNvifi+kag3LCsXlCHFKonxim9J8IEGBEX9C5QV0
	GiEpgBU7SWbf0a+5Jsh7OpzPXIYc/BU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720067553;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sh4f2O4+wRTS3lNqvGwH972LquLk6Sxiod9/OijqLHw=;
	b=B6iVvmiyIQfFPvvBsrtHLZj8Lm+q7MF8LvHMT8cMfsKfCmslqOG4WdKgUVsuxWbCfOn648
	Wa2GOQPr90SaqfAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0D7D13889;
	Thu,  4 Jul 2024 04:32:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OPOFNd8lhmbnDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 04:32:31 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Peter Xu <peterx@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	SeongJae Park <sj@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Michal Hocko <mhocko@suse.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 34/45] arch/powerpc: Skip hugetlb vmas in subpage_mark_vma_nohuge
Date: Thu,  4 Jul 2024 06:31:21 +0200
Message-ID: <20240704043132.28501-35-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240704043132.28501-1-osalvador@suse.de>
References: <20240704043132.28501-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_RATELIMIT(0.00)[to_ip_from(RLghcz9uomn9ay1xnuhrww8uur)];
	RCVD_TLS_ALL(0.00)[]

Skip hugetlb vmas as we are not interested in those.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 arch/powerpc/mm/book3s64/subpage_prot.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/mm/book3s64/subpage_prot.c b/arch/powerpc/mm/book3s64/subpage_prot.c
index ec98e526167e..dd529adda87f 100644
--- a/arch/powerpc/mm/book3s64/subpage_prot.c
+++ b/arch/powerpc/mm/book3s64/subpage_prot.c
@@ -159,6 +159,8 @@ static void subpage_mark_vma_nohuge(struct mm_struct *mm, unsigned long addr,
 	 * VM_NOHUGEPAGE and split them.
 	 */
 	for_each_vma_range(vmi, vma, addr + len) {
+		if (is_vm_hugetlb_page(vma))
+			continue;
 		vm_flags_set(vma, VM_NOHUGEPAGE);
 		walk_page_vma(vma, &subpage_walk_ops, NULL);
 	}
-- 
2.26.2



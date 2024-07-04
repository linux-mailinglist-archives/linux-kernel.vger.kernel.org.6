Return-Path: <linux-kernel+bounces-240506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 108D1926E63
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FD9EB24348
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA13B142E6F;
	Thu,  4 Jul 2024 04:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="reCsEU+x";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cWSSs/Dz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="reCsEU+x";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cWSSs/Dz"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9218913D244
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067532; cv=none; b=EbzTnSXTylcgz7BsLtuC3Mp6Xveqrz48fh6LHvGmATUwozCznbT6/W62JU5OLxoAvcPd29BfW2nyOFCMGWBc8eGWD+tWZWT+aPEt+X7KXDx8DEGeGIFFmKGrD6gTMSXQQrqbXgcOKWyZmPFNLDyQ/nRyK5jCw8ndfGhEqmNjerE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067532; c=relaxed/simple;
	bh=eyJY9NWoZ4hgVK9bByr04uTn+2RTeLXcPqA2C30/qTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNhVHK2iQoVyG6xrH0TCiIhBGuUqlOdUct54iCWKFMgKBXhHc0aKAFD5vtCkrlCJKkl0AOrsrLPpbNIgxYMwsfHXa5S91sA4enw2IyxVQO8JEs/EgpcmuddlM6mZb1AwGat05gsesudYtcqUpd9yiD2M5Xgk0j1W4J8LZEG9G/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=reCsEU+x; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cWSSs/Dz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=reCsEU+x; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cWSSs/Dz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E2CC31FCFB;
	Thu,  4 Jul 2024 04:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720067528; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fM4emcZ2cxXRGcFoZk72IXVFIB/7cc45xsWWyiF4u+4=;
	b=reCsEU+xOf0IC135atdv1qtTW7GwE3KuG5U1k4v+SluCIY6H3D2FUi8FAWIyXYCZIx84yW
	2P3PP6oHEwHguqWCpYJ2Wi1pGYR41wpaVnU4D4lDnskSWrRP5eI4/8eoAU1cZhaAgG1ovS
	/ddxekibmWnrHYkaVCjv2+cJtRQFDJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720067528;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fM4emcZ2cxXRGcFoZk72IXVFIB/7cc45xsWWyiF4u+4=;
	b=cWSSs/Dz6GKtXty5+7bttcX9oK91QygswkqdEf4rRjRzvfkLm/fnE40h99EAYCwuc44cs1
	Y9XuXXYLWDeZrCBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720067528; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fM4emcZ2cxXRGcFoZk72IXVFIB/7cc45xsWWyiF4u+4=;
	b=reCsEU+xOf0IC135atdv1qtTW7GwE3KuG5U1k4v+SluCIY6H3D2FUi8FAWIyXYCZIx84yW
	2P3PP6oHEwHguqWCpYJ2Wi1pGYR41wpaVnU4D4lDnskSWrRP5eI4/8eoAU1cZhaAgG1ovS
	/ddxekibmWnrHYkaVCjv2+cJtRQFDJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720067528;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fM4emcZ2cxXRGcFoZk72IXVFIB/7cc45xsWWyiF4u+4=;
	b=cWSSs/Dz6GKtXty5+7bttcX9oK91QygswkqdEf4rRjRzvfkLm/fnE40h99EAYCwuc44cs1
	Y9XuXXYLWDeZrCBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A7B8713889;
	Thu,  4 Jul 2024 04:32:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cGPCI8clhmbnDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 04:32:07 +0000
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
Subject: [PATCH 15/45] fs/proc: Adjust pte_to_pagemap_entry for hugetlb vmas
Date: Thu,  4 Jul 2024 06:31:02 +0200
Message-ID: <20240704043132.28501-16-osalvador@suse.de>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_RATELIMIT(0.00)[to_ip_from(RLghcz9uomn9ay1xnuhrww8uur)];
	RCVD_TLS_ALL(0.00)[]

HugeTLB pages cannot be swapped , so do not mark them as that.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 fs/proc/task_mmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 5965a074467e..22200018371d 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1795,7 +1795,8 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 			frame = swp_type(entry) |
 			    (offset << MAX_SWAPFILES_SHIFT);
 		}
-		flags |= PM_SWAP;
+		if (!is_vm_hugetlb_page(vma))
+			flags |= PM_SWAP;
 		if (is_pfn_swap_entry(entry))
 			page = pfn_swap_entry_to_page(entry);
 		if (pte_marker_entry_uffd_wp(entry))
-- 
2.26.2



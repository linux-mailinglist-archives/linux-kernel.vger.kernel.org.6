Return-Path: <linux-kernel+bounces-240533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA54E926E80
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 272B31C22182
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167CE149C7F;
	Thu,  4 Jul 2024 04:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="f6TMrMH1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7wTQx6i+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="f6TMrMH1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7wTQx6i+"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B9D14901B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067566; cv=none; b=k7hwlktjpX+XsPXGd/G9eLoIea0V1E89MS3QNCwagJZi9R/JmpIyXQCADcbJ2WnEygvqIxp0Nys/gRSq7JOQG6eEuK99MUUvSO6ScZDPNWoUpujizbUU2cQg3CAVyGiUzZVzFz/yewC2M60u8n8OhHSVlkFfvUxys1n/7KyU7v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067566; c=relaxed/simple;
	bh=SvWtT8eXdxiInxt0lWb3Rj5G0POa5eYV4UnyF6GLYLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c3+pXD3Ql530GO5v/ZvM/EMdiARqPOhw2wMgHLOipzErPWL3Q4Dxhe5HwdPPlCKJ4/wPf4VVqc0fld0qkiPjfC3dL9coSDsBHyny0x0f1zrjKRRQ3YFtyNCptHe6KwOWFT/ovyIkv9+IDjeSr3qBlzNmDhDCGW8Hdn7jIWNqm3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=f6TMrMH1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7wTQx6i+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=f6TMrMH1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7wTQx6i+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 69E391FCFA;
	Thu,  4 Jul 2024 04:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720067563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OvwrckhnGQ1ia89v5nuOKOB6N7ZG52TVWWVE7z3ysd0=;
	b=f6TMrMH1l0DF/S8bfNE80GfcQ/4KU9eJ27sxLCy3LzyHrHWU4yVZdFy7kYhwfc7mVnZVdu
	xsRX3Nb1px3A9NnzgBOX5ai81npXNqEkbHs8Yk6Z2158wI9WwdgLuclp+kv3Leuji+b1kc
	vOC5FehQO0GHOMoxqJ/B9oV+I3yygyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720067563;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OvwrckhnGQ1ia89v5nuOKOB6N7ZG52TVWWVE7z3ysd0=;
	b=7wTQx6i+oEK8SbN8wor1yxW+lVrtevHmwonbwTOp+kRSZvWPS1cw79vzxMRpqgGlJBhIHR
	U7Fz/q4+qA9HUzCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720067563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OvwrckhnGQ1ia89v5nuOKOB6N7ZG52TVWWVE7z3ysd0=;
	b=f6TMrMH1l0DF/S8bfNE80GfcQ/4KU9eJ27sxLCy3LzyHrHWU4yVZdFy7kYhwfc7mVnZVdu
	xsRX3Nb1px3A9NnzgBOX5ai81npXNqEkbHs8Yk6Z2158wI9WwdgLuclp+kv3Leuji+b1kc
	vOC5FehQO0GHOMoxqJ/B9oV+I3yygyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720067563;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OvwrckhnGQ1ia89v5nuOKOB6N7ZG52TVWWVE7z3ysd0=;
	b=7wTQx6i+oEK8SbN8wor1yxW+lVrtevHmwonbwTOp+kRSZvWPS1cw79vzxMRpqgGlJBhIHR
	U7Fz/q4+qA9HUzCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B28813889;
	Thu,  4 Jul 2024 04:32:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WEYNDuolhmbnDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 04:32:42 +0000
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
Subject: [PATCH 42/45] mm/memcontrol: Make mem_cgroup_move_test_walk skip hugetlb vmas
Date: Thu,  4 Jul 2024 06:31:29 +0200
Message-ID: <20240704043132.28501-43-osalvador@suse.de>
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
 mm/memcontrol-v1.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 99cc9501eec1..542922562cf9 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1319,8 +1319,20 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 	return ret;
 }
 
+static int mem_cgroup_move_test_walk(unsigned long start, unsigned long end,
+				     struct mm_walk *walk)
+{
+	struct vm_area_struct *vma = walk->vma;
+
+	if (is_vm_hugetlb_page(vma))
+		return 1;
+
+	return 0;
+}
+
 static const struct mm_walk_ops charge_walk_ops = {
 	.pmd_entry	= mem_cgroup_move_charge_pte_range,
+	.test_walk      = mem_cgroup_move_test_walk,
 	.walk_lock	= PGWALK_RDLOCK,
 };
 
-- 
2.26.2



Return-Path: <linux-kernel+bounces-174388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7888C0DF2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 12:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E71041F214B4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 10:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E819514B081;
	Thu,  9 May 2024 10:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iJNOMk0u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BJLLF2tH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iJNOMk0u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BJLLF2tH"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA8614AD14
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 10:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715248932; cv=none; b=ebB6/Qe+oCezOsHgow5UkAkwTrIOFIci8fg57kBrPTibiW8SG8mgMYhoiEkQcJnYrFbTpIo7D28L8qwM7vlJisJGj4jLeEq9mO7ZIEbcc59S5Nl7qAJsQcPrEpTNkmALqKNXFjehp407IBUYpttNSlstc7hGJpPe4nYcFrDb7Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715248932; c=relaxed/simple;
	bh=S7+PEDPOpa5VRXCzs5IETrmaM5wBA1i1MSuRVDnQ0hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HGMcvgXeXgJcwMdaJaiZKP5AbNOVrOG2vtkZsOHWzXAwrVADSMdir532Qx0PpgjLPjGT8ct4q5F+VPir7A1SKPOFvWwKXyHY0rCf95DMA0M4tJchp6ejSnYF7lQmJGuiL2JSBpuPN1SpE72tr0dGfeLDuEPjNi+eWGXH4yXnqpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iJNOMk0u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BJLLF2tH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iJNOMk0u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BJLLF2tH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B69B63822C;
	Thu,  9 May 2024 10:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715248928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KNxNDL8CliX5ScNdOouEVQHYdAYZp10dvdvoP0daPnA=;
	b=iJNOMk0uj9LwE54I1NK+1wuLoKmWR8NHqhes5O0I6nOw2c0mgraRXO0Jn5VZIuDLYGh8WS
	XcmF6vOUjsrojborzt5SKJXT59+bt3kWiKstg7jsjI3QWd4LXFKhG1LP46od9hRQLxmr7p
	yT7UKaS6mpNX7jmSgsKBmvAkwgfpFoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715248928;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KNxNDL8CliX5ScNdOouEVQHYdAYZp10dvdvoP0daPnA=;
	b=BJLLF2tHIR9ux5RHDbXoVxPGdfKBT9VErnyoHGNXwFuOttgPANSzh7bCOXm8+QpgRObb0/
	hsyZrh8Mu80ggSCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iJNOMk0u;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BJLLF2tH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715248928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KNxNDL8CliX5ScNdOouEVQHYdAYZp10dvdvoP0daPnA=;
	b=iJNOMk0uj9LwE54I1NK+1wuLoKmWR8NHqhes5O0I6nOw2c0mgraRXO0Jn5VZIuDLYGh8WS
	XcmF6vOUjsrojborzt5SKJXT59+bt3kWiKstg7jsjI3QWd4LXFKhG1LP46od9hRQLxmr7p
	yT7UKaS6mpNX7jmSgsKBmvAkwgfpFoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715248928;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KNxNDL8CliX5ScNdOouEVQHYdAYZp10dvdvoP0daPnA=;
	b=BJLLF2tHIR9ux5RHDbXoVxPGdfKBT9VErnyoHGNXwFuOttgPANSzh7bCOXm8+QpgRObb0/
	hsyZrh8Mu80ggSCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC2DD13941;
	Thu,  9 May 2024 10:02:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QOsjMx+fPGZbOAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 09 May 2024 10:02:07 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	Peter Xu <peterx@redhat.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Liu Shixin <liushixin2@huawei.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 1/2] mm/hugetlb: Add missing VM_FAULT_SET_HINDEX in hugetlb_fault
Date: Thu,  9 May 2024 12:01:47 +0200
Message-ID: <20240509100148.22384-2-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240509100148.22384-1-osalvador@suse.de>
References: <20240509100148.22384-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.98
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B69B63822C
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.98 / 50.00];
	BAYES_HAM(-2.97)[99.87%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]

commit af19487f00f3 ("mm: make PTE_MARKER_SWAPIN_ERROR more general") added
the code to handle pte_markers in hugetlb faulting path.
In case of an UFFD_POISON event, a PTE_MARKER_POISONED will be created and
we will return VM_FAULT_HWPOISON_LARGE upon detecting that in the fault path.
Add the missing VM_FAULT_SET_HINDEX, so the right si_addr_lsb will be passed
to userspace to report the extension of the faulty area.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/hugetlb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 33d175add044..262456daf327 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6485,7 +6485,8 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 				pte_marker_get(pte_to_swp_entry(vmf.orig_pte));
 
 			if (marker & PTE_MARKER_POISONED) {
-				ret = VM_FAULT_HWPOISON_LARGE;
+				ret = VM_FAULT_HWPOISON_LARGE |
+				      VM_FAULT_SET_HINDEX(hstate_index(h));
 				goto out_mutex;
 			}
 		}
-- 
2.44.0



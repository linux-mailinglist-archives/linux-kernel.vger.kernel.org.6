Return-Path: <linux-kernel+bounces-174389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A28F8C0DF3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 12:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2FF1F218BC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 10:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0929214B954;
	Thu,  9 May 2024 10:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yrG/oC93";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kBBKn7Nm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yrG/oC93";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kBBKn7Nm"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C803514B07E
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 10:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715248934; cv=none; b=lwnsmH1Z0OoB6sn2ZWYkkPMBZ4JiqdZsN5Fc4AsqfEWSMm9f9icU1er5hEXAMb7uwbcMx0xUuX+1CozRmNsRRPAvn76/pV8hcCFTJl/Ds/SK/ij/KNplpNHSvGl0X0sD9DePd0P1qxNooOWnrCJJBSJRW8zOqIvIONF55Q0/1MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715248934; c=relaxed/simple;
	bh=EGxnPS0yhiH1vdHZvJ5vJ0VsWmcUYd/h7Lji8/SatuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MamfGnjZ0B1pe6PonpITjF20jLPviXSDl2Tfr3RcH9KKZPoZcDK8NeswX6QEFPOlhRFsZFwgnrozzYQPFzedkEbG3/pfsLWCRA96q97jqRNWFUH6dulLZ9ri7LxqSXRxsAYwG1qQcnBDjyRyUWClIb+pe6LFlnFWwuKJNHqQNv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yrG/oC93; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kBBKn7Nm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yrG/oC93; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kBBKn7Nm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DC2345FC50;
	Thu,  9 May 2024 10:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715248930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fH9mcFMskWdh4UuFUQbCoC6swB7vTaoxR3AzCi/uWRg=;
	b=yrG/oC93h5JV8qQmse+DMDxdJ3XjcpoZ8p9RWPbh8qeIgBEK4uSnqJXtVl+5s5vB3Ir2oP
	gbL318bcbu5brHByri1fMi3aKj6H6X4TUb1QAgT0iEco9HOk/w8ffwlxdL832dk5VmZDXw
	BZlAyoxMZz7UEC75NwUYOkgb4qorXMU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715248930;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fH9mcFMskWdh4UuFUQbCoC6swB7vTaoxR3AzCi/uWRg=;
	b=kBBKn7Nmv3J/YzvrHjy1h4S3Y+YMOCrtdI5mhdpzd8xfufJcrmzRkM0Qyvz9ZaUPv/7p9f
	8EiDPJlRTErRyMCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715248930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fH9mcFMskWdh4UuFUQbCoC6swB7vTaoxR3AzCi/uWRg=;
	b=yrG/oC93h5JV8qQmse+DMDxdJ3XjcpoZ8p9RWPbh8qeIgBEK4uSnqJXtVl+5s5vB3Ir2oP
	gbL318bcbu5brHByri1fMi3aKj6H6X4TUb1QAgT0iEco9HOk/w8ffwlxdL832dk5VmZDXw
	BZlAyoxMZz7UEC75NwUYOkgb4qorXMU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715248930;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fH9mcFMskWdh4UuFUQbCoC6swB7vTaoxR3AzCi/uWRg=;
	b=kBBKn7Nmv3J/YzvrHjy1h4S3Y+YMOCrtdI5mhdpzd8xfufJcrmzRkM0Qyvz9ZaUPv/7p9f
	8EiDPJlRTErRyMCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C31B13941;
	Thu,  9 May 2024 10:02:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WHeLCSKfPGZbOAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 09 May 2024 10:02:10 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	Peter Xu <peterx@redhat.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Liu Shixin <liushixin2@huawei.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 2/2] mm/hugetlb: Add missing VM_FAULT_SET_HINDEX in hugetlb_wp
Date: Thu,  9 May 2024 12:01:48 +0200
Message-ID: <20240509100148.22384-3-osalvador@suse.de>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-2.44 / 50.00];
	BAYES_HAM(-2.64)[98.42%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.44
X-Spam-Flag: NO

commit 1cb9dc4b475c ("mm: hwpoison: support recovery from HugePage
copy-on-write faults") added support to use the mc variants when
coping hugetlb pages on CoW faults.
Add the missing VM_FAULT_SET_HINDEX, so the right si_addr_lsb will be
passed to userspace to report the extension of the faulty area.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 262456daf327..6be78e7d4f6e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6067,7 +6067,7 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
 		goto out_release_all;
 
 	if (copy_user_large_folio(new_folio, old_folio, vmf->real_address, vma)) {
-		ret = VM_FAULT_HWPOISON_LARGE;
+		ret = VM_FAULT_HWPOISON_LARGE | VM_FAULT_SET_HINDEX(hstate_index(h));
 		goto out_release_all;
 	}
 	__folio_mark_uptodate(new_folio);
-- 
2.44.0



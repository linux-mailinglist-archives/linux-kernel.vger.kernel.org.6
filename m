Return-Path: <linux-kernel+bounces-193075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 783F98D268C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28D31292C91
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6845A76033;
	Tue, 28 May 2024 20:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SMDNGdD2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pHenuFy/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mJq/oUDs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cE0EMu7N"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF6A45024
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 20:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716929613; cv=none; b=GsoJaKCg8w/c3XtZJErNMTY5bBuVlaLJa8nzH62IvKyFR2lNnXi+ke8GuIAtipa0xDMLwRn1QwP2jjbJGWx3z2a1y/aiaLTDNurzdkzfeoGTIupdfXNOrVErczOsvGldtSjXV85mTWPUz+Z0MtFgNRgoPrHfP0Ry2sgR4Y337Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716929613; c=relaxed/simple;
	bh=yout4lE/69Ndq9ktj93xfEwYhHC3lXUZBM+E2QimnfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WdsjxOACMnnpp19C4U1UT1WfIjK4lDQq7SC6+dToWA9f3IPlXETI94OYktHZW3DcflOFf4ja6KSHuo5G5qNIvnrfevkOgTs6hWLEyR0NRsbotIbxfvKXyKIP9C8vocFvt2uQO+GkuLvfAuvYTm9Pdm2NmM/5AM/o+raukjj0RPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SMDNGdD2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pHenuFy/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mJq/oUDs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cE0EMu7N; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 73DD921DFF;
	Tue, 28 May 2024 20:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716929609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nPM8/5iyaxn91F5FasQwKg49PMvS+vUFJtBXhbVxWmg=;
	b=SMDNGdD22P0C4uH2aqVY1PLOLm287seK9UMiCyzjsHZET0/c1fn9c/t0J9cNok7tfNY22X
	LTh6ie0iT7ksJQKjxWjlWbPF54lpWifpRTn7WhtVDs/ztYNqW/Qp8WMza+dgTIDZX2DrKl
	bxnfV35KnUolkpveqAR+493DHB2dHBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716929609;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nPM8/5iyaxn91F5FasQwKg49PMvS+vUFJtBXhbVxWmg=;
	b=pHenuFy/l0U7a3ZJtt248LPOzMdQ7X2uXabie+KXo/j+Wd3fiVxMIkaSgguj4opRm6MIz8
	euoVLf0D7Ki2eqAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="mJq/oUDs";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cE0EMu7N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716929608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nPM8/5iyaxn91F5FasQwKg49PMvS+vUFJtBXhbVxWmg=;
	b=mJq/oUDs9jaUsxIRgP/bGB0xFqDKVyajM7HTMMwXNPs34PCaqeM2N44FHojNPmM8krgYWC
	EsGAncgBp+cApro51J6FO7qAr7JP2ccOlQc/72ObKhlOZ7dfSk0iO7qLX4YueHDlq3rVrA
	f3DKapoogQlZpPE5j0LyIc1sdzYcCBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716929608;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nPM8/5iyaxn91F5FasQwKg49PMvS+vUFJtBXhbVxWmg=;
	b=cE0EMu7NbAKf1Se3PxBJLKSYA+UZzGv79MBqPqvHCqw/0sslaproiBoFzXuLERizxvtk2z
	XIt5r4oN7l01jbCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09C1413A6B;
	Tue, 28 May 2024 20:53:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id e2PSOkdEVmY2cAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 28 May 2024 20:53:27 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	Breno Leitao <leitao@debian.org>,
	Oscar Salvador <osalvador@suse.de>,
	syzbot+d3fe2dc5ffe9380b714b@syzkaller.appspotmail.com
Subject: [PATCH] mm/hugetlb: Do not call vma_add_reservation upon ENOMEM
Date: Tue, 28 May 2024 22:53:23 +0200
Message-ID: <20240528205323.20439-1-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.50
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 73DD921DFF
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.50 / 50.00];
	BAYES_HAM(-2.99)[99.94%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[d3fe2dc5ffe9380b714b];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

sysbot reported a splat [1] on __unmap_hugepage_range().
This is because vma_needs_reservation() can return -ENOMEM if
allocate_file_region_entries() fails to allocate the file_region struct for
the reservation.
Check for that and do not call vma_add_reservation() if that is the case,
otherwise region_abort() and region_del() will see that we do not have any
file_regions.

If we detect that vma_needs_reservation() returned -ENOMEM, we clear the
hugetlb_restore_reserve flag as if this reservation was still consumed,
so free_huge_folio() will not increment the resv count.

[1] https://lore.kernel.org/linux-mm/0000000000004096100617c58d54@google.com/T/#ma5983bc1ab18a54910da83416b3f89f3c7ee43aa

Fixes: df7a6d1f6405 ("mm/hugetlb: restore the reservation if needed")
Reported-and-tested-by: syzbot+d3fe2dc5ffe9380b714b@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-mm/0000000000004096100617c58d54@google.com/
Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/hugetlb.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6be78e7d4f6e..f35abff8be60 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5768,8 +5768,20 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		 * do_exit() will not see it, and will keep the reservation
 		 * forever.
 		 */
-		if (adjust_reservation && vma_needs_reservation(h, vma, address))
-			vma_add_reservation(h, vma, address);
+		if (adjust_reservation) {
+			int rc = vma_needs_reservation(h, vma, address);
+
+			if (rc < 0)
+				/* Pressumably allocate_file_region_entries failed
+				 * to allocate a file_region struct. Clear
+				 * hugetlb_restore_reserve so that global reserve
+				 * count will not be incremented by free_huge_folio.
+				 * Act as if we consumed the reservation.
+				 */
+				folio_clear_hugetlb_restore_reserve(page_folio(page));
+			else if (rc)
+				vma_add_reservation(h, vma, address);
+		}
 
 		tlb_remove_page_size(tlb, page, huge_page_size(h));
 		/*
-- 
2.45.1



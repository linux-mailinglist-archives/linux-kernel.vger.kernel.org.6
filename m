Return-Path: <linux-kernel+bounces-184574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6405E8CA901
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 09:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DBC1282233
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 07:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6265027B;
	Tue, 21 May 2024 07:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nT4Rz7Ud";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BLTDQuj3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nT4Rz7Ud";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BLTDQuj3"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EE450249
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 07:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716276909; cv=none; b=e8bRbtSw6gbKVSgda0dhGOMzk17+C8VtSJrqThL0dtSA7fw9Dt+I3Vntv/R6JwxFX1mfdznkgS0PktunbbyLW5DOgUyI8CZ6dUHN3Vm+n2/TNMkaabi4dFb45RwKkmmxgRmOw48RjM2k/ojNlPueOg5H3VH8jl1902Ob3yxZ0AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716276909; c=relaxed/simple;
	bh=10+vWjU9fEYhM2BvzvCY09MhY3MxUddecLRnA14gucc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NfUh6gv7SJ1cOgpb82Nc2KtabrYCrQN2sI+U0NX0d8uCY6wOOceATJPI02ph6t5BK34QqSZpeEz8Qe8wDcYLFzW/0/K2yUwcI7bxAJ8C9YR6VniAIJPSG/XEswXxlANp8q4Lo9qqz+Yn8FCwdFxpn7BJdgCmstJ5dXI9DLjVefc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nT4Rz7Ud; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BLTDQuj3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nT4Rz7Ud; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BLTDQuj3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4796D3459C;
	Tue, 21 May 2024 07:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716276904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wB9yo6B995pyR1WHngI60PKsDG18PMwNpyYk7BknREA=;
	b=nT4Rz7UdfPcFfNFHb5q3aGKN+f7xIn9KFkrHjaBkh1ZJZ/vcVVyZr1cdAJbcC9jL5Lh88V
	3mnvJ/Znl3YpK0lHsG3T86fEOUOclKQctA+hbaIWiO/qWsyPhU99CfztbrcV6WrdrAD8G/
	fKASUt0zK8hIDbevY4YsTqpJvhdxWME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716276904;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wB9yo6B995pyR1WHngI60PKsDG18PMwNpyYk7BknREA=;
	b=BLTDQuj3MZ2muMWqRkHBIW8Wc9czA2FSoHg2hbJ7DeaKUy5xvPRA53Uevy6Q/IKQCHb3iS
	EPldRwmnVHzIY6Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716276904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wB9yo6B995pyR1WHngI60PKsDG18PMwNpyYk7BknREA=;
	b=nT4Rz7UdfPcFfNFHb5q3aGKN+f7xIn9KFkrHjaBkh1ZJZ/vcVVyZr1cdAJbcC9jL5Lh88V
	3mnvJ/Znl3YpK0lHsG3T86fEOUOclKQctA+hbaIWiO/qWsyPhU99CfztbrcV6WrdrAD8G/
	fKASUt0zK8hIDbevY4YsTqpJvhdxWME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716276904;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wB9yo6B995pyR1WHngI60PKsDG18PMwNpyYk7BknREA=;
	b=BLTDQuj3MZ2muMWqRkHBIW8Wc9czA2FSoHg2hbJ7DeaKUy5xvPRA53Uevy6Q/IKQCHb3iS
	EPldRwmnVHzIY6Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DDF8413A1E;
	Tue, 21 May 2024 07:35:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id totQM6dOTGZSfQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 21 May 2024 07:35:03 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	Vishal Moola <vishal.moola@gmail.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH] mm/hugetlb: Move vmf_anon_prepare upfront in hugetlb_wp
Date: Tue, 21 May 2024 09:34:46 +0200
Message-ID: <20240521073446.23185-1-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.30
X-Spam-Level: 
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,linux.dev,gmail.com,suse.de];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]

hugetlb_wp calls vmf_anon_prepare() after having allocated a page, which
means that we might need to call restore_reserve_on_error() upon error.
vmf_anon_prepare() releases the vma lock before returning, but
restore_reserve_on_error() expects the vma lock to be held by the caller.

Fix it by calling vmf_anon_prepare() before allocating the page.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Fixes: 9acad7ba3e25 ("hugetlb: use vmf_anon_prepare() instead of anon_vma_prepare()")
---
I did not hit this bug, I just spotted this because I was looking at hugetlb_wp
for some other reason. And I did not want to get creative to see if I could
trigger this so I could get a backtrace.
My assumption is that we could trigger this if 1) this was a shared mapping,
so no anon_vma and 2) we call in GUP code with FOLL_WRITE, which would cause
the FLAG_UNSHARE to be passed, so we will end up in hugetlb_wp().

 mm/hugetlb.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6be78e7d4f6e..eb0d8a45505e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6005,6 +6005,15 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
 	 * be acquired again before returning to the caller, as expected.
 	 */
 	spin_unlock(vmf->ptl);
+
+	/*
+	 * When the original hugepage is shared one, it does not have
+	 * anon_vma prepared.
+	 */
+	ret = vmf_anon_prepare(vmf);
+	if (unlikely(ret))
+		goto out_release_old;
+
 	new_folio = alloc_hugetlb_folio(vma, vmf->address, outside_reserve);
 
 	if (IS_ERR(new_folio)) {
@@ -6058,14 +6067,6 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
 		goto out_release_old;
 	}
 
-	/*
-	 * When the original hugepage is shared one, it does not have
-	 * anon_vma prepared.
-	 */
-	ret = vmf_anon_prepare(vmf);
-	if (unlikely(ret))
-		goto out_release_all;
-
 	if (copy_user_large_folio(new_folio, old_folio, vmf->real_address, vma)) {
 		ret = VM_FAULT_HWPOISON_LARGE | VM_FAULT_SET_HINDEX(hstate_index(h));
 		goto out_release_all;
-- 
2.45.1



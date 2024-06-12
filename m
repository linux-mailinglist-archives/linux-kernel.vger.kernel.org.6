Return-Path: <linux-kernel+bounces-211183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F132904E27
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E761928224E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE3F16D307;
	Wed, 12 Jun 2024 08:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HC+NsgFS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qapP2hSg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HC+NsgFS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qapP2hSg"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066D67404F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718180996; cv=none; b=MgllKIv586Rrs3Ooll4FuzXJN/o/3c5ZRJUijIe/Ib4vCeeDT5J1dsfzoS0DoESGUZwrRUhtevujooOvpEPqYC4i2RB+qa9hOYcF1su7UaD4c6eW5OGgmiWU64fI4ANF9jGx/1ek0uOVaalXIKUvGvOOHwjKS4WYZ+15NOg8DYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718180996; c=relaxed/simple;
	bh=dmOLm8cv7b87LwmJl2Wdm2gqeo/n29d5+rkx+zRvcEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lORD+gPkoMRP/cULpl6tT3WH1smjT5nFDi5VTvAUE+oEy6gTqn0fusHqc0D4YYWWqUgKyCBT3zfvOiEye1UgUal1VAZBR8Pt8p/hQHPqdWluV2z69HK3Jyrmhx0OH9wQSC0lV/0ojM/Xxm52mC3XXph/I/F+MzCppCbgulf/xKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HC+NsgFS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qapP2hSg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HC+NsgFS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qapP2hSg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A97785BEA8;
	Wed, 12 Jun 2024 08:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718180992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=543Ixs4ZWLgiYouY+6K/h6dazdyBgWaNSCOWCW6JdR4=;
	b=HC+NsgFSPxyIMlLXYrHKOTbALXSCzRblEh631ikNPGeZtmETx0mAdVK/uAMErpyZlABSWg
	H7mw8cSbRZwBGYVkAI5912gy/VUY1F1kd0fmOOf5xNG77yIfv+iJbLD345HurFnbec850b
	0FfbL6jEhV2hzISCmW3QMEBTiuwJEb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718180992;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=543Ixs4ZWLgiYouY+6K/h6dazdyBgWaNSCOWCW6JdR4=;
	b=qapP2hSg+MjMW474lK2ZUxie16HHXN6ToyiGPpF0NEqKW5qFwn8j562olet4+IeY9CXJsY
	3zN4TlHR9Ye//TCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HC+NsgFS;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qapP2hSg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718180992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=543Ixs4ZWLgiYouY+6K/h6dazdyBgWaNSCOWCW6JdR4=;
	b=HC+NsgFSPxyIMlLXYrHKOTbALXSCzRblEh631ikNPGeZtmETx0mAdVK/uAMErpyZlABSWg
	H7mw8cSbRZwBGYVkAI5912gy/VUY1F1kd0fmOOf5xNG77yIfv+iJbLD345HurFnbec850b
	0FfbL6jEhV2hzISCmW3QMEBTiuwJEb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718180992;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=543Ixs4ZWLgiYouY+6K/h6dazdyBgWaNSCOWCW6JdR4=;
	b=qapP2hSg+MjMW474lK2ZUxie16HHXN6ToyiGPpF0NEqKW5qFwn8j562olet4+IeY9CXJsY
	3zN4TlHR9Ye//TCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42D291372E;
	Wed, 12 Jun 2024 08:29:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XsffDYBcaWYJXQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 12 Jun 2024 08:29:52 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Oscar Salvador <osalvador@suse.de>,
	syzbot+569ed13f4054f271087b@syzkaller.appspotmail.com
Subject: [PATCH] mm/hugetlb: Guard dequeue_hugetlb_folio_nodemask against NUMA_NO_NODE uses
Date: Wed, 12 Jun 2024 10:29:36 +0200
Message-ID: <20240612082936.10867-1-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A97785BEA8
X-Spam-Score: -1.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TAGGED_RCPT(0.00)[569ed13f4054f271087b];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

dequeue_hugetlb_folio_nodemask() expects a preferred node where to get the
hugetlb page from.
It does not expect, though, users to pass NUMA_NO_NODE, otherwise we will
get trash when trying to get the zonelist from that node.
All current users are careful enough to not pass NUMA_NO_NODE, but
it opens the door for new users to get this wrong since it is not
documented [0].
Guard against this by getting the local nid if NUMA_NO_NODE was passed.

[0] https://lore.kernel.org/linux-mm/0000000000004f12bb061a9acf07@google.com/

Closes: https://lore.kernel.org/linux-mm/0000000000004f12bb061a9acf07@google.com/
Reported-and-tested-by: syzbot+569ed13f4054f271087b@syzkaller.appspotmail.com
Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/hugetlb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3518321f6598..6a5ea898e4da 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1355,6 +1355,10 @@ static struct folio *dequeue_hugetlb_folio_nodemask(struct hstate *h, gfp_t gfp_
 	struct zoneref *z;
 	int node = NUMA_NO_NODE;
 
+	/* 'nid' should not be NUMA_NO_NODE. Try to catch any misuse of it and rectifiy. */
+	if (nid == NUMA_NO_NODE)
+		nid = numa_node_id();
+
 	zonelist = node_zonelist(nid, gfp_mask);
 
 retry_cpuset:
-- 
2.45.2



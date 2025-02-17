Return-Path: <linux-kernel+bounces-515307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D01FFA36314
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C34C87A58FC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772EE267F42;
	Fri, 14 Feb 2025 16:28:06 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70355267719
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739550486; cv=none; b=fO5P47pWQZI9oHwwY55n3IlXY+V5mrtcrgcBzrPeEDT76t16q+/9i/SW311jS02ToFjzsrD7hbx3TW8TzPHvR0qv5dpfWCG28w2WjQloayu2fFg451GbrvoaUqe3oku1WDIVgwd4oMqLyhe0dBwcKPQ4qtiL8o22k8jx4NS7m44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739550486; c=relaxed/simple;
	bh=FIhqpGQRgZX+ryUfiw2jv01IB7iYXNhxYhaPED5xW30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c871SWJpKwGQRsjxpyDGxtnfb14F/fhbBKkNA+88TKreI6rB8R+cRmcKdbEve+0Fcx0eKxwLvDXiB9SI2yZqezHC+yVZ8uhcTVp9edO0uFVJMCStOrkV10UCArePIc5AvLokYOiUmjekNHaTKA500lr+NZD44Gr4L5JA+gQ7p8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=fail smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F20B31F397;
	Fri, 14 Feb 2025 16:27:42 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE1DC13285;
	Fri, 14 Feb 2025 16:27:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2Mf3Nf5ur2eHSAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 14 Feb 2025 16:27:42 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 14 Feb 2025 17:27:43 +0100
Subject: [PATCH RFC v2 07/10] slab: determine barn status racily outside of
 lock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-slub-percpu-caches-v2-7-88592ee0966a@suse.cz>
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
In-Reply-To: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
To: Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 maple-tree@lists.infradead.org, Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.2
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: F20B31F397
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

The possibility of many barn operations is determined by the current
number of full or empty sheaves. Taking the barn->lock just to find out
that e.g. there are no empty sheaves results in unnecessary overhead and
lock contention. Thus perform these checks outside of the lock with a
data_race() annotated variable read and fail quickly without taking the
lock.

Checks for sheaf availability that racily succeed have to be obviously
repeated under the lock for correctness, but we can skip repeating
checks if there are too many sheaves on the given list as the limits
don't need to be strict.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 57 ++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 23 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index c1df7cf22267f28f743404531bef921e25fac086..72e6437f1d74bfacbb1cd7642af42929c48cc66a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2685,9 +2685,12 @@ static struct slab_sheaf *barn_get_empty_sheaf(struct node_barn *barn)
 	struct slab_sheaf *empty = NULL;
 	unsigned long flags;
 
+	if (!data_race(barn->nr_empty))
+		return NULL;
+
 	spin_lock_irqsave(&barn->lock, flags);
 
-	if (barn->nr_empty) {
+	if (likely(barn->nr_empty)) {
 		empty = list_first_entry(&barn->sheaves_empty,
 					 struct slab_sheaf, barn_list);
 		list_del(&empty->barn_list);
@@ -2703,38 +2706,36 @@ static int barn_put_empty_sheaf(struct node_barn *barn,
 				struct slab_sheaf *sheaf, bool ignore_limit)
 {
 	unsigned long flags;
-	int ret = 0;
+
+	/* we don't repeat the check under barn->lock as it's not critical */
+	if (!ignore_limit && data_race(barn->nr_empty) >= MAX_EMPTY_SHEAVES)
+		return -E2BIG;
 
 	spin_lock_irqsave(&barn->lock, flags);
 
-	if (!ignore_limit && barn->nr_empty >= MAX_EMPTY_SHEAVES) {
-		ret = -E2BIG;
-	} else {
-		list_add(&sheaf->barn_list, &barn->sheaves_empty);
-		barn->nr_empty++;
-	}
+	list_add(&sheaf->barn_list, &barn->sheaves_empty);
+	barn->nr_empty++;
 
 	spin_unlock_irqrestore(&barn->lock, flags);
-	return ret;
+	return 0;
 }
 
 static int barn_put_full_sheaf(struct node_barn *barn, struct slab_sheaf *sheaf,
 			       bool ignore_limit)
 {
 	unsigned long flags;
-	int ret = 0;
+
+	/* we don't repeat the check under barn->lock as it's not critical */
+	if (!ignore_limit && data_race(barn->nr_full) >= MAX_FULL_SHEAVES)
+		return -E2BIG;
 
 	spin_lock_irqsave(&barn->lock, flags);
 
-	if (!ignore_limit && barn->nr_full >= MAX_FULL_SHEAVES) {
-		ret = -E2BIG;
-	} else {
-		list_add(&sheaf->barn_list, &barn->sheaves_full);
-		barn->nr_full++;
-	}
+	list_add(&sheaf->barn_list, &barn->sheaves_full);
+	barn->nr_full++;
 
 	spin_unlock_irqrestore(&barn->lock, flags);
-	return ret;
+	return 0;
 }
 
 static struct slab_sheaf *barn_get_full_or_empty_sheaf(struct node_barn *barn)
@@ -2742,6 +2743,9 @@ static struct slab_sheaf *barn_get_full_or_empty_sheaf(struct node_barn *barn)
 	struct slab_sheaf *sheaf = NULL;
 	unsigned long flags;
 
+	if (!data_race(barn->nr_full) && !data_race(barn->nr_empty))
+		return NULL;
+
 	spin_lock_irqsave(&barn->lock, flags);
 
 	if (barn->nr_full) {
@@ -2772,9 +2776,12 @@ barn_replace_empty_sheaf(struct node_barn *barn, struct slab_sheaf *empty)
 	struct slab_sheaf *full = NULL;
 	unsigned long flags;
 
+	if (!data_race(barn->nr_full))
+		return NULL;
+
 	spin_lock_irqsave(&barn->lock, flags);
 
-	if (barn->nr_full) {
+	if (likely(barn->nr_full)) {
 		full = list_first_entry(&barn->sheaves_full, struct slab_sheaf,
 					barn_list);
 		list_del(&full->barn_list);
@@ -2797,19 +2804,23 @@ barn_replace_full_sheaf(struct node_barn *barn, struct slab_sheaf *full)
 	struct slab_sheaf *empty;
 	unsigned long flags;
 
+	/* we don't repeat this check under barn->lock as it's not critical */
+	if (data_race(barn->nr_full) >= MAX_FULL_SHEAVES)
+		return ERR_PTR(-E2BIG);
+	if (!data_race(barn->nr_empty))
+		return ERR_PTR(-ENOMEM);
+
 	spin_lock_irqsave(&barn->lock, flags);
 
-	if (barn->nr_full >= MAX_FULL_SHEAVES) {
-		empty = ERR_PTR(-E2BIG);
-	} else if (!barn->nr_empty) {
-		empty = ERR_PTR(-ENOMEM);
-	} else {
+	if (likely(barn->nr_empty)) {
 		empty = list_first_entry(&barn->sheaves_empty, struct slab_sheaf,
 					 barn_list);
 		list_del(&empty->barn_list);
 		list_add(&full->barn_list, &barn->sheaves_full);
 		barn->nr_empty--;
 		barn->nr_full++;
+	} else {
+		empty = ERR_PTR(-ENOMEM);
 	}
 
 	spin_unlock_irqrestore(&barn->lock, flags);

-- 
2.48.1



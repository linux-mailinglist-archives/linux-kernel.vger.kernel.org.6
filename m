Return-Path: <linux-kernel+bounces-261995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A05CB93BF21
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BFD61F25656
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1407197A90;
	Thu, 25 Jul 2024 09:31:39 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 675E618754E;
	Thu, 25 Jul 2024 09:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721899899; cv=none; b=l3OXUVXIbaDAxBOKc/rdsHMWKTG8IK5ccI1diqccSB03gqLq5qAFvH/+rqjLv9+fnKjAYw4YCeLDDz9kIGRf89x0wvEGloMJDam0zjh+VRXpPOkaNVZbT7FUBoIMI9/grPBJUz1Lsm2aJBJc3qgkg9aw8I5Srjsr2oIoNwj0qqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721899899; c=relaxed/simple;
	bh=4wZBE8Tmet51vxvCwqvFUlkmyBj1OYEmEVnRE0+8MDo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JZ/Xe3NHYmNYUvGYh2PXT2iPJ+tjq42HKhIxx5nVEbDoueSipAxkG3dlSU5JmzMW43sKBIHdUKP+2m6foEJUCDQh8W+W6DMsnVPFnMeHqbhHWEUm1Un49Id0GdOzi/SdAmGshHVTKjy1xFPYFMOm2CmRDc+CIyFQjrn1oFHBydY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 2C4906123B6B3;
	Thu, 25 Jul 2024 17:31:20 +0800 (CST)
X-MD-Sfrom: deshan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Deshan Zhang <deshan@nfschina.com>
To: akpm@linux-foundation.org,
	philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com
Cc: linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com,
	kernel-janitors@vger.kernel.org,
	Deshan Zhang <deshan@nfschina.com>
Subject: [PATCH] lib/lru_cache: fix spelling mistake "colision"->"collision"
Date: Thu, 25 Jul 2024 17:30:45 +0800
Message-Id: <20240725093044.1742842-1-deshan@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a literal string. Fix it.

Signed-off-by: Deshan Zhang <deshan@nfschina.com>
---
 include/linux/lru_cache.h |  4 ++--
 lib/lru_cache.c           | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/lru_cache.h b/include/linux/lru_cache.h
index c9afcdd9324c..ff82ef85a084 100644
--- a/include/linux/lru_cache.h
+++ b/include/linux/lru_cache.h
@@ -119,7 +119,7 @@ write intent log information, three of which are mentioned here.
 */
 
 /* this defines an element in a tracked set
- * .colision is for hash table lookup.
+ * .collision is for hash table lookup.
  * When we process a new IO request, we know its sector, thus can deduce the
  * region number (label) easily.  To do the label -> object lookup without a
  * full list walk, we use a simple hash table.
@@ -145,7 +145,7 @@ write intent log information, three of which are mentioned here.
  * But it avoids high order page allocations in kmalloc.
  */
 struct lc_element {
-	struct hlist_node colision;
+	struct hlist_node collision;
 	struct list_head list;		 /* LRU list or free list */
 	unsigned refcnt;
 	/* back "pointer" into lc_cache->element[index],
diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index b3d9187611de..9e0d469c7658 100644
--- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -243,7 +243,7 @@ static struct lc_element *__lc_find(struct lru_cache *lc, unsigned int enr,
 
 	BUG_ON(!lc);
 	BUG_ON(!lc->nr_elements);
-	hlist_for_each_entry(e, lc_hash_slot(lc, enr), colision) {
+	hlist_for_each_entry(e, lc_hash_slot(lc, enr), collision) {
 		/* "about to be changed" elements, pending transaction commit,
 		 * are hashed by their "new number". "Normal" elements have
 		 * lc_number == lc_new_number. */
@@ -303,7 +303,7 @@ void lc_del(struct lru_cache *lc, struct lc_element *e)
 	BUG_ON(e->refcnt);
 
 	e->lc_number = e->lc_new_number = LC_FREE;
-	hlist_del_init(&e->colision);
+	hlist_del_init(&e->collision);
 	list_move(&e->list, &lc->free);
 	RETURN();
 }
@@ -324,9 +324,9 @@ static struct lc_element *lc_prepare_for_change(struct lru_cache *lc, unsigned n
 	PARANOIA_LC_ELEMENT(lc, e);
 
 	e->lc_new_number = new_number;
-	if (!hlist_unhashed(&e->colision))
-		__hlist_del(&e->colision);
-	hlist_add_head(&e->colision, lc_hash_slot(lc, new_number));
+	if (!hlist_unhashed(&e->collision))
+		__hlist_del(&e->collision);
+	hlist_add_head(&e->collision, lc_hash_slot(lc, new_number));
 	list_move(&e->list, &lc->to_be_changed);
 
 	return e;
-- 
2.30.2



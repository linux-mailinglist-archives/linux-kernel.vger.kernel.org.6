Return-Path: <linux-kernel+bounces-250112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D8292F45F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1587282F75
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 03:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60A4DDBC;
	Fri, 12 Jul 2024 03:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z++ak1Lq"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3992E9460
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 03:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720754800; cv=none; b=oB7nUVq0jmVGG85IwQUQ9/tLFh8CIt5e9/UvEbKMxvroQrW7vlpyB+9PzhdIbL1KMgodyfaKZVWMD4rnC0DMTAtHFJp7++2zRbn5DKB1JgHLtAVsARZYxREXlLYIAQMPhE5Eb5ywDMaxY6haPyKnag8TSJ3wWJDjBPPqH3eDAs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720754800; c=relaxed/simple;
	bh=KCKytG2y0HDEEkP5vWtAxl58cdEHGx4HE52l765u4Lc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XsOs0zxtyIF3si5H8WPTH+HhY3pr5IMCAca0ANgHE27u05eMNaXEX00h3KA4t+jD0gfar+fxrfQuxd8fIQypVHZ5EA62crp+qXIFMZpcxqgK4wQF/ocM9MNu29fOVyVly4ruM4tdvy0HU6Zmq5+vbItYRHORu1cTJQeu64oKtvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z++ak1Lq; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720754794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VWeQNJq+zI55ma4p1FwSxutTu1uuDdgE89/qb0lCzRY=;
	b=Z++ak1LqH047WRiwSMRDmUltLuYrojjoNRsJR68z/X+XIMT0Yvpe/Ex3cWJpFhL5glP4UY
	KV9iUdiiJ8L+ezFVxE6ZmUDUASrEb4w2yy574oUeHeK0g1Rz0t+RgerY7oJCHwdFyFwLSX
	j/qforvln5vTK2ekIUWdd/Ur7BcTLCQ=
X-Envelope-To: kent.overstreet@linux.dev
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: tangyouling@kylinos.cn
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH] mm: list_lru: Fix NULL pointer dereference in list_lru_add()
Date: Fri, 12 Jul 2024 11:25:54 +0800
Message-Id: <20240712032554.444823-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

Note that list_lru_from_memcg_idx() may return NULL, so it is necessary
to error handle the return value to avoid triggering NULL pointer
dereference BUG.

The issue was triggered for discussion [1],
Link [1]: https://lore.kernel.org/linux-bcachefs/84de6cb1-57bd-42f7-8029-4203820ef0b4@linux.dev/T/#m901bb26cdb1d9d4bacebf0d034f0a5a712cc93a6

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 mm/list_lru.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 3fd64736bc45..ee7424c3879d 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -94,6 +94,9 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item, int nid,
 	spin_lock(&nlru->lock);
 	if (list_empty(item)) {
 		l = list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(memcg));
+		if (!l)
+			goto out;
+
 		list_add_tail(item, &l->list);
 		/* Set shrinker bit if the first element was added */
 		if (!l->nr_items++)
@@ -102,6 +105,7 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item, int nid,
 		spin_unlock(&nlru->lock);
 		return true;
 	}
+out:
 	spin_unlock(&nlru->lock);
 	return false;
 }
-- 
2.34.1



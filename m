Return-Path: <linux-kernel+bounces-244095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A34E929F0F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25A4F1F2335D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABDC78C8F;
	Mon,  8 Jul 2024 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F8/djpNQ"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3470D5466B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720430969; cv=none; b=Tk/RfAw/k9vTmlp3Ic+Thn7ueCJIgQiGugZj5DnJXz/PG48fParKx7T6SM7frKcpyEel4b8FJrmXfheuDu/7+XNFrfXsiiTdrLG4hsdbdSQom2bBeoftAXfwoNV7dGa9e/3t7lQ6S4E/OmF/Onm/+ElU2GMBeAQYaT4G6xpaXak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720430969; c=relaxed/simple;
	bh=YcR0uhyVp1UXF4y0oBeFBxmqAwWj8VkQLxscHUOYniA=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=qEv8j7kPo8LMuUKI3uKqgBhqU1QFRxUhS5FwsHopORi/BnFDeX3YsKvHpqPn7volj3xXahHsmx7ztgz+GMtgqLwhQ27qHVPFTGjwqSe10GrzWC9NP3/zf7rdBsv+fT/II0RO9gnwRwLGBjHNTgtzDn5sqXNg5muTVFw9tjQMV9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=F8/djpNQ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=nJ0jzIltPN4Hiu0OGMRSjwloxqmGPggzTGl+GF3aNWM=; b=F8/djpNQRIwf46Wf7FQPlsaTLk
	x51ddJlyjJkSwtyaXEHAqtWTpOOftxfXeILQ4QrM791qmdd8n0f3SJn1vdj1D3GwTn+yYrD5PQOuZ
	dAKbSo+JjMdMULb8OpFYjib56ghPtGoZIaapPzCl5gsUfLzLfO/N3W9dPk3SjM7i+DWHJJUC6Lc3L
	IGKyEE56A7ZTwIflvDAlxW50hOu8YDg6AzlD4fJ8NZfLCxDctog/3Uv9Ex0qBeX2qNnUzEpVCyumA
	0z/6Uoqo7hhirAU84xoJbjJYJsagDLTdBBq7FC/baGWe2M90A1JOGAFLuTI2RkK39ZrX8FMMfohv/
	UW1EoFNA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQkgO-00000000ZsN-02Um;
	Mon, 08 Jul 2024 09:29:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 0E40C300CBA; Mon,  8 Jul 2024 11:29:13 +0200 (CEST)
Message-Id: <20240708092415.464066230@infradead.org>
User-Agent: quilt/0.65
Date: Mon, 08 Jul 2024 11:12:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org,
 andrii@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 rostedt@goodmis.org,
 mhiramat@kernel.org,
 oleg@redhat.com,
 jolsa@kernel.org,
 clm@meta.com,
 paulmck@kernel.org
Subject: [PATCH 03/10] rbtree: Provide rb_find_rcu() / rb_find_add_rcu()
References: <20240708091241.544262971@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Much like latch_tree, add two RCU methods for the regular RB-tree,
which can be used in conjunction with a seqcount to provide lockless
lookups.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/rbtree.h |   67 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

--- a/include/linux/rbtree.h
+++ b/include/linux/rbtree.h
@@ -245,6 +245,42 @@ rb_find_add(struct rb_node *node, struct
 }
 
 /**
+ * rb_find_add_rcu() - find equivalent @node in @tree, or add @node
+ * @node: node to look-for / insert
+ * @tree: tree to search / modify
+ * @cmp: operator defining the node order
+ *
+ * Adds a Store-Release for link_node.
+ *
+ * Returns the rb_node matching @node, or NULL when no match is found and @node
+ * is inserted.
+ */
+static __always_inline struct rb_node *
+rb_find_add_rcu(struct rb_node *node, struct rb_root *tree,
+		int (*cmp)(struct rb_node *, const struct rb_node *))
+{
+	struct rb_node **link = &tree->rb_node;
+	struct rb_node *parent = NULL;
+	int c;
+
+	while (*link) {
+		parent = *link;
+		c = cmp(node, parent);
+
+		if (c < 0)
+			link = &parent->rb_left;
+		else if (c > 0)
+			link = &parent->rb_right;
+		else
+			return parent;
+	}
+
+	rb_link_node_rcu(node, parent, link);
+	rb_insert_color(node, tree);
+	return NULL;
+}
+
+/**
  * rb_find() - find @key in tree @tree
  * @key: key to match
  * @tree: tree to search
@@ -268,6 +304,37 @@ rb_find(const void *key, const struct rb
 		else
 			return node;
 	}
+
+	return NULL;
+}
+
+/**
+ * rb_find_rcu() - find @key in tree @tree
+ * @key: key to match
+ * @tree: tree to search
+ * @cmp: operator defining the node order
+ *
+ * Notably, tree descent vs concurrent tree rotations is unsound and can result
+ * in false-negatives.
+ *
+ * Returns the rb_node matching @key or NULL.
+ */
+static __always_inline struct rb_node *
+rb_find_rcu(const void *key, const struct rb_root *tree,
+	    int (*cmp)(const void *key, const struct rb_node *))
+{
+	struct rb_node *node = tree->rb_node;
+
+	while (node) {
+		int c = cmp(key, node);
+
+		if (c < 0)
+			node = rcu_dereference_raw(node->rb_left);
+		else if (c > 0)
+			node = rcu_dereference_raw(node->rb_right);
+		else
+			return node;
+	}
 
 	return NULL;
 }




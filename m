Return-Path: <linux-kernel+bounces-205373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6618FFAD2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C16012861CF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3CD15AACA;
	Fri,  7 Jun 2024 04:27:58 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CCA167278
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734474; cv=none; b=lkQPMsPYsrRU7m+VCQwF0OfbYNy2ijqTGVQK2SD0fXUvoFr4VYorU9L+mjVejzZaxNyXtjFNuNMNsPoFLj3C8Av7dNtY6F3gl76/4YiWePxA6AW9LW3md06AS3lVZvTpXAi3tLXeLtd4J/Q35OHRkJbnvMmOwj6waDmwW5syfNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734474; c=relaxed/simple;
	bh=acgRyEiik7BAVD2+r8jV4SIG8Fqee3e44SQuTb5HEQ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j15eBCBfGTxlwesRQOswJoFhBQFEEbwGzH0IrCobdPVdoRlorm9bvRj9EF3SSxe7jPiytmt1oSbn3Hmd0JBPa3FjEZzpjBXu0kl7lrqIwAhb6OxDXDF/sP5vOysVh5dfP81iml9OhY4oZLQ0slj6184Hf6ja0rN/44igUZy6kyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VwSkZ1Dt4z1SB5Q;
	Fri,  7 Jun 2024 12:23:50 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id E569D14040F;
	Fri,  7 Jun 2024 12:27:33 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:20 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 072/110] fsck.ubifs: rebuild_fs: Build TNC
Date: Fri, 7 Jun 2024 12:25:37 +0800
Message-ID: <20240607042615.2069840-73-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607042615.2069840-1-chengzhihao1@huawei.com>
References: <20240607042615.2069840-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)

This is the 9/12 step of repairing. Construct TNC according to scanned
files, and write TNC on flash, just like mkfs does.
Building TNC can effectively solve many failed mounting problems caused
by bad TNC (eg. bad node pointed by TNC, bad key order in znode, etc.).

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/fsck.ubifs/rebuild_fs.c | 283 +++++++++++++++++++++++++++++++++---
 1 file changed, 262 insertions(+), 21 deletions(-)

diff --git a/ubifs-utils/fsck.ubifs/rebuild_fs.c b/ubifs-utils/fsck.ubifs/rebuild_fs.c
index 62bd4128..e1d1957f 100644
--- a/ubifs-utils/fsck.ubifs/rebuild_fs.c
+++ b/ubifs-utils/fsck.ubifs/rebuild_fs.c
@@ -34,6 +34,29 @@ struct scanned_info {
 	struct rb_root del_dents;
 };
 
+/**
+ * struct idx_entry - index entry.
+ * @list: link in the list index entries for building index tree
+ * @key: key
+ * @name: directory entry name used for sorting colliding keys by name
+ * @lnum: LEB number
+ * @offs: offset
+ * @len: length
+ *
+ * The index is recorded as a linked list which is sorted and used to create
+ * the bottom level of the on-flash index tree. The remaining levels of the
+ * index tree are each built from the level below.
+ */
+struct idx_entry {
+	struct list_head list;
+	union ubifs_key key;
+	char *name;
+	int name_len;
+	int lnum;
+	int offs;
+	int len;
+};
+
 static int init_rebuild_info(struct ubifs_info *c)
 {
 	int err;
@@ -146,6 +169,17 @@ static int insert_or_update_ino_node(struct ubifs_info *c,
 	return 0;
 }
 
+static int namecmp(const char *a, int la, const char *b, int lb)
+{
+	int cmp, len = min(la, lb);
+
+	cmp = memcmp(a, b, len);
+	if (cmp)
+		return cmp;
+
+	return la - lb;
+}
+
 /**
  * insert_or_update_dent_node - insert or update dentry node.
  * @c: UBIFS file-system description object
@@ -160,7 +194,7 @@ static int insert_or_update_dent_node(struct ubifs_info *c,
 				      struct scanned_dent_node *new_dent,
 				      struct rb_root *tree)
 {
-	int cmp, nlen;
+	int cmp;
 	struct scanned_dent_node *dent_node, *old_dent_node = NULL;
 	struct rb_node **p, *parent = NULL;
 
@@ -174,9 +208,8 @@ static int insert_or_update_dent_node(struct ubifs_info *c,
 		} else if (cmp > 0) {
 			p = &(*p)->rb_right;
 		} else {
-			nlen = min(new_dent->nlen, dent_node->nlen);
-			cmp = strncmp(new_dent->name, dent_node->name, nlen) ? :
-				      new_dent->nlen - dent_node->nlen;
+			cmp = namecmp(new_dent->name, new_dent->nlen,
+				      dent_node->name, dent_node->nlen);
 			if (cmp < 0) {
 				p = &(*p)->rb_left;
 			} else if (cmp > 0) {
@@ -424,7 +457,7 @@ static struct scanned_dent_node *
 lookup_valid_dent_node(struct ubifs_info *c, struct scanned_info *si,
 		       struct scanned_dent_node *target)
 {
-	int cmp, nlen;
+	int cmp;
 	struct scanned_dent_node *dent_node;
 	struct rb_node *p;
 
@@ -437,9 +470,8 @@ lookup_valid_dent_node(struct ubifs_info *c, struct scanned_info *si,
 		} else if (cmp > 0) {
 			p = p->rb_right;
 		} else {
-			nlen = min(target->nlen, dent_node->nlen);
-			cmp = strncmp(target->name, dent_node->name, nlen) ? :
-				      target->nlen - dent_node->nlen;
+			cmp = namecmp(target->name, target->nlen,
+				      dent_node->name, dent_node->nlen);
 			if (cmp < 0) {
 				p = p->rb_left;
 			} else if (cmp > 0) {
@@ -885,9 +917,12 @@ static const char *get_file_name(struct ubifs_info *c, struct scanned_file *file
 	return name;
 }
 
-static void parse_node_location(struct ubifs_info *c, struct scanned_node *sn)
+static int parse_node_info(struct ubifs_info *c, struct scanned_node *sn,
+			   union ubifs_key *key, char *name, int name_len,
+			   struct list_head *idx_list, int *idx_cnt)
 {
 	int lnum, pos;
+	struct idx_entry *e;
 
 	lnum = sn->lnum - c->main_first;
 	pos = sn->offs + ALIGN(sn->len, 8);
@@ -895,11 +930,184 @@ static void parse_node_location(struct ubifs_info *c, struct scanned_node *sn)
 	set_bit(lnum, FSCK(c)->rebuild->used_lebs);
 	FSCK(c)->rebuild->lpts[lnum].end = max_t(int,
 					FSCK(c)->rebuild->lpts[lnum].end, pos);
+
+	if (idx_cnt == NULL)
+		/* Skip truncation node. */
+		return 0;
+
+	e = kmalloc(sizeof(struct idx_entry), GFP_KERNEL);
+	if (!e)
+		return -ENOMEM;
+
+	key_copy(c, key, &e->key);
+	e->name = name;
+	e->name_len = name_len;
+	e->lnum = sn->lnum;
+	e->offs = sn->offs;
+	e->len = sn->len;
+	list_add_tail(&e->list, idx_list);
+	*idx_cnt = *idx_cnt + 1;
+
+	return 0;
+}
+
+static int add_idx_node(struct ubifs_info *c, struct ubifs_idx_node *idx,
+			union ubifs_key *key, int child_cnt,
+			struct idx_entry *e)
+{
+	int err, lnum, offs, len;
+
+	len = ubifs_idx_node_sz(c, child_cnt);
+	ubifs_prepare_node(c, idx, len, 0);
+
+	err = reserve_space(c, len, &lnum, &offs);
+	if (err)
+		return err;
+
+	copy_node_data(c, idx, offs, len);
+
+	c->calc_idx_sz += ALIGN(len, 8);
+
+	/* The last index node written will be the root */
+	c->zroot.lnum = lnum;
+	c->zroot.offs = offs;
+	c->zroot.len = len;
+
+	key_copy(c, key, &e->key);
+	e->lnum = lnum;
+	e->offs = offs;
+	e->len = len;
+
+	return err;
+}
+
+static int cmp_idx(void *priv, const struct list_head *a,
+		   const struct list_head *b)
+{
+	int cmp;
+	struct ubifs_info *c = priv;
+	struct idx_entry *ia, *ib;
+
+	if (a == b)
+		return 0;
+
+	ia = list_entry(a, struct idx_entry, list);
+	ib = list_entry(b, struct idx_entry, list);
+
+	cmp = keys_cmp(c, &ia->key, &ib->key);
+	if (cmp)
+		return cmp;
+
+	return namecmp(ia->name, ia->name_len, ib->name, ib->name_len);
+}
+
+/**
+ * build_tnc - construct TNC and write it into flash.
+ * @c: UBIFS file-system description object
+ * @lower_idxs: leaf entries of TNC
+ * @lower_cnt: the count of @lower_idxs
+ *
+ * This function builds TNC according to @lower_idxs and writes all index
+ * nodes into flash.
+ */
+static int build_tnc(struct ubifs_info *c, struct list_head *lower_idxs,
+		     int lower_cnt)
+{
+	int i, j, err, upper_cnt, child_cnt, idx_sz, level = 0;
+	struct idx_entry *pe, *tmp_e, *e = NULL;
+	struct ubifs_idx_node *idx;
+	struct ubifs_branch *br;
+	union ubifs_key key;
+	LIST_HEAD(upper_idxs);
+
+	idx_sz = ubifs_idx_node_sz(c, c->fanout);
+	idx = kmalloc(idx_sz, GFP_KERNEL);
+	if (!idx)
+		return -ENOMEM;
+
+	list_sort(c, lower_idxs, cmp_idx);
+
+	ubifs_assert(c, lower_cnt != 0);
+
+	do {
+		upper_cnt = lower_cnt / c->fanout;
+		if (lower_cnt % c->fanout)
+			upper_cnt += 1;
+		e = list_first_entry(lower_idxs, struct idx_entry, list);
+
+		for (i = 0; i < upper_cnt; i++) {
+			if (i == upper_cnt - 1) {
+				child_cnt = lower_cnt % c->fanout;
+				if (child_cnt == 0)
+					child_cnt = c->fanout;
+			} else
+				child_cnt = c->fanout;
+
+			key_copy(c, &e->key, &key);
+			memset(idx, 0, idx_sz);
+			idx->ch.node_type = UBIFS_IDX_NODE;
+			idx->child_cnt = cpu_to_le16(child_cnt);
+			idx->level = cpu_to_le16(level);
+			for (j = 0; j < child_cnt; j++) {
+				ubifs_assert(c,
+				    !list_entry_is_head(e, lower_idxs, list));
+				br = ubifs_idx_branch(c, idx, j);
+				key_write_idx(c, &e->key, &br->key);
+				br->lnum = cpu_to_le32(e->lnum);
+				br->offs = cpu_to_le32(e->offs);
+				br->len = cpu_to_le32(e->len);
+				e = list_next_entry(e, list);
+			}
+
+			pe = kmalloc(sizeof(struct idx_entry), GFP_KERNEL);
+			if (!pe) {
+				err = -ENOMEM;
+				goto out;
+			}
+
+			err = add_idx_node(c, idx, &key, child_cnt, pe);
+			if (err) {
+				kfree(pe);
+				goto out;
+			}
+
+			list_add_tail(&pe->list, &upper_idxs);
+		}
+
+		level++;
+		list_for_each_entry_safe(e, tmp_e, lower_idxs, list) {
+			list_del(&e->list);
+			kfree(e);
+		}
+		list_splice_init(&upper_idxs, lower_idxs);
+		lower_cnt = upper_cnt;
+	} while (lower_cnt > 1);
+
+	/* Set the index head */
+	c->ihead_lnum = FSCK(c)->rebuild->head_lnum;
+	c->ihead_offs = ALIGN(FSCK(c)->rebuild->head_offs, c->min_io_size);
+
+	/* Flush the last index LEB */
+	err = flush_write_buf(c);
+
+out:
+	list_for_each_entry_safe(e, tmp_e, lower_idxs, list) {
+		list_del(&e->list);
+		kfree(e);
+	}
+	list_for_each_entry_safe(e, tmp_e, &upper_idxs, list) {
+		list_del(&e->list);
+		kfree(e);
+	}
+	kfree(idx);
+	return err;
 }
 
-static void record_file_used_lebs(struct ubifs_info *c,
-				  struct scanned_file *file)
+static int record_file_used_lebs(struct ubifs_info *c,
+				 struct scanned_file *file,
+				 struct list_head *idx_list, int *idx_cnt)
 {
+	int err;
 	struct rb_node *node;
 	struct scanned_file *xattr_file;
 	struct scanned_dent_node *dent_node;
@@ -911,28 +1119,46 @@ static void record_file_used_lebs(struct ubifs_info *c,
 		 ubifs_get_type_name(ubifs_get_dent_type(file->ino.mode)),
 		 c->dev_name);
 
-	parse_node_location(c, &file->ino.header);
+	err = parse_node_info(c, &file->ino.header, &file->ino.key,
+			      NULL, 0, idx_list, idx_cnt);
+	if (err)
+		return err;
 
-	if (file->trun.header.exist)
-		parse_node_location(c, &file->trun.header);
+	if (file->trun.header.exist) {
+		err = parse_node_info(c, &file->trun.header, NULL, NULL,
+				      0, idx_list, NULL);
+		if (err)
+			return err;
+	}
 
 	for (node = rb_first(&file->data_nodes); node; node = rb_next(node)) {
 		data_node = rb_entry(node, struct scanned_data_node, rb);
 
-		parse_node_location(c, &data_node->header);
+		err = parse_node_info(c, &data_node->header, &data_node->key,
+				      NULL, 0, idx_list, idx_cnt);
+		if (err)
+			return err;
 	}
 
 	for (node = rb_first(&file->dent_nodes); node; node = rb_next(node)) {
 		dent_node = rb_entry(node, struct scanned_dent_node, rb);
 
-		parse_node_location(c, &dent_node->header);
+		err = parse_node_info(c, &dent_node->header, &dent_node->key,
+				      dent_node->name, dent_node->nlen,
+				      idx_list, idx_cnt);
+		if (err)
+			return err;
 	}
 
 	for (node = rb_first(&file->xattr_files); node; node = rb_next(node)) {
 		xattr_file = rb_entry(node, struct scanned_file, rb);
 
-		record_file_used_lebs(c, xattr_file);
+		err = record_file_used_lebs(c, xattr_file, idx_list, idx_cnt);
+		if (err)
+			return err;
 	}
+
+	return err;
 }
 
 /**
@@ -946,13 +1172,16 @@ static void record_file_used_lebs(struct ubifs_info *c,
  *    LEBs could be taken for storing new index tree.
  * 3. Re-write data to prevent failed gc scanning in the subsequent mounting
  *    process caused by corrupted data.
+ * 4. Build TNC.
  */
 static int traverse_files_and_nodes(struct ubifs_info *c)
 {
-	int i, err = 0;
+	int i, err = 0, idx_cnt = 0;
 	struct rb_node *node;
 	struct scanned_file *file;
 	struct rb_root *tree = &FSCK(c)->rebuild->scanned_files;
+	struct idx_entry *ie, *tmp_ie;
+	LIST_HEAD(idx_list);
 
 	if (rb_first(tree) == NULL) {
 		/* No scanned files. Create root dir. */
@@ -966,7 +1195,9 @@ static int traverse_files_and_nodes(struct ubifs_info *c)
 	for (node = rb_first(tree); node; node = rb_next(node)) {
 		file = rb_entry(node, struct scanned_file, rb);
 
-		record_file_used_lebs(c, file);
+		err = record_file_used_lebs(c, file, &idx_list, &idx_cnt);
+		if (err)
+			goto out_idx_list;
 	}
 
 	/* Re-write data. */
@@ -985,16 +1216,25 @@ static int traverse_files_and_nodes(struct ubifs_info *c)
 
 		err = ubifs_leb_read(c, lnum, c->sbuf, 0, len, 0);
 		if (err && err != -EBADMSG)
-			return err;
+			goto out_idx_list;
 
 		if (len > end)
 			ubifs_pad(c, c->sbuf + end, len - end);
 
 		err = ubifs_leb_change(c, lnum, c->sbuf, len);
 		if (err)
-			return err;
+			goto out_idx_list;
 	}
 
+	/* Build TNC. */
+	log_out(c, "Build TNC");
+	err = build_tnc(c, &idx_list, idx_cnt);
+
+out_idx_list:
+	list_for_each_entry_safe(ie, tmp_ie, &idx_list, list) {
+		list_del(&ie->list);
+		kfree(ie);
+	}
 	return err;
 }
 
@@ -1059,6 +1299,7 @@ int ubifs_rebuild_filesystem(struct ubifs_info *c)
 	/*
 	 * Step 7: Record used LEBs.
 	 * Step 8: Re-write data to clean corrupted data.
+	 * Step 9: Build TNC.
 	 */
 	err = traverse_files_and_nodes(c);
 	if (err)
-- 
2.13.6



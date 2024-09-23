Return-Path: <linux-kernel+bounces-335972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A8897ED56
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05B9DB21784
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 14:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798D714A08D;
	Mon, 23 Sep 2024 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KXlsyNKS"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C8519CC3A
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 14:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727102877; cv=none; b=LaFbC5CR9mSaiNNtcdP6TyyFpBtUrm0cGZ7XwSyIoBmnFtR8NfKnoOKKe44jMOgm3Rh9HEg49OEAS2Q2jdjsN/rZTRJZcUlaXIew3qXKGFIwmBFHAQlUh2/CRu/fr3WltHPVkZhEojevtYPS3JoQaJ5BDXoscc+zlB/Nfw/Qy+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727102877; c=relaxed/simple;
	bh=Bk0fNQRsh28mlTF+N79aeZ/0DJFr8w85c0CjH9t0gtI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P+vHQ8ZAiED/XGvHUhEgInOm+dyDgy2b3A2iJDlE3JgmVr1H3Zr6J2kfZdzqgKc9NG3DK2Gxw5TpgWaXdXQ578lerndlYBamsOeMA1B/rU9I9glwE/TysVDnNudCWURa9+TfQz8hSupOM2rmVa9lZO0e1swNpElIg0uNfgERkGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KXlsyNKS; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727102871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wxyecHP0DQb9yEgGdekn4EqQ2Tgs0JnWo2dsEC0la5w=;
	b=KXlsyNKSZZE8+Cm9rTlGTCi5mj1z84IPRzzqcxCmh2+/xQALL0hzKtFflItnWmhiAVPzMJ
	ASjufaJkbsoYQgv4Gw2VHhQB5+5BQGI4GIHZbLS5F2U0MTp3h0SYq4FVHQWVIjhE5nioKL
	i/8dvVUQ/k5hYpi9Pg4hgejh+G9ILfk=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bcachefs: Use FOREACH_ACL_ENTRY() macro to iterate over acl entries
Date: Mon, 23 Sep 2024 16:44:53 +0200
Message-ID: <20240923144452.233096-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use the existing FOREACH_ACL_ENTRY() macro to iterate over POSIX acl
entries and remove the custom acl_for_each_entry() macro.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/bcachefs/acl.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/bcachefs/acl.c b/fs/bcachefs/acl.c
index 1def61875a6f..56b160e71a53 100644
--- a/fs/bcachefs/acl.c
+++ b/fs/bcachefs/acl.c
@@ -184,11 +184,6 @@ static struct posix_acl *bch2_acl_from_disk(struct btree_trans *trans,
 	return ERR_PTR(-EINVAL);
 }
 
-#define acl_for_each_entry(acl, acl_e)			\
-	for (acl_e = acl->a_entries;			\
-	     acl_e < acl->a_entries + acl->a_count;	\
-	     acl_e++)
-
 /*
  * Convert from in-memory to filesystem representation.
  */
@@ -199,11 +194,11 @@ bch2_acl_to_xattr(struct btree_trans *trans,
 {
 	struct bkey_i_xattr *xattr;
 	bch_acl_header *acl_header;
-	const struct posix_acl_entry *acl_e;
+	const struct posix_acl_entry *acl_e, *pe;
 	void *outptr;
 	unsigned nr_short = 0, nr_long = 0, acl_len, u64s;
 
-	acl_for_each_entry(acl, acl_e) {
+	FOREACH_ACL_ENTRY(acl_e, acl, pe) {
 		switch (acl_e->e_tag) {
 		case ACL_USER:
 		case ACL_GROUP:
@@ -241,7 +236,7 @@ bch2_acl_to_xattr(struct btree_trans *trans,
 
 	outptr = (void *) acl_header + sizeof(*acl_header);
 
-	acl_for_each_entry(acl, acl_e) {
+	FOREACH_ACL_ENTRY(acl_e, acl, pe) {
 		bch_acl_entry *entry = outptr;
 
 		entry->e_tag = cpu_to_le16(acl_e->e_tag);
-- 
2.46.1



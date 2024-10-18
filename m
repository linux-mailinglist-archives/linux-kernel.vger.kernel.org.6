Return-Path: <linux-kernel+bounces-371657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2CA9A3DF6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450AC1F241F4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A861CFA9;
	Fri, 18 Oct 2024 12:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RfO4TxRW"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7128CA5B
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 12:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729253731; cv=none; b=UtveGrYAWcjYOZUew9V8ujNGJvzNZpfQgriCrU/YkAaIUFz3FDS6viS4ykn3y7JQfbJIFgaCcEOOYXyJVLOcjfDdI+fvk/SAQNw7MXzAMEeqH0GzB3VDy/m2c7csOLN5be62VrxFy2qNlliEXj+Rx4oONcVjZlFy1VOwR+24X3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729253731; c=relaxed/simple;
	bh=ZS0URDKaxWK4LH2jmhZlGbkJf8uJqN2Riv04+tCTXB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XI3KouKAqCOXLMJ3BShARURLw1EWASfpnHdAn5YvibMCb+1Fnl4hXWBT2ok3Zhtk1D3YeuDWltk6d5IRzox7qnU/IKRINzgCd9bopIw2CJmbeFNHq9Chp/2jYhFcFI9NusHs9bezGabfNJLHI8BQoi8huvci67RYGlcCiN0dvT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RfO4TxRW; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729253727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/I1t6dr9YxkUDtjU+LCeHcvfcO9HKB+cT/uD7iPasWs=;
	b=RfO4TxRWnCCgRwEmMh7HRw0CCQGyRoYUzgbBa1mmGxG1YQ8kPU1i4wtlmeI16T14PNzhbU
	4TG3OjcAQtNR/pJLNq386tgKmQHe99ruEI3ri3tDSeWw3rdyvZBk7UIv5JTw+QEYsYi1kV
	ern8WXnnhwWuQ+/DQ6IHmDe6NWqC3Y4=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: Nathan Chancellor <nathan@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] acl: Annotate struct posix_acl with __counted_by()
Date: Fri, 18 Oct 2024 14:14:21 +0200
Message-ID: <20241018121426.155247-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add the __counted_by compiler attribute to the flexible array member
a_entries to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Use struct_size() to calculate the number of bytes to allocate for new
and cloned acls and remove the local size variables.

Change the posix_acl_alloc() function parameter count from int to
unsigned int to match posix_acl's a_count data type. Add identifier
names to the function definition to silence two checkpatch warnings.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Nathan Chancellor <nathan@kernel.org>
---
Changes in v2:
- Update patch to apply cleanly to linux-next. With 8f0a7a2d7bc3
  ("acl: Realign struct posix_acl to save 8 bytes") in -next, this
  patch should not trigger the false-positive buffer overflow anymore
- Link to v1: https://lore.kernel.org/linux-kernel/20240923213809.235128-2-thorsten.blum@linux.dev/
---
 fs/posix_acl.c            | 13 ++++++-------
 include/linux/posix_acl.h |  4 ++--
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 6c66a37522d0..4050942ab52f 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -200,11 +200,11 @@ EXPORT_SYMBOL(posix_acl_init);
  * Allocate a new ACL with the specified number of entries.
  */
 struct posix_acl *
-posix_acl_alloc(int count, gfp_t flags)
+posix_acl_alloc(unsigned int count, gfp_t flags)
 {
-	const size_t size = sizeof(struct posix_acl) +
-	                    count * sizeof(struct posix_acl_entry);
-	struct posix_acl *acl = kmalloc(size, flags);
+	struct posix_acl *acl;
+
+	acl = kmalloc(struct_size(acl, a_entries, count), flags);
 	if (acl)
 		posix_acl_init(acl, count);
 	return acl;
@@ -220,9 +220,8 @@ posix_acl_clone(const struct posix_acl *acl, gfp_t flags)
 	struct posix_acl *clone = NULL;
 
 	if (acl) {
-		int size = sizeof(struct posix_acl) + acl->a_count *
-		           sizeof(struct posix_acl_entry);
-		clone = kmemdup(acl, size, flags);
+		clone = kmemdup(acl, struct_size(acl, a_entries, acl->a_count),
+				flags);
 		if (clone)
 			refcount_set(&clone->a_refcount, 1);
 	}
diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
index 2d6a4badd306..e2d47eb1a7f3 100644
--- a/include/linux/posix_acl.h
+++ b/include/linux/posix_acl.h
@@ -30,7 +30,7 @@ struct posix_acl {
 	refcount_t		a_refcount;
 	unsigned int		a_count;
 	struct rcu_head		a_rcu;
-	struct posix_acl_entry	a_entries[];
+	struct posix_acl_entry	a_entries[] __counted_by(a_count);
 };
 
 #define FOREACH_ACL_ENTRY(pa, acl, pe) \
@@ -62,7 +62,7 @@ posix_acl_release(struct posix_acl *acl)
 /* posix_acl.c */
 
 extern void posix_acl_init(struct posix_acl *, int);
-extern struct posix_acl *posix_acl_alloc(int, gfp_t);
+extern struct posix_acl *posix_acl_alloc(unsigned int count, gfp_t flags);
 extern struct posix_acl *posix_acl_from_mode(umode_t, gfp_t);
 extern int posix_acl_equiv_mode(const struct posix_acl *, umode_t *);
 extern int __posix_acl_create(struct posix_acl **, gfp_t, umode_t *);
-- 
2.47.0



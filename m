Return-Path: <linux-kernel+bounces-514615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BF1A35951
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C3B33AC098
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D075227BA3;
	Fri, 14 Feb 2025 08:49:19 +0000 (UTC)
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEAC207E13
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 08:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739522959; cv=none; b=o+pDAfn0EJwx91fVvYgQwnmNkSap51DJaFoxUE7eTtoIE5HdqSFifukOaAUXCgqz4qS8eSOdQTbYZRuTF56KzMcpKuDGF0/Nf+ROM8Xu9JHb2Jl3a9TU1d0vtPi5Q+HJablAeGlL6X9B6hY+ITkk9u25//7PcpJSe4L+02OBsaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739522959; c=relaxed/simple;
	bh=gfPYUhwKYv1yN+ZIi7Gwz/R6bJJpxCjLJcrBc2tzsb8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MHUm6XCZ1LJYHBT/iEtzBY3Leq7lEAJMQdop1RiaiklkWl7e8qMgx9Tqs8akeiw38oR/YZNvxkFQy/5NYCmlwbLF5YDmaStVV1MnkiB6QOpdjCHHBg/4oSDmw20RxU3iyduIZuNVQ1j3iyU5PgNYbLMGurqAn1AYGpIBK+Z2UaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id 85BD4233B5;
	Fri, 14 Feb 2025 11:49:13 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: joseph.qi@linux.alibaba.com
Cc: jlbec@evilplan.org,
	kovalev@altlinux.org,
	kurt.hackel@oracle.com,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	mark@fasheh.com,
	ocfs2-devel@lists.linux.dev,
	syzbot+66c146268dc88f4341fd@syzkaller.appspotmail.com
Subject: [PATCH v3] ocfs2: validate l_tree_depth to avoid out-of-bounds access
Date: Fri, 14 Feb 2025 11:49:08 +0300
Message-Id: <20250214084908.736528-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
In-Reply-To: <bb8e95f6-ee91-47b9-82a0-86d576f67e39@linux.alibaba.com>
References: <bb8e95f6-ee91-47b9-82a0-86d576f67e39@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The l_tree_depth field is 16-bit (__le16), but the actual
maximum depth is limited to OCFS2_MAX_PATH_DEPTH.

Add a check to prevent out-of-bounds access if l_tree_depth
has an invalid value, which may occur when reading from a
corrupted mounted disk [1].

Fixes: ccd979bdbce9 ("[PATCH] OCFS2: The Second Oracle Cluster Filesystem")
Reported-by: syzbot+66c146268dc88f4341fd@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=66c146268dc88f4341fd [1]
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
v3: Change the condition "> OCFS2_MAX_PATH_DEPTH" to ">= OCFS2_MAX_PATH_DEPTH"
v2: Restricted depth to OCFS2_MAX_PATH_DEPTH and moved the check
    to __ocfs2_find_path().
---
 fs/ocfs2/alloc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index 4414743b638e8..cec8fc5cb8e87 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -1803,6 +1803,14 @@ static int __ocfs2_find_path(struct ocfs2_caching_info *ci,
 
 	el = root_el;
 	while (el->l_tree_depth) {
+		if (unlikely(le16_to_cpu(el->l_tree_depth) >= OCFS2_MAX_PATH_DEPTH)) {
+			ocfs2_error(ocfs2_metadata_cache_get_super(ci),
+				    "Owner %llu has invalid tree depth %u in extent list\n",
+				    (unsigned long long)ocfs2_metadata_cache_owner(ci),
+				    le16_to_cpu(el->l_tree_depth));
+			ret = -EROFS;
+			goto out;
+		}
 		if (le16_to_cpu(el->l_next_free_rec) == 0) {
 			ocfs2_error(ocfs2_metadata_cache_get_super(ci),
 				    "Owner %llu has empty extent list at depth %u\n",
-- 
2.42.2



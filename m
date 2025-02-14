Return-Path: <linux-kernel+bounces-514546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E07A1A35853
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BE0C16CEA6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A4C221710;
	Fri, 14 Feb 2025 08:00:57 +0000 (UTC)
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C99921CC4D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 08:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739520056; cv=none; b=Y5pyuhuSxB4tyQpr8AjN9nKw2CJkqQD7zZb1fSHhyoJbJJHZiKfL21b8sqrmp1cMCrSQjS95511VJzX/1BJPjw9kg21kts9eazrenC53165xLPm8ylMX2wEOca7cxgtVbYNKdNs08qosJ6iRokf8cm4TCyLbU74wxzvq5wjXDVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739520056; c=relaxed/simple;
	bh=7qyE1rUAjEWTLeVysUNMu5l5eIHUWPtaoHVSPNXQJQU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SpPwaNsAkEjurTQniF4AXDuEX5zKZsZtSUe14ypaIPb3AzMVc7N455TPvpKdnWg/5hDlv/0dL8m92XsHAwyyx8N4QPvZ/OToOyS8m3oS35vRQ5xOWqSgjZ4SQSHgV9U/MSJB+KoQpHk7Lq5No1km8hHzApjI8KaM4wVjXuI6tQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id 241F62339B;
	Fri, 14 Feb 2025 11:00:50 +0300 (MSK)
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
Subject: [PATCH v2] ocfs2: validate l_tree_depth to avoid out-of-bounds access
Date: Fri, 14 Feb 2025 11:00:38 +0300
Message-Id: <20250214080038.735185-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
In-Reply-To: <2d12eb70-5fbe-415b-9970-78af2ab7945c@linux.alibaba.com>
References: <2d12eb70-5fbe-415b-9970-78af2ab7945c@linux.alibaba.com>
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
+		if (unlikely(le16_to_cpu(el->l_tree_depth) > OCFS2_MAX_PATH_DEPTH)) {
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



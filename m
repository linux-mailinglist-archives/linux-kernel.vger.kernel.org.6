Return-Path: <linux-kernel+bounces-310519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1641967DE2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 04:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D211A1C21E5D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 02:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BF82C182;
	Mon,  2 Sep 2024 02:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MYkv4fO4"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A605273F9
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 02:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725244604; cv=none; b=T2sba6Tw9Vzl295BwgfATC+RCuActngIq39XjdXkh/QzugIvRZkknSF11SwSH+sg/b4njO7G7Y45L+rR5A6dbhLnXa7bzwaUqUV36SIg5+N8bLiEqMercMotIAkkL8EOzpimPT5Wp2EjxiMobaVkR6flhKN915Qtfwuq1r9y7h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725244604; c=relaxed/simple;
	bh=Qi3mFAh46zqBBGRVdGNoLVmijtM0zQv73cyI6DOT1aE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WUBLvI6kK/n2S4JGi8xmugCp3eMF4ENSFi46tgJbcw6FoPeFPQCeVp+8n5o+D9c0lnzCPistlpf6EmTZuQsLQyK7ngKQry4vntlXlu1ZHhShOKzQ2ZH9GqfNWCx1NNaDEp6oy86EQ1MZvHTdHPx4x72bGPpEfgKrq4BV544lUNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MYkv4fO4; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725244598; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=y82yL1fAwzFCDuugYwNZGzR8FaXBJxRTSwco7Omtw9k=;
	b=MYkv4fO4geak8uqM96s+SzQJUrReEfQBTeV2Bqs47JsLo3VqM6uz/T1UkNgJkGCMWivHacYfl0rgWHRfaxAldP9RIV/dVpKQeURT3/ViWgYvv+z0ShI7S84hSFMqAINABX8haq9LSLoFSJjBe0PSL9ixxOAstJ5sdVn9pLbcNrY=
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WE1-ECs_1725244597)
          by smtp.aliyun-inc.com;
          Mon, 02 Sep 2024 10:36:38 +0800
From: Joseph Qi <joseph.qi@linux.alibaba.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Lizhi Xu <lizhi.xu@windriver.com>,
	Heming Zhao <heming.zhao@suse.com>
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	jlbec@evilplan.org,
	mark@fasheh.com,
	syzbot+ab134185af9ef88dfed5@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH v5 1/2] ocfs2: remove unreasonable unlock in ocfs2_read_blocks
Date: Mon,  2 Sep 2024 10:36:35 +0800
Message-Id: <20240902023636.1843422-2-joseph.qi@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240902023636.1843422-1-joseph.qi@linux.alibaba.com>
References: <20240902023636.1843422-1-joseph.qi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lizhi Xu <lizhi.xu@windriver.com>

There was a lock release before exiting, so remove the unreasonable unlock.

Reported-and-tested-by: syzbot+ab134185af9ef88dfed5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ab134185af9ef88dfed5
Fixes: cf76c78595ca ("ocfs2: don't put and assigning null to bh allocated outside")
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
Cc: stable@vger.kernel.org # 4.20+
Reviewed-by: Heming Zhao <heming.zhao@suse.com>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 fs/ocfs2/buffer_head_io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ocfs2/buffer_head_io.c b/fs/ocfs2/buffer_head_io.c
index cdb9b9bdea1f..e62c7e1de4eb 100644
--- a/fs/ocfs2/buffer_head_io.c
+++ b/fs/ocfs2/buffer_head_io.c
@@ -235,7 +235,6 @@ int ocfs2_read_blocks(struct ocfs2_caching_info *ci, u64 block, int nr,
 		if (bhs[i] == NULL) {
 			bhs[i] = sb_getblk(sb, block++);
 			if (bhs[i] == NULL) {
-				ocfs2_metadata_cache_io_unlock(ci);
 				status = -ENOMEM;
 				mlog_errno(status);
 				/* Don't forget to put previous bh! */
-- 
2.39.3



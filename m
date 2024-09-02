Return-Path: <linux-kernel+bounces-310521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB0A967DE4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 04:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBB0A1F227B0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 02:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B823BBD8;
	Mon,  2 Sep 2024 02:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jwbDeiu2"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60CE3A8CB
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 02:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725244609; cv=none; b=kidFw6bjmiMAwa1LS8Z3CetuCyDOE6nS5DQohatgXqI2jYazCLZLQMqmnYrzO02jckRCH7xF1/G27SyuIR7+WmMXkQExVFIZAepJwycWtMpGf9Ju8pECJ5LXXcvxwFaiy/TsOOJaSXJQO972lwWAk5HmuyeZVjVRdEm+Z0HekpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725244609; c=relaxed/simple;
	bh=gvaTHUNn91ypwBekQZaPcb418U5xnX/PcHGbttiUAfw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fvUEttHXrZ++2o3wg7c7OHyYFpgeJ+4i3DRSXYqu5zq6eJyKp38JWjQsXZaQOJTHsS6B2nfeJYzRVw3NBcuwX4R3O07WZvZ4DPNACKNy7z/D9MmjRPBnBeFof2lATd1sD4KeDNi1nbjNzwpm2TCl1hFy2Ep+6C+kkgQbe1s1Wuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jwbDeiu2; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725244600; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Ir3tb/AMSasYPRpDdduGuFl2yf0Pry+tCjwl0Nq2JNY=;
	b=jwbDeiu2bvi8SwqAam5dX6Lmp311TKC4/ZUL4N5Yi6hN6oT7BexWGTX2M3zC8Nlhxp8s0cyw9+HzFrXFzeCR8F9TadhgKxpsJsSw8KJdlCiuSPjKhtVmyZnXGXI5WVXZrPY+Z6YTiJMKyQ8iTcJ6SqS5J/5bq1Vm0KzKbcOOSRg=
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WE17hqx_1725244598)
          by smtp.aliyun-inc.com;
          Mon, 02 Sep 2024 10:36:39 +0800
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
Subject: [PATCH v5 2/2] ocfs2: Fix possible null-ptr-deref in ocfs2_set_buffer_uptodate
Date: Mon,  2 Sep 2024 10:36:36 +0800
Message-Id: <20240902023636.1843422-3-joseph.qi@linux.alibaba.com>
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

When doing cleanup, if flags without OCFS2_BH_READAHEAD, it may trigger
NULL pointer dereference in the following ocfs2_set_buffer_uptodate() if
bh is NULL.

Reported-and-suggested-by: Heming Zhao <heming.zhao@suse.com>
Fixes: cf76c78595ca ("ocfs2: don't put and assigning null to bh allocated outside")
Cc: stable@vger.kernel.org # 4.20+
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 fs/ocfs2/buffer_head_io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/buffer_head_io.c b/fs/ocfs2/buffer_head_io.c
index e62c7e1de4eb..8f714406528d 100644
--- a/fs/ocfs2/buffer_head_io.c
+++ b/fs/ocfs2/buffer_head_io.c
@@ -388,7 +388,8 @@ int ocfs2_read_blocks(struct ocfs2_caching_info *ci, u64 block, int nr,
 		/* Always set the buffer in the cache, even if it was
 		 * a forced read, or read-ahead which hasn't yet
 		 * completed. */
-		ocfs2_set_buffer_uptodate(ci, bh);
+		if (bh)
+			ocfs2_set_buffer_uptodate(ci, bh);
 	}
 	ocfs2_metadata_cache_io_unlock(ci);
 
-- 
2.39.3



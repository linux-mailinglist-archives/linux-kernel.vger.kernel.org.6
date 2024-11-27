Return-Path: <linux-kernel+bounces-423201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 901709DA42E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 09:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 019E3284DF8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 08:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A44E1917E4;
	Wed, 27 Nov 2024 08:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kgUeZ7eb"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D838E186E46
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 08:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732697573; cv=none; b=iaiKU1ImXSp4omIsKcO9+0tos5kvaDHkF/1my5tQ/sYn+C4rHeITiQJ0OX2fTkL2A/Sa/DaN+4xUi0Z+0TuJWgPIINIGz9i0xuxOCfKPZNbNv3ieyj1lxeCSytVaqV/V+Gh76nfZ5Yksz28biEhR8ES78Y2xoPGtoXHXJpimNC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732697573; c=relaxed/simple;
	bh=bjbRRfMzhJjZrweIGKA3CThoDZ9CfSqte5us+KoWLmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nSpnWdmm/RUQQMTWJrShhefZGkYxVrjSYpymLlpRnvlzWa3htI5ETG7nmhZFNQllYXBb9f89x69jY/zcav5Vnc/BgEohjNFkDD10+W2C8NU8yuss8lh+OXvKUjOcxJbQYQlPBe0d3VlSN/p2EqD41JdPkh9c9LdBy247tv/ttY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kgUeZ7eb; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732697563; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=/75P4yZ3HLTWLNgRcQezp8O8WllCY0JuxZe7FDTAslM=;
	b=kgUeZ7ebgcPA+P5zFSWCoLFrmTZCxc0P9FxpBKDifOoU4jmYppHfaB9y8PD9PZQ9bk24M1q8WF7ZyAispJa2DsZSshvctxm/9IwvG7JgeCOZQLlFdTJ+R+T/UrIryCU0DPoYi49wG9335xDN6/pjNtK3GXAZf/RdSYOsYvxt/rg=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WKLmL2V_1732697558 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 27 Nov 2024 16:52:43 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] erofs: fix PSI memstall accounting
Date: Wed, 27 Nov 2024 16:52:36 +0800
Message-ID: <20241127085236.3538334-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Max Kellermann recently reported psi_group_cpu.tasks[NR_MEMSTALL] is
incorrect in 6.11.9 kernel.

I think the root cause of the recent issue is that since the problematic
commit, bio can be NULL so psi_memstall_leave() could be missed in
z_erofs_submit_queue().

Reported-by: Max Kellermann <max.kellermann@ionos.com>
Closes: https://lore.kernel.org/r/CAKPOu+8tvSowiJADW2RuKyofL_CSkm_SuyZA7ME5vMLWmL6pqw@mail.gmail.com
Fixes: 9e2f9d34dd12 ("erofs: handle overlapped pclusters out of crafted images properly")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 01f147505487..19ef4ff2a134 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1792,9 +1792,9 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 			erofs_fscache_submit_bio(bio);
 		else
 			submit_bio(bio);
-		if (memstall)
-			psi_memstall_leave(&pflags);
 	}
+	if (memstall)
+		psi_memstall_leave(&pflags);
 
 	/*
 	 * although background is preferred, no one is pending for submission.
-- 
2.43.5



Return-Path: <linux-kernel+bounces-263380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C211893D52C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3E161C23373
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC3F17583;
	Fri, 26 Jul 2024 14:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="pjDnxFmh"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31721CAA4
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722004543; cv=none; b=l7wEqutlcHhYMTAU7fADbDNgCmQD1mZyVbfau59QCxcjw8fb82FK4Gx/8yMgoiv5rfQtHrTCE3YAGAPwab3IXxG3xtI3gx9Hm6EEpNItKWO0+6dlpdsPodG3w5nBjXDZ9H5Y5CU9SjjmRKWet/j2ZsDi0QkyL2PV5JAqbVNLjjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722004543; c=relaxed/simple;
	bh=xBCgu9FNQnnP2P5osUR1+wUHCUDQz/+XEE4Is7LlvUw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Mf6iTr9cnB97ytyDLkXecrnlFV8Qejfl/QgW6a/ykGG0K48WOtFUS/vZ571SergJKmpyQE3AAtgFSaArmid1lubQNz0xuU/78CkyYPHQScFgL+dOrvDYzMBYgahvOg8tECkfybhz/HTiCAHdSUMEMMjgNCoqhYyBUWpaQYxWw5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=pjDnxFmh; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1722004530; bh=RYy2lkXdrqvvRQ6HUau4IEEmxjZjv7SYZfEboVOissk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pjDnxFmh3a5cIwz31gFXAofenzQWfUWqEGzJzDuesnH9nNTNfc18QlivJUbuNZNPs
	 2scPo1LUQPW8YQ8eemSX+WirF7L6Bjq+BV/fzzNiT6g4gy3bvtjxUOoi73XuLgzvOX
	 oxaO3Sbh7x18txiC4JHs19pw1POwyz0xEYgJi9bc=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 59215058; Fri, 26 Jul 2024 22:22:18 +0800
X-QQ-mid: xmsmtpt1722003738terxm588f
Message-ID: <tencent_8FB36BE36BC97A03AE44421765577706C905@qq.com>
X-QQ-XMAILINFO: NvKyM24IHTKSSrukGyLZFBr6AF0D5OZmp3rvMMXqB0ntwiSTCqE/LPUMPeQxGO
	 8kSCg5zMjGQDAHC/y0XqQAb+HLFxf6C+kXDz+8rShCQEQYZJ01MszrWZrYWwjtFs8rV1W5yeD3zV
	 lUJUCeALR60JuVawf5Sh10wjc/HJceUiF0VMcwGMHBt91fzrDLKacDAlhSVuwlPAvjVoaZMJ7tjJ
	 KGv5SctVuAT483fIiSLRF45/7SLHhfkmBZD3zgFAogSsvsU41u5cqK2rYTVqWXXU9NueELhRSQH/
	 JJESbHEdJjmsMEY8DQHjaaSdfU4Vep/L12uc1k8zYyR5uo29rlpKsl6Y08NsMEl8Q04D6sBhxpFs
	 cWN7WV+uRp4+DIb46gJm5GJWFhaV0EAdUI2o0QurLalh0G42iZBKvYOINBgqKIrbRUuGXrcJGQ+Z
	 2XUhCeJf3JkEh0r6AA8aAfPE61cruSKlcO3G/5oWixsZtLgL2CzBGpmnL8D+0Wg3Utlk5dVFH8RQ
	 Wx1Ka9R0mn48yDEH6n7TFPEwGRyTe1vm2eHzg6+kE5wsDLKivhgu6nPHwVFQrzy7pHIChY6LPwEN
	 c7usomrPGQ71OPhuqpAHOmc7JdyBc+MiFJIhqCYJfI8GoDpyWDT5tZ3RPchofrd0MGhE0kl0T7um
	 nT09DdU9/zGAPMgocpm0qnT9YDiq+3E8DJ6+aDKeHhoP2VYQc3gO6DSxu/UDer+kcrPoyi/sOdbt
	 e+zirI+Xc+Z2R9x0+5AD0uoaDOW8xMgHJnRel1/Qcbkg7E+p74deLlHtw9OAvDF0xJN2OYM+/FKQ
	 j4zq9XQagQorS5J7tcvxTmn6Z53MoMXDO+tABQS9kJvupltz/E3b6hWDk5q8iLmTjXaUYqRSKmUh
	 uckJRN1kgaDE/Is7dmm3XnM5f3JVFGjuliuXq4HdOndqHSfrDWKFr24k/GaXGc2w==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+dca05492eff41f604890@syzkaller.appspotmail.com
Cc: jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	shaggy@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] jfs: check if dmt_leafidx is less than zero
Date: Fri, 26 Jul 2024 22:22:19 +0800
X-OQ-MSGID: <20240726142218.2293706-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000064c7a0061e2004d6@google.com>
References: <00000000000064c7a0061e2004d6@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot report a out of bounds in dbSplit, it because dmt_leafidx less
than 0, add a checking for dmt_leafidx in dbAllocDmapLev.

Reported-by: syzbot+dca05492eff41f604890@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=dca05492eff41f604890
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/jfs/jfs_dmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index cb3cda1390ad..c5b8883599e3 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -1956,6 +1956,7 @@ dbAllocDmapLev(struct bmap * bmp,
 {
 	s64 blkno;
 	int leafidx, rc;
+	dmtree_t *tp = (dmtree_t *) &dp->tree;
 
 	/* can't be more than a dmaps worth of blocks */
 	assert(l2nb <= L2BPERDMAP);
@@ -1964,10 +1965,10 @@ dbAllocDmapLev(struct bmap * bmp,
 	 * free space.  if sufficient free space is found, dbFindLeaf()
 	 * returns the index of the leaf at which free space was found.
 	 */
-	if (dbFindLeaf((dmtree_t *) &dp->tree, l2nb, &leafidx, false))
+	if (dbFindLeaf(tp, l2nb, &leafidx, false))
 		return -ENOSPC;
 
-	if (leafidx < 0)
+	if (leafidx < 0 || le32_to_cpu(tp->dmt_leafidx) < 0)
 		return -EIO;
 
 	/* determine the block number within the file system corresponding
-- 
2.43.0



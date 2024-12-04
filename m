Return-Path: <linux-kernel+bounces-431180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0319E3A19
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5B7D2860B4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB4A1B652B;
	Wed,  4 Dec 2024 12:39:04 +0000 (UTC)
Received: from mta22.hihonor.com (mta22.hihonor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32BD1AF0BE
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 12:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733315944; cv=none; b=uT+Pow0ULdwjbLFnijHC4yqio7xTw1N4e21GC81ydv/meo0egO1H2oSsZOEN4B7qNR7vsdZxzG2bhoCB46L8+Z5YP9KUyVb5zadURq2n3RLvxk2w3qv67MkgGNOsPkpBfZRpi1llM4wvaEMMySichZCIpL1SEZ5PL9qauOLZgAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733315944; c=relaxed/simple;
	bh=EYR5MRHTsk50WKWmNlRMIJvq34xsRxeBylR9R0tzyxI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eCMkb23vpQQIb1fS8bSdfATT9Vb1AHgRwaikRHkcEcCxV+V57vFibcpbgVaKTx5wBSJGF6MwXyPEElHmPKnIx31D9Q5YHUUbDq53mn5pgE9SUxTmjSvKRYQy9XUDizto+6dZX7EXOeFisn3d5GkJI0F3IoxqlzRcDXDgZQHaaig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w003.hihonor.com (unknown [10.68.17.88])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4Y3GrZ3BkfzYkxX8;
	Wed,  4 Dec 2024 20:23:10 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w003.hihonor.com
 (10.68.17.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 4 Dec
 2024 20:23:19 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 4 Dec
 2024 20:23:19 +0800
From: wangzijie <wangzijie1@honor.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
	<bintian.wang@honor.com>, wangzijie <wangzijie1@honor.com>
Subject: [f2fs-dev] f2fs-tools: Check and fix inline xattr inplace
Date: Wed, 4 Dec 2024 20:23:17 +0800
Message-ID: <20241204122317.3042137-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: w001.hihonor.com (10.68.25.235) To a011.hihonor.com
 (10.68.31.243)

When we check inode which just has inline xattr data, we copy
inline xattr data from inode, check it(maybe fix it) and copy
it again to inode. We can check and fix xattr inplace for this
kind of inode to reduce memcpy times.

Signed-off-by: wangzijie <wangzijie1@honor.com>
---
 fsck/fsck.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index aa3fb97..fd8b082 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -840,11 +840,18 @@ int chk_extended_attributes(struct f2fs_sb_info *sbi, u32 nid,
 	struct f2fs_xattr_entry *ent;
 	__u32 xattr_size = XATTR_SIZE(&inode->i);
 	bool need_fix = false;
+	bool has_xattr_node = false;
+	nid_t xnid = le32_to_cpu(inode->i.i_xattr_nid);
 
 	if (xattr_size == 0)
 		return 0;
 
-	xattr = read_all_xattrs(sbi, inode, false);
+	if (xattr_size <= inline_xattr_size(&inode->i) && !xnid)
+		xattr = inline_xattr_addr(&inode->i);
+	else {
+		xattr = read_all_xattrs(sbi, inode, false);
+		has_xattr_node = true;
+	}
 	ASSERT(xattr);
 
 	last_base_addr = (void *)xattr + xattr_size;
@@ -867,12 +874,15 @@ int chk_extended_attributes(struct f2fs_sb_info *sbi, u32 nid,
 	}
 	if (need_fix && c.fix_on) {
 		memset(ent, 0, (u8 *)last_base_addr - (u8 *)ent);
-		write_all_xattrs(sbi, inode, xattr_size, xattr);
+		if (has_xattr_node) {
+			write_all_xattrs(sbi, inode, xattr_size, xattr);
+			free(xattr);
+		}
 		FIX_MSG("[0x%x] nullify wrong xattr entries", nid);
-		free(xattr);
 		return 1;
 	}
-	free(xattr);
+	if (has_xattr_node)
+		free(xattr);
 	return 0;
 }
 
-- 
2.25.1



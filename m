Return-Path: <linux-kernel+bounces-181950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FBE8C8404
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 11:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5D91C22D29
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 09:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078A12C84F;
	Fri, 17 May 2024 09:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OxUbCqgO"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF6422324
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 09:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715938933; cv=none; b=NAop7zWiIyAVcawfIJ7vJj3x5Fy5wiKsPZvm426mV32i/tA/BY8XyIZS+zTzw10JmuT2cF2BPWKMH3y+Ot2wu3v4hFhUfPyjh9nWu/8Lbq3Pnpju5dWEQuZ9aU+Jm0g78Q6ohAvmdZH7vlD3PgaWPTYYQr0qb0Q9g2F0IclyTdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715938933; c=relaxed/simple;
	bh=g2mtvEDKT6K/qKPF1XuOt7jvGo9xLXUL9uFTaUoQL74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T1NxgX/7ii2Fu0toHV5spaHErhCNTs+s6bdV5dSGrJbM+pzZ8b3s7LflKkvNRVn8guLuIgUpejY7SIuGFyL3Pqhj2z41thUVrEXBGg0+ODJ4ihg1qaEhGCRcNPYThhe3S7xcBR3rXSGQ4jIP5sZsHpaN1eGkUZfOgavbCP2MWo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OxUbCqgO; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715938928; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=jOPrgQph3RGN8jKqsS+ujDSxSagogaAaFxEI3R+UkrM=;
	b=OxUbCqgOE2LTox+UvMJ9AfQ4jq52ccXrbgZHJ9gl5G3DMhY9k/VPLWol0v/KIDty8cO+AebcMIJPqD5+798yAU4etRYPBxbM+h7k0/1H6JFhLuWPX/4dyB7qnxzMiyfCeDaElC2YxTITLZucd/7wicYw0l4ZNLw6C01eEHCaDJg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=mengferry@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W6eF4Lh_1715938925;
Received: from j66c13357.sqa.eu95.tbsite.net(mailfrom:mengferry@linux.alibaba.com fp:SMTPD_---0W6eF4Lh_1715938925)
          by smtp.aliyun-inc.com;
          Fri, 17 May 2024 17:42:07 +0800
From: Ferry Meng <mengferry@linux.alibaba.com>
To: Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	ocfs2-devel@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	Ferry Meng <mengferry@linux.alibaba.com>
Subject: [PATCH v2 2/2] ocfs2: strict bound check before memcmp in ocfs2_xattr_find_entry()
Date: Fri, 17 May 2024 17:41:47 +0800
Message-Id: <20240517094147.87133-3-mengferry@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240517094147.87133-1-mengferry@linux.alibaba.com>
References: <20240517094147.87133-1-mengferry@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xattr in ocfs2 maybe 'non-indexed', which saved with additional space
requested. It's better to check if the memory is out of bound before
memcmp, although this possibility mainly comes from crafted poisonous
images.

Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>
---
 fs/ocfs2/xattr.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 8aea94c90739..35c0cc2a51af 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -1068,7 +1068,7 @@ static int ocfs2_xattr_find_entry(struct inode *inode, int name_index,
 {
 	struct ocfs2_xattr_entry *entry;
 	size_t name_len;
-	int i, cmp = 1;
+	int i, name_offset, cmp = 1;
 
 	if (name == NULL)
 		return -EINVAL;
@@ -1083,10 +1083,15 @@ static int ocfs2_xattr_find_entry(struct inode *inode, int name_index,
 		cmp = name_index - ocfs2_xattr_get_type(entry);
 		if (!cmp)
 			cmp = name_len - entry->xe_name_len;
-		if (!cmp)
-			cmp = memcmp(name, (xs->base +
-				     le16_to_cpu(entry->xe_name_offset)),
-				     name_len);
+		if (!cmp) {
+			name_offset = le16_to_cpu(entry->xe_name_offset);
+			if ((xs->base + name_offset + name_len) > xs->end) {
+				ocfs2_error(inode->i_sb,
+					    "corrupted xattr entries");
+				return -EFSCORRUPTED;
+			}
+			cmp = memcmp(name, (xs->base + name_offset), name_len);
+		}
 		if (cmp == 0)
 			break;
 		entry += 1;
-- 
2.32.0.3.g01195cf9f



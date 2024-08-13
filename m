Return-Path: <linux-kernel+bounces-284244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 449FD94FED3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA6A31F24283
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283E569DFF;
	Tue, 13 Aug 2024 07:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="n02JOwwm"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCA7A29
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 07:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723534378; cv=none; b=qF5yRZLrfIfKvph1FNapDgWNoEPq7du9aDSuhCwb+bywyi9hl4BbY8NJtBkX94Cd0F/lvx8BC1b/4gDQiZOtH9GhqzA055ZExsDuZ/WbRpRfE8G+n2Lh/cMep8E2mROFqP18DItJH6twkw2sKq3w2rvUewDjF15uII6wXVW0NQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723534378; c=relaxed/simple;
	bh=fqvA7nIxDr4aIjRmjKnJ3E71KI2IEHpRg9QqIEY1qHE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=kRi+6ogNar7ZQKZylRJ1lkYaWpGmACzdNEy5z5JWw6GQYnvzPcOjPfaIinObFTQOGIlDZzKAFxXM86Hvezy/9+u4438Bvs2fVxqmQ7HFTWzjX6aH5UFdmbKGScWguUNbxLsjUyCvHUzFYw+ErNMfi7esgB1Ms6vHdE1fkNXJbiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=n02JOwwm; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240813073247epoutp012bb421b7d4c47c6cd607ac839d655746~rOWAwWq9m2708827088epoutp01z
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 07:32:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240813073247epoutp012bb421b7d4c47c6cd607ac839d655746~rOWAwWq9m2708827088epoutp01z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1723534367;
	bh=zG6ilKTn8eNmcV9EFzJK5daAN5h+HI6Gemb8abNBuJk=;
	h=From:To:Cc:Subject:Date:References:From;
	b=n02JOwwmyaTY93Qq4+reruPpXRnDlSWMOvq638x33EcOj4dRZycrbNw91+/24Ojld
	 J4VkgoHoucNvR2FsXCoD7T0rvQicMYvOnNovT6phmOmeOOMoUEgaUD9kNr7/kdxioE
	 Csb8ijO1nU4hetpQzCD6e/Dw3nGCdFyyVLcKqe+Q=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240813073247epcas1p1a5986fdba4af931962a07b631f37ce71~rOWAeSXVh2396423964epcas1p1M;
	Tue, 13 Aug 2024 07:32:47 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.242]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Wjjlf6cx2z4x9Q7; Tue, 13 Aug
	2024 07:32:46 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	A6.C5.08992.E1C0BB66; Tue, 13 Aug 2024 16:32:46 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20240813073246epcas1p4085b32d2b008b77119b811dc328b964e~rOV-i0cGo0063700637epcas1p4c;
	Tue, 13 Aug 2024 07:32:46 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240813073246epsmtrp2b542b92e37c497f1ac776c80eff6a660~rOV-hnS5V0250902509epsmtrp2Y;
	Tue, 13 Aug 2024 07:32:46 +0000 (GMT)
X-AuditID: b6c32a33-70bff70000002320-aa-66bb0c1ec355
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3F.82.08964.E1C0BB66; Tue, 13 Aug 2024 16:32:46 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.41]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240813073246epsmtip2a802335dba448035f5e87d2e088c0d4d~rOV-R5H9l1326513265epsmtip2W;
	Tue, 13 Aug 2024 07:32:46 +0000 (GMT)
From: Yeongjin Gil <youngjin.gil@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org, daehojeong@google.com
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	Yeongjin Gil <youngjin.gil@samsung.com>, Sungjong Seo
	<sj1557.seo@samsung.com>, Sunmin Jeong <s_min.jeong@samsung.com>
Subject: [PATCH] f2fs: Create COW inode from parent dentry for atomic write
Date: Tue, 13 Aug 2024 16:32:44 +0900
Message-Id: <20240813073244.9052-1-youngjin.gil@samsung.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNJsWRmVeSWpSXmKPExsWy7bCmnq4cz+40g+mn9S1OTz3LZDG1fS+j
	xZP1s5gtLi1yt7i8aw6bxYLW3ywWW/4dYbWYsf8puwOHx4JNpR6bVnWyeexe8JnJo2/LKkaP
	z5vkAlijGhhtEouSMzLLUhVS85LzUzLz0m2VQkPcdC2UFDLyi0tslaINDY30DA3M9YyMjPRM
	jWKtjEyVFPISc1NtlSp0oXqVFIqSC4BqcyuLgQbkpOpBxfWKU/NSHLLyS0HO1ytOzC0uzUvX
	S87PVVIoS8wpBRqhpJ/wjTFjX/81xoIJfBXvDu1jaWA8w93FyMkhIWAisWDZMpYuRi4OIYEd
	jBI9K5rYIZxPjBLrJvxkgnC+MUqcuL6TCaZlzrUGqMReRoldb1YxwrU0rHzCCFLFJqArMfXl
	U1YQW0TATuLWzUWsIEXMAkcYJX7v2g5WJCzgLbFt+ydmEJtFQFXi96XrYHFeARuJPzfOs0Gs
	k5e42bWfGSIuKHFy5hMWEJsZKN68dTYzyFAJgWvsEp9XLmeEaHCRePPoIFSzsMSr41vYIWwp
	ic/v9rJBNKxilHjT+okJwtnOKDH9cQ9Uh71Ec2szkM0BtEJTYv0ufYhtfBLvvvawQpQISpy+
	1s0MUiIhwCvR0SYEEVaTuDLpF1SJjETfg1lQez0kPu8/BzZdSCBW4mTnBPYJjPKzkPwzC8k/
	sxAWL2BkXsUollpQnJuemmxYYIgct5sYwelUy3gH4+X5//QOMTJxMB5ilOBgVhLhDTTZlSbE
	m5JYWZValB9fVJqTWnyIMRkYwhOZpUST84EJPa8k3tDMzNLC0sjE0NjM0JCwsImlgYmZkYmF
	saWxmZI475krZalCAumJJanZqakFqUUwW5g4OKUamDKca1m+vr5uOGH2zES+4O/rdpu2vw2/
	55nzzDRMVc9vDe8S7Uz2t4sORVr095+6t0r7w26NPo+lD/KbuNeqnera335VPL/C8cgqJY98
	t78vvwfVvGgInf+3Y+YGidafCq2mNesWTnp+/wHjxI2L47LP3pSyMv3RmJF4qW/Cga02U2wD
	Lp7MKMlL6fz1s3hWbSRz8jxTqbmNZwNvcbkEpLllb5n9d/FLLu9LGuL/MvZbXYqbdG0e0+qt
	oTGBORPDvz2ZuK3q3TrZWwezVvzgKHm5Yxq7euSTf9837l5x+drV+THPO8y3Ra5jdeYW0jP5
	6jLLs+zTBq91W061LN8nJjHtkKXsr8sqs1YuOB8r9ChGiaU4I9FQi7moOBEAnAwO3V4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsWy7bCSvK4cz+40g+mXeCxOTz3LZDG1fS+j
	xZP1s5gtLi1yt7i8aw6bxYLW3ywWW/4dYbWYsf8puwOHx4JNpR6bVnWyeexe8JnJo2/LKkaP
	z5vkAlijuGxSUnMyy1KL9O0SuDL29V9jLJjAV/Hu0D6WBsYz3F2MnBwSAiYSc641MHUxcnEI
	CexmlOhtusYKkZCR+DPxPVsXIweQLSxx+HAxRM0HRolVrYvZQGrYBHQlpr58ClYvIuAk8f9G
	OztIEbPACUaJr4u/MoEkhAW8JbZt/8QMYrMIqEr8vnSdEcTmFbCR+HPjPBvEMnmJm137mSHi
	ghInZz5hAbGZgeLNW2czT2Dkm4UkNQtJagEj0ypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k
	/NxNjOBg1dLcwbh91Qe9Q4xMHIyHGCU4mJVEeANNdqUJ8aYkVlalFuXHF5XmpBYfYpTmYFES
	5xV/0ZsiJJCeWJKanZpakFoEk2Xi4JRqYDLVr+0/Ze7kySJs5TFPXWl3R9X5zUY7n8VfSj69
	rEpIIPrUynV2JQxvuk46yb87HmH53t7PPptnUdjDD63hPl4mP1pFORcdSRSvdI3N6+/WuiG1
	VXih//OWb8JqWVkxRpN5Nv3Xmso292/4hS3ThOtMbPZd3aufXHPT6M2etBeZR64n2f/p/a7v
	IaT5ZVnCTsfqWPbH+dtm8DfFflF7ym87Jzt57zI/E8f+ZieTd0EPFqT9D+LasG2Dqn7XR7NT
	QkfdzyecCNrP0rNoQtrlXJnYGys5pun0PNm5Sz92ltDlhE0rTBZNZ2oOyV77/26IbZqvyJLp
	L6osbsyZ/vrim1ihhD1J0ZOVp0Q7S7hOUGIpzkg01GIuKk4EAMP3DqvFAgAA
X-CMS-MailID: 20240813073246epcas1p4085b32d2b008b77119b811dc328b964e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-ArchiveUser: EV
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240813073246epcas1p4085b32d2b008b77119b811dc328b964e
References: <CGME20240813073246epcas1p4085b32d2b008b77119b811dc328b964e@epcas1p4.samsung.com>

The i_pino in f2fs_inode_info has the previous parent's i_ino when inode
was renamed, which may cause f2fs_ioc_start_atomic_write to fail.
If file_wrong_pino is true and i_nlink is 1, then to find a valid pino,
we should refer to the dentry from inode.

To resolve this issue, let's get parent inode using parent dentry
directly.

Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Reviewed-by: Sunmin Jeong <s_min.jeong@samsung.com>
Signed-off-by: Yeongjin Gil <youngjin.gil@samsung.com>
---
 fs/f2fs/file.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index fba8b5f216f9..1eae123f0315 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2127,7 +2127,6 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 	struct mnt_idmap *idmap = file_mnt_idmap(filp);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct inode *pinode;
 	loff_t isize;
 	int ret;
 
@@ -2178,15 +2177,10 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 	/* Check if the inode already has a COW inode */
 	if (fi->cow_inode == NULL) {
 		/* Create a COW inode for atomic write */
-		pinode = f2fs_iget(inode->i_sb, fi->i_pino);
-		if (IS_ERR(pinode)) {
-			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
-			ret = PTR_ERR(pinode);
-			goto out;
-		}
+		struct dentry *dentry = file_dentry(filp);
+		struct inode *dir = d_inode(dentry->d_parent);
 
-		ret = f2fs_get_tmpfile(idmap, pinode, &fi->cow_inode);
-		iput(pinode);
+		ret = f2fs_get_tmpfile(idmap, dir, &fi->cow_inode);
 		if (ret) {
 			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
 			goto out;
-- 
2.40.1



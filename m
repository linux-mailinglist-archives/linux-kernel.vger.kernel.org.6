Return-Path: <linux-kernel+bounces-304729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 078D4962405
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF84E2820FA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9DE16B74B;
	Wed, 28 Aug 2024 09:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eRM7YIOp"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F5615F3E6
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 09:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724838767; cv=none; b=flw0klPGVVyYMy/sFXy0xNyOMpoh9PW08wqjaCW1pTOdGsQArKHTfvIflrntyhkrQo94vf0bBNflH8VJNc8ySjG1/DfnZtxT9pbD40uuFPWzyxhy7O8SyxhOgiA+SHA+MR2EMVvV6EtepvZH4ufRAJ39ThwcQM5knjfth8SGEWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724838767; c=relaxed/simple;
	bh=ozlaIqKGPJeor8tQv1Ap7ZaKcONr6CjARjA5O2SzL5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xy+gCkwk6+XCf9P7OYmUhdz4c7iJTsH9XmQyoIQID/XqzbI0GzkjFL+Hl8sn2IXgav7hRyZu8af0fn+dqpFnIuUUjVhEqxvRwxNXVsMPGyWh+aEiQBy9pT2SFRn821GCCzrMxuhKZEp/8uqBsVAkDa3eo6T/hjpUdM7ZzNTjsXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eRM7YIOp; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724838757; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Wiybu7Typ2/zR0lNiQSCRktnMCk0oKr/bTEJatprEbA=;
	b=eRM7YIOpL2DfnZjeZoUH1xkxas8hc7CZyTFULGeaDbpGCPRsSHqTH1GjwWPbCTSW6zLZ/udr09UbOzRjNl384t1uq0EuF0xnz7bpt4sve89zRefQ/VL5JsMe8T6+I6lop2+kt9HEwxp+1HcNE3kP64aKtQ2cjycxf2bG/a09Kn4=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WDpX0E3_1724838752)
          by smtp.aliyun-inc.com;
          Wed, 28 Aug 2024 17:52:37 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: clean up erofs_register_sysfs()
Date: Wed, 28 Aug 2024 17:52:32 +0800
Message-ID: <20240828095232.571946-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit 684b290abc77 ("erofs: add support for
FS_IOC_GETFSSYSFSPATH"), `sb->s_sysfs_name` is now valid.

Just use it to get rid of duplicated logic.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/super.c |  2 +-
 fs/erofs/sysfs.c | 30 ++++++------------------------
 2 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 95b4faa0b245..5760b45252cc 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -649,7 +649,6 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 		sb->s_flags |= SB_POSIXACL;
 	else
 		sb->s_flags &= ~SB_POSIXACL;
-	erofs_set_sysfs_name(sb);
 
 #ifdef CONFIG_EROFS_FS_ZIP
 	xa_init(&sbi->managed_pslots);
@@ -687,6 +686,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		return err;
 
+	erofs_set_sysfs_name(sb);
 	err = erofs_register_sysfs(sb);
 	if (err)
 		return err;
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index 435e515c0792..63cffd0fd261 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -205,34 +205,16 @@ static struct kobject erofs_feat = {
 int erofs_register_sysfs(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
-	char *name;
-	char *str = NULL;
 	int err;
 
-	if (erofs_is_fscache_mode(sb)) {
-		if (sbi->domain_id) {
-			str = kasprintf(GFP_KERNEL, "%s,%s", sbi->domain_id,
-					sbi->fsid);
-			if (!str)
-				return -ENOMEM;
-			name = str;
-		} else {
-			name = sbi->fsid;
-		}
-	} else {
-		name = sb->s_id;
-	}
 	sbi->s_kobj.kset = &erofs_root;
 	init_completion(&sbi->s_kobj_unregister);
-	err = kobject_init_and_add(&sbi->s_kobj, &erofs_sb_ktype, NULL, "%s", name);
-	kfree(str);
-	if (err)
-		goto put_sb_kobj;
-	return 0;
-
-put_sb_kobj:
-	kobject_put(&sbi->s_kobj);
-	wait_for_completion(&sbi->s_kobj_unregister);
+	err = kobject_init_and_add(&sbi->s_kobj, &erofs_sb_ktype, NULL, "%s",
+				   sb->s_sysfs_name);
+	if (err) {
+		kobject_put(&sbi->s_kobj);
+		wait_for_completion(&sbi->s_kobj_unregister);
+	}
 	return err;
 }
 
-- 
2.43.5



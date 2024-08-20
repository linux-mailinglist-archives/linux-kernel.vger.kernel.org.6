Return-Path: <linux-kernel+bounces-293155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C63957B68
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 04:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA655B226FE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 02:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4774133998;
	Tue, 20 Aug 2024 02:28:35 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE22F22EF2;
	Tue, 20 Aug 2024 02:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724120914; cv=none; b=eyM5nouooktOEnLtKTQ1DpL+/PqQ8dx58o/yYQhiCpyOnFGYzUO27QdriEqRQX1x8bRXXkyZ0t/lKlMOmW1FN2o+eBxxMKbxZW6Y//xhJdlOVV8X/iJw+SkYSWU23e77zgvoSscZ9yQf+EtJegMDo7bgSskEJGDy4HkclZCkDXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724120914; c=relaxed/simple;
	bh=CDXhsasnshXdv2F7kEyqpa9BSMgkrn3BNHigrOJuj1c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GqRrmhIjMpk9mXT8jdLEAtUwceFseCZ8I8GkgCr5WV5toChqIQugckKEKQDZxNBiVYAhFQCMi94Uqo9T+fizbVX7aWspV8HaTWC0s/q14vYPp6yYCd0OdzQ7MZGk8ulaZYu1NksK2DGKUMT17hmdqL1aFXE379P3RLvX3GZMUGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Wntd71Zt4z1xvRp;
	Tue, 20 Aug 2024 10:26:35 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id 297DD1400FD;
	Tue, 20 Aug 2024 10:28:29 +0800 (CST)
Received: from huawei.com (10.67.174.77) by dggpemm500020.china.huawei.com
 (7.185.36.49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 20 Aug
 2024 10:28:28 +0800
From: Liao Chen <liaochen4@huawei.com>
To: <linux-fsdevel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <dlemoal@kernel.org>,
	<naohiro.aota@wdc.com>, <jth@kernel.org>
Subject: [PATCH -next v2] zonefs: add support for FS_IOC_GETFSSYSFSPATH
Date: Tue, 20 Aug 2024 02:20:29 +0000
Message-ID: <20240820022029.8261-1-liaochen4@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500020.china.huawei.com (7.185.36.49)

FS_IOC_GETFSSYSFSPATH ioctl expects sysfs sub-path of a filesystem, the
format can be "$FSTYP/$SYSFS_IDENTIFIER" under /sys/fs, it can helps to
standardizes exporting sysfs datas across filesystems.

This patch wires up FS_IOC_GETFSSYSFSPATH for zonefs, it will output
"zonefs/<dev>".

Signed-off-by: Liao Chen <liaochen4@huawei.com>
---
 fs/zonefs/sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/zonefs/sysfs.c b/fs/zonefs/sysfs.c
index 8ccb65c2b419..ff9a688f1f9c 100644
--- a/fs/zonefs/sysfs.c
+++ b/fs/zonefs/sysfs.c
@@ -92,6 +92,7 @@ int zonefs_sysfs_register(struct super_block *sb)
 	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
 	int ret;
 
+	super_set_sysfs_name_id(sb);
 	init_completion(&sbi->s_kobj_unregister);
 	ret = kobject_init_and_add(&sbi->s_kobj, &zonefs_sb_ktype,
 				   zonefs_sysfs_root, "%s", sb->s_id);
-- 
2.34.1



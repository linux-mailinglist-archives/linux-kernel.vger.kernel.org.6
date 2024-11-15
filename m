Return-Path: <linux-kernel+bounces-410397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A506A9CDAF8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 09:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BA831F21A32
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 08:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B9A18C332;
	Fri, 15 Nov 2024 08:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9Sq/c1U"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994E51632E7
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 08:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731660945; cv=none; b=qeupLCgRl7TLUNgswtt3ge//2I96/tyJbxuLtcpzog2xl06ScaOWE/t8qINy9RlbNxwGjSo9fbnTruGy3N99cIZUjOdlRw+/5oJp2fBgefl0Ipv8IELo74FHEJc0KrCrYXYXtimUFF3hGofTyaG4OyWiRSfRavhw0xfWfZ8yY3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731660945; c=relaxed/simple;
	bh=I9uYl41QRGR34kBf2jcXMhn8f5XxhdA7gzLic0SNu1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d416k62tC6hAn2HFbcJ8iy/B9aQ7b3hgc5/ZpT3+sVZonvUOTHymT9PN0jTiXF/axRTvslJYprsN1Xh/zn+FnV9c2O7orKWgEKIzdB4t8kT9YXbKklzQf9XBAuxjcAxvrrnjmRZ/OCVkbtgUzLRAGWlBblS52AOkMXSPW9l++go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9Sq/c1U; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5ceca0ec4e7so1944701a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 00:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731660942; x=1732265742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WwPfvv1Vu4fpClWF94s2/7ENJKbUW5Fs/yycbUbmmqg=;
        b=D9Sq/c1UziaoygEsyes+KzG/Zk5nn1E8xFciEm/12WYOidRUizTKP4CcvzutbLfRDr
         BwQqPaYVHSSnBOcWTtpZ97AHXIoiKu9Ii3G3vt64w+RTQ1bwvRcZRzW3A14GrkZAIQP4
         PsVpk4P9KmF4wrZU5R14NJld/3MQWayfkL7l5g7ZCDY6/dil5SwYIwjbqTTqaBao9oLu
         9JfsyaR4naYqHi84jbhGnbd2Y4yFhrVtPy7P62rCqBEvCsiMVdV/ptYn4fWrPoG0728t
         cpLnTMF5U0mSqAiW3d4MI4b/uECQTgUS/z4EBQ4zmUQWX/9zEfPSxDqpBcTI69b/72zL
         VjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731660942; x=1732265742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WwPfvv1Vu4fpClWF94s2/7ENJKbUW5Fs/yycbUbmmqg=;
        b=Y2Iu4XB+nkCi6fLYtDQD0nlG+TpBwSDRcWGnAHi/ATNmAZwlLettbcaNOlGNQw4HSw
         Osj+/ls+rw7v/Iir9xASI57QA42Huhlk7KcLv6BAYLym/SKf9kkq2u1o7oPFZqxHcCeK
         IvWi7M4/9EUb7+nSkk0UniJB5s/9sV9iuPIcZDLbb44eI2FxgL24plGNyFflqrL781wb
         MS1K/L3kXi1tnYHXKZZ4s0Ouee7vVeBIWlbNGm1ShePYy1Zgov+u1W7D6uiOjMWrQVBL
         g5ZTpthm7rftV31n/J5TWD1FhqiyyfbYknkoyWpOiVycAHkj2QOTomadfRGzl3hgLn8c
         DT+w==
X-Forwarded-Encrypted: i=1; AJvYcCXJK1sYgmFker8RnBQq8AeLjoeMy386Q0VN3b8wkOyccaP/RaTVZBJIpJ8H5yCRwg/xBXYZG9zDgIRHixw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIOE5e+eQP05YZQa1tT3OGi48XGg+1XX1L7BLcHGpDtjTbL1Li
	+REoaaXvnc6IjXnr7lMZHP+qPL3nKW1qvdTa+7wNHvTrK+9IkjZJ
X-Google-Smtp-Source: AGHT+IFpqTwtMjV+8xffCCbPSZs9XUvm9no//pS9duGs/44wrGoUxnGCitypnV5+QD7w0Kza5jeVVQ==
X-Received: by 2002:a17:907:844:b0:a9a:13dd:2734 with SMTP id a640c23a62f3a-aa483489f26mr173860666b.36.1731660941639;
        Fri, 15 Nov 2024 00:55:41 -0800 (PST)
Received: from enno-kaukura.lan ([147.161.234.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e081574sm157714866b.179.2024.11.15.00.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 00:55:41 -0800 (PST)
From: Andreas Oetken <ennoerlangen@gmail.com>
X-Google-Original-From: Andreas Oetken <andreas.oetken@siemens-energy.com>
To: 
Cc: Andreas Oetken <andreas.oetken@siemens-energy.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] mtd: core/part: trying to delete partition with usecount > 0 corrupt partition
Date: Fri, 15 Nov 2024 09:55:13 +0100
Message-ID: <20241115085516.1852668-1-andreas.oetken@siemens-energy.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check for usecount before deleting debugfs and sysfs entries.
Otherwise deleting the partition a second time leads to a kernel panic.

Signed-off-by: Andreas Oetken <andreas.oetken@siemens-energy.com>
---
 drivers/mtd/mtdcore.c | 25 ++++++++++++++-----------
 drivers/mtd/mtdcore.h |  2 +-
 drivers/mtd/mtdpart.c |  7 +++----
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 1c8c40728678..19ade7e53024 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -714,30 +714,33 @@ int add_mtd_device(struct mtd_info *mtd)
  *	if the requested device does not appear to be present in the list.
  */
 
-int del_mtd_device(struct mtd_info *mtd)
+int del_mtd_device(struct mtd_info *mtd, const struct attribute *mtd_partition_attrs[])
 {
 	int ret;
 	struct mtd_notifier *not;
 
 	mutex_lock(&mtd_table_mutex);
-
-	debugfs_remove_recursive(mtd->dbg.dfs_dir);
-
 	if (idr_find(&mtd_idr, mtd->index) != mtd) {
 		ret = -ENODEV;
 		goto out_error;
 	}
 
-	/* No need to get a refcount on the module containing
-		the notifier, since we hold the mtd_table_mutex */
-	list_for_each_entry(not, &mtd_notifiers, list)
-		not->remove(mtd);
-
 	if (mtd->usecount) {
 		printk(KERN_NOTICE "Removing MTD device #%d (%s) with use count %d\n",
 		       mtd->index, mtd->name, mtd->usecount);
 		ret = -EBUSY;
 	} else {
+		/* No need to get a refcount on the module containing
+		 * the notifier, since we hold the mtd_table_mutex
+		 */
+		debugfs_remove_recursive(mtd->dbg.dfs_dir);
+
+		list_for_each_entry(not, &mtd_notifiers, list)
+			not->remove(mtd);
+
+		if (mtd_partition_attrs != NULL)
+			sysfs_remove_files(&mtd->dev.kobj, mtd_partition_attrs);
+
 		/* Try to remove the NVMEM provider */
 		if (mtd->nvmem)
 			nvmem_unregister(mtd->nvmem);
@@ -852,7 +855,7 @@ int mtd_device_parse_register(struct mtd_info *mtd, const char * const *types,
 
 out:
 	if (ret && device_is_registered(&mtd->dev))
-		del_mtd_device(mtd);
+		del_mtd_device(mtd, NULL);
 
 	return ret;
 }
@@ -878,7 +881,7 @@ int mtd_device_unregister(struct mtd_info *master)
 	if (!device_is_registered(&master->dev))
 		return 0;
 
-	return del_mtd_device(master);
+	return del_mtd_device(master, NULL);
 }
 EXPORT_SYMBOL_GPL(mtd_device_unregister);
 
diff --git a/drivers/mtd/mtdcore.h b/drivers/mtd/mtdcore.h
index b5eefeabf310..0f8e815e99b2 100644
--- a/drivers/mtd/mtdcore.h
+++ b/drivers/mtd/mtdcore.h
@@ -9,7 +9,7 @@ extern struct backing_dev_info *mtd_bdi;
 
 struct mtd_info *__mtd_next_device(int i);
 int __must_check add_mtd_device(struct mtd_info *mtd);
-int del_mtd_device(struct mtd_info *mtd);
+int del_mtd_device(struct mtd_info *mtd, const struct attribute *mtd_partition_attrs[]);
 int add_mtd_partitions(struct mtd_info *, const struct mtd_partition *, int);
 int del_mtd_partitions(struct mtd_info *);
 
diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index 5725818fa199..96d4deb4d9b5 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -307,12 +307,11 @@ static int __mtd_del_partition(struct mtd_info *mtd)
 			return err;
 	}
 
-	sysfs_remove_files(&mtd->dev.kobj, mtd_partition_attrs);
-
-	err = del_mtd_device(mtd);
+	err = del_mtd_device(mtd, mtd_partition_attrs);
 	if (err)
 		return err;
 
+
 	list_del(&mtd->part.node);
 	free_partition(mtd);
 
@@ -334,7 +333,7 @@ static int __del_mtd_partitions(struct mtd_info *mtd)
 			__del_mtd_partitions(child);
 
 		pr_info("Deleting %s MTD partition\n", child->name);
-		ret = del_mtd_device(child);
+		ret = del_mtd_device(child, mtd_partition_attrs);
 		if (ret < 0) {
 			pr_err("Error when deleting partition \"%s\" (%d)\n",
 			       child->name, ret);
-- 
2.45.2



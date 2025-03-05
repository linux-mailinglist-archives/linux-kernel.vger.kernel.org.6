Return-Path: <linux-kernel+bounces-546920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDE8A5009A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 184EA1882455
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79711245023;
	Wed,  5 Mar 2025 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JPbIWMSJ"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC862134D4
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 13:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741181617; cv=none; b=RpNmHif9U8V1jBC9CRYN33GpAtC6o9651m3qWYqSNjO2afxqm47KlN5fRlIgkI7ZQCuFtifbIezmSi8ZfTSZrdTmhAU7nZcM0mkc36KTnw9J+UT8xW6cNqP+ledFTMp4juXFVjiXMgSXVzDIQGG9H8rNwqMG9cKdQJAlBKbEGKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741181617; c=relaxed/simple;
	bh=nLZuTD4O5TfThTjoxxiTaCOFqFsWGfW7NribwesxYKs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tZ5wuM6hQfpJ/Vz2ZENtW5I2yfRREGW9+02bifC6KrMSXZarEo03m1HQgz2CVwdJ6q4RyMMdWyn/9E9ghDBAtVBFuWcpx/C5CK7uaRVMQe1Ucl8MAtbjRMNWpz086hfN/u+X5h5wT+MUqj6G4Ljlz+gWOB5xS5m915pkFpzbPWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JPbIWMSJ; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ivZMd
	f8K4NKd/IimW5p+hBinu9acvKGE4BCqgwtiLqM=; b=JPbIWMSJVIv0dAK4ODLX9
	Pi1rFdmHQhH8jaYRX7vmwVVrEULWkVRBXBOBESS43vTWObTkm+rWSvITvWmNBrDU
	jcabFpAxdMAx6BqIBzHa9XUwMzkOEBUnh4lmoKMlBHSvwYtXb7JUXlVE/hLgai/c
	yesEO2IBey/9vYrZhjtfEI=
Received: from zhuxin.hobot.cc (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wAn_3qXUshn_yNfQQ--.11325S2;
	Wed, 05 Mar 2025 21:33:19 +0800 (CST)
From: Zxyan Zhu <zxyan20@163.com>
To: gregkh@linuxfoundation.org
Cc: broonie@kernel.org,
	rafael@kernel.org,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	Zxyan Zhu <zxyan20@163.com>
Subject: [PATCH v3] regmap: debugfs: Fix name collision without atomic operations
Date: Wed,  5 Mar 2025 21:32:52 +0800
Message-Id: <20250305133251.44082-1-zxyan20@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAn_3qXUshn_yNfQQ--.11325S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr47Ww47ur4xKFW8Jr4xZwb_yoW5ZFWDpa
	1kG3WrKwsrAr4rJrWYya18CFySk392vFy3A3yru3W5Zwnaqr47JF4vgFWYyryDuryUXw1U
	XF4ay34UCr1UtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piF_M3UUUUU=
X-CM-SenderInfo: p201t0isq6il2tof0z/1tbioBYHXmfIUpsAQAAAsJ

The `dummy_index` global variable caused debugfs file name conflicts
during re-entry, leading to creation failures. Use atomic operations
to ensure safe and unique debugfs `dummy%d` naming.

Signed-off-by: Zxyan Zhu <zxyan20@163.com>
---

Changes since v2:
- Remove atomic_dec operation if kasprintf() fails

Changes since v1:
- Replaced atomic_read + atomic_inc with atomic_inc_return.
- Added atomic_dec in the error path to maintain index consistency.
- Updated the commit message to clarify the fix.

At 2025-03-05 00:23:02, "Greg KH" <gregkh@linuxfoundation.org> wrote:
>On Tue, Mar 04, 2025 at 10:24:52PM +0800, Zxyan Zhu wrote:
>>  	if (!strcmp(name, "dummy")) {
>>  		kfree(map->debugfs_name);
>> -		map->debugfs_name = kasprintf(GFP_KERNEL, "dummy%d",
>> -						dummy_index);
>> -		if (!map->debugfs_name)
>> +		index = atomic_inc_return(&dummy_index);
>> +		map->debugfs_name = kasprintf(GFP_KERNEL, "dummy%d", index);
>> +		if (!map->debugfs_name) {
>> +			atomic_dec(&dummy_index);
>>  			return;
>> +		}
>>  		name = map->debugfs_name;
>> -		dummy_index++;
>
>Shouldn't you just use an idr here if there is a race condition?
>There's a lock built into it that should solve all of these issues.
>
>thanks,
>
>greg k-h

Thanks for the feedback! I think using atomic_t is a better fit here
than idr because:
1. It's lighter and simpler for our basic indexing needs.
2. No extra resource management is needed. If we use idr, we'd have to
 handle resource cleanup and add locks for debugfs_init/debugfs_exit
 concurrency.
3. As Mark mentioned, id continuity isn't a hard requirement, so we
 can even skip the atomic_dec on kasprintf failure.

If you still think idr has clear advantages here, I'm happy to adjust
the code, but it'd be great to understand the specific benefits in
this context.

Cheers,

Zxyan Zhu

 drivers/base/regmap/regmap-debugfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index fb84cda92a75..8811c42dccb7 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -20,7 +20,7 @@ struct regmap_debugfs_node {
 	struct list_head link;
 };
 
-static unsigned int dummy_index;
+static atomic_t dummy_index = ATOMIC_INIT(0);
 static struct dentry *regmap_debugfs_root;
 static LIST_HEAD(regmap_debugfs_early_list);
 static DEFINE_MUTEX(regmap_debugfs_early_lock);
@@ -549,6 +549,7 @@ void regmap_debugfs_init(struct regmap *map)
 	struct regmap_range_node *range_node;
 	const char *devname = "dummy";
 	const char *name = map->name;
+	int index;
 
 	/*
 	 * Userspace can initiate reads from the hardware over debugfs.
@@ -595,12 +596,11 @@ void regmap_debugfs_init(struct regmap *map)
 
 	if (!strcmp(name, "dummy")) {
 		kfree(map->debugfs_name);
-		map->debugfs_name = kasprintf(GFP_KERNEL, "dummy%d",
-						dummy_index);
+		index = atomic_inc_return(&dummy_index);
+		map->debugfs_name = kasprintf(GFP_KERNEL, "dummy%d", index);
 		if (!map->debugfs_name)
 			return;
 		name = map->debugfs_name;
-		dummy_index++;
 	}
 
 	map->debugfs = debugfs_create_dir(name, regmap_debugfs_root);
-- 
2.34.1



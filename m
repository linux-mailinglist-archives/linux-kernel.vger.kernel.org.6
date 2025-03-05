Return-Path: <linux-kernel+bounces-546914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FF2A50082
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D3127A769C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EC724887B;
	Wed,  5 Mar 2025 13:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MvCjS6e8"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DB12E3396
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 13:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741181280; cv=none; b=UWK2ob+dJC/dvMDx5oGpl5uImqObyP7u1FKChhtcJev5f9Brz91YoD2nLMP4uF1CwSZ5AEBduMMnJSra6zI6mDgw3Frs3QgOsS4ls/a2yOxTtGqBI+baRz57hHBcOfwL4oGD1UIjOV/Tab5RGl5kbtwcRPO9TO+9lGErC/AbOPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741181280; c=relaxed/simple;
	bh=NnjloQ5PbkFb2Yq5EIqUEp7tDPM1RKO4//TKAphUQaM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c9JUWTJU4Rhw+YxBvUkg/ODcNvIDRH1Bc5gv+UR38Ntm1On34n5R5Gh81XwGBHti0Ppu7n3Yio4aq64niz7bPwt2C8cxyOS2dSsh0O2/NdY4x5JR54R7df1y98PouzZ8QxwS0lu0BeAm+cMw6ZG7HDjg83P9TK28YIO16BEcSKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MvCjS6e8; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=DoDm5
	WqdyCSw9zF05uuOrOwB9tjNVDa1inbfEQownEE=; b=MvCjS6e87WvZz9JFfl5B9
	zt0LAyOeLBlAynUPr8eWPvKjSdDOktZ+iQbNlBrg9PLOij5F5YNrZKm/HYl6vsw2
	aCb2CEkvIPYD1hpf+6A2+obCO9jsrAR3mvgY0YtN/X2VTALUnf7ke6Z6iYB7yTar
	TfO3J8z1BqG2o0HTMUDTMI=
Received: from zhuxin.hobot.cc (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3_9U4UchnyQT7QQ--.64878S2;
	Wed, 05 Mar 2025 21:27:33 +0800 (CST)
From: Zxyan Zhu <zxyan20@163.com>
To: gregkh@linuxfoundation.org
Cc: broonie@kernel.org,
	rafael@kernel.org,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	Zxyan Zhu <zxyan20@163.com>
Subject: [PATCH v3] regmap: debugfs: Fix name collision without atomic operations
Date: Wed,  5 Mar 2025 21:27:18 +0800
Message-Id: <20250305132718.40247-1-zxyan20@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_9U4UchnyQT7QQ--.64878S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr47Ww47ur4xKFW8Jr4xZwb_yoW5ZFWDpa
	1kG3WrKwsrAr4rJrWYya18CFySk392vFy3A3yru3W5Zwnaqr47JF4vgFWYyryDuryUXw1U
	XF4ay34UCr1UtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pirHU3UUUUU=
X-CM-SenderInfo: p201t0isq6il2tof0z/xtbBhgEHXmfIQCz6IQAAsG

The `dummy_index` global variable caused debugfs file name conflicts
during re-entry, leading to creation failures. Use atomic operations
to ensure safe and unique debugfs `dummy%d` naming.

Signed-off-by: Zxyan Zhu <zxyan20@163.com>

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
---
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



Return-Path: <linux-kernel+bounces-314009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D174A96ADA5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 03:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49DE41F25AAC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 01:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D507A4A28;
	Wed,  4 Sep 2024 01:13:34 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB36B10F7
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 01:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725412414; cv=none; b=lpMxVoppZDYdFSgiF/QgSCNk41N6uzRE4ZovRgc/d9j1T22Q/EMbCYZsk68joJmM1ugDfWI8EaMJVr94YpDGIjVhZ9gdTwdCU+jCJk9vOt4YCuyOSNXtIiq1+rNFxMwLTtSG6ekhDXrzjiGDZKwTtonQtaZOBsNR/yT6P/0ux8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725412414; c=relaxed/simple;
	bh=BDgdnVMogk09jOfCq18EJNffj79Z6DznqgJQHqINZxw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZzW5u8qXR4c+WQmppbKZT5008qiZrHcKl3oWUFT2ccXEKAlaf4L0zQgyu5hBCBgUchclwMnrpXNFulO5RUVHhfPXUV1Tln86ufm9Hky6/wd/Q2WSJbxO0oOchCnKRM1dTcH3gafy0Dpg9/OxCTI5wGktNRC12odzUfJHzG+Qe2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wz4Fh5qR7zpVGK;
	Wed,  4 Sep 2024 09:11:36 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id D8F28140414;
	Wed,  4 Sep 2024 09:13:28 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 4 Sep
 2024 09:13:28 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <gregkh@linuxfoundation.org>
CC: <lihongbo22@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] uio: Constify struct kobj_type
Date: Wed, 4 Sep 2024 09:22:00 +0800
Message-ID: <20240904012200.2010916-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)

These 'struct kobj_type' are not modified. They are only used in
kobject_init() which takes a 'const struct kobj_type *ktype'
parameter.

Constifying these structure and moving them to a read-only
section (from data to text), and can increase over all security.

```
[Before]
   text   data    bss    dec    hex    filename
  10330   1908     20  12258   2fe2    drivers/uio/uio.o

[After]
  text    data    bss    dec    hex    filename
  10458   1844     20  12322   3022    drivers/uio/uio.o
```

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 drivers/uio/uio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 20d2a55cb40b..004a549c6c7d 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -118,7 +118,7 @@ static const struct sysfs_ops map_sysfs_ops = {
 	.show = map_type_show,
 };
 
-static struct kobj_type map_attr_type = {
+static const struct kobj_type map_attr_type = {
 	.release	= map_release,
 	.sysfs_ops	= &map_sysfs_ops,
 	.default_groups	= map_groups,
@@ -207,7 +207,7 @@ static const struct sysfs_ops portio_sysfs_ops = {
 	.show = portio_type_show,
 };
 
-static struct kobj_type portio_attr_type = {
+static const struct kobj_type portio_attr_type = {
 	.release	= portio_release,
 	.sysfs_ops	= &portio_sysfs_ops,
 	.default_groups	= portio_groups,
-- 
2.34.1



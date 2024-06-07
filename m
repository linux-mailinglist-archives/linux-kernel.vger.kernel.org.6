Return-Path: <linux-kernel+bounces-205338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D74FC8FFAAA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61C40B23937
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A27E15B0F4;
	Fri,  7 Jun 2024 04:27:34 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E80315AAB1
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734452; cv=none; b=pV13nLr9I3SoLWQkfDxHCBGGRyVTY0Dx9NOzWHQoy6I9AoEAToNiS3W91oeOL2+zjP+HNiM2yOKN0nIOvt4cb40FZbrsQoIj1FnL3Q8ha2VOgm4v+/N9hjGv1KOfomB0bIrwjLivWZOqo6jGnTME7R/1fNkCdtXV8aFJmXg9D+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734452; c=relaxed/simple;
	bh=mPrAe2UVuBplSMLi2TXauuCSsb/mbFPlTH2FOWlYb6c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SC/aAcLHV5mVrkDDK5J1fzBGTztY5266RjkEAFh1paGdTqc5yZnoTWecis5CaxifF8hynHsSpAe9480fMKkPytHmavD9zZLizC1rDRRlK+Og3yEIUCmKRXFBBmGj2/EGO+T3UuTX0avDJd9Y9hiVCcB+hw4GIB5tIcDn8kC8yp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VwSjP5d5lzmYRQ;
	Fri,  7 Jun 2024 12:22:49 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 97025180085;
	Fri,  7 Jun 2024 12:27:25 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:08 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 056/110] ubifs-utils: open_ubi: Set errno if the target is not char device
Date: Fri, 7 Jun 2024 12:25:21 +0800
Message-ID: <20240607042615.2069840-57-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607042615.2069840-1-chengzhihao1@huawei.com>
References: <20240607042615.2069840-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)

Set errno if the target is not char device. It will be useful for
fsck to print error message if open_ubi failed.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/libubifs/super.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/ubifs-utils/libubifs/super.c b/ubifs-utils/libubifs/super.c
index 1cbbfcac..9fa366f3 100644
--- a/ubifs-utils/libubifs/super.c
+++ b/ubifs-utils/libubifs/super.c
@@ -43,9 +43,14 @@ int open_ubi(struct ubifs_info *c, const char *node)
 {
 	struct stat st;
 
-	if (stat(node, &st) || !S_ISCHR(st.st_mode))
+	if (stat(node, &st))
 		return -1;
 
+	if (!S_ISCHR(st.st_mode)) {
+		errno = ENODEV;
+		return -1;
+	}
+
 	c->libubi = libubi_open();
 	if (!c->libubi)
 		return -1;
-- 
2.13.6



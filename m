Return-Path: <linux-kernel+bounces-424225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E9C9DB1C6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 04:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26A74B21C5C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 03:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186A184A5E;
	Thu, 28 Nov 2024 03:18:38 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0AC256D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 03:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732763917; cv=none; b=GTk4iUqBjQL4EXd+mveCOtOeJlOhkkDy3r72rEMwf5rXiSUkfR88jH8+dhvPsra/zHaabvSSpzLzw1rTG4VSfUcP6XYvfZ7XYivIENGlAyxv1dGc4C2Z+egpPe/EbiyoO7tQINE/W7xlsIP73LAEZ6WyPVYykDbuH5t0CTh2iBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732763917; c=relaxed/simple;
	bh=TiR0Dn++jWa6gVEEWOieYWYgbH3PEeN5LZwzDJmLVb0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wj3d+vc9zy4QxubM0hf3vwCLItLwS33PiAoqW/UY5XZFt5WvCO2T6g6U7Uirhum4nLr2u72mxA1S89Aib4/mWED0DvbRyxWZ9SxxtXa9j8nl4uojeiA6m2PRZVegAihmjVsLdTOSebEijZA2zESNzHVKpjdPkZk2gbUb2afVhdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XzM0M6dPQz2Gbqc;
	Thu, 28 Nov 2024 11:16:19 +0800 (CST)
Received: from kwepemf200016.china.huawei.com (unknown [7.202.181.9])
	by mail.maildlp.com (Postfix) with ESMTPS id B77541A0188;
	Thu, 28 Nov 2024 11:18:28 +0800 (CST)
Received: from huawei.com (10.113.213.244) by kwepemf200016.china.huawei.com
 (7.202.181.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 28 Nov
 2024 11:18:28 +0800
From: Wang Jianjian <wangjianjian3@huawei.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	<linux-kernel@vger.kernel.org>
CC: <wangjianjian0@foxmail.com>, Wang Jianjian <wangjianjian3@huawei.com>
Subject: [PATCH] fat: use nls_tolower simplify code
Date: Thu, 28 Nov 2024 11:12:34 +0800
Message-ID: <20241128031234.3668274-1-wangjianjian3@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf200016.china.huawei.com (7.202.181.9)

Signed-off-by: Wang Jianjian <wangjianjian3@huawei.com>
---
 fs/fat/dir.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index acbec5bdd521..88bf16204aab 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -214,10 +214,7 @@ fat_short2lower_uni(struct nls_table *t, unsigned char *c,
 		*uni = 0x003f;	/* a question mark */
 		charlen = 1;
 	} else if (charlen <= 1) {
-		unsigned char nc = t->charset2lower[*c];
-
-		if (!nc)
-			nc = *c;
+		unsigned char nc = nls_tolower(t, *c);
 
 		charlen = t->char2uni(&nc, 1, uni);
 		if (charlen < 0) {
-- 
2.34.1



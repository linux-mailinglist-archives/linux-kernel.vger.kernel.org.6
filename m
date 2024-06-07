Return-Path: <linux-kernel+bounces-205283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAC78FFA6D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBEDE1F24726
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026001BDCD;
	Fri,  7 Jun 2024 04:26:34 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4705418EA1
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734393; cv=none; b=JKisKFTC7RUMyywQn9RSuhwNZT0IIPi9JXCUF4qENnjKuPvNhTc4pGrsyGz0/TGbISQG4RyaOptPFZb66o1Ash7tOX0PRbr2dGAh1AOT/x2wWuZ+TbYeQBtWX8PvIS7TZxOzdUud9PTVgbg41OJZP+GDyz3nfyfmfGQpyj3Iwfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734393; c=relaxed/simple;
	bh=OubTEbmvvT4uQyxu+ylLsWyh+v4hByOhHO8hJew60KY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RibqyxN8D8i988ENk1ewLF0xeLwvEE9TQhNxjS6mvifzNQyMT/wZfjUCNkvybLsMcYDXbUv9e93HSu85l7xUFW/rpnfwA9PNjRXLOb5+VHnwpDhVEtH5wWca60MKFJvTmbTfM+PlgQ3ERBFk2cEtflyh4Q73MU4owDwDrhn2v8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4VwSjK2cKpz1S6K9;
	Fri,  7 Jun 2024 12:22:45 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C1E61400D3;
	Fri,  7 Jun 2024 12:26:28 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:26:27 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 002/110] mkfs.ubifs: Initialize 'cipher_name' as NULL
Date: Fri, 7 Jun 2024 12:24:27 +0800
Message-ID: <20240607042615.2069840-3-chengzhihao1@huawei.com>
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

Variable 'cipher_name' is defined on stack without initialization, when
an user invokes mkfs with '--key' and without '-C', 'cipher_name' is a
random value, which could cause init_fscrypt_context() failed to find a
valid cipher.
Fix it by initializing 'cipher_name' as NULL when it is declared.

Fixes: cc4c5e295f546 ("mkfs.ubifs: Enable support for building without crypto")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/mkfs.ubifs/mkfs.ubifs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c b/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
index 5ca01512..b91a3e2d 100644
--- a/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
+++ b/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
@@ -556,7 +556,7 @@ static int get_options(int argc, char**argv)
 	struct stat st;
 	char *endp;
 #ifdef WITH_CRYPTO
-	const char *cipher_name;
+	const char *cipher_name = NULL;
 #endif
 
 	c->fanout = 8;
-- 
2.13.6



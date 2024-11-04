Return-Path: <linux-kernel+bounces-394842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D15899BB4BC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4CC1C21ED9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A26518BC0E;
	Mon,  4 Nov 2024 12:34:53 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D276D469D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 12:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730723692; cv=none; b=TFOrgk9fgGxVwuLDWYITIAzncXCEZpO8kfDAOC5lRHXAVJ7vN4plVJyapFwmxXhGgAv9u78KqmRQ2/GZuG6GG14Wt3L3TuC7vr71KxJcB+QwGr3oDSzmuJ2F44yBDJ9HKNKrgICj+q5kGXpKSPfzgotD160Hy9pfHptXjtEWNHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730723692; c=relaxed/simple;
	bh=PmCb/NGm1NJk+YdAb6d36wxlhP6lWKlZM8/+yNTHvkc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W9gJ2O24sseieu2HxZ+OqM9zgNDxFy7IzaE4BMfoFAA/TL90UpN09FJ9/rOvKzgLrf7OyzUKtwg0n4v58xBzwmrv317BWpp64IO9giMUvOiroL4h3mP6SId1bPSmS95u/+d1tMs7nQFSk1Isj+14bNfh4kjNAmV8kmNJONKhn+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XhrTv3Wxpz1SDrD;
	Mon,  4 Nov 2024 20:33:07 +0800 (CST)
Received: from kwepemj200012.china.huawei.com (unknown [7.202.194.24])
	by mail.maildlp.com (Postfix) with ESMTPS id A7B6D1A016C;
	Mon,  4 Nov 2024 20:34:46 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemj200012.china.huawei.com (7.202.194.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 4 Nov 2024 20:34:45 +0800
From: Peng Zhang <zhangpeng362@huawei.com>
To: <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <richard@nod.at>, <anton.ivanov@cambridgegreys.com>,
	<johannes@sipsolutions.net>, <willy@infradead.org>, <josef@toxicpanda.com>,
	<brauner@kernel.org>, <zhangxiaoxu5@huawei.com>, <wanghai38@huawei.com>,
	<zhangpeng362@huawei.com>
Subject: [PATCH] hostfs: Fix the NULL vs IS_ERR() bug for __filemap_get_folio()
Date: Mon, 4 Nov 2024 20:34:40 +0800
Message-ID: <20241104123440.1347175-1-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemj200012.china.huawei.com (7.202.194.24)

From: ZhangPeng <zhangpeng362@huawei.com>

The __filemap_get_folio() function returns error pointers.
It never returns NULL. So use IS_ERR() to check it.

Fixes: 1da86618bdce ("fs: Convert aops->write_begin to take a folio")
Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
---
 fs/hostfs/hostfs_kern.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 6d1cf2436ead..084f6ed2dd7a 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -471,8 +471,8 @@ static int hostfs_write_begin(struct file *file, struct address_space *mapping,
 
 	*foliop = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
 			mapping_gfp_mask(mapping));
-	if (!*foliop)
-		return -ENOMEM;
+	if (IS_ERR(*foliop))
+		return PTR_ERR(*foliop);
 	return 0;
 }
 
-- 
2.25.1



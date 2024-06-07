Return-Path: <linux-kernel+bounces-205291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1F18FFA7A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFD2E1C22253
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF6F13E41D;
	Fri,  7 Jun 2024 04:26:54 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFAC13E041
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734413; cv=none; b=ro6hPdaO3gbRzw3YFNqE+IND5/UCmHJmiN3S5zEfC1OmpY1B3aop1QrnZj7W0FhteseiGgAi5gDoW7lLKdRF8Im/Vr84eKMt/nKzVAkzCj4shImy3jFbrXI8o1sfxVxs0uzKU9PB023cDi+xNmMv1D6QK5FE3NqOAVtO0Apho+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734413; c=relaxed/simple;
	bh=sU2x5b/EvrBaeXm7hZpVhgo6XKCgm3qdgzglMy43Fmg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VMma6dmU0eO0XmAX6+W9CKXLev3W6JPB+9H2G0SlGu4iLEyuYrwRje/01OkUV5uufKqa2vHjW4sUGG8UgHtQ2vstuZ7+JAUnCQazmo2pT79qZgBtuacdd6083zhuxnUiUM3xPLhbBLzOVs/hlf/YE/x/fG40WN8TdJFQAhWuWa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VwShk3xfrzmXhG;
	Fri,  7 Jun 2024 12:22:14 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 6211D1400D5;
	Fri,  7 Jun 2024 12:26:50 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:26:35 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 012/110] mkfs.ubifs: Fix memleak for 'output' in error paths
Date: Fri, 7 Jun 2024 12:24:37 +0800
Message-ID: <20240607042615.2069840-13-chengzhihao1@huawei.com>
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

The 'output' is allocated in get_options(), don't forget to free it
in error paths, move 'output' freeing out of close_target(), which
simplifies the logic of close_target().

Fixes: 36ec51948e0ec ("Add mkfs.ubifs")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/mkfs.ubifs/mkfs.ubifs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c b/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
index 949187ea..f66c6a46 100644
--- a/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
+++ b/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
@@ -2898,8 +2898,6 @@ static int close_target(void)
 		if (close(out_fd) == -1)
 			return sys_errmsg("cannot close the target '%s'", output);
 	}
-	if (output)
-		free(output);
 	return 0;
 }
 
@@ -3096,6 +3094,7 @@ int main(int argc, char *argv[])
 		printf("Success!\n");
 
 out:
+	free(output);
 	close_ubi();
 	crypto_cleanup();
 	return err;
-- 
2.13.6



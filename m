Return-Path: <linux-kernel+bounces-235034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C76091CEA1
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 20:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA2E81F21B8E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 18:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E2C134402;
	Sat, 29 Jun 2024 18:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gpRxZV3t"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD06132118
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 18:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719687493; cv=none; b=L4PIDFx2Vi/CiBY7jOsuSA4riIqBGThlUi6l1BOyRTQH9AAnZx/PKsZXe/Z4yN/fWlCOOGbFbJru6Pq3q0lSZYeDz8IuxLGpJ0kFNGxcsdD9jiFgTG5NEsBkEYkjfoIuU8YGe0usDvUT6vPqfvzz6ib8bIJ/dtJyRmMRX+lRkiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719687493; c=relaxed/simple;
	bh=4XdOuO+suNvQDwIYnF6y+V7ZtBcFHF+TeDB/fbDthHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f3WM8pUBk6WZBTwUwflAANJ5HuuzHnl+z0kIjbkUjrWG4fbIKPqbPjp+1z4oT3hIoGnHmkyPidpK4JaxR1RZLn5j8aL2iFtpKhO7/497sFFXGlTxoCYBTI/bRvER+BLPiqXQmkz9Rhd920SFB0nucbHKlpP7MiIW6FtBhNimEhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gpRxZV3t; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719687483; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=iQNmjx9aMgLa1f79E0y6SIn1TUROyrKh2kuEUUI4uHQ=;
	b=gpRxZV3tSL23DGQUQ60MM8mzSVFjaPXpKZlQG1eWYN6bsHPrZcuA5H6UDh2U9RvbPLyY9E+d6cuacBOeHPGzzfnCQgVF1JKAmdkPGMbi+8/GZWyWAmAQWH/PXLkORBiUpE8mbSnBEthU2nXOxLvIB2eFYYowkLRFbpK7SOrmUrY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W9ThmIU_1719687464;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W9ThmIU_1719687464)
          by smtp.aliyun-inc.com;
          Sun, 30 Jun 2024 02:58:02 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: ensure m_llen is reset to 0 if metadata is invalid
Date: Sun, 30 Jun 2024 02:57:43 +0800
Message-ID: <20240629185743.2819229-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes, the on-disk metadata might be invalid due to storage
failure or other unknown issues.

In that case, z_erofs_map_blocks_iter() may still return a valid
m_llen while other fields remain invalid (e.g., m_plen can be 0).

Due to the return value of z_erofs_scan_folio() in some path will
be ignored on purpose, the following z_erofs_scan_folio() could
then use the invalid value by accident.

Let's reset m_llen to 0 to prevent this.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 9b248ee5fef2..74d3d7bffcf3 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -711,6 +711,8 @@ int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
 
 	err = z_erofs_do_map_blocks(inode, map, flags);
 out:
+	if (err)
+		map->m_llen = 0;
 	trace_z_erofs_map_blocks_iter_exit(inode, map, flags, err);
 	return err;
 }
-- 
2.43.5



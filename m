Return-Path: <linux-kernel+bounces-177631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD138C41F2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BC391F238DB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 13:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3740A1534E0;
	Mon, 13 May 2024 13:31:09 +0000 (UTC)
Received: from smtp.cecloud.com (unknown [1.203.97.240])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3251474BB
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 13:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.203.97.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607068; cv=none; b=M4S9wfOHDWJH53d43WsEnMSmKGUT+FeuHiOBOXnK9UwMBLg6E+pg9tk/rswvm/xI6GVBHM/OUMBLRzDVrhA9ifQS7018RYAIAxIIE/vhaZP+/saDGca9hb1ZW66KidS0scNGlyvZfHLAZHvmdE/eEeVMvCfb+oE603aCMdMAuHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607068; c=relaxed/simple;
	bh=MTdxi2ale3fW7dSHpstO+MvldCGiFjelycSbJ+wqZuY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oSeS1HKGq4juBXLJ8k4p7ikHYHtcJlYZiEk+ib9ZySEf29EK5ZCDJVFBENi2/3C5gNoMgwb93oV0cfb/DadNgCWGJ2ESWc4oEvPi9LezzdN6SHdtRx73xIusT13Pc3yJu+iuW7LNtJKAS6VLJKIQcJtSjE5Yr7mZWnMeS14ldCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn; spf=pass smtp.mailfrom=cestc.cn; arc=none smtp.client-ip=1.203.97.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cestc.cn
Received: from localhost (localhost [127.0.0.1])
	by smtp.cecloud.com (Postfix) with ESMTP id 14E4A900113;
	Mon, 13 May 2024 21:24:25 +0800 (CST)
X-MAIL-GRAY:0
X-MAIL-DELIVERY:1
X-ANTISPAM-LEVEL:2
X-ABS-CHECKED:0
Received: from localhost.localdomain (205.241.211.222.broad.my.sc.dynamic.163data.com.cn [222.211.241.205])
	by smtp.cecloud.com (postfix) whith ESMTP id P894637T281472879423856S1715606664328465_;
	Mon, 13 May 2024 21:24:24 +0800 (CST)
X-IP-DOMAINF:1
X-RL-SENDER:liuwei09@cestc.cn
X-SENDER:liuwei09@cestc.cn
X-LOGIN-NAME:liuwei09@cestc.cn
X-FST-TO:willy@infradead.org
X-RCPT-COUNT:4
X-LOCAL-RCPT-COUNT:1
X-MUTI-DOMAIN-COUNT:0
X-SENDER-IP:222.211.241.205
X-ATTACHMENT-NUM:0
X-UNIQUE-TAG:<9d514f52b8d39a8dbda5d1923a1262b2>
X-System-Flag:0
From: Liu Wei <liuwei09@cestc.cn>
To: willy@infradead.org
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	liuwei09@cestc.cn
Subject: [PATCH] mm/filemap: invalidating pages is still necessary when io with IOCB_NOWAIT
Date: Mon, 13 May 2024 21:23:39 +0800
Message-ID: <20240513132339.26269-1-liuwei09@cestc.cn>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit (6be96d3ad3 fs: return if direct I/O will trigger writeback),
when we issuing AIO with direct I/O and IOCB_NOWAIT on a block device, the
process context will not be blocked.

However, if the device already has page cache in memory, EAGAIN will be
returned. And even when trying to reissue the AIO with direct I/O and
IOCB_NOWAIT again, we consistently receive EAGAIN.

Maybe a better way to deal with it: filemap_fdatawrite_range dirty pages
with WB_SYNC_NONE flag, and invalidate_mapping_pages unmapped pages at
the same time.

Signed-off-by: Liu Wei <liuwei09@cestc.cn>
---
 mm/filemap.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 30de18c4fd28..1852a00caf31 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2697,8 +2697,15 @@ int kiocb_invalidate_pages(struct kiocb *iocb, size_t count)
 
 	if (iocb->ki_flags & IOCB_NOWAIT) {
 		/* we could block if there are any pages in the range */
-		if (filemap_range_has_page(mapping, pos, end))
+		if (filemap_range_has_page(mapping, pos, end)) {
+			if (mapping_needs_writeback(mapping)) {
+				__filemap_fdatawrite_range(mapping,
+						pos, end, WB_SYNC_NONE);
+			}
+			invalidate_mapping_pages(mapping,
+					pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
 			return -EAGAIN;
+		}
 	} else {
 		ret = filemap_write_and_wait_range(mapping, pos, end);
 		if (ret)
-- 
2.42.1





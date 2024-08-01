Return-Path: <linux-kernel+bounces-270789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBED94454B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4822B1F216CD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 07:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1D416DC18;
	Thu,  1 Aug 2024 07:17:38 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCE016D4DD
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 07:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722496657; cv=none; b=fCQpvuw+dDBIDpYbATBCGquMsuxcViIWg9rDmurzpfcIrbUMIVbNJwVT8bNDfn08L+YCw6lv0kBv2OQfkoDB5XQ9v16P8sCN9JtCfFFQwtLdoBykULXuTaZTHVUQKXpZVXq28Ostt1L/zIi7c94/tNXiU5hP6cF2GILzdTO+PqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722496657; c=relaxed/simple;
	bh=dLkW0E/ybwTjAaGBfgZp74Utqgah0iGpllA3fNq0MK8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qeL7D5yaLvvrfvMmf3+AoPlfUZFz70We26QFjlNLjlrIjNnu2ggFWW4Z/Q5Qrq/QneJn2v+ZazLu2d7AclHmzzuazP9C/G5jEubjg+DTqec9Xl5L5pjz4vXbwyIWyjjWIrG3VlUMbd9tbES2KrlQT3PXP50BIRlImf0PRfWmJck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from inp1wst083.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 1 Aug
 2024 10:17:19 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>,
	<linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>, Karina Yankevich <k.yankevich@omp.ru>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] f2fs: file: add checks to f2fs_ioc_flush_device()
Date: Thu, 1 Aug 2024 10:17:07 +0300
Message-ID: <20240801071707.8296-1-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 08/01/2024 06:59:26
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 186817 [Jul 31 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 24 0.3.24
 186c4d603b899ccfd4883d230c53f273b80e467f
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;inp1wst083.omp.ru:7.1.1;81.22.207.138:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 81.22.207.138
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/01/2024 07:03:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 8/1/2024 5:04:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

If invalid data is copied from user space and if GET_SEGNO()
returns NULL_SEGNO an overflow is possible.

Add checks for invalid values.

Found by Linux Verification Center (linuxtesting.org) with Svace.

Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
---
 fs/f2fs/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 168f08507004..1b9c4fee9db1 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3093,6 +3093,9 @@ static int f2fs_ioc_flush_device(struct file *filp, unsigned long arg)
 		start_segno = dev_start_segno;
 	end_segno = min(start_segno + range.segments, dev_end_segno);
 
+	if (start_segno > F2FS_MAX_SEGMENT - range.segments || end_segno == NULL_SEGNO)
+		return -EINVAL;
+
 	while (start_segno < end_segno) {
 		if (!f2fs_down_write_trylock(&sbi->gc_lock)) {
 			ret = -EBUSY;
-- 
2.43.0



Return-Path: <linux-kernel+bounces-182055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F4C8C85AD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 13:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32E501F2416E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 11:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46A93E471;
	Fri, 17 May 2024 11:28:11 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74A72BCFD
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 11:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715945291; cv=none; b=jTyXkTBL1a+qUrahjxmIcThund3mlblm5H8oRvK3qIdbUGMcaVTfLKHu7jbB2tz0XK5CSQRA7ZR8z4dL7ovSLKg04BK1AKPh5btnI4JJ+JxmkXPvP0rBEHwRfyvD5o7FS3o2rQ/wWqA7WjtW9uxHx/+JJRv18BVji2s4yxEy1iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715945291; c=relaxed/simple;
	bh=cXA+wMh0DoUH+aNA0HoHewqoDE2nsQtINGtHwe1mWUM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PwBsrh1uXEsZnpSCPJbAkn9qhBnRLB/4Y/tIzI61sEEyWcehBGdUwiGX33RRHQK+k4wlcV1mwfSXaAWbuAxAN+mzYyY2/TygkKHyT8fcCwuTA8ygUrvUhMNMhXLhUwqzKuVkaOS6NU7J4E26WXhLY7WD4I4a6PGOhWprK8ILg6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 44HBRIr9071358;
	Fri, 17 May 2024 19:27:18 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Vgl300WpXz2PdW2s;
	Fri, 17 May 2024 19:23:56 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 17 May 2024 19:27:10 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <Hao_hao.Wang@unisoc.com>
Subject: [PATCH] f2fs: fix to check return value of f2fs_allocate_new_section
Date: Fri, 17 May 2024 19:26:42 +0800
Message-ID: <1715945202-30045-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 44HBRIr9071358

commit 245930617c9b ("f2fs: fix to handle error paths of {new,change}_curseg()")
missed this allocated path, fix it.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 fs/f2fs/segment.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a0ce3d0..71dc8042 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -5190,7 +5190,9 @@ static int fix_curseg_write_pointer(struct f2fs_sb_info *sbi, int type)
 	if (cs->next_blkoff) {
 		unsigned int old_segno = cs->segno, old_blkoff = cs->next_blkoff;
 
-		f2fs_allocate_new_section(sbi, type, true);
+		err = f2fs_allocate_new_section(sbi, type, true);
+		if (err)
+			return err;
 		f2fs_notice(sbi, "Assign new section to curseg[%d]: "
 				"[0x%x,0x%x] -> [0x%x,0x%x]",
 				type, old_segno, old_blkoff,
-- 
1.9.1



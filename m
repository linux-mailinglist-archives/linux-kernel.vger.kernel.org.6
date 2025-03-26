Return-Path: <linux-kernel+bounces-576683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 863D1A71303
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DE141889DF5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A151A23A9;
	Wed, 26 Mar 2025 08:47:47 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BDD3D6A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 08:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742978867; cv=none; b=P5mnfYpkd9bx2U4liYppiIOGy0bgAxeGYUG4KjAtcPsk2pt+hVWUqOy5vv5iY7tOzEQNhvqccIak/QqaDIMG7wTfROCZmr5cDezKLPMuAuH1EsdHlZVXCnMG6ea8rm/uyQIBiA6KONRBva9TnLntJeCocrAxNmW39io/+Fa69v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742978867; c=relaxed/simple;
	bh=Fp/WQjQ/c+kx+e/v6g7c5IPvw1yAX4VKRzGqaxxUEWI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g9BEIbfCbEQ/NpU71S54xVzcNy9cVXCY0MRe9JL2y8ZkndhzhV4IQRdVlUcOcVD9XV29Kj0w1W2W2xq7Yh5cKH/JuTkiJ0R+e7TzQMuMYt+HIxwX91EON3BKayuGVbRuCd8Xr1s+2HGEdG/bVWXTjg46a0Sw5XWnF0JTPavHoNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 52Q8kcNi031891;
	Wed, 26 Mar 2025 16:46:38 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4ZN0kQ3yz2z2KhRXC;
	Wed, 26 Mar 2025 16:46:06 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Wed, 26 Mar 2025 16:46:36 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <daehojeong@google.com>, <niuzhiguo84@gmail.com>,
        <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <Hao_hao.Wang@unisoc.com>
Subject: [RFC PATCH] f2fs: remove some redundant flow about FI_ATOMIC_DIRTIED
Date: Wed, 26 Mar 2025 16:46:01 +0800
Message-ID: <1742978761-16264-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 52Q8kcNi031891

Commit fccaa81de87e ("f2fs: prevent atomic file from being dirtied before commit")
adds the processing of FI_ATOMIC_DIRTIED in the following two positions,
[1]
f2fs_commit_atomic_write
 - __f2fs_commit_atomic_write
  - sbi->committed_atomic_block += fi->atomic_write_cnt;
  - set_inode_flag(inode, FI_ATOMIC_COMMITTED);
  - if (is_inode_flag_set(inode, FI_ATOMIC_DIRTIED)) {
  -    clear_inode_flag(inode, FI_ATOMIC_DIRTIED);
  -    f2fs_mark_inode_dirty_sync(inode, true);
  - }
[2]
f2fs_abort_atomic_write
  - if (is_inode_flag_set(inode, FI_ATOMIC_DIRTIED)) {
  -    clear_inode_flag(inode, FI_ATOMIC_DIRTIED);
  -    f2fs_mark_inode_dirty_sync(inode, true);
  - }

but [1] seems to be redundant:
The atomic file flag FI_ATOMIC_FILE is still set here, so f2fs_mark_inode_dirty_sync
still does not set the dirty state to vfs. If FI_ATOMIC_DIRTIED was originally set
when atomic file is committing, then FI_ATOMIC_DIRTIED is just cleared here, and
then do the repeating action of setting FI_ATOMIC_DIRTIED?
So is it enough to do this only in [2]?

Cc: Daeho Jeong <daehojeong@google.com>
Fixes: fccaa81de87e ("f2fs: prevent atomic file from being dirtied before commit")
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 fs/f2fs/segment.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 396ef71..d4ea3af 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -376,10 +376,6 @@ static int __f2fs_commit_atomic_write(struct inode *inode)
 	} else {
 		sbi->committed_atomic_block += fi->atomic_write_cnt;
 		set_inode_flag(inode, FI_ATOMIC_COMMITTED);
-		if (is_inode_flag_set(inode, FI_ATOMIC_DIRTIED)) {
-			clear_inode_flag(inode, FI_ATOMIC_DIRTIED);
-			f2fs_mark_inode_dirty_sync(inode, true);
-		}
 	}
 
 	__complete_revoke_list(inode, &revoke_list, ret ? true : false);
-- 
1.9.1



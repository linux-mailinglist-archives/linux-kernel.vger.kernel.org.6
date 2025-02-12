Return-Path: <linux-kernel+bounces-510353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A85CDA31B97
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 02:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28E9C1887E52
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 01:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D92486355;
	Wed, 12 Feb 2025 01:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzisAyF9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A8E6F30C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 01:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739325295; cv=none; b=n2SgTBuQn8AnBR99eoQodgc6gmfppC1wTh/3mJi+QYQ9h45/yFjvkAyIdNB6BVwafgkDWyW2c27VGL/zK6+RYaTtjETM5rZvONGSKeSXM7ZHieLcScjrxBikQQ7tqCquugEGL4eRd+aqk9QJaFIR3dTRNlAoF9kcSNlGXtP8EkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739325295; c=relaxed/simple;
	bh=k1i6OnM4vggKxSRbw8FWHtmyl30AxTlQ0Io8rRqVT3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DLyXavyU/5KyJpyl1HeSIOaVqJ65qhXrMLTVUD1ZxUErhKdtiGeY4IrQI0P1paPKVFcFyBU3XMrsiFnVPN2V0wivlTnWM84ThzsRDwHoV0O78wIXmD8PAUJiwjZL7a9BxJeXoXkx0ibuh7lD/h6pJ7QWHt1W+9SteFl3W5VqAwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzisAyF9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6675CC4CEE4;
	Wed, 12 Feb 2025 01:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739325294;
	bh=k1i6OnM4vggKxSRbw8FWHtmyl30AxTlQ0Io8rRqVT3s=;
	h=From:To:Cc:Subject:Date:From;
	b=fzisAyF9kn2B5OPov1zXdhCd/Kiy6J9cWng1fouKc8AzXJMW7jidDhjDGO+K4A9ks
	 gwCC0cITtqzWZ7PPsyGg7M34l/STKSbWNgfnTrRwVvdbphR9lYqbfNdmx9UyngTg2y
	 ME9ymtOvmaERx4jwhkJB0NGDLl7SB2+RVygmZqxEKSvJ5c5/S9HNEMwzNfvy9HeXCE
	 ncO+jhTjVoxDt+YPPk4x1AKjEq1SGjvCaeantoxtkkXLmwMi60sruFvmrKd6pBSycA
	 vontoo041CE0xjMJFLf05MAUXlBkeVEzB+U9IM/4d+KAlDnerTiywOWTm80MkpofCU
	 30P3oAjxR6XrA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 1/2] f2fs: don't retry IO for corrupted data scenario
Date: Wed, 12 Feb 2025 09:54:12 +0800
Message-ID: <20250212015413.666375-1-chao@kernel.org>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]

If node block is loaded successfully, but its content is inconsistent, it
doesn't need to retry IO.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index cba2f6bacde4..d6ad7810df69 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -765,8 +765,12 @@ void f2fs_update_inode_page(struct inode *inode)
 		if (err == -ENOENT)
 			return;
 
+		if (err == -EFSCORRUPTED)
+			goto stop_checkpoint;
+
 		if (err == -ENOMEM || ++count <= DEFAULT_RETRY_IO_COUNT)
 			goto retry;
+stop_checkpoint:
 		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_UPDATE_INODE);
 		return;
 	}
-- 
2.48.1.502.g6dc24dfdaf-goog



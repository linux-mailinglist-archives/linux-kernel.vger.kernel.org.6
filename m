Return-Path: <linux-kernel+bounces-302148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2D795FA90
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9FBE1C2220F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8880E199EA1;
	Mon, 26 Aug 2024 20:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFQzwhJK"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E91199940
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 20:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724703839; cv=none; b=XuJj33mxhGeEN1fbNoYTUdMWAhMh773iI01kDbo3c251F9xvKID2KrWy8sRb38U3cGMJf09LWcSY+SE5nAl9ObQW+RaNKnq9vrsjwaYVxpZxOtxdphwSSwGFkn0IcBNT5xsTYgvFBUEdTdbf0sI7Pn8C+XxTaKeQh5r6pWGACgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724703839; c=relaxed/simple;
	bh=XSyISKPjGcN+q22ONXX7qumOIAWLMra9rZLthez1cSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KWzutWWwOP/1azZEn0XsBINR0R5Kq1su7813Vd+c7T8R3iHmz4vog0wQ7x9QTVLNCL+dg2WFHtN7zktUBdd5R06FquRqX9xpKJEDHMhnSOJKfh6AeLj0NPIRyScWvbaZaPYu+WNWCdBLPuamXklvBvp+M1aplBcqJh4TUhqX7ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFQzwhJK; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-201e64607a5so33552055ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 13:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724703837; x=1725308637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WGeGgPWuY1K2FynP7scy8UtSU10OAbl7DE/fg3On6Kk=;
        b=OFQzwhJKr/mvdGAnJOMvsCuXjoE67r0aCDtLO/m3+QewJqdjjNezFhZmEHpyFyYzaE
         eTi3pxAH3yQtk3yeLljYLy4qXe3sih+Qm2ym6LJYwXyYt1e8k+DyUeTMrgmDU/XVt6wY
         sV/Gxmleai5kyv47MY8N0dB6zpLh3+Y+bena89APCYAO9jogV/UyubmQ+ITj1oxINn+D
         +P49gFGQ5AwDxNLwDt3BmDrjgI0rZvP/qFi7KFkGlUG58DxlGGPEfhByUwaCiEqv6O61
         WIlVFiracS1GFvNDHAfF0DXjpt6OXYexNe6/DalLT5JWfVKEfxTN1XddGmNe7YWXQjid
         I+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724703837; x=1725308637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WGeGgPWuY1K2FynP7scy8UtSU10OAbl7DE/fg3On6Kk=;
        b=sjWqWPACL/L8HjD3Ksvcc5maL01JshWQ0/UfVDPeXbJ45wPmVGu+x1+qsR5L0ja8nT
         g3FMYVcLzmcSAnyWBpr0ODkioZ2ZA3A4E9s2pjb02wCsH89kE2/SzavkeWFiH5XNn74Q
         oiCtps0GgmTEwjj9oF7ydEXWNqyLsWQfdNB8fNoxbl1Rd6ZvPlY4bS7QOu+fO62c9DK3
         y3cG9QG9zAeOwA+K3dDZ6vbwYF2oUcGBNAlyiQoUHtcTprFjUuxwT8uOlTPyA/m+xDAS
         EGOGHGUxZX8uIR/1SQ/deuRuhK6N5diSnElDhUiuNz2x+Zam6/bIvk5H95eTrCnfWoZm
         baXQ==
X-Gm-Message-State: AOJu0YybGxxFHcC+RiypHffTYzXc9udXtJkfs26myvFuRfmkQUTj9x7A
	JVNdASPUmGMdtvF1U8uaGpjmlKhV0wONjfDx+PO6lcR3SRQylQCxewdndw==
X-Google-Smtp-Source: AGHT+IH0yXRtZgUiedgapAcFw9gmLlMG5cItC8NxCYiU/+6CoRdUrl4tE1HCQeqmH7Eb4NJ4jPfITQ==
X-Received: by 2002:a17:902:e84f:b0:1fb:6151:f62f with SMTP id d9443c01a7336-2039e4858c2mr136911715ad.28.1724703837293;
        Mon, 26 Aug 2024 13:23:57 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e14:7:f453:fb42:ecd4:259d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855df0c4sm71430265ad.157.2024.08.26.13.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 13:23:57 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: prevent atomic file from being dirtied before commit
Date: Mon, 26 Aug 2024 13:23:52 -0700
Message-ID: <20240826202352.2150294-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

Keep atomic file clean while updating and make it dirtied during commit
in order to avoid unnecessary and excessive inode updates in the previous
fix.

Fixes: 4bf78322346f ("f2fs: mark inode dirty for FI_ATOMIC_COMMITTED flag")
Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/f2fs.h    |  3 +--
 fs/f2fs/inode.c   | 10 ++++++----
 fs/f2fs/segment.c | 10 ++++++++--
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 465b2fd50c70..5a7f6fa8b585 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -801,7 +801,7 @@ enum {
 	FI_COMPRESS_RELEASED,	/* compressed blocks were released */
 	FI_ALIGNED_WRITE,	/* enable aligned write */
 	FI_COW_FILE,		/* indicate COW file */
-	FI_ATOMIC_COMMITTED,	/* indicate atomic commit completed except disk sync */
+	FI_ATOMIC_DIRTIED,	/* indicate atomic file is dirtied */
 	FI_ATOMIC_REPLACE,	/* indicate atomic replace */
 	FI_OPENED_FILE,		/* indicate file has been opened */
 	FI_MAX,			/* max flag, never be used */
@@ -3042,7 +3042,6 @@ static inline void __mark_inode_dirty_flag(struct inode *inode,
 	case FI_INLINE_DOTS:
 	case FI_PIN_FILE:
 	case FI_COMPRESS_RELEASED:
-	case FI_ATOMIC_COMMITTED:
 		f2fs_mark_inode_dirty_sync(inode, true);
 	}
 }
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 1eb250c6b392..5dd3e55d2be2 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -35,6 +35,11 @@ void f2fs_mark_inode_dirty_sync(struct inode *inode, bool sync)
 	if (f2fs_inode_dirtied(inode, sync))
 		return;
 
+	if (f2fs_is_atomic_file(inode)) {
+		set_inode_flag(inode, FI_ATOMIC_DIRTIED);
+		return;
+	}
+
 	mark_inode_dirty_sync(inode);
 }
 
@@ -653,10 +658,7 @@ void f2fs_update_inode(struct inode *inode, struct page *node_page)
 	ri->i_gid = cpu_to_le32(i_gid_read(inode));
 	ri->i_links = cpu_to_le32(inode->i_nlink);
 	ri->i_blocks = cpu_to_le64(SECTOR_TO_BLOCK(inode->i_blocks) + 1);
-
-	if (!f2fs_is_atomic_file(inode) ||
-			is_inode_flag_set(inode, FI_ATOMIC_COMMITTED))
-		ri->i_size = cpu_to_le64(i_size_read(inode));
+	ri->i_size = cpu_to_le64(i_size_read(inode));
 
 	if (et) {
 		read_lock(&et->lock);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 78c3198a6308..2b5391b229a8 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -196,9 +196,12 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
 		truncate_inode_pages_final(inode->i_mapping);
 
 	release_atomic_write_cnt(inode);
-	clear_inode_flag(inode, FI_ATOMIC_COMMITTED);
 	clear_inode_flag(inode, FI_ATOMIC_REPLACE);
 	clear_inode_flag(inode, FI_ATOMIC_FILE);
+	if (is_inode_flag_set(inode, FI_ATOMIC_DIRTIED)) {
+		clear_inode_flag(inode, FI_ATOMIC_DIRTIED);
+		f2fs_mark_inode_dirty_sync(inode, true);
+	}
 	stat_dec_atomic_inode(inode);
 
 	F2FS_I(inode)->atomic_write_task = NULL;
@@ -365,7 +368,10 @@ static int __f2fs_commit_atomic_write(struct inode *inode)
 		sbi->revoked_atomic_block += fi->atomic_write_cnt;
 	} else {
 		sbi->committed_atomic_block += fi->atomic_write_cnt;
-		set_inode_flag(inode, FI_ATOMIC_COMMITTED);
+		if (is_inode_flag_set(inode, FI_ATOMIC_DIRTIED)) {
+			clear_inode_flag(inode, FI_ATOMIC_DIRTIED);
+			f2fs_mark_inode_dirty_sync(inode, true);
+		}
 	}
 
 	__complete_revoke_list(inode, &revoke_list, ret ? true : false);
-- 
2.46.0.295.g3b9ea8a38a-goog



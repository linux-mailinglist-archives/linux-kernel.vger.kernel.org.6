Return-Path: <linux-kernel+bounces-315379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 240A696C1DC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D51152823A5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F1C1DEFC4;
	Wed,  4 Sep 2024 15:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfa+MkyZ"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F0455898
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 15:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725462662; cv=none; b=mx2GSzSgLueHo/Fx6d2WmvV524LyHYkPQ4mjPNGGD4CEHPC//weDoYOYJcHOpv9rV1Y+8iLkPBFvaAps2M5lJoGzCY22x2cW9nj8BBWDfdVJUMRr7SJO4MV2wRaF0RoEmVsoBw9yPcJGncR8BX7Wxj4FntysGnjb+QxSQkToTys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725462662; c=relaxed/simple;
	bh=mVse9Q5sFVCg9ti1xl+pGf2TEkCbAvMAkL3VmLDv9jA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q6nOUG7zQGwzRvgTGtf1jFIYcmMGhABheArEiXQtIZLHvAoBVy5XA61jNPHH/oakfUmzo7rLGEXswLTKls/Kgp3he7lZxHMpAyAKoHuqcTeZuFtCYlfN5HWsl9ykNk/vy83NhrNxnzoUUwgcXOjVbNwzsXWFLb9LYuPfDUP1vrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfa+MkyZ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20551eeba95so31215285ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 08:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725462660; x=1726067460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=43ydKagFmOiArusbTnepvZXequK3FKBWJc82HDWyEIw=;
        b=cfa+MkyZAl32WX6n1tWC8wJ/4RNEqVF1+4ywqZjc03hgPyIHeNdmNado2Jw8+jt4Kp
         uhrZ1XkeuUtCP5JyAH+YfiDfSAvvFc1UCKk6GBJD7yav1nOUI0zfN3eE/lJxZm5bF0I+
         8daoMDkvDFR5g7zGNef5Hx/U9+MGx0AHUxsZZlYtmhiAuEiUGOmk5vJmibec9VOIRKnU
         ZKZ0+GqAwvLryJajxGm7JG/xLlJKzl7ESyZRpUR/IFTtMsFT9i2qT01ZsZoKroREwNyB
         mfoLWRX746epNBdP2VcFId9Bvt6LwxRJ7NxedBY5VbBi1uORC0zHZe2A3obkbCzqVsW6
         JfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725462660; x=1726067460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=43ydKagFmOiArusbTnepvZXequK3FKBWJc82HDWyEIw=;
        b=vLhfd6UHkfIVEFgPMGhvs5O36mNrsBKQBNVctEiuhhjz+aL4UXsofp96FHJEesd+/K
         AvEMwvijJ5QNAQKA9PVkMFslbekZ+h8nKeoF0bzeOAFhLQ0pZMkOknV+Gk3h7uEKqBDE
         tI+P8KpM5Js3peY4F5pZ3JC2uwSOiKbyb9VFpcXq2e9YV3PGf1A3h4fGq7GFGZGqbtXs
         r4SEUz3fveGkrmlqqaftSA+hcuyLX27KiBJRhePTXdbX6L635AoM3RhkeDMvNZQ8sGZK
         u5rzA7bsjmF1O9Zjh29oJ2HmXCtZefpDNhZMXjtlHXYwsRVonS0YTKKFBwtFmW1ZD22z
         20kw==
X-Gm-Message-State: AOJu0YxY0pBFK5DRhnOn9VeeX3oetQBDmp4elkKOaPRH6WSPUzK2mNtw
	t+UWI2LFvVl6grovgN+ABcNYDHytb+Ct1TwdVSDgnwpcIdkpHUg4s3k+Rg==
X-Google-Smtp-Source: AGHT+IGfo/94kB9afFvRPno+mvVQpzCAOhJq+Y9J3yrdPnGat19R1P1vOwtxLsIwUfwROlQ0n6sETw==
X-Received: by 2002:a17:902:e74f:b0:205:7e3f:9e31 with SMTP id d9443c01a7336-2057e3fa1fcmr93168535ad.60.1725462659805;
        Wed, 04 Sep 2024 08:10:59 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e14:7:85f3:1406:4b87:9708])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea55d42sm14629905ad.204.2024.09.04.08.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 08:10:59 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: prevent atomic file from being dirtied before commit
Date: Wed,  4 Sep 2024 08:10:54 -0700
Message-ID: <20240904151054.813444-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
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
v2: take the original logic not to change inode size by inode dirtying
    from VFS layer
---
 fs/f2fs/f2fs.h    | 2 +-
 fs/f2fs/inode.c   | 5 +++++
 fs/f2fs/segment.c | 8 ++++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ac19c61f0c3e..4ef6d877aa36 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -802,6 +802,7 @@ enum {
 	FI_ALIGNED_WRITE,	/* enable aligned write */
 	FI_COW_FILE,		/* indicate COW file */
 	FI_ATOMIC_COMMITTED,	/* indicate atomic commit completed except disk sync */
+	FI_ATOMIC_DIRTIED,	/* indicate atomic file is dirtied */
 	FI_ATOMIC_REPLACE,	/* indicate atomic replace */
 	FI_OPENED_FILE,		/* indicate file has been opened */
 	FI_MAX,			/* max flag, never be used */
@@ -3041,7 +3042,6 @@ static inline void __mark_inode_dirty_flag(struct inode *inode,
 	case FI_INLINE_DOTS:
 	case FI_PIN_FILE:
 	case FI_COMPRESS_RELEASED:
-	case FI_ATOMIC_COMMITTED:
 		f2fs_mark_inode_dirty_sync(inode, true);
 	}
 }
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index aef57172014f..4729c49bf6d7 100644
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
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 78c3198a6308..2f6ee9afd3ad 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -199,6 +199,10 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
 	clear_inode_flag(inode, FI_ATOMIC_COMMITTED);
 	clear_inode_flag(inode, FI_ATOMIC_REPLACE);
 	clear_inode_flag(inode, FI_ATOMIC_FILE);
+	if (is_inode_flag_set(inode, FI_ATOMIC_DIRTIED)) {
+		clear_inode_flag(inode, FI_ATOMIC_DIRTIED);
+		f2fs_mark_inode_dirty_sync(inode, true);
+	}
 	stat_dec_atomic_inode(inode);
 
 	F2FS_I(inode)->atomic_write_task = NULL;
@@ -366,6 +370,10 @@ static int __f2fs_commit_atomic_write(struct inode *inode)
 	} else {
 		sbi->committed_atomic_block += fi->atomic_write_cnt;
 		set_inode_flag(inode, FI_ATOMIC_COMMITTED);
+		if (is_inode_flag_set(inode, FI_ATOMIC_DIRTIED)) {
+			clear_inode_flag(inode, FI_ATOMIC_DIRTIED);
+			f2fs_mark_inode_dirty_sync(inode, true);
+		}
 	}
 
 	__complete_revoke_list(inode, &revoke_list, ret ? true : false);
-- 
2.46.0.469.g59c65b2a67-goog



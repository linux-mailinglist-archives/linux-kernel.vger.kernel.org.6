Return-Path: <linux-kernel+bounces-315419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 573AE96C28B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC81E1F2646C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203991DCB10;
	Wed,  4 Sep 2024 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chbGAVR0"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAD11EC017
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 15:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463993; cv=none; b=WnH2QviNQzmlEVZv2nloQR2Exid2bJyL0BIWDvQ8DrPoSXZtbWJACD3TLTiG52aw7MXPWrwGB1Arl5pJjnBeVu1YaqxDoD8j+Wd9elVeqMP+gqdzNhNngYWsVdY3q3HULi1ic5uWB+KqmFnBldicdMqZGOSC5SWbNpZFA49ePCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463993; c=relaxed/simple;
	bh=mVse9Q5sFVCg9ti1xl+pGf2TEkCbAvMAkL3VmLDv9jA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MWmPUutjvFUC6UCKmBfpldITqTqGSuXWPzqY4GONgL2UH7Z+OTXaQoB5Gr3Tgd8sRwvAX6yLvOgznq8phIAKy26+DnJSXz1BjU/uCrNX8CxWfeyFMDMAcZgsn2trZSEPMbwsYFbCeN5cPCEqraYFlrj27IiaM7jJr26OyaiGEC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chbGAVR0; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7176645e4daso2219524b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 08:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725463991; x=1726068791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=43ydKagFmOiArusbTnepvZXequK3FKBWJc82HDWyEIw=;
        b=chbGAVR0yg2djXYlBaFP37/oKEfK0iu5HhycuEqTAJYdh6kZ6Hhsq4/g2ImESIJQUv
         ECs5HTwamqjOD294vqqWhokbF+QhkntWSlNEQz2MMm1PD8oOhFwNLJBDmCA4YcSi4nVe
         Xi90elbDBfDvfTOGZ/AXVlCS3BvcLOTe5mUzPRqW1qmP9Klc/pGgy5HKUt39AVwCBtsn
         zXhkkS0JdvO3bnkwZ3Ho0BfiFUN5hoGhUXRySXsCrr9dOPjBDSEjSJkAucJjSOpRTVGj
         j7FRVRNPqnMdSdY62Mb5Ga+4b+Y2h9NQH2emQfGCDppczY/chZsXOwjz3GRws7w5kLtj
         NsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725463991; x=1726068791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=43ydKagFmOiArusbTnepvZXequK3FKBWJc82HDWyEIw=;
        b=WScESMSAxn9zM6qjXxMXyo2Imy83oFsLdR5z8Idvp9snB9yByzkaXT1Su83w84WLBe
         SSz6jtcdFfT3SmJE9wXUlJ5tkCpAwkaH1FE21KSxDY/YCWdnCXy4cG3pW5jfrauslI/q
         xDLFxJsNTFyi2zOTxaXt7x/w7oDoqbdVHC72FsUwcHejBviTMTH/MV5sHjWtS8JRkbcl
         gSef+qduMaZVsEyAjYeKmbUiyMRTQGERUchYVMUE+LYm6+elQmV9AsqaBKkUK5K6hwD3
         l6bSDVqw9N6JdLKebuiEj+T2DWa+c/fI716FLzsCwkFX4IbB0vR5Dnm+Uxa5YCakexNE
         t6jg==
X-Gm-Message-State: AOJu0YyhDXvSB2CUDwkyWV+Q2VUPzp9pXhQzbI4E+issE1eqiIYrU4bK
	j8QGw26OUaTdCFArkUR8/BlQwj7n5IaAYSVzzXNroRDhtC2XHUYxQ49xKA==
X-Google-Smtp-Source: AGHT+IHcrIN+v0zbJWwqosxZZmctTqjPG/EVSh/Yn6r1MBARV8oNa7qPLWr1N3y7upuaJDJeGoOz1g==
X-Received: by 2002:a05:6a20:438e:b0:1cc:ea85:a60a with SMTP id adf61e73a8af0-1cece5e24e4mr13664285637.49.1725463991107;
        Wed, 04 Sep 2024 08:33:11 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e14:7:85f3:1406:4b87:9708])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd8d52esm1815791a12.32.2024.09.04.08.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 08:33:10 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v2] f2fs: prevent atomic file from being dirtied before commit
Date: Wed,  4 Sep 2024 08:33:06 -0700
Message-ID: <20240904153306.816988-1-daeho43@gmail.com>
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



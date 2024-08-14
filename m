Return-Path: <linux-kernel+bounces-287206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 237DD95249D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 23:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D4C2B20C75
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 21:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD83E1C5792;
	Wed, 14 Aug 2024 21:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQr6+Thd"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0D713BC0C
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 21:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723670212; cv=none; b=RF9fV2YUib8C2f20oR13xeNLKOOllSAb865k6YLc6zjL6tzU0HMn/yvONCINWrkbufbx0gs2LH1gS99xCGdjuUUNlMepyijQlAjTJzuIzpi5NW04/LaSrT5G86oQxbOUlQ+Mab6N8+O2YA+IV9uP5NZkhuX6GQqumqq5m2aAMt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723670212; c=relaxed/simple;
	bh=JJu10rUqvhoONT4FMW2wGNtKYWRXEinTec4MxVTqdmk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JppojsRBVks2VUjEBsjO4+bN5/pIWCsyOmNyPTlqQKZ5RZlJShHWTadK0DE5a15mnHVtJdkiAUtraNBw5BzVbWnKUZ+5HtKpNhKvrYZCTpwvxzvxSX8FIPI1rk4Dj34Khf30ZunOyiMcbDKKuQxbYjoSkgxTqUIze3sd0M/s0RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQr6+Thd; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70d2ae44790so210752b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723670208; x=1724275008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Hw8lz23tqDzKkzkY8nXMHYNLEk2gqVka2W0RkG9/44=;
        b=UQr6+Thdb2uX8xwc2hGnN/rTe81+x2t56frBWq3/w6HwQ36br8Ikey9FN7MoAljBKq
         ocmyy1Pn4sE83BqYqta0MoD5QLGed6kK4wmaxkdBY0+WP/7Et9vKETarJNuC5cpVp0OD
         lwPjYtrL6QM8SssDKfOZrYL47K7tx3E/0Epj9UfBkzRFqIHN2FEotXcI/EC1RIQo4u2o
         Ov7NS47ScPRyXZiKxA3ZGxQx8Sbi9kaPFA652EU7vhX9sa2leT5Rw8RJHacx5HstcNoJ
         Kkj8REDvNWXStfUjqKVkeQeMl0rLxrevFGe3JeT5HvyqnF3N2XON2z2WyZOOV6AcxmGd
         Y20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723670208; x=1724275008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Hw8lz23tqDzKkzkY8nXMHYNLEk2gqVka2W0RkG9/44=;
        b=nycIqAJFqjO3JIaE3UppKO6/qsZeCr5mmWyTSGZGzn4z9yzUvlb3xsKTF9YWdmkgis
         AnnTN03hD4bCCcrfz+yvZRTZ1fr9iUt3+QnxVTrYcYPGDHgH9IbogAsxYCRU79/bc4pS
         dADylSmDJIc52pU7UuCikPMS8d1EHksdq5zBZSAS9qLGLn7guuHwZCZthD+i4TAhjV0c
         2RcVZ4hRa9JF+mAUa/W9Iu7bLQF3H3DF1t8CMjl0tpSO52yI7yDOsJRmXoAgG4GpEmEd
         hEKtJL+Nla3e+buunij1HPBkWFBKHyhdflhV+wYSZeSqQ3tCD6VvOp/lhdESvABL6UJV
         aNqw==
X-Forwarded-Encrypted: i=1; AJvYcCXVYywhYFgraJitv/5Ud1FnlhAbEIiKkOIC0f0kM5VAVZvc/rPZJrDrrEtQTuZNOBORZot2dYaR0sfI93Wf0GtDgAmUrVkrzLlvey5U
X-Gm-Message-State: AOJu0YzcduAAo9oBGE+oG+I5SkpjDtyzfCv5NsC1xTom9nhSpJ9333n8
	4wIibUVb2qViSd0geR4TY5E/a7mbLiz8Gl6H+OtSrHI1kj184EiepZTd8Q==
X-Google-Smtp-Source: AGHT+IF40yt88J2Butglx46sQdOzBwoONfypAPbzL+xZUb9dsPF3jvjvcdDQmIzPIc31FfLEnidnqA==
X-Received: by 2002:aa7:88cc:0:b0:710:5825:5ba0 with SMTP id d2e1a72fcca58-712670ec998mr5006066b3a.3.1723670208263;
        Wed, 14 Aug 2024 14:16:48 -0700 (PDT)
Received: from ddebjk.ddebjk.net ([200.4.98.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef5457sm14738b3a.127.2024.08.14.14.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 14:16:47 -0700 (PDT)
From: Diogo Jahchan Koike <djahchankoike@gmail.com>
To: jaegeuk@kernel.org
Cc: chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	syzbot+733300ca0a9baca7e245@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	Diogo Jahchan Koike <djahchankoike@gmail.com>
Subject: [PATCH] f2fs: fix unreleased reader lock on return
Date: Wed, 14 Aug 2024 18:16:40 -0300
Message-Id: <20240814211640.167728-1-djahchankoike@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fix reader lock unreleased in error path.

Fixes: 374a8881ce4c ("f2fs: atomic: fix to forbid dio in atomic_file")
Reported-by: syzbot+733300ca0a9baca7e245@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=733300ca0a9baca7e245
Signed-off-by: Diogo Jahchan Koike <djahchankoike@gmail.com>
---
 fs/f2fs/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 51f6ffd5f4e2..c9eda5dbd11f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2172,6 +2172,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
 	if (ret) {
 		f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
+		f2fs_up_write(&fi->i_gc_rwsem[READ]);
 		goto out;
 	}
 
@@ -2181,6 +2182,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 		pinode = f2fs_iget(inode->i_sb, fi->i_pino);
 		if (IS_ERR(pinode)) {
 			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
+			f2fs_up_write(&fi->i_gc_rwsem[READ]);
 			ret = PTR_ERR(pinode);
 			goto out;
 		}
@@ -2189,6 +2191,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 		iput(pinode);
 		if (ret) {
 			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
+			f2fs_up_write(&fi->i_gc_rwsem[READ]);
 			goto out;
 		}
 
@@ -2202,6 +2205,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 		ret = f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
 		if (ret) {
 			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
+			f2fs_up_write(&fi->i_gc_rwsem[READ]);
 			goto out;
 		}
 	}
-- 
2.39.2



Return-Path: <linux-kernel+bounces-289741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 869F8954B41
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C0A928537B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1C81BBBF0;
	Fri, 16 Aug 2024 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuUOdSE/"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AE1817
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 13:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723815761; cv=none; b=CfyGbSMhrQdYSqVdKVa3KQP4gC7792Ylv1sI072p38V6TdFpegxqVid4hFTyD2Uj0i3TMO9UqWi/ttnf9wtvso6nETaUXGGk/4j/aImJ+951Ue84j/WPNTIa+5p3l5FhxMB2M2eFGgnssJ1CN9b6Ge0XxVZ30Hgs6OldQ5x3EHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723815761; c=relaxed/simple;
	bh=GDRN/U17nLltMwM8K86CB2KETOu93s5A4TrFjyjHQjw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fa3lL0qfpxGoHSrkh2FnUNUsBrfGnb7OhX85W0GrHvJsHa2wTdSjWIMr84qU38iL5jqTpVL/bgIyqlXvEW+FDd6pXD4JQIviJGQwUBT3n+Yo1hv/dZlt3zVCtA6PhhxzrbXb48gA2CXGDCdre1GOJMLoz/Bzghhs9YuXgImxA3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuUOdSE/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-428e3129851so14719415e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 06:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723815758; x=1724420558; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IuyVvuAkRjJSIAKvYtsQnHCMkhH/3BO0FwvyRHQBab0=;
        b=UuUOdSE/oc9msqV/BzHkfcVs/GAWjLLBCXcUrO01sXDSHszz2VPUlZU3G2HoA0Sawb
         cwR9CtnyuArII387n7fq14ngSMs/xdiJe4ekhkfz/qD2no2zDnkftWc1OWBy1D7Md11P
         I6PZnYbyf8HLTpmMcFTtXcrbYWO1UNPVgSupqMhi41sIEAqJarxhb4PLqRRtJyEPAkrK
         0uVsn/vuw4MJo3B6YAIe/iGdY3qqGx4NCLu9C956vCCtTnhI5hgKRw/qQBf651P9qP+n
         ZVEAOPsWffgWOMvutB7UZRl5gYCQ/svkpNYT3XFSJCaixMdi1+VL3TPNjUVkYhZO79sL
         oEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723815758; x=1724420558;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IuyVvuAkRjJSIAKvYtsQnHCMkhH/3BO0FwvyRHQBab0=;
        b=t6DNmw5KM2+qzU6pWuBwEXn7Mb4nGOMHVKEFLTxFnOghT16zJJWtM/4crQB/WaoCXz
         k39WE380gPuVNMtuxTEdk8Cm4uxWfJHiLkKYPes9G6f8+6ey8KbHLGCHqUJD7uNXiYbl
         yYuq7eaQQtQZXy+/a1535d5vrNP75mTZT9oUjQDKqgM3RmCOC1ynSgUK0qcJ7kVlLYyb
         pNnk5U1sqGoLlunI+YmWOxDYtECVLWaPPe0PTwmep//sIxkiB4/c4N0MvuW9wAdHFxZ+
         htvendNnpRfx22QT5gjwBklR5q0nPirsmup7h3EKL6c94T71wonH6+VRZx7Gz5aQW5Pa
         nLfg==
X-Forwarded-Encrypted: i=1; AJvYcCXH+V+AjBwnQnrXUpydy9tx7wpVUVdMAoZY0jVjlK54BzT2MjjXdV+O87dpP2T3rKMl8yf50dTy0tP6/QAXHQj4BxMArTrwPSggcwfP
X-Gm-Message-State: AOJu0Yws4bq6QSa+i8UiF+r4B4jSL5FiHd70a0X9SNFFBn4nP8ykHD/q
	tNBXTT4J3PxDL38L+ak7y63HPGpYN4w7lxAuPJtjfIWd9rYtxdDX7At7qQ==
X-Google-Smtp-Source: AGHT+IH5kC7MTYBBM7V3Itm0SZ+IDwrTPeMZxvzzWO1NKbR+0e0bPv9WVVYmTDRNL4HQoOoR5xE4fA==
X-Received: by 2002:a05:600c:450b:b0:428:640:c1b1 with SMTP id 5b1f17b1804b1-429ed7c0944mr18400495e9.17.1723815757628;
        Fri, 16 Aug 2024 06:42:37 -0700 (PDT)
Received: from hostname ([2a02:c7c:6696:8300:44d8:63fa:6beb:ff38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed6593casm23148145e9.28.2024.08.16.06.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 06:42:37 -0700 (PDT)
Date: Fri, 16 Aug 2024 14:41:56 +0100
From: qasdev <qasdev00@gmail.com>
To: mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com
Cc: ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] ocfs2: Fix shift-out-of-bounds UBSAN bug in
 ocfs2_verify_volume()
Message-ID: <Zr9XJJlZ+RzkLK/M@hostname>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From ad1ca2fd2ecf4eb7ec2c76fcbbf34639f0ad87ca Mon Sep 17 00:00:00 2001
From: Qasim Ijaz <qasdev00@gmail.com>
Date: Fri, 16 Aug 2024 02:30:25 +0100
Subject: [PATCH] ocfs2: Fix shift-out-of-bounds UBSAN bug in
 ocfs2_verify_volume()

This patch addresses a shift-out-of-bounds error in the 
ocfs2_verify_volume() function, identified by UBSAN. The bug was triggered 
by an invalid s_clustersize_bits value (e.g., 1548), which caused the 
expression "1 << le32_to_cpu(di->id2.i_super.s_clustersize_bits)" 
to exceed the limits of a 32-bit integer, 
leading to an out-of-bounds shift.

Reported-by: syzbot <syzbot+f3fff775402751ebb471@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=f3fff775402751ebb471
Tested-by: syzbot <syzbot+f3fff775402751ebb471@syzkaller.appspotmail.com>
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 fs/ocfs2/super.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index afee70125ae3..1e43cdca7f40 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -2357,8 +2357,12 @@ static int ocfs2_verify_volume(struct ocfs2_dinode *di,
 			     (unsigned long long)bh->b_blocknr);
 		} else if (le32_to_cpu(di->id2.i_super.s_clustersize_bits) < 12 ||
 			    le32_to_cpu(di->id2.i_super.s_clustersize_bits) > 20) {
-			mlog(ML_ERROR, "bad cluster size found: %u\n",
-			     1 << le32_to_cpu(di->id2.i_super.s_clustersize_bits));
+			if (le32_to_cpu(di->id2.i_super.s_clustersize_bits) < 32)
+				mlog(ML_ERROR, "bad cluster size found: %u\n",
+				     1 << le32_to_cpu(di->id2.i_super.s_clustersize_bits));
+			else
+				mlog(ML_ERROR, "invalid cluster size bit value: %u\n",
+				     le32_to_cpu(di->id2.i_super.s_clustersize_bits));
 		} else if (!le64_to_cpu(di->id2.i_super.s_root_blkno)) {
 			mlog(ML_ERROR, "bad root_blkno: 0\n");
 		} else if (!le64_to_cpu(di->id2.i_super.s_system_dir_blkno)) {
-- 
2.30.2


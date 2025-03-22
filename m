Return-Path: <linux-kernel+bounces-572297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C84DDA6C8D1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 10:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9953AE706
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 09:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776801EFF83;
	Sat, 22 Mar 2025 09:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ed0mIKmh"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6361BF37
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 09:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742636275; cv=none; b=hr0kA1UBSQ3ocLldBU9+8NWXhZMOqbAElQhI1gBPj886j+OCyjs9ESexWT3RCw+95INsz9/8TVrWavwavPesxsqTYSFZ1Cru9I6ZUWA2sQ09G0gdWk03FllswPghPLksGMrFjj7v+S+K9rMbRlxguRXxYZEmsW/CmC+zv0mwYAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742636275; c=relaxed/simple;
	bh=J7/WQgu2k/4op9hFOXc5t1eVpzyBtXwWHi926Tkrxdo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UzCmok1XrfDj6ETcjMqWLeAhxs+7ihYuV+0DbTSIhFFC0kM8w+izohsZE8HsYv3qYX7lWn9+Q6MdnxyjMJDWAcbN/wJYqhA4ElARLMCZuKApJEm8/E92JoeHIqMfW4W8k7NBCILIkmqU1LjjwuVDWA7qU8N+y9ijMyGL7hwM4qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ed0mIKmh; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ff85fec403so8262363a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 02:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742636274; x=1743241074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MdP4ZXitUOh9kblN+XbKRvo5B0HnicG0HrvxthmlC2c=;
        b=ed0mIKmhRJaep8YPoAlD61HbcZAx/Pn+yhyjlNBoQGtyPSPk/dQiI2tZHuU4pX5mq0
         6bhg8P0kO5CWIJ/BmXLXeY7ccAGzCtbQyFhA/W4hTCiYlOo+frml54F5I9IkRmC2LWTD
         ppufZTxTdFkfC7u5PuFSXrtyE7joZqQUypS+ogqUygwFEzoPJKJle0sZg+TZVkzqCBY8
         cD6onvSwuM9reMQH/DwsbusGFuhzsVxCFavKCmMgvpiMsX+AqzuukBpepVk9KvdvqmIp
         nadbv86M2xK6hI7QfuLSG0FMBLuQonMpMo5ujrzljT+It4GV9ck01awf4cZVicOC/Lgo
         1MSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742636274; x=1743241074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MdP4ZXitUOh9kblN+XbKRvo5B0HnicG0HrvxthmlC2c=;
        b=gpAbIxP+BQg4yYHUe+7fe10S41FzjGO8+NVJ+CDkndB3nxvIVLXWPBcuOfI8Uk5XJu
         z5J/fV9emyLpZkw4wbb2XixOEIsqaGBt9lN8q8stOmBZPRUqOj6fjLJvhhsvJcyMsyKk
         cJ/ucoSxXieFlQfKTLSiSrOjRBBtt6+qRwKzAVADXp/b9iTQcs2mGnyfozxew+vLyQDh
         W05idVZQp7RwRcxq7TmEFgRXVPIjMqXFWFHt8bvLeldT8/v5zpbY8YUN2uPpppx4Q5NW
         0mg5Ns5cJ+lfZXKfK6q1A5il0kZWZ/PtesQ1S3FrxQq6r9YZVt6y+jclFdUpxq2T+LWr
         cSrg==
X-Forwarded-Encrypted: i=1; AJvYcCVqmPAIK0apqs2mKTIdFH51lmsO2NL7qu4inyflIcwqbw4w+b170UA1snHCqTV9aHo4zb9FBB+D8mHSKQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCnAuvDL8hPrWorYiDs6NHX20o/I/vgXCbeWnZEuG1TAgCWgrv
	A7R63hSysQTGWVhS9ANurmdNAqDNqF//6XYgHHJZY8r57nDwSpNw
X-Gm-Gg: ASbGncsbfjYjvet3qmaeWTN+eQow3ypsPG5WDQ3vIQZC8MsRck5X6nTbi8C2GhC56Z8
	o2olzja6K7/yGNTpMlUinSu50wuk/5lL0Bqld0mPIJfbTdO7GZp9YsvIPV7EWSJYBYHNicJsDMd
	sRZtnZliLlY2NBtEZSdqvPERAtooedCaT6GZCI9y9/KpMAb/NItPQjmcanz3BkYeZAaVwrEEnsL
	8xKRwfskQq9p7TKMBWGZVOKv6blM49D904SReM5e1BgeBZuawOiDFhHsElQaycqM6xCuvyt5DeM
	85/QpO73tDEAzIYwtHeSaCFLt5gd31Ypov/WHkMxxW2/PjPb
X-Google-Smtp-Source: AGHT+IEI6chihQoruZ28OxzHXXZbvpvcX+Hc7zhQMWZwLyPhTcaNxaPxyu1y2dKQodskKWeCWaVB7g==
X-Received: by 2002:a17:90b:2551:b0:2ee:9661:eafb with SMTP id 98e67ed59e1d1-3030f38e57dmr10775736a91.12.1742636273706;
        Sat, 22 Mar 2025 02:37:53 -0700 (PDT)
Received: from pop-os.. ([2401:4900:65c5:3a53:51ff:1da3:89ce:3f84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf576884sm7783256a91.1.2025.03.22.02.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 02:37:53 -0700 (PDT)
From: Aditya Dutt <duttaditya18@gmail.com>
To: syzbot+b974bd41515f770c608b@syzkaller.appspotmail.com
Cc: jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	shaggy@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in add_missing_indices
Date: Sat, 22 Mar 2025 15:07:37 +0530
Message-Id: <20250322093737.197101-1-duttaditya18@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6745ebeb.050a0220.21d33d.001a.GAE@google.com>
References: <6745ebeb.050a0220.21d33d.001a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test https://github.com/kleikamp/linux-shaggy.git jfs-next

diff --git i/fs/jfs/jfs_dtree.c w/fs/jfs/jfs_dtree.c
index 93db6eec4465..de33026d18d2 100644
--- i/fs/jfs/jfs_dtree.c
+++ w/fs/jfs/jfs_dtree.c
@@ -2613,7 +2613,7 @@ void dtInitRoot(tid_t tid, struct inode *ip, u32 idotdot)
  *	     fsck.jfs should really fix this, but it currently does not.
  *	     Called from jfs_readdir when bad index is detected.
  */
-static void add_missing_indices(struct inode *inode, s64 bn)
+static int add_missing_indices(struct inode *inode, s64 bn)
 {
 	struct ldtentry *d;
 	struct dt_lock *dtlck;
@@ -2622,7 +2622,7 @@ static void add_missing_indices(struct inode *inode, s64 bn)
 	struct lv *lv;
 	struct metapage *mp;
 	dtpage_t *p;
-	int rc;
+	int rc = 0;
 	s8 *stbl;
 	tid_t tid;
 	struct tlock *tlck;
@@ -2647,6 +2647,16 @@ static void add_missing_indices(struct inode *inode, s64 bn)
 
 	stbl = DT_GETSTBL(p);
 	for (i = 0; i < p->header.nextindex; i++) {
+		if (stbl[i] < 0) {
+			jfs_err("jfs: add_missing_indices: Invalid stbl[%d] = %d for inode %ld, block = %lld",
+				i, stbl[i], (long)inode->i_ino, (long long)bn);
+			rc = -EIO;
+
+			DT_PUTPAGE(mp);
+			txAbort(tid, 0);
+			goto end;
+		}
+
 		d = (struct ldtentry *) &p->slot[stbl[i]];
 		index = le32_to_cpu(d->index);
 		if ((index < 2) || (index >= JFS_IP(inode)->next_index)) {
@@ -2664,6 +2674,7 @@ static void add_missing_indices(struct inode *inode, s64 bn)
 	(void) txCommit(tid, 1, &inode, 0);
 end:
 	txEnd(tid);
+	return rc;
 }
 
 /*
@@ -3017,7 +3028,10 @@ int jfs_readdir(struct file *file, struct dir_context *ctx)
 		}
 
 		if (fix_page) {
-			add_missing_indices(ip, bn);
+			if ((rc = add_missing_indices(ip, bn))) {
+				jfs_err("jfs_readdir: add_missing_indices returned %d", rc);
+				goto out;
+			}
 			page_fixed = 1;
 		}


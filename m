Return-Path: <linux-kernel+bounces-572424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8CFA6CA36
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 14:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FD331B631C2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 13:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226F321D001;
	Sat, 22 Mar 2025 13:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdPDmbru"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385851E9907
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 13:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742648590; cv=none; b=g4jpPPbuQWKZ66UNwrF/DYFqNiQPEQRZRFhHAEW19sSL0x8UkQ3qOwS7F41q6nN/Nk4FTE4BQWoNqU6ISKdMTjv7NQGDqxfVsFjZoVLa6aCyGVPJRF5Akg/zg3xez33LlTIsKqweaYRygjWrHB5BTbjS4SLTezeEfX0Po2WlC10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742648590; c=relaxed/simple;
	bh=C+U9HJiWxQVzz9b+uuE1UHAjPSwIwpe7abDowDXSGdg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j57J/gIAUBZHNspwZf8rJT4ci6Twio2YErhWFyH9+esyz2DP2DwBQeTcNFAtgBGMjfetHJq/mlbxJVEe8Yl6K3XxilUufWob0uSag8GYhGEsTMdoBtVedw4KA0UuRtyfkDyrvb/MAV501J7gGbLfUnEMJOh6L3cX93azP9nyed8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdPDmbru; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3011737dda0so3706774a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 06:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742648588; x=1743253388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jp3f+m8hDUdzwFKD8WssiJEprIkmH8XOlrFoJxIL6lY=;
        b=EdPDmbru8pxlJNGMdEJzBN5eZ9aCsEuSK0Nw8ouHk3qndINLZgeNOZXQ8VFG2IlUWv
         ia1O3TNGn+a6edqFq7SKnWDpfYfMXdEU6GuIzXfWaL4B2L6lIUEpzNDZ6fbPM8K/CxbA
         x8TDaQAI/PmEdSqz6z6JYHzlKO4pM/BWeJ5OpV+/IRJ/8tyv/cyO2wt8GTgOAGS/w+XG
         SeZe1t0RWwop7LxoBXbfg4vPv4ghpNeaniDzIQI5MVzxyI+c1IppefgCrGFdUfNNZA//
         MnE/w4gtHZdPh9Ath1FEgTRmHWIcR1W8uIhFMyZKDUP7dSutxIxzGAiICMiSSIi6GC6A
         YTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742648588; x=1743253388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jp3f+m8hDUdzwFKD8WssiJEprIkmH8XOlrFoJxIL6lY=;
        b=l5nqE9EAu5e62NHc66QMT7lTLdKtOVWw+g/tSfP70LpFXbakk4ojuEsfgs/cJ1lFK7
         ++KR3o8PdfMlzRkB8utRCh+uF3IMWZIGxi6vDv59IksjpYhweensljddjPnOQ04yAULD
         j2+h0cOYlknli/OOABYA1w8ouVw6RiRZvMc3Urq4G9MRaCXDsN2y00cxqF5n6fUZeKoG
         w4hkJnN75wON13zTaWHn4A/8m2eIg6Al7M0HITcbUH+K5schnBCYUKERlQZ9tCPebogO
         A1RObSwDYJ/sFL7FYxjEVWB8iIJ7DFlBysb04u8cOZV4VGMeRg1yx7J8jSFino3+bzlH
         BRQw==
X-Forwarded-Encrypted: i=1; AJvYcCVqSrK5uK30/eNNiCfYXnJHeQw7T0xpZSBn3Y2cLCOg74Zlw4sei37H279CqdPTUJiHHNlx2VoR3MKY0xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGa+GX1EpWO7QKxrfDI1CDMpyNqhKsmynU1UjKnHZdsoXCp0T2
	Hfm0IUvg6TKFr6BEY7UWz8tbU1ZyxJGKBUSMZBqgEP7fNFmU0DcX
X-Gm-Gg: ASbGncsvKIbSBtir5zGwBmCrFi/X24UsWOzdCSE5DpUIgjognBHNUto1KSQ7b4V7yhZ
	MfWquqXqJGj9TRQHU9dcsrf+aUXPk0r/wTxZHGDr9tPWyg+9jx+ppWe1ClJnWlWA3U1p3nnVjMD
	0LjRRc2jCCA2RD/nZJAwJC/Sf36eM3ci+9fa4e0HoGGIZBtebdEwe2RIDNb+d3/qs84xTF+d3/T
	xVFTjlZR8q9fQ6CAOsApVMGkW5Fl7+uME3BNGlt55xmQqWpTcUdAQatAeGGldYz2EpLw8aUPy0n
	lunUUcDfXGyB/H/ro/rxjUnBZ80ngVq99LVMJ7hwSec3O2c=
X-Google-Smtp-Source: AGHT+IHs/wSMhvLrY1D4gAEYACP9WT0SUj0yyR8NCytlkMYsN4hnlgObgoaTOHCTE4yHuX6v3BXyYw==
X-Received: by 2002:a17:90b:2dd2:b0:2f6:d266:f45e with SMTP id 98e67ed59e1d1-3030fe8d517mr12298088a91.2.1742648588196;
        Sat, 22 Mar 2025 06:03:08 -0700 (PDT)
Received: from pop-os.. ([2409:40f2:103b:bee1:9075:e78a:e271:6953])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3030f60b919sm4028792a91.27.2025.03.22.06.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 06:03:07 -0700 (PDT)
From: Aditya Dutt <duttaditya18@gmail.com>
To: syzbot+b974bd41515f770c608b@syzkaller.appspotmail.com
Cc: jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	shaggy@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in add_missing_indices
Date: Sat, 22 Mar 2025 18:32:57 +0530
Message-Id: <20250322130257.227256-1-duttaditya18@gmail.com>
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

#syz test

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


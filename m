Return-Path: <linux-kernel+bounces-575226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DADCA6F60B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A8413ABC90
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCBC2561B8;
	Tue, 25 Mar 2025 11:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSezaTl9"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABDB1E8346
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903091; cv=none; b=S6n9aK5RyLW+MvnHH0sJacMwndTsPp7f8yI/KJOGGgiSFN7JxLr1Mh6NSrLK5CWMKTwQ67YskHbCaxGyndi30EZ5Bhf7acxBYq8Lw9MOXc+q5jjjaXI18xZqHQmTCasgQuqIRPeWJh96yks8MuVM+cYCEVqMz9yLnXF76ICGvPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903091; c=relaxed/simple;
	bh=5/nslLODj2vZJkViJjsPxLNg0iwKhOfjrM1t4Q4wrac=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jenCxJiglCKAmvhg6V9JX/5koMi1FfM2yHq1WUeWRwX6zDKjMdOlVSF/jfeam4oyoz6OspFUfvEZRivp8O9J7tO4mkZwZSe1Xglb8t0WbJVDZWbYDOKebngKhEBq3H/K3IN/VUrZpWcneSog0tjTSgWtOAhgz4kFiLk98TcltP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSezaTl9; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-224019ad9edso33711175ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 04:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742903089; x=1743507889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZN9EoU3NOIXLHMOmv53dJjYHmNGZXjtjYsDTIPQ6mb8=;
        b=SSezaTl9vunZ9utFkpOZ42d5aMeXjWxsRpWo7UdAixwRtLaKAGkQEGh0igQWxtIK6a
         ec31P3ndrz8Dq+6wl9cCyvc0JWBgCieiI4TIxVxDwazbA3IUowDPqEW+EPm6YpMKjhx1
         504wKrKsbD0KtYaHIH7hOYnX80Ot0DmrXu2ce0uR7XoPz6PiZ+MSH/tC4dDjil/vHrOY
         6IkL7HK5C1oKegLOiavMropGEEDSAm9rxVgBhRyBT3bIO/G1f/oYdENXu/9SqfnkwPW2
         Np+xhaObwxPWZ8zQY+ptPomaPQKmvgGi/ZqtR2A2Icq9QjBkDTOk4AqBTXQJyNUdOnkP
         QG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742903089; x=1743507889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZN9EoU3NOIXLHMOmv53dJjYHmNGZXjtjYsDTIPQ6mb8=;
        b=pvxZIG7sFemJIEr+46cWxXwKvAKc/zC30w0t0QYIctlVkiiszozybbn5/45QLfw+wm
         OH3R2wgCaZnaCNjXJvCx9Qx5XWQNnTyIQq1cmHvfD7qNrzik4OHkAVNRdyyCAKQ6SV65
         Sl8Iq/K3U7b7f7W4xyBOQAJ5ZbsuLuc/COumnQoVyU9iv4DYaQPI3skz6HXDYm87/IJX
         6uxoqnw4Kts0m7goQ3ag2n1j6tJ6FkN3MPS2hmt9n0xPMxUc6I4DcxUIT0UdJRa+x4Gg
         N4FFAv/82Yvq85TM9KNQ0Qct2F3TGaqyGo9MhhGkCu4fOGfntCdsexRH6sBmF6B8RT4o
         3Ttw==
X-Forwarded-Encrypted: i=1; AJvYcCViQ0mcvSvuWGLO0YBRgldOzTDpaQyLEBHLZoBaII7tIWvrl7Fy+UZcqEPC3zZEClNUdv0nuQTBL99Za/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVScY2wKcwV5QMmCYZV8nF8DHA8HkXInZIfZYFrB4pAjYW+djg
	hXddBYQw3iahzV8b05TdluYaWrq0oqCQEP6AMAw/WG0AR1mD3Nlm
X-Gm-Gg: ASbGncvPqa/U3onV1KQkMDNnoTtpPGkcPTp73HIbcOmpKeRhP32U2GieWnCtCMNdtL/
	ZVwMorB0vsEloh0w5NVPUXeJuGwV/e3YRxxgLtEiZ0YzppyZOSMgV9mliumtONMvDfIFz8rDsu1
	eLeoRsp8ECMIXdGuiKgYW+GeLUKlx4zV1qfHQCyR7pf/85ppZQoDHC9Co0uCIgAyVcHpHDAUO89
	SOJLPo8q484JPDOWLjDOL8Yqyb/1vuiWLJzHyVBzbwWZRF+Epak0Arq84C6OzjBukILdSS9hi/p
	wNWLngJi74oiAYyVlz+Mg2ww7pvAYSr7w7k1CJ1nx+Dj
X-Google-Smtp-Source: AGHT+IEd5TqM3Ur2SeElmap55MkC4ZerI/76IhMaZUOxyVFkeLtvIZ9DW1PcVzamcoXnxNeG2XeM8Q==
X-Received: by 2002:a05:6a21:999a:b0:1f5:67c2:e3eb with SMTP id adf61e73a8af0-1fe43439eb8mr27780478637.41.1742903089202;
        Tue, 25 Mar 2025 04:44:49 -0700 (PDT)
Received: from pop-os.. ([49.207.209.237])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fd54fasm9824703b3a.49.2025.03.25.04.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 04:44:48 -0700 (PDT)
From: Aditya Dutt <duttaditya18@gmail.com>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: Aditya Dutt <duttaditya18@gmail.com>,
	Ghanshyam Agrawal <ghanshyam1898@gmail.com>,
	Roman Smirnov <r.smirnov@omp.ru>,
	Edward Adam Davis <eadavis@qq.com>,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	syzbot+b974bd41515f770c608b@syzkaller.appspotmail.com
Subject: [PATCH] jfs: fix array-index-out-of-bounds read in add_missing_indices
Date: Tue, 25 Mar 2025 17:13:39 +0530
Message-Id: <20250325114339.412100-1-duttaditya18@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

stbl is s8 but it must contain offsets into slot which can go from 0 to
127.

Added a bound check for that error and return -EIO if the check fails.
Also make jfs_readdir return with error if add_missing_indices returns
with an error.

Reported-by: syzbot+b974bd41515f770c608b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com./bug?extid=b974bd41515f770c608b
Signed-off-by: Aditya Dutt <duttaditya18@gmail.com>
---
 fs/jfs/jfs_dtree.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index 93db6eec4465..de33026d18d2 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
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
 

base-commit: a8dfb2168906944ea61acfc87846b816eeab882d
-- 
2.34.1



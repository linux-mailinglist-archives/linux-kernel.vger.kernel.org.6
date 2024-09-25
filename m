Return-Path: <linux-kernel+bounces-337883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0B99850A4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 03:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAEA52848AA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 01:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77641145B0B;
	Wed, 25 Sep 2024 01:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="lYmGcrfy"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3E542AB5
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 01:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727228062; cv=none; b=T1tRPSi0QLpJIzUZyzQA0VOnQA1stzsYKk5lH7aAmV95/mChwqFKH/8+vfL/33xz+fPTKochVwqJ6bfywnoqp+5Rimm8CkND8rjXJ4l/qstzjeYry31iDP+QTs05tYdQ8xc5xVLNXJL2HjJDmaY5hkRx19T/bkpcxyEDdOvM1Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727228062; c=relaxed/simple;
	bh=u0hbjJNpzOW6ItAe/lgfk03Pzl5beZR51/r8QN8usbk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=pgcRmq1NSBn6GKNxQPH+Kwd18MWsMnKTJS9AZuOs+MG37mScTenIehqL32hg3CRMfhKG4TE5HC9SOeEJhRksLjdA53/2G0LZxjEKm7gkWTu5nSzIvKe3JPSeKzFixrllyVCirtmoWlOB03to2LN834jZNP5AnIo3iPjB39Za0vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=lYmGcrfy; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1727228055; bh=YIL4iXIHrJrYf3W/ArVUoDuQ3Ht/E83pGURjcCp5p48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lYmGcrfy0ayGK0NCDzAuKuX82Kdy5ZYOfUkmS4xg8LeP1yS7fJV0iHxSjflRIoi0m
	 ZQZUYM3MrTLLW4t8XJPcWT+76O2GyAgM4ETuJEY2NqmgMSjBIedJpPTezkPr0/qTj1
	 HNQaeSHcDev41VmCSXFmtoagP/O66D6JnGTbOcQE=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 681AC2A7; Wed, 25 Sep 2024 09:26:01 +0800
X-QQ-mid: xmsmtpt1727227561tlvmbvhvy
Message-ID: <tencent_08982ECAAEE20C9E67D106F812CF067E8906@qq.com>
X-QQ-XMAILINFO: OaubouGXmhNzcKFJKN2/tnxmFnE+UHI3fWqB9mWSWR2lYK5NYj93oJQjl9vf29
	 QYLga3V0hcKZ9UImZSw9Rq53paaqU/R8PAgJv2p62PQFMiUwyDZdNXMcb8nnzjH5fO+32RCa9HNk
	 ESvZpN0xpBzRxkKqEH6QFVXcuGR079hceHHpiWtrj/roJzY+qpnZemOaalaLELmV6iU2WKqVt1nU
	 UXDcS5y4gJB/Pw0Fz+LrxixFZ5Nrq8N/WRxLAUwdGytKHfSDpGa8+lvmKJXVqNV3UcTRatah7YH/
	 SkzHgNlAE3z78GOWOlm3qWo4btvo1f7xjJd8U3v/LVCmz6k8qaPfvnfqcHIElvQFSnD4AArnrWfK
	 2oyEVWa/6fZW0aK0qJJE+GJgvjzWfLDIAfO4Fg6nAZg48TGGr9EWD60wb6O2lcG4zfuUZB8qk6/A
	 E8wHnd96R8phK7IjvJRTiSQMEQN6vTO9AC18GMzyFiEH60LoZE4NVWkdyl3q/nLhaUqCVPmguDUq
	 kHEAagtX8bCA0Xq2X5p/hBRPaUed8TZ7oEpmVWa2Xlz8SiKc8KbdSokDbYqg8UcMisIZDPCwu6LV
	 xIA+IVodTzpYrD7O659N28OIgFjYTltvk9CLsdpXms02TnETAiPMKDobtN/+3Zue5SMsh2ZIXxtd
	 PvSZjCm03ajQOuj06oCMgGDkSjY02t1fk2osRN1iG6F+Wnl9s3VjzmErAJg76QiFmDF953ygAd47
	 +OK817Ay5Dum8MIl5hkKcbboRg4+tX8LIZE6iYU7BpUTv1EX6meb80CFgyCwJ0NMDu0vVIs1tLOZ
	 x1FBOZBK8SlKs2U01DNPbQJ8HmmFst62OnNBfRAhodnXsWad+rhMfaZlzI66CC+64L0gb1lbhe0f
	 1ga4K4ElOCwbl7qkifsovnUg9FTxIpYqlkQVTngI2GAjAWVl/j8vgooypOn3nN72DL8tfwlV8D
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+c0360e8367d6d8d04a66@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] kernel BUG in vfs_get_tree
Date: Wed, 25 Sep 2024 09:26:02 +0800
X-OQ-MSGID: <20240925012601.840261-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <66f33aad.050a0220.457fc.0030.GAE@google.com>
References: <66f33aad.050a0220.457fc.0030.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

db

#syz test

diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 4a1bb07a2574..49d711e9837e 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -2148,6 +2148,7 @@ static int bch2_fs_get_tree(struct fs_context *fc)
 out:
 	fc->root = dget(sb->s_root);
 err:
+	pr_info("ret: %d, sb: %p, fc: %p, fcroot: %p, %s\n", ret, sb, fc, fc->root, __func__);
 	darray_exit(&devs_to_fs);
 	bch2_darray_str_exit(&devs);
 	if (ret)
diff --git a/fs/bcachefs/recovery.c b/fs/bcachefs/recovery.c
index be1e7ca4362f..12835c0290f8 100644
--- a/fs/bcachefs/recovery.c
+++ b/fs/bcachefs/recovery.c
@@ -849,6 +849,7 @@ int bch2_fs_recovery(struct bch_fs *c)
 		atomic64_add(1 << 16, &c->key_version);
 
 	ret = read_btree_roots(c);
+	pr_info("ret: %d, %s\n", ret, __func__);
 	if (ret)
 		goto err;
 
diff --git a/fs/bcachefs/super.c b/fs/bcachefs/super.c
index 873e4be7e1dc..9fb45c7e7063 100644
--- a/fs/bcachefs/super.c
+++ b/fs/bcachefs/super.c
@@ -1011,6 +1011,7 @@ int bch2_fs_start(struct bch_fs *c)
 	mutex_lock(&c->sb_lock);
 
 	ret = bch2_sb_members_v2_init(c);
+	pr_info("ret: %d, %s\n", ret, __func__);
 	if (ret) {
 		mutex_unlock(&c->sb_lock);
 		goto err;
@@ -1036,6 +1037,7 @@ int bch2_fs_start(struct bch_fs *c)
 	ret = BCH_SB_INITIALIZED(c->disk_sb.sb)
 		? bch2_fs_recovery(c)
 		: bch2_fs_initialize(c);
+	pr_info("2ret: %d, %s\n", ret, __func__);
 	if (ret)
 		goto err;
 



Return-Path: <linux-kernel+bounces-373083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58ECD9A5205
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 04:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EED55283E05
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 02:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BBB3D6D;
	Sun, 20 Oct 2024 02:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="eoesKANB"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39272119
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 02:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729393102; cv=none; b=aOfp0OIOCcz/cKQF/UqNIg0OjhPv31xxtAocBxYW4T/tiSabgzA+2vxaeooC4xV9r/Fm/uRi5kaNsC3rePEyJ2qSPpFWGa17NiaT/HKpKCUcE2QoghTMZsMB7unr1chkznPdRc6nr2E0DQMPsKGwHMa4E1WQ9UFpk0FV5pSEFzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729393102; c=relaxed/simple;
	bh=SBPGmGwiCkEl/txV6fIuDN8U8qj25xJTs9gh/76pX7w=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=DkFFcatf7cVUawHG3owfGL3faiT97Mdh01Z1mHKADMqptyfvz62B2kq+n2Vur8zqDFBTfIYtWxnoDOJFXIdk8QooWTeMUyglK39QNtp2j5LAMgw07KZxxID9OF7iN2TKqRUK1JMJREXx2chmyWDmD/QJyBNOazRDuMA+/GZRij4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=eoesKANB; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1729392786; bh=lQrh/YCq+3AoRVc4CCz9YEwxYEPob7aHL41dcY2uQE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eoesKANB7YCs4HQIedSO0X0JQH3ZK6G8r40Z1Tbv2HBFl98wwzGOZeGGzXeWtt54E
	 bsQ2ZB9YXT40hMU/dHHxmWmRxiqJU1eCBcALgw8pVwX5iWFEArn67rub+isMT+/kxY
	 rqSzLNQ/zENV5+OQPhCR3gveJHk/XjDP0DUdE7A0=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id D4492EC5; Sun, 20 Oct 2024 10:53:04 +0800
X-QQ-mid: xmsmtpt1729392784ted94vpqi
Message-ID: <tencent_1756D762F77466DD937EA36E2960A3AD4405@qq.com>
X-QQ-XMAILINFO: M0PjjqbLT90wa3B8JXO/EbfvJIGsb0c03UQAmMYigz6QdJ9el+6syy4LTNNf+i
	 iKjrqYaXMJ5WZO2umCSiJaAOuXjRGibUGeNBx/4ObD73rSJpukimRzdIm1fUA99IX8ENDzWg0Zrc
	 JzLhcRbh0dlq7OPvA+8PvCp3eL3t7mGJoz6fMbS6mwMw6ixenfIATFXfIKsD6RF4Zc9XmsQjnuGL
	 5gh96q7KZXXDyLRjZ/1ETe4sPQ/kpiRFtNInS3iN/qN6AjoU4sEAW9Jyxg3M6+CTcKZuzfvrgjYs
	 Jwn73a/DW4h/yt51cZF8JtEEYN0blJZcjGx9sYSwdDlbEDW2jZg6T5Q5PQ9QOAbpj9YnRqNKeSw0
	 OihEN/P45wx2YYAqNGXb3qzy4Xbif01RyH4hLsW7afXa6zm8VLIjtBM+6iISsC94ElhfuWqCXkLc
	 CpVNy0C01m6lGURsIOqJatc2RrKgHpWa0NNuqEyl6mC/349F9hJD9/33lsT/jaAosxde6eRr/UMt
	 BYoYwdAPNV+ToHHx2W90iooZdaO+i6pi8bGexmzhwiqoIMgQQBjI6GFgVvf7tTTtHtx88wMDCrO5
	 PfhoHHgiKCQ7YRhlxhBZzS2LMmQPC2pkUzf3SRI4cBmZEOM/zZzscLiKdyJLeXfYq0y7m0B+Yy1o
	 CcnkZw6dQnoJH0H2DftKFGD/Xlf7AGTaX2vqZ1/dyNX6ujiXSdZHw5rXrwFYO2bsK28GTYhPpJjF
	 4LS6xPscbWlgeZIDBtSekmwwQy5DYO6tJrykJ4nI7CK18wpNUiP30wspHGX0X3cjgI+0JajYTxph
	 49aBzlaK+9sG2ZNncPMYmNmQuN9+oN8NCdWLbncQzT0HRNfQuC3Sygi88a4fowIgepVK7h/nx3tD
	 WyQ6WVKcomkjQqGSkHMFOf4W9a8TbkxYlPvOqmMV9HD8KiReviGItRJkyusSkhYg==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+4125a3c514e3436a02e6@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] KASAN: null-ptr-deref Write in xfs_filestream_select_ag (2)
Date: Sun, 20 Oct 2024 10:53:05 +0800
X-OQ-MSGID: <20241020025304.2289918-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <6712b052.050a0220.10f4f4.001a.GAE@google.com>
References: <6712b052.050a0220.10f4f4.001a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

catch can't pick any perpag

#syz test

diff --git a/fs/xfs/xfs_filestream.c b/fs/xfs/xfs_filestream.c
index e3aaa0555597..8c8f341cf627 100644
--- a/fs/xfs/xfs_filestream.c
+++ b/fs/xfs/xfs_filestream.c
@@ -165,6 +165,7 @@ xfs_filestream_pick_ag(
 
 	trace_xfs_filestream_pick(pag, pino, free);
 	args->pag = pag;
+	printk("pag: %p, %s\n", args->pag, __func__);
 	return 0;
 
 }
@@ -298,8 +299,8 @@ xfs_filestream_create_association(
 
 	*longest = ap->length;
 	error = xfs_filestream_pick_ag(args, pino, agno, flags, longest);
-	if (error)
-		return error;
+	if (error || !args->pag)
+		return error ?: 0;
 
 	/*
 	 * We are going to use this perag now, so create an assoication for it.



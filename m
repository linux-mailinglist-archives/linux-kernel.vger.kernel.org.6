Return-Path: <linux-kernel+bounces-401538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E45C99C1BE3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89D9BB2394C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7EC1E2849;
	Fri,  8 Nov 2024 11:10:58 +0000 (UTC)
Received: from mail114-240.sinamail.sina.com.cn (mail114-240.sinamail.sina.com.cn [218.30.114.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB22322E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 11:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731064258; cv=none; b=lvM6QWLP9DzW92q+uTVoe4emnJpW1Mjwq7CoMLfHn1/Zi8GKtq20grGpUMey9stk+7WcAzB6WHZ8u3EHZerkyV2oxY9lna7aAww8Xakn53BNDuJqGoJrqUk5WDwPeDNyGqmKZAGnchnoIIziSu2zahyqFaZXE6JPXV+PgZ5hVMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731064258; c=relaxed/simple;
	bh=hBC+CHjmgqduSWliLvAUk7GGZISScjArUOiRxRwZR+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FzTgpbJ/QS/3UnU1IGWPXDJyiBjh6uvJ+LmFAtbJZD6D+dVDbTPf+XAhWyEbRg5gPQ7OH4DaolZywaw2TqxaDfuXNZ/lHHEJx9wrt1xA5F0KA6m6Adkoobot30+I5LvvCgAUEre+z00kRjugIS+M5RYg2P7NAF7HmQi3LnNKenM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.68.160])
	by sina.com (10.185.250.23) with ESMTP
	id 672DF1AD0000464C; Fri, 8 Nov 2024 19:10:41 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6897678913454
X-SMAIL-UIID: 544897F7081D46F5AD5339F876BC4F59-20241108-191041-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+4c493dcd5a68168a94b2@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_seq_start
Date: Fri,  8 Nov 2024 19:10:29 +0800
Message-Id: <20241108111029.3505-1-hdanton@sina.com>
In-Reply-To: <00000000000091228c0617eaae32@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 07 May 2024 22:36:18 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    dccb07f2914c Merge tag 'for-6.9-rc7-tag' of git://git.kern..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1367a504980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  dccb07f2914c

--- x/fs/namei.c
+++ y/fs/namei.c
@@ -3494,6 +3494,7 @@ static struct dentry *lookup_open(struct
 			goto out_dput;
 		}
 
+		BUG_ON(!got_write);
 		error = dir_inode->i_op->create(idmap, dir_inode, dentry,
 						mode, open_flag & O_EXCL);
 		if (error)
--


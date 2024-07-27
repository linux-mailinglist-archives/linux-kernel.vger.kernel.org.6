Return-Path: <linux-kernel+bounces-263939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C06D393DCE6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 03:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 178C32858F8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 01:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF531C2D;
	Sat, 27 Jul 2024 01:19:01 +0000 (UTC)
Received: from mail115-63.sinamail.sina.com.cn (mail115-63.sinamail.sina.com.cn [218.30.115.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F467394
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 01:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722043140; cv=none; b=NvEps6kWS94ZXSRrRI7vgZ6eWL4Bdlea8lb5sAcnHAJhGbXCCy3CIIHOeJZHpr0By03LP0OPdi80/f/39AOjX/aTOWXilCNUHJ6xP8ZrS3xSxg+ctUV5+XCgFOcox6A6ZqOGr+4GiWVLfjeyS19+LLAOizAO4hffppxx1SdXrwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722043140; c=relaxed/simple;
	bh=Mhl7kVYCHEmuu+Dx/WZAYVxhqwRaOlFbQd01G1ICqCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XQOy4X3VqUztNxhpeeyQ7IYuMehgbs0sB+wnbylaZQOHop8nmiFpPL0+HgHMuq4ngc1/pPMvwBVSpZEW5qjxDTJLpEJfrbH7H7n/fSBkgyjS0VaZm1wN7kcqu0cBZRqVdszzNoLxMMxRm9WKlXPgtZd4HHLRZAQZg3/wL8/ETGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.10.191])
	by sina.com (10.185.250.22) with ESMTP
	id 66A44A6700001542; Sat, 27 Jul 2024 09:16:25 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7095927602691
X-SMAIL-UIID: 5DA5E0B2415249C9AD27502AA3EBA712-20240727-091625-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+20d7e439f76bbbd863a7@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [f2fs?] WARNING in rcu_sync_dtor
Date: Sat, 27 Jul 2024 09:16:16 +0800
Message-Id: <20240727011616.2144-1-hdanton@sina.com>
In-Reply-To: <000000000000b90a8e061e21d12f@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 26 Jul 2024 00:54:21 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    1722389b0d86 Merge tag 'net-6.11-rc1' of git://git.kernel...
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=115edac9980000

#syz test upstream  1722389b0d86

--- x/fs/f2fs/super.c
+++ y/fs/f2fs/super.c
@@ -4169,16 +4169,7 @@ void f2fs_handle_critical_error(struct f
 	 */
 	if (continue_fs || f2fs_readonly(sb) || shutdown) {
 		f2fs_warn(sbi, "Stopped filesystem due to reason: %d", reason);
-		return;
 	}
-
-	f2fs_warn(sbi, "Remounting filesystem read-only");
-	/*
-	 * Make sure updated value of ->s_mount_flags will be visible before
-	 * ->s_flags update
-	 */
-	smp_wmb();
-	sb->s_flags |= SB_RDONLY;
 }
 
 static void f2fs_record_error_work(struct work_struct *work)
--


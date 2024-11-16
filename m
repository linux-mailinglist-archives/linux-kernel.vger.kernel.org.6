Return-Path: <linux-kernel+bounces-411925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 567429D0164
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 00:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7241F22954
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 23:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002DE195FCE;
	Sat, 16 Nov 2024 23:10:14 +0000 (UTC)
Received: from mail115-24.sinamail.sina.com.cn (mail115-24.sinamail.sina.com.cn [218.30.115.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACEE194A59
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 23:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731798613; cv=none; b=PmXNBNlitwXW5WTw0Tqk5lVoPc/0khPhxlkJScfLZ8hx0lz2l+bFASU9WsvLVkAivA+BjlEwbTk0KCBkcylLTmbyBd0WUibBUBBdD9+QKVjafH7WJuhe4JETidwDC5BvnbQOPtgXQmyWMTvgZC1wzIuCVO2AxZntuRi+C/TDCC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731798613; c=relaxed/simple;
	bh=KiVMa+y4CK/8GDNZ5XW162nOAOv2Nu03MehMR2+AeN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OQMOvy+qqOwbDw1m2TmiTDWY26F+pq4C21tfFYdQvetcZYPgzjQkg/ONFjpmjEx5JiWVX6E/D5WxRXWSamVZGZBUGlrNycOU9HUbRHSAwwhh/wZb5ywKiQT9+iPRUupudYFdYdUooTN8VFib6vLwI++8ko6bk0AzTzaH1oBxm60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.70.242])
	by sina.com (10.185.250.22) with ESMTP
	id 6739261E00006640; Sat, 17 Nov 2024 07:09:23 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7423917602666
X-SMAIL-UIID: 22A2E5ABF2C14004986820D5F80F3989-20241117-070923-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+823cd0d24881f21ab9f1@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] WARNING in rcu_sync_dtor (2)
Date: Sun, 17 Nov 2024 07:09:13 +0800
Message-Id: <20241116230913.1124-1-hdanton@sina.com>
In-Reply-To: <673866ee.050a0220.85a0.0013.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 16 Nov 2024 01:33:34 -0800
> syzbot found the following issue on:
> 
> HEAD commit:    2d5404caa8c7 Linux 6.12-rc7
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12188ce8580000

#syz test

--- x/fs/exfat/super.c
+++ y/fs/exfat/super.c
@@ -46,9 +46,6 @@ static int exfat_sync_fs(struct super_bl
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	int err = 0;
 
-	if (unlikely(exfat_forced_shutdown(sb)))
-		return 0;
-
 	if (!wait)
 		return 0;
 
--


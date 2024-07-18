Return-Path: <linux-kernel+bounces-256298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57853934C34
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE519282737
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097DE12F5B1;
	Thu, 18 Jul 2024 11:06:06 +0000 (UTC)
Received: from smtp134-25.sina.com.cn (smtp134-25.sina.com.cn [180.149.134.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41B4639
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 11:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721300765; cv=none; b=qkYneYJN5vV4NxUSOvTH9nlbmAQaweNjhQKRYhtteA2cFAxSwzQTJDk6pp+td5/pFsPqBeTF1CwgddMeiqNH8CPD3LSLy+li3KSAFyRbV7JzxoaRuoasZwnKJ08z6gciZNiiPB3P4d1SaNkuYk1rdMmCfo/eGZDgQjnCxBgvdng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721300765; c=relaxed/simple;
	bh=QrybV2O3fQFIey0y7HCfFqZJPy7TwYRexU+AamIdwAs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O7XGdzTgTqgR9B90Nlqpd73fncC+91zoEUvhg7dv8ZNhgUQi7wvwxHL1G1QrPil1+xgPM4vsKQ4BZQJ6vit+J9emUZRwFN+w17T13PIaX58Zaz6qC6c9oDKgYTPHAMJEdDVMLBdGu4hQCb85ABFe0VaVgFOtCVERDilTyAf8L+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.11.47])
	by sina.com (10.185.250.21) with ESMTP
	id 6698F67F00002E0B; Thu, 18 Jul 2024 19:03:29 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6939403408355
X-SMAIL-UIID: 7AD681F498144E4E863AF17084311F2A-20240718-190329-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+dd73570cf9918519e789@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] WARNING: lock held when returning to user space in ns_ioctl
Date: Thu, 18 Jul 2024 19:03:17 +0800
Message-Id: <20240718110318.1438-1-hdanton@sina.com>
In-Reply-To: <00000000000077c88b061d7b893e@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 17 Jul 2024 18:31:24 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    51835949dda3 Merge tag 'net-next-6.11' of git://git.kernel..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15ef5b4e980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  51835949dda3

--- x/fs/nsfs.c
+++ y/fs/nsfs.c
@@ -188,8 +188,10 @@ static long ns_ioctl(struct file *filp,
 			tsk = find_task_by_vpid(arg);
 		else
 			tsk = find_task_by_pid_ns(arg, pid_ns);
-		if (!tsk)
+		if (!tsk) {
+			rcu_read_unlock();
 			break;
+		}
 
 		switch (ioctl) {
 		case NS_GET_PID_FROM_PIDNS:
--


Return-Path: <linux-kernel+bounces-392133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7BB9B9018
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 12:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBA3B1C23526
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DBA1990CE;
	Fri,  1 Nov 2024 11:16:44 +0000 (UTC)
Received: from mail115-118.sinamail.sina.com.cn (mail115-118.sinamail.sina.com.cn [218.30.115.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EC8322B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 11:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730459803; cv=none; b=A0tl9Kn+zZ99cRVb7Bs1N77C1D1fzYL5+bWHym4M9g3ffEgPw5a+jgYxNBtwpuJ7hwxFq47qUT1aO5PdA0sjC+hq691pruQy6GrVFolaDMefWeljW1wjqVYkhMSGqEyLyEKxK0wd1vKT9z5VotHWwPs+LWhGjvikpH3yoIM8Oc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730459803; c=relaxed/simple;
	bh=GmkNNVsgO+cGdzrWYIwM+2l9OI9ms6pGmNAQNZpFAJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gW5tfR4tY4JZctuHAWqdqpZvOWRDXNnmnPFIWVVMq8C59vrhgNO6lSjfoyA/Pg52pYwF/tsnxW2pPVpENGeXXrW5JN+4k61LrYyIOfJNqiJLncU3P7ds+1BLSCUoUy1BkKv0a8fxNywFnU/zwpxFKBDpo6M9AMxPB+6LIClnNI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.10.76])
	by sina.com (10.185.250.24) with ESMTP
	id 6724B88600002126; Fri, 1 Nov 2024 19:16:26 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 89372710748376
X-SMAIL-UIID: 2DB79BBC6FAE4A5FBB7B5D04BBB43BFD-20241101-191626-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+a8cdfe2d8ad35db3a7fd@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernfs?] INFO: task hung in do_coredump (3)
Date: Fri,  1 Nov 2024 19:16:14 +0800
Message-Id: <20241101111614.2670-1-hdanton@sina.com>
In-Reply-To: <67200ed8.050a0220.11b624.04b5.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 28 Oct 2024 15:23:20 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    819837584309 Linux 6.12-rc5
> git tree:       upstream
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=171b4687980000

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/ mm-hotfixes-unstable

--- x/fs/coredump.c
+++ y/fs/coredump.c
@@ -416,7 +416,7 @@ static int coredump_wait(int exit_code,
 		struct core_thread *ptr;
 
 		wait_for_completion_state(&core_state->startup,
-					  TASK_UNINTERRUPTIBLE|TASK_FREEZABLE);
+					  TASK_IDLE|TASK_FREEZABLE);
 		/*
 		 * Wait for all the threads to become inactive, so that
 		 * all the thread context (extended register state, like
--


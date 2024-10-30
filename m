Return-Path: <linux-kernel+bounces-388522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDA19B60B0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09BDB1F2411C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B5D1E411D;
	Wed, 30 Oct 2024 10:59:06 +0000 (UTC)
Received: from mail115-63.sinamail.sina.com.cn (mail115-63.sinamail.sina.com.cn [218.30.115.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209F11E4113
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730285946; cv=none; b=XZhjIl+GKBCeNmD2mDDk1AF4P3/pzKxIeNsa58j8f7EHeFu8W+T6wyit85ZyJhShgrkfqcwI3GPJMhsdIAk1Uufak5EsjrgbK3iaCbqIVAOwKo1K3lNtvRjAU31D5nNXl+hhoSBqdr2WVG9y/27XQ4Gu2uw2cmx9qw/ym4S2EIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730285946; c=relaxed/simple;
	bh=qwousLz4gtVaVB/ltIftQWHhUEQ7sSTHXP0urXXShIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dA5KXkthfVI9q+7nNeI6AAKwXVzxQqJlEn2L9Qz1qqZCOKcU5RI7jqUgLDvGCzmEPIfCVTCnvGT1hwMaRwnjmzQ7PRfclvDloBC1vhuRSyXG5OhC3dFHTNgmpzYzxXeGRQMIIYbtJpBE1Z76ObX62VswGXb8oS65oJcQBjQqOoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.66.137])
	by sina.com (10.185.250.22) with ESMTP
	id 6722116700004DE5; Wed, 30 Oct 2024 18:58:52 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 125247602654
X-SMAIL-UIID: F0D0C9360ECA4881BB85015C380F264C-20241030-185852-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+a8cdfe2d8ad35db3a7fd@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernfs?] INFO: task hung in do_coredump (3)
Date: Wed, 30 Oct 2024 18:58:39 +0800
Message-Id: <20241030105839.2547-1-hdanton@sina.com>
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

#syz test upstream  master

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


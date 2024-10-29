Return-Path: <linux-kernel+bounces-386782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B08FA9B47D7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E20481C24B82
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3680F203708;
	Tue, 29 Oct 2024 11:07:54 +0000 (UTC)
Received: from mail115-118.sinamail.sina.com.cn (mail115-118.sinamail.sina.com.cn [218.30.115.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A4D1DF753
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 11:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730200073; cv=none; b=FEwTWnz6MtvmJ02Ame8fB0D6U4o/FfI4WALcBhj/IuaON7zTws4iRf4hcRPmDAZbE6/VZz5ijBkEZ+hW7KkHHtCkn3Z7BHmFWEoOl1oiJbM8jmX6JOO/CWjIYZ+dWUb190DNgcy3yu9uxl904vHLHcWHOzzYRnO04t1qQHHxFgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730200073; c=relaxed/simple;
	bh=i//hEd+8Spgz3go9PCEf8/mOGgSWQRCcrGaB18xlZhg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=brCzJ6PjOXF9388FrkeQClwZFKOR7u7Hd9nubH7CG4ujcQyfIvKcmN6OWF6RiqFHgQhW8VVck8a5h2ISVXbu1HgXXX8fxL7KX30CimnnY1hzHoA5aqW+dXyBKjoLEkFaj+zzsPSj1Q+53cs5G4tpEfFncP6NwR7VVGOGxLIJLx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.68.172])
	by sina.com (10.185.250.24) with ESMTP
	id 6720C1F7000041EC; Tue, 29 Oct 2024 19:07:39 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 56096010748377
X-SMAIL-UIID: 41B253B1B5234C58B913A1C2898FE593-20241029-190739-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+a8cdfe2d8ad35db3a7fd@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernfs?] INFO: task hung in do_coredump (3)
Date: Tue, 29 Oct 2024 19:07:26 +0800
Message-Id: <20241029110726.2433-1-hdanton@sina.com>
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

#syz test

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


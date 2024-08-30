Return-Path: <linux-kernel+bounces-309471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5929A966AFD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 22:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C3281C22025
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACBD1C2DCF;
	Fri, 30 Aug 2024 20:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCq0ruzJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B511BFDF0
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 20:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725051120; cv=none; b=fFyR73UCFqM96t0xadBxbVvKwjJgcexurVGNfPlbYC7iE1Q6vWeBovox1ue6lU3AfpOkR203u/S4n1NykwU+yAOel+WjbnYAQJz8R6tEwLjZyQ5+fY6voMvgTT0DDoGdeo5XAYa9WokALLI1QYX9jb0MWzChCZtqGrWbnF0RtkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725051120; c=relaxed/simple;
	bh=L39tLmzteaMlelknO4XtntQrZCNbukWTk4YH9v898y0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mLI8+fBqa/ZLGTK9duqwRayMLpYWFzmRFdqMJGBy446nW0q46NqIcK/Jpujc+RJBtqi1/lgRK5Dt2K9RNoiCz3+0oG/yVWIP0TEcyJ6PdpTUfpZINLlw9iWf7dsI5wAv5fprfb/58o2esxq9EPgCZlIZPDWTnC+JkGq8rKukUhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCq0ruzJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3080C4CEC2;
	Fri, 30 Aug 2024 20:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725051119;
	bh=L39tLmzteaMlelknO4XtntQrZCNbukWTk4YH9v898y0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nCq0ruzJbOdNfxGId2egEJhy6keNoNaQU9/UpoUuHKkRE52mCANKeLWQnooXCX5hH
	 21If42pgjCu9e+oV9sp5C9y4sWmoJQOiFrMSUcEJ/exy57gvynV4CDnq2iM1SUncRx
	 f8s7XehBmN3Iid/NDmbbDiUeOj7dJWePgFi86aLiY4jJZ+RdEvCdpPWqS9zKBrZIa9
	 ce+EaoEweRF/MVlhxhoC0zgptpWbHJX8R7wvncjfCbYMccBT3mEKSAKyqur1P2XRyU
	 qpIFYJ/6VTr4WsRciQN75c3eSas6rOFAdln3qUT7j0pAY7p+Ww4Gh1vUEY3rvwnMX8
	 18qdSLJ7JtVbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 718813809A80;
	Fri, 30 Aug 2024 20:52:01 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to avoid use-after-free in
 f2fs_stop_gc_thread()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172505112026.2712133.17685334156318477673.git-patchwork-notify@kernel.org>
Date: Fri, 30 Aug 2024 20:52:00 +0000
References: <20240730010855.2942132-1-chao@kernel.org>
In-Reply-To: <20240730010855.2942132-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, syzbot+1a8e2b31f2ac9bd3d148@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 30 Jul 2024 09:08:55 +0800 you wrote:
> syzbot reports a f2fs bug as below:
> 
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>  print_report+0xe8/0x550 mm/kasan/report.c:491
>  kasan_report+0x143/0x180 mm/kasan/report.c:601
>  kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
>  instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
>  atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
>  __refcount_add include/linux/refcount.h:184 [inline]
>  __refcount_inc include/linux/refcount.h:241 [inline]
>  refcount_inc include/linux/refcount.h:258 [inline]
>  get_task_struct include/linux/sched/task.h:118 [inline]
>  kthread_stop+0xca/0x630 kernel/kthread.c:704
>  f2fs_stop_gc_thread+0x65/0xb0 fs/f2fs/gc.c:210
>  f2fs_do_shutdown+0x192/0x540 fs/f2fs/file.c:2283
>  f2fs_ioc_shutdown fs/f2fs/file.c:2325 [inline]
>  __f2fs_ioctl+0x443a/0xbe60 fs/f2fs/file.c:4325
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:907 [inline]
>  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix to avoid use-after-free in f2fs_stop_gc_thread()
    https://git.kernel.org/jaegeuk/f2fs/c/c7f114d864ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




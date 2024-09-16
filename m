Return-Path: <linux-kernel+bounces-331131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5441B97A8CF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 23:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84EB61C25D9A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 21:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0125F158527;
	Mon, 16 Sep 2024 21:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3eZyCaE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6484217ADE0
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 21:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726522242; cv=none; b=EUemkxkBs1qeYJJNQQH1Tz/HjlYW6IjVcPwEnxtmzNVSojg8YgQX3aan0vJ1u/nmv8Ay19hd5ihfsGJm+ap+Fg07h9SnjRKxDvUZa8bL5tHRVjQIYSOIVIDk7LQQS97GFOnwbilRPPN2vk8c+g6C+5tQMDOrAN7mSxoRBPWESSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726522242; c=relaxed/simple;
	bh=tSD8XJAuZN/iamujVj5Yupc0eKiuu2Cf1U7jWiweoN4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Vl0iOXwtoQcUu+JCsMO/E1szc5j18Ld2B/etcO7Al3yp9un8MC1H7wwiHeev0PyeHTQotZlpNvr/YFe3TtnGS/Rqkvlky+AXfnG0G9iwfIuC77ab7rjeoMy1WT5WXGqavzh3zbA7BR5Q5T/d/BWmn00NDHKn56pH9O4iRLuDet0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3eZyCaE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2678C4CECF;
	Mon, 16 Sep 2024 21:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726522241;
	bh=tSD8XJAuZN/iamujVj5Yupc0eKiuu2Cf1U7jWiweoN4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m3eZyCaE3qsmseZJ+YPEJmlcxBLgn3LxeJuehfAvzApu50uYhurgbaVvPoOQ3Dg9M
	 FKCsDNkfWXELYsPo/SsWDWWLkkLeuIesVWFPshhuWwDp75Wwd/YqnypJIaQH6MoJ86
	 2KQEPqE56lwAOlYsUfyvQLz5jH4OcyOi14ypBNm8sxpI5pvjDsY3jHt3BLmKG21qKR
	 ZwK32vmjkkvCM70stdaa6+suEsFR/5/MexNyIjIhGBpFoN5wCF+5iwoJHFErSXk6hm
	 9h+UVdJUhHtz0JJIGKH8gnT/wL6lZun5ohEHwxnuoS87IG8f5+7JXxNp+FGazZrb0K
	 RmPugBKisanng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD123806644;
	Mon, 16 Sep 2024 21:30:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to don't set SB_RDONLY in
 f2fs_handle_critical_error()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172652224325.3820990.5977903925076414761.git-patchwork-notify@kernel.org>
Date: Mon, 16 Sep 2024 21:30:43 +0000
References: <20240910030713.3716318-1-chao@kernel.org>
In-Reply-To: <20240910030713.3716318-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, brauner@kernel.org, jack@suse.cz,
 linux-kernel@vger.kernel.org,
 syzbot+20d7e439f76bbbd863a7@syzkaller.appspotmail.com,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 10 Sep 2024 11:07:13 +0800 you wrote:
> syzbot reports a f2fs bug as below:
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 58 at kernel/rcu/sync.c:177 rcu_sync_dtor+0xcd/0x180 kernel/rcu/sync.c:177
> CPU: 1 UID: 0 PID: 58 Comm: kworker/1:2 Not tainted 6.10.0-syzkaller-12562-g1722389b0d86 #0
> Workqueue: events destroy_super_work
> RIP: 0010:rcu_sync_dtor+0xcd/0x180 kernel/rcu/sync.c:177
> Call Trace:
>  percpu_free_rwsem+0x41/0x80 kernel/locking/percpu-rwsem.c:42
>  destroy_super_work+0xec/0x130 fs/super.c:282
>  process_one_work kernel/workqueue.c:3231 [inline]
>  process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
>  worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to don't set SB_RDONLY in f2fs_handle_critical_error()
    https://git.kernel.org/jaegeuk/f2fs/c/930c6ab93492

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




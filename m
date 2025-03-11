Return-Path: <linux-kernel+bounces-556889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D86A5CFE5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B09DF189D42D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665D7264615;
	Tue, 11 Mar 2025 19:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVpVc7b8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C742E2641D8
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 19:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741722603; cv=none; b=rYK3ir7zOK6gQDpL6UOR80ainrIMxsjN+xsU5IIqWl25Roc8T+x/3UUALav5Rw32/nYjS5zbKJ7tDlXcKQ3b7PmQ1hKhgzmLUo1xbYKOdPYU8XVrWHBdUaJPxcGL1IM6fVu3u+/uDGRUyopH/30K64OmLWwt3JKnvv0oqBFX3+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741722603; c=relaxed/simple;
	bh=+qG6d7S8I82gDrV+L5d1hoVLSp/ulhZqrxchLH9vvts=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Lra68nT/BMwGQfrKgNUlzx0Xcu7tJfAbxR78Sf6TJEmxVr3GT/yqOexsW7ypUWB8L6pojtgJQEXwfJSUYi7SZYdoJTy2oauBUb6RS7fwbTVGKDf58wFB1L2pIdsGvQRiTdpU81jbTxElCvge0zLS55IhzEzdLKe/3kwuF93oEJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVpVc7b8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4642EC4CEE9;
	Tue, 11 Mar 2025 19:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741722603;
	bh=+qG6d7S8I82gDrV+L5d1hoVLSp/ulhZqrxchLH9vvts=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rVpVc7b8z7nqnLhZibPYVf8s9QMOTSjZblbCf/+IK9FbN22X5U/MdL0hk7gV801xP
	 lZotN5FSP5dmuyr2P9YpeOleSumSUf9y9b67eGJy1nHb+zgZUNdMGT0Kpa3Ks3Efcy
	 i+CO5ThSGz5xxod4LPBGM60AY1bwqs6AIHopehg9uzOPhNd4eTXJzThhkNTLb2RFAt
	 Qv9TqQRTzr0ggsqX0epj4hv09348pLGP6gWvnG6Vu4osoaRQF4L82SlfJ1Tx2ddKjX
	 RYRsynF7utmWqMb8zW3sVtZVrBojsNECS6oCtIWBeIUeT+OFSxukh0JKtZF0PFBQ9S
	 /hI4EwJIzb8Jg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCCB380AC1C;
	Tue, 11 Mar 2025 19:50:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to avoid accessing uninitialized
 curseg
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <174172263724.214029.5489516472538640830.git-patchwork-notify@kernel.org>
Date: Tue, 11 Mar 2025 19:50:37 +0000
References: <20250224102923.93758-1-chao@kernel.org>
In-Reply-To: <20250224102923.93758-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 syzbot+b6b347b7a4ea1b2e29b6@syzkaller.appspotmail.com,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 24 Feb 2025 18:29:23 +0800 you wrote:
> syzbot reports a f2fs bug as below:
> 
> F2FS-fs (loop3): Stopped filesystem due to reason: 7
> kworker/u8:7: attempt to access beyond end of device
> BUG: unable to handle page fault for address: ffffed1604ea3dfa
> RIP: 0010:get_ckpt_valid_blocks fs/f2fs/segment.h:361 [inline]
> RIP: 0010:has_curseg_enough_space fs/f2fs/segment.h:570 [inline]
> RIP: 0010:__get_secs_required fs/f2fs/segment.h:620 [inline]
> RIP: 0010:has_not_enough_free_secs fs/f2fs/segment.h:633 [inline]
> RIP: 0010:has_enough_free_secs+0x575/0x1660 fs/f2fs/segment.h:649
>  <TASK>
>  f2fs_is_checkpoint_ready fs/f2fs/segment.h:671 [inline]
>  f2fs_write_inode+0x425/0x540 fs/f2fs/inode.c:791
>  write_inode fs/fs-writeback.c:1525 [inline]
>  __writeback_single_inode+0x708/0x10d0 fs/fs-writeback.c:1745
>  writeback_sb_inodes+0x820/0x1360 fs/fs-writeback.c:1976
>  wb_writeback+0x413/0xb80 fs/fs-writeback.c:2156
>  wb_do_writeback fs/fs-writeback.c:2303 [inline]
>  wb_workfn+0x410/0x1080 fs/fs-writeback.c:2343
>  process_one_work kernel/workqueue.c:3236 [inline]
>  process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3317
>  worker_thread+0x870/0xd30 kernel/workqueue.c:3398
>  kthread+0x7a9/0x920 kernel/kthread.c:464
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix to avoid accessing uninitialized curseg
    https://git.kernel.org/jaegeuk/f2fs/c/986c50f6bca1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




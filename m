Return-Path: <linux-kernel+bounces-385497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 680989B37F5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 131FD1F22A1E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53A01E0B7B;
	Mon, 28 Oct 2024 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5tbBbvy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E321E1E048F
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137230; cv=none; b=COBe+gm/njnIXkOdKPESqds2IBiS0i11d3vvDsCvyE0nvHM4fFBjZ7lHzHp8nXF52NBsFNKBIQ03dKS1suc8cnjZ9mk0a0WckmkHqPe7IH5scQJMKBg0KN+97sVKxAo5tYqmLMxY3/u1/NsEeNs0jURu6S3bXs4Y/pFRQ8R1oHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137230; c=relaxed/simple;
	bh=M57Z0VxnT5yC46WkZqloqUomYzVIUkLNmjPO7S8c6bQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r7AOgn2/LM1WugVvtK3U7H/L+r0yYFn2yxfolK2lghWT3vl6Ty4UsdEiIL/tnWSUOahReOuTWf/4j3k3k8k1qsT7WGQZw99SbsEACucEbZY4h3HltB4ge9tKTCx25bxB8FKy+Onab0atjlO7diy9RoYdcaQkvBAzGETnuFaHzeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5tbBbvy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4829CC4AF48;
	Mon, 28 Oct 2024 17:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730137229;
	bh=M57Z0VxnT5yC46WkZqloqUomYzVIUkLNmjPO7S8c6bQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k5tbBbvy+fGZReQZKRQEJp69eb4geJdVN1aYGK6fX8Y7/GhKfQ3iDXo1smdaOIPws
	 clpQN0pzF06qVO+ykkaNKq7IC+BwJMx95z1U/OsRPOZAlfvarVJjn9gsR37kZcRH/D
	 TfpG1toCPO7it6oNyOynbYIj9PtqFVfTLvUcTb+HZrlgQnqKBvNiuTDoSoYEJd/t1t
	 /h3xPE2grW106xqOnx33BG9LzRXzvtI2KMkMybshGq8aKuHVU6wrbIhzmbEM72Zcca
	 6NucGqXcuoaHqALkVfw58H3ivNyxw+IOWAeHW3ewPojDQ1CY8+iG4LX+qJZ7PufuSM
	 IIgWBvb0w8WJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE93380AC1C;
	Mon, 28 Oct 2024 17:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix f2fs_bug_on when uninstalling
 filesystem call f2fs_evict_inode.
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <173013723649.126843.961245482692582747.git-patchwork-notify@kernel.org>
Date: Mon, 28 Oct 2024 17:40:36 +0000
References: <20240918084400.1821317-1-hanqi@vivo.com>
In-Reply-To: <20240918084400.1821317-1-hanqi@vivo.com>
To: Qi Han <hanqi@vivo.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 18 Sep 2024 02:44:00 -0600 you wrote:
> creating a large files during checkpoint disable until it runs out of
> space and then delete it, then remount to enable checkpoint again, and
> then unmount the filesystem triggers the f2fs_bug_on as below:
> 
> ------------[ cut here ]------------
> kernel BUG at fs/f2fs/inode.c:896!
> CPU: 2 UID: 0 PID: 1286 Comm: umount Not tainted 6.11.0-rc7-dirty #360
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> RIP: 0010:f2fs_evict_inode+0x58c/0x610
> Call Trace:
>  __die_body+0x15/0x60
>  die+0x33/0x50
>  do_trap+0x10a/0x120
>  f2fs_evict_inode+0x58c/0x610
>  do_error_trap+0x60/0x80
>  f2fs_evict_inode+0x58c/0x610
>  exc_invalid_op+0x53/0x60
>  f2fs_evict_inode+0x58c/0x610
>  asm_exc_invalid_op+0x16/0x20
>  f2fs_evict_inode+0x58c/0x610
>  evict+0x101/0x260
>  dispose_list+0x30/0x50
>  evict_inodes+0x140/0x190
>  generic_shutdown_super+0x2f/0x150
>  kill_block_super+0x11/0x40
>  kill_f2fs_super+0x7d/0x140
>  deactivate_locked_super+0x2a/0x70
>  cleanup_mnt+0xb3/0x140
>  task_work_run+0x61/0x90
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix f2fs_bug_on when uninstalling filesystem call f2fs_evict_inode.
    https://git.kernel.org/jaegeuk/f2fs/c/d5c367ef8287

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <linux-kernel+bounces-545131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 102ADA4EB16
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E865C8A5860
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B49B2780F4;
	Tue,  4 Mar 2025 17:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjD8hFeM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6337A2638B3
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108213; cv=none; b=sbgt7CBmK7YncejRFXB484advzoFWsPd6XDq29Rof91iF6SKvBVtLD2KuWoIwY8sWDjex2W3ybWGWqk9upk4GVJgLYjlL5YrYjql5FJ2h556DCEehxnvI0MzubWQSS4hvBq1Khsul6T9et4P5iT0btcGxQPL4RDggo1ejSyJbaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108213; c=relaxed/simple;
	bh=WWUDy4hRLXd6xsZfc/ZyszaaktyeH+JXKR4MtvSr5Ds=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OEDlcsdh1MiN36V/0F/SQBeNNL0lipdYBO8hkKEK7K8IfRaVHNk+eOYLtW8FvOMlmScKnSy9Kl3XfTL99yD9AjSoiPrTpkZ2eaC0y9VWdDrG7YXLrdfFDzppt8t5wt07sYlYIdZzP8z3HB8g6qG1aKPVlAaqHQljciVrvOyDit4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjD8hFeM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82FEC4CEE5;
	Tue,  4 Mar 2025 17:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741108212;
	bh=WWUDy4hRLXd6xsZfc/ZyszaaktyeH+JXKR4MtvSr5Ds=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BjD8hFeMnQQCkogqz88dd79fqRCaUmhcB00T8MDRipDwEKPTpmIsWM5JWeWC9LDUx
	 GKVnkKxct1nIW5L9hA+f3CcCVtSIHZXlWrmmwLcysPgzjIj44fGw0wj69yh4NDx/y5
	 ThWU0QkuKtHi1dB4oTGOA6T85Vdb/7rjIKhAECf9JF5cU5K5Hs739WVHGlM5uGx0RU
	 UNNdMwpt0wySI/zdiyAEtQrnyCmTCbKWMF+Unp6/Juloxg0i+cfBiDj/VzuSSDmu9V
	 w8kSBcvQLxaiHyIZdSIqcbD/1ZqS15cQvtuL2pOREalm1Gge80LRI9YNcHWU8aG3is
	 RqNEcsfT/LU/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB24C380AA7F;
	Tue,  4 Mar 2025 17:10:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid out-of-bounds access in
 f2fs_truncate_inode_blocks()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <174110824573.224349.9408350967320704453.git-patchwork-notify@kernel.org>
Date: Tue, 04 Mar 2025 17:10:45 +0000
References: <20250303034738.1355927-1-chao@kernel.org>
In-Reply-To: <20250303034738.1355927-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, syzbot+6653f10281a1badc749e@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon,  3 Mar 2025 11:47:38 +0800 you wrote:
> syzbot reports an UBSAN issue as below:
> 
> ------------[ cut here ]------------
> UBSAN: array-index-out-of-bounds in fs/f2fs/node.h:381:10
> index 18446744073709550692 is out of range for type '__le32[5]' (aka 'unsigned int[5]')
> CPU: 0 UID: 0 PID: 5318 Comm: syz.0.0 Not tainted 6.14.0-rc3-syzkaller-00060-g6537cfb395f3 #0
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  ubsan_epilogue lib/ubsan.c:231 [inline]
>  __ubsan_handle_out_of_bounds+0x121/0x150 lib/ubsan.c:429
>  get_nid fs/f2fs/node.h:381 [inline]
>  f2fs_truncate_inode_blocks+0xa5e/0xf60 fs/f2fs/node.c:1181
>  f2fs_do_truncate_blocks+0x782/0x1030 fs/f2fs/file.c:808
>  f2fs_truncate_blocks+0x10d/0x300 fs/f2fs/file.c:836
>  f2fs_truncate+0x417/0x720 fs/f2fs/file.c:886
>  f2fs_file_write_iter+0x1bdb/0x2550 fs/f2fs/file.c:5093
>  aio_write+0x56b/0x7c0 fs/aio.c:1633
>  io_submit_one+0x8a7/0x18a0 fs/aio.c:2052
>  __do_sys_io_submit fs/aio.c:2111 [inline]
>  __se_sys_io_submit+0x171/0x2e0 fs/aio.c:2081
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f238798cde9
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to avoid out-of-bounds access in f2fs_truncate_inode_blocks()
    https://git.kernel.org/jaegeuk/f2fs/c/e6494977bd4a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




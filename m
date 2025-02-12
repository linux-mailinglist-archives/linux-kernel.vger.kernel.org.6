Return-Path: <linux-kernel+bounces-510414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC69A31C7E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 04:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBC253A727C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 03:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264341DB12D;
	Wed, 12 Feb 2025 03:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biPZNrBV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C681D9688
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739329212; cv=none; b=nefNd6LbvyQ4+nAs6M69ll7BRi252/w6ofxlM/5dQqzHmQXpk3IgjmV230/EPW1QcBWGQlgNJTo6DdRpcddl7rBs5umspEVNpGPZ3wILybZaH64+AnDNpCT/+ICCPjWLXT6MkFVNgpVWEH2YjjX8vCgRjVgs6kFBnuW9qt4WQpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739329212; c=relaxed/simple;
	bh=3asK8Y8U8glA2LNCKXEl2FC1l727IKQxHBsgJIa/F4o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nz6KDzJnNuMEBCXqubvVLdcj+uq+SPLeKZSHCcOvh5B4ADLu5MQ9YeD+OidxJo9Kq++dFJ5HdDoh33rNTzkr2P5VvULiHcVWPE7bIVMdtmtVwS8f+tvwQ/QaNso8Rx7VpXIY7SYiGTNe+qL2cIbddcCUpeuFwYPOFCG8GebeRPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biPZNrBV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE76FC4CEE4;
	Wed, 12 Feb 2025 03:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739329211;
	bh=3asK8Y8U8glA2LNCKXEl2FC1l727IKQxHBsgJIa/F4o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=biPZNrBVck1DuGNXkFv6+ys3dhIhKWjvbMkp8k+5TuEbaSyV+qyBsZZxx09jjoxQ5
	 bboD2jmgDvfGtsYPSaUc4ZvXJIhydhl/PmkRYyvFvCVrgiwK+EbLtvbdZAdazNIevs
	 NtJBMyX8/Gz3Epv6T7gnMhSic+pbYmqDj7OuD9WloamkPBfoOpSeewzlLhayaVRCaU
	 rAK72SEyAYa7DB71cN1Kp9PHjkZ0s/EuMWNgU6BPY2QCpCgGOudJioQPl5rZQR0CK/
	 bEUtwOnw7JN9c73e7KkaCZI0NXAv0ujH3ZmnmSlxav4pUernDDygErpIZ3XGN2Tx/b
	 0pUhJK/4ff4Kw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADBA380AAFF;
	Wed, 12 Feb 2025 03:00:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid panic once fallocation fails
 for pinfile
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <173932924049.82998.16364535718355132249.git-patchwork-notify@kernel.org>
Date: Wed, 12 Feb 2025 03:00:40 +0000
References: <20250211063657.405289-1-chao@kernel.org>
In-Reply-To: <20250211063657.405289-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, syzbot+15669ec8c35ddf6c3d43@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 11 Feb 2025 14:36:57 +0800 you wrote:
> syzbot reports a f2fs bug as below:
> 
> ------------[ cut here ]------------
> kernel BUG at fs/f2fs/segment.c:2746!
> CPU: 0 UID: 0 PID: 5323 Comm: syz.0.0 Not tainted 6.13.0-rc2-syzkaller-00018-g7cb1b4663150 #0
> RIP: 0010:get_new_segment fs/f2fs/segment.c:2746 [inline]
> RIP: 0010:new_curseg+0x1f52/0x1f70 fs/f2fs/segment.c:2876
> Call Trace:
>  <TASK>
>  __allocate_new_segment+0x1ce/0x940 fs/f2fs/segment.c:3210
>  f2fs_allocate_new_section fs/f2fs/segment.c:3224 [inline]
>  f2fs_allocate_pinning_section+0xfa/0x4e0 fs/f2fs/segment.c:3238
>  f2fs_expand_inode_data+0x696/0xca0 fs/f2fs/file.c:1830
>  f2fs_fallocate+0x537/0xa10 fs/f2fs/file.c:1940
>  vfs_fallocate+0x569/0x6e0 fs/open.c:327
>  do_vfs_ioctl+0x258c/0x2e40 fs/ioctl.c:885
>  __do_sys_ioctl fs/ioctl.c:904 [inline]
>  __se_sys_ioctl+0x80/0x170 fs/ioctl.c:892
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to avoid panic once fallocation fails for pinfile
    https://git.kernel.org/jaegeuk/f2fs/c/48ea8b200414

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




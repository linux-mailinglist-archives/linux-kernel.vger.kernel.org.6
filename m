Return-Path: <linux-kernel+bounces-400593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022219C0FA7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CD521C2169E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5931D5CCF;
	Thu,  7 Nov 2024 20:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAD71rx1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A001940AA
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 20:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731011429; cv=none; b=SgrbZJkjN8y1myeY6Y+ZMiivwOWsyNm98OmmOHrkgQ+cO61jQJoBfuut/TAQWdjXqGgzkL4Id6uPF7gtIobE4TOZBLC2GO/6TPjJp9u9LZOguQTDvt4UViGtzuYpBhw8/Us2uVVk8K4LVvOBNv8WkRxuobTC/q6JPuIfVRfDSRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731011429; c=relaxed/simple;
	bh=PJa3ud3Q4IAiR4hQi7wTBGOpeDpVzUhFTJUlSeSTUdk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C4T6Gas+Omd+eqv6WmixeRCRlM/+6cIC0EKIrpRiK38xyzPZxmQD9hNC62KPq+394GVOhpSbzD2YIOhOJ7Ek8KDA9S42LeM927qe8yIeMo+g6jXhAfuLpPl/Vk162+21tUpKt3AyWKsD4dcRkWqblCjXgW2dn2SEhaxA1lp8PMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAD71rx1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CB5C4CECC;
	Thu,  7 Nov 2024 20:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731011428;
	bh=PJa3ud3Q4IAiR4hQi7wTBGOpeDpVzUhFTJUlSeSTUdk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XAD71rx1PtiyTGxLPou1xMbtKKSLlluSJgKWnUEzmLK8eA0Uy3EHMwa1xiqA9PUNa
	 Ob6ihufkTwq1uszccY5s5adJxevwNTUvhEMaKNAYN7yj62P0fUo/UTA/XZbbuloM5n
	 EP9oRMndrR/BbChRyDYZvcb2qfAFAUnPizK5v9/lPjU7cfxOznQLukK6A60FfNwe2P
	 7WfUv81dQ8XuYHZHB18Qmlhp4wyYPagyV99efgmvxTS0pJ2SyXE04Ys7Sg12DFi9d3
	 7yciC5WFcoVDksnNg6AMmcRTGYEvs33OOrrsAwMV/H32JnDMX2k414sueJUTk2ZEU/
	 rvqehrfOVnOZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB3373809A80;
	Thu,  7 Nov 2024 20:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix race in concurrent
 f2fs_stop_gc_thread
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <173101143777.2084993.11494159010925970965.git-patchwork-notify@kernel.org>
Date: Thu, 07 Nov 2024 20:30:37 +0000
References: <20241104020542.2603607-1-leo.lilong@huawei.com>
In-Reply-To: <20241104020542.2603607-1-leo.lilong@huawei.com>
To: Long Li <leo.lilong@huawei.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, yi.zhang@huawei.com,
 lonuxli.64@gmail.com, yangerkun@huawei.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 4 Nov 2024 10:05:42 +0800 you wrote:
> In my test case, concurrent calls to f2fs shutdown report the following
> stack trace:
> 
>  Oops: general protection fault, probably for non-canonical address 0xc6cfff63bb5513fc: 0000 [#1] PREEMPT SMP PTI
>  CPU: 0 UID: 0 PID: 678 Comm: f2fs_rep_shutdo Not tainted 6.12.0-rc5-next-20241029-g6fb2fa9805c5-dirty #85
>  Call Trace:
>   <TASK>
>   ? show_regs+0x8b/0xa0
>   ? __die_body+0x26/0xa0
>   ? die_addr+0x54/0x90
>   ? exc_general_protection+0x24b/0x5c0
>   ? asm_exc_general_protection+0x26/0x30
>   ? kthread_stop+0x46/0x390
>   f2fs_stop_gc_thread+0x6c/0x110
>   f2fs_do_shutdown+0x309/0x3a0
>   f2fs_ioc_shutdown+0x150/0x1c0
>   __f2fs_ioctl+0xffd/0x2ac0
>   f2fs_ioctl+0x76/0xe0
>   vfs_ioctl+0x23/0x60
>   __x64_sys_ioctl+0xce/0xf0
>   x64_sys_call+0x2b1b/0x4540
>   do_syscall_64+0xa7/0x240
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix race in concurrent f2fs_stop_gc_thread
    https://git.kernel.org/jaegeuk/f2fs/c/7b0033dbc483

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




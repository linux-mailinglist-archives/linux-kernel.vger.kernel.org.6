Return-Path: <linux-kernel+bounces-385509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 527109B380E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 840031C22121
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9871FF5F7;
	Mon, 28 Oct 2024 17:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsRHubI0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280661FBF4D
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137237; cv=none; b=lF/+HPeZ3y09DxY9wt2vgDYWrtWmVLfvXQJLUaJ9U5nR+gKggk4Z5fl5lr7Mak1LT2r2VljmHT/MX74oAL5wXrDDe2RJ3gQD0chNEC0gmkLs98Br4/A9B0/+BoZPMtJYDyItFPHUlqh8WnRtlEnm7cVncvcJzfiOUXLGYoPqkAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137237; c=relaxed/simple;
	bh=zUOiog+udt4w3pRdHXpty+ks/QHOzQoZWUfTUON0AYs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AO8Oq0hAc9c+aF1UsG/dYENHazUb/m8xE+EJOu4TBKqmBTzimJSoXMVVb1KgkozJvQpA3aLwk+xH8zMxUMtMqt681wzt9nmZaeTiWsC3ssmAKbNnqZrgM4PjXD2zDZjAP/UKaC93VLaqyNHFO3Lxwf0pujh9WOzbKRUlHMSLuWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsRHubI0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1863C4CEED;
	Mon, 28 Oct 2024 17:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730137236;
	bh=zUOiog+udt4w3pRdHXpty+ks/QHOzQoZWUfTUON0AYs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UsRHubI0me7oHxa5Kb7o/7aeKcWSxFiKQgLBQvaByvwSjv2FNS7+54LJVTaxb/mwQ
	 UUsvqcCvOGPpsXvQRwHdX84W7MLdoiOz7JaN35kb0sk/pyfnW2zbAWKAIdFTsvm3Vf
	 W/bkRpbIJwngDMFZaGIjl8TR8LTu4gboAEbILp3kFQYBx+9dIKbMeOM8HKNtMNSTzf
	 bY0fP36aCD2ydDUJnNblZkM8vGrY3KLz8oR+Fm1Nm2zEZGpdxvFwj6uKqOV3R4MHuB
	 dxYcQKmlFn7e6gS5bf5JMOzSGynQ8Xd9dJfViWRfbpYxnl4YgzoGzZpAf6f0REYwsH
	 QjNoCfvF3xcmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F41380AC1C;
	Mon, 28 Oct 2024 17:40:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix null-ptr-deref in
 f2fs_submit_page_bio()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <173013724399.126843.16835536679745667890.git-patchwork-notify@kernel.org>
Date: Mon, 28 Oct 2024 17:40:43 +0000
References: <20241011164450.3366215-1-yebin@huaweicloud.com>
In-Reply-To: <20241011164450.3366215-1-yebin@huaweicloud.com>
To: Ye Bin <yebin@huaweicloud.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, zhangxiaoxu5@huawei.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sat, 12 Oct 2024 00:44:50 +0800 you wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> There's issue as follows when concurrently installing the f2fs.ko
> module and mounting the f2fs file system:
> KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
> RIP: 0010:__bio_alloc+0x2fb/0x6c0 [f2fs]
> Call Trace:
>  <TASK>
>  f2fs_submit_page_bio+0x126/0x8b0 [f2fs]
>  __get_meta_page+0x1d4/0x920 [f2fs]
>  get_checkpoint_version.constprop.0+0x2b/0x3c0 [f2fs]
>  validate_checkpoint+0xac/0x290 [f2fs]
>  f2fs_get_valid_checkpoint+0x207/0x950 [f2fs]
>  f2fs_fill_super+0x1007/0x39b0 [f2fs]
>  mount_bdev+0x183/0x250
>  legacy_get_tree+0xf4/0x1e0
>  vfs_get_tree+0x88/0x340
>  do_new_mount+0x283/0x5e0
>  path_mount+0x2b2/0x15b0
>  __x64_sys_mount+0x1fe/0x270
>  do_syscall_64+0x5f/0x170
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix null-ptr-deref in f2fs_submit_page_bio()
    https://git.kernel.org/jaegeuk/f2fs/c/b7d0a97b2808

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




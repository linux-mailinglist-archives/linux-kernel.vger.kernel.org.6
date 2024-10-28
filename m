Return-Path: <linux-kernel+bounces-385513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F7B9B3813
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2D661C22208
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564D6200C8A;
	Mon, 28 Oct 2024 17:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UM6aALqu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85A220101E
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 17:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137244; cv=none; b=Gg3qyCEc2sd0spi3fgIFVS6E2QLfi2m9nVtTFQm6RMyNPUzvf5Jyek651Q4PC3nR2R8KQ44r3FfEWlDTr8I/LrAuJZMskx1yiVXCWcN+j1B3abKU05nSVOV9vmeXgQKbUrOOLushbaE9fKWBn8QhIzXYeQBNl0g0oEbmp1sUFBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137244; c=relaxed/simple;
	bh=0e6mh1pPRvBQrevYXf0NwQRU0jj/QaQLKxi7HwBRBSQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hNA+oGy0hjjIGYf2yvkYnpgfkX82i6TNnguijKfpC/C93YW1GPMIpJCrHX6Yhq0AbulI4Ofo4MNHcDZj9X2lvjegw/mUmHE6/XqygOIQIx/3cZ8i8tykfpWJ1gaIHicFKH0/e/UVeizUpCcukjnTfh/vvav62iepXag+eB5cTW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UM6aALqu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D0CC4CEC3;
	Mon, 28 Oct 2024 17:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730137243;
	bh=0e6mh1pPRvBQrevYXf0NwQRU0jj/QaQLKxi7HwBRBSQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UM6aALquUPYQTkzoE6ENq9nFPI5r+s2F2rXv1hfX6H/tzAMFKHj7FPsRWp1AeLZ3C
	 qfw6M+MIo2tLrfa+PNj4A65XX0XmV4Zj5Ad+nKCcUDxzqIynDZCXcabcgZJiXFG/gv
	 QFqWwJS5z6KmhTWVlSEigeKqdqSOiVixrG9d5OFj3zUntW01DF+fyHNu80AkfLn57c
	 8QjHSC81FibQke8MAG7as3io5/ApKpAG9MAswWeWv3PahSYzNhRBeLCsFsEcgUCoiE
	 AMEuwaNkfi43H2HvwrvuNLeq58qvePIrlW/vqnEIOc0lbe08sAOps4xjyEOC8R2V4y
	 qsp0a3L7yeh9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC6D380AC1C;
	Mon, 28 Oct 2024 17:40:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to account dirty data in
 __get_secs_required()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <173013725051.126843.7852092128381308948.git-patchwork-notify@kernel.org>
Date: Mon, 28 Oct 2024 17:40:50 +0000
References: <20241015034339.3244676-1-chao@kernel.org>
In-Reply-To: <20241015034339.3244676-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, drosen@google.com,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 15 Oct 2024 11:43:39 +0800 you wrote:
> It will trigger system panic w/ testcase in [1]:
> 
> ------------[ cut here ]------------
> kernel BUG at fs/f2fs/segment.c:2752!
> RIP: 0010:new_curseg+0xc81/0x2110
> Call Trace:
>  f2fs_allocate_data_block+0x1c91/0x4540
>  do_write_page+0x163/0xdf0
>  f2fs_outplace_write_data+0x1aa/0x340
>  f2fs_do_write_data_page+0x797/0x2280
>  f2fs_write_single_data_page+0x16cd/0x2190
>  f2fs_write_cache_pages+0x994/0x1c80
>  f2fs_write_data_pages+0x9cc/0xea0
>  do_writepages+0x194/0x7a0
>  filemap_fdatawrite_wbc+0x12b/0x1a0
>  __filemap_fdatawrite_range+0xbb/0xf0
>  file_write_and_wait_range+0xa1/0x110
>  f2fs_do_sync_file+0x26f/0x1c50
>  f2fs_sync_file+0x12b/0x1d0
>  vfs_fsync_range+0xfa/0x230
>  do_fsync+0x3d/0x80
>  __x64_sys_fsync+0x37/0x50
>  x64_sys_call+0x1e88/0x20d0
>  do_syscall_64+0x4b/0x110
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to account dirty data in __get_secs_required()
    https://git.kernel.org/jaegeuk/f2fs/c/1acd73edbbfe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




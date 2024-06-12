Return-Path: <linux-kernel+bounces-211837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910779057BA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 271182893DC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AA61836E2;
	Wed, 12 Jun 2024 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epUylh4W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF81181322
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207757; cv=none; b=sdRq415Nsb4gG2hpgnql1/9Zt+CJJBZV7Z5w4Gm2U/Bm2556uheGMKp+xItjA1oP7raOGwkLRw2ZVtULvCeCjF3xkZLQCt6ndfBJUzhn83/kFuqVPMIsJdNVgWGDjP94GnNF/0X+eVMfwNVmw5+SeoJy81uytrTKsh/RJm92src=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207757; c=relaxed/simple;
	bh=nvqdK8Zfe+BQqsmHz03eVLUh1k+NW47H6UA4WSho07I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=huvn2ILe0ne31bHQnyBlA27fFLuUkTgN4VRYeFF393ccvCp2MdPTRA1prwf8p5qWuqY9qR75sPIBh+625ukp1/qou78oqf0RtgOmK+wTCqhW74PimlXFYeUdn9kLpJNNoSqsbdIWjqTyDZf6OlugbRhRFWEG7UYJdoFzhn38f64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epUylh4W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81EECC4AF4D;
	Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718207757;
	bh=nvqdK8Zfe+BQqsmHz03eVLUh1k+NW47H6UA4WSho07I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=epUylh4Wid+JYSdc14+jnpQ4XAO0GHhRMf3jsCknV2zF2KrJo1ADGp4pQ+rQeSj8d
	 spM/szMeN43fZgHaV5R9s6ctyM1yz2wmjXYkcCLiULtBeFdXbVTtqiweUiaIAhz9s/
	 3+Lr61L7+/aTHvhWLYQVyOip6OlnGkMpTZna+Cu6LoVZyGEjKH3tGkYSKp4gCLs7k3
	 PBY661Ck0f36PhE7frbYprhlcHoy6wZSVfl/w8+Ece6zYNn1kXgc+2KfhvbPUtMzV2
	 XCjNXbDeF3rL8yZU/K/y5wacN/pHE037DJL77ydqnkAEv+AXRdhToyFmAMgtQsiAAq
	 +7SildofgLo8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75A19C43619;
	Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to truncate preallocated blocks in
 f2fs_file_open()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171820775747.32393.11994963596959116040.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jun 2024 15:55:57 +0000
References: <20240529100103.329778-1-chao@kernel.org>
In-Reply-To: <20240529100103.329778-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, yuwen.chen@xjmz.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 29 May 2024 18:01:03 +0800 you wrote:
> chenyuwen reports a f2fs bug as below:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000011
>  fscrypt_set_bio_crypt_ctx+0x78/0x1e8
>  f2fs_grab_read_bio+0x78/0x208
>  f2fs_submit_page_read+0x44/0x154
>  f2fs_get_read_data_page+0x288/0x5f4
>  f2fs_get_lock_data_page+0x60/0x190
>  truncate_partial_data_page+0x108/0x4fc
>  f2fs_do_truncate_blocks+0x344/0x5f0
>  f2fs_truncate_blocks+0x6c/0x134
>  f2fs_truncate+0xd8/0x200
>  f2fs_iget+0x20c/0x5ac
>  do_garbage_collect+0x5d0/0xf6c
>  f2fs_gc+0x22c/0x6a4
>  f2fs_disable_checkpoint+0xc8/0x310
>  f2fs_fill_super+0x14bc/0x1764
>  mount_bdev+0x1b4/0x21c
>  f2fs_mount+0x20/0x30
>  legacy_get_tree+0x50/0xbc
>  vfs_get_tree+0x5c/0x1b0
>  do_new_mount+0x298/0x4cc
>  path_mount+0x33c/0x5fc
>  __arm64_sys_mount+0xcc/0x15c
>  invoke_syscall+0x60/0x150
>  el0_svc_common+0xb8/0xf8
>  do_el0_svc+0x28/0xa0
>  el0_svc+0x24/0x84
>  el0t_64_sync_handler+0x88/0xec
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix to truncate preallocated blocks in f2fs_file_open()
    https://git.kernel.org/jaegeuk/f2fs/c/298b1e4182d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




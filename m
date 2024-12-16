Return-Path: <linux-kernel+bounces-447707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1F69F3640
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16F1316539B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C54200BB4;
	Mon, 16 Dec 2024 16:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="juaKhib8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA86114B086
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367223; cv=none; b=qGb8cUjsF/L59lxyd8x/1B1RH/J5/E3q9eHOTTX+M4bhVElBC/IRTfqJ8RfvM1rljrqb4FC2lASr6kFxBpdRG2IVGjGO1i/85eM/RRWvyQJbDpPqwvtKEpgxUEXImSrYvtawv5KA/mISkXHXvGSDYuSU3DHyq9GAxFHk9zBAZfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367223; c=relaxed/simple;
	bh=70lINbxMiuJr0DwKul2hLcahtcYekps2D3NWfzvPUqI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g0csNriKp3uaB19R2QHhR8VCs7P6qI0+XkZRLnJl9pfVwRqjWiURyurjPalbzBCMDB9liLS3/MqoGEbct0SprRUEGcpYIrwD8+i33Rmu1WnQiFaZMhpQkvQjeCpFTgPiiBq8S5RIoo2lUvBQc7SqpnBy9c4HwZo2gP9cm7FTIW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=juaKhib8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33953C4CEE0;
	Mon, 16 Dec 2024 16:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734367223;
	bh=70lINbxMiuJr0DwKul2hLcahtcYekps2D3NWfzvPUqI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=juaKhib8i5XlsjUEzHgmF0Nw7IUh8wLMcxaJgD9jtqOtrJKcweuBM5fE6yqdpPoKl
	 tCcdvvqNJ2RjWT6WtfJlJ9/X63DcamtPC1azcuiq/r04Ot3wIuEoJyvW2ibYn5iZ+a
	 rdqyNyer3mX7L/VXfF3avH01e9WozcO5uAIFubWbBiwRvM5jsPLS9FZlkIeBWtmk+G
	 sIaaA0coaW40RvxEGnrMRYSiNmMGtWZmaZ55alY/vdrTGxxeiUd60XjyKfmygUX+Dd
	 sUwJ6VhWrnwW6yZ1JMtkTQzm/wwsa95O6A8AaluZH5a1Q3FICPl0mb+p3FmK+nZRdy
	 xaxEaual5SZIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71A9B3806656;
	Mon, 16 Dec 2024 16:40:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH V2] f2fs: The GC triggered by ioctl also needs to
 mark the segno as victim
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <173436724000.272389.17352923573264150429.git-patchwork-notify@kernel.org>
Date: Mon, 16 Dec 2024 16:40:40 +0000
References: <20241204033113.4133027-1-yangyongpeng1@oppo.com>
In-Reply-To: <20241204033113.4133027-1-yangyongpeng1@oppo.com>
To: Yongpeng Yang <yangyongpeng1@oppo.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed,  4 Dec 2024 11:31:13 +0800 you wrote:
> In SSR mode, the segment selected for allocation might be the same as
> the target segment of the GC triggered by ioctl, resulting in the GC
> moving the CURSEG_I(sbi, type)->segno.
> Thread A				Thread B or Thread A
> - f2fs_ioc_gc_range
>  - __f2fs_ioc_gc_range(.victim_segno=segno#N)
>   - f2fs_gc
>    - __get_victim
>     - f2fs_get_victim
>     : segno#N is valid, return segno#N as source segment of GC
> 					- f2fs_allocate_data_block
> 						- need_new_seg
> 						- get_ssr_segment
> 						- f2fs_get_victim
> 						: get segno #N as destination segment
> 						- change_curseg
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,V2] f2fs: The GC triggered by ioctl also needs to mark the segno as victim
    https://git.kernel.org/jaegeuk/f2fs/c/e9a844f6e487

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




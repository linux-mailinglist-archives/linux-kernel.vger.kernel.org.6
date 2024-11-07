Return-Path: <linux-kernel+bounces-400594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 457719C0FA8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1FB71F23AB9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2421C21830A;
	Thu,  7 Nov 2024 20:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUarq3AK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805C7217F47
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 20:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731011430; cv=none; b=O4zjlk62HOmv/C8xHXpI9sPvZuyRXlHIR5rcAw2LL8fXLtUqTYNosYMw1Nap07I5YZh2k89H8R18Q17fehHBq7efHB5RB6XesCeVVeNvMDj/wQi+XsLtHtLUcs8Cs9Rn/YqGo4yNRU+SSTezOxf6lgJaAENKES/Xp1ailHtkyis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731011430; c=relaxed/simple;
	bh=XxyYH8l/Y7eByhFzcGMgEQOD9yhri/88JH4DpmxXwYk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jAGGwNHmvfYePquEwhkYAC45b8dH+D1JH5I0mhNe1792EFis4PcAgFCTzVoG9H24hy4HCxYSgoDhRn1visBWOHZ1KwhiZZPX+WJMB3iGV/cwH07oEpVMGrWaLgb61GdIPRszx3qQn1XuIWhJMRf7AF4LE34XtbtmucOZ1TLUm4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUarq3AK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04CCDC4CECE;
	Thu,  7 Nov 2024 20:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731011430;
	bh=XxyYH8l/Y7eByhFzcGMgEQOD9yhri/88JH4DpmxXwYk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LUarq3AKb8jlnULjdtYqmyie90C1OW/7a5JUaMkj3O8gAg3op3tuLVnz6r987YAGp
	 baF8o//7Q2s+A+tNsA+0lmp9B1WrYwyPBdUk+lrN+Vhnljk+JWi4G54Pf9Q7mbwfPJ
	 r2Sysk3eazw6blZFNC0I0vnogbWvme4gf8QdGuioe9/wjLiv13c1UIbFX56TnqMtbg
	 dDg22UaaLk18qCuaLyVio0hmHPQtaJAgGUu5R2wZoekzH/yq0pVbKf83+A5L0yyeTC
	 S+tEf15RmRi+4CnvVNU9Ll2/wqTY+YzQH0RQKhSSDw3jr0Hgy/Pei/Rb53RPGdqWXI
	 KFfZFR1h9s4QQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 719773809A80;
	Thu,  7 Nov 2024 20:30:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: modify f2fs_is_checkpoint_ready logic
 to allow more data to be written with the CP disable
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <173101143905.2084993.15250919555869983751.git-patchwork-notify@kernel.org>
Date: Thu, 07 Nov 2024 20:30:39 +0000
References: <20241025091823.2467074-1-hanqi@vivo.com>
In-Reply-To: <20241025091823.2467074-1-hanqi@vivo.com>
To: Qi Han <hanqi@vivo.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 25 Oct 2024 03:18:23 -0600 you wrote:
> When the free segment is used up during CP disable, many write or
> ioctl operations will get ENOSPC error codes, even if there are
> still many blocks available. We can reproduce it in the following
> steps:
> 
> dd if=/dev/zero of=f2fs.img bs=1M count=65
> mkfs.f2fs -f f2fs.img
> mount f2fs.img f2fs_dir -o checkpoint=disable:10%
> cd f2fs_dir
> i=1 ; while [[ $i -lt 50 ]] ; do (file_name=./2M_file$i ; dd \
> if=/dev/random of=$file_name bs=1M count=2); i=$((i+1)); done
> sync
> i=1 ; while [[ $i -lt 50 ]] ; do (file_name=./2M_file$i ; truncate \
> -s 1K $file_name); i=$((i+1)); done
> sync
> dd if=/dev/zero of=./file bs=1M count=20
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v4] f2fs: modify f2fs_is_checkpoint_ready logic to allow more data to be written with the CP disable
    https://git.kernel.org/jaegeuk/f2fs/c/84b5bb8bf0f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




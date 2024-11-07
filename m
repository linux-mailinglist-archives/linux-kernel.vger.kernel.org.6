Return-Path: <linux-kernel+bounces-400601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC5F9C0FBD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 029A7284CEC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0DF2194AA;
	Thu,  7 Nov 2024 20:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7SjE5uz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE0D218314
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 20:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731011445; cv=none; b=OP5qpTxeNevLFO1uTowZzBgLD4qNJ3bXSuIVJNwi0vJL3jOWC1lAQSU7lkyfLqdcJ+1Zsx85DAt5p8QrBZgmqjINhWVjy+P5vD0ZqQRxcm80aFFPwLlgbiv93WkDNqYWUXgAT/xGazPvIbJjjGunji5KlNoVAvDdOk7ralMa5Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731011445; c=relaxed/simple;
	bh=EYuGwPoXdKxAgBqaNBZh+1hyRDGNtUBv9XJ3c5kvPiw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZibEpxThrF/MwUd9+CJmK+h5FH1dkWuYbZ0Myx64yQdtEDv5XZb3Zzfk1PYe30+OiZqQCtE0dNHwGkfU1YOOPS/mCQE2ngwvGjNaASO+WsBqOAQeObkhY/9CPwNaOhdstJpPbD2Mw940C2rIotCnfAX7FB7LvxM475hy4wC4BcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7SjE5uz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4F2C4CECC;
	Thu,  7 Nov 2024 20:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731011444;
	bh=EYuGwPoXdKxAgBqaNBZh+1hyRDGNtUBv9XJ3c5kvPiw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U7SjE5uz79zkZdtsINzKOjTg987S4JtDbVfzXHQWRkysn3NF38Rj5IE2b81EqXd+a
	 k8lt66PjfWNNlamfVO83pCQ8VrXWZlrszmmnREZbLo9OvZmHHbqJsPoJ3q5allxHBW
	 ByMp5C8RoUxEjXfjGT59CLXNGIQ6fpAaIpPp3rFYDaSpQJS7AXoE0Ul3IyTJjCbhc8
	 UrTgR8yuEOblgrpZiAHhWBPUd9M0DOJ7Fx9c+D5cgHpf4yY5mgcKRm9q6JIr4SIbMv
	 PG5mZQDapg+oxmEYhaVFVwmL2UWZOe2pI6ZiyaHSlEovOFmrNjiIJdy/puoFA1YEpC
	 KbSV0KyzAcnkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB3593809A80;
	Thu,  7 Nov 2024 20:30:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to avoid potential deadlock in
 f2fs_record_stop_reason()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <173101145349.2084993.4012866127488813376.git-patchwork-notify@kernel.org>
Date: Thu, 07 Nov 2024 20:30:53 +0000
References: <20241022083623.2641434-1-chao@kernel.org>
In-Reply-To: <20241022083623.2641434-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, syzbot+be4a9983e95a5e25c8d3@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 22 Oct 2024 16:36:23 +0800 you wrote:
> syzbot reports deadlock issue of f2fs as below:
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.12.0-rc3-syzkaller-00087-gc964ced77262 #0 Not tainted
> ------------------------------------------------------
> kswapd0/79 is trying to acquire lock:
> ffff888011824088 (&sbi->sb_lock){++++}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2199 [inline]
> ffff888011824088 (&sbi->sb_lock){++++}-{3:3}, at: f2fs_record_stop_reason+0x52/0x1d0 fs/f2fs/super.c:4068
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix to avoid potential deadlock in f2fs_record_stop_reason()
    https://git.kernel.org/jaegeuk/f2fs/c/f10a890308a7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <linux-kernel+bounces-510413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDF1A31C7D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 04:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66A07166A2B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 03:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE391D6DDC;
	Wed, 12 Feb 2025 03:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4R6BsEs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F152AC148
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739329211; cv=none; b=rtKghY9Lua5oGRrzsxUNyLAF7vtXqcO8/YdUdqJLzEgGQiVYuEjLzlgfM/aSgHriozE+r2OImvR/HaBKbyqwNmbyWYfNgym3yKkNUh18MBH48tk7c7YwUQbBhUl8gh/+bQeJZNSswxr8BRGskyBdFw5/8Odppbts5le0XHBxrDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739329211; c=relaxed/simple;
	bh=s51PwjYiXgxoVGujUd7KagMqrOmjYUloowPDYEhHEn8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gt0UAZn5A8u/dvHrLut4VPbKVEo5TkwwP0aH4L5u8+BUplkVX7pfXYw3ubUJGs1W3aU4sYulXzTHP/Roo47bYOfEb1SP502nQG5H3wKHuDNzNbui44ZHxf+2MC2EhWTQJWPZ5GWNM2RyQof4dslHmgHI02cHzIMzan2I7LaWgKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4R6BsEs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A75BC4CEDD;
	Wed, 12 Feb 2025 03:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739329210;
	bh=s51PwjYiXgxoVGujUd7KagMqrOmjYUloowPDYEhHEn8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J4R6BsEsFngMhxMHInJf6ec0sVv19DPhPjwg0Wt2PslFHmUB6Haf2TvsznD/oZCnO
	 FNoGw8X4V1yPGnLY4T4RiGjvHaDvUf/ac+VIwUhNhySEulK0S3jtm+L/UK3L9uWStJ
	 kqHvAH8Yt/g3YNPc4uZ5u6Cw27ykbTqM3CzID6/g+t7bS8k7T3XomW4IDOdRoWhDyX
	 OPtZtvQDheUf7qJsNaWIoGYUxadrLbY3uKOR5RcEdojt9iomd9KcP3DqKPHsfD633O
	 qXSkNF3ffbPEzR0l5VGrTHUWYTI5bZzwy7xcC8EGkzcoT/I50cMDpQvzbwRrbQM41n
	 cGbDBfI7xG+PQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710FB380AAFF;
	Wed, 12 Feb 2025 03:00:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v3 RESEND] f2fs: add check for deleted inode
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <173932923927.82998.635511827116437277.git-patchwork-notify@kernel.org>
Date: Wed, 12 Feb 2025 03:00:39 +0000
References: <20250211071725.457343-1-chao@kernel.org>
In-Reply-To: <20250211071725.457343-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, syzbot+b01a36acd7007e273a83@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, leocstone@gmail.com,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 11 Feb 2025 15:17:25 +0800 you wrote:
> From: Leo Stone <leocstone@gmail.com>
> 
> The syzbot reproducer mounts a f2fs image, then tries to unlink an
> existing file. However, the unlinked file already has a link count of 0
> when it is read for the first time in do_read_inode().
> 
> Add a check to sanity_check_inode() for i_nlink == 0.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3,RESEND] f2fs: add check for deleted inode
    https://git.kernel.org/jaegeuk/f2fs/c/6e3019906688

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




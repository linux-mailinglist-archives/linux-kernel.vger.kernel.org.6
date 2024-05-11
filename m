Return-Path: <linux-kernel+bounces-176347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA238C2E3E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 02:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C2011C21564
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 00:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613315645E;
	Sat, 11 May 2024 00:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gL01o3wh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8941F12E47
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715388634; cv=none; b=nfiHN83ibcrRNxz6d8/csapPuYgCUi1Nmr9IVXxfB7j8WQm5xStuRLS8tarKzL5iS9lL8k9+Hxo6uvZH01maQ/O0hHUGR7gj2jEH2wTdurpupTpatchY+7t3fnfjk85Fk0pbXil0wnssPT59Wl3ksf0ZEmZDTG4AXBKMC1cqnUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715388634; c=relaxed/simple;
	bh=7+8lbIyUYwurNknKC/k7UJyRmT+SDoPbDodvcJKpVIg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rd0dQuXOukM2ZH+9UGoAdbUCYaeSsUXmSYWLnp9hd6iBqEhvHCcaJb3mT1HwMDiu6pu+Aj3tNtnFKpKUe2wbw9B885YtWQd/VM/NKxkMK2AIb3ZrtL6iWDrkZc+dYRz4t6jOGEYNDy0MYLPWOUe9MiY5vROiHTZl7fa64nEZfDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gL01o3wh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3DB18C4DDE8;
	Sat, 11 May 2024 00:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715388634;
	bh=7+8lbIyUYwurNknKC/k7UJyRmT+SDoPbDodvcJKpVIg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gL01o3whIHfyxjv1QztCCV3oNfoXLA9NFcWyXN6pEG0pauWrOApIiwDyHU79QlX0i
	 qm9fSOsNU3lmB/FuFpsh7Ei7rhby92LiNUkx4Dz5zg/DxWd5ceTtNzhrbVXAsbeb6/
	 A2KdtePislDGBftnBgfMzQaGJRHIaE2vCa1iC1aQ9AfCQSlqdq5+T0V/RVRZuSS5Sr
	 Ir0jQyIT5vAMeMjoEOb5yqcDX67wiOICPuJFK5yvR8BqQE7w5IjhPV90iUzo13UZAZ
	 6mj/vRLneTM9b1PrxhM7PrCsgQz9FDhzDfAxyb28GfGJPo1MYtOTkqJhVMoF89u/Qa
	 ELfH1YThSLOaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 336EAC54BA1;
	Sat, 11 May 2024 00:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v3 5/5] f2fs: compress: don't allow unaligned
 truncation on released compress inode
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171538863420.11229.14176789629360065013.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 00:50:34 +0000
References: <20240510033339.300331-1-chao@kernel.org>
In-Reply-To: <20240510033339.300331-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 10 May 2024 11:33:39 +0800 you wrote:
> f2fs image may be corrupted after below testcase:
> - mkfs.f2fs -O extra_attr,compression -f /dev/vdb
> - mount /dev/vdb /mnt/f2fs
> - touch /mnt/f2fs/file
> - f2fs_io setflags compression /mnt/f2fs/file
> - dd if=/dev/zero of=/mnt/f2fs/file bs=4k count=4
> - f2fs_io release_cblocks /mnt/f2fs/file
> - truncate -s 8192 /mnt/f2fs/file
> - umount /mnt/f2fs
> - fsck.f2fs /dev/vdb
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3,5/5] f2fs: compress: don't allow unaligned truncation on released compress inode
    https://git.kernel.org/jaegeuk/f2fs/c/29ed2b5dd521

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




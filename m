Return-Path: <linux-kernel+bounces-562262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C35BA6205D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 23:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A91848821BC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE721EEA29;
	Fri, 14 Mar 2025 22:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XoJJWhnx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09C41953A9
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 22:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741991399; cv=none; b=QrYsAZNO+BZmLyLlttrMFdxqgVy8hNiXI/IcsEh1VpSu68sctJdMYm6swYK2UUi6rvmLryMH6CJkwpOEIm80G4cHJQNfeJsrgcW+LICO19zFQtd7lAOdASacFYHpliKKF8XPoBQ+kinE8s8I+u1Rpelrr83LZdyq+Vm8hKr59dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741991399; c=relaxed/simple;
	bh=ZVN1gXmayXjszbtmz2X55ie4YM/+jBh6LnYxP8usMAk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DGWY9jBJfI0XwMJS1HCK8jBcew75LU+oQkX9Tch+teR9IfelYoL8wDBZmLERGygRviTec+q/7wg65fPlsl4n6TMUc1aYxrP3xrstJ1CuRXOlO8A5q3ufd1LVcXJcJFoQEfJHG24xFw3uEfPBrgMTHZx2V+ITrqzZwHVURNNm2Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XoJJWhnx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EDA3C4CEE9;
	Fri, 14 Mar 2025 22:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741991398;
	bh=ZVN1gXmayXjszbtmz2X55ie4YM/+jBh6LnYxP8usMAk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XoJJWhnxgbgyUBrWJ+Q0You4CIaneFkMJfxD57iTPu0ZYE4H6jNLvbZUbzoDzTmoN
	 tc81Nwwj8vA8n3CVuM8ljmX6Ux31/XiPVU9rse7sit70yDydfTlCdM3iOS+04LhdFu
	 vKPhDhYTvyld1Wg3iGnQw0MMoAw0huMsy6ELDjLHRBDKdhinv8O9P2OYC/PzCV+lAw
	 PAE3G1WMDLyL0RXO55CL9kkavgZal8n/6L6YehkFkP8XVxBQeUDfkjTtOponGswDBA
	 AH8jzZpWY7AipGXgsm7QdlKOid5oX/Yoag3erxpmMxzXtphsTGWpAxrFf5ICrZVrCf
	 YMlvmkWPtV+gg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F22380CFE7;
	Fri, 14 Mar 2025 22:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid atomicity corruption of
 atomic file
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <174199143325.2405968.380584551658170427.git-patchwork-notify@kernel.org>
Date: Fri, 14 Mar 2025 22:30:33 +0000
References: <20250314120651.443184-1-youngjin.gil@samsung.com>
In-Reply-To: <20250314120651.443184-1-youngjin.gil@samsung.com>
To: Yeongjin Gil <youngjin.gil@samsung.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, daehojeong@google.com,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 sj1557.seo@samsung.com

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 14 Mar 2025 21:06:51 +0900 you wrote:
> In the case of the following call stack for an atomic file,
> FI_DIRTY_INODE is set, but FI_ATOMIC_DIRTIED is not subsequently set.
> 
> f2fs_file_write_iter
>   f2fs_map_blocks
>     f2fs_reserve_new_blocks
>       inc_valid_block_count
>         __mark_inode_dirty(dquot)
>           f2fs_dirty_inode
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to avoid atomicity corruption of atomic file
    https://git.kernel.org/jaegeuk/f2fs/c/c60b556bfe0a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




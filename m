Return-Path: <linux-kernel+bounces-309464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B54C966B0D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 23:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 365AC282845
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 21:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BB11C1AB3;
	Fri, 30 Aug 2024 20:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOLi6IPX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC391C2303
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 20:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725051108; cv=none; b=KrUfq9uAUu1lzTQNbRN0papUZngUYlyVjXy38LAFhDXtOVLZZ40DZZDUqKeQbWlsO/hzx3fF9KOhE2hF1AIcQcLsFWg9ZMrR//mpg7iGSyasD9Tmv4ONXGmGLVnB6U660GUp98UbyrWB0JOrslwFUJfaLslDUEhFR1ur8zVryV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725051108; c=relaxed/simple;
	bh=lFgtvMYeTEGkEcxfD1ufZdF6r7CAqSj8sqzU1hMPTxk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hkNT5Wu/3MMg8ZyW0lLXabAenCdI0aXrhMwkgMmeQc8ARaFFaLpLqizD8dfWy8lQOMHtI8pUrU5xKhY3xXe+VT5j9gnGv7inTgXq9QjEfhBC7aghGwDTD9o/JLy5J0D7Pp7xLuaJJhrSV4YJHLFJT9Y0lRqxyXEYZdeKuxAf0m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOLi6IPX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9D0C4CEC6;
	Fri, 30 Aug 2024 20:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725051108;
	bh=lFgtvMYeTEGkEcxfD1ufZdF6r7CAqSj8sqzU1hMPTxk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sOLi6IPXBHwOs1i6+i/qT1eUM5PMdvgWIJKK5+7iQJjQ2vG1cz/s+cEAlUGFbbqWv
	 MmA9yuKrsZwIr6FjhuqDAv9AJwH3w1cG4fy2gcHm6isnKmWUkV49JbUJB58AFDuokt
	 iwrCA8/88SzItefPtvqNOK0HKcJFM6u/odBu7DXWXthR7dWu9ZC0AIAtQCdpfhzJet
	 9OrWcgvibzKrzyryqA1bFKAMTkrRzod7AZpfZSKUYdQY0+89Mlfk4CmRibqxNvHgg4
	 VJgfFhAYgLJAIj5MlCGDFTMMjMhzOMSzUU5G+p4TGnZJHqOmlSbJ+Hl/vqmq23455Q
	 /1GnIIL8uoBUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2FB3809A80;
	Fri, 30 Aug 2024 20:51:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2 8/9] f2fs: convert f2fs_read_multi_pages() to
 use folio
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172505110849.2712133.2597797946591195513.git-patchwork-notify@kernel.org>
Date: Fri, 30 Aug 2024 20:51:48 +0000
References: <20240814135059.802454-1-chao@kernel.org>
In-Reply-To: <20240814135059.802454-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, willy@infradead.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 14 Aug 2024 21:50:59 +0800 you wrote:
> Convert to use folio, so that we can get rid of 'page->index' to
> prepare for removal of 'index' field in structure page [1].
> 
> [1] https://lore.kernel.org/all/Zp8fgUSIBGQ1TN0D@casper.infradead.org/
> 
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2,8/9] f2fs: convert f2fs_read_multi_pages() to use folio
    https://git.kernel.org/jaegeuk/f2fs/c/0a823f608bfe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




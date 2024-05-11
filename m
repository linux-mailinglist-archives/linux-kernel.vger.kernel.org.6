Return-Path: <linux-kernel+bounces-176344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC628C2E36
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 02:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06CBA1C2153E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 00:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27871446B4;
	Sat, 11 May 2024 00:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiRuI7/Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFE212B8B
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715388634; cv=none; b=CUVTpY4Eqc36008YYVEKPyg0eDlBDwPWuRPIJhmGGNke9mLo9CkJQJ/PEcBq0wyVJMZndxdy+sSDTMkhHrGQ6AawnXWyPCTv/iJinMUbA0mAmAgvdXcXCfc/w+G2Twnb4wFXhAPob7lIz2Wd6N9VMr3cepdjS8ZGnWDtIGsI4nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715388634; c=relaxed/simple;
	bh=XfqFDi5MeOcdt7/akiT9d2506BZ52NdNgmwK4rVVh38=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aY5Saeb7gsrex5YtpLGexNMKcNbs7Sy5FtzThxCSvsJJ2gtTAgSZLF/+aqt+9MlEaZi950ohyYm/5heKnEwxVAEZjb5N6NP8/vzV8wDXEO/ViW75w68ByjkHpfxpnWoAtNBn5GQX+cSWNvP9PZq1gk/37bY9VIaG9mShioY8m8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiRuI7/Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18849C4AF18;
	Sat, 11 May 2024 00:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715388634;
	bh=XfqFDi5MeOcdt7/akiT9d2506BZ52NdNgmwK4rVVh38=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hiRuI7/QSR8GUi2SkeNi2OCMUVNWkE4vIV+8u2fRpcmIXOstrKvpMWUCrUVdiEI/1
	 NrXQ8h0wlaDc7DL5bZAt4+gEuO8VKKPjKVqDxwBt/b5JoIj66Nd1lc0fuAxSR8JxTT
	 xxzZ4vjilu/q1KHPQYay4kNpB6pVd+yOAvUBQMHcpASeUJabDTpEBaph2rNhAumoxX
	 mb6K3udAB2cnpP5kbsBJr3P26krV53O1P/hUuWBcBhf49sUjEcTO99riShIGTieNe+
	 VKVUZsGq5WDx376vtecw/bxLvWFviI7yH/hLiD1fk57nWvD9JrRQINVb4hTVh7fFcM
	 E73d6jELr1caQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D89FC54BA1;
	Sat, 11 May 2024 00:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2 1/3] f2fs: fix to release node block count in
 error path of f2fs_new_node_page()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171538863404.11229.12387715734074959132.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 00:50:34 +0000
References: <20240507033100.1044884-1-chao@kernel.org>
In-Reply-To: <20240507033100.1044884-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue,  7 May 2024 11:31:00 +0800 you wrote:
> It missed to call dec_valid_node_count() to release node block count
> in error path, fix it.
> 
> Fixes: 141170b759e0 ("f2fs: fix to avoid use f2fs_bug_on() in f2fs_new_node_page()")
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - avoid comppile warning if CONFIG_F2FS_CHECK_FS is off.
>  fs/f2fs/node.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [f2fs-dev,v2,1/3] f2fs: fix to release node block count in error path of f2fs_new_node_page()
    https://git.kernel.org/jaegeuk/f2fs/c/0fa4e57c1db2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




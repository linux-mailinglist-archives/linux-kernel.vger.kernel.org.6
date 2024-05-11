Return-Path: <linux-kernel+bounces-176340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C018C2E39
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 02:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E934B244E0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 00:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B194437C;
	Sat, 11 May 2024 00:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnoE+l9x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A591078B
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715388634; cv=none; b=XT19KPlEMxUurocMGgdz++wLAx6tJGDJs4Bj5pVZsr4UzLle9deVCt35ltuK31mquZ7dHzEqjP5sqe8wpddEY3DALeG8eCK6dV8H3efFLaKLyyglZa8G8roIEuYyfkNC1xx/X8t+yJnwFD8cg9KIFJpo2+29vubmHjhRsLOlL6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715388634; c=relaxed/simple;
	bh=Lm9UgoQ0EqF9fJAh2wacDF88Osv1XpcxXCrzsm+J6/U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k4wp4Ydynli0OledF02Y95A2Cty9gy1AWz7C9Xil6ui4jYIraiZKrS6btcDJY87c9phdmX4WdSIPZ8hyi874zjuw9VzGsqdi6JSrvatin0MtJqOBOl2ChoulzVnF956DzhzmCueeyv27elxIhz+k6VYTOm78n4YgPF6KMqvxZXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnoE+l9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1E87C4AF0F;
	Sat, 11 May 2024 00:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715388634;
	bh=Lm9UgoQ0EqF9fJAh2wacDF88Osv1XpcxXCrzsm+J6/U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BnoE+l9xyxXgcfa24Y4kVBpFJHKqH3v8qaEBFeylWyz2Y6fbwJTVTG9PJ90JwQzHQ
	 urNJyNTn6bEO4tDXR1LA5/XcwLGR39FDu8TxqriOhmguGqVn3ltv1EVs8w5vkVSVbb
	 aSeO6OQGlEJ+oeLoTG8QvvLtrBawVzRa7PpxRAuGQAev4FL2nf6DeD9xahmxJUViNY
	 VMei5Qxab/f5aM2u+OJFvEwe7daVR2KG0wdX0QjqiPXGB/qN7vZrJAdT2p5l68laVH
	 egPfiqvQNtes4ovSXJmELIjdbruzLIpUnBVBtpo9zKU485d+XrTJBN9D/R4fjH61ix
	 eJtGd2+CWNFOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D67DCC54BA3;
	Sat, 11 May 2024 00:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs: fix to release node block count in
 error path of f2fs_new_node_page()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171538863387.11229.8284477395784483205.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 00:50:33 +0000
References: <20240506103313.773503-1-chao@kernel.org>
In-Reply-To: <20240506103313.773503-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon,  6 May 2024 18:33:11 +0800 you wrote:
> It missed to call dec_valid_node_count() to release node block count
> in error path, fix it.
> 
> Fixes: 141170b759e0 ("f2fs: fix to avoid use f2fs_bug_on() in f2fs_new_node_page()")
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/node.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Here is the summary with links:
  - [f2fs-dev,1/3] f2fs: fix to release node block count in error path of f2fs_new_node_page()
    (no matching commit)
  - [f2fs-dev,2/3] f2fs: fix to add missing iput() in gc_data_segment()
    https://git.kernel.org/jaegeuk/f2fs/c/a798ff17cd2d
  - [f2fs-dev,3/3] f2fs: fix to do sanity check on i_nid for inline_data inode
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




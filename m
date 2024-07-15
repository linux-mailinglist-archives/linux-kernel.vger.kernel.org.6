Return-Path: <linux-kernel+bounces-252697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E16931701
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EBEE1F21F34
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2490418EFF4;
	Mon, 15 Jul 2024 14:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uAjBYiYQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684AC18EFE4
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721054432; cv=none; b=JujE4BE8ne4JhwMZ1zEhUaZmw58ZNRXZ6SwLlhwaxxUYg818a4aLcyZCmUHCL1wOJ13HNjHs4Y4fcsBaKuyHts+v/Gtmq42gwRC5yNOqfRgsYRN4gK0Y7K68xuPCAWfyT+YCy+5CV0hh0OEp2eyqYUIU1KHBizjX91xueojBn4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721054432; c=relaxed/simple;
	bh=vQbab53Kq/JDeM92ftMFSZ8LTcTos0iEWTuCkxnkP48=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ISJWLBO5KJpUwbEMTWIMr42GK9kqqTHo0WChTiVysMn8/dDKatzpApRasUrcGYcIaXxer6KgfVMbYl3Xem0Dt+/URZfYZmO4R2kgnMFbWmnLCl3/+4kIoCiatGJqRfp+5IP3jYDhZ2erfy4Ceg/t1uMAj4KtrgegeGtLjWOu1Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uAjBYiYQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49D25C4AF0E;
	Mon, 15 Jul 2024 14:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721054432;
	bh=vQbab53Kq/JDeM92ftMFSZ8LTcTos0iEWTuCkxnkP48=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uAjBYiYQFWAwJdSGIvuxpLuQBvj0QNLWvydvPwK1IUto2v8zgktZeEhl5TAnjRD6X
	 93YELIY8yDal+l0BcbGPL41W42V+gphF6VvmrP61x7XKLft+r2zUmlO2yASXlu37ob
	 YFa+MDLyPBkgrhV0bpJHdl+DvT9eAvS90MqatCoEK2VmdfNdPuRgVThLNvb8ee3KuA
	 PuVRI5Xx9iy+ZPaba+RVW20dBfivZR+3gD9toIbpp5MBvC0jq2ZFtLB5FKeEmv8x10
	 m1eWDjXU2wLlBB1BOlFVgrLw3/DttirtsyZlfENdQuMWjPintYprAkWJ62UGz0iUxC
	 9HzpJEtgfUrbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A3D8C433E9;
	Mon, 15 Jul 2024 14:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix start segno of large section
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172105443223.17443.17786881448481283569.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jul 2024 14:40:32 +0000
References: <20240708120407.2807639-1-shengyong@oppo.com>
In-Reply-To: <20240708120407.2807639-1-shengyong@oppo.com>
To: Sheng Yong <shengyong@oppo.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon,  8 Jul 2024 20:04:07 +0800 you wrote:
> get_ckpt_valid_blocks() checks valid ckpt blocks in current section.
> It counts all vblocks from the first to the last segment in the
> large section. However, START_SEGNO() is used to get the first segno
> in an SIT block. This patch fixes that to get the correct start segno.
> 
> Fixes: 61461fc921b7 ("f2fs: fix to avoid touching checkpointed data in get_victim()")
> Signed-off-by: Sheng Yong <shengyong@oppo.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix start segno of large section
    https://git.kernel.org/jaegeuk/f2fs/c/8c409989678e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




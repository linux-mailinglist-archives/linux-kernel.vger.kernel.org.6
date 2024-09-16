Return-Path: <linux-kernel+bounces-331125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F93497A8C8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 23:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CF7CB29C6B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 21:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC391667DA;
	Mon, 16 Sep 2024 21:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i24MWzel"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8DA165F1C
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 21:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726522233; cv=none; b=T4Twt3QX4NxgbPXvVWBsbH8uEaXiURnqbGUOuYHZErfipAG8TlvBiHHb2qYXhDmdSTpe9lLYK7j9nml4idTLJYaTb89DgY8W6uCgp8Zt4hNmO7XlcIYD5czaH0Py2sai5/ejaSEN06rxxImFcV7YX0Btx0TOCRKeJQ8k4pblLyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726522233; c=relaxed/simple;
	bh=TZJ1GBrIg57PXXnle/QW2Qy3nJQgUO8q3yXT38KZQdo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UGtsVH0N/k0I8yb8NUjTFzRJQB6LFL9JqoGSM/fQc8DzJ7kwzulbmHrHbP0Ds7UiAhy5PfD0LP74rabmPJS0BV7ILVKYSXrlR8MCPAmOEU6d4Amt3ji44HlTAJHWUmUQcYEBYeHcoBIeOls4XKDFpgqAlsxzS04/5E673CmBWSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i24MWzel; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE84C4CECE;
	Mon, 16 Sep 2024 21:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726522233;
	bh=TZJ1GBrIg57PXXnle/QW2Qy3nJQgUO8q3yXT38KZQdo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i24MWzelxezgQxSfirUpYeLLLHeYAzmNit8b91Xpdk7CBOSrx5eFZ49KRW550cHhg
	 IRtVfT7OlXttXRjQMvWL9ucN9po1OXyUZ1suGBO+8zR2ZhoES4l5K8i9oh+vJQ56jp
	 XrJmIbaZZCOaRild1wTlXp09nbs9fqybO7yYP3sXM6xT+GIv1DI1Z3vl6gs/Y5WuaO
	 53j3Qh9ZhNI/heP2pOvL3IFASIg1YXRLk2DNRJtCiWYmQ2F4eE8rlDBbTKATkKokFR
	 yT4FVgjGd0Ru32MgTpBxkJL4fHYuHwGSENKp1IgnkhASQFjhCaA8BuE82hbYPd6i/j
	 nT/0kZEEdQ+nQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2133806644;
	Mon, 16 Sep 2024 21:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to don't panic system for no free
 segment fault injection
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172652223449.3820990.9890904559085171308.git-patchwork-notify@kernel.org>
Date: Mon, 16 Sep 2024 21:30:34 +0000
References: <20240910011619.3582861-1-chao@kernel.org>
In-Reply-To: <20240910011619.3582861-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, syzbot+341e5f32ebafbb46b81c@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 10 Sep 2024 09:16:19 +0800 you wrote:
> f2fs: fix to don't panic system for no free segment fault injection
> 
> syzbot reports a f2fs bug as below:
> 
> F2FS-fs (loop0): inject no free segment in get_new_segment of __allocate_new_segment+0x1ce/0x940 fs/f2fs/segment.c:3167
> F2FS-fs (loop0): Stopped filesystem due to reason: 7
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to don't panic system for no free segment fault injection
    https://git.kernel.org/jaegeuk/f2fs/c/65a6ce4726c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




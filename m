Return-Path: <linux-kernel+bounces-176338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 434138C2E37
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 02:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A07ADB23E8C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 00:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1788744374;
	Sat, 11 May 2024 00:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6fM4V4o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF97101EE
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715388634; cv=none; b=FFZPVKQ4+4XhCyguD/ja/FcRagrT74w+5lNYLhvtSuLX7ACPkWBGwnRqJ7JOLdF3C2V1LpmoKhsGo1zJOngr1Ra0u1YMgNpMHa+GTGpoAFKOgkOZ+EUel5uICBcktBYyjB44GyeR5oTNI2m3/IiHwmppd2un2xjlBJ+QwoVC63s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715388634; c=relaxed/simple;
	bh=Awf1r273q7gGg010KfrhYdOCJKlxBHOXjUBot6jM11Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ORARtitVCwNKzJyTeTIinh5pJHdcYdQQc+HmW8RqohQkUXVjHKVxGRn5mrOqdDChBtiGUQZcAxy6/vdLWs2mz6X7CVstwvGw16RdbV8AKaSv02HGmnyltXN09JNW1zyJvQxSh1IrM3GOgFznNaUgnSef5W2CdTFepFtbW4MXaGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6fM4V4o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 220EEC4DDE0;
	Sat, 11 May 2024 00:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715388634;
	bh=Awf1r273q7gGg010KfrhYdOCJKlxBHOXjUBot6jM11Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y6fM4V4ovkebTJKUcT03MXxdriMrWkQ/KfUhOu2NmPj8mhLHJSWnkjH8oOKQz08WN
	 mrkDF6jQRtg5QOkS4JGg186iKFr4DgdgS34oSlLy7L6acGQlTaW6X+FfwPW6af2Qxt
	 1wCTl4ZONlP9d+BiNVXFc25dn+e2OQWHdAekbzdAL4NRepa3dgRnrMuEiOA4uzNUSy
	 iT3sfCoHh87Q4/E8OZfsj0vNuqAR2PYQ4MvCeMbFjCmX68eQD4P1bqtRiu2aKZNSvh
	 +WgzgDd7s5LVdqItmnZO/bK/Ca4jo9uxYL33NnEY4EvQ0fPhJA2iDxYlZhSkcoz/ab
	 Qz6+z3P1d+uyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16FBFC54BA3;
	Sat, 11 May 2024 00:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid allocating WARM_DATA segment
 for direct IO
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171538863409.11229.15179982798559586188.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 00:50:34 +0000
References: <20240426093348.377018-1-chao@kernel.org>
In-Reply-To: <20240426093348.377018-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 26 Apr 2024 17:33:48 +0800 you wrote:
> If active_log is not 6, we never use WARM_DATA segment, let's
> avoid allocating WARM_DATA segment for direct IO.
> 
> Signed-off-by: Yunlei He <heyunlei@oppo.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/data.c    |  3 ++-
>  fs/f2fs/f2fs.h    |  2 +-
>  fs/f2fs/file.c    |  5 +++--
>  fs/f2fs/segment.c | 11 +++++++++--
>  4 files changed, 15 insertions(+), 6 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to avoid allocating WARM_DATA segment for direct IO
    https://git.kernel.org/jaegeuk/f2fs/c/a320b2f08b3b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




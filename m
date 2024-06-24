Return-Path: <linux-kernel+bounces-227692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A8091558F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD8401F24584
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3233419F487;
	Mon, 24 Jun 2024 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAoOntiP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF2919EEC7
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719250831; cv=none; b=WZECA5sUtAu9K26F0q24hjoR4HOVmbzYLNQ1oRbsay64Z1hV4cQrQTIzIio5YZ8tvVwpNLNuzf0nihnlaLeS5j/FehLeIWMv4t9UXxE3KHjqnbXVIrf/qYWsT4vCcvpqMWLVwZgRA0oOaa3VOAcSu0j6gwxX7eucAbOVJAqnxdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719250831; c=relaxed/simple;
	bh=y+3HBYbLlNGdn/StePP7MdTMbYY+NAYSYK1c+0uNZTc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Eh1vU40qb4Z8Ox0yCdgF5vxwWldyYttjN1gvB96oEmv8670HnGdbSQmR+8AU7i+Tj57AstGh0GVRZ/LLwZ3RLLfx54nRyxRSwFSaDAPOOtY+ngu5KIabaHANTTDjZpqhmDWp0WMA87A9VYfUWUPstH5bTVjlf313knO9lD9PE80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAoOntiP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F5EAC4AF0B;
	Mon, 24 Jun 2024 17:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719250831;
	bh=y+3HBYbLlNGdn/StePP7MdTMbYY+NAYSYK1c+0uNZTc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jAoOntiPcsQXOh41dcTZrzJwHDLIccPkc442vDJm6/PQYfu/nXmMAN/CJxTBfZC5J
	 7bQy/+pGcFzN+tH6IZlX/jnhYi/+bMtyJK/u+qG0DIJOdSvRphlqX+aB0Lk8BSl8Q9
	 DP2T7F46I6GKkQ9P38868EtWy2ovPzia1l1gfWb+aExNDNw3JqdwCb6IT4aU8iMkTO
	 hjgRXqsY4zyV/CpkJBpa/ZhrpQPMdJHCcZRch9z05lhaNc5smaOP5YRlJdAPX5BGyJ
	 emxSkRK+bLzT2L9ctHJbYgzlk5jA12dZrqtH6OFJ/slQctABZdBKmYLft330iYWvQN
	 lSzrpDG/Xr9+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EF3AAC43613;
	Mon, 24 Jun 2024 17:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to use mnt_{want,
 drop}_write_file replace file_{start, end}_wrtie
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171925083097.4247.3362095080701103412.git-patchwork-notify@kernel.org>
Date: Mon, 24 Jun 2024 17:40:30 +0000
References: <1718271333-32179-1-git-send-email-zhiguo.niu@unisoc.com>
In-Reply-To: <1718271333-32179-1-git-send-email-zhiguo.niu@unisoc.com>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, ke.wang@unisoc.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Hao_hao.Wang@unisoc.com

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 13 Jun 2024 17:35:33 +0800 you wrote:
> mnt_{want,drop}_write_file is more suitable than
> file_{start,end}_wrtie and also is consistent with
> other ioctl operations.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>  fs/f2fs/file.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to use mnt_{want, drop}_write_file replace file_{start, end}_wrtie
    https://git.kernel.org/jaegeuk/f2fs/c/1efb7c8fd8bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




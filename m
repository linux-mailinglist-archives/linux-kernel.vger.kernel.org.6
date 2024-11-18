Return-Path: <linux-kernel+bounces-413266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE049D16AC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC895B29DDB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F18E1C2301;
	Mon, 18 Nov 2024 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tdose/qI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC671C1F32
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 17:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731949232; cv=none; b=P1S93ohrczrOwqmtIVlVb9cpieoZBHnK3EJubszn2sZAvSsGrY3sqcC6C02mfp0UiecQY8K+9MVF0tRR+3TVsrkfEwE6LkR8KbAVxJCExEdt9cgFqGjFJjozOGETCL2LG2wTn/9ERwVFngZOMOwLh82w7uooj8hwnJtM8cQkC5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731949232; c=relaxed/simple;
	bh=pt9p5kclLLeN/+fpCGfjargQCDSHIstJnKgShg8P1Q8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HegSzq3G9H77zTtpJ0Ru68swS8k4U7P7ttQunqRQ7vTp/QBmBibQQbPrlXyn0yY02eThRdC9Z8cIpEVWNONOad8yQhCQXlkqh1/2outn9c6ejKgc5Kxk84KjGyg3Jbf05UvzbeDHhlXYPumPe4o/AuXsAfHn1fxWaYTqaIzUu9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tdose/qI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5BCC4CED6;
	Mon, 18 Nov 2024 17:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731949231;
	bh=pt9p5kclLLeN/+fpCGfjargQCDSHIstJnKgShg8P1Q8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Tdose/qI25BUA+KS0D+KQ10UKrzpLf97p5KcnkjEdRvKzYjSDnTOgpXWUX2ACXRmw
	 O6o/q5TVUMm/9mmCtiqGA7zNeQ9w3neOm3bATB7RvslktDm4enFOgZ5gn3SjGu/M/V
	 6BRgQ/yJXPl3jFNEL9yfKd1wtxwsRr7WiFOJbYWXIq0inlhmKV0LxV4C1tFVAL1Uu/
	 G+PoA/GGy3n77Zd3gjEmHQMNXBQxbZvsE6r8znmMUZoK+6KQVWUPPMGW5sBdC0WFKt
	 U17gxT8Q24dHYl0DlQs5jvyyere0tLQAgR49aS/2EsIVt+SmRWGBRaq6Skf4jJggD+
	 IEXCzFnwtfrZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DA03809A80;
	Mon, 18 Nov 2024 17:00:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to map blocks correctly for direct
 write
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <173194924303.4109060.813014636748252195.git-patchwork-notify@kernel.org>
Date: Mon, 18 Nov 2024 17:00:43 +0000
References: <20241104013551.218037-1-chao@kernel.org>
In-Reply-To: <20241104013551.218037-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, oliver.sang@intel.com, linux-kernel@vger.kernel.org,
 chrubis@suse.cz, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon,  4 Nov 2024 09:35:51 +0800 you wrote:
> f2fs_map_blocks() supports to map continuous holes or preallocated
> address, we should avoid setting F2FS_MAP_MAPPED for these cases
> only, otherwise, it may fail f2fs_iomap_begin(), and make direct
> write fallbacking to use buffered IO and flush, result in performance
> regression.
> 
> Fixes: 9f0f6bf42714 ("f2fs: support to map continuous holes or preallocated address")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202409122103.e45aa13b-oliver.sang@intel.com
> Cc: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix to map blocks correctly for direct write
    https://git.kernel.org/jaegeuk/f2fs/c/5dd00ebda337

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




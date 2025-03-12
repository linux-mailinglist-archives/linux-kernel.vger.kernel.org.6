Return-Path: <linux-kernel+bounces-557997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC68A5E025
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BD7616D866
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54E82586C2;
	Wed, 12 Mar 2025 15:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxvmRpLZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364D7250C0F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792800; cv=none; b=ZwqG1lhJHEFofcz/FofV8uGO+lFAr8l/U+GHMiD0hXxE+uV/dXahk+TsCgXLkb+zyv0iXtTXgNhyfteeWu9kavuTw4eELRkX/luVoZJHtHGKMMKzupSe9cQ8OZXLISd39nQ4eW/kn4YzubjM8r89YH9C0XxX7oVByQeimME01pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792800; c=relaxed/simple;
	bh=IxlcF8BZP06JVhdofL8W/C0CQCL3FTai5k9b9g87Tnw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f3zBGNRsjRtGMjJSwtepDaRio0W3sw7N7ZryKnjZ9uE2kG9jZK2+DhxaRtNvF02ARrKTQ5rA8YEUIyPhfxFvLUy4hB8gMp3eATa5KwIq5yEpXQP+mlvLBd5tycOOle6hp2psuq251/Vl0BKs+/BuInfuQAu13FtPQqs28U1S2WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxvmRpLZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BC1C4CEDD;
	Wed, 12 Mar 2025 15:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741792799;
	bh=IxlcF8BZP06JVhdofL8W/C0CQCL3FTai5k9b9g87Tnw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JxvmRpLZnuI4PFTLQTjOt8GyFaujiPyHJZ1dNdx9+LLyc6P7AAV2SLzojTlGvyyVu
	 Y3vzDZPRcTM/Y96vY/ni9fDF9sDHcaLBuUCzjLsA8JDLtocInj7M6gi3pu4wU6O1TP
	 pDNKnxvNc2J8fJyn1sjjEeciYGDCtZ3bq6i0D8mzKGs4ZJ6+Jivs2IvKxi9o8ZNkkG
	 Zat6u9poaSOImz9GktANikOHug3StTn9DmOG0j3va0WFtRlfNJhciqiLe5iT7G2zuo
	 DQ0+DqFr9vhS+Zn1jnoFl0C0nv43zcxVTG2swQ0iwMvSd8kXqi0lu+zmqN+vaAox8o
	 5ZKYq5zgDgINA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EB5380DBE4;
	Wed, 12 Mar 2025 15:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid running out of free segments
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <174179283306.831874.2260893071160537539.git-patchwork-notify@kernel.org>
Date: Wed, 12 Mar 2025 15:20:33 +0000
References: <20250312090125.4014447-1-chao@kernel.org>
In-Reply-To: <20250312090125.4014447-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 12 Mar 2025 17:01:25 +0800 you wrote:
> If checkpoint is disabled, GC can not reclaim any segments, we need
> to detect such condition and bail out from fallocate() of a pinfile,
> rather than letting allocator running out of free segment, which may
> cause f2fs to be shutdown.
> 
> reproducer:
> mkfs.f2fs -f /dev/vda 16777216
> mount -o checkpoint=disable:10% /dev/vda /mnt/f2fs
> for ((i=0;i<4096;i++)) do { dd if=/dev/zero of=/mnt/f2fs/$i bs=1M count=1; } done
> sync
> for ((i=0;i<4096;i+=2)) do { rm /mnt/f2fs/$i; } done
> sync
> touch /mnt/f2fs/pinfile
> f2fs_io pinfile set /mnt/f2fs/pinfile
> f2fs_io fallocate 0 0 4201644032 /mnt/f2fs/pinfile
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to avoid running out of free segments
    https://git.kernel.org/jaegeuk/f2fs/c/f7f8932ca6bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




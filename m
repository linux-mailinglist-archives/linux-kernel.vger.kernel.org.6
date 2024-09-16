Return-Path: <linux-kernel+bounces-331124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB3F97A8BD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 23:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 392F81F26A62
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 21:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2C315CD6E;
	Mon, 16 Sep 2024 21:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C47j5NID"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159935588E
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 21:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726522232; cv=none; b=ZRn/INVeA/xgzi0Ph105GfnbTeDInJqqpyUQpK62lueaomqn9xOdcJPCF4RkICU94YEtBkujzBuIJJfNgvM/FvD2S9eDT+nb/RpLw0OzXjQcXfQS7IT6uUTKdlSVMQxeoO9qo+8s0yiARni40jSR0behwSRhor4I5ZvRTE1wn2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726522232; c=relaxed/simple;
	bh=f6cGudW8bpYB1h8dVvi/iSMGcZhutHcSIscuvvjHLEA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iIn9FYzyGmSzBczVK90e3bEzzjTPkuYyVl4Gt2x45xPR4JGH4pqZsS67oy1sZrhr4IGCkJeHaF7E82ofMlrzmkAe72qDmuF4hrcvEknOSwYA5ZTKulP1gozYIXzwcw5Rh1To34TGKfoZU9EaS1zsomWHMPnRVW146Z7XQ51eT/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C47j5NID; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA99C4CECF;
	Mon, 16 Sep 2024 21:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726522231;
	bh=f6cGudW8bpYB1h8dVvi/iSMGcZhutHcSIscuvvjHLEA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C47j5NIDmrzDc3lovwDrQdBL1QO4Nx3FaDGvG7rVGNTBZrMfIFVMip3Uv9kM/knkw
	 0qcGEVvj9cFEC5exqZWJQiyzZyJJEAEZW3yj61EIm7D3o6bVqxstObxa7Qw8OuL4jJ
	 wxqUvmupkGYa64lIzLFdpouQo9n6H2rR4k70qV5m2cY4NwPFQ807bwa1uON4rBP79v
	 0zdE/umc3Eh6qwYQ8rLkHENLW45L3rc9gICSy3rLcZ5mPcBD3Jn4UPxWZjvuqhUkbn
	 e8UIRKbkz3nnqcT5NunwS81eLpcPGZ7pA+wGzz0pW56TQxsWJwF5CP9OC6QuwPlQfc
	 ekHCPJ34uVBhA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C223806644;
	Mon, 16 Sep 2024 21:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2 1/7] f2fs: make BG GC more aggressive for
 zoned devices
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172652223303.3820990.12818974880515327403.git-patchwork-notify@kernel.org>
Date: Mon, 16 Sep 2024 21:30:33 +0000
References: <20240909221946.2004046-1-daeho43@gmail.com>
In-Reply-To: <20240909221946.2004046-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com, daehojeong@google.com

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon,  9 Sep 2024 15:19:40 -0700 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Since we don't have any GC on device side for zoned devices, need more
> aggressive BG GC. So, tune the parameters for that.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2,1/7] f2fs: make BG GC more aggressive for zoned devices
    https://git.kernel.org/jaegeuk/f2fs/c/5062b5bed432
  - [f2fs-dev,v2,2/7] f2fs: introduce migration_window_granularity
    (no matching commit)
  - [f2fs-dev,v2,3/7] f2fs: add reserved_segments sysfs node
    https://git.kernel.org/jaegeuk/f2fs/c/4cdca5a904b1
  - [f2fs-dev,v2,4/7] f2fs: increase BG GC migration window granularity when boosted for zoned devices
    https://git.kernel.org/jaegeuk/f2fs/c/2223fe652f75
  - [f2fs-dev,v2,5/7] f2fs: do FG_GC when GC boosting is required for zoned devices
    https://git.kernel.org/jaegeuk/f2fs/c/9748c2ddea4a
  - [f2fs-dev,v2,6/7] f2fs: create gc_no_zoned_gc_percent and gc_boost_zoned_gc_percent
    https://git.kernel.org/jaegeuk/f2fs/c/9a481a1c16f4
  - [f2fs-dev,v2,7/7] f2fs: add valid block ratio not to do excessive GC for one time GC
    https://git.kernel.org/jaegeuk/f2fs/c/e791d00bd06c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




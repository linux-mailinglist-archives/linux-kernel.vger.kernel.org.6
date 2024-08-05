Return-Path: <linux-kernel+bounces-275464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED0C948610
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A16EE1C21BC5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 23:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9FD17623C;
	Mon,  5 Aug 2024 23:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jy4+WdYz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6218416D9DD
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722900652; cv=none; b=MZJEvASMEuISrLdUaRGBRyvayTYYiNx0mGXL2DmT6I2iSxc7vrb5i7Jo2Tr2QrHW88PPj3oXQ60bSt9T7OGYGsYtwnKRky6nzZsE7ZmJZznhZdNcDJ9yYKGs2izONG9eIzdjni6m+im3N62ZJ64kunONIRRudf2jojY/TNmatJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722900652; c=relaxed/simple;
	bh=JB9tHugh5uz1t6hACHVOqtzb1kHKTIVf1m+7h7eV5Uk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qdOXzaV/EEJN7QfB4oIh4RxIiGXFnEdIFRVsjlaAiAQrWaQgMiQ6AdeVZC9StjK2Qpkvsn614oqMt3+iAsxt1rS7P3JWNxGNnBzv0+wKz0ify6SeEldbQ+n27rLD5l6JiFWrCLK337nDJ5cW968BlhbFn4B7qN2UMcFbFYJdArA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jy4+WdYz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2CCE8C4AF62;
	Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722900652;
	bh=JB9tHugh5uz1t6hACHVOqtzb1kHKTIVf1m+7h7eV5Uk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jy4+WdYzgUpAAveKz+mEPJ8TCm1ihX4hZd7WwbqGxCXWYN7P30ZRJzo0GcKXjb6bW
	 AhgDk0SQTWgRZxnbXRPhHpSo8d7p/ivP4NS582WZSmZ7JEKH9O0Cqd1L5qb1eNcABC
	 k1xBa0PM8J2UlUSp41wOKDP/HkJ7TphzNXkx2EVlLp2tekZAh5SfZZHGGg2kRF6TTI
	 c2XFbtkfhJht3sldXIVRjLyeCqxuD/dKvWpiNek2xbjPk9K90FdZbdb32PdburL8N2
	 zLGgiE36yPE1c32OZ4X9WtG0YaNXHjadEYoNZQfDvdIbWP0A5dY5vlc6jmbG4yFo6N
	 UyCTTKpDjH85A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21668D20ABC;
	Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: fix to avoid racing in between read and
 OPU dio write
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172290065212.2803.17197676609534608059.git-patchwork-notify@kernel.org>
Date: Mon, 05 Aug 2024 23:30:52 +0000
References: <20240627071521.1557830-1-chao@kernel.org>
In-Reply-To: <20240627071521.1557830-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 27 Jun 2024 15:15:21 +0800 you wrote:
> If lfs mode is on, buffered read may race w/ OPU dio write as below,
> it may cause buffered read hits unwritten data unexpectly, and for
> dio read, the race condition exists as well.
> 
> Thread A			Thread B
> - f2fs_file_write_iter
>  - f2fs_dio_write_iter
>   - __iomap_dio_rw
>    - f2fs_iomap_begin
>     - f2fs_map_blocks
>      - __allocate_data_block
>       - allocated blkaddr #x
>        - iomap_dio_submit_bio
> 				- f2fs_file_read_iter
> 				 - filemap_read
> 				  - f2fs_read_data_folio
> 				   - f2fs_mpage_readpages
> 				    - f2fs_map_blocks
> 				     : get blkaddr #x
> 				    - f2fs_submit_read_bio
> 				IRQ
> 				- f2fs_read_end_io
> 				 : read IO on blkaddr #x complete
> IRQ
> - iomap_dio_bio_end_io
>  : direct write IO on blkaddr #x complete
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3] f2fs: fix to avoid racing in between read and OPU dio write
    https://git.kernel.org/jaegeuk/f2fs/c/415ea641b020

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <linux-kernel+bounces-309460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC5A966AE9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 22:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D57E1C213EF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289041C1740;
	Fri, 30 Aug 2024 20:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pic5yn1z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631AB1C1732
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 20:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725051102; cv=none; b=m2rKSWgoyV2sO6Uh6uDtbbkS6nfSk+c4+uwVtQPQotdt+nCpvJwWXGAyS/F1OgG8Tdnom8twaTy47cnMhAXgXVASqBNvbLJRErzBjzn64DpXQbCXYxHy0or/nxhVtUjoO/7Y2AyC2FZYZtGQ/zUz+pHI5vTxDBGHBmT7S7yb7cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725051102; c=relaxed/simple;
	bh=Qch9L6aepwg9HHdR6rD1CcwmmNNUmm8PHEmpjGDF7JQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O66vuZAdG1H/ifdZh8OQiz1LCZmayK4xClkCxY5lo4uD6d22V5lyylfmjQvd/qEUXaK+csET6ZM1addRGPuTjCwQMJucOu5wNq3iDQi0dMktgyAc72WV0LDeXfplwxZgiCK3yNeNK7zXwvvRt4tAkc221FXKik3T3JIU8HkVHmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pic5yn1z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401FFC4CEC2;
	Fri, 30 Aug 2024 20:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725051102;
	bh=Qch9L6aepwg9HHdR6rD1CcwmmNNUmm8PHEmpjGDF7JQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Pic5yn1zaJj/nKjnzXSwwa7t2f/n5uIpVdf25w6TTN2oaXLONE2Y2XJ8frzuQGabK
	 n1FOmX6SYcQxIw7EoH1djHyzKLVg5YuqPUaVVE4kWDrc792qbY31iyHDcS4b7eP6WX
	 QBIP9VUT4G5jlCUD79mbVfn3wbtKgIMbzwYUdn1HyyabQVJlAoma9kQ6ZHsmQmcJS5
	 1xANNlzikR1F17fRkXG0+AFAQI0IlwYERY7K6HZh54YhYloQzCAicItH4tdsDTRxJs
	 LtltZYXXpgcF1ONXvvEEriiJzB2Zggv4n0hHtsUTH9r8ivESPVqlzjnhUC3QrqK3m3
	 oqOYyZwxw+3DA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE583809A80;
	Fri, 30 Aug 2024 20:51:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v3 1/9] f2fs: convert f2fs_submit_page_read() to
 use folio
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172505110250.2712133.5954239958085668419.git-patchwork-notify@kernel.org>
Date: Fri, 30 Aug 2024 20:51:42 +0000
References: <20240820145507.1372905-1-chao@kernel.org>
In-Reply-To: <20240820145507.1372905-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, willy@infradead.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 20 Aug 2024 22:54:59 +0800 you wrote:
> Convert to use folio, so that we can get rid of 'page->index' to
> prepare for removal of 'index' field in structure page [1].
> 
> [1] https://lore.kernel.org/all/Zp8fgUSIBGQ1TN0D@casper.infradead.org/
> 
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3,1/9] f2fs: convert f2fs_submit_page_read() to use folio
    https://git.kernel.org/jaegeuk/f2fs/c/f5e3739942b5
  - [f2fs-dev,v3,2/9] f2fs: convert f2fs_write_begin() to use folio
    https://git.kernel.org/jaegeuk/f2fs/c/f13c7184e62e
  - [f2fs-dev,v3,3/9] f2fs: convert f2fs_write_end() to use folio
    https://git.kernel.org/jaegeuk/f2fs/c/357dd8479f8b
  - [f2fs-dev,v3,4/9] f2fs: convert f2fs_set_compressed_page() to use folio
    https://git.kernel.org/jaegeuk/f2fs/c/4713b14f107a
  - [f2fs-dev,v3,5/9] f2fs: convert f2fs_do_write_data_page() to use folio
    https://git.kernel.org/jaegeuk/f2fs/c/609c7375350a
  - [f2fs-dev,v3,6/9] f2fs: convert f2fs_write_data_page() to use folio
    https://git.kernel.org/jaegeuk/f2fs/c/75428dcd4d2e
  - [f2fs-dev,v3,7/9] f2fs: convert __write_node_page() to use folio
    https://git.kernel.org/jaegeuk/f2fs/c/62b691af1a66
  - [f2fs-dev,v3,8/9] f2fs: convert read_node_page() to use folio
    https://git.kernel.org/jaegeuk/f2fs/c/e381d92a035a
  - [f2fs-dev,v3,9/9] f2fs: get rid of page->index
    https://git.kernel.org/jaegeuk/f2fs/c/c6f1758f7a68

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




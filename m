Return-Path: <linux-kernel+bounces-545133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C2CA4EA4F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58A0B3B9272
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C326A27810E;
	Tue,  4 Mar 2025 17:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfjNTE+e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCB427811C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108216; cv=none; b=qvlwlvEzzoQN3eW968PMNs64A30ootSRuyDcluW1WIOZA3dCVhynquR/gSdhb76wkoVC1h9qVauSdPocTKF0C5rInBXC1HWldUXotTMOhT45gj0mJ7nEn0TIFX59ua5jfTXr175/81yF0dvihNLD6hqEguOVtiDSx1T5BXFh1Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108216; c=relaxed/simple;
	bh=o43ff7R4e3i7w6mMMmeiN5+e4slUZu+u/De0cuXcQOg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ndGI5ooiFh7xVYlsv/v5TKE7sYNNNcnlMRomDV+YCJfO9XeMNKHcK/mEuVdLIciPCmhqkc0XglRs7pbnKLigExbxIN0dtqsgI4r6XzBn7DQLkq/29xoYucbSP0Xk95N1OvLtkZP1pExSc10xChxF9QnBvQ4+KKY2irI4CSsMIf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfjNTE+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFC5C4CEE5;
	Tue,  4 Mar 2025 17:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741108215;
	bh=o43ff7R4e3i7w6mMMmeiN5+e4slUZu+u/De0cuXcQOg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hfjNTE+eToFjy7+bAUje04CdMveohZzVgbytFafuHToqn3jeT9uemTB+93vHWPLk/
	 DeZGSkHmw1huQ/PhYeFkhrQvJN/GS7uSPXhaxOGz9W7cDrQhvueQ3optJ6MbFKi35r
	 2K1O5W7s9pKkoFzcH+HrLcQnt/0YJ9AoKf6c0SSX4HsENdODfuNb3H3XBMez3RNNlB
	 4bMv9WGtdRqo1JBVYSTCpIAkVsTLmXO951Sj64/bjS5dLpwiytIyqpArYBBxox+/sm
	 0CSMBbxNPkVZwQpgrS8utkkvqlqCdPYJy/coaurn4QQvxQxAzz+y/O5z9Oiaz3xFmG
	 SM99zlZ7q6ekg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF79380AA7F;
	Tue,  4 Mar 2025 17:10:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs: do sanity check on inode footer in
 f2fs_get_inode_page()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <174110824849.224349.8255576653519442579.git-patchwork-notify@kernel.org>
Date: Tue, 04 Mar 2025 17:10:48 +0000
References: <20250303035423.1357211-1-chao@kernel.org>
In-Reply-To: <20250303035423.1357211-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon,  3 Mar 2025 11:54:21 +0800 you wrote:
> This patch introduces a new wrapper f2fs_get_inode_page(), then, caller
> can use it to load inode block to page cache, meanwhile it will do sanity
> check on inode footer.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/data.c   |  6 ++---
>  fs/f2fs/dir.c    |  2 +-
>  fs/f2fs/f2fs.h   |  3 ++-
>  fs/f2fs/file.c   |  2 +-
>  fs/f2fs/inline.c | 22 +++++++++----------
>  fs/f2fs/inode.c  |  4 ++--
>  fs/f2fs/node.c   | 57 +++++++++++++++++++++++++++++++++---------------
>  fs/f2fs/node.h   |  6 +++++
>  fs/f2fs/xattr.c  |  4 ++--
>  9 files changed, 67 insertions(+), 39 deletions(-)

Here is the summary with links:
  - [f2fs-dev,1/3] f2fs: do sanity check on inode footer in f2fs_get_inode_page()
    https://git.kernel.org/jaegeuk/f2fs/c/770648dd6abc
  - [f2fs-dev,2/3] f2fs: do sanity check on xattr node footer in f2fs_get_xnode_page()
    https://git.kernel.org/jaegeuk/f2fs/c/1078ec609e0a
  - [f2fs-dev,3/3] f2fs: introduce FAULT_INCONSISTENT_FOOTER
    https://git.kernel.org/jaegeuk/f2fs/c/4116a6f1172c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <linux-kernel+bounces-556888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A30A5CFE4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F096A7A9EC4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B81C2512D1;
	Tue, 11 Mar 2025 19:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qd5FpiOZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621F0215F49
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 19:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741722602; cv=none; b=IIFKDcUFsQ4rBzXRaBJMi07Shtzfc547EDJiwAnhqypzIx2runqksIdBss79eziCYjLbbIgne2o5p9s+DSESKoiVacsNovbcE67yuS5qy2Nrja+hYRtzXgCpajgKi3G1HDF5BcLaXZfsYeS2pf4+yCm9Xfnc+EJtPQrWykZXeoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741722602; c=relaxed/simple;
	bh=zhU+YAurbMexCiQ10t2HtbZUnnw8b93XeIzc9Zk2DCU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ia+LJiSVuBWbugU4+0pFu5FDSOL1Z3Y90sPeokXkgfNVJcLXQ9E3VFVR49pE/UFM/yJxdpDUJcK3DaMW2sqT5mFt2bWAW4hcz/Q/8SSFECJlZr4VBFpzr71K/03To4YLSdIHpYt5WOHoAxmR8FTieTc/EQ+wGJze0qYBA9sGIk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qd5FpiOZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FB9C4CEE9;
	Tue, 11 Mar 2025 19:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741722601;
	bh=zhU+YAurbMexCiQ10t2HtbZUnnw8b93XeIzc9Zk2DCU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qd5FpiOZHOYsrt025Vohs7QvIlnKFX5vbbkQzrZVhxgZ76+GjIORlYzcBdoVQOtqm
	 iDdvlGKAGbe+r8fEU7NvKXYKfQynMIPCREQZQC+TLw/K+VjVVWJd1T6RW9IDSQANv9
	 PAMjUDe6k3EZS5vA4RbyaEy1zjf6aDJ9QW45KNcAwOiStcPtkzsQyLN2e97PG0PtgJ
	 Al3TPoAtAzUbhxcic032SUVuIWHbZqrAemy5eDTMlh8gLpPfj33xuVHHDXw3qwKgfi
	 Jwq62Bx96+P7cWBzApcMUnSdN0ONJGm/itFuejO0p89upjZTHHoSwI9b0M+L9HEbiw
	 5TAUheZUIta7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 348BD380AC1C;
	Tue, 11 Mar 2025 19:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2 1/3] f2fs: do sanity check on inode footer in
 f2fs_get_inode_page()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <174172263600.214029.2439800128963864972.git-patchwork-notify@kernel.org>
Date: Tue, 11 Mar 2025 19:50:36 +0000
References: <20250305091148.2086015-1-chao@kernel.org>
In-Reply-To: <20250305091148.2086015-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed,  5 Mar 2025 17:11:46 +0800 you wrote:
> This patch introduces a new wrapper f2fs_get_inode_page(), then, caller
> can use it to load inode block to page cache, meanwhile it will do sanity
> check on inode footer.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - fix node_type in f2fs_get_inode_folio()
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
  - [f2fs-dev,v2,1/3] f2fs: do sanity check on inode footer in f2fs_get_inode_page()
    https://git.kernel.org/jaegeuk/f2fs/c/1cf6b5670af1
  - [f2fs-dev,v2,2/3] f2fs: do sanity check on xattr node footer in f2fs_get_xnode_page()
    https://git.kernel.org/jaegeuk/f2fs/c/2aac2538a97d
  - [f2fs-dev,v2,3/3] f2fs: introduce FAULT_INCONSISTENT_FOOTER
    https://git.kernel.org/jaegeuk/f2fs/c/1788971e0bfa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




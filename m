Return-Path: <linux-kernel+bounces-176336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6938C2E2F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 02:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19AFD1C2123B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 00:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78221643A;
	Sat, 11 May 2024 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgQp9IR+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A3EE576
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 00:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715388634; cv=none; b=I0a1EJPiS9dsoRYMeuTW56DaehgVnN8fSy+97/bZWA6jIxKPVmIaF4K2XvKt8CS+6f7NGifBwZ6RteH9zsPwSRTYFZHjf4dnhdTp2yG5upcm3bWeyJzJBsQz+b4tYp99vdNdKU0e5mv+tRcOZ2CcFF8Yurooq6cTxyEez7J9wI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715388634; c=relaxed/simple;
	bh=UKEe94oVWtgpVuykgNAFFHHsNeG3y+btMC3fbZTqcSE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Wx/yZaI7aVQ5ffnR+r+VUODdDJCl1FM84UZ9xe7kh1/6LPIGF2XT3WAnAMHUtkjsnMduL/V+SEY4nSZpEEHZ3ZgVFnvB0ZGmA8YipJBcfrmKJWT70SXL27qGwv+iBpjuqvAoVfyMMUF4zfpFjAUFZtR9HEPsDatT8Bvngab6dMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgQp9IR+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C473AC32781;
	Sat, 11 May 2024 00:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715388633;
	bh=UKEe94oVWtgpVuykgNAFFHHsNeG3y+btMC3fbZTqcSE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kgQp9IR+Juw1eQWt1C2pVudkxlg2safWvJve6KWaG4JbnOc/ZcpnYik10EJfTXZJv
	 EMdZOxIvNN9kUPJFlUwwus83Cwh3nu+zOC+nUTISVuvfBdVuLR78f3MkiqQ91qD8ZS
	 CmCfhCULoVGJOuNLtTmZVadiaj1g1j6mjZ3W5J1wGMU9A1xZ4UVA9qbRWYFZ3mZ9bX
	 v+IaEWYPko8jhOUDteuXagZgf6D2oSiN8bWuVU9oc7IMDRJpCO0Tnwt8P7aSkmA66Z
	 ajcd2oW3ZSQi/3+xlIaQurGTIc54SJQQkS6aJIorjDkS/xyFGM85fz4eSTgC907I4s
	 HxxpLFJLmwuag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AB1B1C32759;
	Sat, 11 May 2024 00:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to do sanity check on i_xattr_nid in
 sanity_check_inode()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171538863369.11229.7576182573841260398.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 00:50:33 +0000
References: <20240425085838.4032657-1-chao@kernel.org>
In-Reply-To: <20240425085838.4032657-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, syzbot+3694e283cf5c40df6d14@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 25 Apr 2024 16:58:38 +0800 you wrote:
> syzbot reports a kernel bug as below:
> 
> F2FS-fs (loop0): Mounted with checkpoint version = 48b305e4
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in f2fs_test_bit fs/f2fs/f2fs.h:2933 [inline]
> BUG: KASAN: slab-out-of-bounds in current_nat_addr fs/f2fs/node.h:213 [inline]
> BUG: KASAN: slab-out-of-bounds in f2fs_get_node_info+0xece/0x1200 fs/f2fs/node.c:600
> Read of size 1 at addr ffff88807a58c76c by task syz-executor280/5076
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to do sanity check on i_xattr_nid in sanity_check_inode()
    https://git.kernel.org/jaegeuk/f2fs/c/20faaf30e555

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




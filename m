Return-Path: <linux-kernel+bounces-176346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB128C2E3D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 02:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 767092842E3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 00:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3428745008;
	Sat, 11 May 2024 00:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DG2PIQND"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893CD12E40
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715388634; cv=none; b=TtxGPRKAXwmqZLreC5HhEemXxk56SZR+LfFSqbl3q6I1SBNQPqonBGgRMxOR7SSlWOHlY/zceSigSwlHu64wMKuqtQiXYBVzhvp1AXvJjeIoSo3b52qAYtdU6Ag0aoYiQJBn/izwhrAngd29GNbAu0k+YhD96w1oS/1ZkLjwn/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715388634; c=relaxed/simple;
	bh=umpzRfqIbQjf2cQ3pWh/DFx/YMizin6Bv2YlZ01qB7w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qwpwqm/WK+E0VGdMrpJBD0S0XQXD91v586iDrTrFoXKEBItupJYBr7dwTLGCTnVxv2NnVNWwi167gdUTnLMMS+vIiExsjdEh+RZZbtzCCoAqExwn9bvM7y7lA5X+DeSXF2Fr58Pao50euaDi4FQU6B//I4FnzGZQAPOFbtOKSWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DG2PIQND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 345FBC4DDE7;
	Sat, 11 May 2024 00:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715388634;
	bh=umpzRfqIbQjf2cQ3pWh/DFx/YMizin6Bv2YlZ01qB7w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DG2PIQNDZ2WQ5knTaNMQofd+vFkrj/8Lk4AJ9Ilohrc1wSrcsxtGnOUGfmqiNU+Ij
	 btandg8l9XvpWW4uEQzEB7DHlsFnDpyt8D52GzjfJ+aO4U+EBbjjCjNyWo3Hem5Tvu
	 DRd54W2RradldTUZvEu01KhbnsxSupD0dpHA17zFtYME7I8/6HJJhA0xSfQkQzvjWZ
	 C6hk1cv9FDBcRMzimQYMpSkLOu0hxwVphDjargyZg/P5XxtPo4cpO3j5YhVrvR7gAV
	 tSxAtlifxSR+rYrQVN46TQam5xBSZc2glLvUcbq1GXF4KKa51RSRvesIU9GVUXo9aY
	 da3/cqXB4otNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A88FE7C114;
	Sat, 11 May 2024 00:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2 5/5] f2fs: compress: don't allow unaligned
 truncation on released compress inode
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171538863417.11229.16140970709452072250.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 00:50:34 +0000
References: <20240507062019.1097683-1-chao@kernel.org>
In-Reply-To: <20240507062019.1097683-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue,  7 May 2024 14:20:19 +0800 you wrote:
> f2fs image may be corrupted after below testcase:
> - mkfs.f2fs -O extra_attr,compression -f /dev/vdb
> - mount /dev/vdb /mnt/f2fs
> - touch /mnt/f2fs/file
> - f2fs_io setflags compression /mnt/f2fs/file
> - dd if=/dev/zero of=/mnt/f2fs/file bs=4k count=4
> - f2fs_io release_cblocks /mnt/f2fs/file
> - truncate -s 8192 /mnt/f2fs/file
> - umount /mnt/f2fs
> - fsck.f2fs /dev/vdb
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2,5/5] f2fs: compress: don't allow unaligned truncation on released compress inode
    https://git.kernel.org/jaegeuk/f2fs/c/29ed2b5dd521

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




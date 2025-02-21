Return-Path: <linux-kernel+bounces-525093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C23A3EAAD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 03:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2462717EE29
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 02:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56471D514C;
	Fri, 21 Feb 2025 02:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpSQsBXF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339711B85FD
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 02:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740104225; cv=none; b=ehpKW4XTuTLXTvnvjXuNRCbKuJ57saYTn1BFwxJiqxsqXUyTFk9xuf0svXkbEQtaRg1DYlx/2+mw6XPTYOBBv4aITzEy3xxZoe6a74aqutXjT7OEDyXE7wP35VNdgyD4AoAaqb97IG89AGTXJQHywv5gtwQXpQcu7wfZXIzx40M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740104225; c=relaxed/simple;
	bh=uiNUJ3lKDfRoeOKZ5ry+tIO8kvsA/VVTsH8aehztNK8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VrCvWFOWRfUa3Ui9O8iBSFQMcGre75hFiJ0LVztFWDZkXRy5WMKDQQhCoW0DxdPcdupts+2J1Z+ObPcRofbB/T+mqXzwYIW81hBnHLE7/ZHakXqa6vlByGgqM4cjtAmfLJmDLSENPHvUv9ZH+w7wAt4cgS4Nz8JAjm5u1fgV6L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpSQsBXF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F82C4CED1;
	Fri, 21 Feb 2025 02:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740104224;
	bh=uiNUJ3lKDfRoeOKZ5ry+tIO8kvsA/VVTsH8aehztNK8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VpSQsBXFyAkLKUgFJ+spXMrAh4IhD/aBczA69eum2I60oQUyr4AOGIvr1zvgM/4K8
	 mUJn4VEv0CLUd7DG09nqB5BxrtDEc6vEkeQe8FNGZKWGFETd8CfpG7Z6kTiJdoHaJO
	 3lZ/1Rp2yoNXmkBm7sLOXiXEH8M0Ar7kjBTmPXP8bnAcsxp0WUromNobwDjDKD2BNs
	 RL955nJ/zvUSIclIYh1ZAmCxaphy5IHFFdK+DI07T05lbSwY1jB3mZii3TiKOPOUWV
	 Ts9mUWVWD5ptTXbScvmT0DOdlqrZmcEhkelyLdumwX0pY+ev/nyUR/h+/nSU4502qd
	 Dp9cgXKqbc/ug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD963806641;
	Fri, 21 Feb 2025 02:17:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 0/2 v9] reclaim file-backed pages given
 POSIX_FADV_NOREUSE
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <174010425541.1545236.6174789060988336403.git-patchwork-notify@kernel.org>
Date: Fri, 21 Feb 2025 02:17:35 +0000
References: <20250212023518.897942-1-jaegeuk@kernel.org>
In-Reply-To: <20250212023518.897942-1-jaegeuk@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 12 Feb 2025 02:31:55 +0000 you wrote:
> This patch series does not add new API, but implements POSIX_FADV_NOREUSE where
> it keeps the page ranges in the f2fs superblock and add a way for users to
> reclaim the pages manually.
> 
> Change log from v8:
>  - remove new APIs, but use fadvise(POSIX_FADV_NOREUSE)
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: keep POSIX_FADV_NOREUSE ranges
    https://git.kernel.org/jaegeuk/f2fs/c/ef0c333cad8d
  - [f2fs-dev,2/2] f2fs: add a sysfs entry to reclaim POSIX_FADV_NOREUSE pages
    https://git.kernel.org/jaegeuk/f2fs/c/a907f3a68ee2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




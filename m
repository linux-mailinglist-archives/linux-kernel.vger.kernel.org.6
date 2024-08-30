Return-Path: <linux-kernel+bounces-309470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E88966AFC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 22:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BC551C22000
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81191C463B;
	Fri, 30 Aug 2024 20:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmFixrAH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1651C461F
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 20:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725051119; cv=none; b=bU9Pecs0WlJoDsmemHeiMUdECKEHx8cp9Ds0mFlma3yjw94ymuG3EBZYNom0hSru6LZ1uQDm9lIY2FKnE2lpkPLvgn3h5YcVpP9b0E+GcHXRZF1eFpwlIuTuijS5PU2puKPyhGQaejD7KXMyopRQUyYjjnsnP0dGWdi5egY29W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725051119; c=relaxed/simple;
	bh=1Wn6yqoxyoKYrvAnKdloD6T5n0X04RDSUrbiGIH0IN8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c/79pXX5enadPvMJgQB4dlV8R8JkJfPjUZyaeIEgkB/YGaBd96aXIYLCn3+2HiY58/5MVV+3RISmx6t0M+BT+A3GZgKEhqV/LMV88ZU2RQUweTlk8dsJmKRCfnbJJIXmWIERA6BGcxJtHtllbqJ+f70TY1VZXeOFptXpkVdnnZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmFixrAH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6F4C4CEC2;
	Fri, 30 Aug 2024 20:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725051118;
	bh=1Wn6yqoxyoKYrvAnKdloD6T5n0X04RDSUrbiGIH0IN8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MmFixrAHwCdUROvjULPxvCKlKRcRiMbB9dbFJLS8i4RQNNItrcwD2aOo3ZzLEy+w/
	 f2s/Z2tvAMwLGb4uQuMsoeYTygGa3tchGeP9KGNxJ/G8q019gt/hUgCfr0b9Z9IXy1
	 ZwHLJPxe6p8027GrOF5X0JDCBj8iV6yyrDNPbfU+JpQvTh1QV9CTsboY5lUBmAnHx0
	 nxYuJw7HpVswaAjdqSey+A+bnSncKlrFYkki79A+yg34z8lWxXThFPj4JvtAFFh/6n
	 k9q0ehCL9lyunWBdZqwZOUP5hc2zJKUH3NONT9HGG/Vb4vlGnG33dwIxlU2oqh8HKA
	 P9LavN+Sun0qg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 342513809A80;
	Fri, 30 Aug 2024 20:52:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2 4/4] f2fs: atomic: fix to forbid dio in
 atomic_file
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172505111900.2712133.2121725656305360259.git-patchwork-notify@kernel.org>
Date: Fri, 30 Aug 2024 20:51:59 +0000
References: <20240816011342.1668666-1-chao@kernel.org>
In-Reply-To: <20240816011342.1668666-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 16 Aug 2024 09:13:42 +0800 you wrote:
> atomic write can only be used via buffered IO, let's fail direct IO on
> atomic_file and return -EOPNOTSUPP.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - fix error path handling.
>  fs/f2fs/file.c | 36 ++++++++++++++++++++++++------------
>  1 file changed, 24 insertions(+), 12 deletions(-)

Here is the summary with links:
  - [f2fs-dev,v2,4/4] f2fs: atomic: fix to forbid dio in atomic_file
    https://git.kernel.org/jaegeuk/f2fs/c/b2c160f4f3cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




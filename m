Return-Path: <linux-kernel+bounces-565276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC026A66505
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 02:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1433317A455
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 01:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C675F15B0EE;
	Tue, 18 Mar 2025 01:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DiYGI+3k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AB513D62B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 01:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742261399; cv=none; b=usIZVqz7dPkHlsbSx7Wej8PkTtr51YZZXFhjcBeFeK2eu+fOoRdSAp9E+LiJBrhPVb3cfLGvQCagGu/MAv+z4FUTuPInh501T4Z8Pn5nPiGo94MOgnyTPsVi1KqmqUlI2HbwHq2+zBMI2tzt67i4SLsywuYhqPfo/udzg7oxR2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742261399; c=relaxed/simple;
	bh=KT+Vy/FXX3jvNAPPBygtO31qSpTtbmjLb9YegbN3mQQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OzHM95UvC8sEaR73lqeSj2W3A1cfeYw5tq6D2i87wDzrO65c8/amT+pCV6tLjWvhNccnyDnYtiKDUiuYzLW2jos9r0nnHDw7yoUH0YCXIFqmSHoQ4icyG5P26Be9jRH9n86nPz/7Eu9EVJO6DM0gG9AFQA6RrnzJOO5VdwoOrr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DiYGI+3k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12D7C4CEEC;
	Tue, 18 Mar 2025 01:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742261398;
	bh=KT+Vy/FXX3jvNAPPBygtO31qSpTtbmjLb9YegbN3mQQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DiYGI+3kQOcfGRc4yT92oXwaSbR8him9DoweICbqUbNh+Z+20BjWuFJldcANdVfQs
	 xCzujGgdEG2FD4C+8lne0rRlwHdmsGXW4Ra+0s1KOzZsrQQj6jnDD35nphgdC6dTS6
	 rKHAEx6iHx0uxbACxRc6EDDOsWJfMjvh8mBacZIg5l3NazaAvDiLeXHkjP6G2mA0OZ
	 0b7dUuvNkcffO3mpBGzy3T6fa4ssjweWRFGJatp+CFVbS+yPsYOmZxz0Qn9NwpfQHV
	 +RGYBgI/xqDTN+/x3fSXY0iYkC5v7HduaMoKcDpvW3b/Fugsv5LRMiGEPOGcCTpvpq
	 9y3CmgWQz3c/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34D52380DBEF;
	Tue, 18 Mar 2025 01:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: fix missing discard for active segments
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <174226143398.3976340.10979169569040925806.git-patchwork-notify@kernel.org>
Date: Tue, 18 Mar 2025 01:30:33 +0000
References: <20250317101624.3223575-1-guochunhai@vivo.com>
In-Reply-To: <20250317101624.3223575-1-guochunhai@vivo.com>
To: Chunhai Guo <guochunhai@vivo.com>
Cc: chao@kernel.org, jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 17 Mar 2025 04:16:24 -0600 you wrote:
> During a checkpoint, the current active segment X may not be handled
> properly. This occurs when segment X has 0 valid blocks and a non-zero
> number of discard blocks, for the following reasons:
> 
> locate_dirty_segment() does not mark any active segment as a prefree
> segment. As a result, segment X is not included in dirty_segmap[PRE], and
> f2fs_clear_prefree_segments() skips it when handling prefree segments.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3] f2fs: fix missing discard for active segments
    https://git.kernel.org/jaegeuk/f2fs/c/21263d035ff2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




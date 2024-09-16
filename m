Return-Path: <linux-kernel+bounces-331127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D672897A8CB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 23:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED7C71C25C87
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 21:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE17D1714B2;
	Mon, 16 Sep 2024 21:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c990Pe7+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6E116B75B
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 21:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726522236; cv=none; b=IZgmpsCxf64C6r1faSfpSgTL7hJajW1ZAVndWtJOvtaIFY9afGC63JM4akghY8BvsMbCefH4HTA1EvGPEajnx78kZY16c4osJBIEIB0jGJGbaUAD1ILlG75/KxHPHcomrdzqRZRlqTIs0Y6PQnSYXXXzUKXIucxbLx/d77aA4zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726522236; c=relaxed/simple;
	bh=gpAhyyWTTofmD5p8pqREwF5xUfCBBnrCVAI8oGe8Bgg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oiPhHTd0MTOeHsYZmeWDot8F4651RdFGtZXlUWdMyLK0EylEJrNToZWDb+I1IfEFLcxYZRTsS5aPX7NWluLAAmfAl/rk4jTfYyp13p2hk/MijedE99vLPq+O4xpO48XH69HVLBbL0Vni9psA9UdyK3NEqo1CDZSJIuyqVjDcx2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c990Pe7+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E4DC4CEC4;
	Mon, 16 Sep 2024 21:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726522235;
	bh=gpAhyyWTTofmD5p8pqREwF5xUfCBBnrCVAI8oGe8Bgg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c990Pe7+XpgXXAA49chRytqdlsJLhHDzty95z/zdhO2T6/VZAuNZoqUbhmCRD/RUA
	 iNV/gNpEGdnUQdlxYpaEYznsZ5Viv/+IpsFJf229yIqVZKbGZGoy1/Q3Jmn+KxGqkf
	 aTFeHUOHKhPtCYUePlKvEYM2y8CYvFhPX8eu60XLO++0P5iXvG4D5h1/7uKs9S6niz
	 PRmRpL7B7wUNKQ9EKEkHdOxZHchTRp8vvXnuSXVZaAJSi6PBIM9X4gvdJM6p36DYtr
	 bZdGXsUT1kmcr7Tm40X54M/uu/fvEwkjqbSe3qnT/39aFY3pot6EIVY2dFeX8U1WSI
	 EkDUUudPePB5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE5393806644;
	Mon, 16 Sep 2024 21:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: prevent atomic file from being dirtied
 before commit
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172652223724.3820990.15004713720565188782.git-patchwork-notify@kernel.org>
Date: Mon, 16 Sep 2024 21:30:37 +0000
References: <20240904153306.816988-1-daeho43@gmail.com>
In-Reply-To: <20240904153306.816988-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com, daehojeong@google.com

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed,  4 Sep 2024 08:33:06 -0700 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Keep atomic file clean while updating and make it dirtied during commit
> in order to avoid unnecessary and excessive inode updates in the previous
> fix.
> 
> Fixes: 4bf78322346f ("f2fs: mark inode dirty for FI_ATOMIC_COMMITTED flag")
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: prevent atomic file from being dirtied before commit
    https://git.kernel.org/jaegeuk/f2fs/c/fccaa81de87e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




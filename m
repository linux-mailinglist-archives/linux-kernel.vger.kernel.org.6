Return-Path: <linux-kernel+bounces-400596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 799479C0FB7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E45A284BC2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E117B2185AB;
	Thu,  7 Nov 2024 20:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6U5i98N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8C8218596
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 20:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731011433; cv=none; b=WtyWkLsYjaOvffh+7VjTLlrRVWGYTRrW7IHYcuTJM9czY7KIwNQsbGKZHQs2hQJ8VqkU+75eTDDOKqTYCFYSI2LN10KkWhikymS9KdbSolv0/EiZ03ZIuAuNNn3/LrvpTkIBRSesnKreheCaAZGDldfZtdLTPvyhvajeD+ugDQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731011433; c=relaxed/simple;
	bh=xEvgzfMCXK4MGPVSxFiRyAR8pYmis6wmboUMDxUIL44=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iv4CHClwTXpbp13f14u08v/CbeeNynga75TINSV0LwApjN6pvZZHFKuorAUSYObQeVD2XZXxKRmJ1JqgjwWlKY6WiNueg3sXhrQFJYiXPKr38Ep9ymUDKdW2OHhff4aDsnMCYWQLd99rQJ7MgMmBgVCNtdcQeP3CkEOHiDxR+NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6U5i98N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDCA6C4CED4;
	Thu,  7 Nov 2024 20:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731011432;
	bh=xEvgzfMCXK4MGPVSxFiRyAR8pYmis6wmboUMDxUIL44=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q6U5i98NdBfp1ExymiB7UqlO/79xEnGtFcz/n6U7n0f2dXzmEQ1OikjHIXo66atR3
	 t1+RO9lNbfXv7gQK0SI6eAXpPFGPWP+u1e+kDfQOHs0JD7gOZBW8UK+wD1miurPYqy
	 6PacAqiMj/KbS2tff2ELE8p7sIqO+4AO61KmcX26Gjr/FU3wgU0hQ+dxOzbzOgqGzM
	 OEyEFHl+ut5lnG+WmrTw7RmdRRPrm0kMdYFZnECxaSjX99sHtDRek9JZHj424n8phI
	 Sgyfv3OY4RJPMZ6KygZ4ij1MjfajZ6Sw0bsXUuwrabiRrVXliqWbjHfCmmkG4biVnd
	 A1TBpyMtbXg0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 344053809A80;
	Thu,  7 Nov 2024 20:30:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix fiemap failure issue when page size is
 16KB
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <173101144199.2084993.6672876155571562205.git-patchwork-notify@kernel.org>
Date: Thu, 07 Nov 2024 20:30:41 +0000
References: <20241029061535.2676673-1-xiuhong.wang@unisoc.com>
In-Reply-To: <20241029061535.2676673-1-xiuhong.wang@unisoc.com>
To: Xiuhong Wang <xiuhong.wang@unisoc.com>
Cc: jaegeuk@kernel.org, chao@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 ke.wang@unisoc.com, xiuhong.wang.cn@gmail.com, hao_hao.wang@unisoc.com

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 29 Oct 2024 14:15:35 +0800 you wrote:
> After enable 16K page size, an infinite loop may occur in
> fiemap (fm_length=UINT64_MAX) on a file, such as the 16KB
> scratch.img during the remount operation in Android.
> 
> The condition for whether fiemap continues to map is to check
> whether the number of bytes corresponding to the next map.m_lblk
> exceeds blks_to_bytes(inode,max_inode_blocks(inode)) if there are HOLE.
> The latter does not take into account the maximum size of a file with 16KB
> page size, so the loop cannot be jumped out.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix fiemap failure issue when page size is 16KB
    https://git.kernel.org/jaegeuk/f2fs/c/a7a7c1d423a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




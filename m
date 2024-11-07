Return-Path: <linux-kernel+bounces-400595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2C39C0FB3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA726B2317B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB93A21833E;
	Thu,  7 Nov 2024 20:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Agg7rmTC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1268721832E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 20:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731011432; cv=none; b=FxyUW0Fk7UUmx/wlp6iBS1cDqVliwuytCm0TIyIQOajaUOEBEeBrtlKPcFu3lbgO7IpbNeacgPK3W7OARibFRty3eXXSHoH0DTw1muKzIqUKoMqKFkfOiBUxhReRINbmK0XQgoIj20VcKBfelyFMuagJXkGk4izaRr8khucEAZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731011432; c=relaxed/simple;
	bh=eAef36GNz7B+Ka0Ox9x43rz9yb93FE3ruONiDAzO5/c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SV1Z3hk5aD+j1/DvT/BAP5w3vyZAfSIvD/F//kjAMwKPfDMSJQlUi9txhC7Y9xINsyPNEjssOEnL8KGZx+OgVwY1ybHofRDJJ0wrIONOnr202C5mM1TJ68TDlvTvFHbVkoHAhJBDgm1EvjwUXL/6s+NKr90lemqpLSB0wr/3ufg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Agg7rmTC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C04C4CED5;
	Thu,  7 Nov 2024 20:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731011431;
	bh=eAef36GNz7B+Ka0Ox9x43rz9yb93FE3ruONiDAzO5/c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Agg7rmTCE62Laa8I+64QLrNBVW+y2KHLN1wVgwpDBh5nfWJGc1qLg96ANqibGgC+l
	 zKRIjaOVPDYtG69ev7u2zhPCcR+5XT3mzN2fFHUkR366VY+kJ+nv1X1cdBGMbL/iRE
	 qznW6BPvO49OS9snrBR33EixIQxAXmvmElk7WwNg2pGfmEhZCKQyhFnipgifi9Etvc
	 h1LKezXUj/2gzW1tP9Mzh0CzF7EQjsfMM+ReDMjf1bDfZa9fcjw9HT0N6LgJe6yCJs
	 1K0oeyoH4uLm//UK4WMWecDmjzPCB57NGMVjmLJJm+NttFuW9FNekTbdr4NgcZZBqF
	 jMWcF4HqiZDHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB5353809A80;
	Thu,  7 Nov 2024 20:30:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: Fix not used variable 'index'
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <173101144050.2084993.16195165564628415074.git-patchwork-notify@kernel.org>
Date: Thu, 07 Nov 2024 20:30:40 +0000
References: <20241023094850.1680709-1-zengheng4@huawei.com>
In-Reply-To: <20241023094850.1680709-1-zengheng4@huawei.com>
To: Zeng Heng <zengheng4@huawei.com>
Cc: chao@kernel.org, jaegeuk@kernel.org, bobo.shaobowang@huawei.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 23 Oct 2024 17:48:50 +0800 you wrote:
> Fix the following compilation warning:
> fs/f2fs/data.c:2391:10: warning: variable ‘index’ set but not used
> [-Wunused-but-set-variable]
>  2391 |  pgoff_t index;
> 
> Only define and set the variable index when the CONFIG_F2FS_FS_COMPRESSION
> is enabled.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: Fix not used variable 'index'
    https://git.kernel.org/jaegeuk/f2fs/c/0c3a38a4b442

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




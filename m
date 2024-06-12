Return-Path: <linux-kernel+bounces-211828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9639590578D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 460E11F28BA8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127D6180A81;
	Wed, 12 Jun 2024 15:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fov6JwUk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E1F17FAA4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207757; cv=none; b=BligNkBVAH8vPZJ/XjCDmPCZRW1+w4eWqES5XMzT8/RSGB1q50jszfEC2nZaazYgvbNrE2DUQ3bLNVic5Jy7dh2Yy+6OyOrN8Te0qnmaXFMMJPm99qTEQ+V6IGstfzbUdqJ2KzG/IjJjrWq/YQEFRmxA3pHYm5i7r3Sbamk5BWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207757; c=relaxed/simple;
	bh=XPgYyhCocDhmK60A7bTcEl7zys5QbnfCXdeEtVRWmcQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y3ogwbFG1Nq1CHBcTgNcB2VCNUQXbZWxLzLu9A4JbvP9QtQnxROE7p3H9CF+m/mQVlSFyDoc7DWvyaaPJbZIHejTz44jo5nmXmmJPJg8VXH5N3/ecjP4DmMbQd0luHuqQ72Dnkys9qpU55pn8gL5SuuFAzSwP/o6oYUmlbD307M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fov6JwUk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3718FC32786;
	Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718207757;
	bh=XPgYyhCocDhmK60A7bTcEl7zys5QbnfCXdeEtVRWmcQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Fov6JwUkPwJarGkitn00xJbvhgpTSFXeYuQa8BeJi4BfAvjnj1IWeNiyeRLf1B9R7
	 Jws40mmhHSPEa6C0gaTgKt391E+BoHgtP2WvZA5JWpLIHdWek0UTMtD9XJDN0y6lhd
	 mJWn7ruBuIJFyrxB2sQoY/ALbRH+3OJt8mryUuR2GqrduQSBLqKq5f71SkDBgkvWqX
	 MOEp7Bq2U58WFNvUjewTeM6xGWqhkp+Lq84n5J3B0vZxz6vCsU+V7Zap1cQtnM7EJM
	 wceR464oI9AA72T0VQ4NFh/ETWr004BR65kXcWY3qz5E1fHNGa5ovGYW1YhzQ9Y8yF
	 og9M8ECw5N2fQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A25FC4361C;
	Wed, 12 Jun 2024 15:55:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to avoid use SSR allocate when do
 defragment
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171820775716.32393.14343237902912623947.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jun 2024 15:55:57 +0000
References: <1716976020-28757-1-git-send-email-zhiguo.niu@unisoc.com>
In-Reply-To: <1716976020-28757-1-git-send-email-zhiguo.niu@unisoc.com>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, ke.wang@unisoc.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Hao_hao.Wang@unisoc.com

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 29 May 2024 17:47:00 +0800 you wrote:
> SSR allocate mode will be used when doing file defragment
> if ATGC is working at the same time, that is because
> set_page_private_gcing may make CURSEG_ALL_DATA_ATGC segment
> type got in f2fs_allocate_data_block when defragment page
> is writeback, which may cause file fragmentation is worse.
> 
> A file with 2 fragmentations is changed as following after defragment:
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix to avoid use SSR allocate when do defragment
    https://git.kernel.org/jaegeuk/f2fs/c/21327a042dd9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




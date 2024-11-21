Return-Path: <linux-kernel+bounces-417208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D179D509B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 17:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 700DE1F22E0D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 16:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357601A9B54;
	Thu, 21 Nov 2024 16:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfQcmagy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954FD1A4F22
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 16:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732206025; cv=none; b=WKkBOPj8c78HnD5nN5JcPVppNA6IXSa/wP9msz8rCzXkXhVurP3LTGFa7aeYVtlbr6cFN8wMHYYo7BU2JQnxWfcbjLF/a63OwoPIjibUep/cOjQN5G1qEqbXY4cED3mS55N5hGiouuNi5cRRp3RkbxadulX2SCfM/Ki+zlfYDe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732206025; c=relaxed/simple;
	bh=OtjUEKdxpPtkGjUDo800ZhZe3Tku9TR+aClhix3hrJs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZXvd7q7hURBGLM/bJPvjfjL6Y4Jw39mIj1IQmO/yM4JIlZKF9sUPtCKlSuu6bHVh00QjCJO26MV/hmKrYxLbXPdIwwnuQ6dYCrn1x/wZq92knPRkEneIJqUjIvKI6Vcgu2iP3KCNjIxzTf60y7q2ZOhC+92CVGP/UeZu/yaP3oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfQcmagy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22791C4CECC;
	Thu, 21 Nov 2024 16:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732206025;
	bh=OtjUEKdxpPtkGjUDo800ZhZe3Tku9TR+aClhix3hrJs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SfQcmagy+q9aQRJ5UO8QJ4nWbWUbXxdk/lfVWUjp+LvtAlJkFpQLgwkOisWPhy90I
	 ilmQC4UDmszmh+6whecmLfpwJsMC1Nk/d4Q9qxmwvuypl5BuVPHVYjofXFMUXPJlni
	 zWJOG56thbBGoOXuWFjr8Lw3mSwA9MexM0Eg5TxGYGC+Y/AuRL8Zo2OQS7ZcvUB+Qj
	 e4/jsX9K9hErGneoCSKkh6hSoyQD1fA5nSHGzGNSzHTHJnWEMgTe69ORCRPAC7CA1V
	 1WRIcAOU5RmRZgU6utiNOaFvV+cWxhkeSPJaIZw2+PRXl8w2qwp3U9aYXVvRJ/36y8
	 9rfrLNLI4M0yg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 387A13809A00;
	Thu, 21 Nov 2024 16:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: adjust unusable cap before
 checkpoint=disable mode
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <173220603673.1977996.6285355196321029401.git-patchwork-notify@kernel.org>
Date: Thu, 21 Nov 2024 16:20:36 +0000
References: <20241118184535.1047327-1-daeho43@gmail.com>
In-Reply-To: <20241118184535.1047327-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com, daehojeong@google.com

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 18 Nov 2024 10:45:35 -0800 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> The unusable cap value must be adjusted before checking whether
> checkpoint=disable is feasible.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: adjust unusable cap before checkpoint=disable mode
    https://git.kernel.org/jaegeuk/f2fs/c/a35749b1ed64

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




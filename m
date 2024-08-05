Return-Path: <linux-kernel+bounces-275458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 909FC948600
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A9C7283C0F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 23:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E109216F908;
	Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlYNOe11"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4BA1547CD
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 23:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722900652; cv=none; b=qHozz1xZtUfTE3rghgtPhmhmQ3D7m/z83V5umWrQA4xZ4g9e+aUvExmP07jeJXqwryIb/H/qOsIaYRih8+s3Gr/kTCAah95ixiFH002hjyN2TNw1SgMxyNnGMTpB+hOUxWQDd+Wtc2Ko3C789WgFn0c+7+V6xYqHW6RnJCqO6y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722900652; c=relaxed/simple;
	bh=Rsa4UgKROg3oElaqYDmOCqPOaaR0RW68YsBwnLH5WlE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MLFagipi/UKlQmrinbiSLuHGm0h4w2ACGCp87yVCH5o5idS4AhH98A7yTT7WnPy4kzViy7MxqdXTJ6VmANz/6y+rrQw3hN+Da+uCM5ip7LT9Xu3L/XdFV000IH5nTI9+WXq8c9XgazaqHc/PZ1b8nwff8wztOZ+Gc4vXsx4jRgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlYNOe11; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE5ADC4AF0E;
	Mon,  5 Aug 2024 23:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722900651;
	bh=Rsa4UgKROg3oElaqYDmOCqPOaaR0RW68YsBwnLH5WlE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jlYNOe11nzSMe16nbuiN7KrLdj2E1D3+nzi2YTBDpuZCcZlv0Lvr+RVy4AyIRCxfS
	 3u/zWt9cgRGhgLa0GqPezKWPOrW6oeb8V9f+yTtZFrQ51goEylGGQOG2D/Jv72vyFJ
	 HVX3qwHuHeFen1klrnJqqAHNY7TtGQiUZ24mSvqGuGEuUyqB+UKHperK1KZ56YSJK8
	 X/t5Wl3UyTQp67YQyVzkem4oyvlJS7lqT48IBRxAaX/Y1kcZVGSLfpChThiVcl1cau
	 UkafDYiE0zqbcvg/Etx0pubR/YKzHolwzmf8z07kFKdL834cH+SFItEuE/HPHDBRBs
	 z+cmd1KCx8EmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B64F5C43140;
	Mon,  5 Aug 2024 23:30:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v5] f2fs:Add write priority option based on zone
 UFS
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172290065174.2803.15142106569963496847.git-patchwork-notify@kernel.org>
Date: Mon, 05 Aug 2024 23:30:51 +0000
References: <20240715123451.7918-1-liaoyuanhong@vivo.com>
In-Reply-To: <20240715123451.7918-1-liaoyuanhong@vivo.com>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org,
 bo.wu@vivo.com, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 15 Jul 2024 20:34:51 +0800 you wrote:
> Currently, we are using a mix of traditional UFS and zone UFS to support
> some functionalities that cannot be achieved on zone UFS alone. However,
> there are some issues with this approach. There exists a significant
> performance difference between traditional UFS and zone UFS. Under normal
> usage, we prioritize writes to zone UFS. However, in critical conditions
> (such as when the entire UFS is almost full), we cannot determine whether
> data will be written to traditional UFS or zone UFS. This can lead to
> significant performance fluctuations, which is not conducive to
> development and testing. To address this, we have added an option
> zlu_io_enable under sys with the following three modes:
> 1) zlu_io_enable == 0:Normal mode, prioritize writing to zone UFS;
> 2) zlu_io_enable == 1:Zone UFS only mode, only allow writing to zone UFS;
> 3) zlu_io_enable == 2:Traditional UFS priority mode, prioritize writing to
> traditional UFS.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v5] f2fs:Add write priority option based on zone UFS
    https://git.kernel.org/jaegeuk/f2fs/c/8444ce524947

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <linux-kernel+bounces-252696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA999316FA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A5E8B21ED5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE35018EFCD;
	Mon, 15 Jul 2024 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jj3Vlgh6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D52313D531
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721054432; cv=none; b=s877DMmGGnH1uwVWUvibPVewX4nF+jB4uKoRFBALtqkLUiHVCmXkq5IlMpjK39WaDJSjgUqF8/0SPwOYeCLmlJzKhx4xu0YtI8TjY35QEXmo6/ku9U4uHSgRGmFKoE3oOhEhZXcx26qpSJZTEG6wUpWbAxjyVEgD2rFZThSfnXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721054432; c=relaxed/simple;
	bh=nLTjZ4iku7w3CDYmTvYQeTxA3KeLggHY3Bv8PHGatPI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q77kwRiF+ZgU9Dnc0lKAX6Im5ZixONTMzzI16fuqF4pXBZl2wZ+EH1iZZEfsgZNNzGgqxNw+wOMpnjoIvAjzDqS1RdhFOTYY6NujM/Bxm31blXm9KgV75SCdUFjcbroqBrZxiwx4dRxQc7WjL/RfgpJd4kGK8CwTOH9UvjUDP4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jj3Vlgh6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3A3DC4AF0D;
	Mon, 15 Jul 2024 14:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721054431;
	bh=nLTjZ4iku7w3CDYmTvYQeTxA3KeLggHY3Bv8PHGatPI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jj3Vlgh6ccvAGi1tcuZ/LYM6s18skXDN0AlW+zr8PGhDNu6MxlRWAsTGTo2C5b3TP
	 sb+opPLh74dPKuwLBGTQHfUvK1cngwS9KFi8ypazvbnITevIx1hE7Cqqs82FB2JBg/
	 oATQRT0dSGmBlGCAqSRLdng14UpGEhyFydstClJaWDcOq4+T/QxJ6ojKNmdjkCezu2
	 fh3hAkG/r/VhI2rtZxGTLwfxJpaJGPKW+3wTmmImmQgPHUnf9JWax/pE+tVyy2bEkj
	 CO2ZKkoOkXWMXgOdRV4I5+lNzs3i9QMNZ5gfsj9m5HKLlZy+DQi7fZNw4HlJxYARQp
	 gRYBiwjjD++5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C1352C433E9;
	Mon, 15 Jul 2024 14:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: only fragment segment in the same
 section
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172105443178.17443.14567102589970622555.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jul 2024 14:40:31 +0000
References: <20240710012659.3415856-1-shengyong@oppo.com>
In-Reply-To: <20240710012659.3415856-1-shengyong@oppo.com>
To: Sheng Yong <shengyong@oppo.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, daehojeong@google.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 10 Jul 2024 09:26:59 +0800 you wrote:
> When new_curseg() is allocating a new segment, if mode=fragment:xxx is
> switched on in large section scenario, __get_next_segno() will select
> the next segno randomly in the range of [0, maxsegno] in order to
> fragment segments.
> 
> If the candidate segno is free, get_new_segment() will use it directly
> as the new segment.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3] f2fs: only fragment segment in the same section
    https://git.kernel.org/jaegeuk/f2fs/c/e3a19972a49f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




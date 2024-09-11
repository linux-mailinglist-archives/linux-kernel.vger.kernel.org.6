Return-Path: <linux-kernel+bounces-325265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F57975727
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 495501C22715
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4148F1AAE3D;
	Wed, 11 Sep 2024 15:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJGTyi3X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C7913D2B2
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726068632; cv=none; b=i2NIA+Ks8VXBopaDgfyVj0BZM+yGACRZZN0K3bgSFJHv01XVf+xgUBfJoq1+ZXhU0GVQ05G3jMJlu9Prcnem4SuY4oURKfGsxXIoyqdBTrrBopmli0nc8Mo+C7OtI4KukSgJADYcGVl/bb5xswso37jpbZ6X5Jg0ZHihfbzbT/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726068632; c=relaxed/simple;
	bh=llJeNL3z/ffIqfsiZcfsjZ/5cwKD3WmlJM+NkLUF0+Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ATq8qR7O3oywnPANjy1me8zeutEHF2BYp/7EI6H/1XP+1Vwx3bTOOQLV6Ae8nlaTc74u53Z9BnMqr3xTQGaXocHj2Jmp7gvtTmebVHjLgIQZDJ9Yg2hpp7OV9v85Mxpadc+r49S80vUUoDpVG8tGvhEXTrzXfS6UHGTFwWUQnqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJGTyi3X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B30C4CEC5;
	Wed, 11 Sep 2024 15:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726068632;
	bh=llJeNL3z/ffIqfsiZcfsjZ/5cwKD3WmlJM+NkLUF0+Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JJGTyi3XQGxWYpZWUPXIzDp3FPB6YDXxvbNdL6tzNzuZbNNPFabctqvBlGYbWNvrK
	 WyTTFSxs/3QJMrEzuhUfjaprlUYCJLctBEMlIlI0tYwFOmO+gmyRh18Mu9A6aqjuAX
	 lTwaBVdSIwDCQg3R1LA7NDjxFFOnOt/TFyMtwpp6TpBpy1wuwJ09iyZn1e4quNozmk
	 2qjy3vByOjb2K1MujG0vAbtYl9HpRtxey1EG3w6PobG7ifn+t2bTYyd0GDDmRtHFL7
	 biW3G9Uq/6tk/2VMbnVv8VU+gglnKXfMEv4wIguzrUFLrcYInyHck+6lG7Vv11mvxm
	 0505TL1Tj03Vg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C093806656;
	Wed, 11 Sep 2024 15:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] riscv: Disable preemption while handling
 PR_RISCV_CTX_SW_FENCEI_OFF
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172606863325.959689.12181957139773137657.git-patchwork-notify@kernel.org>
Date: Wed, 11 Sep 2024 15:30:33 +0000
References: <20240903-fix_fencei_optimization-v2-1-8025f20171fc@rivosinc.com>
In-Reply-To: <20240903-fix_fencei_optimization-v2-1-8025f20171fc@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alexghiti@rivosinc.com,
 atishp@rivosinc.com, samuel.holland@sifive.com, parri.andrea@gmail.com,
 palmer@rivosinc.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 03 Sep 2024 15:52:34 -0700 you wrote:
> The icache will be flushed in switch_to() if force_icache_flush is true,
> or in flush_icache_deferred() if icache_stale_mask is set. Between
> setting force_icache_flush to false and calculating the new
> icache_stale_mask, preemption needs to be disabled. There are two
> reasons for this:
> 
> 1. If CPU migration happens between force_icache_flush = false, and the
>    icache_stale_mask is set, an icache flush will not be emitted.
> 2. smp_processor_id() is used in set_icache_stale_mask() to mark the
>    current CPU as not needing another flush since a flush will have
>    happened either by userspace or by the kernel when performing the
>    migration. smp_processor_id() is currently called twice with preemption
>    enabled which causes a race condition. It allows
>    icache_stale_mask to be populated with inconsistent CPU ids.
> 
> [...]

Here is the summary with links:
  - [v2] riscv: Disable preemption while handling PR_RISCV_CTX_SW_FENCEI_OFF
    https://git.kernel.org/riscv/c/7c1e5b9690b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




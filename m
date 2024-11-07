Return-Path: <linux-kernel+bounces-400600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 495C29C0FBC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFC61284A67
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EFE21830B;
	Thu,  7 Nov 2024 20:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtzFQwre"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7670D21830A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 20:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731011443; cv=none; b=qpyB0a9J10ydR7mMWxMCVE/veHtGk1XaHXmXG8JiyEjxGTM/NfMPGuH8ZeXI9BnfrOb8efqM7rilG2aGk13MKKutJIfjnh0ixQeHyOjh60Kacz8NRiT4uItDbU/249xzUHEFHT+n2ENrK7hXvjojJrPmSdtmoOvnCCK7f/VgWI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731011443; c=relaxed/simple;
	bh=qS6CXdrqUCjtuvc8yxy0I2OHxYoRkeaHGHzfvSGgpKw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lCt6dj6w8E9fwIZG5JTzFd37uxQW8Clx6wLcdF4nKWYtdPQL5sMAKOJ5trlaStHcduD8p5tkqMMaycGwPfA00mgMYxA2ismGRCr7IpDRv8wl8FkAP6H6c2tIg8pZBX4v/4jxVJtyn8GeJtZQIxceWvT615p9NCweW7XcUVUvgZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtzFQwre; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12C4C4CED2;
	Thu,  7 Nov 2024 20:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731011443;
	bh=qS6CXdrqUCjtuvc8yxy0I2OHxYoRkeaHGHzfvSGgpKw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DtzFQwrePm7CJX07yC/vNRHp6OiV4DE0xSkLUNtwN2WQ+bqVPYFz8RdQYJvhnu38d
	 ThSBQ739qtn6nFfLN6Caf4Vqjy1iOFpzukqQfmnVkdj11eZLANnp0sICJFP5Mc/R75
	 3sd4cPWbYFgp8hWSgRn///3JPojdZITkmLm+PqSbOmxk2PLiBIvLRF4gY0j7lgvCaJ
	 SSm1dNgOI4KD0n5TmfjTEV4Ci93n06SILsUoqPURW14N9lwUo8hERA3qObPYU6LCu9
	 dPTMcAveGisEnrbmN9EalTdpkxfG6eoRZbFL2n7RctUmQHVOHR2ZHZ3+juzvE5xBIv
	 vIsRytIZWzU7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 723663809A80;
	Thu,  7 Nov 2024 20:30:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH V3] f2fs: fix to avoid use GC_AT when setting
 gc_mode as GC_URGENT_LOW or GC_URGENT_MID
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <173101145199.2084993.8756265891137961200.git-patchwork-notify@kernel.org>
Date: Thu, 07 Nov 2024 20:30:51 +0000
References: <1730171569-10757-1-git-send-email-zhiguo.niu@unisoc.com>
In-Reply-To: <1730171569-10757-1-git-send-email-zhiguo.niu@unisoc.com>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, ke.wang@unisoc.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Hao_hao.Wang@unisoc.com

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 29 Oct 2024 11:12:49 +0800 you wrote:
> If gc_mode is set to GC_URGENT_LOW or GC_URGENT_MID, cost benefit GC
> approach should be used, but if ATGC is enabled at the same time,
> Age-threshold approach will be selected, which can only do amount of
> GC and it is much less than the numbers of CB approach.
> 
> some traces:
>   f2fs_gc-254:48-396     [007] ..... 2311600.684028: f2fs_gc_begin: dev = (254,48), gc_type = Background GC, no_background_GC = 0, nr_free_secs = 0, nodes = 1053, dents = 2, imeta = 18, free_sec:44898, free_seg:44898, rsv_seg:239, prefree_seg:0
>   f2fs_gc-254:48-396     [007] ..... 2311600.684527: f2fs_get_victim: dev = (254,48), type = No TYPE, policy = (Background GC, LFS-mode, Age-threshold), victim = 10, cost = 4294364975, ofs_unit = 1, pre_victim_secno = -1, prefree = 0, free = 44898
>   f2fs_gc-254:48-396     [007] ..... 2311600.714835: f2fs_gc_end: dev = (254,48), ret = 0, seg_freed = 0, sec_freed = 0, nodes = 1562, dents = 2, imeta = 18, free_sec:44898, free_seg:44898, rsv_seg:239, prefree_seg:0
>   f2fs_gc-254:48-396     [007] ..... 2311600.714843: f2fs_background_gc: dev = (254,48), wait_ms = 50, prefree = 0, free = 44898
>   f2fs_gc-254:48-396     [007] ..... 2311600.771785: f2fs_gc_begin: dev = (254,48), gc_type = Background GC, no_background_GC = 0, nr_free_secs = 0, nodes = 1562, dents = 2, imeta = 18, free_sec:44898, free_seg:44898, rsv_seg:239, prefree_seg:
>   f2fs_gc-254:48-396     [007] ..... 2311600.772275: f2fs_gc_end: dev = (254,48), ret = -61, seg_freed = 0, sec_freed = 0, nodes = 1562, dents = 2, imeta = 18, free_sec:44898, free_seg:44898, rsv_seg:239, prefree_seg:0
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,V3] f2fs: fix to avoid use GC_AT when setting gc_mode as GC_URGENT_LOW or GC_URGENT_MID
    https://git.kernel.org/jaegeuk/f2fs/c/296b8cb34e65

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




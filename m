Return-Path: <linux-kernel+bounces-354293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CF0993B5A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 01:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A555F1C23DEF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 23:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771FE1C230E;
	Mon,  7 Oct 2024 23:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwKxIyrw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E9B1C1ABC;
	Mon,  7 Oct 2024 23:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728344437; cv=none; b=WK4qQupHw+Dripd9Jr4NVAdGnAVAEn/tg5+QwzzAwFdgvvOEanZpdCj9V39RQxp0ksErhukYRiI2J+W42w8Jz0w1DFFotvAWDAiyKxNSSiL+Chp5yNwJZXkAgSvsX0AXIKHKd/ucyChnTjll4ZVod7zj/WaZZtLFecJSEdSA06Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728344437; c=relaxed/simple;
	bh=v6bg5HUl2zhJ6Ksjbve8CqmD3g3lkSxXE3tYME5aPNU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kgm7am1XxKcULTSvJt8KLKDAv98H83k1bWpVVBtelOgp8PQpLd9g0LS4nE78mQZjn9CVCu1pFmzrqFUfo//DXdDVwIIBe+cD6uK72c65GWZoBi+DTGeQmSIJWepY/XJ3Ws/+J8iRkvw5yjN8HaTwLmq6dm1M3NSFIPtFDxGJM5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwKxIyrw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60592C4CECD;
	Mon,  7 Oct 2024 23:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728344437;
	bh=v6bg5HUl2zhJ6Ksjbve8CqmD3g3lkSxXE3tYME5aPNU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IwKxIyrwwdP4CNgozgemp1uYvL239FDjzES2mq3GhSdERVMBtipDwGUpXV59WVvcX
	 g+5MfZdK9u1+eh0mkpQghkIyGqcW1oITa2FBUrY2UbqtJbhkA0S81w+EklWf4JHD9k
	 7//Tm6OD16thqhocXzARSpqNFNMFRlKpthKTWGLLJL6gleVOc/twzKuF10aWW23EM+
	 RO0552wSyYfQ1C6JsShAhe+Vhn936oxa5kdDmDjZrmf2jBwFgGAT0IjeT8HU7JWmPW
	 0SE/il9n+MliKBk3Vti9Wi6a4l4KXANU3iSWupa1k78a34gJ2G6vj9N7nmqLnJB3mr
	 GrydPsrZLbCFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDCD3803262;
	Mon,  7 Oct 2024 23:40:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] lib: packing: catch kunit_kzalloc() failure in the
 pack() test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172834444148.18821.13328797318044195975.git-patchwork-notify@kernel.org>
Date: Mon, 07 Oct 2024 23:40:41 +0000
References: <20241004110012.1323427-1-vladimir.oltean@nxp.com>
In-Reply-To: <20241004110012.1323427-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jacob.e.keller@intel.com,
 przemyslaw.kitszel@intel.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  4 Oct 2024 14:00:12 +0300 you wrote:
> kunit_kzalloc() may fail. Other call sites verify that this is the case,
> either using a direct comparison with the NULL pointer, or the
> KUNIT_ASSERT_NOT_NULL() or KUNIT_ASSERT_NOT_ERR_OR_NULL().
> 
> Pick KUNIT_ASSERT_NOT_NULL() as the error handling method that made most
> sense to me. It's an unlikely thing to happen, but at least we call
> __kunit_abort() instead of dereferencing this NULL pointer.
> 
> [...]

Here is the summary with links:
  - [net-next] lib: packing: catch kunit_kzalloc() failure in the pack() test
    https://git.kernel.org/netdev/net-next/c/1405981bbba0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




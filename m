Return-Path: <linux-kernel+bounces-318093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC2496E841
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 05:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183DC2863A3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 03:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201CC4E1B3;
	Fri,  6 Sep 2024 03:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfeAMdJd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DB349627;
	Fri,  6 Sep 2024 03:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725593462; cv=none; b=iTtPBDv/kwVbJTu1gVP7L3x+t/wqHXvGMwm3aia6/3cp27v90siisysJwUXkLN5vznKLnPP1ypMKXseA2Pj92FYoE6kJPzDGVe6Chgi1gLV+sGwCqkxb1YHpGbS8atcGqiwimAsuEseAWfAnyHUzwCsl4InEWHnNroV66eqxalk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725593462; c=relaxed/simple;
	bh=JFpYOVn/44Ce2ylA+aIfBxLo+51Gsl6VpzW/3PYS8dM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UhDclCkMU/h5F37E8mvyRo6IkaQ6c0NxeHsSL3TeYdv8n+2K+L69t5NO8lhQkUswko2y+u7jdOqxoNRulSUzWBv7BpB2FzKFGEKzJl3GNswjLoWRpdaeB5x72ZN4MoDK1Q1kSU0RPjYdWUqLUGG/kIH98B3ngRnQP5/JSSxg5oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfeAMdJd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B75DC4CEC9;
	Fri,  6 Sep 2024 03:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725593462;
	bh=JFpYOVn/44Ce2ylA+aIfBxLo+51Gsl6VpzW/3PYS8dM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kfeAMdJd9yRGCdZnQ5mkjDI5A2ObfNHPR4RRpe2o9FtItxTZl3jHjh5j3EAVQhTtC
	 DXftEiloz5yb3DyX1EVVdpnEGth6s8wJjsaHD20tRzBkRsRRG10xQfS2FxkVWDujMf
	 JPkWtWE+DZjT6NUtgozvRvH+cMqLBBk4nwx5EqVB2afw6wvvKj/GkyFcxk+bPmiUi+
	 A4guZJIoHGPS88lMxOQxsQufVV2GIVKEMc8KPImQb+m7sD/Ll2DhwO/kel+PxCURTD
	 Z8zUFSxTu8qpbmxUrpDQu4sqT0RdZzRjQmEGwDhyYaHkisFWx8JayUlZJSYbEg4nzX
	 zKSxKLDs2WEZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 50A973806654;
	Fri,  6 Sep 2024 03:31:04 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: napi: Prevent overflow of
 napi_defer_hard_irqs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172559346306.1921528.17445029403392757877.git-patchwork-notify@kernel.org>
Date: Fri, 06 Sep 2024 03:31:03 +0000
References: <20240904153431.307932-1-jdamato@fastly.com>
In-Reply-To: <20240904153431.307932-1-jdamato@fastly.com>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, edumazet@google.com,
 kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, corbet@lwn.net,
 leitao@debian.org, aleksander.lobakin@intel.com, johannes.berg@intel.com,
 jamie.bainbridge@gmail.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Sep 2024 15:34:30 +0000 you wrote:
> In commit 6f8b12d661d0 ("net: napi: add hard irqs deferral feature")
> napi_defer_irqs was added to net_device and napi_defer_irqs_count was
> added to napi_struct, both as type int.
> 
> This value never goes below zero, so there is not reason for it to be a
> signed int. Change the type for both from int to u32, and add an
> overflow check to sysfs to limit the value to S32_MAX.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: napi: Prevent overflow of napi_defer_hard_irqs
    https://git.kernel.org/netdev/net-next/c/08062af0a521

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




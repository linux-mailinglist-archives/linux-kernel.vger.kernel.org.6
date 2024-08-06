Return-Path: <linux-kernel+bounces-276839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BAD94990A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2BB01F245DF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E3515688F;
	Tue,  6 Aug 2024 20:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrUZz06T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7591440875;
	Tue,  6 Aug 2024 20:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722976081; cv=none; b=jF5bKqY3ADJnMbvLqV4y+Lq3fNSIqCtFG5Q7V7v/Y0+6y9ZgF1gZ4BPkSg9SQOPKUp7a5aH7z/uN7RD9DdOviY2Uf5s/PGX2AYNQu55oUCQijdfoURHT9FzMZLsrfgZGYxBzsRvDD1X7Etw6sMlDXTqk/GyGYW+4bXY5qdFQ2kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722976081; c=relaxed/simple;
	bh=PoyDOtS7MnlY8J10/7ZLaQYnqWZiUxqKFsv2laWRwKo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hm9uqpD/8vks6edJFZCWPd+PTEGDxMNRnWXGohiNXwpVuGSkXoxGh/nIz6S86MC1FkG4Y7eqPNtM5k8mDrJ0guoZFA2Z7YjS7BkgC/u3FK+YH6i1oopFvUv134bMXq3hMJWVIRXOuvUgwqU5G0NwdptjLPPccuwtW042G18/FU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrUZz06T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00595C32786;
	Tue,  6 Aug 2024 20:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722976081;
	bh=PoyDOtS7MnlY8J10/7ZLaQYnqWZiUxqKFsv2laWRwKo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CrUZz06TwdkPJ98kwp0q9ok4TfSl073/0t83kOWB5usq3fqNXB6GYArTWxPffQYX3
	 JOJCyYYupWdQELGurfas5XcVsYwlAdX3HmPrldcNtfQaOnpMVRRxos+a8mEBvnfcEg
	 5l+Is/Am6Z4PYuZURfgoogxe+okPSyu/xpv3YJ0m2uJaBltj0jCyx8ZqPQtIiCYbEb
	 hv1jaDipNlNx4vhxk7BzOrFnojaagFxF0Oxs7Qc++3wEhdIs91uvch4TISWZ8KuerT
	 sJLvwVDpOYkobcC70YD069vHJOeTc1oduOe+OxzrjLhV7IDH2/VQya8bVtrD4q1Icl
	 hEP143O5AGeow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF383824F34;
	Tue,  6 Aug 2024 20:28:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: veth: Disable netpoll support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172297607950.1692635.16720160332883646837.git-patchwork-notify@kernel.org>
Date: Tue, 06 Aug 2024 20:27:59 +0000
References: <20240805094012.1843247-1-leitao@debian.org>
In-Reply-To: <20240805094012.1843247-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, leit@meta.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Aug 2024 02:40:11 -0700 you wrote:
> The current implementation of netpoll in veth devices leads to
> suboptimal behavior, as it triggers warnings due to the invocation of
> __netif_rx() within a softirq context. This is not compliant with
> expected practices, as __netif_rx() has the following statement:
> 
> 	lockdep_assert_once(hardirq_count() | softirq_count());
> 
> [...]

Here is the summary with links:
  - [net-next] net: veth: Disable netpoll support
    https://git.kernel.org/netdev/net-next/c/45160cebd6ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




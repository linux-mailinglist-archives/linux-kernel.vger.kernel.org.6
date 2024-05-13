Return-Path: <linux-kernel+bounces-178159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE6E8C49D4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 01:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 819DCB226FC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 23:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1787785939;
	Mon, 13 May 2024 23:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yjz6f019"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580F984FCF;
	Mon, 13 May 2024 23:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715641230; cv=none; b=cRHEbCdL6rfGumyPcAfXUFZYzRxtgRfcNrjoc0wxjANloA4u1+tHdXTPOl2PALvm1Qh1cI1da+PwFEc8oN3Pn6CGdMFFOojxqXYmTe9g1TqCtcvQopUaaFncCgWBf7S4RIlXKNnTDXGjKAuglCiMfnL+7EsEYBnBdZWXnkrcFFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715641230; c=relaxed/simple;
	bh=04zHvcqQ/IrQmnLS4EQOGLW0ACbRHLVX15Nck5Iv63M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Aj8s92uJaBORcpxjxESDdJhOyCgh7QYAA7I8gE21kI4oBRiELY0p3ANpbBy5lUJ6Kayrkcu5GV0aUCqFlUahR4JY/fzuWlNPjyjizRsYbdqSnx1ze+j1kOJO4QQm0STPl7773+/4VgEYdd8JYkfww4GJXUoRzlgonPhmuTjUtQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yjz6f019; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D97CEC4AF0F;
	Mon, 13 May 2024 23:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715641229;
	bh=04zHvcqQ/IrQmnLS4EQOGLW0ACbRHLVX15Nck5Iv63M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Yjz6f019JiVq57W9dTaSikkvhicTwjI6zvIAJ0bLavbVprNtS9UO6g+QQisK115Dh
	 NQkOR5mzAzZSJNiH/7SnLyX0S2CrPH5zlNiQZ7vIUPGPHPyyx3qKA/L1hQsNmnJ8DQ
	 Kw60HD4vVcFtAuaNN1hDZnyxZvZF6Et6aJD8cOej/n/Rk8V3V4djHjS6y3apFB4s2b
	 AIMlvw19SAxZusg+uUs49u+wHbJ637v4bUOCs8K1myNyMsaiXSopPY3a8kPaioFe4R
	 R6bE9cbNwsOOpstwFTsZWkTU+0dUp2cGRqJyXHpyUCFASXGUAugKiatRDlIo+SI/nA
	 pF3dzMi7uGT3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CB764C43443;
	Mon, 13 May 2024 23:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] l2tp: Support different protocol versions with same IP/port
 quadruple
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171564122982.1634.17490203085538677634.git-patchwork-notify@kernel.org>
Date: Mon, 13 May 2024 23:00:29 +0000
References: <20240509205812.4063198-1-samuel.thibault@ens-lyon.org>
In-Reply-To: <20240509205812.4063198-1-samuel.thibault@ens-lyon.org>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: linux-kernel@vger.kernel.org, tparkin@katalix.com, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jchapman@katalix.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 May 2024 22:58:12 +0200 you wrote:
> 628bc3e5a1be ("l2tp: Support several sockets with same IP/port quadruple")
> added support for several L2TPv2 tunnels using the same IP/port quadruple,
> but if an L2TPv3 socket exists it could eat all the trafic. We thus have to
> first use the version from the packet to get the proper tunnel, and only
> then check that the version matches.
> 
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> 
> [...]

Here is the summary with links:
  - l2tp: Support different protocol versions with same IP/port quadruple
    https://git.kernel.org/netdev/net-next/c/364798056f51

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




Return-Path: <linux-kernel+bounces-370165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 808F79A28D4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B18201C20FCF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1FB1DF747;
	Thu, 17 Oct 2024 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOdPxAaW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE28C1DF729
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729182629; cv=none; b=jAQuFy4mMs7pr/Ir7eZTwr1+SdMSvgCFUf6rEisOQa0hDHhVMwaBEXX/tKNQiPn0KtSvf2oLeTCKRAGB+vaACcGaXmES+8bhLw36GoI9zd3Ln83yKy6LdcR5SPiU/A0HmDS5XkJWhv8T5SXBdeU+kQc9pXmLtSxaTRZ9H0e7xPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729182629; c=relaxed/simple;
	bh=nAWLdZX91eIJ11BlrVEiY4ELlhecxxPurMVmz9N9nJU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pQnHyjkBwxgP0N83wey3x+hKe+coZn3RV4cRnFGGlJNe+ETt4uDW7FBItNghk86Jrh4dmzR0YaG/odPlF1deeOnz6GDdkpBca/d0ZkuyGSnKn95PL8Jop1V/7QumO0DskHH+XHnSXKcD5NxFtBSrK9+I65ANMdDMi577L8xSgHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOdPxAaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40AE2C4CEC3;
	Thu, 17 Oct 2024 16:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729182629;
	bh=nAWLdZX91eIJ11BlrVEiY4ELlhecxxPurMVmz9N9nJU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gOdPxAaWZj61iX7yjafGJrl+oxhuJ4iNs+5b4EzTnqjP1Z5sLUpU0KnYnzOYGhRxZ
	 kk/sfLvvTAD6IQ9H/AgGvyLsKg1hJRbmVnsGM/CDS3gtWFSvkD7loorMNNw+hNyPVo
	 +5DRx5+5Z7oG5wjrHtz3Lf9jGs9ePKVwtQJP/wAwn4826nTWwLukQ2YLLoyCUSXPPi
	 XM/djyAgTfoohVWsEAXasJjsk96kRHKfT5BmTGPKBlSvqJ7Q73L/3UKqcshlWje4+S
	 LD5v7kUlstTkSVJ1dVe9Oxrt5B3Vyu2SMZEozoG1iTsS/J7HaeNegnv8c47+8x7pbf
	 pZ2RdVCbEop6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADD63809A8A;
	Thu, 17 Oct 2024 16:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Prevent a bad reference count on CPU nodes
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172918263473.2528145.2882493292845168667.git-patchwork-notify@kernel.org>
Date: Thu, 17 Oct 2024 16:30:34 +0000
References: <20240913080053.36636-1-mikisabate@gmail.com>
In-Reply-To: <20240913080053.36636-1-mikisabate@gmail.com>
To: =?utf-8?q?Miquel_Sabat=C3=A9_Sol=C3=A0_=3Cmikisabate=40gmail=2Ecom=3E?=@codeaurora.org
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
 palmer@dabbelt.com, cuiyunhui@bytedance.com, sudeep.holla@arm.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri, 13 Sep 2024 10:00:52 +0200 you wrote:
> When populating cache leaves we previously fetched the CPU device node
> at the very beginning. But when ACPI is enabled we go through a
> specific branch which returns early and does not call 'of_node_put' for
> the node that was acquired.
> 
> Since we are not using a CPU device node for the ACPI code anyways, we
> can simply move the initialization of it just passed the ACPI block, and
> we are guaranteed to have an 'of_node_put' call for the acquired node.
> This prevents a bad reference count of the CPU device node.
> 
> [...]

Here is the summary with links:
  - riscv: Prevent a bad reference count on CPU nodes
    https://git.kernel.org/riscv/c/9510c5b0db36

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




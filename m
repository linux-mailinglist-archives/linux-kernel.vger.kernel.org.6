Return-Path: <linux-kernel+bounces-232809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E20291AE88
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 19:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA2F8B252BD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF4819B591;
	Thu, 27 Jun 2024 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDglNNhZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F0C19AA4E
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 17:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719510656; cv=none; b=N8jAfkviZs+SKe8Uke8NF99w1lm0FPM4bNnYyD6rp+a7YCdi9U4aQyPaF74+ao8DJF55d8nXSzXSsaVkJGloeGBnAspsGqkcmzFMj9xvVAhtmIYOr75jMGdsQfowySSefeeEJjontPDjXrieKaWp/7i10GZTKN/JeiIGfD6n+l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719510656; c=relaxed/simple;
	bh=IuoqwMEEfuW08SxSHhqWl1UrUywBAnZMyB8ms2RBmAM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oc4s4TLdjaWUUvUHS6k5twrtYcjEcjK+ttN1xJNtw5JY19xrChRHwAhXTqP2zvDIefM99jfR61tEctTCj/KfmokbTJx0fjjewa5R1PhPOdaLrGMK3usHzm7BCoGVpWF7277TG1Zw6g5S8aQLf7oGTl04aYs2hvN3Rjr2vtc2U8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDglNNhZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A80CC4AF0E;
	Thu, 27 Jun 2024 17:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719510656;
	bh=IuoqwMEEfuW08SxSHhqWl1UrUywBAnZMyB8ms2RBmAM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JDglNNhZRPah2c7TvQOBVL17WWNRFWhiZS5NU3S/sk/24buJgMsxilpQ40dft3G3C
	 a+8CMV9xRTuKk05KmeQOroY7s2tM+aCQ7lxQPndzIb3owp0knl0/CNBjcUiE7S4/d8
	 Ry2O7OBmqF2CmskPpVRaGZz18Lij/Iiy1glkvoLZTNm8eKKU71m+5FtzJ+PPxS7CxM
	 +mF6SmchXTjZMIwWuPLV57KMVuBiGMR8OYNHIdZdEy1IQPPzH35AAO1AGl1yqP7bgb
	 0/ILf4OBdWLoAv6fQybj1S1lsI6vN8ptz8y2AJh1GFmv+Xqll51S/ltstqdAECSyrX
	 p/DZr/CtFYUlA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 73AB6C433E9;
	Thu, 27 Jun 2024 17:50:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Implement pte_accessible()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171951065646.6762.11396758328508305883.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jun 2024 17:50:56 +0000
References: <20240128115953.25085-1-alexghiti@rivosinc.com>
In-Reply-To: <20240128115953.25085-1-alexghiti@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sun, 28 Jan 2024 12:59:53 +0100 you wrote:
> Like other architectures, a pte is accessible if it is present or if
> there is a pending tlb flush and the pte is protnone (which could be the
> case when a pte is downgraded to protnone before a flush tlb is
> executed).
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> 
> [...]

Here is the summary with links:
  - riscv: Implement pte_accessible()
    https://git.kernel.org/riscv/c/50b5bae5be1b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




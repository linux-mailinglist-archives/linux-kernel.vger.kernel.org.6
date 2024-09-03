Return-Path: <linux-kernel+bounces-313571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2671296A723
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5999C1C22337
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 19:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD191D5CF4;
	Tue,  3 Sep 2024 19:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLOXNBrh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6381D5CE6
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 19:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725390634; cv=none; b=PKwtCsXyYOvTPFWsECShBbuOqql95Go5RU1F/Ngg5quRSihudBL65o2WND+vFrwcsEEZncJiaNalaaYCCZIPQj4+5ZDL43bFqg2ZPz78+RwIf5zVwlHzPr1aZmYEvELT1WajmiTVUcVr7EEghHodWIeWvGVkIS0q6NHILU9cbmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725390634; c=relaxed/simple;
	bh=dbJsHm4vu/RSU3Ppal7NFr4QAfyU+2VbOxwEdvEqMeM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=joKissbUEUa7sp2DwiejA3OddiDwN6bg2hrl/YHbG9kKYhUW/5FFvMyI+CiqIWYO7+zUbnlkcsfbWHYAyOL/SAXXtuT1ZlhNskDLcIAsTCqc17Vf+JvKODcXevaM+RFSnav8/AIYxK5OvWqgyZl5O2Pi/Sfr6O/BxAy7t53zp2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLOXNBrh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ECFEC4CEC4;
	Tue,  3 Sep 2024 19:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725390634;
	bh=dbJsHm4vu/RSU3Ppal7NFr4QAfyU+2VbOxwEdvEqMeM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RLOXNBrhMlkQcdBIl2bM4XLcrSbF/8dnZfCGvNZb4U7QdNox05yu53yeQJejkChz8
	 BzYYIhLcTaW9rsfLwXMQjLVju/jwYsAH77FQYZfbFTwSmBvXLF+NbR2lSVLO1s434L
	 5RfZw14WxoxgNRa0qZ6fXY/MKTBT63JxNC5iSJM1R2EWEwDDOqvbZDc69cYiWBJDxk
	 iMFZoiEd+Ngv/NUX8Q2RWLmam3HBu4JK8O/iDgkCHZiNNq5UaXSDtmb0K7cumPINqr
	 SPhOTpP4MUAQC/03VLgishKSd6wlzy5MU1DGD1iAnD8gIYz9rHDjrWN0H8y5BY917K
	 SxdAVcWhMoa4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71A703822D69;
	Tue,  3 Sep 2024 19:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Fix toolchain vector detection
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172539063500.409367.1817166858428512996.git-patchwork-notify@kernel.org>
Date: Tue, 03 Sep 2024 19:10:35 +0000
References: <20240819001131.1738806-1-antonb@tenstorrent.com>
In-Reply-To: <20240819001131.1738806-1-antonb@tenstorrent.com>
To: Anton Blanchard <antonb@tenstorrent.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 19 Aug 2024 00:11:31 +0000 you wrote:
> A recent change to gcc flags rv64iv as no longer valid:
> 
>    cc1: sorry, unimplemented: Currently the 'V' implementation
>    requires the 'M' extension
> 
> and as a result vector support is disabled. Fix this by adding m
> to our toolchain vector detection code.
> 
> [...]

Here is the summary with links:
  - riscv: Fix toolchain vector detection
    https://git.kernel.org/riscv/c/5ba7a75a53df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




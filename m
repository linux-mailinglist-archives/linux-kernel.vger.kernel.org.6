Return-Path: <linux-kernel+bounces-195924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DA68D545B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 23:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B217B25D70
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 21:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38F318628B;
	Thu, 30 May 2024 21:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L02GX94Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A64183A75;
	Thu, 30 May 2024 21:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717103431; cv=none; b=T47w/oKmMPtUfTrdtmJbWXNzvoZzHdb4sFZSdYCNeqgZrGEGavUpa5MMjoTmyu17Z2srFtqL6ZvLmJgLf/HNZUOL5/PJjLChBggVjR5aOUo6TYdXAbqtQvHgUKfoVvDG76LgCjp7l47NcRv0CBT4pa1AJPxF7tsowAVdspEOjqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717103431; c=relaxed/simple;
	bh=imwaghj5+sbOEUXtN0H+N4S2m2OApJlTIDRCmvWIFO0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DM8zzNLot1rh9O1pVXWZoye8quMpXwHj6CTvaNjbdVIC3uhDYzjOmPPYaBdTMSIxX/r8tGpCkedKrPq3TNf2Ii05+bWD0D0j91NONgtjwdiNTFmPzp5PuTkhcEvoUQ4IjNUE27UBAaEjpzuCQKMapizVtb2gmd7q7VqEbK34DWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L02GX94Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99D8EC32786;
	Thu, 30 May 2024 21:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717103430;
	bh=imwaghj5+sbOEUXtN0H+N4S2m2OApJlTIDRCmvWIFO0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L02GX94ZIqE3jNGEP3/mk6VzHkkns9PZu2ZFXHRhascBPvF406Fx0lhsRM/Zv6scG
	 Lhyrl6pVwJ6yrKORSf8lpFTE3hXLdrT0NYIliQjMlg8CbgsWkJd04FN+PLsor6hj7n
	 tzbzENePdDw6vhOTXbkSHhOgk7Y9ql7lDGZp6p32sgc5stqfIcZhJDJUsQVgkPcSpS
	 MCt8zu8IZPZCZMXnQz/DH7ZVgxM82Mr0fULkBUe8HjDqpOU9nvrJzkOPZlVXuMKWRi
	 MYqZ6eZ84uDetV7h5et8inTuNWblm+5ULn1Faflf/K5dUDuCHLzWCwAtioW7Q5xesv
	 hXDrZ1inkN1Lg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A81CC3276C;
	Thu, 30 May 2024 21:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Documentation: RISC-V: uabi: Only scalar misaligned loads are
 supported
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171710343056.6624.2242126513528878113.git-patchwork-notify@kernel.org>
Date: Thu, 30 May 2024 21:10:30 +0000
References: <20240524185600.5919-1-palmer@rivosinc.com>
In-Reply-To: <20240524185600.5919-1-palmer@rivosinc.com>
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, corbet@lwn.net, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, costa.shul@redhat.com,
 conor.dooley@microchip.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri, 24 May 2024 11:56:00 -0700 you wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> We're stuck supporting scalar misaligned loads in userspace because they
> were part of the ISA at the time we froze the uABI.  That wasn't the
> case for vector misaligned accesses, so depending on them
> unconditionally is a userspace bug.  All extant vector hardware traps on
> these misaligned accesses.
> 
> [...]

Here is the summary with links:
  - Documentation: RISC-V: uabi: Only scalar misaligned loads are supported
    https://git.kernel.org/riscv/c/982a7eb97be6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




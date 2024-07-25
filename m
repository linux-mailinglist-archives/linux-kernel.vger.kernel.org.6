Return-Path: <linux-kernel+bounces-262237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D4093C2DE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C77E0B21482
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECB219DF48;
	Thu, 25 Jul 2024 13:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="siZHhB8f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AFF19B3CA;
	Thu, 25 Jul 2024 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721913639; cv=none; b=FsMhwl8hGJe/mvUpYLx8VZSE3cIUMrIDtewak3zXeHlU9fBqC1fdTruN5nHaqWtzDHfZCXhsF36aP7Vgt/9ujF9AfN8bjELpPE/9Z1teh03G4Lpp7YWZL1wvsfKpHo+9WLGg6EwfCGYR8uY5cNtcy6LwZ8juu1G6wsn274rX7Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721913639; c=relaxed/simple;
	bh=VU016AbJh5L3ZwL7kApcuoKicYHOtsSYeeuPsrXTct4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bQXnKrCfsuojNbESgq8aStXz9HuZvTrfm8bjPM2tvcszCEKYf7Cy1S31GSlhD61CRMLxOlaPVIajOlh/uD41urqXZ738J7aKR+X7/BJsSAYhv0/emjvPwcpOorCnjLdBvL0ZMOhkL+LRUm+AtXGcFZtCtXa2/c9mgC9mr5oKiy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=siZHhB8f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B511C4AF12;
	Thu, 25 Jul 2024 13:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721913639;
	bh=VU016AbJh5L3ZwL7kApcuoKicYHOtsSYeeuPsrXTct4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=siZHhB8fFv/POj2NExEStNEaE5qOfcNIwFWu1U3nv7iaTOrI3JWkKOErwLgTIZMt5
	 TtXSLL/q/csMTLoavFLERs4L+FjXjMv+CTvPFxSvtrsZm8BIUdvmM7pGOejtt3WcRD
	 SystoXljQGVtVhWm0iUcuANBf+n0GKpAh+3sVGGvQjYY/itUZNI6oHTGKpeu85P2tv
	 7z9ZQ8/I23tWOCqg4EgBSgo+X7u1vqLKVVJvb3tw7PTggJj3Y+DpXtj/0p4ZY07zhU
	 QOveMB0tsNWtmUjku2JOV06vjTyXsDRP6Hq+ixdR+/TI8m7D7J0uLtkVcazzYeRkMN
	 V2P/+gsZz9vyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 523ACC4332D;
	Thu, 25 Jul 2024 13:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] riscv: Extend sv39 linear mapping max size to 128G
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172191363932.6240.15191198914787494944.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jul 2024 13:20:39 +0000
References: <20240630110550.1731929-1-stuart.menefy@codasip.com>
In-Reply-To: <20240630110550.1731929-1-stuart.menefy@codasip.com>
To: Stuart Menefy <stuart.menefy@codasip.com>
Cc: linux-riscv@lists.infradead.org, alexghiti@rivosinc.com, corbet@lwn.net,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sun, 30 Jun 2024 12:05:49 +0100 you wrote:
> This harmonizes all virtual addressing modes which can now all map
> (PGDIR_SIZE * PTRS_PER_PGD) / 4 of physical memory.
> 
> The RISCV implementation of KASAN requires that the boundary between
> shallow mappings are aligned on an 8G boundary. In this case we need
> VMALLOC_START to be 8G aligned. So although we only need to move the
> start of the linear mapping down by 4GiB to allow 128GiB to be mapped,
> we actually move it down by 8GiB (creating a 4GiB hole between the
> linear mapping and KASAN shadow space) to maintain the alignment
> requirement.
> 
> [...]

Here is the summary with links:
  - [v2] riscv: Extend sv39 linear mapping max size to 128G
    https://git.kernel.org/riscv/c/30c3ce044a70

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




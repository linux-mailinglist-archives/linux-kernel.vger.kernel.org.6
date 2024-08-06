Return-Path: <linux-kernel+bounces-276845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF999949918
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9843C283C42
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F3916C6AB;
	Tue,  6 Aug 2024 20:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAvUPekL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7AD166F0C
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 20:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722976133; cv=none; b=QeNSp/Bq0eiHJyUnKPn46Ih3/PV9ofUrEJJHPpvZl/vxsU91B3xlK9uxn6ZLgT2x1fBAeoidVwGb9dMxLhz5TdkBE0tDq1I/NgGhIm28qRpnpXGuy4KwdNvdDHIVd+rh/WtL/83kHb5C37ZY6cZ0rvrz2/HoJkM0UiYxNhbkfzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722976133; c=relaxed/simple;
	bh=eRU6lTfWk+3oWmmHeJiEsOh57khrS6jc6a+WsnE6j+k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iOImqSYywaPWbPdyZy6l/fztg9ofKUjEEiRWWLWMS46jMYAotA8JFSUK01da1Xc1FET9o5BAVVgVXDhEwFOQ1+OCxo9rXFJAfyurlwGjZay7ugxPtVW6N1WdQBdgBomLXHazsKvFaYrXo+zxTh2SaSs54aYKGPXAZ+G2I+xr7Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAvUPekL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0436FC4AF0F;
	Tue,  6 Aug 2024 20:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722976133;
	bh=eRU6lTfWk+3oWmmHeJiEsOh57khrS6jc6a+WsnE6j+k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qAvUPekLTTIn7fP1Kyzy5xefgZ16MXnoQWO8hQ7C5wjaQsrs2MuMFdtNsMLtWDyX+
	 fw7leww2LaDgvRO/ApHURhKUVIIBOIB+vcV4E/MQV/u0fW0Xyjp7sEdIeabRifXKCu
	 qu4DsGtFPuNYb5wYfy5EIpHNt2a+2/pzJGYrzTzsePd8vYjM9F5+SWK8t3sl4XhFRl
	 O2kKx4SAHtn7KY/96YOBfONoNOx35NXHvLrGrXGQUyA4UAgyWZdDesClbrclmUbY5W
	 xWKjFyJJjdPvcNkJZ4Mn+S8/1S/JktZN90a14kpL6bPpvBxEMPHOpju2odYbIUjpks
	 4RLUImDpnYv+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F3DC63824F34;
	Tue,  6 Aug 2024 20:28:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -fixes v2] riscv: Re-introduce global icache flush in
 patch_text_XXX()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172297613179.1692635.6654179302710248006.git-patchwork-notify@kernel.org>
Date: Tue, 06 Aug 2024 20:28:51 +0000
References: <20240801191404.55181-1-alexghiti@rivosinc.com>
In-Reply-To: <20240801191404.55181-1-alexghiti@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, andy.chiu@sifive.com,
 linux-kernel@vger.kernel.org, samuel.holland@sifive.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu,  1 Aug 2024 21:14:04 +0200 you wrote:
> commit edf2d546bfd6 ("riscv: patch: Flush the icache right after
> patching to avoid illegal insns") mistakenly removed the global icache
> flush in patch_text_nosync() and patch_text_set_nosync() functions, so
> reintroduce them.
> 
> Fixes: edf2d546bfd6 ("riscv: patch: Flush the icache right after patching to avoid illegal insns")
> Reported-by: Samuel Holland <samuel.holland@sifive.com>
> Closes: https://lore.kernel.org/linux-riscv/a28ddc26-d77a-470a-a33f-88144f717e86@sifive.com/
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> 
> [...]

Here is the summary with links:
  - [-fixes,v2] riscv: Re-introduce global icache flush in patch_text_XXX()
    https://git.kernel.org/riscv/c/ee9a68394b4b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




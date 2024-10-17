Return-Path: <linux-kernel+bounces-370164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B309A28D8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DA09B27D6E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C5F1DF26E;
	Thu, 17 Oct 2024 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5bcYVI4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B831DED7C
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729182628; cv=none; b=eu1ezvzTg/+O55kmwGm6S9vx/zM9ejdEZ591R+08peOTF5sMVQG19Alh4xx1UU6e/y5YiyVA6nYRGII8/Znmq8QfftRu54CfJaYNETNLH2X0/WhJ5taVFxzheG7JNpdNLqJiPHab92VUwWirjLd4p6/ypWS6hNVnkScFthiij3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729182628; c=relaxed/simple;
	bh=aVA2QxSCVNkbqcq/em21m98qo2fV/FVrPCoqpZFeCX0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jOb6QZoUPt5UUDMK+Mdv0H9mXiCn0i4ST5ec3wzh2lL5HzzOWAEXBI7+IL/qxwDCM9l9pNCGsZ0Eu4DyuOeGAXae/8S4pz9etiPaMFO8SojipHer7iovAquw7SibYMPgeI03xnGHxR9JQr3CXfFZ/YMTGR4ZMZ2RYbCY5EQCpGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5bcYVI4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0196FC4CECD;
	Thu, 17 Oct 2024 16:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729182628;
	bh=aVA2QxSCVNkbqcq/em21m98qo2fV/FVrPCoqpZFeCX0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D5bcYVI4iz5awwcJLIZXc55uINJNgXz6l2CrClolPGsE5BVdZ0e4RqRRb1/W2Noiy
	 FsO/fQRWV7g7Dx8K0p5sBmED+nNLZEpSZ6FKHGy6LJgZMJRoFrrmoEWcvXNpNWPije
	 h0N/zRZn7/iFOkNNCk3VMY64Ss6RWYYGTlpRV1lEWZscy2xwR4+7F4eU9P7cM/bPuw
	 JxjCX1EFD1d7FPFErP6kDMmhrY49k8MrY5IfXvFw0h68FtvTyX//fo4j/4JJm8/raf
	 LSIjxnGJwEOPFK9DUNL/KynOga6RqQqU5bhIwdGOtvSalivmS08HLWXHuwspSA4QUH
	 hcsLybHss/Pqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADB9C3809A8A;
	Thu, 17 Oct 2024 16:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/2] Prevent dynamic relocations in vDSO
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172918263324.2528145.12860614136206368233.git-patchwork-notify@kernel.org>
Date: Thu, 17 Oct 2024 16:30:33 +0000
References: <20241016083625.136311-1-alexghiti@rivosinc.com>
In-Reply-To: <20241016083625.136311-1-alexghiti@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, vladimir.isaev@syntacore.com,
 roman.artemev@syntacore.com, guoren@kernel.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 16 Oct 2024 10:36:23 +0200 you wrote:
> Patch 2 uses a generic function to make sure the vDSO object does not
> contain any dynamic relocations.
> 
> Patch 1 removes a dynamic relocation from vDSO in rv32 found with patch
> 2.
> 
> v2: https://lore.kernel.org/linux-riscv/20240705060902.113294-1-alexghiti@rivosinc.com/
> v1: https://lore.kernel.org/linux-riscv/20240326113831.283025-1-alexghiti@rivosinc.com/
> 
> [...]

Here is the summary with links:
  - [v3,1/2] riscv: vdso: Prevent the compiler from inserting calls to memset()
    https://git.kernel.org/riscv/c/f431f67ff6c2
  - [v3,2/2] riscv: Check that vdso does not contain any dynamic relocations
    https://git.kernel.org/riscv/c/fcb5dcb789a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




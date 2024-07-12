Return-Path: <linux-kernel+bounces-250521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 940C492F8D1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 12:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C534C1C216B1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 10:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A16158DB3;
	Fri, 12 Jul 2024 10:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msqPesQ9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BAB14039E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 10:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720779633; cv=none; b=fJoCng7XAjOkzf1ddKAddqMEwtqg9TVkn2QeEX+IC5o1sKMvZGHn1CgtF4ipCfu5dLN8sUYlvjc7WK1EJhmVcmC9t6TrQuZYpp72/brE/Ip4q9q5gLBrFfQNl+n9sunuDSaE1mYupb6fVgbLvokCIx0cNhFYhGWPQtKswlf+YyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720779633; c=relaxed/simple;
	bh=RnzPJHw3EtG6YPeqag1VcDrc0jcCFRsUX3IkvXy3Ve0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DqbCi/7frXs7gAPf6Frpo0sa4E4+Fwr8u0MDPSQgxJysofMgjB900wYISGjZCqUvtiuODR4XTX+1PO/igtX88Bo/0tN7d29gVTNIVF5OhdhtEkLgpCvMfpIUMzLkxWdHrUO7/zYDdFCrSORZX3Z8AGouZ2rxaTsKKeZxfLpm7GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msqPesQ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 907F9C32786;
	Fri, 12 Jul 2024 10:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720779632;
	bh=RnzPJHw3EtG6YPeqag1VcDrc0jcCFRsUX3IkvXy3Ve0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=msqPesQ9wVhM/XWK4aYizxpJJ7lkb1dmKJ38Z9MbAtBsF7wkZcmmrhhuqIBV+AVUW
	 y2vhp9Ch30Gvfb6HXrqoSDFdT9uVdTpoBtaKQGLy4yzI5Q+zY9YMBR8C9vruwjVlVo
	 2QMXHKxDpxWh1No3MT3/FdoB6LN8RnNA7qd7pbzmzWjcZ+WUM2OvjgsCQjABaFRRTl
	 q6iaKa3V7TZUy9EBrbqRaIFQr0xPlpIbs9mrV7tsp8h5F33c8mf8mxSMou3Q2lE8ml
	 GXCRV/ejOYHpowe3NITlXDXQypWa0Azf8UxAxPGQADefcMcFYDN6CtNCZSLNI/++ZI
	 yuolv06Wp3b9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 85C52C4332D;
	Fri, 12 Jul 2024 10:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Improve sbi_ecall() code generation by reordering
 arguments
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172077963254.4770.3789114985844710075.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jul 2024 10:20:32 +0000
References: <20240322112629.68170-1-alexghiti@rivosinc.com>
In-Reply-To: <20240322112629.68170-1-alexghiti@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, samuel.holland@sifive.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri, 22 Mar 2024 12:26:29 +0100 you wrote:
> The sbi_ecall() function arguments are not in the same order as the
> ecall arguments, so we end up re-ordering the registers before the
> ecall which is useless and costly.
> 
> So simply reorder the arguments in the same way as expected by ecall.
> Instead of reordering directly the arguments of sbi_ecall(), use a proxy
> macro since the current ordering is more natural.
> 
> [...]

Here is the summary with links:
  - riscv: Improve sbi_ecall() code generation by reordering arguments
    https://git.kernel.org/riscv/c/16badacd8af4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




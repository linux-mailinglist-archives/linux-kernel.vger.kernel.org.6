Return-Path: <linux-kernel+bounces-575834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF87A707C5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ED5C188D830
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43B5262802;
	Tue, 25 Mar 2025 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="itv3wHSz"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3560525F988
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 17:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742922615; cv=none; b=K3V80mpDIxcIoN3qG/R680qz8WlzGV6/1RNhebVKoZ6KSXYoV0YSDDtEVGN/x8uvzv30wRLwzfZh0HOUXhMgYj2KzmqWdwYrZrLJsWln/IZhGXVMJ+3TT7sDuQZW6rSGLf2VivRtdaRHVYurC9nJUe3+OLjNw2zlgEX+u5fHUrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742922615; c=relaxed/simple;
	bh=VTzh6p8sdLXgtm1dcyU8A3yPyAfqZP2PURip12/aE/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+8F6jFy9W4dp+xSK8p3BHc8viDtqervFIL+4UKeUrMLnd4Ws44rgCJmR05gAf23ywdzOaPrcOW3mFm39sPhZkpvUTcCSYlFjG+hCk7KzL7iD8iAZ+Vqe1t4Sr//bmVWuf3zk3quClxcGAX0qz75U9Nz/gYPNpoz+zBGUPkkcn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=itv3wHSz; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1176140E0219;
	Tue, 25 Mar 2025 17:10:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ESc8JYNbU0sP; Tue, 25 Mar 2025 17:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742922606; bh=xuW+1acWbyIXSc6I4FgAnoNPiRSbNAyPu57oGWJiKRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=itv3wHSz/vRFGCJuRGswigasZzUZ/h3avnPbR6adgie+8LPdiiiSaWgrL5vpgd6Pw
	 cNtcmIVlCZQIR0Onj+lEGlKAAhdyAeYxhY3xYZvGzWZZP4p7wpkXgbzjVie4Le6SCw
	 gR0b9XOIwHYqjaA2S90GqFIgtrNYseGsH6f+mZRFKtxivw18TDdjvSWKr35US2tmz7
	 KUFCkezVLS97Fu7coHh0Yjrhy4bwnQNqqNtbE/bobK/VyFN7MY6ETNn+960vFdjImS
	 q1VQqb5400Iz//VLTBM+HSbt2qBxFLmzqqUVzYPgQiB5OpeAKP0FiuPceA39wcYJCu
	 Huc7WMuqKDysnfcYRQy9aSgn+laOaGM4Nhmy3YhTOrOZxt2axZT1sJ/KrgHNZeygEy
	 A6JZfw6ddKFnin/seZ3Pa3iOu6BUsnaCXFyFUFZ9w10PNO5y1Hxov8FnGcLCCLNFIG
	 WZNILA5TJBR162V59psWI5fGymmR2Kc7RnjHPWJtgLr3AEp9lz75h8YNHPD/PdzfsK
	 aZdB0zBAmRihTpa8VY5lT5JLlS8++ZhogNAnKDq8wc0fSgJNbgjTFkvY1fImazy3sW
	 qpLotoa72STtkfkWhXmtcK/mXmz1ZtKYDwW3WS6pRHrMkK3rmh+r230iJ1XcAnq0lf
	 RBPkOG4G42uMCL2J2Pc79Ia8=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1C6F040E0214;
	Tue, 25 Mar 2025 17:09:59 +0000 (UTC)
Date: Tue, 25 Mar 2025 18:09:53 +0100
From: Borislav Petkov <bp@alien8.de>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH -tip 1/2] x86/hweight: Fix false output register
 dependency of POPCNT insn
Message-ID: <20250325170953.GCZ-LjYdl4rftqY-us@fat_crate.local>
References: <20250325164854.199420-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250325164854.199420-1-ubizjak@gmail.com>

On Tue, Mar 25, 2025 at 05:48:37PM +0100, Uros Bizjak wrote:
> +/*
> + * On Sandy/Ivy Bridge and later Intel processors, the POPCNT instruction
> + * appears to have a false dependency on the destination register. Even
> + * though the instruction only writes to it, the instruction will wait
> + * until destination is ready before executing. This false dependency
> + * was fixed for Cannon Lake (and later) processors.

Any official documentation about that?

Any performance numbers to justify that change?

Because if it doesn't matter, why do it in the first place? Especially if
you're doing this XORing now for *everyone* - not just the affected parties.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


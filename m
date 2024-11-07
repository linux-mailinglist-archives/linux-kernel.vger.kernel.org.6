Return-Path: <linux-kernel+bounces-399536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 967C49C004A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E12B1F21F4B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 08:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A071DD88F;
	Thu,  7 Nov 2024 08:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="M/4lmfPE"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0EF1D9341
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 08:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730969107; cv=none; b=IIeKsAtw9uAWrjZkoJMp+Efz4stIs+hIwUf/Z4iz89LFixdXFJU0PsHcKcAHJ99OL2VJ0xE2n0wXpPFUz38FtefKyN9rSCdh/9PN9thMpPMMhQZmhTNH/CukpeSGSzlGQ6tqHEp33DkI7PVZjLR7WJMa8MdFlCG+rZ4gSnVyxpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730969107; c=relaxed/simple;
	bh=H0z/cKKO/vGA2TVwHat1Uphf6X+ZhbN7sSt0JKrbcn4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gBokuMQVeDjIkfm+P01/j64/ydlQSat08tYV61bqSm569HybpLJzyXJKbvr5kZgW4t4KMw3rTF2Gkma0dAKN1Xo2Rh9ed4FemA4ETj7jBHCHKA1HpbWYVpu9lMh1Uo018X2VEeWSkZj4kZCm9beruBf9ubjau32+oqrAGhQmgjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=M/4lmfPE; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1730969101;
	bh=qv+lXZk9AxiBXOukRl42TWk9GVsab/O46laDxhRM5hE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=M/4lmfPEFRH6/1lbGXZBiuQuWuN2f8FgVMgompeW9KGF6Se4j/TxtUiG5cI8liugR
	 DKqNkDPNEh9c8Dsncmnhna5GB/rb/gUG0Sf4CeGKiVe5fELEqOus4gH96I2F0P5539
	 b3wn8WIYcWynrYfX9RKuvDYCQ7shNlF+dqtmKr1uhmpFyNpgL3mOWcEA6V+G3Wcv/G
	 KEH0oZh3ZfLj7EZBtS2poxP7EoIohkWX9Q7qGxnnEN9gNRwXyN3kuTMIUpThnoC7f+
	 6ixUqafHF1r/Rm2cC7JqJq5OjIW6VIWnCqRD/lynN3imW71Lhgo3FhmD0fDC5nrgYC
	 /DeAjY60zFUrA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XkbHK1YtXz4xFt;
	Thu,  7 Nov 2024 19:45:01 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20241013102957.548291-1-mpe@ellerman.id.au>
References: <20241013102957.548291-1-mpe@ellerman.id.au>
Subject: Re: [PATCH v2] powerpc/64: Remove maple platform
Message-Id: <173096894650.18315.14444465278023846329.b4-ty@ellerman.id.au>
Date: Thu, 07 Nov 2024 19:42:26 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Sun, 13 Oct 2024 21:29:57 +1100, Michael Ellerman wrote:
> The maple platform was added in 2004 [1], to support the "Maple" 970FX
> evaluation board.
> 
> It was later used for IBM JS20/JS21 machines, as well as the Bimini
> machine, aka "Yellow Dog Powerstation".
> 
> Sadly all those machines have passed into memory, and there's been no
> evidence for years that anyone is still using any of them.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/64: Remove maple platform
      https://git.kernel.org/powerpc/c/62f8f307c80e99ab18d38aa1a5bbbc18128ee5f8

cheers


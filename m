Return-Path: <linux-kernel+bounces-283039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1870C94EC3A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C97A4282664
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB36178365;
	Mon, 12 Aug 2024 12:00:36 +0000 (UTC)
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D671366
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 12:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464036; cv=none; b=A7yXqhao92rUW6s0okmyAvixg0pOEXhjyi/DoIu2cXm/MLFNpPF0fgdA5vjvXASYUCi1cJxxaPScd6AP+mJrNM0Ump1IXTPu0wZMtCEOksBXt2UcI+w6jxOLv//Pg3jvt9iu4OsCB+K2IKQJEuX7pBKcVG/Cj6t2T6bEp4Y5dkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464036; c=relaxed/simple;
	bh=DtvMHjIb+ssOcYkY+Pd6DX7W0xAIRAmDP1F36VvmQMk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bM2DpCh+rFnqfbvO+rd2o052VwIYFAivkVlHmynpcZRHBjmEJ43b4vEiLlBLPDIRI2BtOaA+fsy87BrwrPSpHAhfTK4fgJPiWZk9Fh+9dEnAs3XfI/Y6I7RMTyZS4jcK3Ne6lbjHXM5f1co/Yjy6ixVgqp2B7oqh2yy0oESvjcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WjCl30rGXz4wcF;
	Mon, 12 Aug 2024 22:00:31 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <62b69c4baad067093f39e7e60df0fe27a86b8d2a.1723100702.git.christophe.leroy@csgroup.eu>
References: <62b69c4baad067093f39e7e60df0fe27a86b8d2a.1723100702.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/mm: Fix boot warning with hugepages and CONFIG_DEBUG_VIRTUAL
Message-Id: <172346398146.772106.14579247166492257362.b4-ty@ellerman.id.au>
Date: Mon, 12 Aug 2024 21:59:41 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, 08 Aug 2024 09:05:08 +0200, Christophe Leroy wrote:
> Booting with CONFIG_DEBUG_VIRTUAL leads to following warning when
> passing hugepage reservation on command line:
> 
>   Kernel command line: hugepagesz=1g hugepages=1 hugepagesz=64m hugepages=1 hugepagesz=256m hugepages=1 noreboot
>   HugeTLB: allocating 1 of page size 1.00 GiB failed.  Only allocated 0 hugepages.
>   ------------[ cut here ]------------
>   WARNING: CPU: 0 PID: 0 at arch/powerpc/include/asm/io.h:948 __alloc_bootmem_huge_page+0xd4/0x284
>   Modules linked in:
>   CPU: 0 PID: 0 Comm: swapper Not tainted 6.10.0-rc6-00396-g6b0e82791bd0-dirty #936
>   Hardware name: MPC8544DS e500v2 0x80210030 MPC8544 DS
>   NIP:  c1020240 LR: c10201d0 CTR: 00000000
>   REGS: c13fdd30 TRAP: 0700   Not tainted  (6.10.0-rc6-00396-g6b0e82791bd0-dirty)
>   MSR:  00021000 <CE,ME>  CR: 44084288  XER: 20000000
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/mm: Fix boot warning with hugepages and CONFIG_DEBUG_VIRTUAL
      https://git.kernel.org/powerpc/c/e7e846dc6c73fbc94ae8b4ec20d05627646416f2

cheers


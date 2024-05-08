Return-Path: <linux-kernel+bounces-173344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0598C8BFF22
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2092287A62
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4597127E11;
	Wed,  8 May 2024 13:42:02 +0000 (UTC)
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1E886629
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715175722; cv=none; b=WSaSepJwNqy3zhDhOpfsxQKSVz7gmeRNsnFj7GBDH+FjMLRq/AamD/LCWi+DGraRFUTI0f+153BldK5nXjHY+MXV+0ZK9bkacqDD6ejhBUoMG4G/AHX+R4lMsGap34KoLVEa32QpFfGMu0RQzt6RXoatQBsX60z2heTU0pXoQRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715175722; c=relaxed/simple;
	bh=RXHSKMLHZrN5WJW3gPBJ+WFN36aCE7TQwQgyl5eudkQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ljYsKJC41hBAuc2MDI+Pm2qQFAvBPrVM0dJhguWtOSYco2KCKvflwe2gPaeUFVWjnKja80PffuTTiT3OJV+wXzg7zdGbLYQjzP2TKYQKN+HxR6ZbmjLi30MYxpOr6dUZwbx4lBNEWLudH0eNpZvjp6ZPORi04x05viMfWwkN9Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VZGXS5NX9z4xKZ;
	Wed,  8 May 2024 23:42:00 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Cc: arnd@arndb.de, naresh.kamboju@linaro.org, linux-kernel@vger.kernel.org, nathan@kernel.org
In-Reply-To: <20240503075619.394467-1-mpe@ellerman.id.au>
References: <20240503075619.394467-1-mpe@ellerman.id.au>
Subject: Re: [PATCH v2 1/2] powerpc/io: Avoid clang null pointer arithmetic warnings
Message-Id: <171517558549.165093.14013162517942082900.b4-ty@ellerman.id.au>
Date: Wed, 08 May 2024 23:39:45 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, 03 May 2024 17:56:18 +1000, Michael Ellerman wrote:
> With -Wextra clang warns about pointer arithmetic using a null pointer.
> When building with CONFIG_PCI=n, that triggers a warning in the IO
> accessors, eg:
> 
>   In file included from linux/arch/powerpc/include/asm/io.h:672:
>   linux/arch/powerpc/include/asm/io-defs.h:23:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      23 | DEF_PCI_AC_RET(inb, u8, (unsigned long port), (port), pio, port)
>         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   ...
>   linux/arch/powerpc/include/asm/io.h:591:53: note: expanded from macro '__do_inb'
>     591 | #define __do_inb(port)          readb((PCI_IO_ADDR)_IO_BASE + port);
>         |                                       ~~~~~~~~~~~~~~~~~~~~~ ^
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/io: Avoid clang null pointer arithmetic warnings
      https://git.kernel.org/powerpc/c/03c0f2c2b2220fc9cf8785cd7b61d3e71e24a366
[2/2] powerpc/64: Set _IO_BASE to POISON_POINTER_DELTA not 0 for CONFIG_PCI=n
      https://git.kernel.org/powerpc/c/be140f1732b523947425aaafbe2e37b41b622d96

cheers


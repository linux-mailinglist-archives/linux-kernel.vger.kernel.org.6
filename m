Return-Path: <linux-kernel+bounces-318856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3002C96F42F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A9031C21ED3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFD21CC898;
	Fri,  6 Sep 2024 12:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Sb+7s+S2"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E021CB313
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 12:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725625392; cv=none; b=icIvKnn09fDflTIDWYOBXYUULuNZAZLqPfMrM7RxbdfW5xVvqQOV1hhz7fsgJgQIL4+FPFcf+Li82CZVEh5sVcN+9jy2vLxpE6rK/bhmGHwN37I6UeMV08af30A+HoBy4RsiMrXkmFFVAa2A/VDGYClzQEXlozyEZW/ELv5f5l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725625392; c=relaxed/simple;
	bh=VkVcwn5TSgVlGZ1p9iHuj6dpkC8/3GPX/Ky2q5dzUZM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dN9hLpGMUPyrLidAXfunyc40JVVvZ9jnrQ4Bdmf7vV0DqnhL1fOeBrAmna8iHN1y/GlxEJz8pSykvenxVnyY2LmDlr07+RXaYm7F6x+qGRq7nwsGt8+B3isdOBEHNMgFD0C24MBGwufojZI2eGs0R2sCsW5z0jLZnYYUE0zx9MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=Sb+7s+S2; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1725625389;
	bh=Z4xBDj54/zEsffPCiXYIbhd/s4U8lTqDOAsUvroIj1I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Sb+7s+S2GugNKnapA55T+at8h3IT/oUHP2tS/vyrOkAoIck5w3tiBzsvL1CAVt1Cu
	 GBIVwQCeRess/ZRAB4OdrtAESROxkdyiy+GnePKxyQTlaAUvU10aBdYE/fem2G2Kh/
	 l96I2XtTYTN7jQIyOoXqSz46zlmFy6+DiZj8QeWvyRIb1ywh+8f2QK7FNzXitW/vcx
	 OnLb1oMsdkeuoUTBoC6eD0WFhk4o1VlhrxgndSqa3y/ABLpt4L+6UqoQqVYl3CUOaS
	 1oEudgOTPqBCpZRIWqAxT14g4BNXcDOLDMgftP0SCPkmElj1R3goQpiu27Rmhv5J+C
	 vVola/aR3IyPA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X0b3c5RBDz4wyh;
	Fri,  6 Sep 2024 22:23:08 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, "Jason A . Donenfeld"
 <Jason@zx2c4.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Nicholas
 Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, Vincenzo
 Frascino <vincenzo.frascino@arm.com>, Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH 1/2] powerpc/vdso: Fix VDSO data access when running in
 a non-root time namespace
In-Reply-To: <700dbf296d02e32376329774be35cfbead08041d.1725611321.git.christophe.leroy@csgroup.eu>
References: <700dbf296d02e32376329774be35cfbead08041d.1725611321.git.christophe.leroy@csgroup.eu>
Date: Fri, 06 Sep 2024 22:23:08 +1000
Message-ID: <87r09x3r9v.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> When running in a non-root time namespace, the global VDSO data page
> is replaced by a dedicated namespace data page and the global data
> page is mapped next to it. Detailed explanations can be found at
> commit 660fd04f9317 ("lib/vdso: Prepare for time namespace support").
>
> When it happens, __kernel_get_syscall_map and __kernel_get_tbfreq
> and __kernel_sync_dicache don't work anymore because they read 0
> instead of the data they need.
>
> To address that, clock_mode has to be read. When it is set to
> VDSO_CLOCKMODE_TIMENS, it means it is a dedicated namespace data page
> and the global data is located on the following page.
>
> Add a macro called get_realdatapage which reads clock_mode and add
> PAGE_SIZE to the pointer provided by get_datapage macro when
> clock_mode is equal to VDSO_CLOCKMODE_TIMENS. Use this new macro
> instead of get_datapage macro except for time functions as they handle
> it internally.
>
> Fixes: 74205b3fc2ef ("powerpc/vdso: Add support for time namespaces")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
 
Oops.

I guess it should also have:

  Cc: stable@vger.kernel.org # v5.13+
  Reported-by: Jason A. Donenfeld <Jason@zx2c4.com>
  Closes: https://lore.kernel.org/all/ZtnYqZI-nrsNslwy@zx2c4.com/

Jason how do you want to handle this?

I can put patch 1 in a topic branch that we both merge? Then you can
apply patch 2 on top of that merge in your tree.

Or we could both apply patch 1 to our trees, it might lead to a conflict
but it wouldn't be anything drastic.

cheers


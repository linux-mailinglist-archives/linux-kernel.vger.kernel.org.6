Return-Path: <linux-kernel+bounces-413793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC399D1ED0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 04:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F9FD1F223B6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 03:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F871448DF;
	Tue, 19 Nov 2024 03:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="UpYG0Y2Q"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BB82B9A6
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 03:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731986791; cv=none; b=DFnzUhyzynQFAJo4iu0W0vhnEEWL31XgRhYbe6FysINtdP49bgPeL5HFf1Tpdoz0Z/jJ67TK5pidrc88g8sfGFqp/o+HxQCRlt9nIjoigNe+PGbMDoiaAn0AV3eAYEewkRCgJf0fq7kuwtpgZEuRrhYdkJzzwxC8/8qWckQ4XMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731986791; c=relaxed/simple;
	bh=xW4QUkmncSLwmAR/ALJcKogsYuh3mspLR3WbZK8mXkE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gHKx+4Ngy3VpFRVzKK8knojxL1OQBfahaKceGIJb0yrU3CA8HEMEs8FJy5aeKjnIm1AMlHxs+CB3nySVY5IoXyBuURXa5Z0ubRJ3L0gL8QgSCnHSS07x+LKwRI/BCpeKFslNALCInq+Uo/6efGpytbtn/jUFW/iN66AC+2b2EcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=UpYG0Y2Q; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731986781;
	bh=BXuxAoEzRYb2W+q6kELsZbpr1GUjRm1uGV4br+FTP7w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UpYG0Y2Q+xU1kzReEfRx5MofeOR1o4vGyM25YhdBiR8Lx+EOPjCfbaIcrhb9cf4g6
	 Lf7vWEatg5c/G6GcLWxPnChn/fQuLFD/epwcaIJXZXje6PFHsmWOAP7qbpBsuAmlDf
	 paNMrRffnYqhjMsL1yRj8HybfEbp7G/uP1EUuftUl0fOkpxvUejVxEI4ajmdehXAre
	 5oqJ73c6b/1hqwIeJudU582guetJkS7F5eJ8DpSyZZdJ19RuVmp0dhrWeGFhQ26V04
	 J2tyqPzjX8JVra6yiAWuOy13WrX2HjFp1xjNsiAXYx6W82XizaQ2rV/EEj+z/m5uBj
	 BejTgqLfCxIDQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xsqf40ZX5z4xfX;
	Tue, 19 Nov 2024 14:26:19 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Michael Ellerman <patch-notifications@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/vdso: Remove unused clockmode asm offsets
In-Reply-To: <20241118075902-8b0cf2ea-d772-4c05-9b5d-14aba194e649@linutronix.de>
References: <20241113-vdso-powerpc-asm-offsets-v1-1-3f7e589f090d@linutronix.de>
 <173184539749.890800.8297350541963703609.b4-ty@ellerman.id.au>
 <20241118075902-8b0cf2ea-d772-4c05-9b5d-14aba194e649@linutronix.de>
Date: Tue, 19 Nov 2024 14:26:22 +1100
Message-ID: <877c8zj44h.fsf@mpe.ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de> writes:
> Hi Michael,
>
> On Sun, Nov 17, 2024 at 11:09:57PM +1100, Michael Ellerman wrote:
>> On Wed, 13 Nov 2024 09:06:58 +0100, Thomas Wei=C3=9Fschuh wrote:
>> > These offsets are not used anymore, delete them.
>> >=20
>> >=20
>>=20
>> Applied to powerpc/next.
>>=20
>> [1/1] powerpc/vdso: Remove unused clockmode asm offsets
>>       https://git.kernel.org/powerpc/c/d7a82238cb8c77d4ed8cc97cd556c5f3e=
64bc749
>
> Thanks!
>
> Is there any chance to get this merged as part of topic/vdso?
=20
I could apply it there, but I don't think it will be necessary, because
topic/vdso will be empty vs mainline as soon as I send my pull request
for v6.13.

> My vdso rework patches for the 6.14 cycle rely on these removals.

Assuming you rebase that series onto v6.13-rc1 or later, this commit
will be included in that base.

But let me know if I'm misunderstanding something.

cheers


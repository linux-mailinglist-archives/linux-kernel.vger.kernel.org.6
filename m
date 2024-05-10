Return-Path: <linux-kernel+bounces-175374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA018C1E9F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CCD11C221C0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 07:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0836C15CD7D;
	Fri, 10 May 2024 07:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="d1Z7pyrE"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7410715217A
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 07:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715324631; cv=none; b=QV+ir/64jo7i6HamQs/kXHwSdkVXUiXjs6eiJWMb1uHZv0IBjGOJrJyzqeO/fxlmpGUSpbk24y1el18df7lCVsOmU/VNKsDoDdFx3uVZu5nPPi3+tOBHBd0SPIQz+Dv3HtkSVHx/LWV0yOer9OGWB0E0uowGrd7oRHvIHkhOUQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715324631; c=relaxed/simple;
	bh=SoDlZE87hfnURumY7SGIdDEMti6ngKTU8lVyyVE7Jgo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t+TWzuXCB3kr5I97BZuD65MsPymxvU5iDzCO7Ok1TL8Np/ikkhrH5k6zzrbeeG9IjbwNxaHGfvLWPOs93uWgyB37Z6j41REFSeNP13jViU7lrorbV5Ee9rnYg1R+1P5vCwe9fXeLrmZ2tUtP30NJr/YFbsskEsvzw0p1lJ3VDKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=d1Z7pyrE; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1715324626;
	bh=Wwz7PGF/2JLHmkgwfEtn4Lag7AXqlkDZb7B4D9iEdQI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=d1Z7pyrEGBrs6L0dz6cxVggbbbxS4Owx0CmDlA2znN4HgBBG3unC7rP44d4u5muzJ
	 sW6V4HKKp5OuQRS5dDqKiVPOAJJdFBRzJjXVfKWS3xawstBOT548LbQUjb0K9AUi3m
	 TIPnWU/d63yWYygXxoAoPG5Eu0nYq0rJy2yqmDx61YaPDYITg0L9haUpysurM+9Jis
	 mNZz4QMY4q9wj8LBHjY47tQGLA2B4LSyqC0YLLcgDY6kyAZtOH/+cv9gtLPWhh7W3D
	 /t0FWdL/FzbE3P03a5nRQSfQjoSC9TGSahFl4bvIlbbzVPdT15a51DEFnQfpQp5AB6
	 yHZ62XQb2poTw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VbKc13n7cz4wcC;
	Fri, 10 May 2024 17:03:45 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: linuxppc-dev@lists.ozlabs.org, arnd@arndb.de,
 linux-kernel@vger.kernel.org, nathan@kernel.org
Subject: Re: [PATCH v2 1/2] powerpc/io: Avoid clang null pointer arithmetic
 warnings
In-Reply-To: <CA+G9fYvo4--rSTHC1Vxdbbe62O6FhL_P2XdcF2Q7ZRku8HjpGg@mail.gmail.com>
References: <20240503075619.394467-1-mpe@ellerman.id.au>
 <CA+G9fYvo4--rSTHC1Vxdbbe62O6FhL_P2XdcF2Q7ZRku8HjpGg@mail.gmail.com>
Date: Fri, 10 May 2024 17:03:45 +1000
Message-ID: <87fruqm9m6.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Naresh Kamboju <naresh.kamboju@linaro.org> writes:
> On Fri, 3 May 2024 at 13:26, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> With -Wextra clang warns about pointer arithmetic using a null pointer.
>> When building with CONFIG_PCI=n, that triggers a warning in the IO
>> accessors, eg:
>>
>>   In file included from linux/arch/powerpc/include/asm/io.h:672:
>>   linux/arch/powerpc/include/asm/io-defs.h:23:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>>      23 | DEF_PCI_AC_RET(inb, u8, (unsigned long port), (port), pio, port)
>>         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>   ...
>>   linux/arch/powerpc/include/asm/io.h:591:53: note: expanded from macro '__do_inb'
>>     591 | #define __do_inb(port)          readb((PCI_IO_ADDR)_IO_BASE + port);
>>         |                                       ~~~~~~~~~~~~~~~~~~~~~ ^
>>
>> That is because when CONFIG_PCI=n, _IO_BASE is defined as 0.
>>
>> Although _IO_BASE is defined as plain 0, the cast (PCI_IO_ADDR) converts
>> it to void * before the addition with port happens.
>>
>> Instead the addition can be done first, and then the cast. The resulting
>> value will be the same, but avoids the warning, and also avoids void
>> pointer arithmetic which is apparently non-standard.
>>
>> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>> Closes: https://lore.kernel.org/all/CA+G9fYtEh8zmq8k8wE-8RZwW-Qr927RLTn+KqGnq1F=ptaaNsA@mail.gmail.com
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

Thanks.

cheers


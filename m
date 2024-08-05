Return-Path: <linux-kernel+bounces-274334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A12789476E6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D127C1C210FC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6721014A634;
	Mon,  5 Aug 2024 08:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kO4OpgX6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aFB/w5xI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6B72AD04
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 08:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722845317; cv=none; b=cNyne1SnEspQSwGXQ5AwJKx12oM1fNc2zRm31Z3GLqGVvvFrzp+OOp3K3gHy0140ncSnWrlPMvuJskk+7Yd5L3BRozRlcpyRpLaVmkdcbGTpdARCw5sfMWRpMX75oaOgHOMDo4LRSxltKt71nPPz1oxPMDicAmpx4LO6mbrbiQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722845317; c=relaxed/simple;
	bh=Cc04qXbYAUnQyH+N7yDHGGJVXdSRYsz9O9z9K1rTYb0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R9ENM/wly9zH8gxuKMNYI60jYvwtzq5BLFpjeJcVsPkfQkop73OgWrXXfSADPlPFam6IdyVBG35SMZXYd7FACjxHiTmo3GIzpVNaxwW61F5uzCDIMMkJKZ/xaRc/KgYWA8qrQ+QuJ2Wwta5v7VBrvhe5xhVZ66Fsny9TDzZ9t6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kO4OpgX6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aFB/w5xI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722845307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yAAdbpCNB7qdXIx7XkZ0OYkacQpR9SF6FMccPCE4uW8=;
	b=kO4OpgX6yRheMGGzR827GvOy3syxNldWwI7Sm9vXJwVMH4IfHDmLwJDVDRA5HrMMRUXlk+
	KcoSc/YmkxR+eEbOzv7pC0njuc0b6pbeB7wytrQ7OngRaWXNzubzyGRQqbQIQDDU917Ada
	qiE/+9/UPvl7QUpthUGPF9kKatWElHiyHcity781UI7hbafd+bfjz/DMlTk70ZpBzTgyHA
	0Ne8FI2zZqOHzB5yN6V+Mp5++xJd8yIb01u5pIOTUtt9ZBBqDmRj/i5JFE9ol8czcOmg8t
	UFGGWTaLyTWslrHXepPrZ1HbGA8vwKdY+PxHzxOyXjeFinjWpyq0mPrZvXP1Dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722845307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yAAdbpCNB7qdXIx7XkZ0OYkacQpR9SF6FMccPCE4uW8=;
	b=aFB/w5xIjuxVNieF0vC2qdlulYO+tcCtgQg74wuVBCq0OgMe2iN/fMbZCmyh12di1oMo2U
	+InW49QI+3DU0jAA==
To: Vincent Chen <vincent.chen@sifive.com>, Anup Patel <anup@brainfault.org>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] irqchip: let the probe of APLIC be earlier than IMSIC
In-Reply-To: <CABvJ_xgcbyQKa1+U1MC7cLEB-SUzzNaWqKdXFp+13mni0YSvNw@mail.gmail.com>
References: <20240802075741.316968-1-vincent.chen@sifive.com>
 <CAAhSdy3yx=mm3M6U_Q+_WdMs12SGCypPgNkBAVc9Kwn9jgev6g@mail.gmail.com>
 <CABvJ_xgcbyQKa1+U1MC7cLEB-SUzzNaWqKdXFp+13mni0YSvNw@mail.gmail.com>
Date: Mon, 05 Aug 2024 10:08:26 +0200
Message-ID: <87sevj5r45.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 05 2024 at 10:43, Vincent Chen wrote:
> On Fri, Aug 2, 2024 at 7:03=E2=80=AFPM Anup Patel <anup@brainfault.org> w=
rote:
>> Secondly, changing compilation order in Makefile to influence
>> the probe order will not help in any way.
>>
> I was confused here. If possible, hope you can help me clarify it.
> The following is the backtrace of really_porbe() dumped by GDB.
> #0  0xffffffff8092318a in really_probe ()
> #1  0xffffffff80923516 in __driver_probe_device.part.0 ()
> #2  0xffffffff8057c856 in driver_probe_device ()
> #3  0xffffffff8057c9ba in __driver_attach ()
> #4  0xffffffff8057aaa4 in bus_for_each_dev ()
> #5  0xffffffff8057c3ea in driver_attach ()
> #6  0xffffffff8057bc4a in bus_add_driver ()
> #7  0xffffffff8057d75a in driver_register ()
> #8  0xffffffff8057e83c in __platform_driver_register ()
> #9  0xffffffff80a2455e in imsic_platform_driver_init ()
> #10 0xffffffff8000212c in do_one_initcall ()
> #11 0xffffffff80a01188 in kernel_init_freeable ()
> #12 0xffffffff80928d80 in kernel_init ()
>
> According to this result, the source to call really_probe is
> do_one_initcall(), regardless of whether it is APLIC or IMSIC. The
> do_one_initcall() function follows the placed order of the
> initialization functions in the __initcall6 section to invoke them.
> The compile order determines the order of the __initcall6 section.
> Therefore, I try to adjust the compile order to influence the probe
> order between IMSIC and APLIC. Do I misunderstand something?

There is no guarantee that this order is retained. The linker can freely
reorg the section. That's why we have deferred probing. It's neither a
bug nor a problem, so what are you trying to solve?

Thanks,

        tglx


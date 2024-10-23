Return-Path: <linux-kernel+bounces-377201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 140199ABB2D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 03:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C99B2284E6A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 01:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8CC381BA;
	Wed, 23 Oct 2024 01:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="pXRHKFR7"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4121B1BDCF
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 01:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729648436; cv=none; b=chHPrqV+NWY+KQdQ2H96X6b6MXAccji8KRhM1GNc5q/hyE2n2FrkKtShkk05jSkyVAaVgzqh743DondR9V6kS8Z8ynquMCJpo7qILcC3BFAxmdA4hTYeB+3SO/E6L+hX3MZnlqPu4tk1euPiv6Cwxea4dqTKTMZ7Iyn5xMhg7dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729648436; c=relaxed/simple;
	bh=nX3JOPTTrpmXjwZohEFcd4e0GEGQfv/OElpvpt5Y2xo=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T53pVwHAhMYlRSvVRV+kdvhainb/W5xQNWRzzSW/BuyWpTo8sjeRD3jUw157gVn2DgNpmGbpwtmHTDXIzqk5W1+i/Fy5VWwedEl35EvAJYRZZcpchQedXqwrKncbAlRK5RCE835NpIsIZmA66H+dyZTok97BQa7a1n8+l07DCoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=pXRHKFR7; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1729648429;
	bh=Prey1zqDyFSBZaOzoYCxWeGlOrbQcMsbN15eTVtd0ew=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=pXRHKFR7ntVrXNcEIMLtFDlIuYC9/RRWyeq7NWNa6x0JqBjVbSKPksqvhtzlWDrI5
	 6sl05Gembdrue4GMcW+S/PYRMYqWnuqa5R9VOeFddEAY6+2aU25e9TMjrTAqrVqIbq
	 bY3rjKC+5yw00HVLBA8Pf6D4osB6TZYKsCYEyGG9rZfw+NN8s1X7kyAoFSIVogJYSn
	 qSYYsg2o3pN4gB9q9sMmAV+Dqk4WnVfA6JYJk/vzv1biDHWVfye8FzXNL4u7X4yaid
	 vdjCHF46WPEz89qMqOZQtPmc/GiXQ9/mH1ACbu5v77mNlh154+rViT4jtnrKSJCNNd
	 IGl6gkj4uucFA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XYBsn65Fxz4wb1;
	Wed, 23 Oct 2024 12:53:49 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: =?utf-8?B?6Jme6ZmG6ZOt?= <luming.yu@shingroup.cn>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, linux-kernel
 <linux-kernel@vger.kernel.org>, npiggin <npiggin@gmail.com>,
 "jialong.yang" <jialong.yang@shingroup.cn>, "luming.yu"
 <luming.yu@gmail.com>
Subject: Re: [PATCH 1/7] powerpc/entry: convert to common and generic entry
In-Reply-To: <tencent_381ACB160B890CC46678170E@qq.com>
References: <88E2581B1D024E9A+20241012035621.1245-3-luming.yu@shingroup.cn>
 <e9595d8b-d1e2-4c6a-b097-6f4f08d29866@csgroup.eu>
 <tencent_381ACB160B890CC46678170E@qq.com>
Date: Wed, 23 Oct 2024 12:53:47 +1100
Message-ID: <87o73b37pw.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"=E8=99=9E=E9=99=86=E9=93=AD" <luming.yu@shingroup.cn> writes:
>>Le 12/10/2024 =C3=A0 05:56, Luming Yu a =C3=A9crit :
>>> convert powerpc entry code in syscall and fault to use syscall_work
>>> and irqentry_state as well as common calls implemented in generic
>>> entry infrastructure.
>>>=20
>>> Signed-off-by: Luming Yu <luming.yu@shingroup.cn>
>>> ---
>>>   arch/powerpc/Kconfig                   | 1 +
>>>   arch/powerpc/include/asm/hw_irq.h      | 5 +++++
>>>   arch/powerpc/include/asm/processor.h   | 6 ++++++
>>>   arch/powerpc/include/asm/syscall.h     | 5 +++++
>>>   arch/powerpc/include/asm/thread_info.h | 1 +
>>>   arch/powerpc/kernel/syscall.c          | 5 ++++-
>>>   arch/powerpc/mm/fault.c                | 3 +++
>>>   7 files changed, 25 insertions(+), 1 deletion(-)
>>>=20
>>
>>...
>>
>>> diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscal=
l.c
>>> index 77fedb190c93..e0338bd8d383 100644
>>> --- a/arch/powerpc/kernel/syscall.c
>>> +++ b/arch/powerpc/kernel/syscall.c
>>> @@ -3,6 +3,7 @@
>>>   #include <linux/compat.h>
>>>   #include <linux/context_tracking.h>
>>>   #include <linux/randomize_kstack.h>
>>> +#include <linux/entry-common.h>
>>>=20=20=20
>>>   #include <asm/interrupt.h>
>>>   #include <asm/kup.h>
>>> @@ -131,7 +132,7 @@ notrace long system_call_exception(struct pt_regs *=
regs, unsigned long r0)
>>>   		 * and the test against NR_syscalls will fail and the return
>>>   		 * value to be used is in regs->gpr[3].
>>>   		 */
>>> -		r0 =3D do_syscall_trace_enter(regs);
>>> +		r0 =3D syscall_enter_from_user_mode(regs, r0);
>>
>>Can you provide details on how this works ?
> I assume the common entry would take over th details.
> So I just made the switch from the high level call.
>
> As you said as the subtle ABI requirement about regs->r3 needs to
> be restored, I'm wondering which test can capture the lost
> ABI feature. As simple Boot test is insufficient, what is the test set
> that can capture it?

The seccomp selftest did exercise it back when I originally wrote that
code. I don't know for sure that it still does, but that would be a good
start.

It's in tools/testing/selftests/seccomp/

cheers


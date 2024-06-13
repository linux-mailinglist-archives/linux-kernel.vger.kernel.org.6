Return-Path: <linux-kernel+bounces-213098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD7D906B0D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 042CA1F2426D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55108142E8E;
	Thu, 13 Jun 2024 11:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="dsezFuET"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9BD1422B5
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 11:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718278456; cv=none; b=IF1iX3JFa5M1noVFABv6R6YhKbvOTShuHjQ5XiHEbQJNHHzGNZcJpRGYRe0kqoSaxXrbskZO40Ggurlm2Rve/zxcEgaGsT7XYMors1blNKDAiL4g0ilqHfxEXLm7Ymmq4jTuIOoayPgEaKMQ2NtxEK0eUCl0GIKJX9HIH3R0U3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718278456; c=relaxed/simple;
	bh=cSldylOADan04Rn9YvO2UHvgx9cydhYHmv6mP+L6OXM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EUKzenbxMrcXvsKwuELcy2SSTxZ8xWbvqfqJfzwzZgGPUZL86WCMdUA/J8H/anIuNGhMRt3zz+pgcT+5NIhbs3wzd2B5YgtEIvvYLFDzCYR88NEglUqjx1BiqTJWWzFOHy5joIhtwbOa0yHKdAImDwKF4mqZpS5BlSvBKTRrIA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=dsezFuET; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1718278451;
	bh=1z2hwHmg3zI5iDN7nSTa67ma/S6hUmgaCaCPmbI3jNE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=dsezFuET6MQptgoIk4Rz2FdLfx112u9Qx789Kb6J4Llwv43suNMkBgJJQYDjUaf9q
	 9PMwVN7VPdH247bgCo1MtVFVRMvX9fR6R77cwc5faN800byW7JZ3yd4LEAg1R352Za
	 GU2G8AD91GMmg4rc9l/tuhy8UCB4yoFI1Fii2QrtjRvJM9MTy3xamznmntrzLqAHHb
	 HhxI6DCtBAo9qAO13nYTcavzOmCFWaiRW3wb1ls8xA1LodFnSv8bpxNI+KoAEzNxvw
	 ndZyvDgLKpZ/Uwiu7IVXY9PytAJ77PvqQwUHX+Wx4c7Ia/Euss5oBGDBynHlU7wdUY
	 63G7z56OX18aA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4W0L0L4qfsz4wcJ;
	Thu, 13 Jun 2024 21:34:10 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Nysal Jan K.A." <nysal@linux.ibm.com>, Thomas Gleixner
 <tglx@linutronix.de>
Cc: Tyrel Datwyler <tyreld@linux.ibm.com>, Michal Suchanek
 <msuchanek@suse.de>, "Nysal Jan K.A" <nysal@linux.ibm.com>, Nicholas
 Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, "Naveen N. Rao"
 <naveen.n.rao@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>,
 Laurent Dufour <ldufour@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Skip offline cores when enabling SMT on PowerPC
In-Reply-To: <20240612185046.1826891-1-nysal@linux.ibm.com>
References: <20240612185046.1826891-1-nysal@linux.ibm.com>
Date: Thu, 13 Jun 2024 21:34:10 +1000
Message-ID: <875xudoz4d.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Nysal Jan K.A." <nysal@linux.ibm.com> writes:
> From: "Nysal Jan K.A" <nysal@linux.ibm.com>
>
> After the addition of HOTPLUG_SMT support for PowerPC [1] there was a
> regression reported [2] when enabling SMT.

This implies it was a kernel regression. But it can't be a kernel
regression because previously there was no support at all for the sysfs
interface on powerpc.

IIUIC the regression was in the ppc64_cpu userspace tool, which switched
to using the new kernel interface without taking into account the way it
behaves.

Or are you saying the kernel behaviour changed on x86 after the powerpc
HOTPLUG_SMT was added?

> On a system with at least
> one offline core, when enabling SMT, the expectation is that no CPUs
> of offline cores are made online.
>
> On a POWER9 system with 4 cores in SMT4 mode:
> $ ppc64_cpu --info
> Core   0:    0*    1*    2*    3*
> Core   1:    4*    5*    6*    7*
> Core   2:    8*    9*   10*   11*
> Core   3:   12*   13*   14*   15*
>
> Turn only one core on:
> $ ppc64_cpu --cores-on=1
> $ ppc64_cpu --info
> Core   0:    0*    1*    2*    3*
> Core   1:    4     5     6     7
> Core   2:    8     9    10    11
> Core   3:   12    13    14    15
>
> Change the SMT level to 2:
> $ ppc64_cpu --smt=2
> $ ppc64_cpu --info
> Core   0:    0*    1*    2     3
> Core   1:    4     5     6     7
> Core   2:    8     9    10    11
> Core   3:   12    13    14    15
>
> As expected we see only two CPUs of core 0 are online
>
> Change the SMT level to 4:
> $ ppc64_cpu --smt=4
> $ ppc64_cpu --info
> Core   0:    0*    1*    2*    3*
> Core   1:    4*    5*    6*    7*
> Core   2:    8*    9*   10*   11*
> Core   3:   12*   13*   14*   15*
>
> The CPUs of offline cores are made online. If a core is offline then
> enabling SMT should not online CPUs of this core.

That's the way the ppc64_cpu tool behaves, but it's not necessarily what
other arches want.

> An arch specific
> function topology_is_core_online() is proposed to address this.
> Another approach is to check the topology_sibling_cpumask() for any
> online siblings. This avoids the need for an arch specific function
> but is less efficient and more importantly this introduces a change
> in existing behaviour on other architectures.

It's only x86 and powerpc right?

Having different behaviour on the only two arches that support the
interface does not seem like a good result.

> What is the expected behaviour on x86 when enabling SMT and certain cores
> are offline? 

AFAIK no one really touches SMT on x86 other than to turn it off for
security reasons.

cheers

> [1] https://lore.kernel.org/lkml/20230705145143.40545-1-ldufour@linux.ibm.com/
> [2] https://groups.google.com/g/powerpc-utils-devel/c/wrwVzAAnRlI/m/5KJSoqP4BAAJ
>
> Nysal Jan K.A (2):
>   cpu/SMT: Enable SMT only if a core is online
>   powerpc/topology: Check if a core is online
>
>  arch/powerpc/include/asm/topology.h | 13 +++++++++++++
>  kernel/cpu.c                        | 12 +++++++++++-
>  2 files changed, 24 insertions(+), 1 deletion(-)
>
>
> base-commit: c760b3725e52403dc1b28644fb09c47a83cacea6
> -- 
> 2.35.3


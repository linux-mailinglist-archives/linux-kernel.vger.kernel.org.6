Return-Path: <linux-kernel+bounces-423074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D513E9DA26E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 07:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 718C9B22BEF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 06:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C37146019;
	Wed, 27 Nov 2024 06:44:05 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE458EC2
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 06:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732689845; cv=none; b=TXbzNx2AmxRYQFXs5YUcGZg7cVP7cjaOE2NCHDkkJQczQhmYG41W1coelxJF43lKMp61oAv4/LtxwaOfuNxVpvrS3oDsu9EvTKcqdiMXfR3bbM6imR69KNB+VS6cZnlzhyNqhPKO5073E7hk0bZJhQMEgiX/DaR3pdBJ2DS9nCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732689845; c=relaxed/simple;
	bh=ESyavCAvOndmtJ4LnCYvU7nWf759k4c/grAm5Z42+ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WvjALzukRPGqbSPAvv0qe4Qy2pqzPho9lu5gec8RzpJQyfxEHbyngpok7L+W4xFSgTjt2lzzMYFUbsdLgAWoR9vnjN5S3EWc05U+HQGa+qKZ+9ffP+6jEuZm1jNNeAWhVlEwqrIIN2YbTsZ960l67AUqwZs967NtCUiK0Qm6n+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XyqfT4V3Pz9sPd;
	Wed, 27 Nov 2024 07:44:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zLJ7ChzR5x-Z; Wed, 27 Nov 2024 07:44:01 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XyqfT3QVDz9rvV;
	Wed, 27 Nov 2024 07:44:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 5BEEB8B780;
	Wed, 27 Nov 2024 07:44:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id SaDX1yXfj_ki; Wed, 27 Nov 2024 07:44:01 +0100 (CET)
Received: from [192.168.233.25] (PO18304.IDSI0.si.c-s.fr [192.168.233.25])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CF7468B77C;
	Wed, 27 Nov 2024 07:44:00 +0100 (CET)
Message-ID: <5089fd16-bc8c-4231-a89b-2658445e04b7@csgroup.eu>
Date: Wed, 27 Nov 2024 07:44:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] powerpc: support dynamic preemption
To: Shrikanth Hegde <sshegde@linux.ibm.com>, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com, maddy@linux.ibm.com, bigeasy@linutronix.de,
 ankur.a.arora@oracle.com, linux-kernel@vger.kernel.org,
 mark.rutland@arm.com, vschneid@redhat.com, peterz@infradead.org
References: <20241125042212.1522315-1-sshegde@linux.ibm.com>
 <20241125042212.1522315-3-sshegde@linux.ibm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20241125042212.1522315-3-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 25/11/2024 à 05:22, Shrikanth Hegde a écrit :
> Once the lazy preemption is supported, it would be desirable to change
> the preemption models at runtime. So this change adds support for dynamic
> preemption using DYNAMIC_KEY.
> 
> In irq-exit to kernel path, use preempt_model_preemptible for decision.
> Other way would be using static key based decision. Keeping it
> simpler since key based change didn't show performance improvement.

What about static_call, wouldn't it improve performance ?

> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 6d6bbd93abab..01c58f5258c9 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -270,6 +270,7 @@ config PPC
>   	select HAVE_PERF_EVENTS_NMI		if PPC64
>   	select HAVE_PERF_REGS
>   	select HAVE_PERF_USER_STACK_DUMP
> +	select HAVE_PREEMPT_DYNAMIC_KEY

Can you use HAVE_PREEPT_DYNAMIC_CALL instead ? That should be more 
performant.

I know static calls are not in for PPC64 yet, you can restart from 
http://patchwork.ozlabs.org/project/linuxppc-dev/cover/20221010002957.128276-1-bgray@linux.ibm.com/ 
and https://github.com/linuxppc/issues/issues/416

Christophe


Return-Path: <linux-kernel+bounces-320628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82305970CF6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 07:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5C831C21BCF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 05:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081A71ACE0F;
	Mon,  9 Sep 2024 05:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="XeiZdEZr"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B747E17C9E
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 05:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725859714; cv=none; b=bDSBa6YHZdg6PRYgPy0pqAFsUSiU1ujKEhsc2x12gndv81jQe9bASDRSMIrH5/Ps36qHzPOg7EbDvs6E1yP+Y5HVj9A7K/fQ9omp3v1ie8ZerPq3e3jS0AP3wN/jQydm/BbsrYBqMo4mce+SmFGY9VaFXeJ0M35FrCCe1Q0NvYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725859714; c=relaxed/simple;
	bh=qB2Wwel9OzDn6pSIe4KfAGyszGxKeVmkpnYx7yYlrWM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VDLn869BjKB6hlkGZSj3j9Qd6u9ai6QwO6dkcso7rUm5mEmKiRqzLfbRxCN98lv183P7rMB0w/vdjznUnHxpuJ5oXJRN2oro4XC5lJm6gd3FY7GuNHQm2ZUmUZDaRErwkaH6whxpmtlgi0gP9qusV9pyP+H2HUu8obbWwcYP1SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=XeiZdEZr; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1725859711;
	bh=fLPqjRZv8TbImz19Z61gMoOmywpxwhWyT/9UYguMWX4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XeiZdEZrV1xAOZngndFEnk9Q15aHKMSmUVvKNr0+k3WK/kOxHRpF9aZ7x2yVnmqB5
	 p0UHLilx4QVpp8QqO2zmn1c8GgQRYH1Xm1IIX5oP9buNQ8sLTkOH2LDz9Dg0rYoxbA
	 GBQK3muxaSxcUWDS5mH69zkOzvKi94xet8cFf1eMl8SxmhEswohR6AsOMO3rS//ggu
	 P8eiAZqr/dxK1a6+wXPgRVcbi1aywBcRcdBya0jYphP6Ed3rX3grM30vNsm6nJC5By
	 BVmK+BHxGjzkBJ/J3X7x3DnlanOci4wQXSO/aw6ahnf4YTIjLZ88mplxZIUkXRqIKm
	 I+6itOqN5rsmg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X2Fjq0PQzz4wcl;
	Mon,  9 Sep 2024 15:28:31 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Costa Shulyupin <costa.shul@redhat.com>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Costa Shulyupin <costa.shul@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: ming.lei@redhat.com
Subject: Re: [PATCH] powerpc/xive: Use cpumask_intersects()
In-Reply-To: <20240906174941.1147197-2-costa.shul@redhat.com>
References: <20240906174941.1147197-2-costa.shul@redhat.com>
Date: Mon, 09 Sep 2024 15:28:30 +1000
Message-ID: <87h6ap4cqp.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Costa Shulyupin <costa.shul@redhat.com> writes:
> Replace `cpumask_any_and(a, b) >= nr_cpu_ids`
> with the more readable `!cpumask_intersects(a, b)`.

I agree it's more readable.

It would be nice if the change log told me that both functions have
similar performance behaviour. I'm not saying this is a super hot path,
but CPU masks can get pretty big, and some cpumask routines compute the
full mask while others short-circuit.

cheers

> diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
> index fa01818c1972c..a6c388bdf5d08 100644
> --- a/arch/powerpc/sysdev/xive/common.c
> +++ b/arch/powerpc/sysdev/xive/common.c
> @@ -726,7 +726,7 @@ static int xive_irq_set_affinity(struct irq_data *d,
>  	pr_debug("%s: irq %d/0x%x\n", __func__, d->irq, hw_irq);
>  
>  	/* Is this valid ? */
> -	if (cpumask_any_and(cpumask, cpu_online_mask) >= nr_cpu_ids)
> +	if (!cpumask_intersects(cpumask, cpu_online_mask))
>  		return -EINVAL;
>  
>  	/*
> -- 
> 2.45.0


Return-Path: <linux-kernel+bounces-246191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B5892BED8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE1CD1F234CA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8717B19D889;
	Tue,  9 Jul 2024 15:52:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5499F15886B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 15:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720540376; cv=none; b=azZdIqePmedbweDmS0tmhexd7M9FY9J2eqhYrtERn+jxHOLbFnXF6mWhyQv4HroHUFqZ+997ZIzA0aV8CEfrhDEQ7cp9BoJAAMmwpptuk6cFNHPZ9ERDr3nGFVWvV8xaGkm7Vull8unKkMqK71ZDsmlgtS66dvql2IopA81SMik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720540376; c=relaxed/simple;
	bh=6pSHSPzyDv2Z5pp7Qec+U+73yn/n2keX8Rb8tvod3fQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dRUKHJcZDqn1hjc+9ynXPiyiWnFuXbesKDpafFvrtKyVhwJ1DJ1D8mgUlLmNudGk0QRrN2RxAW1CfGzZVO0wIHvqNo8Yj4MVs1VKNMaRICbsEY+YHZvA0ySndwGFWcZjgBj/wY1h17zcr/TEUxfodEfJSkPRIQsiaO9i3wePB+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1A72153B;
	Tue,  9 Jul 2024 08:53:17 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E2843F762;
	Tue,  9 Jul 2024 08:52:51 -0700 (PDT)
Message-ID: <42552be3-df90-4f8f-a27b-abd08e350fc4@arm.com>
Date: Tue, 9 Jul 2024 16:52:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -fixes] dma-mapping: add default implementation to
 arch_dma_{set|clear}_uncached
To: Yangyu Chen <cyy@cyyself.name>, Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux.dev,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
References: <tencent_A5ED71472ADCAF18F59085464CBE23C12A07@qq.com>
 <20240709111901.GC4421@lst.de>
 <tencent_651BC4D11C9730062064ACB186AF4A904005@qq.com>
 <20240709114629.GB6959@lst.de>
 <tencent_30E109FE684F391AE15AC6F4854034C2F00A@qq.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <tencent_30E109FE684F391AE15AC6F4854034C2F00A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/07/2024 1:22 pm, Yangyu Chen wrote:
> 
> 
>> On Jul 9, 2024, at 19:46, Christoph Hellwig <hch@lst.de> wrote:
>>
>> On Tue, Jul 09, 2024 at 07:39:29PM +0800, Yangyu Chen wrote:
>>> The reason is that some optimizations failed to apply after adding
>>> some passes. I will fix the compiler later. Whatever, we should not
>>> rely on this optimization to get the code being successfully compiled.
>>
>> The Linux kernel relies on constant propagation and dead code
>> eliminiation a lot to make code simpler and more readable.
> 
> Actually, the compiler is patched LLVM with -O2 optimization. I didn’t
> turn off the optimization.

Well, sorry, you did do that, by patching the compiler in a way which 
makes it no longer happen as before. If LLVM is otherwise able to make 
this optimisation as expected then to me that sounds like your patch 
effectively causes a codegen regression in LLVM, thus it should hardly 
be the concern of Linux, nor every other project which may get worse 
codegen because of it, to work around it.

Regardless of whether people think it's reasonable to *depend* on 
compiler optimisation or not, emitting dead code which was not 
previously emitted at the same optimisation level seems like a clear 
step backwards.

> You can see what we did for the compiler here[1] and compile the
> kernel with `-march=rv64imac_zicond_zicldst` added to KBUILD_CFLAGS.
> I added conditional load/store pass as Intel did for the x86 APX
> extension, which appeared last year (called hoist load/store in
> LLVM if you want to search the PR), and then LLVM failed to optimize
> this.
> 
> The only failed symbol on the kernel with `ARCH=riscv defconfig`
> is `arch_dma_set_uncached` since the compiler requires all possible
> values to be known. I think a pattern like in kernel/dma/direct.c:349
> for symbol `arch_dma_clear_uncached`, which uses `if
> (IS_ENABLE(CONFIG_ARCH_HAS_xxx)) xxx` is acceptable. But for the
> symbol `arch_dma_set_uncached`, a complex analysis is needed for a
> value set in a block of branches. I think we should not rely on such
> compiler optimization in such a complex pattern.

I'm not a compiler guy, but is it really that complex when the variable 
is only ever written with the same compile-time-constant value that it's 
already initialised with? If the optimisation pass is so focused on 
being able to use a conditional store instruction that it would rather 
emit one which has no effect either way than elide it entirely, that 
doesn't strike me as a particularly good optimisation :/

Thanks,
Robin.

> 
> In addition, patching this way can also make this symbol safer to use.
> 
> [1] https://github.com/cyyself/llvm-project/tree/zicldst-support-bugless-v3
> 
> Thanks,
> Yangyu Chen


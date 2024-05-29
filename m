Return-Path: <linux-kernel+bounces-193815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D11C8D3291
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 008681F223CD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 09:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CFF169361;
	Wed, 29 May 2024 09:08:24 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594E81E888
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 09:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716973704; cv=none; b=YDYCzsJDI+yS9LvBJnsfpnqe4/aA1ldHqQbB9Q0xk7byi5PU+L/6nCnQLolAhIvObLeg+rPYksUYNfej+tw9NU90y1wk/o7WIlTfezjm4u5pbamt+4MEB+xI3IhMPN70IhCdnIMizYXoh9SR5uaJYKQZeCKHBijwgLQVrRo532I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716973704; c=relaxed/simple;
	bh=ytzmCHDBAof2zTjniBViAI+SAOG4tzv4iEyEBrfYGKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AUbzHTgwqSgVuf7IQIie2FqNpKWMOpCUzbG/XaaVH3WGo+BRw3uNRanlz7/JRdMZswkIaui8ZFlEC5qvWgoCnGEEWkwRft5t4uzgNrWXKI3bHZUScBzMQLPG4ip5ua0IzF7BFK2RBX9Gm3CzkDQBtt2UPyZ1IrSYnwFSipF9Ur8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 44A37C0009;
	Wed, 29 May 2024 09:08:15 +0000 (UTC)
Message-ID: <e34f73ce-bca8-4d18-84cd-9b8d0a6130b9@ghiti.fr>
Date: Wed, 29 May 2024 11:08:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] RISC-V: clarify what some RISCV_ISA* config
 options do
Content-Language: en-US
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org,
 xiao.w.wang@intel.com, Andrew Jones <ajones@ventanamicro.com>,
 pulehui@huawei.com, Charlie Jenkins <charlie@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, linux-kernel@vger.kernel.org,
 Samuel Holland <samuel.holland@sifive.com>,
 Pu Lehui <pulehui@huaweicloud.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>
References: <20240528-applaud-violin-facef8d9d846@spud>
 <20240528-varnish-status-9c22973093a0@spud>
 <f2a3bddd-0cc1-43ca-8421-1d67dd2800f8@ghiti.fr>
 <20240529-riveter-spectacle-e5ab2f45065f@wendy>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240529-riveter-spectacle-e5ab2f45065f@wendy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr


On 29/05/2024 10:54, Conor Dooley wrote:
> On Wed, May 29, 2024 at 10:47:40AM +0200, Alexandre Ghiti wrote:
>> Hi Conor,
>>
>> On 28/05/2024 13:11, Conor Dooley wrote:
>>> From: Conor Dooley <conor.dooley@microchip.com>
>>>
>>> During some discussion on IRC yesterday and on Pu's bpf patch [1]
>>> I noticed that these RISCV_ISA* Kconfig options are not really clear
>>> about their implications. Many of these options have no impact on what
>>> userspace is allowed to do, for example an application can use Zbb
>>> regardless of whether or not the kernel does. Change the help text to
>>> try and clarify whether or not an option affects just the kernel, or
>>> also userspace. None of these options actually control whether or not an
>>> extension is detected dynamically as that's done regardless of Kconfig
>>> options, so drop any text that implies the option is required for
>>> dynamic detection, rewording them as "do x when y is detected".
>>>
>>> Link: https://lore.kernel.org/linux-riscv/20240328-ferocity-repose-c554f75a676c@spud/ [1]
>>> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>>> ---
>>>    arch/riscv/Kconfig | 36 +++++++++++++++++++-----------------
>>>    1 file changed, 19 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>>> index b94176e25be1..3b702e6cc051 100644
>>> --- a/arch/riscv/Kconfig
>>> +++ b/arch/riscv/Kconfig
>>> @@ -501,7 +501,8 @@ config RISCV_ISA_C
>>>    	help
>>>    	  Adds "C" to the ISA subsets that the toolchain is allowed to emit
>>>    	  when building Linux, which results in compressed instructions in the
>>> -	  Linux binary.
>>> +	  Linux binary. This option produces a kernel that will not run on
>>> +	  systems that do not support compressed instructions.
>>>    	  If you don't know what to do here, say Y.
>>> @@ -511,8 +512,8 @@ config RISCV_ISA_SVNAPOT
>>>    	depends on RISCV_ALTERNATIVE
>>>    	default y
>>>    	help
>>> -	  Allow kernel to detect the Svnapot ISA-extension dynamically at boot
>>> -	  time and enable its usage.
>>> +	  Add support for the Svnapot ISA-extension in the kernel when it
>>> +	  is detected at boot.
>>
>> To me, the new version makes things even more confusing: svnapot mappings
>> will indeed be handled by the kernel (since only the kernel sets up the page
>> tables) but it will only be used (for now) for HugeTLB mappings in
>> userspace.
> How would you suggest that I word it? "Enable the use of the Svnapot
> ISA-extension when it is detected at boot"? The current text implies that
> these options control detection of extensions (which they do not) and
> that is what I am looking to remove as it has caused confusion.


Ok, I see what you mean. Your above suggestion looks great then :)

Thanks,

Alex


>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


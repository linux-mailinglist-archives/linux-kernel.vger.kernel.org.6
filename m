Return-Path: <linux-kernel+bounces-170691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA8D8BDAAB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 07:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A091F28103A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 05:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6EF6BB5B;
	Tue,  7 May 2024 05:29:07 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F02B6BB20
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 05:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715059747; cv=none; b=G4vocIk99giKZF94Lg3KrjntEkyXo/JfrN3snLiG4PH9dtU1uS8F1S4QhsUzyI1U/fDIKqqi2uwOnwpQqJ1+spJqI8FsIERwqJRTjRY1ieWgeawBAOdZzoB3cAmamqTBMPAWmkFA4OGK4X7yDw4bB3tU4CVo/Grx6u+qTE3ShlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715059747; c=relaxed/simple;
	bh=mI0s6oQSYCa0h4zfTerm09YmKn24JLVdXv9sDT2609U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LG19wRoovpF/We0HwVy2llNTJ8jaooHugwGHVzz0f9UXv3Q+r1qhcEaaogwUI8OweYyNTIPoyOn3vnqf9O6KVJJAOpuwEg7qCHwwytoHWogWucIq74uBrPiOzQwVvz2b/+DOfS2jmLZKIahn3T6kqlG/36PB6VU8hIy0LKCJu5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 10937FF804;
	Tue,  7 May 2024 05:28:58 +0000 (UTC)
Message-ID: <bfb82e87-94c0-4a23-b59d-bb57911224b5@ghiti.fr>
Date: Tue, 7 May 2024 07:28:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] riscv: set trap vector earlier
Content-Language: en-US
To: "yang.zhang" <gaoshanliukou@163.com>, alexghiti@rivosinc.com
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 "yang.zhang" <yang.zhang@hexintek.com>
References: <20240506022239.6817-1-gaoshanliukou@163.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240506022239.6817-1-gaoshanliukou@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Yang,

On 06/05/2024 04:22, yang.zhang wrote:
> From: "yang.zhang" <yang.zhang@hexintek.com>
>
> If trap earlier, trap vector doesn't yet set properly, current
> value maybe set by previous firmwire, typically it's the _start of kernel,
> it's confused and difficult to debuge, so set it earlier.


What about:

"The exception vector of the booting hart is not set before enabling the 
mmu and then still points to the value of the previous firmware, 
typically _start_kernel. That makes it hard to debug setup_vm() when bad 
things happen. So fix that by setting the exception vector earlier."


> ---
> v1 -> v2:
> As Alex commented, remove the patch for supporting hugesize kernek image
> Add the omissive logic of set trap vector earlier
>
> Signed-off-by: yang.zhang <yang.zhang@hexintek.com>
> ---
>   arch/riscv/kernel/head.S | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 4236a69c35cb..03dc440e643e 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -300,6 +300,9 @@ SYM_CODE_START(_start_kernel)
>   #else
>   	mv a0, a1
>   #endif /* CONFIG_BUILTIN_DTB */
> +	/* Set trap vector to spin forever to help debug */
> +	la a3, .Lsecondary_park
> +	csrw CSR_TVEC, a3
>   	call setup_vm
>   #ifdef CONFIG_MMU
>   	la a0, early_pg_dir

Note that this patch will allow to catch any exception happening in 
setup_vm() but as we reset stvec in relocate_enable_mmu. But that's ok, 
it will help catching weird bugs more easily :)

With the commit message fixed, you can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex



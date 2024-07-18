Return-Path: <linux-kernel+bounces-256304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16780934C43
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5553EB22D03
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A8312D76F;
	Thu, 18 Jul 2024 11:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RtOoNhE3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B015E4D8A1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 11:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721301262; cv=none; b=GhxwsRqdkcIh9leQ5qNt7stWjFQraMDtfDlv+bVxYArcKEiziLLV4vnVCJrPNslHR6PDsk2dX/IaW/VxZHrsyTqg0mYTCPUY/8JU0DQIlARV/ewhf1jNkHQsa5o4m7fgL02yRMKsq5d9khvINGLA9U13PiHKE7Ab6F+vdIWwiUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721301262; c=relaxed/simple;
	bh=MD5H7xy8KCRCZIBZPhdfApDfKoEbaG31DxQKBY3EYb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQwslvCbAVqGDBW6HMIOK0qyepR0Qf2qgnzriwTXCejIvgYYWzeLvC+RNtWO+eI9V4PECiwnjBeBmVxVmJzAUgTAOxlKZ2SokxPtDw90i8I7nRnyE3bwar47cVxVDCKdnZOvBOYWHx9vSSF/KnG04l1XX3Bvz83+JnHvsJDUBqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RtOoNhE3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721301259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yaMYBnsmHVguo1+b/EMIXO5bT8FcNVXk06LyZCMh0p0=;
	b=RtOoNhE3k6ERzY6rTP5tkRnP+HBIyuZBCgNVRMV3am8L+pS5B9TzQtdZ2HwlLc4r6ql9S2
	gCMP3VI9nbt0A+R7eUoS6xwH7QInLVMhD2YU5sU92nZUGbB0AxEeLm//5N7PDelPeI2Jw1
	DA4kFwJvfFNisutuqmxn8FYhfOiBBLM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-hGO9jZbyMYGs8ICG87O2eQ-1; Thu,
 18 Jul 2024 07:14:15 -0400
X-MC-Unique: hGO9jZbyMYGs8ICG87O2eQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D5D5B1955D4D;
	Thu, 18 Jul 2024 11:14:10 +0000 (UTC)
Received: from localhost (unknown [10.72.112.39])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9849919560B2;
	Thu, 18 Jul 2024 11:14:05 +0000 (UTC)
Date: Thu, 18 Jul 2024 19:14:00 +0800
From: Baoquan He <bhe@redhat.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, vgoyal@redhat.com,
	dyoung@redhat.com, arnd@arndb.de, afd@ti.com,
	linus.walleij@linaro.org, akpm@linux-foundation.org,
	eric.devolder@oracle.com, gregkh@linuxfoundation.org,
	javierm@redhat.com, deller@gmx.de, robh@kernel.org,
	hbathini@linux.ibm.com, thunder.leizhen@huawei.com,
	chenjiahao16@huawei.com, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 2/3] crash: Fix x86_32 crash memory reserve dead loop
 bug at high
Message-ID: <Zpj4+G5OwTYBQGIA@MiWiFi-R3L-srv>
References: <20240718035444.2977105-1-ruanjinjie@huawei.com>
 <20240718035444.2977105-3-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718035444.2977105-3-ruanjinjie@huawei.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 07/18/24 at 11:54am, Jinjie Ruan wrote:

I don't fully catch the subject, what does the 'dead loop bug at high'
mean?

> On x86_32 Qemu machine with 1GB memory, the cmdline "crashkernel=512M" will
> also cause system stall as below:
> 
> 	ACPI: Reserving FACP table memory at [mem 0x3ffe18b8-0x3ffe192b]
> 	ACPI: Reserving DSDT table memory at [mem 0x3ffe0040-0x3ffe18b7]
> 	ACPI: Reserving FACS table memory at [mem 0x3ffe0000-0x3ffe003f]
> 	ACPI: Reserving APIC table memory at [mem 0x3ffe192c-0x3ffe19bb]
> 	ACPI: Reserving HPET table memory at [mem 0x3ffe19bc-0x3ffe19f3]
> 	ACPI: Reserving WAET table memory at [mem 0x3ffe19f4-0x3ffe1a1b]
> 	143MB HIGHMEM available.
> 	879MB LOWMEM available.
> 	  mapped low ram: 0 - 36ffe000
> 	  low ram: 0 - 36ffe000
> 	  (stall here)
> 
> The reason is that the CRASH_ADDR_LOW_MAX is equal to CRASH_ADDR_HIGH_MAX
> on x86_32, the first "low" crash kernel memory reservation for 512M fails,
> then it go into the "retry" loop and never came out as below (consider
> CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX = 512M):
> 
> -> reserve_crashkernel_generic() and high is false
>    -> alloc at [0, 0x20000000] fail
>       -> alloc at [0x20000000, 0x20000000] fail and repeatedly
>       (because CRASH_ADDR_LOW_MAX = CRASH_ADDR_HIGH_MAX).
> 
> Fix it by skipping meaningless calls of memblock_phys_alloc_range() with
> `start = end`
> 
> After this patch, the retry dead loop is avoided and print below info:
> 	cannot allocate crashkernel (size:0x20000000)
> 
> And apply generic crashkernel reservation to 32bit system will be ready.
> 
> Fixes: 9c08a2a139fe ("x86: kdump: use generic interface to simplify crashkernel reservation code")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Tested-by: Jinjie Ruan <ruanjinjie@huawei.com>

Also the tag issues, please update.

Other than above concerns, the patch looks good to me.

> ---
> v3:
> - Fix it as Baoquan suggested.
> - Update the commit message.
> ---
>  kernel/crash_reserve.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
> index c5213f123e19..dacc268429e2 100644
> --- a/kernel/crash_reserve.c
> +++ b/kernel/crash_reserve.c
> @@ -414,7 +414,8 @@ void __init reserve_crashkernel_generic(char *cmdline,
>  			search_end = CRASH_ADDR_HIGH_MAX;
>  			search_base = CRASH_ADDR_LOW_MAX;
>  			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> -			goto retry;
> +			if (search_base != search_end)
> +				goto retry;
>  		}
>  
>  		/*
> -- 
> 2.34.1
> 



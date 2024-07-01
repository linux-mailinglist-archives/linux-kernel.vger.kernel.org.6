Return-Path: <linux-kernel+bounces-236553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D26B91E3E5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E22C1C21C20
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F6016D4C7;
	Mon,  1 Jul 2024 15:19:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6FE16CD0C
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 15:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719847165; cv=none; b=SQ7kouYBbw7joFZN8CB/MCvCfv7AqdBNNzzG1BUqxX0x2pYcvy5HP/Znhj2E4iXVxzFMyrstnJapw3kl0MtKXjYU4+EXjTE5sQzBIo4i2GQZbzIgvJzTkG9quBH1LxqqlGEMRvWrib+awTl9P5B4A358Wv3BVUS+CeXNu8REG0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719847165; c=relaxed/simple;
	bh=7wV9GVR+o/bWNN4sS03Jw3MG6wVffPVzE+jw24AtPIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oNlCHeaMKWeyUUuEddvJmmyPnufCt1y0lNleCP2fUbNDaFiiC52oikE+ZbnaifMQM/ddxZuQN9lT5pWvMzgyKieWoXoafObzxhfRHC7CIrC6XnRbwubbz2qcpF39KLCHkiGmEHJ/d6ntohsAz48urKagy/PsAYDlS9N2flaAr7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4BF6367;
	Mon,  1 Jul 2024 08:19:47 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 932013F73B;
	Mon,  1 Jul 2024 08:19:21 -0700 (PDT)
Message-ID: <4d4efa29-8a6e-40de-8979-3fd13d6bd4db@arm.com>
Date: Mon, 1 Jul 2024 16:19:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] x86/vgtod: Remove unused typedef gtod_long_t
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
References: <20240701-vdso-cleanup-v1-0-36eb64e7ece2@linutronix.de>
 <20240701-vdso-cleanup-v1-4-36eb64e7ece2@linutronix.de>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <20240701-vdso-cleanup-v1-4-36eb64e7ece2@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 01/07/2024 15:47, Anna-Maria Behnsen wrote:
> The typedef gtod_long_t is not used anymore so remove it.
> 
> The header file contains then only includes dependent on
> CONFIG_GENERIC_GETTIMEOFDAY to not break ARCH=um. Nevertheless, keep the
> header file only with those includes to prevent spreading ifdeffery all
> over the place.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: x86@kernel.org
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> ---
>  arch/x86/include/asm/vgtod.h | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/vgtod.h b/arch/x86/include/asm/vgtod.h
> index 7aa38b2ad8a9..a0ce291abcae 100644
> --- a/arch/x86/include/asm/vgtod.h
> +++ b/arch/x86/include/asm/vgtod.h
> @@ -14,11 +14,6 @@
>  
>  #include <uapi/linux/time.h>
>  
> -#ifdef BUILD_VDSO32_64
> -typedef u64 gtod_long_t;
> -#else
> -typedef unsigned long gtod_long_t;
> -#endif
>  #endif /* CONFIG_GENERIC_GETTIMEOFDAY */
>  
>  #endif /* _ASM_X86_VGTOD_H */
> 

-- 
Regards,
Vincenzo


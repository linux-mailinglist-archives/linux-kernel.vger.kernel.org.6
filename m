Return-Path: <linux-kernel+bounces-291828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704059567B1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2440A282AC6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 09:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711FA15DBB6;
	Mon, 19 Aug 2024 09:57:59 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C6A13B592
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724061479; cv=none; b=CxJsfiTpJUkvzAt0Ttgd/9kK2jtbJhGUP7qsVlC/DCpKApylAYKLhtCGDmj/g3WvKdj4+0884LBNs05DsFuNc3IQBRB1CSbtbz1kx54sEXcszt2tAZKgwIB8iuK+FmUMHdwEkqwLk/12hftjiBfTzDRX6lE9CnhSyLJAVnxgpZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724061479; c=relaxed/simple;
	bh=90a/RVgk60kCpe/pWWIEGS6e9qC4DOGm+RrSYDM7tjM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DtuUcRlU1wzRLqB5t3RMLHt0Agfl3LZR4qPRgQh2SpGIQL/D141EEMxNgMwC7tLISvacDZ3108NZfRTTk6xs5HE16iLB34wi+ojaxyV1OqkGqe5d/kRu7htpHMjqwluhHZNXjDsP9fSkm7Kdqzjjtz46dfQzb3mf6JFdksogvKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WnScz4lGNz6K94c;
	Mon, 19 Aug 2024 17:54:59 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 6331E1400DB;
	Mon, 19 Aug 2024 17:57:52 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 19 Aug
 2024 10:57:51 +0100
Date: Mon, 19 Aug 2024 10:57:50 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Tong Tiangen <tongtiangen@huawei.com>
CC: Mark Rutland <mark.rutland@arm.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, James Morse <james.morse@arm.com>, "Robin
 Murphy" <robin.murphy@arm.com>, Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino
	<vincenzo.frascino@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, Aneesh Kumar K.V <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mm@kvack.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <wangkefeng.wang@huawei.com>, Guohanjun
	<guohanjun@huawei.com>
Subject: Re: [PATCH v12 1/6] uaccess: add generic fallback version of
 copy_mc_to_user()
Message-ID: <20240819105750.00001269@Huawei.com>
In-Reply-To: <20240528085915.1955987-2-tongtiangen@huawei.com>
References: <20240528085915.1955987-1-tongtiangen@huawei.com>
	<20240528085915.1955987-2-tongtiangen@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 28 May 2024 16:59:10 +0800
Tong Tiangen <tongtiangen@huawei.com> wrote:

> x86/powerpc has it's implementation of copy_mc_to_user(), we add generic
> fallback in include/linux/uaccess.h prepare for other architechures to
> enable CONFIG_ARCH_HAS_COPY_MC.
> 
> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Seems like a sensible approach to me given existing fallbacks in x86
if the relevant features are disabled.

It may be worth exploring at some point if some of the special casing
in the callers of this function can also be remove now there
is a default version. There are some small differences but I've
not analyzed if they matter or not.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  arch/powerpc/include/asm/uaccess.h | 1 +
>  arch/x86/include/asm/uaccess.h     | 1 +
>  include/linux/uaccess.h            | 8 ++++++++
>  3 files changed, 10 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
> index de10437fd206..df42e6ad647f 100644
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -381,6 +381,7 @@ copy_mc_to_user(void __user *to, const void *from, unsigned long n)
>  
>  	return n;
>  }
> +#define copy_mc_to_user copy_mc_to_user
>  #endif
>  
>  extern long __copy_from_user_flushcache(void *dst, const void __user *src,
> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
> index 0f9bab92a43d..309f2439327e 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -497,6 +497,7 @@ copy_mc_to_kernel(void *to, const void *from, unsigned len);
>  
>  unsigned long __must_check
>  copy_mc_to_user(void __user *to, const void *from, unsigned len);
> +#define copy_mc_to_user copy_mc_to_user
>  #endif
>  
>  /*
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index 3064314f4832..0dfa9241b6ee 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -205,6 +205,14 @@ copy_mc_to_kernel(void *dst, const void *src, size_t cnt)
>  }
>  #endif
>  
> +#ifndef copy_mc_to_user
> +static inline unsigned long __must_check
> +copy_mc_to_user(void *dst, const void *src, size_t cnt)
> +{
> +	return copy_to_user(dst, src, cnt);
> +}
> +#endif
> +
>  static __always_inline void pagefault_disabled_inc(void)
>  {
>  	current->pagefault_disabled++;



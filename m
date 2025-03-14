Return-Path: <linux-kernel+bounces-561235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B4CA60F11
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF60D1702E1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918A71F239B;
	Fri, 14 Mar 2025 10:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XM1E5Zr8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4212E3364
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741948500; cv=none; b=VySFfQgRDWYbDvxaW5wJzdLh74wIM2A6cGSHrqlozo38ev90WWIM71e4s0R1G/X/fOHs87GpVqtVSBKR6ZA4ii5m83moEPczu0AqhZfjY51yKK2wo4LoRSC2QL2Pm10G10IUc6VkJeB9yWTKBu5yKHrAU7Lzh4wWEAVE+pfO4mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741948500; c=relaxed/simple;
	bh=l8ntTR3a/55I6o8PPqCMsWt7nAeOmzqzgHnF4Wr5xFc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cMFbYgPUeWxBmTj5LJQd93oXzM2ue87Ux7jffGWVZUBTQr41uAVdxu3GrkeUw2mWj3bLU6r9CU8HULJrRjEdKFye/CukBneL8TrAzEkOs8qY/jxv8Ck/JjTqyT+WxhH0TRAQ0HwM2HVMKGAy/HGXY35/4H0LSut7KcWK1Bi7lRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XM1E5Zr8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD715C4CEE3;
	Fri, 14 Mar 2025 10:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1741948500;
	bh=l8ntTR3a/55I6o8PPqCMsWt7nAeOmzqzgHnF4Wr5xFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XM1E5Zr8Ro4VqUSVAIIoI7m5VnsBdzZkV1oiUDdBTTY2kfXjaQ26Ukpbo6UTWA31d
	 pdvLsBjr92PBSumYIGQ7AYNPDleTGE74CI1WSTOdHx8FeiVGi+5GMashPL78zy/lrw
	 TFKf3LQkPLU0Lq1etg2KEsVcN7iR5SV0e5puJcgU=
Date: Fri, 14 Mar 2025 03:34:59 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, =?ISO-8859-1?Q?Andr=E9?= Almeida
 <andrealmeid@igalia.com>, Darren Hart <dvhart@infradead.org>, Davidlohr
 Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Valentin Schneider <vschneid@redhat.com>,
 Waiman Long <longman@redhat.com>, Uladzislau Rezki <urezki@gmail.com>,
 Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org, Christoph
 Hellwig <hch@lst.de>
Subject: Re: [PATCH v10 19/21] mm: Add vmalloc_huge_node()
Message-Id: <20250314033459.180e943deaa30dcf3549f376@linux-foundation.org>
In-Reply-To: <20250314095931.825Pdmvi@linutronix.de>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
	<20250312151634.2183278-20-bigeasy@linutronix.de>
	<20250312150206.54afabcf993bbc55f0066886@linux-foundation.org>
	<20250313075924.qulV64zL@linutronix.de>
	<20250313150814.075d1cd993a84005d4cd22c2@linux-foundation.org>
	<20250314095931.825Pdmvi@linutronix.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Mar 2025 10:59:31 +0100 Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2025-03-13 15:08:14 [-0700], Andrew Morton wrote:
> > That would be nice, if you think it makes sense.  There is some
> > duplication here.
> 
> As you wish. That would be the following patch below.

Looks OK.

> This is now
> somehow unique compared to the other interfaces (like vmalloc() vs
> vmalloc_node()).

I'm not sure what this means?

I kinda struggle with the name "vmalloc_huge_node".  But
"vmalloc_node_maybe_huge" is too long!


> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -207,7 +207,23 @@ void *vmalloc_noprof(unsigned long size)
>  }
>  EXPORT_SYMBOL(vmalloc_noprof);
>  
> -void *vmalloc_huge_noprof(unsigned long size, gfp_t gfp_mask) __weak __alias(__vmalloc_noprof);
> +/*
> + *	vmalloc_huge_node  -  allocate virtually contiguous memory, on a node
> + *
> + *	@size:		allocation size
> + *	@gfp_mask:	flags for the page level allocator
> + *	@node:          node to use for allocation or NUMA_NO_NODE
> + *
> + *	Allocate enough pages to cover @size from the page level
> + *	allocator and map them into contiguous kernel virtual space.
> + *
> + *	Due to NOMMU implications the node argument and HUGE page attribute is
> + *	ignored.
> + */
> +void *vmalloc_huge_node_noprof(unsigned long size, gfp_t gfp_mask, int node)
> +{
> +	return __vmalloc_noprof(size, gfp_mask);
> +}

Please check, I think this wants to be EXPORTed to modules.

> -void *vmalloc_huge_noprof(unsigned long size, gfp_t gfp_mask)
> +void *vmalloc_huge_node_noprof(unsigned long size, gfp_t gfp_mask, int node)
>  {
>  	return __vmalloc_node_range_noprof(size, 1, VMALLOC_START, VMALLOC_END,
> -				    gfp_mask, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
> -				    NUMA_NO_NODE, __builtin_return_address(0));
> +					   gfp_mask, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
> +					   node, __builtin_return_address(0));
>  }
> -EXPORT_SYMBOL_GPL(vmalloc_huge_noprof);
> +EXPORT_SYMBOL_GPL(vmalloc_huge_node_noprof);

Like the NOMMU=n version.


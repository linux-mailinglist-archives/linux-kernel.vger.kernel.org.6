Return-Path: <linux-kernel+bounces-407709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1302A9C7164
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6DF1286267
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF27200CAE;
	Wed, 13 Nov 2024 13:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kFeaJ2nL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B221FF7C2
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 13:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731505807; cv=none; b=tsrncKCIEe39G4Nv74+G4N1UTcOAluuHCForPhuthp6fYoJUdfZagSpLyClABWkJVCIxArcXDN5en7J2AcEcEmJ89q6jQMQdAsbPCB7/agbLJtFqwKAQiq+zCaFW0V4vEBr02Y06940c4utDhuzk19BIHFdQXKBTUsk+FmW3Scw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731505807; c=relaxed/simple;
	bh=Znl7Dk+1vnR/ytY4vzGG5873bkylts3zXUWRbDVC44g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2g4sU1qej99V3Hnj7XtBSO30Zw/Pgvk30u/T7chzzWMr+GBGdDCIpcR4Rf0HH97y0UCd/k69spI7IsAkDga/BOWBQ+uekkqa7swG0OVAxCAM7Mv2jVsu6rW8pIOCJmUDuSIg1idtbYceiAb/iNGx2ECWSHZBPOwwb9VYFUgojY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kFeaJ2nL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4C4C4CEC3;
	Wed, 13 Nov 2024 13:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731505806;
	bh=Znl7Dk+1vnR/ytY4vzGG5873bkylts3zXUWRbDVC44g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kFeaJ2nL2Bd1oDCIOqWEhw60wmQcbnktW2csPCyPV1WnAy/WDxvEsF8n/PKgCIXNc
	 8EV1Wti0JizL53j0ZdMnpTQDEpqHTqWTZO38+aX3mAtrRTuHyVlZ/K9qTmmqEpuT1n
	 H3kzxwpy6IrwkUhWfmcudJVHPH81vCt2XBd388A0=
Date: Wed, 13 Nov 2024 14:50:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Li Huafei <lihuafei1@huawei.com>
Cc: tiantao6@hisilicon.com, rafael@kernel.org, Jonathan.Cameron@huawei.com,
	baohua@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] topology: Keep the cpumask unchanged when printing cpumap
Message-ID: <2024111347-buggy-cranium-61c3@gregkh>
References: <20241113165900.78095-1-lihuafei1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113165900.78095-1-lihuafei1@huawei.com>

On Thu, Nov 14, 2024 at 12:59:00AM +0800, Li Huafei wrote:
> During fuzz testing, the following warning was discovered:
> 
>  different return values (15 and 11) from vsnprintf("%*pbl
>  ", ...)
> 
>  test:keyward is WARNING in kvasprintf
>  WARNING: CPU: 55 PID: 1168477 at lib/kasprintf.c:30 kvasprintf+0x121/0x130
>  Call Trace:
>   kvasprintf+0x121/0x130
>   kasprintf+0xa6/0xe0
>   bitmap_print_to_buf+0x89/0x100
>   core_siblings_list_read+0x7e/0xb0
>   kernfs_file_read_iter+0x15b/0x270
>   new_sync_read+0x153/0x260
>   vfs_read+0x215/0x290
>   ksys_read+0xb9/0x160
>   do_syscall_64+0x56/0x100
>   entry_SYSCALL_64_after_hwframe+0x78/0xe2

What is happening when this fuzzing is going on?  Removing/adding cpus?

> The call trace shows that kvasprintf() reported this warning during the
> printing of core_siblings_list. kvasprintf() has several steps:
> 
>  (1) First, calculate the length of the resulting formatted string.
> 
>  (2) Allocate a buffer based on the returned length.
> 
>  (3) Then, perform the actual string formatting.
> 
>  (4) Check whether the lengths of the formatted strings returned in
>      steps (1) and (2) are consistent.
> 
> If the core_cpumask is modified between steps (1) and (3), the lengths
> obtained in these two steps may not match. Indeed our test includes cpu
> hotplugging, which should modify core_cpumask while printing.

Ah, yes.  Good catch.

> To fix this issue, cache the cpumask into a temporary variable before
> calling cpumap_print_{list, cpumask}_to_buf(), to keep it unchanged
> during the printing process.

Nice, but:

> 
> Fixes: bb9ec13d156e ("topology: use bin_attribute to break the size limitation of cpumap ABI")

No cc: stable?

> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> ---
>  drivers/base/topology.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/topology.c b/drivers/base/topology.c
> index 89f98be5c5b9..70dbd7ef038d 100644
> --- a/drivers/base/topology.c
> +++ b/drivers/base/topology.c
> @@ -27,9 +27,17 @@ static ssize_t name##_read(struct file *file, struct kobject *kobj,		\
>  			   loff_t off, size_t count)				\
>  {										\
>  	struct device *dev = kobj_to_dev(kobj);                                 \
> +	cpumask_var_t mask;							\
> +	ssize_t n;								\
>  										\
> -	return cpumap_print_bitmask_to_buf(buf, topology_##mask(dev->id),	\
> -					   off, count);                         \
> +	if (!alloc_cpumask_var(&mask, GFP_KERNEL))				\
> +		return 0;							\

If this fails, return the error please.  Don't return a size of 0, which
will just confuse userspace as to why the read succeeded yet did not
return any data?

> +										\
> +	cpumask_copy(mask, topology_##mask(dev->id));				\
> +	n = cpumap_print_bitmask_to_buf(buf, mask, off, count);			\
> +	free_cpumask_var(mask);							\
> +										\
> +	return n;								\
>  }										\
>  										\
>  static ssize_t name##_list_read(struct file *file, struct kobject *kobj,	\
> @@ -37,9 +45,17 @@ static ssize_t name##_list_read(struct file *file, struct kobject *kobj,	\
>  				loff_t off, size_t count)			\
>  {										\
>  	struct device *dev = kobj_to_dev(kobj);					\
> +	cpumask_var_t mask;							\
> +	ssize_t n;								\
> +										\
> +	if (!alloc_cpumask_var(&mask, GFP_KERNEL))				\
> +		return 0;							\

Same here, please return the error.

thanks,

greg k-h


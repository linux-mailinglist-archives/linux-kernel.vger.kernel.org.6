Return-Path: <linux-kernel+bounces-301328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5FE95EF1C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE4D1289262
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14B0154458;
	Mon, 26 Aug 2024 10:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dWhbUJ77";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sIT6Kxpv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F84154C0A
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 10:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724669705; cv=none; b=dvyOl4/nw7KHGPQZLTYbpnn7odXDnEv709uFkHDV16EWvT+HWMLcK7fP19MfCJq2Zv1G2cVmi7oOPPiEjZfc5KaDeSkSm0JBVLgSq8BZvPogor4dMqqQmpEQmqDE+gdYIzLJDR+dVRvd5HCtdUmHKqs6K43EtWn4IgGAFJiwCy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724669705; c=relaxed/simple;
	bh=+jifOuFdqX3hEyWXd5mXVDdepcGv0de/NU9pi/ui2wg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E2u38QuKtyNgX9M8N6nGquCbkqGX5nYH3KqZUOKkDUm8XBUQymEsZj9pd9bc4svKl0YJNVRt94Vckv2MSAJaLyfqR/yyjCmiRW7ljk/0vgfW7IjyZdxbOoDOWEtSHZH/4iqqWsmTXgTVDGlV5tJOIruQ965sBx4h7dcQ4IQ2UFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dWhbUJ77; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sIT6Kxpv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724669701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xyy/9EfpWkx8KTwGBZRfyUnnf41eemSTPmGgHeisF08=;
	b=dWhbUJ77IoPaGluyyIP0gbl2ndVlT5wrQiVxNsgpuTW70LOfGt8MyeoSu4hiYv784WjLQ+
	uMTuXgr4Ro3vVleUS0C4K0sbsTLjoM+NVg7xvqI8JI3Iq5Hp7VCDJ3VUrYimV/3ArMdtbX
	2eBg0EfMyQHGV7ntwqWyWDTK3altwh2YDANOngycioD4GP1qmE2e5sNBSlEYU8tx7MsLgn
	WWYPUf801HrhCf+LaTVBc4cMFuXB5CKBFZxfLN/LJQpwFjeihTrxU/B1u99iRoMC/Ih3KJ
	6O6Vfw4rzykeLUQQgG+r0gE2ScmjCPSJcFOd+lMXUty6qdWD4knUBnnBvd+n/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724669701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xyy/9EfpWkx8KTwGBZRfyUnnf41eemSTPmGgHeisF08=;
	b=sIT6KxpvK8mJpA0lpYZ4OTj5SlF0c8oBOtgJBYBaB5HzSXhPqtVGFwhkefEobRJXqmaJ0f
	3HhgLnSi7glqJvDA==
To: Jeff Xie <jeff.xie@linux.dev>
Cc: linux-kernel@vger.kernel.org, xiehuan09@gmail.com, Jeff Xie
 <jeff.xie@linux.dev>
Subject: Re: [PATCH v2] genirq: procfs: Make smp_affinity read-only for
 interrupts that userspace can't set
In-Reply-To: <20240825131911.107119-1-jeff.xie@linux.dev>
References: <20240825131911.107119-1-jeff.xie@linux.dev>
Date: Mon, 26 Aug 2024 12:55:00 +0200
Message-ID: <87seurd057.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Aug 25 2024 at 21:19, Jeff Xie wrote:
> The kernel already knows at the time of interrupt allocation that the
> affinity cannot be controlled by userspace and therefore creating the
> file with write permissions is wrong.
>
> Therefore set the file permissions to read-only for such interrupts.
>
> Signed-off-by: Jeff Xie <jeff.xie@linux.dev>
> ---
> v2:
> - Updated the description suggested by tglx
> - Corrected the return value from -EIO to -EPERM when the userspace can't set the affinity
>
>  kernel/irq/proc.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
> index 8cccdf40725a..7b3a4c92d148 100644
> --- a/kernel/irq/proc.c
> +++ b/kernel/irq/proc.c
> @@ -142,7 +142,7 @@ static ssize_t write_irq_affinity(int type, struct file *file,
>  	int err;
>  
>  	if (!irq_can_set_affinity_usr(irq) || no_irq_affinity)
> -		return -EIO;
> +		return -EPERM;

I drop this hunk as it is unrelated to $subject. That want's to be a
separate patch. Documentation/process clearly states:

         Solve only one problem per patch.

Thanks,

        tglx


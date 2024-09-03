Return-Path: <linux-kernel+bounces-312410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A92D96963D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28E9E1F23CD6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CA41DAC78;
	Tue,  3 Sep 2024 07:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FS9g3634"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BCA1D54D3
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 07:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725350125; cv=none; b=qDeTm89IpwzHfRbCvN+8TbzGz32BPr1i5g0fwNHAZLwwmxlNoDEmpDxXeKGdYoGzvP9Zgbp6WyL0D76oysejCVP7zUSwXHm0U0GUTioPzvQVkH2vp5YmFnwv3jnwwmGbhI7KZQHDWlHbrybr7FGbs5loxOdIxM9NsU4dO8oSWYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725350125; c=relaxed/simple;
	bh=lHEjtxV41KqvLn7BW25CS1r3sTnWoMNIxb0wXuXSs+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqoWHUzHsWkhpTkkB9D9mkb8CUQY3Fu7tNkzgcGm97oC1EJv0zPli1QyEOL2ThkHzWj8m5dDhewSyT0WcqOj2+/bdMVhXkCPBS/3A5ezJcjNIe0y3tTwVOSJAgpBndaC09jB5x54innkeQhxBv/Jh6xG5jb0DiDPnOcIVXd28GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FS9g3634; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7d4f0181be2so272457a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 00:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725350123; x=1725954923; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=igBgchUo2vyXbADov+gENWjdwyJXCwLlZ3FYaV7kMJs=;
        b=FS9g3634v6/ZxzEq6YzPP0l87ePx1u48v98X7pGaW/oYdBEMEECCZfCbEYVB03QAr0
         fhABYz5VXAf+xAzNzCB51cldhra2CRJRDH/bPseviLGnaf9xun+pBdrwRZpb/KjfP1Ag
         cJsXOz7f8eFyHF76bIHu/dkwg+uGGgKDekRlM8xBPhY/SnkLWKyq4icQcanD9e47Ts4F
         tDEKL3zrH7IQGxDmVSLEGmd2qjiee7bX6U0quq+p3AvQPLzkThIibtskEt7Ii8yanLVi
         3ZmD/fVRqCTaV4d5b9E0hD2wTfZRHTfLzqxpZu80urjr1xt85ShYnvMgCj5Es/E8xmm3
         WG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725350123; x=1725954923;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=igBgchUo2vyXbADov+gENWjdwyJXCwLlZ3FYaV7kMJs=;
        b=jNC4UBTkcENQs+damVnk4jXtSuSDSs8lkN7rjk2W5h1kBoFDFzHIStpTp1B2w7JdZd
         el1dap0jAgNsRMNGMfEHMnAOQ2dgRQ4OoGE0VW0sycsfWszp/v3ucLiieJe7CdEuN2UU
         g2AEfjLUQpJ/EtM/K4SRrpt9bSnO/xkC7reiq1+Bc/aE/um+aQRL48fy87mZHqCu+Plu
         KbiSXtkvPzJbaUmtiRz4CFoFvd322nO0O8mcU5Ti/zqY4OFK6nlENY2xXdYkH3GdmVPk
         vy+QQuZKRK0DcboURNcpW45/3+kxfpfPO7T0HS1G8LVjBG4tROG49qk2f0yKJf2Tg2Tw
         97GQ==
X-Gm-Message-State: AOJu0YxTEVwAgEIsNKLZnkADSVpZIzjNzb7Dp0sNkpq7ATM3xA/hMVVm
	H2oo1I/CKPMjhOB5dScA2VxUJIg8VhAo5AGnHpaJj5JhEnvc3bfV
X-Google-Smtp-Source: AGHT+IEOODZ2+fsB4siQlM6mhBxUnPAFrTjs9gHzR6Bwmi8h/FnHCIbdSvuRzIJSel2zF1VVfGnE8A==
X-Received: by 2002:a17:90b:3e83:b0:2d3:bd5c:4ac8 with SMTP id 98e67ed59e1d1-2d856383ff8mr18663084a91.27.1725350122463;
        Tue, 03 Sep 2024 00:55:22 -0700 (PDT)
Received: from den-build ([116.228.68.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8f5ec4bc6sm2591066a91.57.2024.09.03.00.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 00:55:21 -0700 (PDT)
Date: Tue, 3 Sep 2024 15:55:16 +0800
From: Richard Clark <richard.xnu.clark@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	torvalds@linux-foundation.org
Subject: Re: [PATCH] irq: fix the interrupt trigger type override issue
Message-ID: <ZtbA5Adh2acTExYq@den-build>
References: <ZtUuYXSq8g2Mphuq@den-build>
 <87r0a27blv.ffs@tglx>
 <CAJNi4rPm2N=_H7LjT3X3_b2-UVZP+EEOw-ztwBwWBs=vMtfYQQ@mail.gmail.com>
 <877cbu7596.ffs@tglx>
 <CAJNi4rPooS82fB+6FditywXTga00JbGoFM6MR8P7U3s7mdbJCg@mail.gmail.com>
 <87y14a5dcq.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y14a5dcq.ffs@tglx>

Hi Thomas,

On Mon, Sep 02, 2024 at 04:39:33PM +0200, Thomas Gleixner wrote:
> Richard!
> 
> On Mon, Sep 02 2024 at 20:50, richard clark wrote:
> > On Mon, Sep 2, 2024 at 5:51 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> >> 2) rmmod()
> >> >>      tears down mapping
> >> >>
> >> > This just tears down the action allocated and installed by
> >> > request_irq(...), but does not teardown the irq's node inserted in the
> >> > revmap_tree.
> >>
> >> So what creates the mapping? If the driver creates it then why doesn't
> >> it unmap it when it exits?
> >>
> > Kernel allocates an irq and creates the mapping during its
> > initialization when parsing the device's interrupt firmware, not the
> > driver does that.
> 
> So the mapping and the interrupt allocation persist even if nothing uses
> them. What a waste.
>
I checked the code and found that it's not the kernel to create the mapping,
it's by the driver calling platform_get_irq(...)/of_irq_get(...) to create. 
> 
> >> > The logic is if the trigger type specified by request_irq(...) is not
> >> > consistent with the firmware one, the request_irq will override the
> >> > FW. We need to keep this logic the same as when we insmod the same
> >> > kmod next time -- override the FW's too instead of returning a
> >> > mismatch type error.
> >>
> >> I can see how that can happen, but what's missing is the information why
> >> this mapping persists and why it's tried to be set up again.
> >>
> > As I mentioned, it doesn't try to set up again. It will just lookup
> > the mapping from the tree for the persistent reason when driver try to
> > request the irq...
> 
> Fair enough. Though the logic in that map code is convoluted as hell and
> making it more convoluted does not really make it better.
> 
> So let's look at how this works (or not):
> 
> 1)
>    map()
>    allocate_irq();
>    set_trigger_type(FW);
> 
> 2)
>    request_irq(type = DRV);
>    set_trigger_type(DRV);
> 
> 3)
>    free_irq();
>    // type is not reset to FW
> 
> 4)
>    map()
>      irq_trigger_type() != NONE && != FW
>         -> fail
> 
> This results in a pile of questions:
> 
>   Why does #2 override the firmware, if the firmware defines a trigger
>   type != NONE?
> 
>   Isn't the whole point of firmware defining the type that the driver
>   does not need to care?
> 
>   If the firmware cannot does not know what the right thing is then it
>   should say so by using type NONE and the type is using the hardware
>   or interrupt driver default.
> 
> That aside. What you are trying to do only works when #2 and #4 are
> coming from the exactly same context.
> 
> What it does not catch is when the interrupt line is shared and there
> are two drivers where the first one fiddles with type on request_irq()
> and the second one relies on the firmware to do the right thing.
> 
> Same problem if you unload the driver and remove the type from
> request_irq() flags because you figured out that this was bogus. Then
> you end up with the old setting when you load the recompiled driver
> again.
> 
> That's all inconsistent. The proper solution would be to restore the
> firmware setting in free_irq() when the last action goes away.
> 
> The question is whether it's worth the trouble. If not then we can just
> make all of this simple, trivial and incomplete instead of making it
> more complex and differently incomplete.
>

Ah, the mapping is created from of_irq_get(...) by driver, the kernel also
provides the mapping teardown interface - irq_dispose_mapping.
IMO, the right way for the driver is:
	1) driver calls of_irq_get() to get the irq and create the mapping
	2) driver *should* call irq_dispose_mapping() as the teardown of step 1.
	3) free_irq is the teardown of the request_irq to free the irq and
	   its action.
So the original issue should be the bug of the driver not calling the
irq_dispose_mapping to release the mapping(and being persistent there). 
The error message will not show if irq_dispose_mapping(...) called by
the driver.
Looks like the current implementation is correct, but I don't know if it's true
for the shared irq...

Thanks!

> 
> Thanks,
> 
>         tglx
> ---
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -895,32 +895,14 @@ unsigned int irq_create_fwspec_mapping(s
>  	 */
>  	virq = irq_find_mapping(domain, hwirq);
>  	if (virq) {
> -		/*
> -		 * If the trigger type is not specified or matches the
> -		 * current trigger type then we are done so return the
> -		 * interrupt number.
> -		 */
> -		if (type == IRQ_TYPE_NONE || type == irq_get_trigger_type(virq))
> -			goto out;
> -
> -		/*
> -		 * If the trigger type has not been set yet, then set
> -		 * it now and return the interrupt number.
> -		 */
> -		if (irq_get_trigger_type(virq) == IRQ_TYPE_NONE) {
> +		/* Preserve the trigger type set by request_irq() */
> +		if (type != IRQ_TYPE_NONE && irq_get_trigger_type(virq) == IRQ_TYPE_NONE) {
>  			irq_data = irq_get_irq_data(virq);
> -			if (!irq_data) {
> +			if (irq_data)
> +				irqd_set_trigger_type(irq_data, type);
> +			else
>  				virq = 0;
> -				goto out;
> -			}
> -
> -			irqd_set_trigger_type(irq_data, type);
> -			goto out;
>  		}
> -
> -		pr_warn("type mismatch, failed to map hwirq-%lu for %s!\n",
> -			hwirq, of_node_full_name(to_of_node(fwspec->fwnode)));
> -		virq = 0;
>  		goto out;
>  	}
>  
> 
>    


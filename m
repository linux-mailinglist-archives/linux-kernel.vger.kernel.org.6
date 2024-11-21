Return-Path: <linux-kernel+bounces-417180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBE89D5005
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 16:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19CB4B226B3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 15:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC93189B81;
	Thu, 21 Nov 2024 15:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wurPV7Fy"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986B970815
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 15:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732203921; cv=none; b=JArsUX3Yug6myhsMamD9yPPBNNrbCAeQFfqiCOAi59SI7FzqCHV0ydVQoc2n7QI2qaGiQTnrqOHWGiHG4EVWTWP8oKfaJeSLC5K0bIRvYZ9RxItgH6tzP0MM/dR49+VwKGvec1OzDz3D2BSLQazHTxFRq3ZWW91MjLoqbaNT/qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732203921; c=relaxed/simple;
	bh=C3+TMv+JfR89FLxkSrOyILwW0qfOXhqqT+YIQ09xJAg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oCULIwrAGt0wsDZnY4kaH7uW80YQz6SiHlbR6yXl6e2Vld/79LddFe7vtN/blXfDBfVs5HYP5HdBYQr8kRrKffsR9WWqVqnnsgDil3D9QeOfw++bRZQvPrDaoZPSqjaa0VveVix9Tu1S2/NOSZFaOtqm8d7+ltsjieheJjKHzds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wurPV7Fy; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6eeb8aa2280so16173957b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 07:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732203918; x=1732808718; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HamuaeYkSZPY6isgC3ltJNVU7ajwdcs8Gx9nQLciR8Y=;
        b=wurPV7FyJ2/tUS4coOTUPdrWg8M7xUGidzOPPYIeLPduJQqv2B3E11yP1VBD2PwLwY
         0csMDREfdBaFWi1Jsv4OmZecsVVrjkN+xDMoeWXRwCZ69ohTDDPdNgTfqXnkzyiZ2okJ
         0LSTH+8J6i/KEZmN1DffXQ6s4IoyvC9xs9XS7fKqLe+mp/pOfkc+fvta3nbhXyeFN9u4
         Uk1cigsdrUD/mTJvEvoa6o5kgkFKP7y+3eRsUKZAv12P7tGr5q/jCczRq5khbIcbziDA
         4/9y0spt40QaFWICkwzYHwkLak5dKg6Z0Q5/Zn3sXEs8OlxcXOTYDs7SD7Z0mcfrewNH
         M+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732203918; x=1732808718;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HamuaeYkSZPY6isgC3ltJNVU7ajwdcs8Gx9nQLciR8Y=;
        b=gct0/JYPAWTMV5rYxBew2pZubYm2SFkIn4BrGvxOyIRNgwEKh3GbMOVTa+fNyWlJ41
         tCspYX3jqC5nf7Jn9Hwa8w8dV3UcOSfOloui0yvpoaT9lDneL84UcttlOZREPU5uvaNh
         ZqlrFmAGxyNRa/ng+p45WIU+wL4iYPa0YHI/dEBz9926cu/Ls/ZeYwFidOkP0cDO2b4Z
         5icPwY6TLBMnQJxavpQjts+h5pP/LM4LdZTtt18jRxEaOM+EbuLxOuU+TEge1cCmYG8C
         CWv8wXrqajvdQsOmCbF1rWKP9R7YHGJN8Lo02/oWcCrAIrdv0gI00VeJpHOwysRt9fx2
         wGyg==
X-Gm-Message-State: AOJu0Yy+Xb6Lj50tAQS9OQ9cDA//MQyHMw8/piCcL7+tXUGwYacKrH/b
	iCbiI9s7CnPWwtg4ADIbi1UUqED9FLJHbG6iXbhs8XYjEAkYaHrgAOrbS1UKWJEii2OY8zpOPKB
	5Qg==
X-Google-Smtp-Source: AGHT+IFipUCBosSPRYKSM3o0GiYohdLjMf94GMG/BjwqRWrx5NmXMc/KFfYupFEzD8/S6jJX4iJYq/xKZnM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:690c:fcb:b0:6ea:1f5b:1f5e with SMTP id
 00721157ae682-6eebd166cb4mr40747b3.4.1732203918448; Thu, 21 Nov 2024 07:45:18
 -0800 (PST)
Date: Thu, 21 Nov 2024 07:45:17 -0800
In-Reply-To: <20241120195340.047C9ABE@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241120195327.26E06A69@davehans-spike.ostc.intel.com> <20241120195340.047C9ABE@davehans-spike.ostc.intel.com>
Message-ID: <Zz9VjVKbzMehRTjA@google.com>
Subject: Re: [PATCH 10/11] x86/fpu: Remove unnecessary CPUID level check
From: Sean Christopherson <seanjc@google.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de, 
	bp@alien8.de, rafael@kernel.org, lenb@kernel.org, dave.jiang@intel.com, 
	irenic.rajneesh@gmail.com, david.e.box@intel.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 20, 2024, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> The CPUID level dependency table will entirely zap X86_FEATURE_XSAVE

What table is that?  XSAVE depends on FXSR, but I can't find anything that clears
X86_FEATURE_XSAVE if cpuid_level < XSTATE_CPUID.  Even if it did, dropping a
sanity check in a one-time path adds risk for almost no reward.

> if the CPUID level is too low.  This code is unreachable.  Kill it.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> ---
> 
>  b/arch/x86/kernel/fpu/xstate.c |    5 -----
>  1 file changed, 5 deletions(-)
> 
> diff -puN arch/x86/kernel/fpu/xstate.c~xsave-leaf-checks-2 arch/x86/kernel/fpu/xstate.c
> --- a/arch/x86/kernel/fpu/xstate.c~xsave-leaf-checks-2	2024-11-20 11:44:20.369771244 -0800
> +++ b/arch/x86/kernel/fpu/xstate.c	2024-11-20 11:44:20.373771397 -0800
> @@ -764,11 +764,6 @@ void __init fpu__init_system_xstate(unsi
>  		return;
>  	}
>  
> -	if (boot_cpu_data.cpuid_level < XSTATE_CPUID) {
> -		WARN_ON_FPU(1);
> -		return;
> -	}
> -
>  	/*
>  	 * Find user xstates supported by the processor.
>  	 */
> _


Return-Path: <linux-kernel+bounces-282340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEC294E272
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 19:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3893C1F215A0
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 17:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11621537C7;
	Sun, 11 Aug 2024 17:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksYAhjEV"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACF227447
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 17:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723397830; cv=none; b=syofY4BWPSOm9I4h6nGHKRXZYKNj6huBkWCLW01ixTZY4AIzkAj79I+rvzRz8uRztDFkUw9kul6BfJignqyKjxaj867AxlosG9gpS01rF4fQWwdW7+5irFBf1nH6/v0FMfUfn3WpyXtzrRAtfg9tz445fqJkCvVZdlweWxsw2oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723397830; c=relaxed/simple;
	bh=1EiGTiROFv4q5u3t6n0EANoPGnoJVFtWZOAMTRSXMqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1EDQmiPGGe3HY6bc2e9x5Q53Es9KlKpichaCnGZlYlUdZgdhXReZk+f9gY+HGrhmig4T0n4S4Q7ftvbef+lUVeEgSDKAyA9gkC2qaweZ1wkdUCNlKTNA0s37fR6iKyDonRFgN1KQw+5vkj9aozA3e4XepWfwSQ0QAdb0m+DO6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksYAhjEV; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d26cb8f71so158980b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 10:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723397829; x=1724002629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G+PvmKKNVKze4C/QBHRr+qRVJwgBe+Hyuo1w73xp6tI=;
        b=ksYAhjEVxlamRGRenGWjfJbsHAnBkLbC3cs37jCPQVWosSujvP7KaZ41ge7w3/9RYz
         ppDqFy+1Am2niLmJS9ljsIc02U1qfMsJYCuZwNwPohmnXN0Lw5SNIoRdXTQV+lyL8dCp
         oU/7Adn1ihr4ZGa2VYw1vfMwQSNvmp+O83gmd+hQrMQwJ35g4lwpeiPxuI69jTRbZyPa
         ZApSlQ3Hgr897AYtJbIg7I6rH1QWl2ZVotX7WurtyN5W64HzXmIV6kEpcJ3K1qI/8dLt
         W6hzp+qgtTf1NlugajTkns0rF3IniYdpwjEGBT541xi9oEFZe2lwk0xqZ/kslGwJc8mS
         /56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723397829; x=1724002629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+PvmKKNVKze4C/QBHRr+qRVJwgBe+Hyuo1w73xp6tI=;
        b=ZIQkvWoV7VtqcYcSCNhRgMVSnohhhzI15A/eJz4IB+NUorY7jL8pq/aUXdAP4fqJEA
         JNfDSzn4DdBXdvKHkIlPXT3LMFkgamoLiegqCacPsl18dYbgYPzfShhz85gCW3zeodWJ
         BYhIAW5WxUj0/5bIwKCdkJtx+WFfUJs21d1Yx14l8pFOup9g9mmUVTII4BDuGdUvxJcv
         QlbsPRgGe6pEtR7DVwmBRgTtS82Idiwl9fs8UzRCXs7LJBbqL2N9ayt0ToviX/DNiLt2
         BzzUeoHuvmpumgHCrOwWt84sQPwncV6gqbeAmWM7DYC/BEYy3NkKRU/mYV9smR7XFplV
         RV4w==
X-Forwarded-Encrypted: i=1; AJvYcCVcwlnvWVJWNQV9mnIRUeol8DzDRTmAs9+6g9qZf7eussP/bnwhQmuP2UJBLlDnw4PYDx3VO+u43cQMGA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp3Eu2P3iNlvqZZR5EAq5K+fVhHjoXEqNG2EXF+QA5mdD3W9ey
	nS8WcIxnrq/n+9hcyKukCSLpATlhvYQfXyRRXxtvaI9UhyMYrGa5
X-Google-Smtp-Source: AGHT+IFFxzoLGtc9WykojPI4wkEztteRifZIbhn9LcZoVF3GGpPwNPBsmGRNdzDA+n4bPmxoVrVj5g==
X-Received: by 2002:a05:6a00:6f68:b0:70b:705f:8c5e with SMTP id d2e1a72fcca58-710dcb9df65mr4831759b3a.5.1723397828376;
        Sun, 11 Aug 2024 10:37:08 -0700 (PDT)
Received: from vaxr-BM6660-BM6360 ([2001:288:7001:2703:fb13:4730:5b8f:99e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5a55c33sm2631611b3a.115.2024.08.11.10.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 10:37:07 -0700 (PDT)
Date: Mon, 12 Aug 2024 01:37:03 +0800
From: I Hsin Cheng <richard120310@gmail.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpumask: Ensure the visibility of set_nr_cpu_ids
Message-ID: <Zrj2v4IFbS/1yPnz@vaxr-BM6660-BM6360>
References: <20240811092501.87653-1-richard120310@gmail.com>
 <ZrjWKV0a37yTO1km@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrjWKV0a37yTO1km@yury-ThinkPad>

On Sun, Aug 11, 2024 at 08:18:01AM -0700, Yury Norov wrote:
> On Sun, Aug 11, 2024 at 05:25:01PM +0800, I Hsin Cheng wrote:
> > The variable "nr_cpu_ids" is a system-wide variable which should be seen
> > as consistent all the time. For example it's set in one of the kernel
> > setup procedure "prefill_possible_map", the operations here should
> > happens before all the code after setup, which means the operations here
> > should be visible to all the code after setup.
> > 
> > set_cpu_possible() ensure it's visibility because it eventually falls
> > into an atomic instruction, however the function "set_nr_cpu_ids()"
> > fails to make the guarantee since it only performs a normal write
> > operations.
> 
> Set_cpu_possible() is a completely different thing.
>  
> > Adding the macro "WRITE_ONCE()" will prevent the compiler from re-order
> > the instruction of the write operation for "nr_cpu_ids", so we can
> > guarantee the operation is visible to all the codes coming after it.
> > 
> > Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
> 
> I don't understand this. nr_cpu_ids is initialized at compile time
> to NR_CPUS, to represent maximum number of bits in cpumasks.
> 
> Later on runtime we update nr_cpu_ids with an actual number of possible
> CPUs in the system. The type of the variable is unsigned int, and it
> means that threads accessing it will either fetch NR_CPUS, or new value
> coherently.
> 
> Having nr_cpu_ids == NR_CPUS is not an error, it's just a non-optimal
> value. The only effect of it is that kernel algorithms traverse unused
> part of cpumasks for the first few microseconds after boot.
> 
> Can you explain in details what type of race you're trying to fix?
> Which architecture? What is the race scenario?
> 
> > ---
> >  include/linux/cpumask.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> > index f10fb87d4..3731f5e43 100644
> > --- a/include/linux/cpumask.h
> > +++ b/include/linux/cpumask.h
> > @@ -46,7 +46,7 @@ static inline void set_nr_cpu_ids(unsigned int nr)
> >  #if (NR_CPUS == 1) || defined(CONFIG_FORCE_NR_CPUS)
> >  	WARN_ON(nr != nr_cpu_ids);
> >  #else
> > -	nr_cpu_ids = nr;
> > +	WRITE_ONCE(nr_cpu_ids, nr);
> 
> 
> WRITE_ONCE()? How is that supposed to work? The only possible effect
> would be reordering of a couple of instructions. How would that help
> threads running on other CPUs synchronize any better?
> 
> Regardless, WRITE_ONCE() should always be paired with READ_ONCE() to
> make it working. So, if we take this, we should also make every read of
> nr_cpu_ids by using READ_ONCE(). nr_cpu_ids is used in fast paths in
> many places, particularly as loop termination condition. Things like
> this:
> 
>         while (cpu < READ_ONCE(nr_cpu_ids))
>                 do_something_very_quick();
> 
> would definitely hit performance.
> 
> Thanks,
> Yury
> 
> >  #endif
> >  }
> >  
> > -- 
> > 2.34.1

Thanks for the reply and your detailed explanation, I wasn't trying to
fix any race conditions, I was thinking the same as you mentioned that
some of the cpumask's operation would traverse more times than it
actually needs to. I took set_cpu_possible() as an example trying to
express I think it would be nice for nr_cpu_ids to make synchronized
guarantees across CPUs, as WRITE_ONCE() would also provide write memory
barrier.

> Regardless, WRITE_ONCE() should always be paired with READ_ONCE() to
> make it working. So, if we take this, we should also make every read of
> nr_cpu_ids by using READ_ONCE(). nr_cpu_ids is used in fast paths in
> many places, particularly as loop termination condition. Things like
> this:
>
>         while (cpu < READ_ONCE(nr_cpu_ids))
>                 do_something_very_quick();
>
> would definitely hit performance.

Indeed if WRITCE_ONCE() is going to be applied here, every read of
nr_cpu_ids will have to use READ_ONCE() and it'll harm the fast path's
performance. I didn't considered this part, thanks for pointing it out.
Comparing to the number of redundant traversal, I think the performance
hit introduced by READ_ONCE() in fast path will be larger, so we should
stick to the same way. I learned alot and should reconsidered many parts
of my former knowledge about cpumask from your reply.
Thanks again for your detail explanation and kindly reply !

Best regards,
I-Hsin Cheng


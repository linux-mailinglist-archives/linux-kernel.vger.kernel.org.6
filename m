Return-Path: <linux-kernel+bounces-272431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CABE945BDF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 12:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D58D4282F5B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 10:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DD61D0DE6;
	Fri,  2 Aug 2024 10:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MVBCWWBQ"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5889947A74
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 10:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722593979; cv=none; b=h3Wl6Jgvdl5d6Qs123rcJW4Q9iusyPDI0NVQV74Ik44DNYUZm0JumG/Qh1PDejI2UjDtAN8/uSB/NMBQ3CfvzCvmuO4B3GC7Yumi2WnOVQZ2o6SRQtNmLvtjkKHhWaLK6TIK9stJs4j3NVw5l+zgfpxYjxj82wkQDXCBWKjGtx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722593979; c=relaxed/simple;
	bh=W1GGNRMDpD1KlMZsqLcQjF+o/toLNUm36ePLVw7fR4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2bR2+43ok1+ApSAZGVkKLghBJOXhJL+5TKjq3g0WJMgbEXzc2V+nRuRmApSdTtkjh/PlRz/m64GinqcTPl/O25fvZCKM0GlPePpvdjiiTOsiYO4qK7HivEaV9hAXMTUgw8NYjcnphtvld0x0hzC+iZ5Rfgn5CBG3wjIpaIWjDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MVBCWWBQ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7abe5aa9d5so907470766b.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 03:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722593976; x=1723198776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FBxfj60iZok+8GSxoKFy9yPNdXszqO75QwuP92f6zDU=;
        b=MVBCWWBQvcyk4T7rM38uipXYHvtXk6G2QmjiRWcCzuap2hfFFvBMCK8NN00o4PR7vj
         OSqYPHudG4c+LpZRQ8hOi+UvEQyX0MTc+7pk80DhNp6F9ChsFmV4qk2RPOM85M2pxtjA
         fqSd2ZYgcMAyj882wOTo112C9B7ANROsopL/2QTiZFBDZnHFumnG8J+/Vt44mEjHwtds
         sjo949GeBd0lFV8nkpgzZugWuNCH4pec09gggrXcNrjrHdCM2yzAZqz/g1G4DDBkOv4+
         DueiedGiqmA5zj4Ih1zK3OIdy/1ixbNNHLFQUoBaThpng4XHe4R9+W1bcUioyGjwUnFr
         gnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722593976; x=1723198776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBxfj60iZok+8GSxoKFy9yPNdXszqO75QwuP92f6zDU=;
        b=b9COlqSqQwzg90jqFoEjVSHAszWiBRy1fgVA+LJVh9byNqGxDkPZvhzhLPinUx2bl9
         RJXgPIA6qyGC+nz1KekQXpTtU6BXQvrB++ARCQMcQXKBjE4ggiJrRB9shrl1pmz33Zv2
         k2z9O6q3syH+Eg32ksu+I/0E/eXgow7VNipMzL5xGr2oYPwLpbWDPP9CV1gOeceGZ171
         HJ0soqou4cnsk4Yv0RNzegMIXXCPYtqT2v1Dvfs56r2AH+xsdiNoOAyEBNXRe2Vh6KMN
         mTWl7w5k8HX46PWWDkyb/hHN7nZAYsc6lEByXA/xpXXrnXdzKU8f8erVDK2pYKTTlfAo
         W5IA==
X-Forwarded-Encrypted: i=1; AJvYcCX70ckhGow/FyDrbJJsfdhTqsQx1WDirR6rcIegEsjWFlADQQJsenELapiWM4BTWXTZ0P9A26znwDz/fpgKI4q1hTZiW1xUMZQr6/3L
X-Gm-Message-State: AOJu0Yxrvg0cffkwumDx874TLHrjqwYWOxTz3iw9i/gtckpWniilRNZa
	qKE/hrjDfmmY2azNwBj6d1b70wZ/8dLliP7j6DZTWcyV40nJwkiKpK9O2O+/Lvw=
X-Google-Smtp-Source: AGHT+IG2Zeq9oNJyiPlcCbmjVrggnEEKmpRbyKqqirUwfiP1gZHGkfOWRsCp9f7joPZY5K7/kT79XQ==
X-Received: by 2002:a17:906:f5a1:b0:a7a:8e0f:aaed with SMTP id a640c23a62f3a-a7dc50a4adamr184016666b.50.1722593975589;
        Fri, 02 Aug 2024 03:19:35 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c614ecsm81451866b.93.2024.08.02.03.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 03:19:35 -0700 (PDT)
Date: Fri, 2 Aug 2024 12:19:14 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: preffer_ofload param: was: Re: [PATCH printk v3 11/19] printk:
 nbcon: Rely on kthreads for normal operation
Message-ID: <ZqyyovKfUfI1t6Nz@pathway.suse.cz>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
 <20240722171939.3349410-12-john.ogness@linutronix.de>
 <ZqpAJgKeB0cIlTg7@pathway.suse.cz>
 <8734noz5jv.fsf@jogness.linutronix.de>
 <Zqush2SkFQpYxJ7q@pathway.suse.cz>
 <87bk2b8jsi.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bk2b8jsi.fsf@jogness.linutronix.de>

On Fri 2024-08-02 09:35:17, John Ogness wrote:
> On 2024-08-01, Petr Mladek <pmladek@suse.com> wrote:
> > I believe that the parameter "prefer_offload" adds more harm than good
> > because:
> >
> >    + It is a non-sense for nbcon consoles. They always prefer offload
> >      except for emergency and panic. But emergency and panic is
> >      handled transparently by nbcon_get_default_prio().
> >
> >    + It is confusing even for legacy consoles after introducing the
> >      kthread. There will be three types of offload:
> >
> > 	+ do console_lock()/unlock() in IRQ work
> > 	+ wake kthread
> > 	+ wake kthread in IRQ work
> 
> I think the confusion comes from my intention of the function. I wanted
> a caller to use it as:
> 
> "Tell me how to flush."

Yes, I understand it the same way.

> This requires input from the caller to know some information about what
> the caller's intentions are.

Does it really need it?
Where?

Please, show me two examples where the function is not able to make
the right decision by global variables?

I know about __wake_up_klogd(). And it is only because
printk_deferred() requires the offload via @level parameter
instead of the per-CPU @printk_context.

Is there any other?

Let me repeat:

    + The parameter makes a difference only when it is "true".
    + The parameter affects only legacy loop.

Let me check where the parameter is true in the current code:

 + nbcon_atomic_flush_pending_con[1548]
    + No effect! The function ignores legacy consoles.

 + nbcon_device_release[1848]
    + No effect! The function ignores legacy consoles.

 + resume_console[2706]
    + Wrong! The function should flush the legacy
	consoles directly by default. Otherwise, we would
	change the legacy behavior.

 + console_flush_all[3102]        printk_get_console_flush_type(&ft, true);
    + No effect! The function ignores legacy consoles.
    + Confusing! The function flushes legacy consoles directly!

  + console_start[3453]
    + Wrong! The function should flush the legacy
      consoles directly by default. Otherwise, we would
	change the legacy behavior.

  + legacy_kthread_should_wakeup[3484]
    + Not needed! The function is called only when
	force_legacy_kthread() == true.

  + __wake_up_klogd[4466]
    + This is the only location where it makes a difference.
    + We could simply check both legacy_direct && legacy_offload
      here.
    + Yes, it is a hack. But it is needed only because of
      printk_deferred() which is already hacky by using
      LOGLEVEL_SCHED.

  + console_try_replay_all[4851]
    + Wrong! It is called under console_lock() => the function will
	flush legacy consoles directly anyway.


> If I change the function so that a caller uses it as:
> 
> "Tell me what flush mechanisms are available to me."

No, this will make the code complicated again.

> Then the function does not need to know the caller's intentions. It only
> needs to know the caller's state, and that information is readily
> available via global/per-cpu variables.
>
> I will drop the @prefer_offload argument, simplifying the function to
> only provide a list of available flush options. The caller will then
> decide itself which option it wants to use. I believe this aligns with
> your intentions as well.

No. Please, keep the original meaning.

Best Regards,
Petr


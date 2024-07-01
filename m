Return-Path: <linux-kernel+bounces-236574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 358FB91E435
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5E2E1F2232B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306E816CD2A;
	Mon,  1 Jul 2024 15:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YWww/ma6"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0961E28F4
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 15:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719848019; cv=none; b=P983Upgl57vxZh+3CxQrN3Iuo9CCqvXpfixmSVqU6d9I/eAx8HlqluA7jyvaxBnO/srt2WcIJt9Rjp6hw2UdkUI96JeBm1ROcKYB2BnMxcBn0GnZ6A3sQ7HBk4P2X3EYHDq/GqhtN7hQj9zjBNqPz77FiPg68n5cA6ev8XH16E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719848019; c=relaxed/simple;
	bh=/rzIGcl+EawX5xeAIo09+kQuMmPfnSkoh236ozH+F0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRSqVGT8WxlwqvLVi0Kb1QfqLLg7fE7VbrGlF/+7TCcA3g+ATGAdwWtP52E+FB57NvUAPagBpBopTmOcXR26PmjIMu53PE7GfGDrKWJsODLvbQKIXgvF0TJ2SCurQj83EmkBKJ9wpHlSb6fjT4Zf/c8RK01n35FY+GC4wDbpRyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YWww/ma6; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ec61eeed8eso39079781fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 08:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719848014; x=1720452814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PSEsfiIduoMSYnAdmjobGnIBcHy7WCzxH+uV65l0j+0=;
        b=YWww/ma6z/jyrRB9SERsyUlLe5ucrNKZmSFekYicfB8/IH2nRPJm0K/UdsVbI5aJr/
         EVYn+2mFik1OJos6BRaRw08/lwCFaADcBdwjTdGDOhmhJH60qwi/fmehw5QX454VuwfU
         iIvmouUBTgHxbRxzQLenpONjt0A3fP11BEO/XQgjixqh267Q+TzARsXUq5QKLjw2g6B9
         /m0N4F9K41xxN+HxicgEnhRbBM4Clevz3DTRnrkJbhWGPaS0o43HHtG3yyRqWq0BoVU0
         5nXd5wwzA5G1llsOKBgRvgmyd3wsglQRb+K9TfjCw+ZT1FJB+KtqMmBMkAB/voV3QKSE
         Xn4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719848014; x=1720452814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PSEsfiIduoMSYnAdmjobGnIBcHy7WCzxH+uV65l0j+0=;
        b=gYhLjf1+fBFhBvnV27m5wO858YH1fOa09mqiC9zljhyJIOPTl27INbZ64pIx3EEzL3
         b6AGyvxNTAlQWMDgLgHyAjhZKQpjfgydPJZL3ExL0PlAEcc5Q7aWQlwrKKaXIYyuLOCP
         X07xpBEHxMSqKzd5giqRBJJrLmqLcmDiaE+vcrRF1A0iZhMoaFp61ci92qYd1+tdKEQr
         fugmkWmyLZcYsbyHdLQR7zdPsZIDspYxkIVxhoUTwuJHjHLzoibyU77K4PuSVs3+a8mR
         Y8XWqVajf7OTM8ASABB0ACtMOFRZh7E1qeduBoIMQQaq8vCCiGiYTW15eIlTQgN4QGfU
         6EqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJ5H/iCexhCrJJqKbu/LPGOGzO04HRQ/32Q/9xqMHzQfGKgPsr33UDBYpvNwp2JZrNLpQRF4cf2fINTX/heFD1zLfAyO2eFHGGSqqi
X-Gm-Message-State: AOJu0YxhKSN3yhnDqF0ISPtQvSnpHwgCCT13vB8L3YANxquO7bkoDpdC
	0vHYVTwwmV1//YRDrqpS+ZuYuqdLuyWKrk+SSJjTA7nL5etOe95M0okZhRdJ3kIZoYQnd2qbFpt
	a
X-Google-Smtp-Source: AGHT+IEUgHtWdqwGOHvvW6PWQm/0rPo7mTo0TqKawefzKpu+qv9w8VFcNWVj+sQbUQ5O0VQb7CfI2Q==
X-Received: by 2002:a2e:9509:0:b0:2ee:494c:c3d3 with SMTP id 38308e7fff4ca-2ee5e6bca4cmr38923251fa.43.1719848014117;
        Mon, 01 Jul 2024 08:33:34 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70803ecfc61sm6665390b3a.132.2024.07.01.08.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 08:33:33 -0700 (PDT)
Date: Mon, 1 Jul 2024 17:33:25 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 12/18] printk: Add kthread for all legacy
 consoles
Message-ID: <ZoLMRQhrwZnWMuj9@pathway.suse.cz>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <20240603232453.33992-13-john.ogness@linutronix.de>
 <Zn6iq3n2ggL138Gs@pathway.suse.cz>
 <87cyo1xnmw.fsf@jogness.linutronix.de>
 <Zn67hDCEHdgtYPv3@pathway.suse.cz>
 <877ce9xim6.fsf@jogness.linutronix.de>
 <874j9dxdr0.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874j9dxdr0.fsf@jogness.linutronix.de>

On Fri 2024-06-28 18:02:19, John Ogness wrote:
> Hi Petr,
> 
> Your comments are sending me into deep thought about this
> situation. Some more comments from me...
> 
> On 2024-06-28, John Ogness <john.ogness@linutronix.de> wrote:
> > On PREEMPT_RT, legacy consoles are not allowed to print from
> > non-preemptible contexts because they use spinlocks (rtmutexes).
> 
> The above statement is not true for legacy _boot_ consoles
> (earlycon/earlyprintk). These are lockless and are intended to execute
> from any context (except NMI due to semaphore limitations).
> 
> I hate boot consoles because they don't use the Linux driver model and
> rely fully on external synchronization. This has made the rework very
> difficult and is actually the core reason why our work was reverted back
> in 5.19-rc4. But for debugging early boot problems, they are quite
> useful.
>
> I have a new proposal. What if we allow boot consoles to always print in
> the caller context (for any preemption model)? I hacked a quick test
> together by providing console_flush_all() an extra argument for printing
> _only_ on boot consoles. Then in vprintk_emit(), I always do a
> boot-console-only-flush (under console_trylock) after storing the record
> in the ringbuffer.
> 
> For PREEMPT_RT this is horrible. But I am OK with mandating that RT
> scheduling cannot be guaranteed with boot consoles (just as it is
> currently mandated that RT scheduling cannot be guaranteed in emergency
> situations). Since the boot consoles are lockless, they pose no deadlock
> threat to RT.

Is this really the case for all boot consoles?

I had the feeling that some boot consoles actually used port->lock.
And for example, register_earlycon() is initializing this spin lock.

> This has some nice features:
> 
> - We get early debugging in all preemption models.

It would be great.

> - We get true synchronous printing when using boot consoles (which
>   should make peterz happy).

Well, Peter's mode is really special because it is done without
the console_lock(). Every printk() is flushing its own message
to the console. Parallel printk()'s are busy waiting for each other.

> - Boot consoles are then horrible enough that options such as
>   "keep_bootcon" will really be avoided unless debugging kernel issues.
> 
> >From the tests I have run so far, it looks good.
> 
> Looking to the future, I think this would also provide an excellent
> foundation for the "sync" console option I would like. For nbcon
> consoles with the "sync" option specified, it would work the same way,
> flushing boot consoles and nbcon consoles directly in vprintk_emit().

The sync mode would be nice.

Just to be sure. I guess that you are talking about a sync mode
using some trylock mechanism where the current owner would be
responsible for flushing everything.

Peter Zijlstra's mode (serialized printk()) is easy to implement
and might be needed in some situations. But I am not sure if
it would be good enough for most other users preferring the
current "synchronous" output.

Well, let's see what people request after they get some experience
with the first nbcon consoles and kthreads.

Best Regards,
Petr



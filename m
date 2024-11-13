Return-Path: <linux-kernel+bounces-408352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D82179C7DBD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 22:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F3AA1F2273A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 21:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E2D18B483;
	Wed, 13 Nov 2024 21:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Bu6njXqG"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4868442AA9
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 21:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731534042; cv=none; b=ZHUj/HzctVouLxfZflzLOXfUq/IEeJ38IiMyy9/rDwGezyRbWrx6SS86/5psZ2ZBL8igIh0KBK85kXT/uFLBs9FXc7x+O5VSRVYN3DYeksPPqJIHd+2pAYJ8F+Pp1SKWRrVsl8g8KtFWB2epJe3vbc7ZTWg5AQKgbKnyyFd4dRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731534042; c=relaxed/simple;
	bh=11EnlHUUv3uLhBrpDNzstXRim3XZtFaStaRr8cQUXB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIl6Cf+6Ub9M6RXQil62DL1YjAnhuv3P21DZbbRgeMwLsJcArbtMMQR3fqcIFngl4xlUUSmhmZInbwpo2lG+nX8w/MYsPltJDpXdU576XNns91z4aRgwfWZUiqx2QO9O52/sEPQ/GC58M2CCCTArA+6zzUraFqXrASWq1p6plxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=Bu6njXqG; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-83aba237c03so294356639f.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 13:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1731534040; x=1732138840; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GLBxlv2lBiZKzfbBsrMeo0WtydntNh9dJNkYuNv5Mas=;
        b=Bu6njXqGpLQvrtHRjr9oqiXQCx8cwE3uj8/NDl2v2URBOebf6DYtd1klOflBfX6/FG
         8ZclUlV1uvdXyY4HKrTGDlHn367hSx13u6lK0Fb9YKSMt+Tq+tTfCynn3qu+VOTprkc1
         LGH0KLvII/YFqRuanZ1l6/1ztUtRZrDD+MZwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731534040; x=1732138840;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GLBxlv2lBiZKzfbBsrMeo0WtydntNh9dJNkYuNv5Mas=;
        b=rM7EAADX2wD5gPzVfyRNth8xMcLdlkUpPREAalv6TQhzYnNz7hQmU8kP7igxcFYgxI
         mkfgf9bbh/8IB0pTN3Z+hVW67M9H3M8ahwVVQXmR14MZpO7/RIeCbpEqExzvFZWsyZ8i
         xGroDRzSh09odgkk0KkMYhh32a/XwW6kNrVCbLaF0a5UZBVsIdTtXhewKM+35xehJAGU
         X6cO5VqEFwEx3AV7xde5weyKBkGlDubANeLHy/TNde8XFPGyzww9aA42cwUzLrCCqgzL
         oqQkUmhzudXDa8YRtFJUMNSfMOJs7P1A4x9ym7jbp5M6u2ZFkAiBXZJOH8LLItrxbNMR
         MooQ==
X-Gm-Message-State: AOJu0YyI64VIcJHk6ODyuBHSh3r7SMG7iZkYmpIQdQ/WXwAxlhkLeacE
	3cmiV6Wu7XIOIor5jwGNpGv5Mv2n7nA6d3tkYycnEZnMyuvAHClppgBjpZ0/G/E=
X-Google-Smtp-Source: AGHT+IG3uZG3pD8bW4erRAyzik2MpIVc3v7EVYYcN4OeQvLDNG6omJS9QejzEvwD79lwb/KzFWp7+w==
X-Received: by 2002:a05:6602:15d4:b0:83a:b364:ff10 with SMTP id ca18e2360f4ac-83e4fada837mr622818939f.9.1731534040309;
        Wed, 13 Nov 2024 13:40:40 -0800 (PST)
Received: from localhost (222.121.121.34.bc.googleusercontent.com. [34.121.121.222])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de787f00besm3106773173.124.2024.11.13.13.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 13:40:39 -0800 (PST)
Date: Wed, 13 Nov 2024 21:40:39 +0000
From: Joel Fernandes <joel@joelfernandes.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC 1/3] tick-sched: Remove last_tick and calculate next tick
 from now
Message-ID: <20241113214039.GA2331600@google.com>
References: <20241108174839.1016424-1-joel@joelfernandes.org>
 <20241108174839.1016424-2-joel@joelfernandes.org>
 <ZzKWvislBnjV9kpf@pavilion.home>
 <20241112183330.GA2061573@google.com>
 <ZzSeMaV9676NiN1_@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZzSeMaV9676NiN1_@localhost.localdomain>

On Wed, Nov 13, 2024 at 01:40:17PM +0100, Frederic Weisbecker wrote:
> Le Tue, Nov 12, 2024 at 06:33:30PM +0000, Joel Fernandes a écrit :
> > On Tue, Nov 12, 2024 at 12:43:58AM +0100, Frederic Weisbecker wrote:
> > > > @@ -837,11 +837,9 @@ EXPORT_SYMBOL_GPL(get_cpu_iowait_time_us);
> > > >  
> > > >  static void tick_nohz_restart(struct tick_sched *ts, ktime_t now)
> > > >  {
> > > > +	/* Set the time to expire on the next tick and not some far away future. */
> > > >  	hrtimer_cancel(&ts->sched_timer);
> > > > -	hrtimer_set_expires(&ts->sched_timer, ts->last_tick);
> > > > -
> > > > -	/* Forward the time to expire in the future */
> > > > -	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
> > > > +	hrtimer_set_expires(&ts->sched_timer, DIV_ROUND_UP_ULL(now, TICK_NSEC) * TICK_NSEC);
> > > 
> > > We don't want to rewrite hrtimer_forward() but, after all, the current expiry is
> > > enough a relevant information.
> > 
> > Thanks, do you envision any way we can get past the sched_skew_tick issue
> > Thomas mentioned, if we still want to do something like this patch?
> 
> First, do we still want to do something like this patch? :-)

I am leaning to dropping it due to the skew issues mentioned which is a
gaping hole. And also the debug usecase you mentioned. At least I appreciate
why this mechanism exists now :-) Thank you both :-)

thanks,

 - Joel



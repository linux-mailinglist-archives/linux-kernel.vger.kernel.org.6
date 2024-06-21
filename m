Return-Path: <linux-kernel+bounces-224801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F5C9126FD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D31891C2202E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EF04688;
	Fri, 21 Jun 2024 13:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="icKZ+3Z5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A57107A6
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718977867; cv=none; b=S1wnd4x5Fbe4d5vupvdoMMZOaEe/OgnYEgqSJ7WM3KKA7GK9GRuvQ+luvbB4jzHel1ypktbWGJu28hkcZKyU2n/lZmUwR5Y4gwt5DzrpcDO5Hp8yJOjnQl41+/NdSPBTdd1LuSSEmXIMQ8VBa6zju0aApyb4L2XOdHew1qGMYTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718977867; c=relaxed/simple;
	bh=GkXBO7iYfH0fRObPP0KB+1zKiyXs1BaZ53Xwf+jzXlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B03ys7/hZOoAnaFH/XcRleWevLF2XLeUl5MxVMpycutZKZwiAS2vgsEcULCg5q5lFmxCrIAfoBgJfkvlwHwMS4gV9wQqNqfJW4aI/grBIpfqBOPcyHeZuNKXMKU/GrlnKrvXpShHFb26jpG8BvZfCK8Fz3ZXsWmosOSStkJKGWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=icKZ+3Z5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718977864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ix4gt7F+iMkMJ3zgzdJl56zdz642sRiEPFq0R57sQXs=;
	b=icKZ+3Z5vPvc5PMbmmYUQcJ1LiKJxePzerxv98xKKpdl26OFyxF6tDqA0VqrwborJaUjGE
	rJgXUnKKHKMj7cdDQzd1Rtclkqpg5WIyWQ7mQGwGwmZRedFBVzr/mrGAaBv3z9jUfSvbQ/
	y99kww9hQCuyYUFe+Yq53MgatpHauh4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-sD64Q4ljOmCPAtSSaIGjGA-1; Fri, 21 Jun 2024 09:51:02 -0400
X-MC-Unique: sD64Q4ljOmCPAtSSaIGjGA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4247047e74aso19074575e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 06:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718977861; x=1719582661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ix4gt7F+iMkMJ3zgzdJl56zdz642sRiEPFq0R57sQXs=;
        b=E1Bzu4oCLX3Iq1TAbt22LTAGlJANY6fjsDDGzBzdJuzKr/e5Mrk971db3vyE9/sAeb
         nwE3C0Hk6kdxcZLjQECStYtE+nlI9scg9AAf3U59y3aw/xWl1TByDXMW9WnNLOJzho54
         Xe88nqSGGx02gAfG7g6H1sa7/4j+D4sFOrLu+Yoq6T5bkfViH19OO/PMpFA7RBGlnS67
         l0y3o+5esZAG27p1JJOhacEcHM8oqAf5JZCZh/RtQM/iIJrIv6nclFjy7FPg2GYJs/ZQ
         sjk7XppTeC3k7qQylVaZeONYRyo+nC/GWIL8HUS1MRfqljCe3BJN3w4p/SvEem431/c1
         zEPg==
X-Forwarded-Encrypted: i=1; AJvYcCXZzlMwFh9ngN+2d45A76wzm62J3hG9QvYDoL07Qs1fuQJVqU/QlSGhyPRQSBNiAUO1xFWQdo4ZbwFNkyF0QQ9uye7FSxcVhIX+WkEG
X-Gm-Message-State: AOJu0Yxx1Wc4mZZbUdZIc9s1DmjVHRxTEU0MuVfbu66YhQhiAtcrAPwU
	7YVA8DpXzn3xM9ic1Hn+rWNJ+IvYSjH3VzZXpjmtMVizmwYw8sU+5ayDX97BDzKOVxSjbItFhDM
	G0jWUeVijnlSBYpfu4CF085PAar5WI3pqrzKwxBL6xdKI2HmwPU0p9sYkpWyOdA==
X-Received: by 2002:a05:600c:4853:b0:421:7bb1:eb9b with SMTP id 5b1f17b1804b1-42475296a7amr76553595e9.28.1718977861602;
        Fri, 21 Jun 2024 06:51:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS92bxMdqtDdu+lfCyEG8UvGo/6cN8YYEKQjjMePLVJ/maSC/rvayrWhtJnByxTbJllK9uyw==
X-Received: by 2002:a05:600c:4853:b0:421:7bb1:eb9b with SMTP id 5b1f17b1804b1-42475296a7amr76553255e9.28.1718977861166;
        Fri, 21 Jun 2024 06:51:01 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.3.168])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42471e65fb7sm78541245e9.1.2024.06.21.06.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 06:51:00 -0700 (PDT)
Date: Fri, 21 Jun 2024 15:50:58 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joel Fernandes <joel@joelfernandes.org>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Phil Auld <pauld@redhat.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Youssef Esmat <youssefesmat@google.com>
Subject: Re: [PATCH V7 0/9] SCHED_DEADLINE server infrastructure
Message-ID: <ZnWFQqQ_Yix9tS8D@jlelli-thinkpadt14gen4.remote.csb>
References: <cover.1716811043.git.bristot@kernel.org>
 <ZnWCBF9QkQmO01nw@jlelli-thinkpadt14gen4.remote.csb>
 <b14879eb-cbc9-4e53-b703-ab7b451b7687@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b14879eb-cbc9-4e53-b703-ab7b451b7687@kernel.org>

On 21/06/24 15:43, Daniel Bristot de Oliveira wrote:
> On 6/21/24 15:37, Juri Lelli wrote:
> > Hi Daniel,
> > 
> > On 27/05/24 14:06, Daniel Bristot de Oliveira wrote:
> >> This is v7 of Peter's SCHED_DEADLINE server infrastructure
> >> implementation [1].
> > 
> > I finally managed to give this a go and can report that it works great
> > for what I've seen. :)
> > 
> > So, please consider this reply a
> > 
> > Tested-by: Juri Lelli <juri.lelli@redhat.com>
> 
> Thanks!
> 
> >> SCHED_DEADLINE servers can help fixing starvation issues of low priority
> >> tasks (e.g., SCHED_OTHER) when higher priority tasks monopolize CPU
> >> cycles. Today we have RT Throttling; DEADLINE servers should be able to
> >> replace and improve that.
> > 
> > ...
> > 
> >> The problem with DL server only implementation is that FIFO tasks might
> >> suffer preemption from NORMAL even when spare CPU cycles are available.
> >> In fact, fair deadline server is enqueued right away when NORMAL tasks
> >> wake up and they are first scheduled by the server, thus potentially
> >> preempting a well behaving FIFO task. This is of course not ideal.
> >>
> >> We had discussions about it, and one of the possibilities would be
> >> using a different scheduling algorithm for this. But IMHO that is
> >> an overkill.
> >>
> >> Juri and I discussed this and though about delaying the server
> >> activation for the (period - runtime), thus enabling the server
> >> only if the fair scheduler is about to starve. We called it
> >> the defer server.
> >>
> >> The defer the server start to the (absolute deadline - runtime)
> >> point in time. This is achieved by starting the dl server throttled,
> >> with a next replenishing time set to activate the server at
> >> (absolute deadline - runtime).
> >>
> >> The server is enqueued with the runtime replenished. As the fair
> >> scheduler runs without boost, its runtime is consumed. If the
> >> fair server has its runtime before the runtime - deadline time,
> >> the a new period is set, and the timer armed for the new
> >> deadline.
> > 
> > I also wanted to pay particular attention to this part implementing the
> > deferred server, but failed to find enough focus time for now. I will
> > keep trying. One thing that I wondered though is if this change (and the
> > move towards this replacing current RT throttling) would call for a Doc
> > update. What do you think?
> 
> Yeah, am I planning a v8 for the next week. It has no code changes, just a rebase
> and the addition of documentation.
> 
> I am not mentioning the RT throttling in the documentation. Instead, I am treating
> this as a new feature on its own, which is inline with the comments over the code.
> 
> I will add an rv monitor to it, extending the documentation, but I will do it
> on another series... once we get this done.
> 
> Thoughts?

Works for me! Guess we can deal with the RT throttling references in the
future when that gets eventually pruned.



Return-Path: <linux-kernel+bounces-224776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEB39126C1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98E0028705F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5A48820;
	Fri, 21 Jun 2024 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iEzLr3ez"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074B95664
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718977039; cv=none; b=JkY7COA7nct2E7gZZRPWzga8fKMG6MUDS0P5byksXfJtPx8jBY00eH/BBzVOulaHGRwK5YaXk7X4JXgtsaJhqIb1UBq6npbKLGKLlGMQcRpddcNdTKSKlDNQwr2yY/oDY0B2gNxMGIzvG0JP8AbCvwg6BCRJm5H2CF+5Jj2Urww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718977039; c=relaxed/simple;
	bh=u67fxrtjHNIcxtx6UtG61+U8B1BQpvD34WX+prGCcuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRIL5Has89IXHMmptrgCFSo1Qo/tFGzi6k2AoAdzlnLJWv9fJZYOwsdUevjENNbBOWUNvn+amyTEkVyDHUiuNcJhrLix5ysx8BrNJcXS2Brno9TdhPpzAZUJqa/VZGCRVlx9AYOTkpPS23lVMIevfxd1sNl6QXOCHp3gz7iRMDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iEzLr3ez; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718977036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+cngwUAA0eoj98HdB95eEmD+8Yh6nB0921qVWIHr4DU=;
	b=iEzLr3ezBM8TZgoziGDCQOvlsRZub/zp/HWdhrEpaUvCwm2AydshF/gPevMef9AeTSaLKj
	UEYuf16ybsTjlQ9dpTcQfc+zHXRytLEHogJcLTmVW863T3tocTUNhKcOe+d1HJinzVf+KF
	aZZe0oUkJXUYky2N7jtzNtI43nKR9Aw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-HiaNANqXM86gdaPGQdAEcg-1; Fri, 21 Jun 2024 09:37:13 -0400
X-MC-Unique: HiaNANqXM86gdaPGQdAEcg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-421805fadadso15958095e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 06:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718977032; x=1719581832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cngwUAA0eoj98HdB95eEmD+8Yh6nB0921qVWIHr4DU=;
        b=BtZfEO3gsIqIiSSBI1zr7l4zMLCUOfdo4YpC/pWV8OaEtYGRuK/3qsGNXMlnrXgstI
         yHiaujACk+ghZl38CjmhhGKK7oB9OGDRz99mT2mMTFYtIXKU3BxnwHrxFBdV0Pgu354P
         sWib1rDvnewKrQwuQS2BLeiK5zpcOL1NF/pOHC8sGZ6TWQbgFrNwGwcoi6+6/4e08BTB
         9YGmdq5tmqK/S6Y6ol0bBKy0caqRB1bOhSPGDGJwRI42PE0qA5e2WVrHGmBIKxvjWZpt
         OuLQiS4CH++GqrK12uTgpEJdk5BSlIGibZNYgcapkrOtsZ/OJgkDKBNKHKXC0v2oi9Ak
         y96Q==
X-Forwarded-Encrypted: i=1; AJvYcCX6/OF0CRiB3NIDCIW+y9EdHtG4WwQFrG49gkJ0Uc8DHWgPtiNo/F5WKw1313z2jV0UZge8hzuG9r6lhMGSJF3M1+RdxvC99YoxTfbi
X-Gm-Message-State: AOJu0Yw+TUHyikkrMeB8ba3XkthpYJdn2t5SphlZG3kQ5Aua0Djg3U6R
	nu3jtEVpya2EaDxKmUk/eppdt5uB1+HkBRWWwKXU+FYS7XkdcoXFjAhTI6mM1mOGLTi7+tKHYrE
	lfn9O/uQ7LBxH6KafoMXPsjzhhwIBLIKYvWjX76OEnqX2vjkm28YJDJKeCKutiA==
X-Received: by 2002:a05:600c:6a85:b0:424:6cbb:b276 with SMTP id 5b1f17b1804b1-4247517520emr64582395e9.11.1718977032435;
        Fri, 21 Jun 2024 06:37:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4oPMlw9RvYzNATm50+n1y3bjSh0agnm0Kf9+qIHwc7umuz2zzadC9afdRQFc0b6Z79V7Aaw==
X-Received: by 2002:a05:600c:6a85:b0:424:6cbb:b276 with SMTP id 5b1f17b1804b1-4247517520emr64582235e9.11.1718977032051;
        Fri, 21 Jun 2024 06:37:12 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.3.168])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424817aa340sm27901685e9.19.2024.06.21.06.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 06:37:11 -0700 (PDT)
Date: Fri, 21 Jun 2024 15:37:08 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <ZnWCBF9QkQmO01nw@jlelli-thinkpadt14gen4.remote.csb>
References: <cover.1716811043.git.bristot@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1716811043.git.bristot@kernel.org>

Hi Daniel,

On 27/05/24 14:06, Daniel Bristot de Oliveira wrote:
> This is v7 of Peter's SCHED_DEADLINE server infrastructure
> implementation [1].

I finally managed to give this a go and can report that it works great
for what I've seen. :)

So, please consider this reply a

Tested-by: Juri Lelli <juri.lelli@redhat.com>

> SCHED_DEADLINE servers can help fixing starvation issues of low priority
> tasks (e.g., SCHED_OTHER) when higher priority tasks monopolize CPU
> cycles. Today we have RT Throttling; DEADLINE servers should be able to
> replace and improve that.

...

> The problem with DL server only implementation is that FIFO tasks might
> suffer preemption from NORMAL even when spare CPU cycles are available.
> In fact, fair deadline server is enqueued right away when NORMAL tasks
> wake up and they are first scheduled by the server, thus potentially
> preempting a well behaving FIFO task. This is of course not ideal.
> 
> We had discussions about it, and one of the possibilities would be
> using a different scheduling algorithm for this. But IMHO that is
> an overkill.
> 
> Juri and I discussed this and though about delaying the server
> activation for the (period - runtime), thus enabling the server
> only if the fair scheduler is about to starve. We called it
> the defer server.
> 
> The defer the server start to the (absolute deadline - runtime)
> point in time. This is achieved by starting the dl server throttled,
> with a next replenishing time set to activate the server at
> (absolute deadline - runtime).
> 
> The server is enqueued with the runtime replenished. As the fair
> scheduler runs without boost, its runtime is consumed. If the
> fair server has its runtime before the runtime - deadline time,
> the a new period is set, and the timer armed for the new
> deadline.

I also wanted to pay particular attention to this part implementing the
deferred server, but failed to find enough focus time for now. I will
keep trying. One thing that I wondered though is if this change (and the
move towards this replacing current RT throttling) would call for a Doc
update. What do you think?

Thanks!
Juri



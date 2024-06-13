Return-Path: <linux-kernel+bounces-213146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B35906D05
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A95DB25B70
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249CF14A4F7;
	Thu, 13 Jun 2024 11:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="vGD8G6TL"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924551465BA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 11:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279508; cv=none; b=BhlI8rQa0AVzUf/XpupwP1tN9p2E1f+eOiUMgSlHbseFk79dyycNHUIDZ+HPaxG5uxcW00j5idg/PKvHwVZCemGgfTHtaaLZbwc6ah/+4aQt6VXmSS3g/Fk4A91llb031g/iC69H0YWJ4EaJpxbdFqlZ2XqXAOScLHFyb6eT/CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279508; c=relaxed/simple;
	bh=w2vdeE6HyK1zqMKz4ydvXzIOS4kYoy98j5IM9DRJLYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmDYRUQqtArIfqng3VTTQFFaLLhqG062jC4nwioOegqWpkD1UnIQbVxbPdE1SkljOGqh+CZg8KeqwRmwHlnAr9iRd6VCqf2WazFSf6eg3qxijsnelGsI7MdmI/MRw0Bdjd5KMNIBmuPFgVmkmGNVBX7JAxVI4wmlq+1J1tPP5Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=vGD8G6TL; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52bc121fb1eso1307500e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 04:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1718279505; x=1718884305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G8v2PHEc7ReSFsN3sKt9G9rx4uLCxEdCe0Zu0J7gE0g=;
        b=vGD8G6TLdNHdHdgl6OafKkZEcV1Vk09xc6O3GpNI1QOMlW11YFEr4B8KJ6ccWWffxQ
         7BFzp82RuZXG4Np49kCqlyeTHKaA4ZmlnXz7SuGeGWWkLkOF87sUjvqYtSsmIxghczcc
         BNmoLX9Ut65I5/ehnL/WTycwRZnGwBMna2tRa7ioDVVHf8FSAzGeCOMqc3wiqn4P1q83
         qBflhEeuqVjDhjk0qRDrAUyqcyM0oiSnQDkGd4p+putyR+woYsbAJt10KmdtIvOWxswv
         vBH89QnacYW0euJqb4VZyJlvjXFTUV8642Fwgg/tSauecsnzMfuCrHfgHjZSnWPLOZdg
         aCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718279505; x=1718884305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8v2PHEc7ReSFsN3sKt9G9rx4uLCxEdCe0Zu0J7gE0g=;
        b=ZoS1lfMkp16zugvdj5g9EpXsaGEv5ZeTyQKMsVcu+mdBScLEFUn4a7ogxMkBssuQl5
         DpYQRSe9kx03BWDlGjutxEwE5U3EpYSXM9Dg2cxf1zYg3HCuJmVQFSk/zgR5dNiZ7zBH
         k6iDg2LLmBuJfhYr9ARMsQjBaQagHIv0raP9nM0aPP/JHSpQQOqqFGttfw6dD78YqaCY
         y8Z5V6qR6t6iCSWK6fOxOLvmEJkbxi0fDVD+V/3siTQRqv4d71FtSaHIzhB/LBK3cqXq
         HKTtfUwyHYum+n8XScpGAMJYeTh8KtZGv5v9Fm4OvcG0aXGbh8dxoZ3vR+0lVOTLbQYN
         qfIw==
X-Forwarded-Encrypted: i=1; AJvYcCXkS08DZXfCnDngSGoRlF5yJHSggvuK+byLv3sIJ6Laa2i24JUxtrC7zHbOfGu5/escgo2kMLSE6xi2jOMfgmWy+m1a4NuzwYdoOY4K
X-Gm-Message-State: AOJu0Yxgn9PgjL6f613F7/QJ61/IMbQR/kLhBOf7kj3XwZC0baBJ2/PM
	B9gJxVPh+G2l66CxVrRi6rbfuoWtH+pwIKplBYa6mu8DJ7qL3dD/B/FHnEvE+3k=
X-Google-Smtp-Source: AGHT+IElojoAfrs8n0pkfZzmTeuOaz+6NcooThdQKgGUe+znNmXNMT8cPYX3NudFuuz+WEL6CBAanw==
X-Received: by 2002:a05:6512:3d87:b0:52c:a5cc:19d6 with SMTP id 2adb3069b0e04-52ca5cc1c34mr27988e87.22.1718279504561;
        Thu, 13 Jun 2024 04:51:44 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f641a64bsm21649075e9.46.2024.06.13.04.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:51:44 -0700 (PDT)
Date: Thu, 13 Jun 2024 12:51:42 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Peter Zijlstra <peterz@infradead.org>
Cc: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joel@joelfernandes.org>, kernel-team@android.com
Subject: Re: [PATCH] RFC: sched: Rework task_sched_runtime to avoid calling
 update_rq_clock
Message-ID: <20240613115142.kxrmlf3btmwjcprg@airbuntu>
References: <20240613015837.4132703-1-jstultz@google.com>
 <20240613100441.GC17707@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240613100441.GC17707@noisy.programming.kicks-ass.net>

On 06/13/24 12:04, Peter Zijlstra wrote:

> ---
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0935f9d4bb7b..d4b87539d72a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -724,7 +724,6 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
>  
>  	rq->prev_irq_time += irq_delta;
>  	delta -= irq_delta;
> -	psi_account_irqtime(rq->curr, irq_delta);
>  	delayacct_irq(rq->curr, irq_delta);
>  #endif
>  #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
> @@ -5459,6 +5458,8 @@ void sched_tick(void)
>  
>  	sched_clock_tick();
>  
> +	psi_account_irqtime(curr, &rq->psi_irq_time);
> +

If wakeup preemption causes a context switch, wouldn't we lose this
information then? I *think* active migration might cause this information to be
lost too.

pick_next_task() might be a better place to do the accounting?

>  	rq_lock(rq, &rf);
>  
>  	update_rq_clock(rq);


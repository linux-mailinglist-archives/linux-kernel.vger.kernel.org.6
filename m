Return-Path: <linux-kernel+bounces-401684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B759C1DE7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F26ADB22F30
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE991F4703;
	Fri,  8 Nov 2024 13:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LCL+Ckpf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C2A1F12FD
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731072354; cv=none; b=qHOFmpPRfLZtxPl42vxtj+uv5a0pKv7NJfsEYj9+lf1wUGyrpalC6H3qfGCQjWC0CySCvxQwgsi5ApRWExJyjdY5VIzanWf1nkM04/SY33RI6WmbgmxzIzJVVm72rsIn77yDhDnbX0BI8+iimcy4gDiew9KiRDwU9LuSg4bZEfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731072354; c=relaxed/simple;
	bh=CJeow9ZcQJJhdCKpB3+Mkbji2j5+kaH4mwRqvJx+8fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDlpSK1JDIhRxUWeEC4PlkVUwaiCw2T32D9J1I8BTbRsfh/EfsCu0naUwaZAuz82RT1dBblSL4CmeFZaMjGo+5lJR9a2Wv8AbA3qUsTW5QKx0XLdu4qE4xXj3MadQa0HSH7s9zscjrh+EkFDnGTjsCYj86uokXF1V/SveImOw7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LCL+Ckpf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731072350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bam85A2nCybT8RxhKMSsCHLDHACUYIyDkIBb/Kj36d8=;
	b=LCL+CkpfvdFqVomGlgvztP+4zGsaRkytoKLMM23JNUIjV2Ua9iYG5mkonVJkaewhb1Te69
	zJV5fzVljQIbo6N12AY0vp5iuqVPSYMnFSKyN3CMvd2aptbjgOnbTIttCFQH0aqAPglWbL
	ASEFZwFASyQk5ziSafdMtB5DragUFtw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-A4Q0fyWGN7WNpZAv-Y3NXw-1; Fri, 08 Nov 2024 08:25:49 -0500
X-MC-Unique: A4Q0fyWGN7WNpZAv-Y3NXw-1
X-Mimecast-MFC-AGG-ID: A4Q0fyWGN7WNpZAv-Y3NXw
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d59ad50f3so1067140f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 05:25:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731072348; x=1731677148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bam85A2nCybT8RxhKMSsCHLDHACUYIyDkIBb/Kj36d8=;
        b=YY+nMwJi8Bw0gmnB2/JO8UGk8cz641bOobIrA3x/Qn+/ckpM4jBGWrnxzBHPabq5yd
         2lp7xKv9ZLXL8+UFlW+Ik/ydEHso1QqlMXh2hk0xkHtZ3QlJljbt//xmBmOLlhENQzoi
         l2bt3F+vLCATPeRI3GeB9fwB0YTnhhhIK/S5bxdRCoYTL+1HtkCdqDQ7fo9HXZPbR6O8
         dzp/c3AyLOpkoS9Zh2BXofqcWf59PvPAwNqxRV6wAmtsMM7J9tBG64RUuUffpcLm/2P5
         xzu5R9hjwhTHljF2H42B1xSxd2diN5ulWuM4fCK1v0pLpF8a7xtLe14LdJik0lI6w5d7
         dNRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqrL7PVPz0hTXHUPn8QLqiFN5KwzumPHwvR2tqHIBStNzsWjxwU5FcyMNe8Bs3/ke2i4mNxED3LihAHII=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpf18k5sS74MJon5WhUpNGZBjMR2CwlAyFJTDL0j8+0PddNNts
	Yd6/eUP9WRx4ZCVQasAGZrPypQIdvgCOUJf1jLt8xB03PteaRHqJpKHboSMJszJ/35HGcHJ9v+T
	FwnHkAwsNcEhLddDWueqjxsgVPA8bjuLRjXkdSA3eVI5sHAGsqs73xlJGfBGubQ==
X-Received: by 2002:a5d:59a2:0:b0:37d:476e:f110 with SMTP id ffacd0b85a97d-381f186fbcbmr2374975f8f.34.1731072348431;
        Fri, 08 Nov 2024 05:25:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6NUlqEvPIsGnToE0cS1OXv5wjMyH2txD/IOjdRVw+0E1/d22EZ6UVE5NMJFLVpoqWUgBQ3Q==
X-Received: by 2002:a5d:59a2:0:b0:37d:476e:f110 with SMTP id ffacd0b85a97d-381f186fbcbmr2374947f8f.34.1731072347948;
        Fri, 08 Nov 2024 05:25:47 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.142.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b054b3fesm66007565e9.17.2024.11.08.05.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 05:25:46 -0800 (PST)
Date: Fri, 8 Nov 2024 14:25:44 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH] sched/deadline: Skip overflow check if 0 capacity
Message-ID: <Zy4RWJPH9jxew_7G@jlelli-thinkpadt14gen4.remote.csb>
References: <20241108042924.520458-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108042924.520458-1-longman@redhat.com>

On 07/11/24 23:29, Waiman Long wrote:
> By properly setting up a 1-cpu sched domain (partition) with no
> task, it was found that offlining that particular CPU failed because
> dl_bw_check_overflow() in cpuset_cpu_inactive() returned -EBUSY. This
> is due to the fact that dl_bw_capacity() return 0 as the sched domain
> has no active CPU causing a false positive in the overflow check.
> 
> Fix this corner case by skipping the __dl_overflow() check in
> dl_bw_manage() when the returned capacity is 0.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/sched/deadline.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index be1b917dc8ce..0195f350d6d3 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -3479,7 +3479,13 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
>  	} else {
>  		unsigned long cap = dl_bw_capacity(cpu);
>  
> -		overflow = __dl_overflow(dl_b, cap, 0, dl_bw);
> +		/*
> +		 * In the unlikely case of 0 capacity (e.g. a sched domain
> +		 * with no active CPUs), skip the overflow check as it will
> +		 * always return a false positive.
> +		 */
> +		if (likely(cap))
> +			overflow = __dl_overflow(dl_b, cap, 0, dl_bw);

The remaining total_bw that make this check fail should be the one
relative to the dl_server on the cpu that is going offline. Wonder if we
shouldn't rather clean that up (remove dl_server contribution) before we
get to this point during an hotplug operation. Need to think about it a
little more.

Thanks,
Juri



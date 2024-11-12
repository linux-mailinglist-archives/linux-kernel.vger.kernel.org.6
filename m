Return-Path: <linux-kernel+bounces-405334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 360D59C502A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E88A8B2B9C5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 07:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58AD20D4F4;
	Tue, 12 Nov 2024 07:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SMYWd2ye"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311571A707D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 07:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731397887; cv=none; b=FGl4g5fcKEKKOCHgGoGvVmivKZnH5uRCeD2gqr9A+AVdKS1yZjDh2+DaprTqp3CZM5W7tGkc1vBDIpo6riGrML3XIoKN/HzS9q2h9UzNY7QY6qXEIfcq4EZGJcYGbX43zCivCckOvzGJlyHPinMQnD3oa6VUniOFc5IlWSqTYnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731397887; c=relaxed/simple;
	bh=HaJdHKi6mZXAsln1vjNMhnlHXzzZ0aVFtC2ergqGuT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gblZkgqWjmYHDsFS2Q37ZVhdoN2sXURKWh4u2c/Aa1TTZfMa/NBoqDyjRWKr3N1NA42N8Npjz+dO3zfW12aHkz8kvHRe5Z/WgciY82FrXWSz3l3CysQSAMMVWp4DB4SAXTZ/cSdkAD4fWcIUImlIoarclJWDvdo2VCtySXwGDSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SMYWd2ye; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731397884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+MhF2cF4ZIcitCQaW+UVcrp6W859H7LsgRV6cQU5rV0=;
	b=SMYWd2yeQzYH/4VVgStlOll8fhyYPOsTGlLfa0q+ykM4s93fJT7er1fBPtohZ0APgP7vXM
	TqsIdYuaiYmJDPz+AfoniMF6nfVmYIdtTqcSE1Ek4o6PgV/HY5PzFwZ3tJPDHGJEMTi8dj
	QWw6HgQZXAn6mO4rvH/ba3+TH1zsHoc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-BMTJsIpNM0iClegW5aEjJQ-1; Tue, 12 Nov 2024 02:51:22 -0500
X-MC-Unique: BMTJsIpNM0iClegW5aEjJQ-1
X-Mimecast-MFC-AGG-ID: BMTJsIpNM0iClegW5aEjJQ
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-460f57b35dbso98614131cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 23:51:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731397882; x=1732002682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+MhF2cF4ZIcitCQaW+UVcrp6W859H7LsgRV6cQU5rV0=;
        b=XrnEYNThGKagODjXhkjhw+zSieAFB01kucHeD4/72IBpziGjyuKUXKafIK52hmUphZ
         F2Ej/GTusImMmfykkorIXAd5zXb7pfsuRpfCCoyTIeiPOkcnj5AWZqwAPGHm0G3jH6Gl
         wc+z258unkzoitNTXAQEG/JejlhCBn/tqQYsBK+CozX7yAGFE+mFMPk00O1xj59zFTsh
         n/J8Lcx3/kx4/76RYykhhJPoc9Ek+qix0Cy70yjjghIlGAqhDs4XEaXogHqYwg6+XdHx
         DGqgogPyE7CpuUJRN78oiltG18EKCXcbAVuLj7HcAZI5h0E2EjIg2Ih6NfKAVz6K+uUt
         Exrw==
X-Gm-Message-State: AOJu0YxV8KfXIbQvopMrKnXhrdu9H3nkN97Kq0rJqilCXMg1bRRYHIFY
	veVMamEO8MaLVQ4YuPl2XsODbt7mX77VXl8qb59eVPeqenGiBk8cVVg1FMSqroXbut3FH1nvjGJ
	4//aYWhGUGGHjMyzPSldKsMgf57xbBmXQs6gPzVxFK01IkFrr8PHa+MKGVAotHQ==
X-Received: by 2002:a05:6214:2b98:b0:6ce:26f0:ea41 with SMTP id 6a1803df08f44-6d39e1b16d1mr199162146d6.31.1731397882444;
        Mon, 11 Nov 2024 23:51:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGX3nw9xm9MptNnmpAXevyVdy5onGVAPpNeIa8QHS0FaXcZsRl0dFVzShlqoBnzIMosERn+ww==
X-Received: by 2002:a05:6214:2b98:b0:6ce:26f0:ea41 with SMTP id 6a1803df08f44-6d39e1b16d1mr199161976d6.31.1731397882147;
        Mon, 11 Nov 2024 23:51:22 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-4-194.as13285.net. [80.47.4.194])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961ecc7asm68243156d6.43.2024.11.11.23.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 23:51:21 -0800 (PST)
Date: Tue, 12 Nov 2024 07:51:17 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Aashish Sharma <shraash@google.com>,
	Vineeth Pillai <vineeth@bitbyteword.org>
Subject: Re: [PATCH] sched/deadline: Do not start hrtick if its disabled for
 DL
Message-ID: <ZzMI9dYjWKqNtQzv@jlelli-thinkpadt14gen4.remote.csb>
References: <20241112012240.1887813-1-joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112012240.1887813-1-joel@joelfernandes.org>

Hi Joel,

On 12/11/24 01:22, Joel Fernandes (Google) wrote:
> Fix an issue where high-resolution timers causes aggressive preemptions,
> leading to increased idle times in CFS tasks (which are inside the DL
> server). The problem was traced to improper usage of hrtick_enabled(),
> which could start high-resolution ticks unexpectedly causing repeated
> preemptions.
> 
> The fix replaces this call with hrtick_enabled_dl(), aligning it with
> scheduler feature checks.
> 
> Reported-by: Aashish Sharma <shraash@google.com>
> Reported-by: Vineeth Pillai <vineeth@bitbyteword.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/sched/deadline.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index b216e6deeac4..d46502b9ce58 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2121,7 +2121,7 @@ static struct task_struct *pick_next_task_dl(struct rq *rq)
>  	if (!p->dl_server)
>  		set_next_task_dl(rq, p, true);
>  
> -	if (hrtick_enabled(rq))
> +	if (hrtick_enabled_dl(rq))
>  		start_hrtick_dl(rq, &p->dl);
>  
>  	return p;
> -- 

I'm not sure I'm seeing this in current code. We have two users in
deadline.c and they both use hrtick_enabled_dl (after a recent fix by
Phil).

Best,
Juri



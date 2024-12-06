Return-Path: <linux-kernel+bounces-434898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B429E6C75
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BBB3165152
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7681F8F13;
	Fri,  6 Dec 2024 10:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S27lXZAG"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EB5145B07
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 10:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733481814; cv=none; b=cVkFh7xiRQeqfd72LbKd1sUzuB88Z1cDT6QwNc6m7EoCdMb4Azaxb4rXW3UMtDwgxYUmicFp7q6VpRsiySs8VBvyJst2WlT4ua51809WggzDOFUYTKifzXO/+NiGtIL1QamgTupKrLSJzjTxY4drsxhg7PqqoYx90YaTT9jZv50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733481814; c=relaxed/simple;
	bh=5uNKrRrhzP/OIA71f5P48+zZBGvPFSZXjZ+UxTehcWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBYwtYiTbg1vzQb0ctWvQu2tFhCSRyT/8YvUXpQM5bgvoJ/+sCf+6pAK7xVDIiprS0/SmCdmSC9b1XiKbFjexwK9CP1b5LepL9ZKmAV5XUiHGCe8kQU9XNMG1Eg34T/SqnNW7J6NCSlCokkx//7MEIRmxTTpNtQQSN5BFv7gkVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S27lXZAG; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434a0fd9778so18992065e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 02:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733481811; x=1734086611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ypldDvXdf/MRPfsrxzrKXantEZsEaAlzytl7UEr/BhM=;
        b=S27lXZAGVCH28jv+uZPOBwMU58azRk4LP3JJvrUrhR4NZirfTbvLqWdO8AvO8eSjmT
         vOGdGfHc8NuQpSt9HQYMWNFWNZaXUkeosDKOZwW5Y+zMohhM8602aCc87X/EP055nMeR
         3GovvTq8Br/5IDXggPK1Q+KbTXMnRGb/h4EPj9cfuhAdZkvc7+M9yLP51umQtu6piNJq
         mxqQbo1bZ+4xxBC1x1DdHzTEXIHGeaR4ShuX/tTnSfq+O9THyZyxRNLLy36AkiwwwwZ1
         Dc3eMLJ3WxxZs8HPDUYjczC2iS+6VQrOvRPjyfCeziNoT40mhSP8h7cgQIu8U9vAlVfP
         psTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733481811; x=1734086611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypldDvXdf/MRPfsrxzrKXantEZsEaAlzytl7UEr/BhM=;
        b=m2/llXUjZLle17cUgrxAzl1okuw2I7M0f7bbC0riRhqD7d1x+nYmbzARTGv0x201tf
         RCFvxJk1WGQVWA8zrN8JZh/s4bgScHzSeKOgVFUEpF7KC1t26Ykh7mMefA132t+jINdk
         xLVTvfqfKdZ3pJZbwbb6qmWhPQwtkTsV7+OiHAurKzVoxiAkMkYe8jqKIScmW0sIGn+2
         xqZY9HS8psmOAuh/xnnxGuiYU7We4wqZsHiTShkmu0LvY73HYF2l0RJw23JjOKwWE4yh
         h6POWOU5taJpJg2De0Reg/+rcxblimMZi8Ig1DcKuPrlQjn2KlvB91arJ/lHoXR9vMGu
         G9kA==
X-Forwarded-Encrypted: i=1; AJvYcCW9No9A4F5eGwOTeaOqHkXYDJPS3jedZ37tu7oPQj5s4oiulEEJRRsQm/h/LXmmp2ZpNkEZ9EpF7FWkOAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5exQd4T3b5DX2IIL0NQ716+K3FTWN2ZyLsOAUcPwLg5WkhUk9
	2vEpyFb7ydDT2fep2ugJu8jD8I5n2xwU5b+cZofWSnWH5G3C6jvV1M6wwGtnc80=
X-Gm-Gg: ASbGncvpM0R8nqNv8oSkISp5WpqtJJRRqIDQ0FDEUR1njBw3BjOLRB+8uuQLhrD2JuA
	iwxQCe+9uac3KrfSL352wj915KscEBUZvKJH3J5EL8ZFWj9y0QWZ/5jIeo73/mr1MCVOg7U2lWQ
	RIqr9v4y9wwiE5ZXMzRkCs9QR64qx4suhDlSPhAjvMNn9vr4Q37ntsXzbiYhUaG0X1Rv6Fo1gba
	BGFRL34H8RRggyCcVPYd/xp35A1sCsf0+21bBexejd8ApVIgQgqrmI=
X-Google-Smtp-Source: AGHT+IEyt0rS6n4oEiP757TGu6ABO+e8NCWcZluPWhmNM/nCS4kfFoLzgZs162So8GRoMBfFBIF4jg==
X-Received: by 2002:a05:600c:1906:b0:434:a39b:5e44 with SMTP id 5b1f17b1804b1-434ddeb8c98mr24193255e9.17.1733481811085;
        Fri, 06 Dec 2024 02:43:31 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d43a0df4sm72091175e9.1.2024.12.06.02.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 02:43:30 -0800 (PST)
Date: Fri, 6 Dec 2024 13:43:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Phil Auld <pauld@redhat.com>, Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Aashish Sharma <shraash@google.com>,
	Shin Kawamura <kawasin@google.com>,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 2/2] sched/deadline: Correctly account for allocated
 bandwidth during hotplug
Message-ID: <cb188000-f0e1-4b0a-9b5a-d725b754c353@stanley.mountain>
References: <20241114142810.794657-1-juri.lelli@redhat.com>
 <20241114142810.794657-3-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114142810.794657-3-juri.lelli@redhat.com>

On Thu, Nov 14, 2024 at 02:28:10PM +0000, Juri Lelli wrote:
>  static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
>  {
> -	unsigned long flags;
> +	unsigned long flags, cap;
>  	struct dl_bw *dl_b;
>  	bool overflow = 0;
> +	u64 fair_server_bw = 0;
        ^^^^^^^^^^^^^^^^^^
This is a u64.

>  
>  	rcu_read_lock_sched();
>  	dl_b = dl_bw_of(cpu);
>  	raw_spin_lock_irqsave(&dl_b->lock, flags);
>  
> -	if (req == dl_bw_req_free) {
> +	cap = dl_bw_capacity(cpu);
> +	switch (req) {
> +	case dl_bw_req_free:
>  		__dl_sub(dl_b, dl_bw, dl_bw_cpus(cpu));
> -	} else {
> -		unsigned long cap = dl_bw_capacity(cpu);
> -
> +		break;
> +	case dl_bw_req_alloc:
>  		overflow = __dl_overflow(dl_b, cap, 0, dl_bw);
>  
> -		if (req == dl_bw_req_alloc && !overflow) {
> +		if (!overflow) {
>  			/*
>  			 * We reserve space in the destination
>  			 * root_domain, as we can't fail after this point.
> @@ -3501,6 +3503,34 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
>  			 */
>  			__dl_add(dl_b, dl_bw, dl_bw_cpus(cpu));
>  		}
> +		break;
> +	case dl_bw_req_deactivate:
> +		/*
> +		 * cpu is going offline and NORMAL tasks will be moved away
> +		 * from it. We can thus discount dl_server bandwidth
> +		 * contribution as it won't need to be servicing tasks after
> +		 * the cpu is off.
> +		 */
> +		if (cpu_rq(cpu)->fair_server.dl_server)
> +			fair_server_bw = cpu_rq(cpu)->fair_server.dl_bw;
> +
> +		/*
> +		 * Not much to check if no DEADLINE bandwidth is present.
> +		 * dl_servers we can discount, as tasks will be moved out the
> +		 * offlined CPUs anyway.
> +		 */
> +		if (dl_b->total_bw - fair_server_bw > 0) {
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Since this subtraction is unsigned the condition is equivalent to:

        if (dl_b->total_bw != fair_server_bw)

but it feels like maybe it was intended to be:

        if (dl_b->total_bw > fair_server_bw) {

regards,
dan carpenter

> +			/*
> +			 * Leaving at least one CPU for DEADLINE tasks seems a
> +			 * wise thing to do.
> +			 */
> +			if (dl_bw_cpus(cpu))
> +				overflow = __dl_overflow(dl_b, cap, fair_server_bw, 0);
> +			else
> +				overflow = 1;
> +		}
> +
> +		break;
>  	}



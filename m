Return-Path: <linux-kernel+bounces-264850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0601393E930
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 22:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF7E01F216DD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 20:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899F66F30B;
	Sun, 28 Jul 2024 20:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="3fgcpNj7"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392CB1D69E
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 20:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722197434; cv=none; b=Jnyz5d8yghyZlghi8qJ1TXau308T2ue76mB/7kx3TSK5UdgST8l0LYKvo4fqmdN+48oDpL635/M/F7jE3ohcopSQ/WCSGDkpA8c4OCwK4gkYFft52TkDnwu/81r7LB71/DudjZGz50+eup2QH7q6JRQCIpzT4ui2VEr9zVL2Kgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722197434; c=relaxed/simple;
	bh=ASH+5wnB2ZyX0ZB0CNcZclI32VcSijWENo4wcOCHWSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfZjB3r0xn/dHmcW6c2Z/q1zLu3KhqwJEy/znIV0JTNPqbRr2+PzMbb+4HcUVs8fL1FTtJdqheSHfdMSvfinh932XF++ERZ2KlnojaLAtHt4OkmvJHfZzR0Nwq25zlqjh7gsuNDB+HSXsCuxH+2cWlPgcXos3pKc/Xxl/nq4SUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=3fgcpNj7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42812945633so11397565e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 13:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1722197430; x=1722802230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ywqHHuu/v6N/ZQ1YK9vJ8qVa4DNZUBfm2lt6pIZIisk=;
        b=3fgcpNj7B83/pB2EpgA2DcYKrlnvQoFiE9OEbetq2StG8wKhPj5169g8JjM2msoIiU
         HlEKvgP1ZKvFAwRYN1FZDfzFlofcJdpqlEhStcCntFWnlsg9t8ccHHnDg93ymazNaH33
         jZ9XbnxCXczVYV1aTuGwkUeL1OxS+F4wLXutvMB6lPFESCtN6kNqL4srmJhzt2JSYQQq
         fuuqbLAJjhdgxGRa35EDmoHMLEXaI2owx7ZpR+qLSXX5fNq5rb5s+XcYh78fxZDWpuYl
         dp5K2uyp/wBzxNM+dHfMGsTk3G7UmtIlPDLkmis7tc6l16CmT2OryscqlsrroG4EbENc
         5UQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722197430; x=1722802230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywqHHuu/v6N/ZQ1YK9vJ8qVa4DNZUBfm2lt6pIZIisk=;
        b=NJGnknnI5SfzVFeB+zdrCbp/uRi3OKNGksDwq1CAlN6bcFdQPaYWFmB3Et3xop3pos
         USoZSq4DB7hPfI2gC8AzhJQt4Ic2F78lXJ2FG4JLysciud554BdvNrxi9BIU/9O//GOk
         8dVelAfWl0IoMy63FSUHgrj56lzHJ3HjDO1Qb85e/jmNCiEoJhCLg2ny2l1Db6U5nFpp
         J4hldWwrMXR1rtF3I9bwN4skFCBCLJGMZ2CBNA109JvtQBc5gidD4HxOelTIjzgyCw3X
         kCl1MdCnqF+Ybqy2iSEV4NSo+OWjQcJus7GpOYNnipv6r2qEW+Dcr/W1opEvUdM/SkhF
         NbeA==
X-Forwarded-Encrypted: i=1; AJvYcCWZsdE7EU/3hnYrCQoomflOZZixHHxkEiijdeqo6HlAXIBt0xZT6ohC9lP48WDsqGjC3Yra8p9kO151oYiqEoQxR9qtTXoK9Pelwo6Q
X-Gm-Message-State: AOJu0YyEvJLv5E3NIxPanlduFUqkKkc/V2EBUGUKspAQqZcXrDxQp/vk
	FwD35zTk2WUq25HkmgoRpJ/DqNXBq38TxNa5TzJF2htSXtjZaY85Avdb0nA+0N0=
X-Google-Smtp-Source: AGHT+IHM02rSqcwf4Y6zpknorSISMQZE3tj8sGyVyEQSEoNplTnbo+lRAccA+9FdEJ0f6hxP7irt2A==
X-Received: by 2002:a05:600c:1c8f:b0:426:5983:ed0a with SMTP id 5b1f17b1804b1-42811dcd2b4mr31185445e9.30.1722197430449;
        Sun, 28 Jul 2024 13:10:30 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428057b7faesm152102085e9.48.2024.07.28.13.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 13:10:30 -0700 (PDT)
Date: Sun, 28 Jul 2024 21:10:28 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Chen Yu <yu.c.chen@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Hongyan Xia <hongyan.xia2@arm.com>,
	Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/pelt: Use rq_clock_task() for hw_pressure
Message-ID: <20240728201028.oylcxv3rwuihqugq@airbuntu>
References: <20240725150820.376623-1-yu.c.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240725150820.376623-1-yu.c.chen@intel.com>

On 07/25/24 23:08, Chen Yu wrote:
> commit 97450eb90965 ("sched/pelt: Remove shift of thermal clock")
> removed the decay_shift for hw_pressure. This commit uses the
> sched_clock_task() in sched_tick() while it replaces the
> sched_clock_task() with rq_clock_pelt() in __update_blocked_others().
> This could bring inconsistence. One possible scenario I can think of
> is in ___update_load_sum():
> 
> u64 delta = now - sa->last_update_time
> 
> 'now' could be calculated by rq_clock_pelt() from
> __update_blocked_others(), and last_update_time was calculated by
> rq_clock_task() previously from sched_tick(). Usually the former
> chases after the latter, it cause a very large 'delta' and brings
> unexpected behavior.
> 
> Fixes: 97450eb90965 ("sched/pelt: Remove shift of thermal clock")
> Reviewed-by: Hongyan Xia <hongyan.xia2@arm.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v1->v2:
>   Added Hongyan's Reviewed-by tag.
>   Removed the Reported-by/Closes tags because they are not related
>   to this fix.(Hongyan Xia)
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 9057584ec06d..cfd4755954fd 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9362,7 +9362,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
>  
>  	decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
>  		  update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
> -		  update_hw_load_avg(now, rq, hw_pressure) |
> +		  update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure) |

NIT:

Wouldn't it be better to remove 'now' and call rq_clock_task() inside
update_hw_load_avg()? Adding a comment on why we should use this not clock_pelt
would be helpful too. hw_pressure doesn't care about invariance.

ie:

update_hw_load_avg(rq, hw_pressure)
{
}

LGTM anyway. I think this is called most of the time from idle when clock_pelt
is synced with clock_task. So the impact is low, I believe.

>  		  update_irq_load_avg(rq, 0);
>  
>  	if (others_have_blocked(rq))
> -- 
> 2.25.1
> 


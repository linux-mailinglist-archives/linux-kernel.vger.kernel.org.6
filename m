Return-Path: <linux-kernel+bounces-275928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF28948C13
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B3631F24798
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9E41BDA8B;
	Tue,  6 Aug 2024 09:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mddu0fXR"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EED75464E
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722936031; cv=none; b=hteoAuMBNrc3s9Z13VlHv/7nbAiSn0mzgnVmKsjSzRTyjBloPFtoK74cB+BVm+D3kT8hYgFRY0Zg67PrRdWi36VMoD+DUVgvXlUoM1baUATGecHElWMdy6pOV6iR5eDdlOgGuKHzGgfrcMsrbD7GsP+QDk6FSLcaiBbxyx7JhQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722936031; c=relaxed/simple;
	bh=ISPgEXXCu0qT2RGAPlWuMBPnTpS6Yh5PJn3+SpojmXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cufhlyv3ig8iYS8oXN9xiyROwihyARdNpPSXe4f+N11Uki6Uwu1ObOeLDuVjgi9QN419R6KLUoSJ2aLyA2CuFCpr0BKW6hWdT8IcJqsznvGw7dP0Nxk7N56/zGd2F2FUOL5FyDFdjAqJr+uyZIFV2O88v5/mKaKktPejJ62FZKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mddu0fXR; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ff67158052so2754315ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 02:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722936029; x=1723540829; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AZ7fcFnWrxPTS8oiJ/ebyzDce2RrYmsfxQaaI3oC9XA=;
        b=mddu0fXRLY8YM2dtxqpbDuUN/V+d3fLIw1FI0cmRCk2NEpeBkpFehDUjBWMQGn3jc1
         84fGEDln+UVPfJPkzPWVsCuSH6jA0hX63frA/8gjpRQnrydC9KvWsu+ONCHIQBIHPAOd
         5ugyMkMNoLeRsyD/u0zqo5rEvfWCHNUYlg8RvDcvzyYLy5yw10lAXidYPRcbla7bRZCp
         DxxmQzydrqr2FtzK19rQH/5PjHYBpgTlaq2pU/f7bQ03MCsXLyp4Dg2oL8PO7gVyqo0b
         Ny5Y0W9p6/kKk4QhdYexv+hkn25V9AsJCvAx4PqR4d0Sx6lcRhFrLO5GAK2ZaKFYirPa
         0iig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722936029; x=1723540829;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AZ7fcFnWrxPTS8oiJ/ebyzDce2RrYmsfxQaaI3oC9XA=;
        b=iR0cp+kqlp659hEKzda+qVAR0W4esX+qVfaJW3krQZaF5siD0vPqf+yBx4mPylZQsR
         55Q+eiqrjhsvIUovxe7+RdYuazAV6DjYOM1H/LLVBWXlMcR0gLCuecifFmM4iEtf+9Et
         ouE3mk4mcGLVv8poEYG3UCWiaU+JhFLVWoJKCACqkm1/FdOto2nIqoHOA+R+B6/gHqVH
         MaTREuVokeLnTgaUDhpva7hlWGgvNWQzRnLQYnt5Dz6ejSU+wfdzrVzvAwxuLsa9IaNP
         fww4WG7yc0DWQdakmUpYE/whSRk6BznzgGQByKPk66L0THQ6gZwphWTahlF1fhNFQFUv
         gQOg==
X-Forwarded-Encrypted: i=1; AJvYcCWAeFmD1himS9Hf+fmsOG+8QB+RRrB0q/hqnSxNBQJA7gMlQGXxoIeUjl8rxU372p385M007Kz67zb5f5tdKaFpRrDwJkIJyVAAQTE7
X-Gm-Message-State: AOJu0YyYsr8EbzBw6P15tqgn8w2/3BinoDEJEsRJEY4KWHtmcVI1sGP8
	L29W50aU4DzMMoOKByCiMHZCO9H6HVIrDK74gqaS+RurkZ1akvKCozZ3nuCinNk5eb3OfvdpfS7
	QRVJh7L5PUm+h/e6Axay/JhRgjNIYtkfTH0knSg==
X-Google-Smtp-Source: AGHT+IGodm+Q8Vyni8fw/4aNeQBxnnBIDYBlcUdQLl6q40GM4YSvCuqItQpwKLhat7M5+OVPNMZ8o8/7Bu6wPXcLowc=
X-Received: by 2002:a17:90b:1004:b0:2c8:6eea:7ad8 with SMTP id
 98e67ed59e1d1-2cff9517a3amr13160601a91.26.1722936028600; Tue, 06 Aug 2024
 02:20:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806015034.27137-1-yu.c.chen@intel.com>
In-Reply-To: <20240806015034.27137-1-yu.c.chen@intel.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 6 Aug 2024 11:20:16 +0200
Message-ID: <CAKfTPtAasQTzHUeW8jF8ECfsoy5JMpKxUd3kYoFJNWcegJ5rKQ@mail.gmail.com>
Subject: Re: [PATCH v4] sched/pelt: Use rq_clock_task() for hw_pressure
To: Chen Yu <yu.c.chen@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Qais Yousef <qyousef@layalina.io>, Hongyan Xia <hongyan.xia2@arm.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Chen Yu <yu.chen.surf@gmail.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Aug 2024 at 03:54, Chen Yu <yu.c.chen@intel.com> wrote:
>
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

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>


> ---
> v3->v4:
>   Revert to v2 to keep the clock outside of pelt functions.
>   (Vincent Guittot)
>   Added comments for hw_pressure within __update_blocked_others().
>   (Qais Yousef)
> v2>v3:
>   call rq_clock_task() inside update_hw_load_avg() to avoid any
>   inconsistence in the future. (Qais Yousef)
>   Added comments around update_hw_load_avg(). (Qais Yousef)
> v1->v2:
>   Added Hongyan's Reviewed-by tag.
>   Removed the Reported-by/Closes tags because they are not related
>   to this fix.(Hongyan Xia)
> ---
>  kernel/sched/fair.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 9057584ec06d..5176db6ae13d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9360,9 +9360,10 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
>
>         hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
>
> +       /* hw_pressure doesn't care about invariance */
>         decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
>                   update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
> -                 update_hw_load_avg(now, rq, hw_pressure) |
> +                 update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure) |
>                   update_irq_load_avg(rq, 0);
>
>         if (others_have_blocked(rq))
> --
> 2.25.1
>


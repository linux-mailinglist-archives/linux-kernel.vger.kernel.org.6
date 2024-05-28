Return-Path: <linux-kernel+bounces-193221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3028D2897
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 01:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDBB0287BD7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 23:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E4213E8B8;
	Tue, 28 May 2024 23:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J9W+MGRl"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A280017C6A
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 23:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716937849; cv=none; b=Z+Xxs4do+vcdhbvd2opUP28wthSDl1kzrl0aAg2Em43SpyCFIP/AjL4dbDgXDTdmgkMWZilHxC55bvaINg5cAClOI5eHxMFeMj1aV08zX/JQwDJlPBVrIHJ1Zi/EhjM6MU9PEVV80Xdqy8Bo9AwWnyQJ9MFFakpEp2kF2gTtuAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716937849; c=relaxed/simple;
	bh=DDnCwgBkD0IE3CqaY1N4KkL1lU4fNU2djZKuJ+qHwKQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iPVC0r5oTwwCoQ2TWG1v+9vIgmw51vo6de/rjrIx2fx1HHc1ic7Wl6S9QJweeu79qeReZgPDrdKF5uLdDWoer4Bu69v58rbAhorftajPi1Tks5+1mDMdibfgssSchn9/7mo88vnKJMIOT0jm6swfMjEpndmY0FL5I2QnftAvHjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J9W+MGRl; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ee5f3123d8so31055ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 16:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716937847; x=1717542647; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2C26c1X2kl1AKGaQVpyxNVw+ZiIYNnX/HN9VLb5bOBQ=;
        b=J9W+MGRl+qN6JUO0/D2sKdhn8lqP1JSpPj58SV30goXP2LzqgCQ0vK1yurwIsN2ZS9
         Aa+pNGS1e2df6HiDI3whc2+SuLd05mvTtGPUyFJieQvD2ptdK5nGkRAM5JYpEwniBT84
         NVd0eJTEDtLOTKBl33HTjkc/n2JZZefZNK5G5/Ki0hM/kDh86DXpGoV7OSIEkXZcR3PJ
         73GRdNeuyx2LVZ/+Fwv5bToYAt/WuKTan55OVJywqR6P4gtrpUyuGYtsNdBoZC3F9YDC
         WbeIkq+8Qj6uen1QRXACkoGQS/qbKCGlvVvbq8hkrCxdtIpkmPy/9qMYiI9LFNDUZGFs
         Rqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716937847; x=1717542647;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2C26c1X2kl1AKGaQVpyxNVw+ZiIYNnX/HN9VLb5bOBQ=;
        b=iuqRVx0bWMAWf08H/ffixikYPb/jq1kD7JI6kiX7aQRFo/Q5F6kB/ISGX8jDieDSC7
         e4QuVjSiMKjJuzJ6Cyr6DVQ83fTmfTOqVEZIDYfMmguctFhwpvMXA6h13HvIVm4/GNGl
         caRavZ0nCK6Rev0E138je2yL2FiMZEpeZZkGaVKdNgmlP54u3YZhPRoYRMPXEwL/Colh
         pBczFXPnftP0RPwjnYYX7UIkE0uEVUbeM8/zUVDJgn2JzgSmH7oad3bavXv/ikYPNBOk
         taSVX93JuvW4lcMubq6KEY9CWi+/M7Z8NMp3X6WG14+hvq35oQgtiT9cv8CiZ8mV/sYo
         wSbw==
X-Forwarded-Encrypted: i=1; AJvYcCXxwkdDeuvmGLViFH1NoiFy7be3P+rJLWOZtRa99Kkp2zg6SUJJwlOhOfyy1gWw1OUIrkP6uZL0ma97Eju7wW2/qLUZxI1SuxXRhjY3
X-Gm-Message-State: AOJu0YwxarKDEQUOiavkRSLI5ywN/tA6/RvtEOpofPL09+XdB/lkOTBw
	C74zL1E34N4J0WaAhUVq0F//XYwwFl86Z1zMvMdhPZlJI6t+mls38al0IAoJjA==
X-Google-Smtp-Source: AGHT+IHQrlSaK6GY7797tcH+pjhLaHIs7cxy1cCldOu6qEd70Fb5h1fxJcvr7O9/E3+4kWjpfdWFNw==
X-Received: by 2002:a17:902:8493:b0:1f3:50cc:43a2 with SMTP id d9443c01a7336-1f4e95e11c5mr759225ad.24.1716937846630;
        Tue, 28 May 2024 16:10:46 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-202-176-14.hsd1.ca.comcast.net. [73.202.176.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c7cc01esm85899035ad.112.2024.05.28.16.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 16:10:46 -0700 (PDT)
From: Benjamin Segall <bsegall@google.com>
To: Cheng Yu <serein.chengyu@huawei.com>
Cc: <mingo@redhat.com>,  <peterz@infradead.org>,  <juri.lelli@redhat.com>,
  <vincent.guittot@linaro.org>,  <dietmar.eggemann@arm.com>,
  <rostedt@goodmis.org>,  <mgorman@suse.de>,  <bristot@redhat.com>,
  <vschneid@redhat.com>,  <changhuaixin@linux.alibaba.com>,
  <shanpeic@linux.alibaba.com>,  <dtcccc@linux.alibaba.com>,
  <tj@kernel.org>,  <linux-kernel@vger.kernel.org>,
  <zhangqiao22@huawei.com>,  <judy.chenhui@huawei.com>,
  <yusongping@huawei.com>,  <zhaowenhui8@huawei.com>,
  <liaoqixin@huawei.com>
Subject: Re: [PATCH 2/2] sched/fair: set burst to zero when set max to cpu.max
In-Reply-To: <20240522031007.643498-3-serein.chengyu@huawei.com> (Cheng Yu's
	message of "Wed, 22 May 2024 11:10:07 +0800")
References: <20240522031007.643498-1-serein.chengyu@huawei.com>
	<20240522031007.643498-3-serein.chengyu@huawei.com>
Date: Tue, 28 May 2024 16:10:42 -0700
Message-ID: <xm268qzt4jnx.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Cheng Yu <serein.chengyu@huawei.com> writes:

> In the cgroup v2 cpu subsystem, assuming we have a cgroup named 'test',
> and we set cpu.max and cpu.max.burst:
>     # echo 1000000 > /sys/fs/cgroup/test/cpu.max
>     # echo 1000000 > /sys/fs/cgroup/test/cpu.max.burst
>
> Next we remove the restriction on cfs bandwidth:
>     # echo max > /sys/fs/cgroup/test/cpu.max
>     # cat /sys/fs/cgroup/test/cpu.max
>     max 100000
>     # cat /sys/fs/cgroup/test/cpu.max.burst
>     1000000
>
> Now we expect that the value of burst should be 0. When the burst is 0,
> it means that the restriction on burst is cancelled.
>
> Fixes: f4183717b370 ("sched/fair: Introduce the burstable CFS controller")
> Reported-by: Qixin Liao <liaoqixin@huawei.com>
> Signed-off-by: Cheng Yu <serein.chengyu@huawei.com>

Yeah, makes sense. My general assumption would be to put these in one
patch, but if there's a convention to separate v1 and v2 that I've
missed, I have no opinion.

Reviewed-by: Ben Segall <bsegall@google.com>

> ---
>  kernel/sched/core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index e9198e30bb74..982d357b3983 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -11414,8 +11414,11 @@ static ssize_t cpu_max_write(struct kernfs_open_file *of,
>  	int ret;
>  
>  	ret = cpu_period_quota_parse(buf, &period, &quota);
> -	if (!ret)
> +	if (!ret) {
> +		if (quota == RUNTIME_INF)
> +			burst = 0;
>  		ret = tg_set_cfs_bandwidth(tg, period, quota, burst);
> +	}
>  	return ret ?: nbytes;
>  }
>  #endif


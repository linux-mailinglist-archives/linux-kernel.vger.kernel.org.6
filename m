Return-Path: <linux-kernel+bounces-321404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 322F9971A0E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E46B128667D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5151B9B44;
	Mon,  9 Sep 2024 12:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UN9fiBYY"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA4F1B86F8
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 12:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725886473; cv=none; b=R2CamVblFL4ts4gdpf0BBr80sZx2ZwS7rvB5vGaJiyfqYSHbaZZ42XyahDQ+szQQsnmx/r3xyx5Dh4Hlx2XGkF9jglrWK15AeIkmqLlBYuWVE90ESZUE5gqOk0DIjLsud3FIRYyNTThkxgJij9bz9XLksuDMuEkAodeA4sHW40Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725886473; c=relaxed/simple;
	bh=g+dDfh1e4lJIZhw+stAZjlWy8LOETSfuEG3DTMZ4EgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uxTWVNX0MuZILeD3MBMUF/hKJZr5bJOUBZa+hIjlHA5QuIaQ8nmeBpxe6I0mHQ+X9EpDjH0zOwpWpeXphXolp9QhpHG+tqVEvY8tZvBB79N8IoHQ4HsaSgzfC9IsRp47Ql/pf1dfBgw4kIPYtmJX8GL/pUHpanpATUaIBG0IIKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UN9fiBYY; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2daaa9706a9so3305855a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 05:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725886472; x=1726491272; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g+dDfh1e4lJIZhw+stAZjlWy8LOETSfuEG3DTMZ4EgM=;
        b=UN9fiBYYekt99Tfiv++OOKKSTIc307HcNJM0/X7l2z4ft+NXv//v9BMu7tcW5qsBGn
         27SDRglXHp58x92phHHiZuDPKLXeCMl+B6xWGbzWRhO6uRXkO1GbAYPRMg2VKnZX44Lh
         6I/NndjuTbNQj39npOLk7i0FtfnPG6dVmI9UBYK8CqgRiiGL9STL8ssMDL1MrDybu8go
         x4Mhl6utoaA+SugT1ER1yAgzSAx6Vd7ASj8qpExtMmPpnN+NFrFnpUkII+ILIeMa1Pbr
         S7MH3qmG3P48UOwSwk95hR9N8PUT7x7aKItyj8IG5HnZ3zSHJvFtyYkNnf8kA51DgAQd
         liFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725886472; x=1726491272;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g+dDfh1e4lJIZhw+stAZjlWy8LOETSfuEG3DTMZ4EgM=;
        b=kGs2F/SHyLtG3bwqo/Uye2rR8bxQT1VpjFR/lplvQU7vkUbXXq7LaOiRxP2gKyQZE/
         Rk7hR9lCSzl+yCooBpMfmnUHuEf5RnwNhcjSgZYx3yFn/62Y7ebspdcBsINYS55D9IsO
         sOYF9XCIiSZ4bkk+4t+ULQmkKtb6qyLy7dERIABaYypdWbd7oJNhRL3P1P/m4CUJLupU
         NERH8pnh+Pnilz6/ZhG5xWKdKCQpDxzGp/2dgyfQ/20G+InM/jRnQyxIBOGi+LTMvAPh
         dWKuvpdWwUAM1biCeSXUmUUIRKtxuJVkRATJxC1N2+k3WR6bg6GFUkrrI2/+B/310mYo
         Qx1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYsdb52wmwIxXCcbWek5jZJg9YSeWCpDzgHrKlLiT31uct1ihol6feBufCNONNQ6zKyP9sxfwDXF9DjMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR1vyOb+3tuYTyHn3G/Ed5hriEHPalUp9EcBlR14SdbSQM1KCk
	mb9oHchkZ48LG6jBYLEN6CFJxj1pG67mkRUBCTOBFGs4hoIKXIbsCA4ap5FugYU/8h/PU5i3Ssd
	FkCKBg9exWEbwjhU9DeDH4gVm7MKlWUpaAkAvmA==
X-Google-Smtp-Source: AGHT+IEwU2qP8xdhpZ7DZJRF1+VHxgwARiuNI3HaFyoB5KtSEj7l0uCW8YVeTduJVdozkmjd9tJGCrWTCFIzH0AzveU=
X-Received: by 2002:a17:90a:887:b0:2db:2939:d9c0 with SMTP id
 98e67ed59e1d1-2db2939da3emr3100300a91.2.1725886471293; Mon, 09 Sep 2024
 05:54:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
 <20240830130309.2141697-6-vincent.guittot@linaro.org> <73756bc3-5de0-4559-99a3-704db78433f5@arm.com>
In-Reply-To: <73756bc3-5de0-4559-99a3-704db78433f5@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 9 Sep 2024 14:54:20 +0200
Message-ID: <CAKfTPtC44YmmNz58ihcX8nzQhZ+5p_K6FgK1KNOedE7v+PRpUw@mail.gmail.com>
Subject: Re: [RFC PATCH 5/5] sched/fair: Add push task callback for EAS
To: Christian Loehle <christian.loehle@arm.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, lukasz.luba@arm.com, 
	rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, qyousef@layalina.io, 
	hongyan.xia2@arm.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Sept 2024 at 11:59, Christian Loehle <christian.loehle@arm.com> wrote:
>
> On 8/30/24 14:03, Vincent Guittot wrote:
> > EAS is based on wakeup events to efficiently place tasks on the system, but
> > there are cases where a task will not have wakeup events anymore or at a
> > far too low pace. For such situation, we can take advantage of the task
> > being put back in the enqueued list to check if it should be migrated on
> > another CPU. When the task is the only one running on the CPU, the tick
> > will check it the task is stuck on this CPU and should migrate on another
> > one.
> >
> > Wake up events remain the main way to migrate tasks but we now detect
> > situation where a task is stuck on a CPU by checking that its utilization
> > is larger than the max available compute capacity (max cpu capacity or
> > uclamp max setting)
>
> Let me think out loud about this and feel free to object:
> If there's other tasks on the rq we don't have that problem, if it is the

You might have been confused by the term utilization in the commit
message which includes both util_avg and runnable_avg of the task the
the max cpu capacity which is the get_actual_cpu_capacity

> only one running it's utilization should be 1024, misfit should take care
> of the upmigration on the way up.
> If the task utilization is 1024 it needs to be alone on the rq, why would
> another CPU be more efficient in that case (which presumably is an idle
> CPU of the same PD)?
> Or is this patch just for UCLAMP_MAX < 1024 cases altogether?

For a task alone stuck on a CPU, it's for the uclamp_max case although
this might also replace the misfit task behavior in the future.

